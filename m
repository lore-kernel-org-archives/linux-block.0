Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A51EB64DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 19:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGDTfn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 15:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDTfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 15:35:42 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D0910C9;
        Tue,  4 Jul 2023 12:35:41 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-345c343ce29so30710875ab.3;
        Tue, 04 Jul 2023 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688499341; x=1691091341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vn24u4tGz5eEseZIEsjh5FJBPFhLJAwSRCoo8IlAu0I=;
        b=q4LjKoYaWxG2uB4CS4yv3Z0kpbL6qtovP4IIEndvEOIv1NP3OSyrD9/8sRnimjB90U
         eCg2wzmfjVmNAI7WHYJrTePYUIwjT4Lrom+TQs9BhnLnXtjpOBzniMluYkbajlImUqAm
         uPC3dqcjR7cTlJAlJ2wUFRuGY/iCmKML7OUZBvFY1r6OLRjelInN2sQTKzGVPhG2jgxo
         bMMa5TKbWeLIxr7UDOfUPqGLTs5CwNetiWQ5iKuSgmHj2eEfai4RakxNeYJutBPmRG8D
         3CVndG6sY6p7jXE3Qot+2kg4jpTYafonjNOY524gs6ZIs/bOa2BD4ZWe3kJs+ZzzCfKw
         rDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688499341; x=1691091341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vn24u4tGz5eEseZIEsjh5FJBPFhLJAwSRCoo8IlAu0I=;
        b=SA+Q+U0863z/5OfhTFL1wPxQXhICEtqEIwnucwOKFz9Hw7o9rwZeso3FmuQrO35Ouy
         8rKIhSWEL7AGvomPFpGBU9Rl4Q/xUwys6cF4riOxYdbliovAbs0bo9VJPEkG+BVYEkbq
         dk+LTs1LxSmLaHdDbOkOvVhnrD5COHufuFysw79MHyemYPZi5ctvnxV8HOZyPeNbRDJj
         FWpsZfUIxiqev7qQPa9XMzXW6mWjCSsFlr9QYEAkcO1fZqFy+/5IR4ldix9tNiwF/3+y
         /jkFUikfUZw6iZaFEqCntbLgvft5yBZnfyqdwtgzdUYfen/ch4SzaZYX4ve4UhEkhYMF
         I+nQ==
X-Gm-Message-State: ABy/qLbBlMlXHXWGkdCQsBiYaIanEMdwLqtsM/r4hOqPhG8/b1RxQga6
        tAUEFvRf66iNh1bwyGEiTpHIqUcUayqnvQ==
X-Google-Smtp-Source: APBJJlGEWXnjNowmsWDVqc5kXgZ3X1fvFlVbb1B6+CflFNh/G4kiNoIBy0MPd8v7dLuO+pZ/D92Diw==
X-Received: by 2002:a92:d48e:0:b0:345:aba5:3777 with SMTP id p14-20020a92d48e000000b00345aba53777mr14265177ilg.25.1688499340643;
        Tue, 04 Jul 2023 12:35:40 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:2c51:ccb9:9db0:5657? ([2001:df0:0:200c:2c51:ccb9:9db0:5657])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902968200b001b7cbc5871csm12763666plp.53.2023.07.04.12.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 12:35:40 -0700 (PDT)
Message-ID: <e50347e0-0545-1a0b-f094-8e93329c30f3@gmail.com>
Date:   Wed, 5 Jul 2023 07:35:34 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] block: bugfix for Amiga partition overflow check patch
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org
References: <20230704054955.16906-1-schmitzmic@gmail.com>
 <2023070456-vertigo-fanfare-1a8e@gregkh>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <2023070456-vertigo-fanfare-1a8e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Greg,

On 4/07/23 18:54, Greg KH wrote:
> On Tue, Jul 04, 2023 at 05:49:55PM +1200, Michael Schmitz wrote:
>> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
>> fails the 'blk>0' test in the partition block loop if a
>> value of (signed int) -1 is used to mark the end of the
>> partition block list.
>>
>> This bug was introduced in patch 3 of my prior Amiga partition
>> support fixes series, and spotted by Christian Zigotzky when
>> testing the latest block updates.
>>
>> Explicitly cast 'blk' to signed int to allow use of -1 to
>> terminate the partition block linked list.
>>
>> Testing by Christian also exposed another aspect of the old
>> bug fixed in commits fc3d092c6b ("block: fix signed int
>> overflow in Amiga partition support") and b6f3f28f60
>> ("block: add overflow checks for Amiga partition support"):
>>
>> Partitions that did overflow the disk size (due to 32 bit int
>> overflow) were not skipped but truncated to the end of the
>> disk. Users who missed the warning message during boot would
>> go on to create a filesystem with a size exceeding the
>> actual partition size. Now that the 32 bit overflow has been
>> corrected, such filesystems may refuse to mount with a
>> 'filesystem exceeds partition size' error. Users should
>> either correct the partition size, or resize the filesystem
>> before attempting to boot a kernel with the RDB fixes in
>> place.
>>
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Fixes: b6f3f28f60 ("block: add overflow checks for Amiga partition support")
> That commit is not in:
>
>> Cc: <stable@vger.kernel.org> # 6.4
> 6.4.  It's in Linus's tree only right now.
Sigh ... I should have followed that tree also. I had wondered why the 
patches hadn't shown up in Geert's tree yet.
>
> But yes, it's tagged for 5.2 and older kernels to be added to the stable
> tree, so why is this one limited only to 6.4 and not also for 5.2 and
> newer?

Brain fade on my part, same day (and situation) as the botched Fixes: 
tag, sorry.

I'll correct that, along with Geert's comment regarding the commit 
description.

Cheers,

     Michael

>
> thanks,
>
> greg k-h
