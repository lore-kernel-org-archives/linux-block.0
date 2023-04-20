Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5191AC6FD18
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 01:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDTBHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 21:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDTBHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 21:07:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805583C32
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 18:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11BEF64437
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 01:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75461C433EF;
        Thu, 20 Apr 2023 01:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681952838;
        bh=AVq7iju1XpZLO1Or9OwQ+14Td19UKDRs7H2YK73ePSg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MdCWF99Rgxtmt4srnuVEcFP2Tqyw2ckeQJzZ9RmG0d5plB1grpiYyJzQu7dWbVJIg
         OGkLSXiBxLCebF4BV8j/kCpvxXfqpVvKd5j2VYXFzAUVBLKggJ0QMmminm/6Mm24E+
         Z8SuDPDx6D8Fq7UYZwNN1tNY1oMPgW79sqbWk3jX5D/N666ElR5xqHyBdI6UKoeU7J
         UYjsv19I5lEW+U1pUaGl4RSPru1rtUoVIj+PaqD9s8bNQvHLTMDdDeAyWLkGB+cDWL
         0QHVV+wVIWaYBgx1NTSKeowCpeCTAlBrNP9ZyMq4hPYddqb/chJb3yJMhFhhUWojHd
         VVV/tPi6xwdpw==
Message-ID: <95b697c5-fb54-96d3-43a8-ee81c3c76607@kernel.org>
Date:   Thu, 20 Apr 2023 10:07:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 09/11] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-10-bvanassche@acm.org>
 <20230419050758.GD25898@lst.de>
 <64b56eb3-bcf5-c48a-df96-bf1956f6992e@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <64b56eb3-bcf5-c48a-df96-bf1956f6992e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/23 08:01, Bart Van Assche wrote:
> On 4/18/23 22:07, Christoph Hellwig wrote:
>>>   deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
>>>   {
>>>   	struct rb_root *root = deadline_rb_root(per_prio, rq);
>>> +	struct request **next_rq __maybe_unused;
>>>   
>>>   	elv_rb_add(root, rq);
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +	next_rq = &per_prio->next_rq[rq_data_dir(rq)];
>>> +	if (*next_rq == NULL || !blk_queue_is_zoned(rq->q))
>>> +		return;
>>> +	/*
>>> +	 * If a request got requeued or requests have been submitted out of
>>> +	 * order, make sure that per zone the request with the lowest LBA is
>>> +	 * submitted first.
>>> +	 */
>>> +	if (blk_rq_pos(rq) < blk_rq_pos(*next_rq) &&
>>> +	    blk_rq_zone_no(rq) == blk_rq_zone_no(*next_rq))
>>> +		*next_rq = rq;
>>> +#endif
>>
>> Please key move this into a helper only called when blk_queue_is_zoned
>> is true.
> Hi Christoph,
> 
> I'm looking into an alternative, namely to remove the next_rq member 
> from struct dd_per_prio and instead to do the following:
> * Track the offset (blk_rq_pos()) of the most recently dispatched 
> request ("latest_pos").
> * Where the next_rq member is read, look up the request that comes after 
> latest_pos in the RB-tree. This should require an effort that is similar 
> to updating next_rq after having dispatched a request.
> 
> With this approach the code quoted above and that is surrounded with 
> #ifdef/#endif will disappear.

This sounds much better, given that there are in practice lots of cases where
next_rq is set null and we endup getting the next req from the fifo list head.
At least last time I looked at this is what I saw (it was when I patched for the
skip seq writes over 2 zones).

> 
> Bart.

