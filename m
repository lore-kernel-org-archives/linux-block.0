Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B74360F36
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhJROMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhJROMd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 10:12:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B5EC02B773
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 06:34:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id m20so16231548iol.4
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PLWUpvXzTRM3ZdlVsqIHX7tBJZOoYIm8l9HYuwtamdk=;
        b=nTX3ITStR5uVBdqiAmqYz8eitipnWOX69dQuwfzmou3nAbUN9HOn9oM2b7Z+Yh75mS
         ej13zCLq/TL71aP/ZGWkYsVNxYxy6WGSu+pX0OSNyHiOPDelTuova1FQSfVs91+zX2fQ
         dozFOyuzXLZ01l2d/kCzll+0W05zwyrvp+4cTHav8ZJeK7xvAluPALFavNTtHkEgwn3v
         8chbotwTgIXI3YKDmce53GtUa72FI7RLaZZMMbKMUReM0Qd7HhiArORIM2rPgG4U3Go9
         zS4OF6YxdYxNFtiodgO3kakfWKnVuZwMrqVZUJMusUdNHWAlVqq7hUByTBhmwmAqT1xw
         jtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLWUpvXzTRM3ZdlVsqIHX7tBJZOoYIm8l9HYuwtamdk=;
        b=50/ZvyCT/Zr9b94WpIuWUa2pItVY70WKB1eeu+2gMszwvOvWPyT8ehjHXf58GZyoaf
         AMcMrOVjW/FXw1r1RnSS70ny3Fok4/2ioS1iq0YK7gkDZUAEARQ7MQfBLg2tWRpnZkOd
         Ml6UsVi7jjfoek3QK+qtrLKCjDLN6iJugC5i4uTkqtxI+BQ49mSp3DPJ0rQ4fqjPDb1B
         2aNEUww1NOqRL2Zrm+m2H6KqoseyCbOXloM/v2AYiRkQAw1zII4YBbBv8k5CNBG6O/xp
         LMn5Y+h7lTnbKLDp3QBXzqbIEEmDYbPDmqUb466mOT927JP083M+eXPFrtsyImlDGJYt
         cCeg==
X-Gm-Message-State: AOAM5313vxS2bNpVtrqHLjPKAyAOxl98ncfCoRYqsZC52FDbG/euKARG
        i8QYbW9xNjBZXbvgnrb4GNRywInEIC/UTw==
X-Google-Smtp-Source: ABdhPJzKKFW3wiaIKfdfF0o9pBLLL5LKttQhI1O6Cq+lPksA7SzibC6TUdbapKIBgvRJvkJQ6DL41Q==
X-Received: by 2002:a02:9609:: with SMTP id c9mr18723529jai.118.1634564092615;
        Mon, 18 Oct 2021 06:34:52 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id r9sm7177215ilb.28.2021.10.18.06.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 06:34:52 -0700 (PDT)
Subject: Re: [PATCH 07/14] block: change plugging to use a singly linked list
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-8-axboe@kernel.dk>
 <05bc77d8-2483-12a4-5ec3-519a59c6b1c2@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32e8015e-31f4-f43d-6a0a-a48b639dabe2@kernel.dk>
Date:   Mon, 18 Oct 2021 07:34:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <05bc77d8-2483-12a4-5ec3-519a59c6b1c2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 6:56 AM, Pavel Begunkov wrote:
> On 10/17/21 01:37, Jens Axboe wrote:
>> Use a singly linked list for the blk_plug. This saves 8 bytes in the
>> blk_plug struct, and makes for faster list manipulations than doubly
>> linked lists. As we don't use the doubly linked lists for anything,
>> singly linked is just fine.
>>
>> This yields a bump in default (merging enabled) performance from 7.0
>> to 7.1M IOPS, and ~7.5M IOPS with merging disabled.
> 
> block/blk-merge.c: In function ‘blk_attempt_plug_merge’:
> block/blk-merge.c:1094:22: error: implicit declaration of function ‘rq_list_empty’; did you mean ‘bio_list_empty’? [-Werror=implicit-function-declaration]
>   1094 |         if (!plug || rq_list_empty(plug->mq_list))
> 
> 
> Also in blk-mq.c and others, and I don't see it defined anywhere.
> Used just fetched for-5.16/block. Did I miss it somewhere?

I forgot to include this prep patch:

https://git.kernel.dk/cgit/linux-block/commit/?h=perf-wip&id=b3ca14988ce2eb125a8a80c3ee146f3ad55cfcf4

-- 
Jens Axboe

