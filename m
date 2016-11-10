Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4542 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932614AbcKJSxh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 13:53:37 -0500
Date: Thu, 10 Nov 2016 14:04:48 -0500
From: Keith Busch <keith.busch@intel.com>
To: Alana Alexander-Rutledge <Alana.Alexander-Rutledge@microsemi.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Stephen Bates <stephen.bates@microsemi.com>
Subject: Re: Higher block layer latency in kernel v4.8-r6 vs. v4.4.16 for NVMe
Message-ID: <20161110190447.GD4929@localhost.localdomain>
References: <33507ACF7FF43A4FBE532BA768AFA4243AF0BECC@avsrvexchmbx1.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <33507ACF7FF43A4FBE532BA768AFA4243AF0BECC@avsrvexchmbx1.microsemi.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 09, 2016 at 01:43:55AM +0000, Alana Alexander-Rutledge wrote:
> Hi,
> 
> I have been profiling the performance of the NVMe and SAS IO stacks on Linux.  I used blktrace and blkparse to collect block layer trace points and a custom analysis script on the trace points to average out the latencies of each trace point interval of each IO.
> 
> I started with Linux kernel v4.4.16 but then switched to v4.8-r6.  One thing that stood out is that for measurements at queue depth = 1, the average Q2D latency was quite a bit higher in the NVMe path with the newer version of the kernel.
> 
> The Q, G, I, and D below refer to blktrace/blkparse trace points (queued, get request, inserted, and issued).
> 
> Queue Depth = 1       
> Interval   Average - v4.4.16 (us) Average - v4.8-rc6 (us)
> Q2G         0.212                             0.573
> G2I           0.944                             1.507
> I2D           0.435                             0.837
> Q2D         1.592                             2.917
> 
> For other queue depths, Q2D was similar for both versions of the kernel.
> 
> Queue Depth     Average Q2D - v4.4.16 (us)  Average Q2D - v4.8-rc6 (us)
> 2                          1.893                                        1.736
> 4                          1.289                                        1.38
> 8                          1.223                                        1.162
> 16                        1.14                                          1.178
> 32                        1.007                                        1.425
> 64                        0.964                                        0.978
> 128                      0.915                                        0.941
> 
> I did not see this as a problem with the 12G SAS SSD that I measured.
> 
> Queue Depth = 1
> Interval   Average - v4.4.16 (us) Average - v4.8-rc6 (us)
> Q2G        0.264                              0.301           
> G2I          0.917                              0.864
> I2D          0.432                              0.397
> Q2D        1.613                              1.561
> 
> Is this a known change or do you know what the reason for this is?

Are you using blk-mq for the 12G SAS? I assume not since most of these
intervals would have executed through the same code path and shouldn't
show a difference from to the underlying driver.

My guess for at least part of the additional latency to D/issued, the nvme
driver in 4.1 used to call blk_mq_start_request (marks the "issued" trace
point) before it constructed the nvme command. 4.8 calls it after.

Have you noticed a difference in over-all latency?
