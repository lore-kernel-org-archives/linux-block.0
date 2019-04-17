Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A6C10F14
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 01:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F1520821
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 01:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDCyKxAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfDQBf7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:35:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45861 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfDQBf7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Apr 2019 21:35:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so29581374wra.12
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2019 18:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hk8oBh8IR2y1WgQpK7lqPC2YhZQ2mFQ1h6PxsNn/E54=;
        b=aDCyKxAfjAdCY61m5GPhcFYL+310hfsl80aEE/y/V+1u1yzQOzCAKbvGV2/JlYrhAU
         qgAoHMPCXx4lTOeSDHXUt1ze1YWjs72lAEK+K4OqNJ20yyi1W/CZYF/2Ob50N+AfAJf7
         LiIKjUXFmc7B93oRRs1jsRUWgGPs3bOP5jL2AO6u2gZPPoMJLK3KdbfZEFxMDoS3zOcl
         LvrbAhUshQOoOV5GG2owyTHVivRTDdtVR3U1dqaJYZ6YRXhshYJbOKjBdbehd2SV6lYC
         A2YfpFm8GAh5zFcv2aZgiHXxllX0VSGkYIsd9qnTCBtoMhItmoy6zzyV5g39kQ7FrVny
         Qokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hk8oBh8IR2y1WgQpK7lqPC2YhZQ2mFQ1h6PxsNn/E54=;
        b=stH0EXW7Qouuq1ivDYusKFnwydyKwaPDfQZNryP1WDwuWGzeXAAGYQCwYKTGYqmBTF
         yDThtaZ1E5EYbIpxZpTcEiNjmb25cxRs0bFdPdE1uwZNXos8NWdRXNODm5izFB0tIkuf
         oIG20EwceVIJfZehO310R3d4Ha1dSzd08VWONgBCnuseA3dBL1Iz7fatQ80s54EYq6Ur
         G0dj2DiBc3k+2LnSGkU2MntzmquezyujZkJ1FomVWp84T6y9rS3AYh71pqo0O1gfBKv5
         JWsOPnvREJJvktR5xuRrlM6gJT1BAdkkaSPZw6EupTRLhclZR4IR9K3lMi/MN8ueKxMt
         DLpQ==
X-Gm-Message-State: APjAAAVEXsPyjqDyO3f1qKjz7A32s744gq5lpK/wkHj37iIeHAQU2C0O
        kp8lWDO44M8QIWNVeEEXpKB4szC029CBlGnIJHI=
X-Google-Smtp-Source: APXvYqwjYuo7KncMCWppQSnGGIL675Yo8fH180HWZvVQfAERE6bo0GVdwj0LjjXhAc/1RZpxS/gdAR4qrLCZ9sWL3eA=
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr53134912wro.170.1555464958068;
 Tue, 16 Apr 2019 18:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
In-Reply-To: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 17 Apr 2019 09:35:46 +0800
Message-ID: <CACVXFVPKHUgbgsbFZSDWqF7GTPyBzKJjKCSq7EYygre_GvpbyQ@mail.gmail.com>
Subject: Re: Adding QCOW2 reading/writing support
To:     Manuel Bentele <manuel-bentele@web.de>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Wed, Apr 17, 2019 at 5:33 AM Manuel Bentele <manuel-bentele@web.de> wrote:
>
> Hi everyone
>
> I'm going to implement an in-kernel reading of QCOW2 images.
> In the project, I only need the reading of QCOW2 images, but it's
> essential to make thoughts for the implementation of the writing, too.
> One of the difficulties seems to be the support of making an image
> sparse (resizing the disk image).

Could you describe this requirement in a bit more detail? Especially why
do you want to read/write QCOW2 in kernel?

>
> Now, I want to ask you for advice: What is the best approach to achieve
> this?
>
>   * Implement the reading/writing in the device mapper?
>   * Extend the loop device?
>   * Create a new subsystem for the processing of sparse devices or images?
>
> Or do you have any other idea?

The 1st idea is that if this feature is really good requirement.

Thanks,
Ming Lei
