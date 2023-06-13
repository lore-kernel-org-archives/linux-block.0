Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D86AC77B7A
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 07:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbjFMHqK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 03:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbjFMHqC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 03:46:02 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 00:45:36 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D761BC9;
        Tue, 13 Jun 2023 00:45:36 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id EE7386F4D8E;
        Tue, 13 Jun 2023 09:25:46 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition support
Date:   Tue, 13 Jun 2023 09:25:45 +0200
Message-ID: <4814181.GXAFRqVoOG@lichtvoll.de>
In-Reply-To: <2b924d0b-f278-e422-2a2c-f149265dcf9a@gmail.com>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <cf6a3edc-7f9c-7a70-23b0-edf43769d994@kernel.dk>
 <2b924d0b-f278-e422-2a2c-f149265dcf9a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael, hi Jens, Hi Geert.

Michael Schmitz - 22.08.22, 22:56:10 CEST:
> On 23/08/22 08:41, Jens Axboe wrote:
> > On 8/22/22 2:39 PM, Michael Schmitz wrote:
> >> Hi Jens,
> >> 
> >> will do - just waiting to hear back what needs to be done regarding
> >> backporting issues raised by Geert.
> > 
> > It needs to go upstream first before it can go to stable. Just mark
> > it with the right Fixes tags and that will happen automatically.
[…]
> thanks - the Fixes tag in my patches refers to Martin's bug report and
> won't be useful to decide how far back this must be applied.
> 
> Now the bug pre-dates git, making the commit to 'fix'
> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ... That one's a bit special,
> please yell if you want me to lie about this and use a later commit
> specific to the partition parser code.

After this discussion happened I thought the patch went in. However… as 
John Paul Adrian asked in "Status of affs support in the kernel and 
affstools" thread on linux-m68k and debian-68k mailing list, I searched 
for the patch in git history but did not find it.

So did it go in meanwhile?

Ciao,
-- 
Martin


