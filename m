Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F43C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 08:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E43121919
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 08:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="MSSEySbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfAYIR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:17:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39415 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYIR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 03:17:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so6299238lfh.6
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 00:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9jiQno4UhpYBqTa//0Ls70fFfjYDxFXuvNUqs9ZqpgM=;
        b=MSSEySbN5UO6m87vMtYZyqZQFMhszrz4L99zNl5hfZLuSPCxNIcU6L+x3ZDiUsM5+R
         xXlApON/eAxmUmgJ+jKLuIss3hqZY0WsRFGlmUha9uJS1YtpK1S73Hc0ayYZj3SNuKNP
         Od1TrmnsZ3ah2QGqnnbmUWE2Df/pRZtiO4+ZW6cUQlO9zfvgj1zHjwtWouhfJUngGmn+
         nB+x3RHfAtOHGOl5wLQ0lO6a5EZc94HJFILh/3mfPH48dZ85kKd8q1gakl9+p0Rn9gAq
         g+Hn8Zrx1rUNTN1l09o8vcmkY3RAGK4Tf3eMze890SZmUbckntS2oUMFqDjVcurD+kBn
         zabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9jiQno4UhpYBqTa//0Ls70fFfjYDxFXuvNUqs9ZqpgM=;
        b=mSomQGyuZ3HnsW7VM6dNM5mhNwpdBwB7oSDAIpDGIKIgELf83ifBKCf1XoXtDXNRZQ
         MZ3lnz44UHBIPyWtuxkfvWx4gMMIukpbQKB/6M2XXQMkEQq6rAXm5st+CLyrwkHAzh6k
         FQPI3GlnXxN25l7rNVmJu0ZnefexD7LK7izlwPkZs4iw0FTJy/wVQZzGojP6++f1d4Q6
         a6+mHUbx72+hrc/YuyukkJoQ69AspD9TpGHu4ltBQH3hhXsIEf4W8K4EwHL83kAGbqDm
         Gr6L79b/GY7jwH+0ILIa47e4vbDrhTTw2b9oOzJuKVhkru1RnewOGE4P5xy7bcEtA6V4
         0n8A==
X-Gm-Message-State: AJcUukeTWvznRLceB70E1D8NC0GDOEDJMA5PqJFSD+COTjb9r6l55JT6
        h6+E7ZhIWekN6d33HtVvbxClQw==
X-Google-Smtp-Source: ALg8bN7s9/hh6YJu10Qia8w6IQ+areeNtAS9ETVh4HZHOP9szGp9pljunMcfDJFTcGro58SAhkCYcw==
X-Received: by 2002:a19:1cb:: with SMTP id 194mr7925460lfb.61.1548404276489;
        Fri, 25 Jan 2019 00:17:56 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id b25-v6sm1413706lji.94.2019.01.25.00.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 00:17:55 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: fix TRACE_INCLUDE_PATH
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1548401030-28860-1-git-send-email-yamada.masahiro@socionext.com>
 <CANr-nt0=gw90vBLA_FMjmD7duNVYJcGmcqfk9HiQpdKxHV-A+g@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <17453c37-72ee-11e1-979d-e60a034d94e3@lightnvm.io>
Date:   Fri, 25 Jan 2019 09:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt0=gw90vBLA_FMjmD7duNVYJcGmcqfk9HiQpdKxHV-A+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/19 9:01 AM, Hans Holmberg wrote:
> On Fri, Jan 25, 2019 at 8:35 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> As the comment block in include/trace/define_trace.h says,
>> TRACE_INCLUDE_PATH should be a relative path to the define_trace.h
>>
>> ../../drivers/lightnvm is the correct relative path.
>>
>> ../../../drivers/lightnvm is working by coincidence because the top
>> Makefile adds -I$(srctree)/arch/$(SRCARCH)/include as a header
>> search path, but we should not rely on it.
> 
> Nice catch, thanks!
> 
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>   drivers/lightnvm/pblk-trace.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
>> index 679e5c45..9534503 100644
>> --- a/drivers/lightnvm/pblk-trace.h
>> +++ b/drivers/lightnvm/pblk-trace.h
>> @@ -139,7 +139,7 @@ TRACE_EVENT(pblk_state,
>>   /* This part must be outside protection */
>>
>>   #undef TRACE_INCLUDE_PATH
>> -#define TRACE_INCLUDE_PATH ../../../drivers/lightnvm
>> +#define TRACE_INCLUDE_PATH ../../drivers/lightnvm
>>   #undef TRACE_INCLUDE_FILE
>>   #define TRACE_INCLUDE_FILE pblk-trace
>>   #include <trace/define_trace.h>
>> --
>> 2.7.4
>>

Thanks Masahiro-san. Applied for 5.1.
