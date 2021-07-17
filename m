Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B8C636C9
	for <linux-block@archiver.kernel.org>; Sat, 17 Jul 2021 09:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8909B613C3
	for <linux-block@archiver.kernel.org>; Sat, 17 Jul 2021 09:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhGQJoG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Jul 2021 05:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhGQJoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jul 2021 05:44:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0128C06175F;
        Sat, 17 Jul 2021 02:41:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d1so6590082plg.0;
        Sat, 17 Jul 2021 02:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5yIJkQt3GFQl4d9x0leKlizsNtZXqf9kI+djIJdlY34=;
        b=jDur00L7znCQBRdMT8eZ6uE1OzbeM3CVkJa9zGog9JRTEtDpGcj1VgX88idel9uiDJ
         iQ8BBLIVgmvxe1rapcEoe9/84mcIURsjYwKS5fJSwMYA519Cv6tUXfCV2pfbzDQW/rGM
         qVKQdzJeZDmuax4Zcoi1ZuXBC+X6FrXIOVWeHSMaPZtIBmrleP0zy6fWRd12iMBZ2HAk
         2YONGql4n7Eo6kJ5BFfmaG034Pj+J4JZxvKBbQjBCcdDOCC86Qc11IJ/Kqw1Kj1TA9QR
         e5FGhf8GeyVIRVLfgAUDQ28YzNTs/UE2eaX6u4YbTGap/SH1kXYH/2XeczyVZNWA008h
         WwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yIJkQt3GFQl4d9x0leKlizsNtZXqf9kI+djIJdlY34=;
        b=QUKo52JQaPC1vKc1S4ZsSqxYKBqb3FnGLlROl2Frks9KGzdc0ArrRNjpwUc2SRY1M7
         qvrbabWBgKlE1A2goEKn4V7ZCztgfDGuvRYGaki5xaT93iiSBKFFgD0/N/NZH/xVLExz
         CPNcPUvHmNEfI5NcrKuwIKTPKV4b7psREJ4eK/QSukV/mKHMkh/VjzRpbAh8dCuiKN5z
         I5ahzUgfmePTIUQ1bimZ20TrIarpwwuptwABK9cnWFn5WS9m30BJk1f2rwnHvwG/i7YA
         8vgf+AU4qzHbpd6GZaKLuqVSh1noI4vrHFvtrdIwmoVR5SCvov/eelus+1LqnvG5IerC
         au7w==
X-Gm-Message-State: AOAM53399BgXx2jDGxZjX92J6ao0EhR6Qsaa/eOILAfsJ61XqkHXRbT8
        OW+wrs7e+I8ixwd72nMKQDQ=
X-Google-Smtp-Source: ABdhPJzLbnHsYSoN6Jg8HyvVaZLw+r9Ux8iqDqa2h+aIY7KU5LHIY9tdpM7rwrjR6FPD4/czUOFERQ==
X-Received: by 2002:a17:90b:1010:: with SMTP id gm16mr20332240pjb.192.1626514868316;
        Sat, 17 Jul 2021 02:41:08 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id q21sm13043739pff.55.2021.07.17.02.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 02:41:07 -0700 (PDT)
Subject: Re: [syzbot] possible deadlock in loop_add
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+118992efda475c16dfb0@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ec01e405c6c2cee3@google.com>
 <20210710131638.605-1-hdanton@sina.com> <20210712052740.GA8599@lst.de>
 <c3d4ebd5-5679-cd81-d1de-4f5f2cbe13db@gmail.com>
 <20210716010028.4218b0de@xps13>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <77da708c-b63d-dac0-c7e6-43ced0d49982@gmail.com>
Date:   Sat, 17 Jul 2021 17:41:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716010028.4218b0de@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16/7/21 7:00 am, Miquel Raynal wrote:
> Hello,
> 
> Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com> wrote on Mon, 12 Jul
> 2021 16:29:16 +0800:
> 
>> On 12/7/21 1:27 pm, Christoph Hellwig wrote:
>>> On Sat, Jul 10, 2021 at 09:16:38PM +0800, Hillf Danton wrote:
>>>> To break the lock chain, un/register blkdev without mtd_table_mutex held.
>>>
>>> Yes, Desmond Cheong Zhi Xi sent pretty much the same patch on June 18th
>>> (mtd: break circular locks in register_mtd_blktrans), but it did not get
>>> picked up.
>>>    
>>
>> I believe Miquèl was waiting for -rc1 to apply it.
> 
> Indeed, I already applied it but did not advertise yet.
> 

Thanks Miquèl!

>>
>> But taking a closer look, although the fix for the register path is the same, Hillf Danton's proposed patch additionally avoids inverting the lock hierarchy on the unregister path. So I believe this new patch should be more robust.
> 
> We can definitely do this in two steps if you want.
> 

Sounds good, I'll prepare a patch with Hillf's suggestion for the 
unregister path.

> Thanks,
> Miquèl
> 

