Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E3EEB64DC
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 05:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFUFzD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 01:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUFzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 01:55:02 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37A11718;
        Tue, 20 Jun 2023 22:55:01 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qBqnz-0019pT-Fa; Wed, 21 Jun 2023 07:54:59 +0200
Received: from p57bd9486.dip0.t-ipconnect.de ([87.189.148.134] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qBqnz-0028RY-84; Wed, 21 Jun 2023 07:54:59 +0200
Message-ID: <29a4b7210abd927e78b9c576f9283403f494e555.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v13 0/3] Amiga RDB partition support fixes
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        fthain@linux-m68k.org
Date:   Wed, 21 Jun 2023 07:54:58 +0200
In-Reply-To: <5707655.DvuYhMxLoT@lichtvoll.de>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
         <168729291463.3788860.17194611750755016861.b4-ty@kernel.dk>
         <5707655.DvuYhMxLoT@lichtvoll.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.134
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2023-06-20 at 23:16 +0200, Martin Steigerwald wrote:
> Jens Axboe - 20.06.23, 22:28:34 CEST:
> > On Wed, 21 Jun 2023 08:17:22 +1200, Michael Schmitz wrote:
> > > another last version of this patch series, only change
> > > in this version is in the patch 2 subject (to better
> > > reflect what it's about), and adding Geert's review
> > > tag to said patch.
> > > 
> > > I hope I've crossed all i's and dotted all t's now...
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/3] block: fix signed int overflow in Amiga partition support
> >       commit: fc3d092c6bb48d5865fec15ed5b333c12f36288c
> > [2/3] block: change all __u32 annotations to __be32 in
> > affs_hardblocks.h commit: 95a55437dc49fb3342c82e61f5472a71c63d9ed0
> > [3/3] block: add overflow checks for Amiga partition support
> >       commit: b6f3f28f604ba3de4724ad82bea6adb1300c0b5f
> 
> Wonderful! Thanks to everyone involved! Thanks to Jens for applying it! 
> And special thanks to Michael for going through 13 iterations!

Amazing. Thanks to everyone who worked hard to get these fixes in!

Serious motivation booster for me to do more work on retro Linux ;-).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
