Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFDCC433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9109861152
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhDOTVo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234863AbhDOTVo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 15:21:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE9AB61139;
        Thu, 15 Apr 2021 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618514481;
        bh=ZauktqtvUFNKTTNi5nrXkKpa4N3m/DBZfGw8y1tCB88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KG+P7kI9lYjUe1L10cJBj2/qGFRDXbzfonnc68VS4+SJ7LkEbwtSZ5loR22b9p3lH
         0/YPRGFm65Q/TcdeofvHi9woaa5nNa9IJC8KXLL9WAELHO5jNNUpW3m6STEEignJQw
         WoHq0QB2vL5galdBu66jgU6V7FUTEDHJPRGR4THIrHjrIlwSmniqaTkFRhJD6nO3rC
         2XNYqsS3uoeKl1DZO7s5kyNimV1ocRdx8hq2cQOre62eivhdmkabui/Sid3OK3GOuC
         0tBVjxshcnxQk0r1QK/j9qR8x0e/qYCD9NDO3x5nXu5+qpQbjF69HMo2sl0IypN8fv
         tcDws6DuG791w==
Date:   Thu, 15 Apr 2021 12:21:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/8] block: introduce blk_ksm_is_empty()
Message-ID: <YHiSHnZRZYLbSCB4@gmail.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-2-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:02PM +0000, Satya Tangirala wrote:
> This function checks if a given keyslot manager supports any encryption
> mode/data unit size combination (and returns true if there is no such
> supported combination). Helps clean up code a little.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/keyslot-manager.c         | 13 +++++++++++++
>  drivers/md/dm-table.c           | 11 +----------
>  include/linux/keyslot-manager.h |  2 ++
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index 2c4a55bea6ca..2a2b1a9785d2 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -437,6 +437,19 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
>  }
>  EXPORT_SYMBOL_GPL(blk_ksm_destroy);
>  
> +bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
> +{

I agree with Christoph that this could use a kerneldoc comment.

> diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
> index a27605e2f826..5bf0cea20c81 100644
> --- a/include/linux/keyslot-manager.h
> +++ b/include/linux/keyslot-manager.h
> @@ -117,4 +117,6 @@ bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
>  void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
>  				 struct blk_keyslot_manager *reference_ksm);
>  
> +bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm);
> +

It's easier to read if declarations are kept in the same order as the
definitions.

- Eric
