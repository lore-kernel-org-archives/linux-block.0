Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C7BC77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 05:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjDLFCR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLFCP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:02:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526BC2D66
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:02:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A29F68BFE; Wed, 12 Apr 2023 07:02:11 +0200 (CEST)
Date:   Wed, 12 Apr 2023 07:02:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 13/16] blk-mq: don't run the hw_queue from
 blk_mq_request_bypass_insert
Message-ID: <20230412050211.GA17948@lst.de>
References: <20230411133329.554624-1-hch@lst.de> <20230411133329.554624-14-hch@lst.de> <28e48eeb-caf4-fe83-baec-6ed1cd154daf@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e48eeb-caf4-fe83-baec-6ed1cd154daf@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 11, 2023 at 11:09:58AM -0700, Bart Van Assche wrote:
> On 4/11/23 06:33, Christoph Hellwig wrote:
>>   	if ((policy & REQ_FSEQ_DATA) &&
>>   	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
>> -		blk_mq_request_bypass_insert(rq, false, true);
>> +		blk_mq_request_bypass_insert(rq, false);
>>   		return;
>>   	}
>
> Did you perhaps want to add a blk_mq_run_hw_queue() call in this 
> blk_insert_flush() code path?

Yes.  I'll fix it.
