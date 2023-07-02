Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29313EB64DD
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 08:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjGBI5d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBI5c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 04:57:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E51A2;
        Sun,  2 Jul 2023 01:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688288218; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SdqprHJt21sDmlqOOIZsFaDzXFYoiPXO8mnsh2dLDLA9SmW0pw6BWDvO5dUUIt2ggy
    /KAGP5IHIynOV2xVjMYKxscR6S97R8HmpapuVy/dqONGwW9VaRYoHpD/akZbkMf/ekUg
    ipp8t1kYZLpxw5lX7MoEEGEjCNKdNDZygoHHCT+jR9OVedXXijBJ2gVhZk6/RNWI9iR6
    SnXRaKHg8SZ588fqhg7mJpbbzEvvWvc+fSBBv59HCEPSjNvvDjWQDAdZOcbuLKOE/65Q
    q2o/jpKe4eRFIaMmI5aTM+PsrwIBPypEWc8VdZCHPxYaBD6y4zRtZcEnBfwLX0AeojJW
    dC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688288218;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ZOaNrtIxqZNKQfZOurFdGFYTBnieac1RhMNNniiQXt8=;
    b=RFx76wg3qRPrNHyd9h7WgJP5vspcM25zfojXMC6CM69815YWwLo5WZ0Waaxg1FElnS
    axGC406jFmkJR1sdP/4AV82wK+oRvFlp1UinAk5ga9uB+7i60hWKbejYwbOkNjWGtcJ0
    YyhCrouga0Ot12tEqQoK+k5+H+GJ+y0IxFePwe+DPVIcSFOBEaV0uCJauTilOd+2dNGI
    sniuzVOSvoxy/dFwS6LrWQDsdqg2NxRMqZFZHbK4R0vTux9kwwiZsi/EbjnZwwCdm1DR
    RIAWKpywQ5hgbVDjKkgF/A6wKY7onAmREmyGWc2pxpPOzJjqPwRPnNyqLsjifI5o1JFE
    2+Bw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688288218;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ZOaNrtIxqZNKQfZOurFdGFYTBnieac1RhMNNniiQXt8=;
    b=BuNPnyonYTTNxPUwltTNCxjrWr+UmZHtwPfhAWPM2DQfGyR/m/aVBHR2d8VzOjn7T5
    jllylba/q9SlNS0baSkT3baYw1O3WTDx+1jYWnG5HGXwkq1PRbzXbzq4sKPUeuQs73M7
    /Zkf091pHdEle34SGZLJI+zPYY4ZlGf/Xe3CJ7JuKppsatubKATEgQkrckY73m6GSCsJ
    wDpjbvZGzEyP58zaXXrX0fzDliWAsP7wei3mpEoBcDX/py0tOolbpeAHpiu9msckktsW
    ZZbt4y1R2NO47bCZ2zIvS7VooR4vVSODv7OhmD4P2YTGH9oMlPAan/TKi2RP6D1CqTZO
    Q7ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688288218;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=ZOaNrtIxqZNKQfZOurFdGFYTBnieac1RhMNNniiQXt8=;
    b=C2gmYy7gc/V2P7moJxVLyEPCzqAf9wm6Py/CBJ6vhEkOJ5mUp3YRb4ta6S93Q56cZR
    icpuOAgpHUp39RNfpyAw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7Vpnhs32SXHk3YqbIfEt/IICE6JpT87oBSUz4GQ=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z628uwta9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 2 Jul 2023 10:56:58 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Date:   Sun, 2 Jul 2023 10:56:47 +0200
Message-Id: <3C36662C-78A3-4160-93AB-3E28A246AFCE@xenosoft.de>
References: <1885875.tdWV9SEqCh@lichtvoll.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <1885875.tdWV9SEqCh@lichtvoll.de>
To:     Martin Steigerwald <martin@lichtvoll.de>
X-Mailer: iPhone Mail (20F75)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2. Jul 2023, at 09:55, Martin Steigerwald <martin@lichtvoll.de> wrote:

How many end users are you speaking of?

Back then I thought I was the only one using a hard disk with mixed=20
Amiga/Linux RDB setup.

Best,
--=20
Martin

=E2=80=94-

A lot. :-) I am speaking about the new A-EON machines.=

