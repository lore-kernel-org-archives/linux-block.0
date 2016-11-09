Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Alana Alexander-Rutledge <Alana.Alexander-Rutledge@microsemi.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Higher block layer latency in kernel v4.8-r6 vs. v4.4.16 for NVMe
Date: Wed, 9 Nov 2016 01:43:55 +0000
Message-ID: <33507ACF7FF43A4FBE532BA768AFA4243AF0BECC@avsrvexchmbx1.microsemi.net>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Stephen Bates <stephen.bates@microsemi.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Hi,

I have been profiling the performance of the NVMe and SAS IO stacks on Linux.  I used blktrace and blkparse to collect block layer trace points and a custom analysis script on the trace points to average out the latencies of each trace point interval of each IO.

I started with Linux kernel v4.4.16 but then switched to v4.8-r6.  One thing that stood out is that for measurements at queue depth = 1, the average Q2D latency was quite a bit higher in the NVMe path with the newer version of the kernel.

The Q, G, I, and D below refer to blktrace/blkparse trace points (queued, get request, inserted, and issued).

Queue Depth = 1       
Interval   Average - v4.4.16 (us) Average - v4.8-rc6 (us)
Q2G         0.212                             0.573
G2I           0.944                             1.507
I2D           0.435                             0.837
Q2D         1.592                             2.917

For other queue depths, Q2D was similar for both versions of the kernel.

Queue Depth     Average Q2D - v4.4.16 (us)  Average Q2D - v4.8-rc6 (us)
2                          1.893                                        1.736
4                          1.289                                        1.38
8                          1.223                                        1.162
16                        1.14                                          1.178
32                        1.007                                        1.425
64                        0.964                                        0.978
128                      0.915                                        0.941

I did not see this as a problem with the 12G SAS SSD that I measured.

Queue Depth = 1
Interval   Average - v4.4.16 (us) Average - v4.8-rc6 (us)
Q2G        0.264                              0.301           
G2I          0.917                              0.864
I2D          0.432                              0.397
Q2D        1.613                              1.561

Is this a known change or do you know what the reason for this is?

My data flows were 4KB random reads, 4KB aligned, generated with fio/libaio.  I am running IOs against a 4G file on an ext4 file system.  The above measurements are the averaged over 1 million IOs.

I am using a Ubuntu 16.04.1

I am running on a Supermicro server with an Intel Xeon CPU E5-2690 v3 @ 2.6 GHz, 12 cores.  Hyperthreading is enabled and SpeedStep is disabled.

My NVMe drive is an Intel SSD P3700 Series, 400 GB.

Thanks,

Alana

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
