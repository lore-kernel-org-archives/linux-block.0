Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3CC4320A
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF93460ED4
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 16:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhGWQEn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhGWQEm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 12:04:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD46B60EBD;
        Fri, 23 Jul 2021 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627058716;
        bh=DCcYUhBN/737aTy/w/vrXuMyRYz7QjGGz7hfxsJhhFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lu2zJXhr0k9Gfk5WPnIoMhcKDxqOVITDg1Gfvx/Tr+8lMKn3vgrZutMbnieSOCGxD
         +dyPCY/qAv19ummAKph9IgAMJUp25CeNMWgOMvQbGWGAJ/ZDioBTCPJwv+Uxl4bTmF
         BzCOS0eosEwRITSmj99shWbrSq5x6fc/Fz8KX6dR0lUo908OSQVvHXljHHyu1i4uA3
         53cl+TumNk9Mh9+mmH12UF8CmmUaJiKxTCx9OigvH6UAuY2ROcsKT/e00KIiW5dVZE
         YykP6JYW85PsWLKb5lxJexThFanaTU0I2coCFVQQf7YhhoKViWWTMgcU0OV2AVsr0f
         C5MYCjp4/dNkQ==
Date:   Fri, 23 Jul 2021 09:45:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v4 1/9] block: introduce blk_ksm_is_empty()
Message-ID: <YPryGi2NNlcISOjQ@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <20210707052943.3960-2-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-2-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:35PM -0700, Satya Tangirala wrote:
> From: Satya Tangirala <satyat@google.com>
> 
> This function checks if a given keyslot manager supports any encryption
> mode/data unit size combination (and returns true if there is no such
> supported combination). Helps clean up code a little.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/keyslot-manager.c         | 31 +++++++++++++++++++++++++++++++
>  drivers/md/dm-table.c           | 11 +----------
>  include/linux/keyslot-manager.h |  2 ++
>  3 files changed, 34 insertions(+), 10 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
