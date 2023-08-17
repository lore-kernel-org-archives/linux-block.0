Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A4C3DA4E
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 16:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353423AbjHQQB0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353415AbjHQQA6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 12:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258F30E9;
        Thu, 17 Aug 2023 09:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4ECB6293C;
        Thu, 17 Aug 2023 16:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17746C433C8;
        Thu, 17 Aug 2023 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692288056;
        bh=7q34eH4rPK+YptiiNrbK2ngkqEU1Twj0WP3fj7nVHh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2XWH9jGq2qV/sPJNUHVQPg9+SVwc2njdp5bC4MMV5jS3MlqdHdVGw/jAxqh6ulJo
         JIufTlcPvFVRZoyYf2p1AMbGMgZqhfdgknDPFCUvMka9PrOVu/2HOe9v1f7pZ8dNM/
         ewZd38j6EXOKzqEH6pIeTD1vqFYmQb46wjDuSigr14HfGrghJe/dAMu7F9Zvu6tMOU
         vrNZQ2iofkDAABKf+u6KaUU8pOxeBPIx9IWPOkJnqp+jFvNYedeFIIs+m3/hAzMZg0
         SxeR1iYqFqjblStp23M/OnSwr4i93OiUbJRnNCDW/tKj22ft5zi4CHYcbXt8tXXV+t
         0efFQfXSBUnqQ==
Date:   Thu, 17 Aug 2023 09:00:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v5] blk-crypto: dynamically allocate fallback profile
Message-ID: <20230817160054.GB1483@sol.localdomain>
References: <20230817141615.15387-1-sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141615.15387-1-sweettea-kernel@dorminy.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 17, 2023 at 10:15:56AM -0400, Sweet Tea Dorminy wrote:
> blk_crypto_profile_init() calls lockdep_register_key(), which warns and
> does not register if the provided memory is a static object.
> blk-crypto-fallback currently has a static blk_crypto_profile and calls
> blk_crypto_profile_init() thereupon, resulting in the warning and
> failure to register.
> 
> Fortunately it is simple enough to use a dynamically allocated profile
> and make lockdep function correctly.
> 
> Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
> v5: added correct error return if allocation fails.
> v4: removed a stray change introduced in v3.
> v3: added allocation error checking as noted by Eric Biggers.
> v2: reworded commit message, fixed Fixes tag, as pointed out by Eric
> Biggers.

Reviewed-by: Eric Biggers <ebiggers@google.com>

Thanks,

- Eric
