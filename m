Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC01C282CD
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57B42183F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 00:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C3ZX4WuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfA2AzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:55:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38638 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfA2AzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 19:55:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so7987384pgc.5
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 16:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Av2wwZTKSuhz2t0+AX1q9j5HIZdT7zqpnF6SMoM1k9k=;
        b=C3ZX4WuZLTDIkTcS00lKsnZ9ITjjKCHdeXi0g2D6N0BTJv4t0/m5EAuyRriMlIevMw
         s4hZn2G0BaaTPYY2NpK7uDgxy68fXgZINY0aNHoHQvxNqYW8f35E6jzxYt9jw517620u
         ACx6r7yHDT+pFs6SZ9Rgo3e9Gwck/Nw0wlirl0cp/0s+jCmBomRPtD1VKZHSX4UG9gPu
         fkGkj8gL6Z8LLi0ec0brjMUetGrk/ITYDtfVZT88V96wquyEYJJyZhB8Ff5rHQLDtmec
         ZJztOZz/Ttv5u28jalzziR+ty3wD4ruscGjgWVSO7laCbgn+Aj0wT/Bf6uxBzvStOSj4
         jD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Av2wwZTKSuhz2t0+AX1q9j5HIZdT7zqpnF6SMoM1k9k=;
        b=VB8Mw9Rcwnb6/539DOmSfQ8OEV24pT4RB22HtfIpGvHJ1sicS1xusGbdFV4jyoNSAF
         jeUAsh42etaN9zM0nrZXJzGyzMtRROjjzAk1orvy9Zu2Y/5ReitR6vaSrQAwxAjaATkb
         gspjcl5MEj5Rp7AdQpm4crAVjLqiURtQ4gQexp3fiTfwHcYU3xDRHTdrHzykMUzp4LSv
         w811UQNriIAhvAcxhi6psn3RW4J0SgZgFRZBGX4SfT+ydU72M4hl7b0Xz6CH/oqeTBAB
         HVS+LtifqZzW3h/tCjTHM8bSHhGgcPtUOLRPaB2tuQyVirBSiKqBL+ky/6kjVELSegYm
         1Oqg==
X-Gm-Message-State: AJcUukcp7pbjiZooLBJEFg38NAsNO0sd64wFLmJYaMcWntUtyy/RLsXD
        gRqMziIx3otRslI6iHd/0IrrtQ==
X-Google-Smtp-Source: ALg8bN4BatF11hSK6QzugLUstuEVcmHmTo7Sz7h/+7NHHtBimKhDSGZgl2l2ni63tmh1N56/2PtwfQ==
X-Received: by 2002:a62:425b:: with SMTP id p88mr24441416pfa.137.1548723321747;
        Mon, 28 Jan 2019 16:55:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 78sm50525408pft.184.2019.01.28.16.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 16:55:20 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez0vDqDH4ks7q4L3F+xt-4kVQrN1yw34QwFAmwQyy27FTw@mail.gmail.com>
 <e9326a77-54c5-e2b8-d9e5-663261462597@kernel.dk>
 <CAG48ez17NW0GJVRC6dFcHZTgQifFz5og1XCUbXkHKhr6f=j74Q@mail.gmail.com>
 <c20a1250-9f3f-a286-9baf-5b71db0c128f@kernel.dk>
 <51c759f4-7ce5-182b-98e8-2c0e99ca4f9a@kernel.dk>
 <CAG48ez3XGjFZbPiof4u4QGtoumBXXfCsFxOQ_2pGt=MnqqY7ZQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a89d28dc-d0c4-d84e-b3f2-20d10c6f673e@kernel.dk>
Date:   Mon, 28 Jan 2019 17:55:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3XGjFZbPiof4u4QGtoumBXXfCsFxOQ_2pGt=MnqqY7ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 5:34 PM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 1:32 AM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/28/19 5:03 PM, Jens Axboe wrote:
>>>> But you only do that teardown on ->release, right? And ->release
>>>> doesn't have much to do with the process lifetime.
>>>
>>> Yes, only on ->relase().
>>
>> OK, so I reworked the files struct to just grab it, then we ensure that
>> doesn't go away. For mm, it's a bit more tricky. I think the best
>> solution here is to add a fops->flush() and check for the process
>> exiting its files. If it does, we quiesce the async contexts and prevent
>> further use of that mm. We can't just keep holding a reference to the mm
>> like we do with the files.
>>
>> That should solve both cases.
> 
> You still have to hold a reference on the mm though, I think (for
> example, because two tasks might be sharing the fd table without
> sharing the mm).

Yes good point, except we can't hold a reference to it. But I think
we can get around this by using an mmu notifier instead. That eliminates
the need for ->flush() as well.

-- 
Jens Axboe

