Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com ([104.47.41.80]:59665
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756047AbcKJWOe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2016 17:14:34 -0500
From: Alana Alexander-Rutledge <Alana.Alexander-Rutledge@microsemi.com>
To: Keith Busch <keith.busch@intel.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Stephen Bates" <stephen.bates@microsemi.com>
Subject: RE: Higher block layer latency in kernel v4.8-r6 vs. v4.4.16 for
 NVMe
Date: Thu, 10 Nov 2016 22:14:26 +0000
Message-ID: <33507ACF7FF43A4FBE532BA768AFA4243AF3D6E1@avsrvexchmbx1.microsemi.net>
References: <33507ACF7FF43A4FBE532BA768AFA4243AF0BECC@avsrvexchmbx1.microsemi.net>
 <20161110190447.GD4929@localhost.localdomain>
In-Reply-To: <20161110190447.GD4929@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks for the info.  Yes, maybe that change in ordering could explain the =
increased Q2D latency then.

I am actually using blk-mq for the 12G SAS.  The latencies appear to have b=
een pretty similar in v4.4.16 but not in v4.8-rc6.  It does seem odd that t=
hey are different in v4.8-rc6.  I've noticed that the average submission la=
tencies between the SAS and NVMe are also around 3 or so us higher for NVMe=
 at queue depth=3D1.  I thought those paths would also be the same so that =
doesn't really make sense to me either.

The overall latency does look like it increased for v4.8-rc6 as well, mainl=
y for queue depth <=3D 4.  In the fio reports, I can see that both the subm=
ission and completion latencies for these cases are higher for v4.8-rc6.  B=
elow are just the fio reported average latencies (us). =20

Queue Depth     v4.4.16           v4.8-rc6
1                          91.64               119.65
2                          91.38               112.42
4                          91.56               112.39
8                          94.57               95.29
16                        106.25            107.90
32                        181.36            173.40
64                        263.58            265.89
128                      512.82            519.96

Thanks,

Alana

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com]=20
Sent: Thursday, November 10, 2016 11:05 AM
To: Alana Alexander-Rutledge <Alana.Alexander-Rutledge@microsemi.com>
Cc: linux-block@vger.kernel.org; linux-nvme@lists.infradead.org; Stephen Ba=
tes <stephen.bates@microsemi.com>
Subject: Re: Higher block layer latency in kernel v4.8-r6 vs. v4.4.16 for N=
VMe

EXTERNAL EMAIL


On Wed, Nov 09, 2016 at 01:43:55AM +0000, Alana Alexander-Rutledge wrote:
> Hi,
>
> I have been profiling the performance of the NVMe and SAS IO stacks on Li=
nux.  I used blktrace and blkparse to collect block layer trace points and =
a custom analysis script on the trace points to average out the latencies o=
f each trace point interval of each IO.
>
> I started with Linux kernel v4.4.16 but then switched to v4.8-r6.  One th=
ing that stood out is that for measurements at queue depth =3D 1, the avera=
ge Q2D latency was quite a bit higher in the NVMe path with the newer versi=
on of the kernel.
>
> The Q, G, I, and D below refer to blktrace/blkparse trace points (queued,=
 get request, inserted, and issued).
>
> Queue Depth =3D 1
> Interval   Average - v4.4.16 (us) Average - v4.8-rc6 (us)
> Q2G         0.212                             0.573
> G2I           0.944                             1.507
> I2D           0.435                             0.837
> Q2D         1.592                             2.917
>
> For other queue depths, Q2D was similar for both versions of the kernel.
>
> Queue Depth     Average Q2D - v4.4.16 (us)  Average Q2D - v4.8-rc6 (us)
> 2                          1.893                                        1=
.736
> 4                          1.289                                        1=
.38
> 8                          1.223                                        1=
.162
> 16                        1.14                                          1=
.178
> 32                        1.007                                        1.=
425
> 64                        0.964                                        0.=
978
> 128                      0.915                                        0.9=
41
>
> I did not see this as a problem with the 12G SAS SSD that I measured.
>
> Queue Depth =3D 1
> Interval   Average - v4.4.16 (us) Average - v4.8-rc6 (us)
> Q2G        0.264                              0.301
> G2I          0.917                              0.864
> I2D          0.432                              0.397
> Q2D        1.613                              1.561
>
> Is this a known change or do you know what the reason for this is?

Are you using blk-mq for the 12G SAS? I assume not since most of these inte=
rvals would have executed through the same code path and shouldn't show a d=
ifference from to the underlying driver.

My guess for at least part of the additional latency to D/issued, the nvme =
driver in 4.1 used to call blk_mq_start_request (marks the "issued" trace
point) before it constructed the nvme command. 4.8 calls it after.

Have you noticed a difference in over-all latency?
