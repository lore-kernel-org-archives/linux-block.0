Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D96CA9EB9
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 03:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B2D21655
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 03:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HxzHDgOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406488AbfJXD0p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:26:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39363 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403962AbfJXD0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 23:26:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so14199046pff.6
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2019 20:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/NWksTV0PRvK0uB0B/h5fw1zJ0CiUL0vTansYq11WNo=;
        b=HxzHDgOfmmz/Qf1h7AwsIFD8ehIQo3i4MTYKyewa91alB7n/RqiTrNl20bIWYungk6
         uRoN8rsIlmuMxrcwvq5S25Gn4Fe4BUgTdTHBWu25zQB3f3fPgsDMRRqe3yc9INWnoATb
         Wi0uFwXKho1uoC+YWjhsmVM3k5ccjdri1Yj9igOKec6wO2YWoz3G6wUpAISWEo7ffwvL
         CY8aOux7zDemAHRsGOyrxK2+zWgXrITrOd/T2HNHU4gSclvT90k1gyQk9XQYzyXgEgYw
         v/XjOPXDORDaYqxfmWtXPDB3VejgoSAlnSm9QxgzvPVP1Gra0USVIpAZZC2yZ9W/MVrZ
         LAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/NWksTV0PRvK0uB0B/h5fw1zJ0CiUL0vTansYq11WNo=;
        b=hieQC9WRAhZpv5Fi89u7ktmuthK7rEhx6iWKDerQqLImonuZDYmaZMdZp4yz+aqXnD
         aJg/t/gPl8ZWA3ENb7MVYNGBxiCRz0FtDXoAVSc41A+ZK71N385jtaKaQ3IkWNzkZOaZ
         /w27DOEUC5IbvpSkgeNqygJu0TCl/BA2/DKkb8yfa29yjYvQyCU277Jr77pNwxfFfk3H
         8RzX2TIudjzsegsVAsz67oSr4Dh7DMNu1/fljXjkj1c9Up48LAZL5JSwnBqk9emctVd1
         d+5VZnKrRapYscWZK/7537CZwgX0xsGxfA1Nl6heUj4C4nnI8k1hX8TWGnt1v1T7j8D1
         LLkg==
X-Gm-Message-State: APjAAAX8t6cXOEZDt4NNf29sRwzbn2NMq7rGIUAcivDgFEqSzKzf1Zu8
        6n+abB7QXBYzFJKO0Dlz+ruwd92fyfOOTw==
X-Google-Smtp-Source: APXvYqwi9ipqmQEKro+qPUtKxjGTZtb30fFp7xz/4IC6inGzsQiVlkzOCMCxnP/X+67xbdh0MhBxrA==
X-Received: by 2002:a63:cf4d:: with SMTP id b13mr13634378pgj.396.1571887603758;
        Wed, 23 Oct 2019 20:26:43 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id n72sm166386pjc.4.2019.10.23.20.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:26:42 -0700 (PDT)
Subject: Re: [PATCH] io_uring: ensure cq_entries is at least equal to or
 greater than sq_entries
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org
References: <1571795864-56669-1-git-send-email-liuyun01@kylinos.cn>
 <x49d0ennw1y.fsf@segfault.boston.devel.redhat.com>
 <e167ef28-8763-7629-fb5b-e0ef28ed8a49@kernel.dk>
 <BB26710D-8704-4D15-9B33-080B28B7941B@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8896b60b-2b06-ed25-3615-fa3a30d4baaa@kernel.dk>
Date:   Wed, 23 Oct 2019 21:26:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BB26710D-8704-4D15-9B33-080B28B7941B@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/19 6:22 PM, Jackie Liu wrote:
> 
> 
>> 2019年10月24日 03:41，Jens Axboe <axboe@kernel.dk> 写道：
>>
>> On 10/23/19 12:42 PM, Jeff Moyer wrote:
>>> Jackie Liu <liuyun01@kylinos.cn> writes:
>>>
>>>> If cq_entries is smaller than sq_entries, it will cause a lot of overflow
>>>> to appear. when customizing cq_entries, at least let him be no smaller than
>>>> sq_entries.
>>>>
>>>> Fixes: 95d8765bd9f2 ("io_uring: allow application controlled CQ ring size")
>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>> ---
>>>>   fs/io_uring.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index b64cd2c..dfa9731 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -3784,7 +3784,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
>>>>   		 * to a power-of-two, if it isn't already. We do NOT impose
>>>>   		 * any cq vs sq ring sizing.
>>>>   		 */
>>>> -		if (!p->cq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
>>>> +		if (p->cq_entries < p->sq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
>>>
>>> What if they're both zero?  I think you want to keep that check.
>>
>> sq_entries being zero is already checked and failed at this point.
>> So I think the patch looks fine from that perspective.
>>
>> Is there really a strong reason to disallow this? Yes, it could
>> cause overflows, but it's just doing what was asked for. The
>> normal case is of course cq_entries being much larger than
>> sq_entries.
>>
> 
> There are actually no other stronger reasons. I think it would be better to do a
> print job in liburing, but the kernel should still make a limit. Too many overflows
> will cause less efficiency.

Taken to the extreme, it's clearly an issue. You could setup sq 128
entries, with 1 cq entry. That'd work as long as you never drive more
than 1 sq entry, but it makes very little sense.

Since we used to have cq == 2 * sq (and still do, by default), I think
the change to ensure that cq >= sq makes sense. I'll apply it, thanks.

-- 
Jens Axboe

