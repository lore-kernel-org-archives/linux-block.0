Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154BFC433EF
	for <linux-block@archiver.kernel.org>; Sun, 27 Feb 2022 11:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiB0LBL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Feb 2022 06:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiB0LBK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Feb 2022 06:01:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806D56211
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 03:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645959632;
        bh=DmtChRc6KYh/Oj5XxryxrWWO/JG5NgXElHEXJfkoAhg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GR8rI7D5w9WL/bVJVhNOkrwWp5hH9XGzso0q+rpb4OKet/goVDPsOBqc62yL60Pnx
         rM7DWY1R2/a/cl78ueafZ8FMc2DWeec6QWT1Xu3I6luEgNmAccVsTHt24KSUCV0iMa
         GKTiSlZ1lBAnbIv+/um5ly8KvGj5C09SRy2Xc8LE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.27] ([45.14.99.28]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1nP6dO3BGH-001Pai for
 <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 12:00:31 +0100
Message-ID: <90b58638-8279-ff09-62fc-aa1fdd5057df@gmx.net>
Date:   Sun, 27 Feb 2022 12:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: blocksize 4096 even for floppy and CDROM?
Content-Language: en-US
To:     linux-block@vger.kernel.org
References: <e4ab39cb-fbe7-1148-8d8a-5cd46866159f@gmx.net>
 <f94fc06e-c0ff-103b-789a-87af52c53e11@infradead.org>
 <yq1fsoab5n0.fsf@ca-mkp.ca.oracle.com>
From:   JPT <j-p-t@gmx.net>
In-Reply-To: <yq1fsoab5n0.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+eX6AtR9w2/NC/xGwYkPhc3vn18jALNmRfL7yL70dN/FUfPRtuA
 0Z2z4gW2XtOVKVs3ded59RnOQYaHOPolhy/dQGtwqu5gHJGM/yvrLD2mZufIkKDOWpXRVfD
 ZAFsCUMNcqoeO0HAtm8xxvSBQLbdIUIXxO26V4719118gx3eF8sw+ICeIAf4opLkPGKPe6a
 EzgO1kR6F23cuHvNxiBOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eM1492xQSpY=:WkIf2rZCnREJGSDB0nszer
 D26k48ZXawTGDWaB7MLvMFezgVcmsrg5rX6AHb4ltn1fNBXaj2ytWRzxmXrIalOEwJbrxrThm
 lr0yNsRXnpGtUa8FUB5O3lY2GroCutdZ0xmMYLdTqKPoS1V7bfAoIL+HUER30sKefchmALqJ0
 ZntZEls7ZoGUdD/ILFgPdM1xPL51c9lubtGiLmqs2tRwWsuEypI0UvPrSUjQj0Gsj0UKR+ms1
 OSJLmmZ/LGJQMwR6tPHRuaDZFUTqR+hmpttDeBp9etmuJ452TP/C8hvcpNA8QGCcDAJtHDmBW
 zrU/JERDQic7109/EsGXR+LrQA3qkZgLC9ndMuo8gXmFFlN8Xrb+VvrL25Cxq5yOLQ7uT7Q3P
 mJq2/4gvAzQ/kPZ7oMekv5aBo3zut27xgV5D+cq9/mV11IgfZ/X23JnnYoBBPYzbJitPwPBGP
 B4K7jiUDLb2XxS6clx4+fVegZIB8czl90Usy4xM96le847X/E6ole07/MSZ4s3/Mr02v6VN1y
 uSSWUm3xIi0tt49Pvix+MJFsLKzQMxBGi0Drb+IwBcwRFX02UPxS/72ZjCpqQiqC5ZheuATtE
 Uo57ykPGqAD7Q2qm/e5QmfgTtlwQ5TN5GwF17Kycy46do2k9bALg213fqCxNm8OHGUO3XrNYI
 hRAiHP7XwvdsE8uXwOW7wzzf2ROm71fZyzrHlYPvKb4vjMKco/+6up/zMJ5XTzv5hemlR5Dfo
 HljCWFk21knOZIG2iym75EG5NYVi067ZRdAt5Q01RLhCaP0ssAtSJLXPICzEgKg0vJY4qdSVd
 RW/8xz+mUinVGVzYUt2SyGateoldEhtdRHpcC5vbXAsB5TJJaPpko+UNCgtD/XHpVbaIMWE3J
 DEWUum2eH1VofbFovsa6EoUA0gRwolbqxEXJ184cluJRrkAd6uiejjYPEWRw4BwYT8j8hBw3h
 kSqYlc+OBgj3sT7NT2MtBiZyHuL63GqokR3XGkaYlYC0/xG8HOJBdw4pOVBTVNjYbVvVR5he9
 h27/jOF76niKNjVPbSfX7rSmq/T9fZmMqRzRPvRPs1Mj2GbmPsqo151d9q4LLUBKHAUaNu6Jp
 tGOfomx19EgOBM=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

seems that safecopy always assumes 4096, while ddrescue always assumes 512=
.
you have to specify the blocksize manually for both programs.

thanks

Jan


Am 23.02.22 um 05:00 schrieb Martin K. Petersen:
>
> Randy,
>
>>> I wonder why safecopy always says
>>> Reported hw blocksize: 4096
>>> Reported low level blocksize: 4096
>>>
>>> even if the medium is floppy (512) or CDROM (2048)
>>>
>>> is this a kernel issue always assuming min 4k block size?
>
> Not sure how safecopy queries the block size. The kernel supports
> devices with 512, 1024, 2048, and 4096-byte logical blocks.
>
