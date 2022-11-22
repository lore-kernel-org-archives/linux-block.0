Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09301C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 06:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiKVGJL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 01:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiKVGJD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 01:09:03 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED12A978
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 22:08:58 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4754C68D05; Tue, 22 Nov 2022 07:08:55 +0100 (CET)
Date:   Tue, 22 Nov 2022 07:08:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
Message-ID: <20221122060855.GA14111@lst.de>
References: <20221101150050.3510-1-hch@lst.de> <20221101150050.3510-15-hch@lst.de> <20221121204450.6vyg6gixsz4unpaz@google.com> <a8e3d7a4-c5f6-13d0-a517-72097daa2a7b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e3d7a4-c5f6-13d0-a517-72097daa2a7b@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 22, 2022 at 10:53:17AM +0800, Chao Leng wrote:
>> This patch is causing the following crash at the boot and reverting it
>> fixes the issue. This is next-20221121 kernel.
> This patch can fix it.
> https://lore.kernel.org/linux-nvme/20221116072711.1903536-1-hch@lst.de/

Yes,  But I'm a little curious how it happened.  Shakeel, do you
have a genuine admin controller that does not have any I/O queues
to start with, or did we have other setup time errors?  Can youpost the
full dmesg?
