Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C99FC43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434F7218EA
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nA3v0Op+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfABSKz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:10:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40545 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfABSKz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 13:10:55 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so39710354ita.5
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 10:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ULtSJ1U05vNUljckl2z7wbeqdVpCxUWiFv5LN7nAdIM=;
        b=nA3v0Op+y7PBkwCMo6fSTnvJPS0mdHs+SKcmH2dEqiRBGbLIQUrM4CelsSeS6jM+NM
         Nq6gwL05B8nuvaA5noqlrnZG6tv1ErD44KDX6dE7lcXHk5eQYYsPsgBgDoQB6s4IUzv3
         +lcqZCDJo9EpRwSWEazKfvD5FtcSkF95+JBnXuBOlRe0x2dPE3YQCv+H+mIfDCeNigzX
         0yYwYg2Ig4pHRIsuS2RIYxpFVFsHp8A+rjzn8uZbPHMBuHNJIAEgVTnnzTrh7rcxq2w5
         posU1MkLj1ZKe7i3oFzzlu33ggyGSuAL1rZcGZhbLsgFJzQTpVOVFn7vuOttvUUQNSMc
         rlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ULtSJ1U05vNUljckl2z7wbeqdVpCxUWiFv5LN7nAdIM=;
        b=ujc7N6R23tKKMFQCK52/HqlIagHcQkoK7sni3UoeNK2kbPuXqPn1OANuv8AtIJbFA4
         BEsPcJVa7hoc+tYK5xRzrSGxeC/m2x0ULZeGwaVWuEyWYbI+JFMY8jrc21iBJ9AbFnWB
         +4IjgHJeRAURDaNZ3jfFmdIIroEKct8IbNQkQFw/wVc+TMdGxMBeda2CyBysUmAp+bIm
         9grEQGdrSXJnKUD7n4nKmOKzLNUeadH3Z7yikZLxgaT/Kuhz1X9ckUAZj+LXNnjPD3ge
         TlcRhJ/XolWbpMlTU21IVzdbW6Vyq64zqqmr5HvRrZfRJN+KHSNRMLI668BA58LO/6ad
         q3FQ==
X-Gm-Message-State: AA+aEWZvRX52dtzuM/QP6ugkeg+HroQgX2pOaJ1tmkZCKa0hEADLgobG
        RXDrl8NrfGjkNXumnQ/+MrqbK5DcbuhyAg==
X-Google-Smtp-Source: AFSGD/UCEr7e3GE7B3Y5g7wxij9edGj1mbKogV04tq+6Ayln2TJ7oHgJfuFb0blb0EiqN23ehY+xTQ==
X-Received: by 2002:a05:660c:128c:: with SMTP id s12mr22655901ita.145.1546452654112;
        Wed, 02 Jan 2019 10:10:54 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v3sm7170302ioj.79.2019.01.02.10.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 10:10:53 -0800 (PST)
Subject: Re: block: only use __set_current_state() for polled IO
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <181e0aa7-34a5-5445-70b2-45770a81659d@kernel.dk>
 <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0734f570-f9f7-f775-84d5-3ed22388e3c0@kernel.dk>
Date:   Wed, 2 Jan 2019 11:10:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wicNcMhY_YCkT5Nsdcxake8x+sfYUByvbhTzp2v-LWjeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/2/19 11:07 AM, Linus Torvalds wrote:
> On Wed, Jan 2, 2019 at 9:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> A previous commit deemed it safe to use __set_current_state() for IRQ
>> driven O_DIRECT, but that's isn't necessarily the case. Be safer and
>> only apply that optimization to polled IO, where we know the the task is
>> going to find the completions itself.
> 
> No.
> 
> We're just reverting 849a370016a5.
> 
> There is absolutely no point in trying to avoid a memory barrier that
> is maybe 15 CPU cycles.
> 
> Stop this craziness. The optimization is garbage. If you want to save
> 15 cycles, get rid of code, don't add new code in an area where the
> block maintainers have already shown that they can't get it right.

Fine, we'll just revert the damn thing then.

-- 
Jens Axboe

