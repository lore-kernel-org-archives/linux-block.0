Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20C3C4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 16:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF9360E73
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 16:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGWQFo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhGWQFn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 12:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03BDC60E73;
        Fri, 23 Jul 2021 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627058777;
        bh=9sl+gJhcGz9m1lZo33z2vi2L7LSNih/ApFZx1AtmfNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNNi6Egb0TBvU3eqzgXRmi0rFOS1Fdtf4sgDDmmIH0Vz1wGBMg01bzaS9LEYT7X0v
         OaUtqT8tAIqlC+3eUo4rfPbOayqQnd0JefnxIAEExWKufPvoBv0RHIAaXgeSp/Tcpi
         vsS8JFBKmEdV95xtZh/04c19Ok4dCHCSKEpOOTQNYzMB114PM/i6Cytqg/+WF763Cg
         jLNhwGpw1AywNwnIPisf/dH5eRM7XClbgkrP6SSET0MVTHLudrwFbOqKOLbWc6oX3D
         4yhLEGwKqwTanEtcxeNeOkW2Ds7eUV95Nvu+em8b9b4mmRamSq0wakQX0AM5Dijr85
         qPTBnLnh5UauQ==
Date:   Fri, 23 Jul 2021 09:46:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v4 3/9] block: introduce bio_required_sector_alignment()
Message-ID: <YPryVxdMmcFy/fJD@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <20210707052943.3960-4-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-4-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:37PM -0700, Satya Tangirala wrote:
> From: Satya Tangirala <satyat@google.com>
> 
> This function returns the required alignment for the number of sectors in
> a bio. In particular, the number of sectors passed to bio_split() must be
> aligned to this value.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
