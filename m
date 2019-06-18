Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52702C31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7692082C
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 22:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfFRWTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:19:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33645 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfFRWTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 18:19:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so8441476pga.0
        for <linux-block@vger.kernel.org>; Tue, 18 Jun 2019 15:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2hVSy97CvI9zxl4Hxb/u0iVS0lwH9emDxf99IYpIjo=;
        b=mTQgUzzf2MlfIqfZR/u8DqttiJWgPgeKrEWVK+ytc1n+9v1WpFX1B05AMjeMmbLh9V
         W2sUnS3uzIRdV7Zrz2PakD4IdkAY5vunTs6YB25+yIj33mcbQc21bKO4a2b6JCMAbAcl
         2NzPW5gdeZl8OAwYoYggtxE50Drxp8/9d0buHpsuFO23DsAPsJW7d9O5Al/DfRrBWvzn
         tav8Isp5294Ine+9pJOOZ+1TplDrug6tr0/2oetuHqOpA/cjFHeUKHaHQgL1p8fqyezn
         R6o83INdzBfRBZ52KbW8clpiuJsi5ylv/nWHmv2QMspQXxFGGg9ViDu/ZZ+hhHA7YzXp
         zo9g==
X-Gm-Message-State: APjAAAW4xsUuS2xlvgsnB1JNQDb7HngzKfVpUlnZQ0nhX0sfz5A44Q1M
        yN7KUP4ETWQdd48z01ekEUs=
X-Google-Smtp-Source: APXvYqymV11GJi8ZnNHIX54XPofOZ6vTmgltu1Ic4ryuiqVg+mizzK5FCsc/hQ+XZEq+nRRYuezryA==
X-Received: by 2002:a63:6b07:: with SMTP id g7mr4869326pgc.325.1560896391485;
        Tue, 18 Jun 2019 15:19:51 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a21sm21209287pfi.27.2019.06.18.15.19.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 15:19:50 -0700 (PDT)
Subject: Re: [PATCH V3 2/6] block: add centralize REQ_OP_XXX to string helper
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "yuchao0@huawei.com" <yuchao0@huawei.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-3-chaitanya.kulkarni@wdc.com>
 <97487a45-0a53-970a-8237-86eebfbe7ad9@acm.org>
 <BYAPR04MB5749C5921DF5D60C9AD9558B86EA0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e6ad04bb-82fe-77d6-828b-c893ed66967c@acm.org>
Date:   Tue, 18 Jun 2019 15:19:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749C5921DF5D60C9AD9558B86EA0@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/19 3:00 PM, Chaitanya Kulkarni wrote:
> Regarding the correctness, I think if one of the operand is unsigned
> then signed values are converted to unsigned valued implicitly.
> 
> However the exceptions is if the type of the operand with signed integer
> type can represent all of the values of the type of the operand with
> unsigned integer type, then the operand with unsigned integer type is
> converted to the type of the operand with signed integer type.
> 
> I'm wondering how would above scenario occur when comparing int and
> size_t. (unless on a platform int can fit all the values into size_t).
> Since above comparison of the ARRAY_SIZE involves sizeof (size_t) type
> is a base unsigned integer value, even if op < 0 it will get converted
> into the unsigned and it will still work.
> 
> Please correct me if I'm wrong.

Since a long comment was needed to explain this, that means that the 
mental effort for anyone who wants to verify the blk_op_str() code is 
large. Please make sure that kernel code is easy to read and to verify.

Thanks,

Bart.
