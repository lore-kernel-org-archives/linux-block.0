Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F96C433EF
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7461A611C9
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 14:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhKKOvj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:51:39 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:35670 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhKKOvj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 09:51:39 -0500
Received: by mail-vk1-f177.google.com with SMTP id u130so3391976vku.2;
        Thu, 11 Nov 2021 06:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOdkRMonvPRtvh+RCUFAypHkHVRkuDa2ETyMKRHbHyA=;
        b=iI8joZvt9NHEqXQcZbe3su7QIofZpWoYEk6jkWejQor5hYpIcqCUVeNWS+firLSGuB
         7sLAsjVzyHKlyOPcSh+c2J0nW+fLWN0kSf8oK/VQtNW9PkXm6qNXrprMn7FFuWXZNsG3
         p1JzgVEHPMKHRwwvB+qg7X2nh0b+hU2aMGdlfJq932DElypEEfqvmd2i8K6duLgLke7X
         PH0CJt+QNoTVWTrqPnu3vMP6OsTbv73DKQSlIyvckygaO3/KMPDxpWUe0mNt//UIylBO
         mPz4JAlFTRMDXg4yhu+akXKDXML2uRFVVDJ5TIwbb83fChZrD+SEmOTENqPrO1ZS3UVP
         CpVw==
X-Gm-Message-State: AOAM533hmdUQrLze4q18T3iEvwl3y45xkluUkIZf5cDrIUXtZhQsaram
        RHdQuJCd3ccHJECPcb4yv7fTZbCzC5Q/EQ==
X-Google-Smtp-Source: ABdhPJyhbdTsSErOLCuMUxvc8k46h57eVvwPNTN1bYH5Rm1jfVYxGpGNsnkLH7qCIiZ1E5RkNJncbQ==
X-Received: by 2002:a05:6122:50e:: with SMTP id x14mr11836486vko.7.1636642129174;
        Thu, 11 Nov 2021 06:48:49 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id d13sm2249722uaf.6.2021.11.11.06.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 06:48:48 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id k83so2536214vke.7;
        Thu, 11 Nov 2021 06:48:48 -0800 (PST)
X-Received: by 2002:a05:6122:20a7:: with SMTP id i39mr11374370vkd.15.1636642128577;
 Thu, 11 Nov 2021 06:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20211104182201.83906-1-axboe@kernel.dk> <20211104182201.83906-5-axboe@kernel.dk>
 <YYQoLzMn7+s9hxpX@infradead.org> <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org> <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk> <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk> <YYQuyt2/y1MgzRi0@infradead.org>
 <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk> <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
 <yq1sfw2g7xr.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1sfw2g7xr.fsf@ca-mkp.ca.oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Nov 2021 15:48:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdwwT5yQPpQ5Frr-Un5OMk9LX3sF_zocOejrouSjaO-w@mail.gmail.com>
Message-ID: <CAMuHMdVdwwT5yQPpQ5Frr-Un5OMk9LX3sF_zocOejrouSjaO-w@mail.gmail.com>
Subject: Re: [PATCH 4/5] block: move queue enter logic into blk_mq_submit_bio()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

On Thu, Nov 11, 2021 at 2:19 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
> > sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> > sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
> > sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> > sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
> > critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> > Buffer I/O error on dev sda1, logical block 0, lost sync page write
>
> Peculiar. That write command looks OK to me. I wonder if it's the FUA
> bit that trips it?
>
> What does:
>
> # dmesg | grep FUA
>
> say?

sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
