Return-Path: <SRS0=PMby=YQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805FCCA9EB9
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3F420640
	for <linux-block@archiver.kernel.org>; Wed, 23 Oct 2019 19:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QuUmadlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfJWTmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:42:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40545 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbfJWTmE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 15:42:04 -0400
Received: by mail-io1-f65.google.com with SMTP id p6so18228750iod.7
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2019 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65DkhxjtGs3hS8ja0TxdM9S+92O9yJlpEFrNnhaV/38=;
        b=QuUmadlDPYZuQLmQypRRMnWKuYZXnIDbZ2Ejkj6XDKl0sAvZbBizmaNkvTbYT5Hep0
         DXG2Ywuh1dYby4Hs+grHwpK7tx4W+HrnigAnfGBrX4Ae+p7+3vXOgQ1TjOXT/bBFmP01
         qwSCLTMFg0iwVSEe5f0qKDVXuP9pGp4zjARky9IMfuisVt47Dxo4gT1agMw/xgr0/v6n
         8kSSeNRuyyf7xeu5wQzOQtm1V7O0phkpkSCXL9aL4A3/bbLZ/uWK2zIEkZfExbVe2qZW
         tOB8S1kS/s2HZfp6Zp+Q5HjpaUV7iUZoqKnOBc28TBJsbYQSl65U2aBekUg6unlsmSWY
         RGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65DkhxjtGs3hS8ja0TxdM9S+92O9yJlpEFrNnhaV/38=;
        b=g8/gL1XYlsvSOClnoQBCr+nHkhqFa6zHR85AfbpntARh0CLWzrCToP7ZBOKeW2jiDQ
         xgtRtmXwkgEUE0PW3mfYO+GTZEOQxqvL36bibTllv4onjSO3Ea6/pfYADswSpRCbrSs9
         dt2KAWOgvgx4f607XbVsbme4ph62sONtJvH/FVzH8VOM1XzvALvam6ZCIJ4dpkiB5TjQ
         QOrFu59hqRrgRfwbgGQ3YLBYI4uBvgC7gcgeBmJpFLMxJf+tyOxmZjTAA9DsDTI3shOW
         o4rAoenBXyZ5FfihWXoOkyk8DEc7FTbOyufUTzQQpSRPQhLWypSKLx7BUIDwWH8naQed
         xc6A==
X-Gm-Message-State: APjAAAUlwBL8Udl65+xDTLf3EPLEafIJJUVXvmhUzomooRoe1c74fVVQ
        rLxkhL55MJo1A0ZuoBTHUU8jeIhpJFQskw==
X-Google-Smtp-Source: APXvYqw56r0Lo9DYHLBRMngE2K25uiHBdauz1kS0hb1YrO6KNASU7wcYyGahYcTGInEWT1wSVPa5Dw==
X-Received: by 2002:a02:7b0d:: with SMTP id q13mr10559606jac.114.1571859721456;
        Wed, 23 Oct 2019 12:42:01 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f145sm2511181ilh.48.2019.10.23.12.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 12:42:00 -0700 (PDT)
Subject: Re: [PATCH] io_uring: ensure cq_entries is at least equal to or
 greater than sq_entries
To:     Jeff Moyer <jmoyer@redhat.com>, Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1571795864-56669-1-git-send-email-liuyun01@kylinos.cn>
 <x49d0ennw1y.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e167ef28-8763-7629-fb5b-e0ef28ed8a49@kernel.dk>
Date:   Wed, 23 Oct 2019 13:41:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x49d0ennw1y.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/19 12:42 PM, Jeff Moyer wrote:
> Jackie Liu <liuyun01@kylinos.cn> writes:
> 
>> If cq_entries is smaller than sq_entries, it will cause a lot of overflow
>> to appear. when customizing cq_entries, at least let him be no smaller than
>> sq_entries.
>>
>> Fixes: 95d8765bd9f2 ("io_uring: allow application controlled CQ ring size")
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>>   fs/io_uring.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index b64cd2c..dfa9731 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -3784,7 +3784,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
>>   		 * to a power-of-two, if it isn't already. We do NOT impose
>>   		 * any cq vs sq ring sizing.
>>   		 */
>> -		if (!p->cq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
>> +		if (p->cq_entries < p->sq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
> 
> What if they're both zero?  I think you want to keep that check.

sq_entries being zero is already checked and failed at this point.
So I think the patch looks fine from that perspective.

Is there really a strong reason to disallow this? Yes, it could
cause overflows, but it's just doing what was asked for. The
normal case is of course cq_entries being much larger than
sq_entries.

-- 
Jens Axboe

