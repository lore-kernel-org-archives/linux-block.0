Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33390C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 19:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE20064EDC
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 19:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhBJT4U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 14:56:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhBJT4T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 14:56:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6720364EE6;
        Wed, 10 Feb 2021 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612986938;
        bh=ElHjRVDpTBGUt44dTaqqIQgE/uiYoro9zAeSbmvpjO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FKdzL3VUubLm16LA7nGgWiHA7wUTtWeudA77EbB1KZK6YT8yftZlvYeee8I16GWUU
         QMu8VSPPW5hdNddTx/Xl/4t+f/PhvloatKpTHKihs/a6m1WFt3xz8tHl5M6011i0Z6
         PynruIaekTHNVekiG1ZOoivuL1zSnvwPae4GIXbhmq1ra+gHrmWUK6ZEL4vn8tMFUm
         /Ri8lH6PogA/pOhX5AdRrUQoMxeS6DU+rlSPPIahMPlQ+zTDmr4iestS1PRAFRl1YC
         47wuzJXImXWVdWXz2znyYWb1seWpTpAkcyfAzNcGc3JFhNZ73pjiOT0hcz8isxcGZM
         kbSH5TvKDgDiA==
Date:   Wed, 10 Feb 2021 11:55:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 2/5] block: keyslot-manager: Introduce functions for
 device mapper support
Message-ID: <YCQ6OBExblohlnfO@gmail.com>
References: <20210201051019.1174983-1-satyat@google.com>
 <20210201051019.1174983-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201051019.1174983-3-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 01, 2021 at 05:10:16AM +0000, Satya Tangirala wrote:
> Introduce blk_ksm_update_capabilities() to update the capabilities of
> a keyslot manager (ksm) in-place. The pointer to a ksm in a device's
> request queue may not be easily replaced, because upper layers like
> the filesystem might access it (e.g. for programming keys/checking
> capabilities) at the same time the device wants to replace that
> request queue's ksm (and free the old ksm's memory). This function
> allows the device to update the capabilities of the ksm in its request
> queue directly. Devices can safely update the ksm this way without any
> synchronization with upper layers *only* if the updated (new) ksm
> continues to support all the crypto capabilities that the old ksm did
> (see description below for blk_ksm_is_superset() for why this is so).
> 
> Also introduce blk_ksm_is_superset() which checks whether one ksm's
> capabilities are a (not necessarily strict) superset of another ksm's.
> The blk-crypto framework requires that crypto capabilities that were
> advertised when a bio was created continue to be supported by the
> device until that bio is ended - in practice this probably means that
> a device's advertised crypto capabilities can *never* "shrink" (since
> there's no synchronization between bio creation and when a device may
> want to change its advertised capabilities) - so a previously
> advertised crypto capability must always continue to be supported.
> This function can be used to check that a new ksm is a valid
> replacement for an old ksm.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Looks good, you can add:

Reviewed-by: Eric Biggers <ebiggers@google.com>
