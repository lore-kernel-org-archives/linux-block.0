Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B1C433FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3C1205F4
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfHNLeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfHNLeU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 07:34:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B6F9309BDA3;
        Wed, 14 Aug 2019 11:34:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C3360F80;
        Wed, 14 Aug 2019 11:34:05 +0000 (UTC)
Date:   Wed, 14 Aug 2019 19:33:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@android.com, narayan@google.com, dariofreni@google.com,
        ioffe@google.com, jiyong@google.com, maco@google.com
Subject: Re: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when
 possible.
Message-ID: <20190814113348.GA525@ming.t460p>
References: <20190814103244.92518-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814103244.92518-1-maco@android.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 14 Aug 2019 11:34:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 14, 2019 at 12:32:44PM +0200, Martijn Coenen wrote:
> Since Android Q, the creation and configuration of loop devices is in
> the critical path of device boot. We found that the configuration of
> loop devices is pretty slow, because many ioctl()'s involve freezing the
> block queue, which in turn needs to wait for an RCU grace period. On
> Android devices we've observed up to 60ms for the creation and
> configuration of a single loop device; as we anticipate creating many
> more in the future, we'd like to avoid this delay.
> 

Another candidate is to not switch to q_usage_counter's percpu mode
until loop becomes Lo_bound, and this way may be more clean.

Something like the following patch:

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a7461f482467..8791f9242583 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1015,6 +1015,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	 */
 	bdgrab(bdev);
 	mutex_unlock(&loop_ctl_mutex);
+
+	percpu_ref_switch_to_percpu(&lo->lo_queue->q_usage_counter);
+
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	if (claimed_bdev)
@@ -1171,6 +1174,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&loop_ctl_mutex);
 
+	percpu_ref_switch_to_atomic(&lo->lo_queue->q_usage_counter, NULL);
+
 	/*
 	 * Need not hold loop_ctl_mutex to fput backing file.
 	 * Calling fput holding loop_ctl_mutex triggers a circular
@@ -2003,6 +2008,12 @@ static int loop_add(struct loop_device **l, int i)
 	}
 	lo->lo_queue->queuedata = lo;
 
+	/*
+	 * cheat block layer for not switching to q_usage_counter's
+	 * percpu mode before loop becomes Lo_bound
+	 */
+	blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, lo->lo_queue);
+
 	blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
 
 	/*


thanks,
Ming
