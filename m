Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB07C432BE
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428F7610CC
	for <linux-block@archiver.kernel.org>; Thu,  2 Sep 2021 12:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbhIBMgv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344534AbhIBMgs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Sep 2021 08:36:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97801C061757
        for <linux-block@vger.kernel.org>; Thu,  2 Sep 2021 05:35:50 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l10so1592544ilh.8
        for <linux-block@vger.kernel.org>; Thu, 02 Sep 2021 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=osIJkBvwdWWjGM2Xczs+xKtVAwutZFKbM96ppuoJRyU=;
        b=SeGdgT925WAlK2GMS4zGWccKacFbYhyrkmazsxC9O1vOB/ssBzdUnp8HXCyYYSxsPk
         W/FVlCBJ/dpx4j3bfMgS3S+Xmtqr8SpioPKN5TfV+WSj+SoPDcvAdKCOomlwfavV6Dvq
         y+dq0VrD5HFx9YeYh0gZhsgpfolQ0OOQTFfnr44Xtw8XNSDFb4CQlAqkMkrLWUeg7n04
         nm0Ant2regqGEcoLFmpa5WELYe1uYZlQBVMQJ+DfQp5DOpWXtXaKGOx1m9xIsj0mM9tw
         HlHJT2WVOj/n2jUFXQGg4WVoEc+BS0PXLVr4bgjQNOxVG+3a2JMmrqjsI/xX3GxeS3yc
         qagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=osIJkBvwdWWjGM2Xczs+xKtVAwutZFKbM96ppuoJRyU=;
        b=c5rhaxHedib/j73Vclb9vGwK7zB7L1aXAcsjoIvyIcWa9N9wsNJWtq+OgK5AO7aIAp
         8grxqmlW4TNcWF+eGojaToK4lhyfmA5ZfVzozUhyjhmCdhyHD6pqQZlt7Ugp5wLU38/O
         7z3knazdAAsfZOIwLe2/2XbbckcC711AlXTW0bdPVGMmWsB7mCz4WPkpPy/sQkYZS6A4
         CYtzO/T7LkniQ964quNQqc71qNQrJbZgJQHafxntDOmDOh+Ls9zGEoQm2BjsSZP+eFWV
         gYOrqtBvpkPTiawQJ1YQphnZ7uiQYL4psIf9i0n8ErdUIyeCWVb4N2KBy2ufGJupD3M1
         TEIQ==
X-Gm-Message-State: AOAM530Jw+AmNNMiLKwo4be30LdaR3Th7+mNv5VHxeDIgP9gdPXCXuiN
        C30pTacWAgXqVYIw8T7ecQUdeg==
X-Google-Smtp-Source: ABdhPJycVzqLDgXQPl9SzoElPgyfW00LsbFQh6H9OTQHYK2VLCDcaBceG4aBh+ri2HwoqJR01g7tQQ==
X-Received: by 2002:a05:6e02:1bc8:: with SMTP id x8mr2145533ilv.138.1630586149849;
        Thu, 02 Sep 2021 05:35:49 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j5sm875526ilu.11.2021.09.02.05.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 05:35:49 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Move dd_queued() to fix defined but
 not used warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210830091128.1854266-1-geert@linux-m68k.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <caf2449c-e86d-195d-3635-9be49159166a@kernel.dk>
Date:   Thu, 2 Sep 2021 06:35:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210830091128.1854266-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/21 3:11 AM, Geert Uytterhoeven wrote:
> If CONFIG_BLK_DEBUG_FS=n:
> 
>     block/mq-deadline.c:274:12: warning: ‘dd_queued’ defined but not used [-Wunused-function]
>       274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> 	  |            ^~~~~~~~~
> 
> Fix this by moving dd_queued() just before the sole function that calls
> it.

Applied, thanks.

-- 
Jens Axboe

