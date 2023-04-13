Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8029C77B73
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 07:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDMHsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 03:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMHsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 03:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AC196
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 00:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D527263B1C
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 07:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02AAC433D2;
        Thu, 13 Apr 2023 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681372074;
        bh=YzpjkEAj5T2jKk6o2Xwg9UCBpJrOdUr2nMU2XEPb9b4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hJLiUbqI3XndA9sF+Nd+oPsOFJ9xg16rqkdIFAZCNpqfMiV4f6Z8dyTz9YFbaMeam
         zSnBmvq77xBPMu9mh/bSjmyktq1tb4BOiZl9Fe1uylWJwIL3ag5WLvGfq9wAkaWL7O
         Y4mF12ZS3YqJnY/8MNYDbm58F57tI841mIPU+U/KLcsuUiBsXOhOySYZf1oBIaxo1s
         LtCUuAYsFFmRrTy1O+aU/XXT/jRYo4XTYiwOiR0TkKrJ7fujo1/wvi9ZeR9FopRfs3
         G2DInDQbEaHzGMwt4IcUG5QFbAWxa35IxBvXeg7SgOQqhFBby+AsbwbSX6JjM5ztGl
         Q9+FkkFE/8Caw==
Message-ID: <82166120-5585-79ee-6225-70b31e08324d@kernel.org>
Date:   Thu, 13 Apr 2023 16:47:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 16/20] blk-mq: don't kick the requeue_list in
 blk_mq_add_to_requeue_list
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
References: <20230413064057.707578-1-hch@lst.de>
 <20230413064057.707578-17-hch@lst.de>
 <1f06dd70-bf06-2983-f9fd-5875a8f5d20d@kernel.org>
 <20230413065940.GB16260@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413065940.GB16260@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 15:59, Christoph Hellwig wrote:
> On Thu, Apr 13, 2023 at 03:54:31PM +0900, Damien Le Moal wrote:
>>>  void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
>>>  {
>>> +	struct request_queue *q = rq->q;
>>
>> Nit: not really needed given that it is used in one place only.
>> You could just call "blk_mq_kick_requeue_list(rq->q)" below.
> 
> It is needed, because we can't dereference rq safely after
> blk_mq_add_to_requeue_list returns.

Ah, yes, indeed. Sorry for the noise.

