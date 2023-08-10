Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C2C04A6A
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 04:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHJExJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 00:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHJExI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 00:53:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAEF10C;
        Wed,  9 Aug 2023 21:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D7B064160;
        Thu, 10 Aug 2023 04:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C954C433C8;
        Thu, 10 Aug 2023 04:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691643187;
        bh=6WqbdW5HGyQE9QxGF/BtZzJqHxjXHZs/Ml+TDLDpJWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wNdo26el7rLra4TZwidBgrIWEpbk8h+uUUX4TG0wUakD1fzbIdm8Yjs0/3RkxbJV8
         7fnTd40iBPcfNPt1J8J6nH8lkyTYGv162vatnji9gXtsIhAhzG8LNLY1Xb10oz7YiM
         35fJ1zNDXJ4+e/hGTZPX1lk8bbWNbwJYFctouZZk=
Date:   Thu, 10 Aug 2023 06:53:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
Message-ID: <2023081023-parsnip-limb-dcd4@gregkh>
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
 <94c661a6-442b-4ca2-b9e8-198069d8b635@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94c661a6-442b-4ca2-b9e8-198069d8b635@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 09, 2023 at 04:08:52PM -0600, Jens Axboe wrote:
> On 8/9/23 6:56 AM, Sweet Tea Dorminy wrote:
> > blk_crypto_profile_init() calls lockdep_register_key(), which warns and
> > does not register if the provided memory is a static object.
> > blk-crypto-fallback currently has a static blk_crypto_profile and calls
> > blk_crypto_profile_init() thereupon, resulting in the warning and
> > failure to register.
> > 
> > Fortunately it is simple enough to use a dynamically allocated profile
> > and make lockdep function correctly.
> > 
> > Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> The offending commit went into 6.5, so there should be no need for a
> stable tag on this one. But I can edit that while applying, waiting on
> Eric to ack it.

That commit has been backported to stable releases, so it would be nice
to keep it there so our tools automatically pick it up properly.  Once
the authorship name is fixed up of course.

thanks,

greg k-h
