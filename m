Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A3C433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 11:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJRLFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 07:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJRLFu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 07:05:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333B193E0
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 04:05:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3957768C4E; Tue, 18 Oct 2022 13:05:44 +0200 (CEST)
Date:   Tue, 18 Oct 2022 13:05:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221018110544.GA4785@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017134244.GA24775@lst.de> <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me> <20221018085557.GA28266@lst.de> <3a466711-860a-667f-b78d-daa1eedb4edf@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a466711-860a-667f-b78d-daa1eedb4edf@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 12:06:41PM +0300, Sagi Grimberg wrote:
>>   +	/*
>> +	 * Mark the disk dead to prevent new opens, and set the capacity to 0
>> +	 * to end buffered writers dirtying pages that can't be synced.
>> +	 */
>>   	blk_mark_disk_dead(ns->disk);
>> -	nvme_start_ns_queue(ns);
>> -
>>   	set_capacity_and_notify(ns->disk, 0);
>> +
>> +	/* forcibly unquiesce queues to avoid blocking dispatch */
>> +	nvme_start_ns_queue(ns);
>>   }
>
> If we no longer have this ordering requirement, then I don't see why
> the unquiesce cannot move before or after nvme_set_queue_dying and apply
> a tagset-wide quiesce/unquiesce...

Yes.  After this patch we can simply do the tagset-wide unquiesce
after the loop calling blk_mark_disk_dead and set_capacity_and_notify.

We can then also move the NЅ_DEAD flag to the controller..
