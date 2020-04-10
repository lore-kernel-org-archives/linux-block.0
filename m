Return-Path: <SRS0=rO4A=52=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9EAC2BBFD
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 04:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D8E20936
	for <linux-block@archiver.kernel.org>; Fri, 10 Apr 2020 04:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586491265;
	bh=Szm+1rgDnYEAet5MAJnily9gGMqOJMGUuLDtS4pC0Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qqgtv1k2MZ5pvtOe+4r2wZlp6HQ4xZr+5KlSw/DEt3xmAvYKD9Khw+Cc5ytMPywTJ
	 1unD/70l24+eDMT8GiOxlpV1doyANefogmGRft582l32Kzwc2GpZ3rTIm12EvnkNJQ
	 iF3+duU+aUyDDETEFnob43WyC5yHbpmAOBNojyrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgDJEBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Apr 2020 00:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgDJDrj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 23:47:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B58F212CC;
        Fri, 10 Apr 2020 03:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490458;
        bh=Szm+1rgDnYEAet5MAJnily9gGMqOJMGUuLDtS4pC0Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFSNqFHSm91F8xrWDPL2eygtz8JTFSZrVT6OmfI4wRiMQisQbDMFNKrhcoXwn9IKL
         9mcqy5Ezn2EQBhIBKbvSA/RYUxhntT/ehQPzJKHXLy+dmeS19k1QfgvCUdeYwSU/Vy
         ggeLes4YfVRgVReYP+NMX/IdEY5bSsLJX4mJOyQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 53/68] block, zoned: fix integer overflow with BLKRESETZONE et al
Date:   Thu,  9 Apr 2020 23:46:18 -0400
Message-Id: <20200410034634.7731-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit 11bde986002c0af67eb92d73321d06baefae7128 ]

Check for overflow in addition before checking for end-of-block-device.

Steps to reproduce:

	#define _GNU_SOURCE 1
	#include <sys/ioctl.h>
	#include <sys/types.h>
	#include <sys/stat.h>
	#include <fcntl.h>

	typedef unsigned long long __u64;

	struct blk_zone_range {
	        __u64 sector;
	        __u64 nr_sectors;
	};

	#define BLKRESETZONE    _IOW(0x12, 131, struct blk_zone_range)

	int main(void)
	{
	        int fd = open("/dev/nullb0", O_RDWR|O_DIRECT);
	        struct blk_zone_range zr = {4096, 0xfffffffffffff000ULL};
	        ioctl(fd, BLKRESETZONE, &zr);
	        return 0;
	}

BUG: KASAN: null-ptr-deref in submit_bio_wait+0x74/0xe0
Write of size 8 at addr 0000000000000040 by task a.out/1590

CPU: 8 PID: 1590 Comm: a.out Not tainted 5.6.0-rc1-00019-g359c92c02bfa #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01/2014
Call Trace:
 dump_stack+0x76/0xa0
 __kasan_report.cold+0x5/0x3e
 kasan_report+0xe/0x20
 submit_bio_wait+0x74/0xe0
 blkdev_zone_mgmt+0x26f/0x2a0
 blkdev_zone_mgmt_ioctl+0x14b/0x1b0
 blkdev_ioctl+0xb28/0xe60
 block_ioctl+0x69/0x80
 ksys_ioctl+0x3af/0xa50

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 05741c6f618be..6b442ae96499a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -173,7 +173,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	if (!op_is_zone_mgmt(op))
 		return -EOPNOTSUPP;
 
-	if (!nr_sectors || end_sector > capacity)
+	if (end_sector <= sector || end_sector > capacity)
 		/* Out of range */
 		return -EINVAL;
 
-- 
2.20.1

