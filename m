Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C451C433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 10:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiERK4p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiERK4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 06:56:44 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CE73B2B5
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 03:56:43 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id z6so1470816vsp.0
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 03:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Sz7hlVSiOpryf5X4ndXXbgt2YPT72riXusbLpYq9A8w=;
        b=h00aUilHmOvDAlMp9vrtNb67aHEi7v/uSMBpJ3mvz0sarpZHmXcz48T++TDvgsnKSF
         +yDSkLGIfJogdQkpO+xcgrgIjaourdFtV2rIGxWv1yxIhtkmR6JhscxrNw7XmEZPtXRK
         BVGgL9LAyXCvAZtFLkjuGc/45RBhb+wp+frnGeLYU3uGqle4QsstOTVI6X0Ca5AfEo08
         iusFFJ5SY2fYQynonw47dO2ta2ehCnmuW4vfBn/i9NcCIb+cp/heL5aZc5mE/BeoWiNf
         ZQ01WxqdRTzLjubK9DM7BAFGGuXvnn+D9st8h66w9DVNUg14XCxRYYrkbmZrpz2ChVXv
         fkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Sz7hlVSiOpryf5X4ndXXbgt2YPT72riXusbLpYq9A8w=;
        b=Ab/UYPJIA/O4V0oiJROgFXcqbwTcipsm4azQDhFejjJIBesMPdI2mHborNPqa1OnWr
         757KOMuoQ54a3mxWi3uBaqBtMxSDUO3k+dYQUbIcEElJb/JsBQxNCK6lFu7S0kKgL2J4
         h3Ebcfq7Eq/tO/Y6vT8qTK13ooQOdW51NzXf4FXalucXHA5b3ivQAvCq4uFJoVxkcmUD
         7iTFP0X1LVDr3VCKV+3thPKa/qmSB75TKPaUivojumHIgTvyu443qVm1ya7kQtGL6wht
         1FibnKullZm2BKNqBK4bAbL5e0QRlKvcDcTzG3QXISBoAQ3kiQrlpAfKFY4igNfQnObA
         sjPA==
X-Gm-Message-State: AOAM532gBcHoktMreMYHJu09WJS2/4ahhBO8708sRy8eFDWZvZxiZm1v
        MmTlqT3Q7l94D4lDrxF9gWwUem1t8+L8ySAKiK16+P/261Cfg1qV
X-Google-Smtp-Source: ABdhPJzbRAtK39wPQFYz8+CbcSQkbQHGHSKm9MS/SYfz0Rl7CHH/1yjeqQrmQo5n5iFEjJWIaqoPN0zApaAzI0d2OZ4=
X-Received: by 2002:a67:e157:0:b0:335:cfe9:3c02 with SMTP id
 o23-20020a67e157000000b00335cfe93c02mr1344386vsl.0.1652871402491; Wed, 18 May
 2022 03:56:42 -0700 (PDT)
MIME-Version: 1.0
From:   Jasper Surmont <surmontjasper@gmail.com>
Date:   Wed, 18 May 2022 13:56:31 +0300
Message-ID: <CAH4tiUssBd1vKjUMtbNcmHt8X+-TzdgSFCfT=3coZZedGVESsg@mail.gmail.com>
Subject: [Question] Editing a bio write request
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm writing a device-mapper which has to edit incoming writes, for
example: Incoming bio request contains a biovec with a page full of 0
bytes, and I want to change it to all 0xFF bytes.

I tried using bvec_kmap_local() to get the page address, to then read
the data and if needed adjust it using memcpy or similar. Initial
tests seemed to work, but if I execute things like mkfs on the created
dm, I get a lot of segmentation faults. I narrowed down the problem
that this only happens if I actually write something to the mapped
page. However, I see no reason why it should cause this fault as I
(after checking probably 100 times) don't access invalid memory. I'm
wondering whether my method of editing the write is actually correct,
or if I am doing something else very stupid.

Any help is appreciated

Thanks!

Cheers, Jasper
