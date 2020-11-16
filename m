Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC16C61DD8
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 16:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB56C221F8
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 16:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6dgBRN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgKPQn2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbgKPQn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 11:43:28 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE80C0613CF
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 08:43:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so14691770pfu.1
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xjik3bPj3QD7dVsokOhUZfPJKy6Jis8hViC/+zvOQUM=;
        b=r6dgBRN+CCjnvMqJbCkD+fhXqWdE/UfTo6VTvA9vJpiS0kPLbpv0z1VR3gH40nkqIx
         KeEuguHCn2fw1EbSf2ConTKo8ZQig6GKTWB8QJJk2PZGKVxJlCQ1/t1Tsy6ciK1jK4sw
         6ZI7rZiRYPHjxPrK70jE+IvWBTpyl6OnEZ8jH+cUURpiIfhshpUbcMHsQ15a1kmkt3iR
         PgykVu9D29b9/8OzWhvQd0jnHVFrhwEcfqrpqb5GCGCvev5htYDkcfic8MhGYDHSqfbh
         +bNnTbb943QzXlIpV3EeWpIpFFI7VDZKRjLHdt+A0Cn9q2SlAvMaGf0aUHCc9cP3TIKd
         oQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xjik3bPj3QD7dVsokOhUZfPJKy6Jis8hViC/+zvOQUM=;
        b=qbt36+g0Ck1lkGWkJE2sKU6+7s5Zx79vhKfO4oKmKBebg38XSQ57HnYrFoF7vWaRDF
         zn7F2mkvDDuUZmw35n/QZUtOtSNnZRboZk0KEyZFgfPloa1TsWOMYtEReAwe1/vujgws
         dns7W97UswYjVOULAshpT8UN3uZnVmqeIqYZDLuRfZ4GRtxFVvRW9GlV1gmzZPd/sgkn
         fovQkEFLyBCJ/b1aENu0Ba5rkOOK0wzE2MwKA9RZGNMBtOLPbutV/1WFqY2zh53O4pYS
         uwwekTZBabVaTujnOucKwQqAY5srx7mkJKbCycAmpSSxH0b9gb05W+XSNRf4rK8iZf5B
         c86Q==
X-Gm-Message-State: AOAM532Hwe4i6PaBf/PiWAWlOZMXYteY6A8uRWb3EoMWZ6BOhDuwUatF
        YyFUTXaFQBkBbxK27kttoqWhVThg8HFgsQ==
X-Google-Smtp-Source: ABdhPJzcp3RvtZQKypsG0TBiPxLUJ4FwgHJ+sMNSvQjvol8u2ckcMoQocABnOBwEkBoFVfnSKHcPsA==
X-Received: by 2002:a62:cec6:0:b029:18a:d620:6b86 with SMTP id y189-20020a62cec60000b029018ad6206b86mr14050197pfg.2.1605545007549;
        Mon, 16 Nov 2020 08:43:27 -0800 (PST)
Received: from dongjoo-desktop ([203.246.112.155])
        by smtp.gmail.com with ESMTPSA id 205sm16292238pge.76.2020.11.16.08.43.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Nov 2020 08:43:26 -0800 (PST)
Date:   Tue, 17 Nov 2020 01:43:22 +0900
From:   Dongjoo Seo <commisori28@gmail.com>
To:     linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: modify hybrid sleep time to aggressive
Message-ID: <20201116164322.GA7283@dongjoo-desktop>
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

