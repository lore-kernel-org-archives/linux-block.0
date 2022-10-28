Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE9FC38A02
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 13:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJ1N4z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 09:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJ1N4y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 09:56:54 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D3F501BB
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 06:56:53 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h18so2961633ilq.9
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNmbf1DrFhGYblawzk2OE47DJTJRUcUrHVQAL/CfprY=;
        b=dG6ulbLayOltV06VckG15ZM5FJG6iiZzromr13Dxi9USxiXVkCtDGqYIAKXSbEjEsg
         6/4zFI9eNDP16ioOt8eBqfK8LLHx9YAtHYAYPLbwGmmU5UBbzmoybUtx16fyzkvhSzR3
         HPY9oV/7QoeTtkKuooaEE+gZnrMu+aqm39boPj7zzGFLLvQJ6VBcsZBBqut7VaIb/buj
         q895fmC/zzzcl+kzWfQ5az43Fi57FG/UVkb72MqRQqVdXSkkuM09YdFcOS8Tska1OEc5
         j3FPfxhv11zq8/5nlaYYCS0Zbo0fVkH/+r+h15pChOem9+8KkNlUI3gQ8khWOzAEmFqK
         kHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNmbf1DrFhGYblawzk2OE47DJTJRUcUrHVQAL/CfprY=;
        b=8KXV//YT5/D3mCcXy8kqjvNe9UKBU3CjhQBtWcCkjCIKibIo2/gLjcb9Y+BNq6LqiE
         lcDlFtc+d6CLDJongeOmae5km9MFYqrauOkZbwM5BJK5WJ1D8atC9krHw0Y9CveFqoVt
         Y5FSue8xfGO7P29bvXt3sHKrtLWeTG1YOTRaFNBktAY2W7fRDBtTv3vteBJwAD20pCB6
         2coUGvZ8mq/aJ+EoOg+Zey064f5KGa+iYJUmqeRArVRElrdOFJ7rDMW8SAVAhjsrqQJz
         9o5dWbO4doYV3P9zhSmQRj88j41rfKEVwVdBEQNeZTWmJucFDwjbGbxA+/3x5+EoN/GL
         V80w==
X-Gm-Message-State: ACrzQf0g35/D//jGoomhljKKIXh5b5D95yFslGtPu1sGaZwUz/tWDirw
        Xx0h2JP4W4bQUFR4k76QQQU4Bg==
X-Google-Smtp-Source: AMsMyM67Rc2FdwlFNx71PR911GhNj2eaxZcauUCfpYlVrbJm9CnlVNFcL7nioQrLtCwqwEdextZnag==
X-Received: by 2002:a05:6e02:1e02:b0:2fc:6288:e6e6 with SMTP id g2-20020a056e021e0200b002fc6288e6e6mr35376483ila.172.1666965412619;
        Fri, 28 Oct 2022 06:56:52 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k11-20020a0566022a4b00b006bba42f7822sm1704584iov.52.2022.10.28.06.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:56:51 -0700 (PDT)
Message-ID: <60b91c39-1e54-ac8b-5e9e-db7e46ca2d60@kernel.dk>
Date:   Fri, 28 Oct 2022 07:56:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC][PATCH v2 04/31] timers: block: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, drbd-dev@lists.linbit.com,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20221027150525.753064657@goodmis.org>
 <20221027150925.819019339@goodmis.org>
 <20221027111944.39b3a80c@gandalf.local.home> <Y1uSG/7VXWLNlxlt@infradead.org>
 <20221028062414.7859f787@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221028062414.7859f787@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 4:24 AM, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 01:26:03 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> This is just a single patch out of apparently 31, which claims that
>> something that doesn't even exist in mainline must be used without any
>> explanation.  How do you expect anyone to be able to review it?
> 
>   https://lore.kernel.org/all/20221027150525.753064657@goodmis.org/
> 
> Only the first patch is relevant to you. I guess the Cc list would have
> been too big to Cc everyone that was Cc'd in the series.

No it's not, because how on earth would anyone know what the change does
if you only see the simple s/name/newname change? The patch is useless
by itself.

-- 
Jens Axboe


