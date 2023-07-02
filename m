Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5F8EB64DA
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 09:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGBJhs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 05:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJhr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 05:37:47 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD5E4D;
        Sun,  2 Jul 2023 02:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688290478; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YBC3GsBZnLsiH20jXus5imV3J8DGwKe+ZfT47aEtlBNxpc+0FZCDThIj7a4XVFV87z
    RNYqxbQ9K9gSRs02fWPeqUPWDDBZWGCSUN2h4/sNLgLvtAZUI4FOYvwykOJ+IGlPxR6Z
    9v6EGttmvuoowJQ4PAefV7J7HmIQcoRnTEHu7fhZpbhGtmAvcoauF8eenLEpgiQqVuzE
    H+iTzwW0X06pmYzZ1slhIw+nxjtgklpzItaDo0crdoezhu0gBq1ukN6UnxYVKpYeDVL8
    nVeJk12EHiaOCJSufSqZHFhFoQAVUBvKJSdVKOiWKR7A0LV8re4Ua9GALxzesRT3l1UL
    4n5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688290478;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=uagJCPl0psGe6wX8+/gWnLaLqW5o2/YItSWw9RajNAY=;
    b=efxZHirrqeVKTHHjSYy3WvWGyDnEbuLn9S95Wk87BU8gogqCRNB83hvV5k15JSHxoY
    42nzkCtoFLNy/Y5GvsEYQnLJAFIbg61paeSQnn5ZxfngKVtpAOrTFXT9klb6c/5SAXeS
    Cbmk1kEIvgciis11YHPEttGNPQRSaONjw3vJPqcK/B2zz7uIPKpCAohm8cVtIY6USrEl
    0UY3axWqS1Pu6kmtI/jmAsanHEsJvbv21cL+dmxgEmwe0tL9yL0AozwVf95seTkO7Bgv
    Fj4zcp5+fW6XHuWLsZOs08chti/xo9KbVQmtjBOrIFFc128InzJRLqzJiyO5kTbjNI5j
    92Hw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688290478;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=uagJCPl0psGe6wX8+/gWnLaLqW5o2/YItSWw9RajNAY=;
    b=VsZeYD9I8ewt9wI4XnF5ArWxmb1Zd6+QcoSR+7jZ/dnv6fNtn8iqGfjXxH6MFbYdZm
    sZnm6+teKglYrixjZWdejthXtQ1wpf+oKfF+ukuzJO65lXdO/ufhd0RSyfu2+Bod944Q
    95lK6rbuQw+ysXUH34/SP4Q4HxLwvx0ZD8S56VKOfGOwRs92jUmLEG8Ms4ULitDm5U3a
    8PAnIhYaU4j5c2cpjuPJmOxN/uEFBhUamaGT+/73z4fH33nanvQbJYJgqHDv/6WuTm/q
    cegFtQysJ/CqxZdnlhoofoF4KRUoA1Lhhcp8R8eZ2NlAg//o0neVFmYxRjEyZqYrIWeG
    LGZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688290478;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=uagJCPl0psGe6wX8+/gWnLaLqW5o2/YItSWw9RajNAY=;
    b=ndB6X20wh9l9S2d6FtqcjzW5vRMvUsI8qpEKrI16okUzaS9i+td78DZIwSNCoLdlR1
    1m9hPtBdfaglOKfYjqBA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7Vpnhs32SXHk3YqbIfEt/IICE6JpT87oBSUz4GQ=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z629Yctcp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 2 Jul 2023 11:34:38 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Sun, 2 Jul 2023 11:34:27 +0200
Message-Id: <9785707F-E415-4E04-A8E5-AD984CE16AA0@xenosoft.de>
References: <3C36662C-78A3-4160-93AB-3E28A246AFCE@xenosoft.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <3C36662C-78A3-4160-93AB-3E28A246AFCE@xenosoft.de>
To:     Martin Steigerwald <martin@lichtvoll.de>
X-Mailer: iPhone Mail (20F75)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2. Jul 2023, at 10:56, Christian Zigotzky <chzigotzky@xenosoft.de> wrote:=


=EF=BB=BFOn 2. Jul 2023, at 09:55, Martin Steigerwald <martin@lichtvoll.de> w=
rote:

How many end users are you speaking of?

Back then I thought I was the only one using a hard disk with mixed=20
Amiga/Linux RDB setup.

Best,
--=20
Martin

=E2=80=94-

A lot. :-) I am speaking about the new A-EON machines.

=E2=80=94-

The end users have to fix their  RDBs if they want to use the new patched ke=
rnels.

But a normal user can=E2=80=99t edit the RDB manually. What can we do for th=
e end users?=

