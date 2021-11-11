Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917A3C433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7112561152
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 21:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhKKVij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 16:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhKKVii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 16:38:38 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C2AC061767;
        Thu, 11 Nov 2021 13:35:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id n85so6651318pfd.10;
        Thu, 11 Nov 2021 13:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=s9nNSre2uSzhq7LJWXGvlLZ1wWn7QfVHEdLKjz4Pqkk=;
        b=RC6fVznDnxtSv8MvKkFHZ0g/OBHaiBrfG0lSngcX8j80nhkl6Zx8zdQ+k15fbml3QE
         530TmzEaVfDXX7R1ga1GsOTqylQox98Ua9uX8O5Fzd1KJfakrC8WxYXdm3lCmRZ5oMej
         /jDj1luaSXoVK6xLaVLSZYPuxa7IGf66mSTpX8dxU7uV9S3DMk9Yj+P1JFnX73mhISGF
         Z1sbsDSNBNG7yCSc0wB+SxoF+STUL3lilslMbzy6Rkar9P3coz6S4/V6F69Q9QZU/7tQ
         bZ9W3iNJffg9l6DU8y4Osx+ulcclBWsN2HojR1YtnNJE3vhKX78K52hFNvLC5UsCPN5g
         uRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=s9nNSre2uSzhq7LJWXGvlLZ1wWn7QfVHEdLKjz4Pqkk=;
        b=5Cw/CrXHse05NESujBp416CzH17mH/WkXb4SEkO+bEd48wzXVGHe0BYfxBCpcqQ7p2
         8FwFX5KoE4W7ziRsXW1Q2N4qWZdfryOiIzua4oyLl5UceF1jW7U2xwydpxmLfXKX7bwj
         3uyMK7pUV+M1wQCcBLTswW4Dp3fXm6qEAGZi+UoECqJ4dqdgqjzc2qO9PbqnNSJHBszF
         kGHWqz/0rcoO2vIZPuMKRcBMU6qBO66CbnLYY0he95l1dw4yLZzYaYBkL6e8teeKzqmd
         0w5ZvpK3otLTGdZnBoastMXOJI2uni9w3RdQD9/JQ8su4ERp5y8KSwiYxcN2HbEGqmk4
         Pmuw==
X-Gm-Message-State: AOAM533mPr95PdBtGI3JY05tddjMftJS5Nvmr0Cti5D6jgK/3D5si9WE
        k78ImGWYQ82AMSIeVjIzKXRQPnim/9M=
X-Google-Smtp-Source: ABdhPJwfQW8Fl9QYm0itZlXAtyfvGBdsRy9traW6TrHtxQuk8o/Utc4N7kEMsM9wH+0v16yoi0bdKQ==
X-Received: by 2002:a62:cdca:0:b0:480:8a68:8b68 with SMTP id o193-20020a62cdca000000b004808a688b68mr9423723pfg.80.1636666547931;
        Thu, 11 Nov 2021 13:35:47 -0800 (PST)
Received: from [10.1.1.26] (222-155-101-117-fibre.sparkbb.co.nz. [222.155.101.117])
        by smtp.gmail.com with ESMTPSA id v38sm3060948pgl.38.2021.11.11.13.35.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 13:35:47 -0800 (PST)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk> <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
 <YYQuyt2/y1MgzRi0@infradead.org>
 <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
 <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
 <yq1sfw2g7xr.fsf@ca-mkp.ca.oracle.com>
 <CAMuHMdVdwwT5yQPpQ5Frr-Un5OMk9LX3sF_zocOejrouSjaO-w@mail.gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <fbe43b88-720f-6956-60ea-18e07d73244e@gmail.com>
Date:   Fri, 12 Nov 2021 10:35:34 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVdwwT5yQPpQ5Frr-Un5OMk9LX3sF_zocOejrouSjaO-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

how easy is that to reproduce?

sd_setup_read_write_cmnd() does not validate the request's FUA flag 
against sdkp->DPOFUA (not suggesting that it should ...). I'd like to 
try and trace when such a mismatch happens.

Cheers,

	Michael

On 12/11/21 03:48, Geert Uytterhoeven wrote:
> Hi Martin,
>
> On Thu, Nov 11, 2021 at 2:19 PM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
>>> sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>>> sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
>>> sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
>>> sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
>>> critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>>> Buffer I/O error on dev sda1, logical block 0, lost sync page write
>>
>> Peculiar. That write command looks OK to me. I wonder if it's the FUA
>> bit that trips it?
>>
>> What does:
>>
>> # dmesg | grep FUA
>>
>> say?
>
> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
