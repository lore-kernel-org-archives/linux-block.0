Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B6C3A5A7
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 12:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190A421883
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 12:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfIDMty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:49:54 -0400
Received: from verein.lst.de ([213.95.11.211]:39028 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfIDMty (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 08:49:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14C1A227A8A; Wed,  4 Sep 2019 14:49:50 +0200 (CEST)
Date:   Wed, 4 Sep 2019 14:49:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
Message-ID: <20190904124949.GA17285@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com> <8df57b71-9404-904d-7abd-587942814039@grimberg.me> <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk> <20190904054956.GA10553@lst.de> <fd70d115-bb29-a8a7-83ae-7e3dcaa1dc1c@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd70d115-bb29-a8a7-83ae-7e3dcaa1dc1c@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 04, 2019 at 11:32:04AM +0300, Max Gurtovoy wrote:
>
> On 9/4/2019 8:49 AM, Christoph Hellwig wrote:
>> On Tue, Sep 03, 2019 at 01:21:59PM -0600, Jens Axboe wrote:
>>> On 9/3/19 1:11 PM, Sagi Grimberg wrote:
>>>>> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
>>>>> +	    error == BLK_STS_OK)
>>>>> +		t10_pi_complete(req,
>>>>> +				nr_bytes / queue_logical_block_size(req->q));
>>>>> +
>>>> div in this path? better to use  >> ilog2(block_size).
>>>>
>>>> Also, would be better to have a wrapper in place like:
>>>>
>>>> static inline unsigned short blk_integrity_interval(struct request *rq)
>>>> {
>>>> 	return queue_logical_block_size(rq->q);
>>>> }
>>> If it's a hot path thing that matters, I'd strongly suggest to add
>>> a queue block size shift instead.
>> Make that a protection_interval_shift, please.  While that currently
>> is the same as the logical block size the concepts are a little
>> different, and that makes it clear.  Except for that this patch looks
>> very nice to me, it is great to avoid having drivers to deal with the
>> PI remapping.
>
> Christoph,
>
> I was thinking about the following addition to the code (combination of all 
> the suggestions):

I'll defer to Martin, but I think we still need the integrity_interval
naming in some form.

static inline unsigned short queue_logical_block_shift(struct  request_queue *q)
> +{
> +       unsigned short retval = 9;
> +
> +       if (q && q->limits.logical_block_shift)
> +               retval = q->limits.logical_block_shift;
> +
> +       return retval;

I don't think a NULL queue makes any sense here.  And I'd rather
ensure the field is always set rather than adding a conditional here.

And btw, centrelize in the Subject should be centralize.
