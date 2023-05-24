Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03085C77B7E
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 01:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbjEXBs7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 21:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjEXBs4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 21:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866AE186
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 18:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B19661DB3
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 01:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E40C433D2;
        Wed, 24 May 2023 01:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684892907;
        bh=RgqSJWOU/j9QkanYVHxDCzkenLAfFXqP2df5JV7XCQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAUhXmupdNSDOZLMFgCULKlDseTIrURrPtvrhxgHzV0xOk7MXsKmCnf8Lr1sfZYvJ
         dNdqPYLQ5Cg43LbJTlrx8QNtvERgyFiY/TCi4htMU3Fc7u6yjBOp+8t5ypC9eqVrgK
         J4KXYG2RKgVEPgZOSNUN5qlIh7v6bqfrw9e8yqeCwOh5ZDmo1JkDtusk5zC+wPGVPy
         SWeGTXihN4Sd9tlgMjH3vcJyaRKOV1UbeKgh5FGactyLG1H+4eVhKbcbpz6YjU5e5G
         4f5LuRGMTjuQ1jv7w56rVimeyJcAX/dUsM1TAZ7gKxRpzo5C6Z5W3f5tXAbEZg7TCp
         kEeyD/g6ziKdg==
Date:   Tue, 23 May 2023 19:48:24 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Tian Lan <tilan7663@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, liusong@linux.alibaba.com,
        ming.lei@redhat.com, tian.lan@twosigma.com
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Message-ID: <ZG1s6D/KnA1M59AL@kbusch-mbp.dhcp.thefacebook.com>
References: <a11faa27-965e-3109-15e2-33f015262426@oracle.com>
 <20230522210555.794134-1-tilan7663@gmail.com>
 <cb475361-dad3-1be0-31a4-710f4c1ea95f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb475361-dad3-1be0-31a4-710f4c1ea95f@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 09:22:13AM +0100, John Garry wrote:
> On 22/05/2023 22:05, Tian Lan wrote:
> > +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> > +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> 
> We could also add a bitops wrapper function for this. I don't know what name
> to use, maybe test_and_set_bit_fast_but_racy() - I'm half joking about the
> name

I don't think this pattern is any more racy than a solo
test_and_set_bit(). Maybe "test_then_test_and_set_bit()"?
