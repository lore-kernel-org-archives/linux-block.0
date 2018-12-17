Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB46AC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E8E2146F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NFFkOO+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbeLQR3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:29:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42448 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeLQR3m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 12:29:42 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so10586386ioa.9
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 09:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zDIKAUw2yxp3jOxvHDtRHBErp1NASLNXA9NXDsqqVPE=;
        b=NFFkOO+Kje5vD3F+RRLx/8xrvr7CCD60rOcCBriu8tF0W11p5AuKxPL0reMfR40UMd
         pEPmgqpsLStGjZfNdqLfUARSVYczKqR3xIqlgCcYMqCjLSDZfFvwDq+/mzmqnJ7z8RFL
         g/FkQWa4VGyINaOL/9zuJqAQp/u5TQyLlZsobAmbWxeQc7WpyU0vn7NnX/Jfh2Zdpp+9
         2d6a+sTtAWXQIA+AVPA2qiM1NR+5ZVcqMEUfw76QRUI0AQu1QQLMdG+LCntD/XeqxGUz
         S+KWPSRCdXAs0JcGBGtuCryH2KV11D4eTgLmR08cLMgUaVy0X6QGwS0x6+bIBoxukHct
         KwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDIKAUw2yxp3jOxvHDtRHBErp1NASLNXA9NXDsqqVPE=;
        b=kqzYkLVr2/D3pRstrOzhgP1D9aJI20n/tH67DQACuTGQGniGXpiXHkq25r7ADcW/b3
         p1+HpL8ab0B/FQQlgNS3tcWvbv9zzAWyPxJem+zaYaKLlRPa2L5kCeThCxgT2Z364gsi
         JKHR4icHGWDywd5WTDr6a1/+s3mPjMiSZm81wKFAaD9hVlNSgpQorDbN9+Amxc7Una2A
         H93qI+Q599B67Yi50sFvD1ARO3IKdSwX1d78dDAg3Jds+Q+FkjB971tchUUCQdzgV6B5
         BTWMdnUVFK2jmHtCNWmAYal3+CptdZWH5MrOxU4io97qyUgwKtieKDj8lQ11/DnBqC8t
         r8dw==
X-Gm-Message-State: AA+aEWZSNbKQLiw4LZPX0e5hnzwNFwXP0nCTh6KjhKcwoGXLu9jA3QEt
        q0GrBUKbTla+0XEO5Tw5enkwEw==
X-Google-Smtp-Source: AFSGD/VbBKGmJfdQ3wQtwYzBnRD8ZPKcowqzhpRY+aB6a0oVGpGq17w5LEiPFRj3/NKsWEVv5FkhJQ==
X-Received: by 2002:a5e:d702:: with SMTP id v2mr11119403iom.224.1545067781252;
        Mon, 17 Dec 2018 09:29:41 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j14sm5849643ioa.5.2018.12.17.09.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 09:29:40 -0800 (PST)
Subject: Re: [PATCH v2] drbd: Avoid Clang warning about pointless switch
 statment
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181002171447.10765-1-natechancellor@gmail.com>
 <20181004200912.32348-1-natechancellor@gmail.com>
 <20181217172401.GA30635@flashbox>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
Date:   Mon, 17 Dec 2018 10:29:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217172401.GA30635@flashbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 10:24 AM, Nathan Chancellor wrote:
> On Thu, Oct 04, 2018 at 01:09:13PM -0700, Nathan Chancellor wrote:
>> There are several warnings from Clang about no case statement matching
>> the constant 0:
>>
>> In file included from drivers/block/drbd/drbd_receiver.c:48:
>> In file included from drivers/block/drbd/drbd_int.h:48:
>> In file included from ./include/linux/drbd_genl_api.h:54:
>> In file included from ./include/linux/genl_magic_struct.h:236:
>> ./include/linux/drbd_genl.h:321:1: warning: no case matching constant
>> switch condition '0'
>> GENL_struct(DRBD_NLA_HELPER, 24, drbd_helper_info,
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/genl_magic_struct.h:220:10: note: expanded from macro
>> 'GENL_struct'
>>         switch (0) {
>>                 ^
>>
>> Silence this warning by adding a 'case 0:' statement. Additionally,
>> adjust the alignment of the statements in the ct_assert_unique macro to
>> avoid a checkpatch warning.
>>
>> This solution was originally sent by Arnd Bergmann with a default case
>> statement: https://lore.kernel.org/patchwork/patch/756723/
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/43
>> Suggested-by: Lars Ellenberg <lars.ellenberg@linbit.com>
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> ---
>>
>> Since this is not the same as Arnd's patch, I took authorship for it
>> while leaving a link to the original patch in the commit message. If
>> this is not how it should have been done, please let me know.
>>
>>  include/linux/genl_magic_struct.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
>> index 5972e4969197..eeae59d3ceb7 100644
>> --- a/include/linux/genl_magic_struct.h
>> +++ b/include/linux/genl_magic_struct.h
>> @@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
>>  {
>>  	switch (0) {
>>  #include GENL_MAGIC_INCLUDE_FILE
>> +	case 0:
>>  		;
>>  	}
>>  }
>> @@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
>>  {
>>  	switch (0) {
>>  #include GENL_MAGIC_INCLUDE_FILE
>> +	case 0:
>>  		;
>>  	}
>>  }
>> @@ -218,7 +220,8 @@ static inline void ct_assert_unique_top_level_attributes(void)
>>  static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
>>  {									\
>>  	switch (0) {							\
>> -		s_fields						\
>> +	s_fields							\
>> +	case 0:								\
>>  			;						\
>>  	}								\
>>  }
>> -- 
>> 2.19.0
>>
> 
> Hi Lars and Philipp,
> 
> Could you please make sure that this patch and the other one I sent make
> it into 4.21/5.0? I am not sure when you were planning on sending the
> pull request to Jens that you mentioned in the other thread but I've
> noticed most maintainers typically send their requests for the impending
> merge window around -rc7 or so and I wanted to make sure it was on your
> radar.

It needs to get here now, but drbd hasn't really sent anything in for
about a year, so I'm starting to doubt how maintained it is at this
point.

-- 
Jens Axboe

