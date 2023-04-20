Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFF4C77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 01:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDTBDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 21:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDTBDV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 21:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B19358C
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 18:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5288863AB4
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 01:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BF2C433D2;
        Thu, 20 Apr 2023 01:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681952598;
        bh=zsdlI1haO7dDV4xh2XqBQh60zMdEAvml2KkfiHm2/K4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f/v5QfVBm2bDQmi547SxLd27ZO7bJFV2Ys9FfklpzKTrUkkO/ZE8EqOHcKhgadw2Q
         6MTD1/tiL3zayrnzF+KBG49lZ1Fs2HwKqidVGtRmpN/EPDZZtjOdaU+na2L3F1OG2Y
         eAWDX8c/sT29POBVzUp6Q7AqY635STRH6knsvmQemNxhw1GWyTKw8hyD/SfZftHCkN
         MDdl3W0dhHLk0l2wOYpr6m+6S7lzsFCKlHng7XF7vnkAe+QvfPIRnxJWgR0iTHAD0/
         OBv2AlufRVh9FwU24g3iQnhFNxreRlKQvAKJ4vX+s1jIRkM5lzj3vhf0uuJX+WYqSi
         DSpAylxLMKcig==
Message-ID: <3995e9fd-d9b3-feaa-39a7-d3d518468604@kernel.org>
Date:   Thu, 20 Apr 2023 10:03:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 03/11] block: Introduce blk_rq_is_seq_zoned_write()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-4-bvanassche@acm.org> <20230419045000.GA25898@lst.de>
 <80cf216a-dc41-0673-6d55-adb32ff42e46@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <80cf216a-dc41-0673-6d55-adb32ff42e46@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/23 06:12, Bart Van Assche wrote:
> On 4/18/23 21:50, Christoph Hellwig wrote:
>> On Tue, Apr 18, 2023 at 03:39:54PM -0700, Bart Van Assche wrote:
>>> +/**
>>> + * blk_rq_is_seq_zoned_write() - Whether @rq is a zoned write for which the order matters.
>>
>> Maybe:
>>
>>   * blk_rq_is_seq_zoned_write() - check if @rq needs zoned write serialization
> 
> That looks better to me :-)
> 
>>> +bool blk_rq_is_seq_zoned_write(struct request *rq)
>>> +{
>>> +	switch (req_op(rq)) {
>>> +	case REQ_OP_WRITE:
>>> +	case REQ_OP_WRITE_ZEROES:
>>> +		return blk_rq_zone_is_seq(rq);
>>> +	case REQ_OP_ZONE_APPEND:
>>> +	default:
>>
>> The REQ_OP_ZONE_APPEND case here is superflous.
> 
> Agreed, but I'd like to keep it since last time I posted this patch I 
> was asked whether I had perhaps overlooked the REQ_OP_ZONE_APPEND case. 
> I added "case REQ_OP_ZONE_APPEND:" to prevent such questions. Are you OK 
> with keeping "case REQ_OP_ZONE_APPEND:" or do you perhaps prefer that I 
> remove it?
> 

Could also have a comment on top of the switch explicitly saying that only WRITE
and WRITE ZEROES need to be checked, and that all other commands, including zone
append writes, do not have strong reordering requirements. This way, no need to
superfluous cases.

> Bart.
> 

