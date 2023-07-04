Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB49DEB64DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 05:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGDFo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 01:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGDFoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 01:44:25 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA1FE62;
        Mon,  3 Jul 2023 22:44:24 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-19fa4346498so4550055fac.1;
        Mon, 03 Jul 2023 22:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688449463; x=1691041463;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH1M+RhPN2/xk0GZVbmVCyVwta7j5k1DtL529IGJxIY=;
        b=q55V5SSBwAIEnEJndEXrBh+SvfdUuGGL55vEP/GNx+c/o46hc5ebjseoo6EqfDgLZz
         NOv09kXrw8wXeLTm8nJndkj3Lxb1tHTZ/hDSAaYbndYSjBI6kRgeaaXV1vT+YKAYCPYv
         G71yL1d5plRlYXSS3AGjV8Dx6/yp7/S3/6Z/Gi0z7/yQsbu+x9pfzK+JXzzhxwHHPjpY
         NfNtMjvRKbT/nGU/ptemjzaxClnRJX3NBsad1KNVsJX0oDIeMBXLrCRV6nfyhKL2b91d
         f6lf3/1yOnLAaseiD/pZEjgMv75d1E/CFc/stj5C2u264ozqlK6k6hlt/JWf6q0Utlov
         Rfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688449463; x=1691041463;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aH1M+RhPN2/xk0GZVbmVCyVwta7j5k1DtL529IGJxIY=;
        b=R8aPgsYwuALMyxBVfCCOkOHumlbiO3qnsoiU/razFbXMrHbWB5p5PSIWDwUqSGof7r
         OxcjFsAl3A6hmjs2PgNhcBwWSb9bFruUFWB0/1mtKbEBAhK0bEh9ZWvzz3llI0yGQxgI
         zmKCFmyKSitzJYjSRZ0FNm9PUgTeLCzy+0uYtnU6DFKejDvauZCsO3zT9JxwleEVkOkw
         2Q1Fb0Ts6A+iymnSejyhd84mOQeghlQCEcfKjQpOgcmTJO4Qe+E4n7YhqzMk+pgooMlD
         G/NDniZllGA7pPJw+H68Kiw0NDHWuyOf6rhEDHguKvok6yh5A3MtTUdxNw0cxrp5QODE
         QjrA==
X-Gm-Message-State: ABy/qLY2HJTUbSWm/564LWpySqboSsWdrmd8MbiObPSRs1AiEjpB0Tpj
        qIE9GymoKL+CYgL+LI7bYcSJJhRcTqzuEg==
X-Google-Smtp-Source: ACHHUZ7pxiqIvpCd/iqSK6is65kANl7Xxiy34Pp2rJmNPIbJB89w1Dfibo3pkleaClKize4U0zlMZg==
X-Received: by 2002:a05:6870:701e:b0:1b0:2d25:f5a3 with SMTP id u30-20020a056870701e00b001b02d25f5a3mr17633718oae.3.1688449463572;
        Mon, 03 Jul 2023 22:44:23 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090a3e8300b002636dfcc6f5sm7718626pjc.3.2023.07.03.22.44.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2023 22:44:23 -0700 (PDT)
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Jens Axboe <axboe@kernel.dk>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <1885875.tdWV9SEqCh@lichtvoll.de>
 <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
 <4858801.31r3eYUQgx@lichtvoll.de>
 <947340d9-b640-0910-317b-5c8022220a55@xenosoft.de>
 <80266037-f808-c448-c3c7-9d5d5f4253a7@xenosoft.de>
 <45d9f890-ebe2-4014-2411-953fd9741c2b@gmail.com>
 <5dcbbcf69462141ab7cd9679b7577b8047b97f29.camel@physik.fu-berlin.de>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block <linux-block@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ed0a8dee-0fb2-aa2f-560a-3a521747a767@gmail.com>
Date:   Tue, 4 Jul 2023 17:44:13 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <5dcbbcf69462141ab7cd9679b7577b8047b97f29.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Adrian,

Am 04.07.2023 um 17:06 schrieb John Paul Adrian Glaubitz:
> Hi Michael!
>
> On Tue, 2023-07-04 at 09:24 +1200, Michael Schmitz wrote:
>> Hi Christian,
>>
>> On 4/07/23 02:59, Christian Zigotzky wrote:
>>>> I am very happy that this bug is fixed now but we have to explain it
>>>> to our customers why they can't mount their Linux partitions on the
>>>> RDB disk anymore. Booting is of course also affected. (Mounting the
>>>> root partition)
>>>>
>>>> But maybe simple GParted instructions are a good solution.
>>> You can apply the patch. I will revert this patch until I find a
>>> simple solution for our community.
>>>
>>> Thank you for fixing this issue!
>>
>> Thanks for testing - I'll add your Tested-by: tag now. I have to correct
>> the Fixes: tag anyway.
>
> Have we actually agreed now that this is a bug and not just an effect of the
> corrupted RDB that Christian provided?

The RDB was perfectly fine. Due to 32 bit integer arithmetic overflow, 
old RDB code passed an incorrect partition size to put_partition(),
and instead of rejecting a partition that extends past the end of the 
disk, put_partition() truncated the size.
>
>> Jens - is the bugfix patch enough, or do you need a new version of the
>> entire series?
>
> But the series has already been applied and released in 6.4, hasn't it?

That's right - I wasn't sure whether it had already gone upstream (but 
even then, squeezing a bugfix in with an accepted patch isn't usually done).

Cheers,

	Michael
