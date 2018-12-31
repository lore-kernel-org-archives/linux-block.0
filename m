Return-Path: <SRS0=5hX+=PI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E475EC43387
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 20:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE3321871
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 20:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r13k9bB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeLaUK7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Dec 2018 15:10:59 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:38697 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeLaUK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Dec 2018 15:10:58 -0500
Received: by mail-pl1-f178.google.com with SMTP id e5so12946690plb.5
        for <linux-block@vger.kernel.org>; Mon, 31 Dec 2018 12:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fo0MqdAzBW+eUjTIj84EqQyGFsmvHIRwa0OFfbPpgxs=;
        b=r13k9bB1SJtsh5qSMU6ePgbjYOAAuTRlY1YmIFlElEY0RTwu6bRDkipE9W083dpS52
         F1FmLzs/0sp3xTseDv1Bi6KFCfD9J8ZYLQbZW0xOeoDdT4tY9+vd+2ujqKZi/ZNPKXf3
         TNnJYQqjVKNmgn7BvxJgdQW9A0jUyAx/2TtIm9YPygskjdgUb5W/qXJtm3X4MYq67cby
         8zN3Hvw/Jk8qlHePmLd0+ZM/yfgoLtmM59cBBU9Q8mSVbPPcV1MiD6P942M93LpCAO7p
         vpbNyeFdRTn/tb8beM960EgY4WzsJLUJFsFmnJ5joxnZBFE/mZfRFhvZ0Och5t3ktQRx
         hNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fo0MqdAzBW+eUjTIj84EqQyGFsmvHIRwa0OFfbPpgxs=;
        b=o1kWad8h2dKRAqkxeH5Kiv159RWqoygNwGgLdLwS0IZlIQlBudYINX/KG2r8R2CDDd
         9vIynd6kR5qu35WhGkf9OA5mHO/qjranbWEvfeHUgPhXKXZ5w9/iKAKHoTFxYEE/q1xj
         gRPkhiBbyMl1CdNMwtrEgev1NHFepJUpajg87Rwdx5KtG7E49zcjf9/3ecDgUIb3SxZx
         m6nnIWDvcAy+VA0dnyQf+mKKgbWVPhxKfuUdnphiJKCnE7xHaBY/weDUvWAMv8WNrsxd
         E/kzprk7JJotW+/3D4YNZ8Iku8rOpUtZ5iht4WxzrRJdbtEhFTGoS1htkA4c9igxx0l9
         NCdQ==
X-Gm-Message-State: AJcUukfcoie5rNREYk9LPcJIdQBlX0AY57CFsj8NIunSWhM75J5z8D4Y
        XRBuLFKsDLTpUihumv9cy+Kdpi7e72a9lA==
X-Google-Smtp-Source: ALg8bN4PAoCHHTJp0B8wm3eVvJfs9Xbu/6tTiYGi544xFUXHwU/tBqPlwM9UNHUGpFNaTPCEMeklTw==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr38821618plp.34.1546287057760;
        Mon, 31 Dec 2018 12:10:57 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm89213557pfd.104.2018.12.31.12.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 12:10:56 -0800 (PST)
Subject: Re: [git pull] device mapper changes for 4.21
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Sweet Tea <sweettea@redhat.com>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
References: <20181227160944.GA12190@redhat.com>
 <20181230090646.GB1022@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c761fb03-5bfe-9096-894a-36820983b7fd@kernel.dk>
Date:   Mon, 31 Dec 2018 13:10:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181230090646.GB1022@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/30/18 2:06 AM, Christoph Hellwig wrote:
> On Thu, Dec 27, 2018 at 11:09:44AM -0500, Mike Snitzer wrote:
>> - Fix various DM targets to check for device sector overflow if
>>   CONFIG_LBDAF is not set.
> 
> Question to Jens and Linus:
> 
> is there any good reason to keep the CONFIG_LBDAF=n option around?
> Less than 2gig block devices seem to be an absolutele niche, and I
> wonder if it is still worth maintaining the special case just for that.

I'd be fine with removing it, I seriously doubt that the extended
math is going to be noticeable at all.

I'll try and run some null_blk testing as micro benchmarks when
I'm back in a few days.

-- 
Jens Axboe

