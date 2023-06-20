Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF515EB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 21:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjFTVQo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFTVQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 17:16:42 -0400
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326ED1728;
        Tue, 20 Jun 2023 14:16:41 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id D0589702044;
        Tue, 20 Jun 2023 23:16:38 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-block@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        fthain@linux-m68k.org
Subject: Re: [PATCH v13 0/3] Amiga RDB partition support fixes
Date:   Tue, 20 Jun 2023 23:16:38 +0200
Message-ID: <5707655.DvuYhMxLoT@lichtvoll.de>
In-Reply-To: <168729291463.3788860.17194611750755016861.b4-ty@kernel.dk>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <168729291463.3788860.17194611750755016861.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe - 20.06.23, 22:28:34 CEST:
> On Wed, 21 Jun 2023 08:17:22 +1200, Michael Schmitz wrote:
> > another last version of this patch series, only change
> > in this version is in the patch 2 subject (to better
> > reflect what it's about), and adding Geert's review
> > tag to said patch.
> > 
> > I hope I've crossed all i's and dotted all t's now...
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] block: fix signed int overflow in Amiga partition support
>       commit: fc3d092c6bb48d5865fec15ed5b333c12f36288c
> [2/3] block: change all __u32 annotations to __be32 in
> affs_hardblocks.h commit: 95a55437dc49fb3342c82e61f5472a71c63d9ed0
> [3/3] block: add overflow checks for Amiga partition support
>       commit: b6f3f28f604ba3de4724ad82bea6adb1300c0b5f

Wonderful! Thanks to everyone involved! Thanks to Jens for applying it! 
And special thanks to Michael for going through 13 iterations!

Best,
-- 
Martin


