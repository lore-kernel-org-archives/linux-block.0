Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF9C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 08:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJSIRm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 04:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJSIRj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 04:17:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A277C186
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 01:17:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9149F68C4E; Wed, 19 Oct 2022 10:17:34 +0200 (CEST)
Date:   Wed, 19 Oct 2022 10:17:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221019081734.GA15255@lst.de>
References: <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1> <20221017153105.GA32509@lst.de> <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1> <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590> <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me> <20221019072535.GA11402@lst.de> <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me> <20221019073231.GA12035@lst.de> <c791d0d8-80b5-d25c-f8d6-f93bf6c840a6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c791d0d8-80b5-d25c-f8d6-f93bf6c840a6@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 19, 2022 at 10:57:11AM +0300, Sagi Grimberg wrote:
>
>
> On 10/19/22 10:32, Christoph Hellwig wrote:
>> On Wed, Oct 19, 2022 at 10:30:44AM +0300, Sagi Grimberg wrote:
>>> iscsi defers network sends to a workqueue anyways, and no scsi lld sets
>>> BLK_MQ_F_BLOCKING.
>>
>> Yes, but Mike had a series to implement a similar fast path as nvme-tcp
>> as while ago that included supporting BLK_MQ_F_BLOCKING in the scsi
>> midlayer.
>
> Hmmm, didn't see that, pointer?

https://www.spinics.net/lists/linux-scsi/msg170849.html

>>  We'll also need it to convert the paride drivers to libata,
>> but those are single request_queue per tag_set as far as I know.
>
> didn't see paride even attempting to quiesce...

The block layer might.  But it really does not matter for our
considerations here..
