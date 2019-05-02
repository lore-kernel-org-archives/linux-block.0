Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BECC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BD92081C
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d5ZSg00H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfEBUkj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 16:40:39 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53392 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 16:40:39 -0400
Received: by mail-it1-f193.google.com with SMTP id l10so5782168iti.3
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=E/6243D7cwm/o/1nfYPe7eanDrUoMQqI0D5RP38kfwk=;
        b=d5ZSg00HHl2AqPq+73eileabYHgMpy7hG+4B5EN0zMesTDNx1z+J3SHPRMiSM6Fct0
         DNupg+DXV6Oe4FiT9BpNHLNNO6C2CqaUrjXDqWzS7CbME9YLSfDEE/p0b6Ho7WRAjpTb
         hE03JLQpDeU8nWJydOpbX418Aq7XCFmYF+RGurpItuUB5sD3EIK2JtCtKvOAk1/ogLKD
         Rt6c9IFIJS7Kr7LeHp5Hv+VWWII3MujWo1DUjpoJc5sEHZmgJhdZBDZuFxN8jkzrGf2i
         5272i5tlu2vhnal/x+IztXpWnXxN6VvYCHSRIzMOwNHDOrcd0rz58mKMtZUfsGlq/Bo6
         3VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E/6243D7cwm/o/1nfYPe7eanDrUoMQqI0D5RP38kfwk=;
        b=LjPnVBU0TOxNNEmqAla0wQTMdddu85+N6WqH/4uyxHj+j2+/oSnlH7zwhgfJ5N+Elw
         gLWCB6mRYsjKeaRXL9+HYbAlWOmB3vVmmcVOsOpgUc2WncQA9GYhVK2/akJvQxIBkF8E
         wuj5tnCuf4JYQ0OM+C+yB8Fj5tN+UZkK7MPHNZmyzaU4iNVyUOaB4bRXnUrnYwkPt2yj
         wU9TFcp0z1ILg/CNFY5z21IivmojQCwJ2LcaYDPyNQUu/ndd35yIb4rHkVw3HJAtzxFK
         ccC/y/jdS4T/i/FFZbpbUa8JnANCWd5l1UNXqeY+GAwhrP5D0bcxYaiMOFWbR3/n+ERX
         aiWg==
X-Gm-Message-State: APjAAAVGJeOyu2qUxsiqBVWvqiy+JPSAqXN8r2GCA6lwq3W7MnxvQRUU
        U6Cqb8Dmc55Yuym+jH47AU8XgviHiWm8TQ==
X-Google-Smtp-Source: APXvYqz+XjmIuPkQCfpNh3XYj1Y75NapuldWyTuJfmsHnGHFKNSSJUup+U08nYWJmXafxgMSco3Y7w==
X-Received: by 2002:a24:c545:: with SMTP id f66mr4004140itg.114.1556829638148;
        Thu, 02 May 2019 13:40:38 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l191sm274151itc.8.2019.05.02.13.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 13:40:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Introduce bytes_to_sectors helper in blkdev.h
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-block@vger.kernel.org
References: <20190502015728.71468-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10f928d4-25a8-0142-fe80-7b5d7a0aef90@kernel.dk>
Date:   Thu, 2 May 2019 14:40:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502015728.71468-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/19 7:57 PM, Marcos Paulo de Souza wrote:
> Changes from v2:
> Rename size_to_sectors o bytes_to_sectors. (suggested by Martin K. Petersen)
> 
> Changes from v1:
> Reworked the documentation of size_to_sectors by removing a sentence that was
> explaining the size -> sectors math, which wasn't necessary given the
> description prior to the example. (suggested by Chaitanya Kulkarni)
> 
> Let me know if you have more suggestions to this code.
> 
> Here is the cover letter of the RFC sent prior to this patchset:
> 
> While reading code of drivers/block, I was curious about the set_capacity
> argument, always shifting the value by 9, and so I took me a while to realize
> this is done on purpose: the capacity is the number of sectors of 512 bytes
> related to the storage space.
> 
> Rather the shifting by 9, there are other places where the value if shifted by
> SECTOR_SHIFT, which is more readable.
> This patch aims to reduce these differences by adding a new function called
> bytes_to_sectors, adding a proper comment explaining why this is needed.
> 
> null_blk was changed to use this new function.

Maybe I'm alone in this, but I much prefer seeing this:

	sector = bytes >> SECTOR_SHIFT;

to

	sector = bytes_to_sectors(bytes);

The former tells me exactly what it does, the latter I'd need to look
up. I do agree that any hard coding of 9 should be SECTOR_SHIFT,
though.

However, if we are going to do this, the functions would need a blk_
prefix.

-- 
Jens Axboe

