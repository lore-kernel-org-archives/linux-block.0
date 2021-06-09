Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E045C48BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CFC61351
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbhFIPgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:36:46 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34804 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhFIPg0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 11:36:26 -0400
Received: by mail-wr1-f45.google.com with SMTP id q5so26014370wrm.1
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xGVDIJuM0pLBNamxzWM55+XUbEA7UeuqWFlHqJ+KE8=;
        b=FW8JjTUgc2QCOqDKs23TPHKlw3yC/XaDsSZbxtUminiXGSvX6HAJpYZ/Q7qFRqe2Si
         DE2Vjjjq+7Wf6EBrGE1XCRiD68xSExd/aXNywXqdoh/MDKiUe+/uyR6PYF3uzo1cSwXC
         c6ECS6g8TDGxRMdOv6S5AUI5s8nP8ITWozbjt+6+5LjaWGsfJYncleIqdfNY3ITWdqau
         g8Ojt5UxSarV5I1ca2LXZWWy06+ixLut8EQIASTas6NCggBh68hH1BfyWb2OL/7sdmf6
         wdfrIrHIygsyVh6LasGPBthjK6hsSsfAxkMeTfsIDvzSpqzHfQzvWqAtcsOOCV75u7Ce
         9EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+xGVDIJuM0pLBNamxzWM55+XUbEA7UeuqWFlHqJ+KE8=;
        b=NXlAehGDKDC4TSzEoT7fyuNooF5SJF2sVz8MW7MObmXJy+iewQr1Offp6X3ICjMcRc
         jFmgUyDmzmx0OlShY0R4cBFar4bBsNfqS3CpEqXcba51I5T/+4sMvutaERrtghOWqo/B
         4+zzX7FNdUzKn2EZy4lb2zjbf+zmxu0RxJUtLmUyVDiSlfUDl9XWfDmnOuKoCSlEXJJD
         oiEFpacEHV/xg5JQibzhy3DHpMSyoeSIZ3WWeSIuY0daWJc5MCbNZoF5qeM2tjnOk1OU
         DUmDpAjjZRC41i/RxEBPjDehrCaouxMt/FwlJPrfrK4BEEdD3gjhJE1FiXEkyZgDKhfC
         /IKw==
X-Gm-Message-State: AOAM5335/1HupFXU6oMCcZ9MRNWiFQXiVwHBKWmVqqf/ECGvqIkxFOHL
        YGX0Xg0X+xIZbRHsH0dZYgS0gg==
X-Google-Smtp-Source: ABdhPJzK+SLvGufcFz0XZVU0UMomSVVWqdLbszEBxtzGiErlhEYmKeaPk4EqBAO1Olmr3eUobVSoZw==
X-Received: by 2002:a5d:4848:: with SMTP id n8mr495266wrs.70.1623252811382;
        Wed, 09 Jun 2021 08:33:31 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:4096:b5c5:79a3:7c0f? ([2a01:e0a:410:bb00:4096:b5c5:79a3:7c0f])
        by smtp.gmail.com with ESMTPSA id q4sm1829995wma.32.2021.06.09.08.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:33:30 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 1/1] lib: Fix spelling mistakes
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210607072555.12416-1-thunder.leizhen@huawei.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <eff5217f-74b5-3067-9210-6b2eb5ea5f4d@6wind.com>
Date:   Wed, 9 Jun 2021 17:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210607072555.12416-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Le 07/06/2021 à 09:25, Zhen Lei a écrit :
> Fix some spelling mistakes in comments:
> permanentely ==> permanently
> wont ==> won't
> remaning ==> remaining
> succed ==> succeed
> shouldnt ==> shouldn't
> alpha-numeric ==> alphanumeric
> storeing ==> storing
> funtion ==> function
> documenation ==> documentation
> Determin ==> Determine
> intepreted ==> interpreted
> ammount ==> amount
> obious ==> obvious
> interupts ==> interrupts
> occured ==> occurred
> asssociated ==> associated
> taking into acount ==> taking into account
> squence ==> sequence
> stil ==> still
> contiguos ==> contiguous
> matchs ==> matches
I don't know if there is already a patch flying somewhere, but it would be good
to add those typos in scripts/spelling.txt


Regards,
Nicolas
