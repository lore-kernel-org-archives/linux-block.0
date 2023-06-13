Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA01C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 06:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjFMGrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjFMGrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 02:47:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704101BDD
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 23:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8419162A1D
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 06:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18F8C433D2;
        Tue, 13 Jun 2023 06:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686638822;
        bh=5EN2Vue2qegn0/vT1a9AG5aq+CPmVmhzH4hQZ2LxTos=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rc0g2RnITimUKYwAZA8vwtjE+VHFfEk+3GFJRSqPGCShQ0NzAmIyIuRnUsMa4FWXY
         fdG2YHXSTjm/gasmtLgnSYXa1SaYtrpHlgqrdNkMf4uLYHvJcgj+4Sco03xQyHv5Wn
         XR/cm486mTwY9dSQRpn3he01aYZcm9kUFiCtFO9H5kXxlJVLEfAvCOdOygfYCqu6he
         pfx3J/UD4tRal2IPh7jAG6JXm8jvnhlB5pEd5sCPcnF5G9ct2jsxEhmN4dwOwtVI9z
         Cp9PawtuhzJkZll9FPCzmsjT5XJAVhgkYLbs+zsu2043mjoRWL/yIzdN1BNhtHsizw
         tKk9U3e2QLnxA==
Message-ID: <baffcda4-4a9d-6631-a5bf-b36f59f82bae@kernel.org>
Date:   Tue, 13 Jun 2023 15:47:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 8/8] null_blk: Support configuring the maximum segment
 size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <20230612203314.17820-9-bvanassche@acm.org>
 <407d7371-efa2-154d-a05f-a827171806a0@kernel.org>
 <2ec5270c-a913-44cf-3a45-0713e6c58224@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2ec5270c-a913-44cf-3a45-0713e6c58224@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/23 09:44, Bart Van Assche wrote:
> On 6/12/23 15:17, Damien Le Moal wrote:
>> On 6/13/23 05:33, Bart Van Assche wrote:
>>> @@ -1283,7 +1293,8 @@ static int null_handle_rq(struct nullb_cmd *cmd)
>>>   
>>>   	spin_lock_irq(&nullb->lock);
>>>   	rq_for_each_segment(bvec, rq, iter) {
>>> -		len = bvec.bv_len;
>>> +		len = min(bvec.bv_len, nullb->dev->max_segment_size);
>>> +		bvec.bv_len = len;
>>
>> I am still confused by this change... Why is it necessary ? If max_segment_size
>> is set correctly, how can we ever get a BIO with a bvec length exceeding that
>> maximum ? If that is the case, aren't we missing a bio_split() somewhere ?
> 
> Hi Damien,
> 
> bio_split() enforces the max_sectors limit but not the max_segment_size 
> limit. __blk_rq_map_sg() enforces the max_segment_size limit. null_blk 
> does not call __blk_rq_map_sg(). Hence the above code to enforce the 
> max_segment_size limit.

OK. That is where I was confused :)
Thanks !

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

