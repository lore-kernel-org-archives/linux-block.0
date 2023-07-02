Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4458EB64DD
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 10:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGBKeO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBKeO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 06:34:14 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7974D1AC;
        Sun,  2 Jul 2023 03:34:12 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 7C3D472AE5F;
        Sun,  2 Jul 2023 12:34:08 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Sun, 02 Jul 2023 12:34:07 +0200
Message-ID: <2918626.e9J7NaK4W3@lichtvoll.de>
In-Reply-To: <9785707F-E415-4E04-A8E5-AD984CE16AA0@xenosoft.de>
References: <3C36662C-78A3-4160-93AB-3E28A246AFCE@xenosoft.de>
 <9785707F-E415-4E04-A8E5-AD984CE16AA0@xenosoft.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

Christian Zigotzky - 02.07.23, 11:34:27 CEST:
> A lot. :-) I am speaking about the new A-EON machines.

Ah yes, that is what the PASEMI is about, I did not recall initially. So 
far I decided to skip on these.

I agree with John that a small shell script could do the trick.

However I still do not understand the issue fully. So I have no idea 
what would be the best approach there.

Best,
-- 
Martin


