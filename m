Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1A3C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5AC2081A
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 12:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="K9jD1x/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFAMhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFAMhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 08:37:18 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EC3C061A0E;
        Mon,  1 Jun 2020 05:37:17 -0700 (PDT)
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 2D98F2E1537;
        Mon,  1 Jun 2020 15:37:15 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id sin8Zu6uxy-bCx0121q;
        Mon, 01 Jun 2020 15:37:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591015035; bh=5PjvOIhiYKATy5WYX6CV1e4IcQVtVa9D6p3WuT8s0D4=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=K9jD1x/WB9MFGRSpVuHnqjbBhyphhBcCrzbaFsCSmn9JkSKKe0ODm3hEKA71EuJyc
         C+I3jmbann0MWOxySvQwGsSwS5d9o8a3UxSAGqfJ08XOkx6K1CFBy/WMWf6oYvoXfB
         //Wi04hvl39aEpn3MdcQYH4aWcNe8WtZMfonbUNg=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6420::1:8])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id oflWdp3Iqs-bCW4OxOY;
        Mon, 01 Jun 2020 15:37:12 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 2/3] md/raid0: enable REQ_NOWAIT
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>
Date:   Mon, 01 Jun 2020 15:37:12 +0300
Message-ID: <159101503243.180989.945052901574296650.stgit@buzz>
In-Reply-To: <159101473169.180989.12175693728191972447.stgit@buzz>
References: <159101473169.180989.12175693728191972447.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set limits.nowait_requests = 1 before stacking limits.
Raid itself does not delay bio in raid0_make_request().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/md/raid0.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 322386ff5d22..e34292b05488 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -406,6 +406,9 @@ static int raid0_run(struct mddev *mddev)
 		blk_queue_io_opt(mddev->queue,
 				 (mddev->chunk_sectors << 9) * mddev->raid_disks);
 
+		/* raid0_make_request() does not delay requests */
+		mddev->queue->limits.nowait_requests = 1;
+
 		rdev_for_each(rdev, mddev) {
 			disk_stack_limits(mddev->gendisk, rdev->bdev,
 					  rdev->data_offset << 9);

