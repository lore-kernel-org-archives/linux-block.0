Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A58C433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 00:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9D5207DA
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 00:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597278724;
	bh=DK6cpoMIVfyVu3p4pB2161IxNHY/GDxfnQI+cNfyugo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1n4Ofyi0WWw2aklE1ncH+ahlLkdBfuAxrRzn5DlFh+1qELVhZ7Fapdx28U4JiItkF
	 T2VToyo0x/BOcY/Ybn3e1siMot6m9x5aN/2dtpkwArz3YoGXDLT6W98m9n94zmDD0B
	 JgugzmZ1LkJpx+TxQzmqPyQ0UBI6GuOwozpHWAio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMAcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgHMAcD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 20:32:03 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421F620771;
        Thu, 13 Aug 2020 00:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597278722;
        bh=DK6cpoMIVfyVu3p4pB2161IxNHY/GDxfnQI+cNfyugo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZG+AL1r5NU/udFg4cl05Mi6MI9WssSOPQQ0fn9v5LXwYCDLVzjyTV+2PpGNeZiYkz
         IGl9HF7xLFWVDGJHZnyU7fcZb3yy2mfQFSXT2/2xG97PjnegHQcIuFKcO4vQ5lRz15
         Cnb3E4XqVMCm2ldp9MAzByXqshGGdUznUybWP5+w=
Date:   Wed, 12 Aug 2020 17:32:00 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
Message-ID: <20200813003200.GA1640756@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200812232444.18310-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812232444.18310-1-logang@deltatee.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's an unrelated whitespace change in nvme_init_identify().
Otherwise, looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>
