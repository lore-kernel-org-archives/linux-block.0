Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC82C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 20:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F90B20661
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 20:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n5PjTNsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F90B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLIUe0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:34:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39986 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeLIUeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 15:34:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so3979744pgp.7
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 12:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bhcBHDTsQkXKPUM8+S6QFU1+sn3VNeURN5UiDMBH9yc=;
        b=n5PjTNsZfQkLayX0w4arceTRN4AUk2jXC8j2SmuniOmVudYrOjnSqGf4eChbmt/9gZ
         neu/643vuQp7XjN1SqHVEW6zJvyknoI0BiOnm+DMtjQNKwVFfrAR9dTpd2IO16MjsnZC
         X1ZM/detBfndfGT6eEyfZiFt6wxSMg2H7vnob4lGXhCXSF1Ajj170iQRrF+/doXpu9TP
         NZXOIX8iLzrwi0v0MGMCa2gGnftMQBq8WhYfKzbPcxykZELX9Q+PeJw+0y25pORwHeJ1
         1k6WuQVbOqECGxnmx30LMYL6HSCbgAvsUfxN1cIo5WjVPpRjZNtFxRADRNDe9L+M320e
         G6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bhcBHDTsQkXKPUM8+S6QFU1+sn3VNeURN5UiDMBH9yc=;
        b=MsWLHMyXobApcaWiuwtl2fWOwnzl5u5NAIW0G1Ek4wVEhkflo7YqJYO21P0XtKsh/E
         /2uw8kq9FsmSuDKAN4SSMQZwBg0a64Na8XQ0vUdLo4669/GXkqAfZBNupTNV1FUi4+NQ
         Vr/AcMfvlK1BIJJS65gRM0qtEm3AoqwMDqMkvkJJr/EQP4D/O4VMC2j7W0gS3WUOFVX+
         cKeCylz8EMCOCsHyfqHo26RMEbguR/MHXAa1Vr2ZWOhZ6E+u/FzJfcNOgt72WTGeffSl
         9drxR2gAJDgr7suMWnmcjKkfLaS6TKkVGttUURyDH+hv7rdUUfyV5wKBFiuQ98lrxE5N
         UjBw==
X-Gm-Message-State: AA+aEWan1fqpdnr+Cz7dK+yvwpW5o7GFwFEOnO8WvKjPtELlXYlyhy/M
        pyC6tK+2NteYL5wCbWOYt5ThT6o0Si8=
X-Google-Smtp-Source: AFSGD/W8Zj/swUg7IJGF3Hy2xZC84pWYALMo28npd8bTcO4dPPIZqS2H+SF/GAJRTaQxDYXPIuWXwQ==
X-Received: by 2002:a63:9e58:: with SMTP id r24mr8876071pgo.264.1544387665012;
        Sun, 09 Dec 2018 12:34:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b10sm16070516pfj.183.2018.12.09.12.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:34:24 -0800 (PST)
Subject: Re: [PATCH v2] sbitmap: silence bogus lockdep IRQ warning
To:     Guenter Roeck <linux@roeck-us.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@osandov.com>
References: <d4dca36f-d694-0dae-7e30-87c0490497b1@kernel.dk>
 <82dac8af-bb91-09b5-51b4-fecfc0bcbf50@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <69f20fd1-07c1-6a46-7e29-9f6670126be5@kernel.dk>
Date:   Sun, 9 Dec 2018 13:34:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <82dac8af-bb91-09b5-51b4-fecfc0bcbf50@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 11:47 AM, Guenter Roeck wrote:
> I'll give it a try.

Thanks!

>> V2: don't use lockdep_set_novalidate_class(), it doesn't work for
>> spinlocks.
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index a89fbe7cf6ca..23da156f7a17 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -118,8 +118,13 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>>   static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
>>   {
>>   	unsigned long mask, val;
>> +	unsigned long flags;
> 
> Probably asks for __maybe_unused.

Yeah good point, we'll need that to shut up gcc for !CONFIG_LOCKDEP.

-- 
Jens Axboe

