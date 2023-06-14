Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10632EB64DC
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 07:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbjFNHVl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 03:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbjFNHV1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 03:21:27 -0400
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B12956;
        Wed, 14 Jun 2023 00:20:29 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id E9A4E6F6D00;
        Wed, 14 Jun 2023 09:19:44 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        Joanne Dow <jdow@earthlink.net>
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition support
Date:   Wed, 14 Jun 2023 09:19:44 +0200
Message-ID: <4507409.LvFx2qVVIh@lichtvoll.de>
In-Reply-To: <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <3748744.kQq0lBPeGt@lichtvoll.de>
 <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael, hi Joanne.

@Joanne: I am cc'ing you in this patch as I bet you might be able to 
confirm whether the rdb_CylBlocks value in Amiga RDB is big endian. I 
hope you do not mind. I would assume that everything in Amiga RDB is big 
endian, but I bet you know for certain.

Michael Schmitz - 14.06.23, 00:11:45 CEST:
> On 13/06/23 22:57, Martin Steigerwald wrote:
> > Michael Schmitz - 13.06.23, 10:18:24 CEST:
> >> Am 13.06.2023 um 19:25 schrieb Martin Steigerwald:
> >>> Hi Michael, hi Jens, Hi Geert.
> >>> 
> >>> Michael Schmitz - 22.08.22, 22:56:10 CEST:
> >>>> On 23/08/22 08:41, Jens Axboe wrote:
> >>>>> On 8/22/22 2:39 PM, Michael Schmitz wrote:
> >>>>>> Hi Jens,
> >>>>>> 
> >>>>>> will do - just waiting to hear back what needs to be done
> >>>>>> regarding
> >>>>>> backporting issues raised by Geert.
> >>>>> 
> >>>>> It needs to go upstream first before it can go to stable. Just
> >>>>> mark
> >>>>> it with the right Fixes tags and that will happen automatically.
> >>> 
> >>> […]
> >>> 
> >>>> thanks - the Fixes tag in my patches refers to Martin's bug
> >>>> report
> >>>> and won't be useful to decide how far back this must be applied.
> >>>> 
> >>>> Now the bug pre-dates git, making the commit to 'fix'
> >>>> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ... That one's a bit
> >>>> special, please yell if you want me to lie about this and use a
> >>>> later commit specific to the partition parser code.
> >>> 
> >>> After this discussion happened I thought the patch went in.
> >>> However…
> >>> as John Paul Adrian asked in "Status of affs support in the kernel
> >>> and affstools" thread on linux-m68k and debian-68k mailing list, I
> >>> searched for the patch in git history but did not find it.
> >> 
> >> I may have messed that one up, as it turns out. Last version was v9
> >> which I had to resend twice, and depending on what Jens uses to
> >> keep
> >> track of patches, the resends may not have shown up in his tool. I
> >> should have bumped the version number instead.
> >> 
> >> I'll see if my latest version still applies cleanly ...
> > 
> > Many thanks!
> > 
> > Would be nice to see it finally go in.
> 
> My last version (v9) still applies, but that one still threw a sparse
> warning for patch 2:
> 
> Link:https://lore.kernel.org/all/202208231319.Ng5RTzzg-lkp@intel.com
> 
> Not sure how to treat that one - rdb_CylBlocks is not declared as big
> endian so the warning is correct, but as far as I can see, for all
> practical purposes rdb_CylBlocks would be expected to be in big endian
> order (partition usually prepared on a big endian system)?

While I did not specifically check myself I would be highly surprised in 
case anything in RDB data structure would be little endian. Amiga is a 
big endian platform. I'd expect little endian only to be used where 
there was need to interface with little endian platforms – like in PC 
emulators.

It may not be easy to find any confirmation in developer documentation, 
I'd assume that wherever it would not have been stated differently, big 
endian is assumed for AmigaOS.

> I can drop the be32_to_cpu conversion (and would expect to see a
> warning printed on little endian systems), or force the cast to
> __be32. Or rather drop that consistency check outright...

So "be32_to_cpu" converts big to little endian in case the CPU 
architecture Linux runs on is little endian?

Well again… I'd say it is safe to assume that anything in Amiga RDB is 
big endian.

Best,
-- 
Martin


