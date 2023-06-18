Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70053EB64D7
	for <linux-block@archiver.kernel.org>; Sun, 18 Jun 2023 23:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjFRX2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Jun 2023 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRX2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2023 19:28:35 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94323E47
        for <linux-block@vger.kernel.org>; Sun, 18 Jun 2023 16:28:34 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b51780c1b3so23257395ad.1
        for <linux-block@vger.kernel.org>; Sun, 18 Jun 2023 16:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687130914; x=1689722914;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HF4al/KpfE3U00Gc3jY6jQGLinv7+Agy63xfkUqw/9I=;
        b=edCd59MDGBtdZU6tOFMLxGRWZ6fcbPNbSmLUtOXTln9jHfG6VUT+FJvw/M8LrcoNdA
         6deUolEDaMk3FpjwVsT2/J+XtqIGl9kdfk6qwyJIOH7z5HLTIwlTqWBS+CyJNt5r6Rh8
         ZBvF4lPc2jzZxwBgIe28saKZuPaWAC2rIbZCjAaSrhTlTUEHvoa/4Xw4uxZtw0SMofj+
         hXHfErbGB81/meCoGeSFzviWVXu1Kv30WOeKq143WmKVI6sjZKf43dUl7J4QBbtL5JiS
         NvJ5C1axRtvcnyL+VXw5xiYW7QAn7erO2B8yadEW8PEmN7n2YNWEEaxUzY106kp/PSen
         K74g==
X-Gm-Message-State: AC+VfDzXLIz7QkBz/5tjqND298uwKWiqjqXzV0yQifP2JoIXRH7Frg0e
        s/DsmbveJhvYf08ZMQfmF5iGRocPHH8=
X-Google-Smtp-Source: ACHHUZ7irfmNs/6/0h6WG+1UviAAEuFpdk6KmssgBF1RWma+xZkT7FH0S46bwLMoFgndfWA7refd3Q==
X-Received: by 2002:a17:902:9a0a:b0:1b4:5697:d991 with SMTP id v10-20020a1709029a0a00b001b45697d991mr7990039plp.15.1687130913880;
        Sun, 18 Jun 2023 16:28:33 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b001b3d44788f4sm8208654plh.9.2023.06.18.16.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 16:28:33 -0700 (PDT)
Message-ID: <1efd3874-bedd-1e49-9fa3-fca0e85187f4@acm.org>
Date:   Sun, 18 Jun 2023 16:28:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-US
To:     Jaco Kroon <jaco@uls.co.za>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <f60c64e0-cfac-53bd-b164-92387c6910cf@uls.co.za>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f60c64e0-cfac-53bd-b164-92387c6910cf@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/12/23 12:36, Jaco Kroon wrote:
> On 2023/06/12 20:40, Bart Van Assche wrote:
>> tar -czf- -C /sys/kernel/debug/block . >block.tgz
> 
> Definitely can do, I'm not sure how to interpret the data in this - is 
> there anything specific you're looking for?  Would love to not just pass 
> the information on but also learn from this.

Most of the information in debugfs is needed. It's easier to capture it 
all than to only request for the many attributes that are needed.

I'm not sure there is any better documentation available for these 
attributes than the information in the source file block/blk-mq-debugfs.c.

Thanks,

Bart.

