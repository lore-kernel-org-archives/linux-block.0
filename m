Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A2AC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 16:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E48D64F64
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 16:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbhBBQDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhBBQBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 11:01:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7AFC061573
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 08:00:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b9so11150053ejy.12
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 08:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rQC8G5tz2PhfrYsVztuVcljM2AAfH2rIZZsFS31Z5Vg=;
        b=JDiQcGwPKhHeBxeYzCGphIEyh/57xx1oJ2ipNVBu4l5DV8klXIxplIteaxgm8YvTD1
         976hyYQobUaHKFfJwUemFrtyLjwD7Gx8LrKrZ/TmSfRCKhnx1B/gZD1cWoMpLPSXgFYw
         XbN9GDdCw+PUrIEqKvon5joF2lK94Z4wGq539DxqtIk/mh8k3G/yIM2zk87Y+gfx9id1
         5J90xzBv+qwgQN8C0eiD4fS9UtVbY7tt1FKb4KcAMujyCdU1l+J6rbuT7oahT0A29qnz
         Lkq7IowPr1VYSNSMHbqoVKtmYjaL945l3nCvqnXhMEkxNlAMT5F7mq3vBWuIwEn1aHOd
         YIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rQC8G5tz2PhfrYsVztuVcljM2AAfH2rIZZsFS31Z5Vg=;
        b=FMssvgh/vStXC5QrXry3GpMYSQLBb27qlTCY7sGRqhQXFuGDzRZZt1zrpNHzlULyLJ
         VOkprA/VbW914F+JDl8lvrP+o6541gFl+laxSG+qUwVSTEeLZqIPuzVTdlJbIQU8pAvE
         kk/J4n2LUtsfY/KMoXWP3bSFj+5X4DHOHewe+dtgJg7uuywf7Hpm2sNBPw7DQ/9eW5BV
         qDXlSTOjtlUZGQkcO2NFMl+12sIgZsiZrQRLe4t96Gdpb/RnScAJsp4FSvdThGeXbfBk
         Wn+OOXiCo3jyD6I+ZNRBBgz73jaZ3dcRJKwLajQlfO3POSBMlyQr6ZxtlUIKG7jao4xF
         9YGg==
X-Gm-Message-State: AOAM531F2ipMURSJTmf1JC3u2/OIDzmQwB4Bz8XI9m4ltP5AVaKHGjdu
        vlGo3AkcTMnXiWcfN5XEKHVS0yOSzqDGEQ==
X-Google-Smtp-Source: ABdhPJxCtimSUEokzC3JF/WV+nYyRQvZh6lD5U125938WrRzuamMeN6Vao/aeinuf2arlauzvwvH8w==
X-Received: by 2002:a17:906:f246:: with SMTP id gy6mr22300863ejb.264.1612281636480;
        Tue, 02 Feb 2021 08:00:36 -0800 (PST)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id m20sm10728658edj.43.2021.02.02.08.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 08:00:35 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix unnecessary NULL check warnings
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Tian Tao <tiantao6@hisilicon.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1612230105-31365-1-git-send-email-tiantao6@hisilicon.com>
 <BYAPR04MB4965F95707D5C87608B4ADEA86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f76e7f84-5f4a-c69a-e203-117102164335@lightnvm.io>
Date:   Tue, 2 Feb 2021 17:00:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965F95707D5C87608B4ADEA86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/02/2021 02.47, Chaitanya Kulkarni wrote:
> On 2/1/21 17:44, Tian Tao wrote:
>> Remove NULL checks before vfree() to fix these warnings:
>> ./drivers/lightnvm/pblk-gc.c:27:2-7: WARNING: NULL check before some
>> freeing functions is not needed.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Looks good.
>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>
Thanks, Tian and Chaitanya. I'll queue it up.

