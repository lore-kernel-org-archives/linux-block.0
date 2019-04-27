Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD1C43219
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A644D208CB
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329615;
	bh=A+7EVeSHcLg7JD438yl89GerQ3uZicddaXRsWTqPvyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xpP9QkCHMGDL15gxNB7Kqsc/FRwZtfTSGnUtXPpeBxBH3Pol/Tt1neRmDJNumMWlf
	 rXt9fa/CqQUFGmQFJLM7cjbNH4pyQ7bearAoRRW/gz9ZfdtZrsG6OiCQkHs5VK8VsP
	 9Fm3QsfyvgXHESr1Od074Wn4oqGJasA0mnVl0MKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfD0BnR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbfD0BnL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6464B215EA;
        Sat, 27 Apr 2019 01:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329391;
        bh=A+7EVeSHcLg7JD438yl89GerQ3uZicddaXRsWTqPvyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+TvrQ84rZ7as6KH3Ht/zvMyUBJnmWRLu1llz5v2tMNkanX40H4fAlq372wslJXb+
         nGDL2odpblANFiZLMyCgls/bqTan/Cehfb+aHRjbkwzoP2gtH/m+eUIKsRiDnMwrb0
         MFGhJtq4yijhmeB+oj7mlfEnJUIe+eeUpsT0OM6w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 26/32] virtio-blk: limit number of hw queues by nr_cpu_ids
Date:   Fri, 26 Apr 2019 21:42:17 -0400
Message-Id: <20190427014224.8274-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit bf348f9b78d413e75bb079462751a1d86b6de36c ]

When tag_set->nr_maps is 1, the block layer limits the number of hw queues
by nr_cpu_ids. No matter how many hw queues are used by virtio-blk, as it
has (tag_set->nr_maps == 1), it can use at most nr_cpu_ids hw queues.

In addition, specifically for pci scenario, when the 'num-queues' specified
by qemu is more than maxcpus, virtio-blk would not be able to allocate more
than maxcpus vectors in order to have a vector for each queue. As a result,
it falls back into MSI-X with one vector for config and one shared for
queues.

Considering above reasons, this patch limits the number of hw queues used
by virtio-blk by nr_cpu_ids.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 68846897d213..8767401f75e0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -437,6 +437,8 @@ static int init_vq(struct virtio_blk *vblk)
 	if (err)
 		num_vqs = 1;
 
+	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
-- 
2.19.1

