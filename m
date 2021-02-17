Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938E0C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 02:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F5C64E63
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 02:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhBQCME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 21:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhBQCMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 21:12:00 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6AC061574
        for <linux-block@vger.kernel.org>; Tue, 16 Feb 2021 18:11:19 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id w1so9964928ilm.12
        for <linux-block@vger.kernel.org>; Tue, 16 Feb 2021 18:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbHWdfrKyhzyKLiX18Uft3nLOen8hta8U9yqWDQRLww=;
        b=a3iblguB6AW+DTPhGOyBrjy6vmJRFOd/7kdLZe0/kaY2zTxz7VIV1olDnTE4FL7Xu5
         7OdpomIQ8LbANYcUXTYP3TRFQfoz9btUrAzjZphpcBkg67q7t2zO3yM/79nfOuxuPok3
         n4U65EtDWRKK7sL0HDLF3ekck/fq4sYH7QOjkWn1mngGUkBIIMiVwKQ9HREbS6Yk6Lmn
         7hxgm4meBE3MxNhc8tNPG94Y9qV7aOTVwFK86RCXvN3lDvpddQqvJpAQGMZwwN6451Kg
         u0ew9bRp1iq6bs8AkrgbcID1uDsxl0grKIfFLW0E2fWyAY1W/N4SczUjy8oIDz2qmDVX
         91jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbHWdfrKyhzyKLiX18Uft3nLOen8hta8U9yqWDQRLww=;
        b=MNAh2I7AnCio0+je/8mEplKP/8Ov9jrDZXZV9DARJ4xVJv6tm6UVc77uToNk1HEEee
         rFtYO/OtfY4MRNxRvwm4YhfzM3Ch9UJwi/IEyafSHrIGcL8Vy1+p05edzrXkklOABVS1
         ld8MZvh4BL8TCbtLsp8FcZ52Wu7mFxTib6ntCisvUrYnUfdxOalukuHpyQma5abHArVP
         FljD02vPyp4xamC4nxeNqpAWa88Sv2WGH2TYWLubSHiKm8eZu//MqbTgi0AezXstJscb
         +Y30NnWD0ylo3XnXLFDVjSuIhu4+VypeWFaL6Mt+7GOpkkrIrnYLCUFRJ/HbV/I2QEu8
         HERw==
X-Gm-Message-State: AOAM53102rIrbB8CouwNKItusao9MroglmJWa7ScFA9SR0Rhwy23qvPz
        ngU6Za2uYh5Ndynj6wP8YsQRFPxgLcclS590Wlhsw7VkVS/s3dHr
X-Google-Smtp-Source: ABdhPJwjigzhh78dQ76BoSPIImpTgYpawyW+7Gjq9rUK48GIDjeTMTQUA2vrhmextbeVxQYltpibhnyB/TVh7Ih8Bg0=
X-Received: by 2002:a92:41cd:: with SMTP id o196mr20213138ila.31.1613527878538;
 Tue, 16 Feb 2021 18:11:18 -0800 (PST)
MIME-Version: 1.0
References: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com>
 <20210216123755.GA4608@lst.de>
In-Reply-To: <20210216123755.GA4608@lst.de>
From:   Tom Seewald <tseewald@gmail.com>
Date:   Tue, 16 Feb 2021 20:11:07 -0600
Message-ID: <CAARYdbiDzi_WcNGe4GkWjtTXeNOV7pZCLiJFk4r+Np_Je+2aZw@mail.gmail.com>
Subject: Re: [Regression] [Bisected] Errors when ejecting USB storage drives
 since v5.10
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 16, 2021 at 6:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> ... but you were using sd, not sr.
>
> Can you give this patch a spin?
>
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a3d2d4bc4a3dcd..6671b4e1909777 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2116,6 +2116,14 @@ static int sd_done(struct scsi_cmnd *SCpnt)
>                         }
>                 }
>                 break;
> +       case NOT_READY:
> +               /* Medium not present */
> +               if (SCpnt->device->removable && sshdr.asc == 0x3a00) {
> +                       req->rq_flags |= RQF_QUIET;
> +                       set_media_not_present(sdkp);
> +                       sdkp->capacity = 0;
> +               }
> +               break;
>         default:
>                 break;
>         }

After reading the asc/ascq assignments from t10.org, I think it should
be "sshdr.asc == 0x3a" rather than "sshdr.asc == 0x3a00". With that
change to your above patch, I am seeing different output after
ejecting USB drives.

[   45.027823] sd 8:0:0:0: [sdc] tag#0 device offline or changed
[   45.027832] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.027871] sd 8:0:0:0: [sdc] tag#0 device offline or changed
[   45.027875] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.027885] ldm_validate_partition_table(): Disk read failed.
[   45.027902] sd 8:0:0:0: [sdc] tag#0 device offline or changed
[   45.027905] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.027928] sd 8:0:0:0: [sdc] tag#0 device offline or changed
[   45.027931] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.027953] sd 8:0:0:0: [sdc] tag#0 device offline or changed
[   45.027956] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.028103] sd 8:0:0:0: [sdc] tag#0 device offline or changed
[   45.028106] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.028113] Dev sdc: unable to read RDB block 0
[   45.028124] sd 8:0:0:0: [sdc] tag#0 device offline or changed
[   45.028126] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.028140] sd 8:0:0:0: [sdc] tag#0 device offline or changed
[   45.028142] blk_update_request: I/O error, dev sdc, sector 0 op
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   45.028148]  sdc: unable to read partition table
[   45.029893] sdc: detected capacity change from 0 to 30595072
