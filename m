Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9302CC433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C61861153
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhDOTpz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234803AbhDOTpz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 15:45:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0606761152;
        Thu, 15 Apr 2021 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618515932;
        bh=zWnJYfHtYM6iXWjHyj1gcN+0DAlxASqFE+oUXJyZXHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYu2G9q+io1kR1RJPZHFndAFazBZnZxk/S+wvYsRDQx4sqMjsxSKK4fakiJFwY5gM
         cPHjm/o+Kzrta2Yn4AfqHNZSSTM7ks56Iw7o8VeB02cbY73TBrtxQn8RkuolRMAVtN
         WXt7dcTFZYLrHkxFOpXEA2pspv58xtTbwMGxALWTtN8+HelsdCr2cQXaVdwfQZDAJa
         xRkKB7HJCJ4jEu57q0LVSXfGWtInYiDllhpvl3ZkAR2b27Jek1RQGChWXHUqWqKnDY
         XboIEFiITIimVxOowM71PoigyRj4zNGrb1IksiiW45+P4LTpJLAgNb6N+npRq1mCcS
         PyR4d1XqWoWtw==
Date:   Thu, 15 Apr 2021 12:45:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 5/8] block: respect bio_required_sector_alignment() in
 blk-crypto-fallback
Message-ID: <YHiX2kLiwH+8kQ9K@gmail.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-6-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:06PM +0000, Satya Tangirala wrote:
> Make blk_crypto_split_bio_if_needed() respect
> bio_required_sector_alignment() when calling bio_split().
> 

A bit more explanation would be helpful here.  Does this fix something, and if
so what is it and under what circumstances?

- Eric
