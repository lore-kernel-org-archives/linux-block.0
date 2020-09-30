Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F153EC4727C
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 00:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF2E206E3
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 00:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTtAuqDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgI3AHH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgI3AHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 20:07:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A681C061755
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 17:07:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so7313894wrl.12
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=ZwPwQM4NSxM/TuLBw+jC6r1tTzxoLRnyinYg/w7w9/o=;
        b=XTtAuqDgDrcrfhSnwj1k69u7Y4U5Cp7n2o1Q77Z9b5OxCvLN+Q/zpn+HXrSH4C5b+W
         xSnBft9ggPGFRlC3eVPg/Rgq5vIXOTh+0LiAfYmy/ovu5dHPb1cFxm1BhoJv0ApmvJK8
         eCqpbtRCz/Z/0Co74oBD4jQB5XoWCH0NkVhGBibbVa25Vx+JAKNKIzHPw53NMb8Ht8h6
         qtCuX768oI/EzpOBDeI2Korz1qO0exHvNVHjndmYbq7F4XHqVhG8jQ2T0kaPixiL5/RO
         bQhJJYfyUIvPhPqz8RDk4e8mSAHNr/LemNSjJgbS/S0XhDb7b/Aj1ph0SVwiN5TXR9sP
         K3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=ZwPwQM4NSxM/TuLBw+jC6r1tTzxoLRnyinYg/w7w9/o=;
        b=WJtmNb78JZrGMBw6QCaY+XYgB0iQQShcd5cC+uqmW79CaQT/S7qm4AnIbBM3lkbuHG
         BACKFQrFMoeSW/GC3XwKVyXqI2FBTwgg2U/hteFUGweQVNATx4WEForLmtMlCItELxUS
         /CfziD6BeZS2wjaBzyhUL6yUAOAuzAXi6xBrWJEUruO0VeG+bIkxPM2d2i6jraPNk+8C
         3XP5PPgSp+jK4nYdU9ZC81PSE0oW522QU9qrIpKe4h654k+5bhTSVd9aRjWVtY81dV4e
         rdZ6DAJTa6VrP8bhfia3PdF3+W3Fb1PXY/i6cpkSpj6BtpGs+e1Yx8U8JNt9Bb8p5KPR
         R/Eg==
X-Gm-Message-State: AOAM530NV8cBmkXyN0fucOgT5X8kUq4BAIJFN4Hote8Ux9vYpQs9GGmC
        c3rKxTsgXB+mMlsxZV7huFg=
X-Google-Smtp-Source: ABdhPJw+6tL6aGUe8+7MB2vdliIkJca//daGL17+K0qEsUupW/kQlhyhuFzP5/TB3TIAKC7TSF2szA==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr6321202wrs.388.1601424424909;
        Tue, 29 Sep 2020 17:07:04 -0700 (PDT)
Received: from localhost ([170.253.46.69])
        by smtp.gmail.com with ESMTPSA id e1sm63171wrp.49.2020.09.29.17.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 17:07:04 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Coly Li <colyli@suse.de>
Cc:     <adrian.hunter@intel.com>, <cjb@laptop.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] =?iso-8859-1?Q?discard=5Fgranularity_is_0_on_rk3399-gru-kevin?=
Date:   Wed, 30 Sep 2020 02:07:02 +0200
MIME-Version: 1.0
Message-ID: <8f461da7-1a49-4288-8b06-020ddaa3dcc6@gmail.com>
In-Reply-To: <ba57d7a8-bafc-e06e-8ed2-87db4ff96904@suse.de>
References: <2438c500-eb41-4ae2-b890-83d287ad3bcd@gmail.com>
 <32986577-b2c2-98ac-1a30-28790414b25d@suse.de>
 <ba57d7a8-bafc-e06e-8ed2-87db4ff96904@suse.de>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Monday, September 28, 2020 7:02:00 AM CEST, Coly Li wrote:
> On 2020/9/28 11:15, Coly Li wrote:
>> On 2020/9/28 04:29, Vicente Bergas wrote:
>>> Hi,
>>> since recently the rk3399-gru-kevin is reporting the trace below.
>>> The issue has been uncovered by
>>>  b35fd7422c2f8e04496f5a770bd4e1a205414b3f
>>>  block: check queue's limits.discard_granularity in ...
>>=20
>> Hi Vicente,
>>=20
>> Thanks for the information. It seems the device with f2fs declares to
>> support DISCARD but don't initialize discard_granularity for its queue.
>>=20
>> Can I know which block driver is under f2fs ?

Hi Coly, yes, i confirm it is the mmc driver.
Regards,
  Vicente.

> Maybe it is the mmc driver. A zero value discard_granularity is from the
> following commit:
>
> commit e056a1b5b67b4e4bfad00bf143ab14f634777705
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Tue Jun 28 17:16:02 2011 +0300
>
>     mmc: queue: let host controllers specify maximum discard timeout
>
>     Some host controllers will not operate without a hardware
>     timeout that is limited in value.  However large discards
>     require large timeouts, so there needs to be a way to
>     specify the maximum discard size.
>
>     A host controller driver may now specify the maximum discard
>     timeout possible so that max_discard_sectors can be calculated.
>
>     However, for eMMC when the High Capacity Erase Group Size
>     is not in use, the timeout calculation depends on clock
>     rate which may change.  For that case Preferred Erase Size
>     is used instead.
>
>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
>
>
> Hi Adrian and Chris,
>
> I am not familiar with mmc driver, therefore I won't provide a quick fix
> like this (which might probably wrong),
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -190,7 +190,7 @@ static void mmc_queue_setup_discard(struct
> request_queue *q,
>         q->limits.discard_granularity =3D card->pref_erase << 9;
>         /* granularity must not be greater than max. discard */
>         if (card->pref_erase > max_discard)
> -               q->limits.discard_granularity =3D 0;
> +               q->limits.discard_granularity =3D SECTOR_SIZE;
>         if (mmc_can_secure_erase_trim(card))
>                 blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }
>
>
> It is improper for a device driver to declare to support DISCARD but set
> queue's discard_granularity as 0.
>
> Could you please to take a look for mmc_queue_setup_discard() ?
>
> Thanks in advance.
>
> Coly Li
>
>
>>  ...
>
>
>

