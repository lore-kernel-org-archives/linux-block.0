Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1A9C43457
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 00:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E84B2076C
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594859274;
	bh=nngL0ckNf8/smwBwPZWSKAozcrsj4QkjLpABavd1ntw=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:
	 In-Reply-To:References:List-ID:From;
	b=NU9nSqlnHqr3mYGT/KcXvjAMXYdilba7VloVuTTyBgVWy0R7miKqxD/mRrMXEaqct
	 uzoaJ+oz4i1qzA5PQSH00J4Z+C4cfe3+3WsHWJqAe2+bymbn/3sIPBH36Hvqic2hLI
	 gQ4SazFzT3L1JX6dATRh4xoWJbiyPVryxm6YwcQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGPA1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgGPA1m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 20:27:42 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C1B207BC;
        Thu, 16 Jul 2020 00:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594859261;
        bh=nngL0ckNf8/smwBwPZWSKAozcrsj4QkjLpABavd1ntw=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:
         In-Reply-To:References:From;
        b=LZa7PeNwvjlt9hSHZ3aQDm+KNzcovhxphCXJDgGddbA0107aCwiuM+Y0CFw+ULvGV
         mwsyJ+u53l/4xekIz9qgtEnjYEnDCJcvNOn+BW0AOhssIq4bZa3TQlR4vRZ0Xaoth8
         tnfvGCH8XwiT28iQ8xbRf/6cSjW4A0NZkZAcO27s=
Date:   Thu, 16 Jul 2020 00:27:40 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Coly Li <colyli@suse.de>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Coly Li <colyli@suse.de>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>
Cc:     Jan Kara <jack@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Vlastimil Babka <vbabka@suse.com>
Cc:     stable@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-tpc: don't use sendpage for pages not taking reference counter
In-Reply-To: <20200710132610.11756-1-colyli@suse.de>
References: <20200710132610.11756-1-colyli@suse.de>
Message-Id: <20200716002741.88C1B207BC@mail.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.7.8, v5.4.51, v4.19.132, v4.14.188, v4.9.230, v4.4.230.

v5.7.8: Build OK!
v5.4.51: Build OK!
v4.19.132: Failed to apply! Possible dependencies:
    37c15219599f7 ("nvme-tcp: don't use sendpage for SLAB pages")
    3f2304f8c6d6e ("nvme-tcp: add NVMe over TCP host driver")

v4.14.188: Failed to apply! Possible dependencies:
    37c15219599f7 ("nvme-tcp: don't use sendpage for SLAB pages")
    3f2304f8c6d6e ("nvme-tcp: add NVMe over TCP host driver")

v4.9.230: Failed to apply! Possible dependencies:
    37c15219599f7 ("nvme-tcp: don't use sendpage for SLAB pages")
    3f2304f8c6d6e ("nvme-tcp: add NVMe over TCP host driver")
    b1ad1475b447a ("nvme-fabrics: Add FC transport FC-NVME definitions")
    d6d20012e1169 ("nvme-fabrics: Add FC transport LLDD api definitions")
    e399441de9115 ("nvme-fabrics: Add host support for FC transport")

v4.4.230: Failed to apply! Possible dependencies:
    07bfcd09a2885 ("nvme-fabrics: add a generic NVMe over Fabrics library")
    1673f1f08c887 ("nvme: move block_device_operations and ns/ctrl freeing to common code")
    1c63dc66580d4 ("nvme: split a new struct nvme_ctrl out of struct nvme_dev")
    21d147880e489 ("nvme: fix Kconfig description for BLK_DEV_NVME_SCSI")
    21d34711e1b59 ("nvme: split command submission helpers out of pci.c")
    3f2304f8c6d6e ("nvme-tcp: add NVMe over TCP host driver")
    4160982e75944 ("nvme: split __nvme_submit_sync_cmd")
    4490733250b8b ("nvme: make SG_IO support optional")
    6f3b0e8bcf3cb ("blk-mq: add a flags parameter to blk_mq_alloc_request")
    7110230719602 ("nvme-rdma: add a NVMe over Fabrics RDMA host driver")
    a07b4970f464f ("nvmet: add a generic NVMe target")
    b1ad1475b447a ("nvme-fabrics: Add FC transport FC-NVME definitions")
    d6d20012e1169 ("nvme-fabrics: Add FC transport LLDD api definitions")
    e399441de9115 ("nvme-fabrics: Add host support for FC transport")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
