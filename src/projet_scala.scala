/**
 * Created by Administrator on 12/12/2016.
 */

import org.apache.spark.SparkContext
import org.apache.spark.SparkConf

object projet_scala {
  val file ="H:\\Documents\\DS\\projet_python\\"
  val conf:SparkConf  = new SparkConf()
  conf.setAppName("appli test").setMaster("local[*]")
  val sc:SparkContext= new  SparkContext(conf)

}
