Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93077C64E69
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 00:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E49924181
	for <linux-block@archiver.kernel.org>; Wed, 18 Nov 2020 00:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgyAURrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKRArx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Nov 2020 19:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRArx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 19:47:53 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF4C061A48
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2020 16:47:51 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w14so309494pfd.7
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2020 16:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xjik3bPj3QD7dVsokOhUZfPJKy6Jis8hViC/+zvOQUM=;
        b=LgyAURrtaY4pITG+veedMmuKbamN9sFy7cybnlGk8m4IWvoWE6/jPnxmCtdNdHheib
         001vrHiofXWnYk+yb+VEmfWJrcONgi22lEHl+LQYsWpceSLSKECYVoF1aoVZA0//cWEg
         TIaubHoKp9PNl8Sretrb+5J5Rq2txAtQ4YP9LmbYhGhq/noEL+45JU0gbiQ+REcte2Fx
         DVzpeYQ/tzWl0mbSBZK25VeeYizlf1Ps4Un/X+MIz3/UTaF84gFEJI0zWZIP3arkIWd/
         xfXJboO9/bw6PORTD2WB/8rR4WxcvYVfk960F4ROWyiD+I9RwOdWAwQ1EWdglXK2r12z
         8LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xjik3bPj3QD7dVsokOhUZfPJKy6Jis8hViC/+zvOQUM=;
        b=j8kKM1UlQvei9pUyeizpS+oWZr2H5Es4o3DgFMCtA2fl3mM28r8X4BFX8tB/ayAhE+
         bQwNqXCVXWrPwe8t2EN4Y3dGhZSRgVvlgmjxBzuTcLeYZHvMdTTzjLrFJwyvVWPCCeMH
         q5x1AULzz91yrKjm62R1oN2FNdskNLAQf+55KJOl+HpInd7ap0i2reRI5TCU2PZAN4tk
         auUuabD+ZO8ACy7gQ14OXLMh9PZRV9/YGHzis59cTFRgG8LWl/VD3HM1NPKxCGDf/Os3
         TahwbN66qiliN2u3xKOxpAbySyFldJChpfXznpd6ZtEHhjmY8oKqaf7S9o3kfSNaJA57
         8vzw==
X-Gm-Message-State: AOAM533rBnfmO20L/bxnF+D8PSCy+3kJaODtvdz8r0aio6hc72YDtLBH
        h0vxZqSd6IZ8Zmq7jRl/qiSa+QpTVle55XtE
X-Google-Smtp-Source: ABdhPJxZaJs674HlDlcgpHYSZtLoB+BQV7xXZC0KRKiWQP0CIKgbkZ691qPGW617771aWNtHMZ2/UA==
X-Received: by 2002:a63:389:: with SMTP id 131mr5857528pgd.128.1605660471417;
        Tue, 17 Nov 2020 16:47:51 -0800 (PST)
Received: from dongjoo-desktop ([203.246.112.155])
        by smtp.gmail.com with ESMTPSA id q14sm20992368pfl.163.2020.11.17.16.47.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Nov 2020 16:47:50 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:47:46 +0900
From:   Dongjoo Seo <commisori28@gmail.com>
To:     axboe@kernel.dk, hch@infradead.org, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: modify hybrid sleep time to aggressive
Message-ID: <20201118004746.GA29180@dongjoo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Current sleep time for hybrid polling is half of mean time.
The 'half' sleep time is good for minimizing the cpu utilization.
But, the problem is that its cpu utilization is still high.
this patch can help to minimize the cpu utilization side.

Below 1,2 is my test hardware sets.

1. Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz + Samsung 970 pro 1Tb
2. Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz + INTEL SSDPED1D480GA 480G

        |  Classic Polling | Hybrid Polling  | this Patch
-----------------------------------------------------------------
        cpu util | IOPS(k) | cpu util | IOPS | cpu util | IOPS  |
-----------------------------------------------------------------
1.       99.96   |   491   |  56.98   | 467  | 35.98    | 442   |
-----------------------------------------------------------------
2.       99.94   |   582   |  56.3    | 582  | 35.28    | 582   |

cpu util means that sum of sys and user util.

I used 4k rand read for this test.
because that case is worst case of I/O performance side.
below one is my fio setup.

name=pollTest
ioengine=pvsync2
hipri
direct=1
size=100%
randrepeat=0
time_based
ramp_time=0
norandommap
refill_buffers
log_avg_msec=1000
log_max_value=1
group_reporting
filename=/dev/nvme0n1
[rd_rnd_qd_1_4k_1w]
bs=4k
iodepth=32
numjobs=[num of cpus]
rw=randread
runtime=60
write_bw_log=bw_rd_rnd_qd_1_4k_1w
write_iops_log=iops_rd_rnd_qd_1_4k_1w
write_lat_log=lat_rd_rnd_qd_1_4k_1w

Thanks

Signed-off-by: Dongjoo Seo <commisori28@gmail.com>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1b25ec2fe9be..c3d578416899 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3749,8 +3749,7 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 		return ret;
 
 	if (q->poll_stat[bucket].nr_samples)
-		ret = (q->poll_stat[bucket].mean + 1) / 2;
-
+		ret = (q->poll_stat[bucket].mean + 1) * 3 / 4;
 	return ret;
 }
 
-- 
2.17.1

