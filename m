Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F204EC433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7905613AC
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhJEPIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhJEPIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 11:08:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C320C06174E
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 08:06:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b8so68711edk.2
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B8uXCv2C6+GSSeMdgdBton+YbzKIB7LnM1rY0GCnX/g=;
        b=ZkU1b4eHiCIl1eIHdsqKrZr4cUqDLqtQV9NogsR4nI9wxXtjsiyLrpO61hKlWYbwYg
         yUGmtKB8J9QWxlC/syD0OljNCUC21vlGu9vdaKpheEN2AUmGnJh3C9gdk6hkbxSGgNQ4
         WHI9TGxgUJG6dzTylLzaQf36iQjl2YHEKe32wQGwJqi9B94MMRXKN3csUq/ZiEzsKRm3
         03i6DdtawHPhO7PvrTlvyAP1yAI3Du2Zxkr4GE5zd4vc3ZkWWW/6BIX1FqvABXiC8fzP
         2hQ8fE+C+30/PDgXq5HwU7vFW6eWAjEekPrgeSxQuylO3hYIK2X+4zzcO9C7fXFA5cP8
         uBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B8uXCv2C6+GSSeMdgdBton+YbzKIB7LnM1rY0GCnX/g=;
        b=q7JJOKvBrJB3N9skcxr+GSSPajICRIGIyDgYdWJ0ek3Kuu0D3TWcAnccXZnvyPAPBF
         G1uywwh7f3TPvfURaSA+3HQpAXunIXpb4rdHbKLhsMzl8LZvQsDJBtu3OivRo50yQBef
         yTS6P03QMwv7pX3F7Y9BgcREfqW4Z7lU3SG/yqA9wPjugpnyGzG4l4t4qiI3xwZe3P36
         yeCv2Ghc4G6YFq2P/U6lYFeX7g2xeHzRUQS1Zc1nCbSRKncVG8fF6XRPhulAyxBlwKPw
         MB5429FYq+jCKNRP3UaNQcTy1CNut/AL9uQV2u7wwfwGL197kbXY1S7tV3JBcpRaMr3W
         hRVw==
X-Gm-Message-State: AOAM531HI5/9rVa7YV4kEoNivtufoxabz0ht9Md/prVqdA3nybD+Ev2b
        ukk4WUGpqF2j9NUcWV0JpMm3ow==
X-Google-Smtp-Source: ABdhPJwcdJXnqbNIwfAFbrEZqAHd3YOfj6wW0VUlQIIPdljisx0oDY7gDey438t9NasjjDzrUoTFfA==
X-Received: by 2002:a17:906:1806:: with SMTP id v6mr25810713eje.420.1633446402723;
        Tue, 05 Oct 2021 08:06:42 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id u16sm7776526ejy.14.2021.10.05.08.06.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 08:06:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [BUG] kernel BUG at mm/slub.c - possible BFQ issue?
From:   Paolo Valente <paolo.valente@linaro.org>
X-Priority: 3
In-Reply-To: <1889051823.161943.1633100469857@office.mailbox.org>
Date:   Tue, 5 Oct 2021 17:06:40 +0200
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <C9A02A5F-1713-4A42-B923-FD1D636AB4C8@linaro.org>
References: <1624640454.149631.1632987871186@office.mailbox.org>
 <1889051823.161943.1633100469857@office.mailbox.org>
To:     torvic9@mailbox.org
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 1 ott 2021, alle ore 17:01, torvic9@mailbox.org ha scritto:
> 
>> torvic9@mailbox.org hat am 30.09.2021 09:44 geschrieben:
>> 
>> 
>> Hello,
>> 
>> I encounter a hard freeze on both 5.14 and 5.15 when using BFQ.
>> Unfortunately, I do not have a full error log, because the computer
>> totally freezes and slightly corrupts the display, so it's
>> impossible to read the entire message.
>> 
>> However, what I could get is the following:
>> 
>>  kernel BUG at mm/slub.c:379
>>  invalid opcode: 0000 [#1]
>>  RIP: 0010:__slab_free
>>  [...]
>>  Call Trace:
>>  bfq_set_next_ioprio_data
>>  [...]
>>  bfq_put_queue
>>  bfq_insert_requests
>>  [...]
>> 
>> This issue appears more or less randomly and it sometimes takes a
>> little while to reproduce it (running fio helps).
>> The call trace always contains references to BFQ, but they are not
>> always the exact same. Once, I could see on the corrupted display
>> the message "general protection fault".
>> I could reproduce this issue on two computers.
>> 
>> Not quite sure but I *think* the issue first appeared somewhere around
>> 5.14.5 or 5.14.6, during which time BFQ only got the following commit:
>> 
>>  (88013a0c5d99) block, bfq: honor already-setup queue merges
> 
> I have now reverted the above commit and launched some heavy I/O like
> e.g. git kernel, fio, xz compression, and so far, no freezes anymore!
> Too early to say that this commit really is the cause though.
> Would be great if someone could have a look at it.
> 

Hi,
sorry for the delay and that you very much for reporting this crash.
I have prepared a dev version of BFQ, to try to solve this problem.
It's based on a 5.12.0, and should hopefully provide more information
upon failure.  Could you please give it a try?  You can find it here:
https://github.com/Algodev-github/bfq-mq/tree/dev-bfq-on-5.12

Thanks for your help,
Paolo


>> 
>> 5.13 doesn't seem to be affected AFAICS.
>> 
>> Does anyone have an idea what is going on?
>> I will now revert the above commit and see if that helps...
>> 
>> Thanks,
>> Tor

