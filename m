Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0864C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 22:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA664E4B
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 22:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhBKW7W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhBKW7W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 17:59:22 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE235C061756
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 14:58:41 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id k13so4632726pfh.13
        for <linux-block@vger.kernel.org>; Thu, 11 Feb 2021 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amreorW5Wp+rgEfeKxxFdgVmmwkgOKq0HeoNDJfuGV4=;
        b=fTdADRcOOLN4WHK2Zt6UP3ji0Zp3Utp9E9xyVb7aSxKdyCDUFDXgECBkyWNT+nwRn8
         rHNZFEobZ0FVNNcZSJ2c1O7yDS3iXY9Rras9gFtz5URWhATRqQWGskClTm1KPBZy3m0b
         4KTw9JUNTiBisgotkHv7R/Tqbo7lrUYGCdWGcDYhfK1TT7HrkNEtqfmSyVJk20ClVQyR
         IICwGksNJvFntlbkNjSM3qGZyXSaEkI+27gcm8oFnfILOKt3bGXg2f+K1rMIsGx8e9xn
         t0fcrD/sNFjQGeCzHqBruUxo/f3ASwpX3jEAAnvRfyDcEmwan6o1MedRlLRq4aYIjbFJ
         ME0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amreorW5Wp+rgEfeKxxFdgVmmwkgOKq0HeoNDJfuGV4=;
        b=HXvIeGm4+MZpHua09eC3jLnpz3/yPUBs36LUXcvETv4K9h/Ao0zaEsarDmBZiQel3S
         dR5JjRW4TP7sb5AGMQssYaQe3WuT0KUNhxCmug8a7AF4xtMrfKqylxpVkBoI5oGsDfco
         CI0luuT/Fo6CbYCeR4PpLpv1fTBhjx11z+4wvKAuTBdTgqlRwMHSW0IPf1V0aUgxnMvX
         wdwPz1rBpUF4Arwnr9KVk/m1gHopy8Z15ktM9Y39YI+cGgFcSzWP8zxlh0PvdmheoLKJ
         8cGIfal4Tj2P3lXyJVa24u791Mwm7wcKf5//S75awP6+7ZBCW2Tuvf2mTGgXnn4Vl52O
         0m7w==
X-Gm-Message-State: AOAM531TlfyzeFiH9ax2G4XijyGiOsUaHvR+FVwVP4aY6sLG+Ebb84pC
        yaalXLMsl++NMXxIH0OeX/ln49/aXU2oaQ==
X-Google-Smtp-Source: ABdhPJyoyyDeZHN2igF/Aa4CBWlQghor7IDCot2l7wTM7pQVHEvTAoANtTfktIz6cSZNPRruC+6nHQ==
X-Received: by 2002:a63:fe13:: with SMTP id p19mr370840pgh.119.1613084321254;
        Thu, 11 Feb 2021 14:58:41 -0800 (PST)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id o14sm7499206pgr.44.2021.02.11.14.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 14:58:40 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:58:37 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v4 3/5] dm: add support for passing through inline crypto
 support
Message-ID: <YCW2nWmHCunU1DwV@google.com>
References: <20210201051019.1174983-1-satyat@google.com>
 <20210201051019.1174983-4-satyat@google.com>
 <YCQ/WjAsVA2gdb7d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQ/WjAsVA2gdb7d@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 10, 2021 at 12:17:30PM -0800, Eric Biggers wrote:
> On Mon, Feb 01, 2021 at 05:10:17AM +0000, Satya Tangirala wrote:
> > Update the device-mapper core to support exposing the inline crypto
> > support of the underlying device(s) through the device-mapper device.
> > 
> > This works by creating a "passthrough keyslot manager" for the dm
> > device, which declares support for encryption settings which all
> > underlying devices support.  When a supported setting is used, the bio
> > cloning code handles cloning the crypto context to the bios for all the
> > underlying devices.  When an unsupported setting is used, the blk-crypto
> > fallback is used as usual.
> > 
> > Crypto support on each underlying device is ignored unless the
> > corresponding dm target opts into exposing it.  This is needed because
> > for inline crypto to semantically operate on the original bio, the data
> > must not be transformed by the dm target.  Thus, targets like dm-linear
> > can expose crypto support of the underlying device, but targets like
> > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > 
> > A DM device's table can only be changed if the "new" inline encryption
> > capabilities are a (*not* necessarily strict) superset of the "old" inline
> > encryption capabilities.  Attempts to make changes to the table that result
> > in some inline encryption capability becoming no longer supported will be
> > rejected.
> > 
> > For the sake of clarity, key eviction from underlying devices will be
> > handled in a future patch.
> > 
> > Co-developed-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> 
> I don't see any obvious issues with this latest version.  I assume you've tested
> it on real hardware?
> 
> If it's needed despite my Co-developed-by, feel free to add:
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> 
> A few nits about comments, in case you resend:
> 
Thanks! I addressed the nits, added acked/reviewed-bys and resent v5.
