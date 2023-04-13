Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52919C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 06:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDMGQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 02:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMGQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608975B9E
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F19EB63804
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 06:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5295C433D2;
        Thu, 13 Apr 2023 06:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681366605;
        bh=B4979L+6ZG5LxjMF3RDq4AUCfj3Z7UHV7gPD0zt44C8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YsCErkIWKGnBYBGikiLLJawRYFxYXzuGvoVaMEPZT6+i6B7pJdJE4K24a0MUtA8Cp
         9TnU+ht+yTGxBBv+dBAWuQ/KiofOdWTr7p4j424EH/eJyRYwF7VOnMQJvVQlNPpWlF
         9nfMOTfKzoDkjmQo2DVcNhQjyoAubF+mz+vWIAgkfsBqWzj5fFuzmiJJ9fd61ZDKdM
         CYgCuizUyk8/W5ltKlDNa/LGREJiap0bdS2th8fssZe+J4JiOnfcxOWTLuK2eF3TDq
         0CqVudyefSP5VvHq7tLh/N8ta3/lRZQx5502uGrzj/wk7cSwWGj/TEPu0sYH0RLklH
         b6lPvNooc8dyA==
Message-ID: <7d6e92d8-025a-f367-cdad-1909e54b1e05@kernel.org>
Date:   Thu, 13 Apr 2023 15:16:43 +0900
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
 <d95970c1-1fea-7e35-e29b-6013d2ba42e1@kernel.org>
 <20230413061428.GB15376@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413061428.GB15376@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 15:14, Christoph Hellwig wrote:
> On Wed, Apr 12, 2023 at 04:33:04PM +0900, Damien Le Moal wrote:
>> I am not worried about the values shown by the trace entries, but rather the
>> order of the inserts: with the trace call outside the lock, the trace may end up
>> showing an incorrect insertion order ?
> 
> ... turns out none of the other calls to trace_block_rq_insert is
> under ctx->lock either.  The I/O scheduler ones are under their
> own per-request_queue locks, so maybe that counts as ordering,
> but blk_mq_insert_requests doesn't lock at all.

OK. And since nobody ever complained (that I know of), I guess it is fine then.
Feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

