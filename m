Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E68C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 07:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDLHdJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDLHdI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 03:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015B61996
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 00:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CF562EBD
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 07:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537E6C433EF;
        Wed, 12 Apr 2023 07:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681284787;
        bh=lAUQXfyjGqt5Dv+cWiZZwEvychDEFyDobCOy2p6fZxU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mXnAjTzosEMzxrGIphXfNL8WnQ1NhM3qthCDfSm5oVW2rnvvjV25tu4NSEax3gkVA
         0JfdMBJLVv2Hzm53mkA5BFaHX50NeNfm6HsDKQw8kTL6CRiuz/bpI4yNEuYawzsgb/
         v4t27po/q9CMiJTFWH76Haxyo/ipBhou2UnUfVhy4O2EKdV/9i4JMl4qCXrtQgy1td
         Fvom47/HtqaadR/T3FKbl4BHfqG+mRbEZPM6jDa2yQM/JQFwDZKEGPaQZYTKqWs4s4
         kOqR1L1INKSBiI9+fj/opTWad7FZahg3NRX5YDdRuQw++BiDyDgtjFpeuyjfemBufN
         rF2ADOjpN6NuA==
Message-ID: <d95970c1-1fea-7e35-e29b-6013d2ba42e1@kernel.org>
Date:   Wed, 12 Apr 2023 16:33:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 08/18] blk-mq: fold __blk_mq_insert_req_list into
 blk_mq_insert_request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
References: <20230412053248.601961-1-hch@lst.de>
 <20230412053248.601961-9-hch@lst.de>
 <fd0e02c6-8fbb-cb7b-4925-331c132aeb7a@kernel.org>
 <20230412072009.GA21504@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230412072009.GA21504@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/23 16:20, Christoph Hellwig wrote:
> On Wed, Apr 12, 2023 at 04:16:36PM +0900, Damien Le Moal wrote:
>>>  	} else {
>>> +		trace_block_rq_insert(rq);
>>
>> Shouldn't we keep the trace call under ctx->lock to preserve precise tracing ?
> 
> ctx->lock doesn't synchronize any of the in the request that is traced
> here.

I am not worried about the values shown by the trace entries, but rather the
order of the inserts: with the trace call outside the lock, the trace may end up
showing an incorrect insertion order ?

