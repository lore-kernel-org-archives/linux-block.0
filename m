Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0E7EB64DD
	for <linux-block@archiver.kernel.org>; Mon,  3 Jul 2023 22:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGCWn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jul 2023 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCWnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 18:43:25 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A053E41;
        Mon,  3 Jul 2023 15:43:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-38c35975545so3862202b6e.1;
        Mon, 03 Jul 2023 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688424204; x=1691016204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/tfjhU3WPT9PSSMcmIhQFAKvoGMhIuT3oBNwXQ8Q7I=;
        b=QxEwG9k9hafZSIThooJ6Va0V2ZEBPjliQLDD5krXOQdS7rJXHc5Iwv6qSyKhGGua3y
         yeLwl2a3dEKnxls7RJvO471pQDcjUCxb3ZwyAGa2ei72HmLpK8LxeP3usnW2C6IvyG34
         SpHO3TtIDpOLLhb8JZJw6CwDzznJIeCurOvNyhaPO2AatPXp70B7SUOWqKlzOOvyy9N4
         MvVNnmr2Vb3VRruPJFksaDRJnu4TAVtkrmIjOGoE8aqZhUl+C0gr5l/gFUDAj58QkdPn
         lEwMS/OK34opowHn1lQVhZIeE4CWE1LO6yBUrN2GOw/v2+c7z82jl8WrbfTEMrzd2J4I
         RW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688424204; x=1691016204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/tfjhU3WPT9PSSMcmIhQFAKvoGMhIuT3oBNwXQ8Q7I=;
        b=DgDG9qmJank+S66LpDrZ+Lyn3/hUaz+94Q/2Ktv+6DWZotAlQkX/GvvRMaNy8PpgUl
         k4QVKMDE5ybaxjBiQKiJvemtrlx0iFF/ff/uzn2gHJoHuJYOg+OLjYEp9HLv4Tgkw8V/
         6GD6LIUOiWfhc1i0PANpanvg2c291dr8XuyqLatqhq26N6+B03BunU0y44vWozA1g/YY
         SbB7MqoGEBiJ01MCL0fslfzVTrIreQAjv4eQ72+3uJ/ZbXeF8Blhf8NCj8BUZOtEJPAc
         5xCychLrwRSWAsycsyMFniMiEh9ZHzwQBxrn4n1R/2RnsBgx0dNvV/L5LGrK/r5zzHx3
         HHhg==
X-Gm-Message-State: AC+VfDwFV/xojIt2YgiExPBHaPEO9gA/j6cEdtjdcO/+wBlDl29dA1sP
        WNMQWPHRY9fzNgn86pYw+X4=
X-Google-Smtp-Source: ACHHUZ7MsBY8S9p1pCulyNlK0/OBB75ADUqabd0KbfLOf7fSvrt5HvmKI+GztiOV4Pt7hNq39OhZvg==
X-Received: by 2002:a05:6808:1827:b0:3a1:d763:40a6 with SMTP id bh39-20020a056808182700b003a1d76340a6mr13018019oib.38.1688424203733;
        Mon, 03 Jul 2023 15:43:23 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:d1e:daf:45b5:fd3f? ([2001:df0:0:200c:d1e:daf:45b5:fd3f])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b00680af5e4184sm8675068pfm.160.2023.07.03.15.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 15:43:23 -0700 (PDT)
Message-ID: <fd1539ee-f336-30e0-e155-2c18b4391753@gmail.com>
Date:   Tue, 4 Jul 2023 10:43:16 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        stable@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block <linux-block@vger.kernel.org>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <1885875.tdWV9SEqCh@lichtvoll.de>
 <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
 <4858801.31r3eYUQgx@lichtvoll.de>
 <947340d9-b640-0910-317b-5c8022220a55@xenosoft.de>
 <80266037-f808-c448-c3c7-9d5d5f4253a7@xenosoft.de>
 <45d9f890-ebe2-4014-2411-953fd9741c2b@gmail.com>
 <fbabe412-a3a9-ef89-72ce-cc3e51984139@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <fbabe412-a3a9-ef89-72ce-cc3e51984139@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 4/07/23 09:27, Jens Axboe wrote:
> On 7/3/23 3:24?PM, Michael Schmitz wrote:
>> Hi Christian,
>>
>> On 4/07/23 02:59, Christian Zigotzky wrote:
>>>> I am very happy that this bug is fixed now but we have to explain it to our customers why they can't mount their Linux partitions on the RDB disk anymore. Booting is of course also affected. (Mounting the root partition)
>>>>
>>>> But maybe simple GParted instructions are a good solution.
>>> You can apply the patch. I will revert this patch until I find a simple solution for our community.
>>>
>>> Thank you for fixing this issue!
>> Thanks for testing - I'll add your Tested-by: tag now. I have to
>> correct the Fixes: tag anyway.
>>
>> Jens - is the bugfix patch enough, or do you need a new version of the
>> entire series?
> Well, the whole series is already upstream, so that part is set in
That's what I thought, but thought to better ask...
> stone. What I'm unclear on is if the final fix is the parent of this
> thread, or if there's later version burried somewhere within this big
> thread?

It's the parent of this thread (Message ID 
<20230701023524.7434-1-schmitzmic@gmail.com>) but I'd botched up the 
Fixes: tag; might also need to reword the commit message to clearly 
explain the ramifications of commit b6f3f28f60 as regards partitions at 
the end of the disk that were subject to size overflow and truncation in 
previous kernels.

I'll send v2 of the bugfix shortly, OK?

Cheers,

     Michael


