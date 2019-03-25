Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B482C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 18:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5076320685
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 18:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yjKZ5q13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfCYS6u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:58:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40572 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfCYS6u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 14:58:50 -0400
Received: by mail-io1-f65.google.com with SMTP id d201so8574277iof.7
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0vwWzs4unHr15vdVdbJSqfRtqs43ocGv745aisT0yZ4=;
        b=yjKZ5q13htmUWjaTUHM5wOuTcCkARG8A6DDuHJxA2qWCsKRcxjmIwOOEAwqS3HNB4B
         hiCKBP6/qlfPjw1rHZximf3zIjj5VXbH8Oef24QlNVWghyS8dEdVodD0FsvPm1H7iMxW
         6qxrMaFntDtc7/ry4zCgznyD74ONPeZxCBMaKtvG4elR1zGYdy5G71htHgZPeEMpz+3A
         cNYOXI8EPRqhPTFJ8LN6OMbkQPNvuCYRNRvuZYFKeMikvFbipNmDSu9X9Zw3HOh5c4LG
         PpqrJELrjNy6XCsoCei1hYbaLuODMPSmE0KC25lsD396WPyqLHXX+AkDIU2VmI5j2Rob
         xQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0vwWzs4unHr15vdVdbJSqfRtqs43ocGv745aisT0yZ4=;
        b=cyi67f7eJeGS1zUspC4qXpFOMw27ybyH3OQ/KH3Sg5+2eSX4RRUEV3imtqjL6idS9L
         YMTEKdYPdJ74vDBCNBk8WeT4z9qt5mYwdY0DaxmvOMZohyvSh+3bvdYeYYopA6QV4hfh
         qIy7mjVGHVun/T6kuOnhuJoP1j/zecJng3eGqxJEn78DZRG2Chitx2KvkwJK5hK6dAKl
         aQwhzI0cYfGnvZnU9u/fKbK8m4trTXw0EdK62cY60/OCDc3CuIVw5QQNIzlmUYswGAuH
         /V/UIPWJMSThrFEoLSJEKbZWhSD2vj8cvv8DXnTJAmXLd2L7Vm3tWya9sbrZDrB5ynN9
         o3RQ==
X-Gm-Message-State: APjAAAXD+pDp0OSz9GkkhXEnzifWiICGM+GLQcOk9gENOb0V9ydq0eeP
        8Xz1cywXDfLIFcGGsYn013vU6Q==
X-Google-Smtp-Source: APXvYqxjCK2b38ueKKI7mzQ1noI14yDtE/xB8fiAQoozjhCmQZa395N4O4IqrW7WFtRKMe36vx+iRQ==
X-Received: by 2002:a5e:8418:: with SMTP id h24mr17449667ioj.170.1553540329490;
        Mon, 25 Mar 2019 11:58:49 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b7sm7301420iod.9.2019.03.25.11.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:58:48 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix sbitmap ws_active for shared tags
To:     Omar Sandoval <osandov@osandov.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
References: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
 <20190325185635.GF5826@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ed3aa61-e12d-2dc4-2a8d-e9cc02788371@kernel.dk>
Date:   Mon, 25 Mar 2019 12:58:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325185635.GF5826@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/19 12:56 PM, Omar Sandoval wrote:
> On Mon, Mar 25, 2019 at 10:22:50AM -0600, Jens Axboe wrote:
>> We now wrap sbitmap waitqueues in an active counter, so we can avoid
>> iterating wakeups unless we have waiters there. This works as long as
>> everyone that's manipulating the waitqueues use the proper helpers. For
>> the tag wait case for shared tags, however, we add ourselves to the
>> waitqueue without incrementing/decrementing the ->ws_active count. This
>> means that wakeups can take a long time to happen.
>>
>> Fix this by manually doing the inc/dec as needed for the wait queue
>> handling.
>>
>> Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Can this use the helpers we added in 9f6b7ef6c3eb ("sbitmap: add helpers
> for add/del wait queue handling")?

I don't think so without adding more, which seems kind of silly for this
very specialized use case of openly manipulating the wait queues. The
blk-mq setup there is very special cased.

-- 
Jens Axboe

