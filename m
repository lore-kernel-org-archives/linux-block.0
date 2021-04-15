Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDADC433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC11C610EA
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 19:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDOTd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 15:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234506AbhDOTd2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 15:33:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58ABC610EA;
        Thu, 15 Apr 2021 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618515184;
        bh=pmEpC+vDwdqGGg9r8ZJX9nLfrlZ2KwOgLUu2CwzCg8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlttjChmO1Bls6od5POk8j49Yd6/WKgmF/RQxekWWT2G4YDlg4ksIfBiub3Au4AD6
         +dMbd7oExE5xJduGozCjLZK859Z3iqbXH38sXYIM1LcID48PzM7v1MEgcxszgfZ7+5
         di1N4OYMuHNX38+e1rVZWen6cu+5St3CbTfXgYJekbEHfvOU4CcBCY0tEtPYFadDbJ
         AVF4qtidffwzk8jSAZ/pvLWJ3R5ZSiXSMKF86bpT9eXR8+O7KjhXMQJXe7FB3rV7yR
         qGQE8Fn1Ye1MPoshT9LulWVI+YAunbJv6Dbm3TpsJN0Dm1ZB5IJMle6TDv/mVOCWAf
         FU7TJLezFJ7+g==
Date:   Thu, 15 Apr 2021 12:33:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/8] block: blk-crypto: introduce
 blk_crypto_bio_sectors_alignment()
Message-ID: <YHiU7lbBO3aqUIuV@gmail.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-4-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:04PM +0000, Satya Tangirala wrote:
> The size of any bio must be aligned to the data unit size of the bio crypt
> context (if it exists) of that bio. This must also be ensured whenever a
> bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns
> the required alignment in sectors. The number of sectors passed to
> any call of bio_split() should be aligned to
> blk_crypto_bio_sectors_alignment().

"should be aligned" => "must be aligned"?

> +/*
> + * Returns the alignment requirement for the number of sectors in this bio based
> + * on its bi_crypt_context. Any bios split from this bio must follow this
> + * alignment requirement as well.
> + */

It would be helpful to expand this comment a bit to explictly mention that the
size of the bio must be a multiple of the crypto data unit size that was
selected by the submitter of the bio, which is the granularity of
encryption/decryption.  Keep in mind that people reading this code won't
necessarily be familiar with inline encryption.

- Eric
