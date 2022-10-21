Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A8C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 13:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJUNWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJUNWT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:22:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F3424CC09
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:22:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E11CA68B05; Fri, 21 Oct 2022 15:22:14 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:22:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Message-ID: <20221021132214.GC22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-4-hch@lst.de> <46ce9b02-7474-22a7-f8c2-10f46e88853a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ce9b02-7474-22a7-f8c2-10f46e88853a@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 03:16:50PM +0800, Chao Leng wrote:
>>   	struct list_head	tag_list;
>> +	struct srcu_struct	srcu;
> srcu_struct size is more than 50+ KB, it is waste for the tagset which do not set
> the BLK_MQ_F_BLOCKING, and most tagsets do not set the BLK_MQ_F_BLOCKING.
> Maybe we can define "srcu" as a pointer, and allocate the memory in blk_mq_alloc_tag_set
> just for tagset which set the BLK_MQ_F_BLOCKING.

I guess we could do that.  Still better than the variable sized struct.

p.s. any chance you could properly trim your replies?  I took me a while
to find your comment in the sea of quotes.
