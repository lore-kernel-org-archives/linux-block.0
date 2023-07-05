Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76496EB64DD
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 21:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGEVdn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjGEVda (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 17:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E631BC3
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 14:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E6D361477
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 21:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0B9C433C8;
        Wed,  5 Jul 2023 21:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688592808;
        bh=Vio6YIpx/Epwjrsn4YSHIveNlucIb1ePVf4IGMf4qv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6jJ2SdHUSrcAK8rbiHtmRUaS8euSqbxDp7yQOsqKc3M8LixlcGAQjnVMdYGNuStm
         uNXaii0qxXV+MhAKyVjlqRb58HWlg7+9gZqixC1EWeIO08GVKNG7PwAQ9OZAX2iIOP
         pLAHZQkbEeh5d8oZPWqAknbuUhcN17rwnmGfPQZ9NLXraNaxgx/8FhG3jXw30oOXCZ
         kej8gWv0hExhS95am+laFYsqZ6tQrIbZVipBspGqcrwB2WvIAuOSuEcmn8vyM41Ktr
         YHaswTrcAFWVktcNi2tsJgSFSXSqBN05pr0rME7hzvyRziabB9dBWFHKMcv/CrMkOR
         fx3tdRx5swgpA==
Date:   Wed, 5 Jul 2023 14:33:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] blk-crypto: use dynamic lock class for
 blk_crypto_profile::lock
Message-ID: <20230705213326.GC866@sol.localdomain>
References: <20230610061139.212085-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610061139.212085-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 09, 2023 at 11:11:39PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When a device-mapper device is passing through the inline encryption
> support of an underlying device, calls to blk_crypto_evict_key() take
> the blk_crypto_profile::lock of the device-mapper device, then take the
> blk_crypto_profile::lock of the underlying device (nested).  This isn't
> a real deadlock, but it causes a lockdep report because there is only
> one lock class for all instances of this lock.
> 
> Lockdep subclasses don't really work here because the hierarchy of block
> devices is dynamic and could have more than 2 levels.
> 
> Instead, register a dynamic lock class for each blk_crypto_profile, and
> associate that with the lock.

Jens, can you apply this?

- Eric
