Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2987EC6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 08:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCVI12 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 04:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCVI1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 04:27:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4399E5D27C
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:27:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F99D68C7B; Wed, 22 Mar 2023 09:27:17 +0100 (CET)
Date:   Wed, 22 Mar 2023 09:27:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Message-ID: <20230322082717.GC22782@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-2-kbusch@meta.com> <ac4ecdd4-104e-0fcf-0ac5-42dde79daf35@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4ecdd4-104e-0fcf-0ac5-42dde79daf35@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 09:35:46AM +0200, Sagi Grimberg wrote:
>>   +unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts)
>> +{
>> +	unsigned int nr_io_queues;
>> +
>> +	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
>> +	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
>> +	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
>> +
>> +	return nr_io_queues;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_nr_io_queues);
>
> Given that it is shared only with tcp/rdma, maybe rename it
> to nvmf_ip_nr_io_queues.

Even if the other transports don't use it, nothing is really IP
specific here, so I don't think that's too useful.  But I'd use
the nvmf_ prefix like other functions in this file.

Just a personal choice, but I'd write this as:

	return min(opts->nr_io_queues, num_online_cpus()) +
		min(opts->nr_write_queues, num_online_cpus()) +
		min(opts->nr_poll_queues, num_online_cpus());

>> +EXPORT_SYMBOL_GPL(nvme_set_io_queues);
>
> nvmf_ip_set_io_queues. Unless you think that this can be shared with
> pci/fc as well?

Again I'd drop the _ip as nothing is IP specific.  FC might or might not
eventually use it, for PCI we don't have the opts structure anyway
(never mind this sits in fabrics.c).

>> +void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
>> +		     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES])
>
> Ugh, the ib_device input that may be null is bad...
> I think that we can kill blk_mq_rdma_map_queues altogether
> and unify the two.

Yes, I don't think anything touching an ib_device should be in
common code.
