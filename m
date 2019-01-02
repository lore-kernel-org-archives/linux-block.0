Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3FCC43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A85F218CD
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 15:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t68i04J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfABP3X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:29:23 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:34430 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfABP3W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 10:29:22 -0500
Received: by mail-vs1-f43.google.com with SMTP id y27so19082881vsi.1;
        Wed, 02 Jan 2019 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgoizObZNi3T/KUof114Eb4G2GnOMwjA/hKcL/kiZHM=;
        b=t68i04J3yujE7kLsbwZGcZyg3c/SN4klyZjsrk4xAMUYDkBqyMYtvVEap0a6Y8X9z8
         lFE0jZ5aKiCoTIztXqlufcLH4AqzRZdFMt4IU8g4mHrRHMxAUGrirp6deoCoyDdH6cGi
         YxzcX7vRFW1qF2q41optIj4mcoqDTOXIzRRYkiPIn9rD/7iumL2USDcR1VssqSQKC8bj
         ATn6J/dCUTKY7zLFudlA1r4H4Xl3L2nnJodcXHDIictOCRWcuk2jC5/AcMs9CiVQGi7X
         i7LrnT0Soki68TQYDmoyevXtOiZJdw1DVz6RFDuC3xTJQIpOaogPejM4n3WZhrEeIubp
         1qAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgoizObZNi3T/KUof114Eb4G2GnOMwjA/hKcL/kiZHM=;
        b=SVp1jgBPoTedO+6OcTflCbv/0pmLSveKu//JzPJbLDo8YmUkdl//w79dm7BYkoW5Kv
         BhZEird0CrYxGdjxURKfIpij1yjV9lfOwRB797mWqIgYOJIzRy0pZIvJNvPBapdn9hub
         XiHHKs1IAQpic6PcGSoMUtlUGzlAk/EZqdVQErOxFMVr6ApOwlT1Qs9p/vqxCUNAucnp
         mPR/vAJOI/tWZoX+vhPp1nH8Sq9WIJiS/XF3Wwn9iwvU6a6nBroQIrHYfdFouiAspIId
         WBb4/sMoNfgm9pxAoPH1sXKae+zXCeQNubru1sKncbStR6nOwb1NA7Zv5TkK6orpbHha
         5KrA==
X-Gm-Message-State: AJcUukewZmCBMaaSQ69J6JQL++Dn1AAH0I59f3CexGBqRTccj45jocXF
        0bxcXqCY+WJ8NnQ29yUFXHDNgJgEKuec5cW81uSFAw==
X-Google-Smtp-Source: ALg8bN4pqk3U1qB0iMZsh5h7zrlld0bg4Affr6PSj36rpJgKQqown2AaLOxywgYprrbnAaEpBWd7HagK38K3fEK2IG4=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr4074255vsa.165.1546442960947;
 Wed, 02 Jan 2019 07:29:20 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
In-Reply-To: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Wed, 2 Jan 2019 15:29:02 +0000
Message-ID: <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
To:     linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Also trying linux-ide list)

On Wed, 2 Jan 2019 at 15:25, Sitsofe Wheeler <sitsofe@gmail.com> wrote:
>
> Hi,
>
> I recently purchased a SATA Samsung 860 EVO SSD and put it in an old
> HP microserver (which has an AMD N36L). By default, when the disk load
> becomes a little heavy e.g. by running a job like
>
> fio --name=test --readonly --rw=randread --filename /dev/sdb --bs=32k \
>     --ioengine=libaio --iodepth=32 --direct=1 --runtime=10m --time_based=1
>
> the kernel starts repeatedly producing error messages like:
>
> [ 1177.729912] ata2.00: exception Emask 0x10 SAct 0x3c000 SErr 0x0
> action 0x6 frozen
> [ 1177.729931] ata2.00: irq_stat 0x08000000, interface fatal error
> [ 1177.729943] ata2.00: failed command: WRITE FPDMA QUEUED
> [ 1177.729962] ata2.00: cmd 61/80:70:80:50:e6/06:00:00:00:00/40 tag 14
> ncq dma 851968 out
> [ 1177.729962]          res 40/00:80:00:5a:e6/00:00:00:00:00/40 Emask
> 0x10 (ATA bus error)
> [ 1177.729978] ata2.00: status: { DRDY }
> [ 1177.729986] ata2.00: failed command: WRITE FPDMA QUEUED
> [ 1177.730002] ata2.00: cmd 61/00:78:00:57:e6/03:00:00:00:00/40 tag 15
> ncq dma 393216 out
> [ 1177.730002]          res 40/00:80:00:5a:e6/00:00:00:00:00/40 Emask
> 0x10 (ATA bus error)
> [ 1177.730017] ata2.00: status: { DRDY }
> [ 1177.730024] ata2.00: failed command: WRITE FPDMA QUEUED
> [ 1177.730039] ata2.00: cmd 61/00:80:00:5a:e6/05:00:00:00:00/40 tag 16
> ncq dma 655360 out
> [ 1177.730039]          res 40/00:80:00:5a:e6/00:00:00:00:00/40 Emask
> 0x10 (ATA bus error)
> [ 1177.730053] ata2.00: status: { DRDY }
> [ 1177.730060] ata2.00: failed command: WRITE FPDMA QUEUED
> [ 1177.730078] ata2.00: cmd 61/00:88:00:5f:e6/01:00:00:00:00/40 tag 17
> ncq dma 131072 out
> [ 1177.730078]          res 40/00:80:00:5a:e6/00:00:00:00:00/40 Emask
> 0x10 (ATA bus error)
> [ 1177.730096] ata2.00: status: { DRDY }
> [ 1177.730108] ata2: hard resetting link
> [ 1178.205831] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [ 1178.206165] ata2.00: supports DRM functions and may not be fully accessible
> [ 1178.209743] ata2.00: supports DRM functions and may not be fully accessible
> [ 1178.212786] ata2.00: configured for UDMA/133
> [ 1178.212826] ata2: EH complete
> [ 1178.212988] ata2.00: Enabling discard_zeroes_data
>
> I tried moving the SSD to another caddy and bay but the issue
> persists. None of the regular hard disks (a Western Digital and a
> Seagate) nor the other SSD (a Crucial MX500) already in the system
> trigger the issue the Samsung 860 EVO does. Adding
>
> libata.force=2.00:noncq
>
> seems to make the issue go away but seemingly at some speed cost (at
> least compared to what the MX500 achieves). The OS in use is Ubuntu
> 18.04 with a 4.15.0-43-generic kernel but even a 4.18.0-13-generic had
> the same issue.
>
> Is there anything software-wise that might need investigating that
> would allow NCQ to work and a better speed to be reached?

-- 
Sitsofe | http://sucs.org/~sits/
