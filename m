Return-Path: <SRS0=IQXF=WU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B78AC3A59E
	for <linux-block@archiver.kernel.org>; Sat, 24 Aug 2019 09:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6830920874
	for <linux-block@archiver.kernel.org>; Sat, 24 Aug 2019 09:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Nkr5IQAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfHXJO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Aug 2019 05:14:28 -0400
Received: from mout.web.de ([212.227.15.4]:54935 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHXJO2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Aug 2019 05:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566638061;
        bh=4KdQ/v44B8Xvqa/bRTo/XlV3ScghQqfMmHlvkTOh+o8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Nkr5IQAg0bJEsDGTJlWviIj36d+dLxrO9fTrnotBG9skcD9cZlTiVAd0NYAHxDTpr
         d3i0MfI+ablhuKgguab6sXc1lggYlw5vpON9kRN/n57xTqI6f/UEBoHBBpSWuCwTy/
         BCZNczlykTlQTDN30owSk4H7ytajj4jmTxoW47ws=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [172.16.2.20] ([81.27.118.244]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBkWd-1huXIQ09bD-00AkTJ; Sat, 24
 Aug 2019 11:14:21 +0200
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2 file
 format driver
To:     Bart Van Assche <bvanassche@acm.org>,
        development@manuel-bentele.de, linux-block@vger.kernel.org
References: <20190823225619.15530-1-development@manuel-bentele.de>
 <da0a76ae-0627-24b8-1aa5-62463e8b3759@acm.org>
From:   Manuel Bentele <manuel-bentele@web.de>
Message-ID: <4cc02259-24c0-0858-5439-5b1b0649d4f2@web.de>
Date:   Sat, 24 Aug 2019 11:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <da0a76ae-0627-24b8-1aa5-62463e8b3759@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE
X-Provags-ID: V03:K1:K5vlIrE0xsjfL+NSrINMBErA93mepHMs6U20ukuJK7+LBpQv2wK
 wDT5IW9c8ppyep+PpGCt9Q5wRal0881RseVaiPkx56brACWnS6Q/AI/WVKt3lb1vzJ6EFEL
 kKrQQzO7Gfe/qZ3aAO9MD9/8VEnamP6e5yWxqchZb1TvP/JAC9TJ/ZC2ePtlOyWqzim2VEK
 JyMGfAiBQRhw7NvXoK19A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DedP4JSl3go=:e0o3t17IIh3t9AY05J6OCG
 gKT7Ae/1F6qyaIPQTbP3GjpCEdGW26e1kjQ5CB+kkhT1R6vE6PGslPptSarYMGFvs1lp98+JG
 ODmu/x0hP7UDWlsuWxXg21FjAS27YdUayx9/4HA/fDKyz4zoAyds8EVUCzI3TjrMb0K+uavai
 AtDVnEbETYuCHgLv+5QfjddZW2bw/NOkcRPuHhxaLfPDSOwX8X2eNQbQb8M+XZqsgYsIzcddl
 FZrtCi6/eRT5wCNsRMaOJOGFJ0r2y+zJYvqFUX90wmn/DtedbDuLPlr1QH6tmkWSHjlq1zb80
 vxgN72bEFsV+y/jstxeljx7ptAzDxUj6ZVWDkHqfohoux8Ql6VnoaG54c3g9NK5K1pDgBwTwS
 Kj0SB4OTuv+LPNXeV/1qCRhaRgOjxehqzrlXu2kAgVimJyhyJIRVLFzfdEuU/omnfzTakJMxj
 nfWZrprf2pTtEpoxQqWul8JamY2OzMCXHeCXJ7rQAyhQAV+pETfK6NwcV0YMnAqi14HDvYfdI
 2x+FSDAo+IlK1Snm2UcmndjBSsatM4T7tX4anQQYCboEUZ+CVJBDtRrSNr1Km7DYfwV11sR2c
 swxeD+71UiYaLPXaqeh0ZXL0H6s+UdQJc6/ThoQRg6XfOLfvv4gCwRzdRz0Wkj0oJPIbTW/gY
 Cd11z6MK91B3mdOkkKRRhOqcQ7FkarFnjuL6WzxZ6F3LGIDpXfHFGhfJPmnsHgEclobaSJx1U
 LUB3BRgaMGoShCQs41WB/a4WL5ljQij3fIQV+Gl0j1RVOozd6C7lfJ6u+EqHUAyLIB5QvP4bb
 7ULqUTZZvfbm3ASOSfl8s3Gm19EdhnOauA/1/meSaGw7bQikgn2vZ1wG44pxNsvL4HzJH3FIZ
 Ll6CgH5QPhlOtUXQhhG1f4jFdY5uhPtjKKWP+GLTm5liX5JV4k3oYSnbYSjFvPeFOhOKKj8S3
 YOLl5AjH3MGD1ZodLqeNw+sqgjhgCYNiIYTYcorh0TK+LubLrQxhfuPeg6HkCmmWuekoEj+1L
 A8KB1qXzB8K+2PmGniOZL5Qmh7ZiZgEgyUiuNrugWYpcO4OrUDciZUKeD/emvBw1K9HwpQgil
 wkCXYnvsc1X5kghR+AuTmGjUGOEC2taP9HW56RPCgKdnxrQwYEUiylIH3WAiBSMJ/fra8AmH7
 ZtUyk=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart

Thanks for your quick reply.

On 8/24/19 5:37 AM, Bart Van Assche wrote:
> On 8/23/19 3:56 PM, development@manuel-bentele.de wrote:
>> During the discussion, it turned out that the implementation as device
>> mapper target is not applicable. The device mapper stacks different
>> functionality such as compression or encryption on multiple block devic=
e
>> layers whereas an implementation for the QCOW2 container format provide=
s
>> these functionalities on one block device layer.
>
> Hi Manuel,
>
> Is there a more detailed discussion available of this subject?
No, the only discussion is the referenced one [1]. But there was a
similar discussion in the master's thesis of Francesc Zacarias Ribot
[2]. Unfortunately, I found no attempt on the mailing list that proposes
his solution.

> Are you familiar with the dm-crypt driver?
I don't know the specific implementation details, but I use this driver
personally and I like it. Do you want to propose that only the storage
aspect of the QCOW2 container format should be used and all other
functionality inside the container should be provided by available
device mapper targets?

> [...]

Regards,
Manuel

[1] https://www.spinics.net/lists/linux-block/msg39538.html
[2] Francesc Zacarias Ribot: QLOOP Linux driver to mount QCOW2 virtual
disks; June 23, 2010;
https://upcommons.upc.edu/bitstream/handle/2099.1/9619/65757.pdf

