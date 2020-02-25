Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34087C35E09
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 15:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BEE2082F
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 15:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgBYPjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:39:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44332 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBYPjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 10:39:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so15224184wrx.11;
        Tue, 25 Feb 2020 07:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:reply-to:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UydO7AEhxXmWMXVvC3vVfDa/G7mimTMlc7pcI/QW8UE=;
        b=uQEDo8FZRWIkQp0CxBMRVYO+OwFDqvAIshGZ1DBPQpPxxFHmL6zDc9HTv4v5Yib2Sn
         ZvutI1eeapNmIIX4y8HA4/aLckFiGqdaSsihlxOMXkmE7MwdEDixRB+SnXNDJr0jJsQU
         LwB+8KEuIwb+iktqm/ALmjGvgdETaFFh/ymLEIlKR1jez+ksTliUz5ogfGpysNIt+KS4
         6r4sJV11Wu0ivLiy2lqd2ui1XcCx5ep2aAydNG4PgcPp/eV+fQfKl2G9yoJvLOalM29L
         e2v4mmSswc4R+1txeIhQ36/z1jO2OcPRlgKfSYrr5NKNTtfiii7YoAIrblN1M/B2L7Bn
         DKeA==
X-Gm-Message-State: APjAAAXTZLj7KqHtG0RIoEG3pglWyCnRY1otajxQXb9Gw2XQc7Y+R43d
        G9WCa/HXMks3nKbsU3eZDk4h4IXY
X-Google-Smtp-Source: APXvYqz4ZE4l1iYQzAmhUYFA4PK1pJy8s9XpgPlBUJai74tCM6qjwwFu6sdA79h+odNmaidqxTOWuw==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr7754925wrq.250.1582645147719;
        Tue, 25 Feb 2020 07:39:07 -0800 (PST)
Received: from [10.10.2.174] (winnie.ispras.ru. [83.149.199.91])
        by smtp.gmail.com with ESMTPSA id f8sm23180403wru.12.2020.02.25.07.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:39:06 -0800 (PST)
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
From:   Denis Efremov <efremov@linux.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: efremov@linux.com, efremov@linux.com
References: <20200224212352.8640-1-w@1wt.eu> <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
 <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com>
 <20200225140207.GA31782@1wt.eu>
 <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <9c22a4ce-1108-d1aa-49c3-5fe7c3bb74f1@linux.com>
Date:   Tue, 25 Feb 2020 18:39:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/25/20 6:22 PM, Denis Efremov wrote:
> As for now, I can see that only floppy.c includes fdreg.h file
> with define FDPATCHES. If it's true then #define FD_IOPORT 0x3f0 
> branch is never used and we can try to fix remaining FD_* macro
> in the next round.

Ah, I forgot that fdregs.h is uapi. Thus, we can't simplify FDPATCHES.

Denis
