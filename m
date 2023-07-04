Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F4EB64DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 05:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGDF6c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 01:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDF6b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 01:58:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D114E7C;
        Mon,  3 Jul 2023 22:58:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b852785a65so33057125ad.0;
        Mon, 03 Jul 2023 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688450303; x=1691042303;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATup9MSAiia8r0PtsmJ6fJfs+kCCMMLgmiDvGdEfsy0=;
        b=arFgoN32HO9yV1k3G/3bSbAiXiddbHu7wOiHMHA2XC5cVaDH5WUOMvCMH7nnm+J6kg
         xJ7TRMxkBDFvN/kNkBoLqQd/qINevlO0KUPl6AgIukZiDF4acDFvg9RxBokF9aeE6q73
         i5kWAVOSHHIbNI5+a6FewQZe1f5hV1gW8x3uREh616OMJKCiAyytKtYB56phN9JZ3lQ+
         aP2VF1XNy0/W6qzuqYq5bfOOO0ZTooOiVF3zzwxKFZ/8U5aj4oZaa0AUX55fjNiGGGeY
         8uqSVP6X17Ry3m8UCS9gC5RGaMF3y9Qq4HdiP+49GH83CWTKUk/TlrKMexMqqsu2NVbG
         0/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688450303; x=1691042303;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ATup9MSAiia8r0PtsmJ6fJfs+kCCMMLgmiDvGdEfsy0=;
        b=cFhx9tTQDa4PVDJ9hDxWbdNLtLDhlmfjYPZqu+QiwgFyMm0s8Lp5+44YmWEfmbU0Kp
         dctdkSrDuEwkgs6w4b2uORlc2KYy/qUYGZWrMuNxogdHUxAo8s7U9y2Z4KQ2chLgWgak
         QwDMrynOkBbEAJbpfEcHj1FrPHZ0oPszG+uXX/W1GCnwNnkQU/FAzy3PGAFL4KD0vzfG
         G7KWmJValHxApLrf3FowH414m7JnMqE1/kLY4rp75z17CjO1mPu8QFFQgNQ6H83e3QOS
         xPPuQj/RgJzK2n+89IgVYOBVfFszufnnkM7mZKpnUZ56vcFzeweoh/+1I1NH1oDIFyHH
         uXig==
X-Gm-Message-State: ABy/qLawCk8+vBorhckfF4D1Mqlj1UHJZ7PxujDgdQIb1pLxnthc9xDJ
        q8X23GVfD864txTtaYIUXgRvqC9p5oceaA==
X-Google-Smtp-Source: APBJJlEP9my588J4NL6/c4AnqL1QQV6B4O9bgqf+d4A89XuILxOWk4DnSIdESHpVYBxTNKy5O342Iw==
X-Received: by 2002:a17:902:dac9:b0:1b8:865e:44e7 with SMTP id q9-20020a170902dac900b001b8865e44e7mr12587991plx.20.1688450303174;
        Mon, 03 Jul 2023 22:58:23 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902b08800b001b8307c81c8sm10274366plr.121.2023.07.03.22.58.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2023 22:58:22 -0700 (PDT)
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
 <ed0a8dee-0fb2-aa2f-560a-3a521747a767@gmail.com>
 <d81af6e5bf77d106e02ed2d50e58f6edf2cfed31.camel@physik.fu-berlin.de>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        Christian Zigotzky <info@xenosoft.de>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block <linux-block@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <11cacce5-8252-c65f-0d41-8d7ad1c17d91@gmail.com>
Date:   Tue, 4 Jul 2023 17:58:13 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <d81af6e5bf77d106e02ed2d50e58f6edf2cfed31.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Adrian,

Am 04.07.2023 um 17:48 schrieb John Paul Adrian Glaubitz:
>>>
>>> Have we actually agreed now that this is a bug and not just an effect of the
>>> corrupted RDB that Christian provided?
>>
>> The RDB was perfectly fine. Due to 32 bit integer arithmetic overflow,
>> old RDB code passed an incorrect partition size to put_partition(),
>> and instead of rejecting a partition that extends past the end of the
>> disk, put_partition() truncated the size.
>
> OK, so using "-1" as an end-of-disk partition marker is fine, but it was just
> the partition size recorded in Christian's RDB that was incorrect, correct?

No, the partition size in the RDB was correct (valid, end cylinder 
before end of disk). The partition size seen by user space tools when 
running the old kernels was incorrect. That lead to the filesystem size 
exceeding the partition size, which only came to light once the overflow 
fixes had gone in.

I know it does sound like semantic sophism, but we have to be clear that 
what the user put in the partition block is definite. I haven't had much 
luck with heuristics in kernel code lately...

>>>
>>>> Jens - is the bugfix patch enough, or do you need a new version of the
>>>> entire series?
>>>
>>> But the series has already been applied and released in 6.4, hasn't it?
>>
>> That's right - I wasn't sure whether it had already gone upstream (but
>> even then, squeezing a bugfix in with an accepted patch isn't usually done).
>
> It's even released already ;-). That's why Christian ran into the problem in the
> first place.

I had hoped he'd spotted it in linux-block ...

Cheers,

	Michael


>
> Adrian
>
