Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896CFC433FE
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 22:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6415C60ED5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 22:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhKLWhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhKLWhX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 17:37:23 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF9C061767;
        Fri, 12 Nov 2021 14:34:32 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x64so9665116pfd.6;
        Fri, 12 Nov 2021 14:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nSYugM7e1H4wPVMZ7Smi27JPy10nGqiU6aBzuySGr60=;
        b=oOzF+zmo6SiMqmJfa7gaK3oKSkR1pY9902ZGS8pJLq+wTbxu/j2FTOacd9hNypatjW
         KKDWQzrRioR146byo8TiYbZBjFjMM7BLYCG+qthYP/S0OUvqqdUsAYrzVdlHC7PF4nnb
         nkhFryqqfmmkTtjQjpvEAcAliZ2mA0ksqrAxGKQ2hqLIaa+OrwOeLrGdKztL1qxWya2Y
         vdT/F5Uff4IOyJVnbpFZTrpVPGqefJQqu4REazxU4XGJdc3DkoiI6x8V+XoRjRSl4xBC
         X8UuvNWnqaj/ltOYmc+LKUHGYWtUKDaOMt8MBVUdBHopxI+fvv5JBeoBmjMy8pMEx64w
         nMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=nSYugM7e1H4wPVMZ7Smi27JPy10nGqiU6aBzuySGr60=;
        b=Z8Ln3Mb5HY7smOO0zB+CjvrNKTUlDhETt0gzXMhuUeAX3CydpbbRLjSwsT/Z7Ou5ND
         2DJMZTN3JifyeCgStU6XTth7QaD5fEEBeRY3hLvt8Ja8ECP9ZulH5NlQiLz5eag3fE4X
         GcsAlhIduc/PsLEGUdFiSWlv78VgDWqa/AfklDxP1b43Sr+ZWz+eczlAu9u0UpbnzTJF
         uc5DGvjIQIIlkxfOTNZF08jgfxeuVJcDBFkFvWFd9s3O1+QTpNYcZHlX+Exjvm3g9i8L
         cI2cA3akLjhy3Y5aH7FDJsXqQmTh+EpSWgiRkuZmz6IWk1BVXJ7d5J1MCOFbezmD49Zp
         yBCw==
X-Gm-Message-State: AOAM532dt+9kIcv9P5IFvw+fqwkLDwGFOkZ5cWUqq3cq3ijAfskk2YHO
        WqBkg+pUBhkOtFcc3d4T/D9f2ieW/kQ=
X-Google-Smtp-Source: ABdhPJy2ci0AXtOi41C6QfAjTwSbRJ3uHJccWJRLcbsisXZ7iyjkAa+HN0Wpt8qitQViNgYi301bIA==
X-Received: by 2002:a63:9212:: with SMTP id o18mr12191120pgd.392.1636756471969;
        Fri, 12 Nov 2021 14:34:31 -0800 (PST)
Received: from [10.1.1.26] (222-155-101-117-fibre.sparkbb.co.nz. [222.155.101.117])
        by smtp.gmail.com with ESMTPSA id f185sm7254353pfg.39.2021.11.12.14.34.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Nov 2021 14:34:31 -0800 (PST)
From:   Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
 <fbe43b88-720f-6956-60ea-18e07d73244e@gmail.com>
 <CAMuHMdXe4bA-a968cUcdaCKesMtkMc+qs=4L8nF2QQ0rWvAVHw@mail.gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <39bfc824-61d8-02a8-30fe-e9ea0efae100@gmail.com>
Date:   Sat, 13 Nov 2021 11:34:19 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXe4bA-a968cUcdaCKesMtkMc+qs=4L8nF2QQ0rWvAVHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

On 12/11/21 20:37, Geert Uytterhoeven wrote:
> Hi Michael,
>
> On Thu, Nov 11, 2021 at 10:35 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> how easy is that to reproduce?
>
> Fairly easy: it happens either on mounting, or after a few seconds booting
> into my old Debian userspace.

I must be too thick for this:

EXT4-fs (sda1): Cannot load crc32c driver.
VFS: Cannot open root device "sda1" or unknown-block(8,1): error -80

(linux-block 5833291ab6de, from kernel.org)

Same config on m68k 5.15 works just fine.

But this looks resolved now, so I'll punt for now ...

Cheers,

	Michael

>
>> sd_setup_read_write_cmnd() does not validate the request's FUA flag
>> against sdkp->DPOFUA (not suggesting that it should ...). I'd like to
>> try and trace when such a mismatch happens.
>
> Thanks!
>
>> On 12/11/21 03:48, Geert Uytterhoeven wrote:
>>> On Thu, Nov 11, 2021 at 2:19 PM Martin K. Petersen
>>> <martin.petersen@oracle.com> wrote:
>>>>> sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>>>>> sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
>>>>> sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
>>>>> sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
>>>>> critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>>>>> Buffer I/O error on dev sda1, logical block 0, lost sync page write
>>>>
>>>> Peculiar. That write command looks OK to me. I wonder if it's the FUA
>>>> bit that trips it?
>>>>
>>>> What does:
>>>>
>>>> # dmesg | grep FUA
>>>>
>>>> say?
>>>
>>> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
>>> support DPO or FUA
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
