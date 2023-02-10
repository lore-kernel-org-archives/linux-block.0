Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8568EC05027
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 22:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjBJWTp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Feb 2023 17:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjBJWTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2023 17:19:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADAE7F833
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 14:19:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id f6so7972343pln.12
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2023 14:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTZexV6UnQ3WdFBqEaIsqChIXbzh0DRq2ObR4zP1Gz4=;
        b=aUwZ+J1KOeoLZKuMoVs1lAdzAK3NVHSgIAaJoYocXSjs0lXBiSDvrjHBBPTg6BPHbr
         s2GmXi8N8TJj5lfOOfBN3vWk6ceC53sQbfMKySz/WWBuOvE/UpuH54k/kH7Bn1rr0fI9
         RYV/2octSuyyeT0B+zjgHSkt+atdAuhUP031d50v5+SO2Z6tqtjKhMfBWM/T5tHxKU4W
         1UZ+H1g2UpzXJ4RWKEF+/1VVNCJRbHaeWoF3X09JhrtJwtYrza6DkBJQ0VEOR9kWKVRn
         K+EXkHPE7KthGQja+KrZ3Aoy3Db8RhNk159fbwfZCdbfTSxagMCbm7FWB92a6+RRffeu
         nHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTZexV6UnQ3WdFBqEaIsqChIXbzh0DRq2ObR4zP1Gz4=;
        b=6XrTKZR4fnavL7QiQgirBPCmFtjPUrX/r8jBZ8nB7zudYeJo3fqmCO6zMBkyKh3nhv
         8AT9GBiNdeJye8LxXo+KMkO3r4e+MghtbEiWsciy41Woxf2z07ueqiHCEawRU27fdlhy
         HmmI5H344i4ERda4vwb+kC+imFAvdBCl5lLcBmN+4IhQXEZpc+j4vqWPGM01veQNeZJH
         TZYWHZ5fZYp9hiR+kuBO5cHZpbdb86s5DqzeYi8vzGRfm0VkJXc5eQAQUK7+q1izaMAK
         PbSBchn80NDwwrgYvWdlKznmtzeBuFyGC13tYhvWvMmBQORp3iYk9sgyDNjn2DbvgltH
         6WDw==
X-Gm-Message-State: AO0yUKW4Dp1TGDhDg5aQtacIFGrxXvD2mhK3a8tloQbcNgDXZ/3z7pLQ
        KjdinCtHJ6dAT5eT9kurYJdaPA==
X-Google-Smtp-Source: AK7set8Lsyg6mfxppzzG/ktXjmFOmEt/5QK/TCHl0fyi6S1W6CER1Y/bzjNS3X5BvsOfiY7PRkclDA==
X-Received: by 2002:a05:6a20:a01d:b0:bd:f7f:5d55 with SMTP id p29-20020a056a20a01d00b000bd0f7f5d55mr16894615pzj.5.1676067542980;
        Fri, 10 Feb 2023 14:19:02 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i15-20020a63b30f000000b004da5d3a8023sm3408303pgf.79.2023.02.10.14.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 14:19:02 -0800 (PST)
Message-ID: <c2bcca97-37a3-08d8-ac04-d9cfd8ff5e08@kernel.dk>
Date:   Fri, 10 Feb 2023 15:19:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/4] io_uring: add IORING_OP_READ[WRITE]_SPLICE_BUF
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
References: <20230210153212.733006-1-ming.lei@redhat.com>
 <95efc2bd-2f23-9325-5a38-c01cc349eb4a@kernel.dk>
In-Reply-To: <95efc2bd-2f23-9325-5a38-c01cc349eb4a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/23 2:54 PM, Jens Axboe wrote:
> On 2/10/23 8:32 AM, Ming Lei wrote:
>> Hello,
>>
>> Add two OPs which buffer is retrieved via kernel splice for supporting
>> fuse/ublk zero copy.
>>
>> The 1st patch enhances direct pipe & splice for moving pages in kernel,
>> so that the two added OPs won't be misused, and avoid potential security
>> hole.
>>
>> The 2nd patch allows splice_direct_to_actor() caller to ignore signal
>> if the actor won't block and can be done in bound time.
>>
>> The 3rd patch add the two OPs.
>>
>> The 4th patch implements ublk's ->splice_read() for supporting
>> zero copy.
>>
>> ublksrv(userspace):
>>
>> https://github.com/ming1/ubdsrv/commits/io_uring_splice_buf
>>     
>> So far, only loop/null target implements zero copy in above branch:
>>     
>> 	ublk add -t loop -f $file -z
>> 	ublk add -t none -z
>>
>> Basic FS/IO function is verified, mount/kernel building & fio
>> works fine, and big chunk IO(BS: 64k/512k) performance gets improved
>> obviously.
> 
> Do you have any performance numbers? Also curious on liburing regression
> tests, would be nice to see as it helps with review.
> 
> Caveat - haven't looked into this in detail just yet.

Also see the recent splice/whatever discussion, might be something
that's relevant here, particularly if we can avoid splice:

https://lore.kernel.org/io-uring/0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org/

It's long...

-- 
Jens Axboe


