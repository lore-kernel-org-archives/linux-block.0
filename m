Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6981C433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 14:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803CB20866
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 14:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d3qdQ7UZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgHROt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHROtX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 10:49:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378AC061342
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 07:49:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g33so9864049pgb.4
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fCviTlz4XSnwg6yVOSQsWhVAGKd364Znuee6QkGLbdc=;
        b=d3qdQ7UZPKbZ7S+EnT9F/IN+BE6+5jbLchQTYDcmwIEOjBhWvPQznkybbt0H+G6ND1
         h9mEckYYN5ikynT1ACEykIl6aXlC4E931EuXEHxn+d0KBcy9G6LTrkvXqhpWdNsvl9+h
         56QZb0lSW0Eml8RJskwKAk8dvVP2RepBw/GMwudC33XqUcLJJQKjXKg+iQrk0q7zBZfJ
         rEl5ENyQej6T/ZKKd3Sz/roVc2N+L2wqKf8MzYfAwpZgrHIW32iZTUsHMWwD3Ijrbqq9
         efjH9gdjiE+jXE6V0NJ3mmPkS7GL/FzPbsYk8txCUN1Pxk+7xj+N7Ms3ARuf3p7wZuKr
         CbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fCviTlz4XSnwg6yVOSQsWhVAGKd364Znuee6QkGLbdc=;
        b=WRnk/UH1J8CtcYg784HQmtTkAmgAj3ptM9Jp6c6yHVFOpg2qcJVN6k7E7tdEbBKw4D
         NEs2KliZYyQdO0j4QkL1E4uDWpzp3muRLaPgODlOkGBgRWchaopwpEf+FnJdoD1JnJas
         njRbBEv/FQmvNyAOCaSFQHHX4S41UgjgLea67WqT80zbKxrfQhUgqVfhML9RS44T+xRi
         ak/M1nsJBOj3nxqcRCF8LXHtqVToI9sceMLjypbsRjic9oxLRDAAfhbZowlIHlgBK34Y
         grZR1tkolmlD5XyyX6ms9aJRwyFFiTm3H5I9+xX7n7pjwHez7dDxwVrpQHK4/+vFiMAL
         bDrA==
X-Gm-Message-State: AOAM533PGZpqPPGi4l9Y7fj0oHcebGTHicxy0POup7sna4NIbkcWoCvC
        iapjPtdzf1sbckm2MGS8feBevw==
X-Google-Smtp-Source: ABdhPJx0FESruQtVAJ0RygWDB3g1tZOeUssXuc6Oj9ZrdkWXm/c4kZfcWzGKId1IecLreRwWduJRBw==
X-Received: by 2002:a63:4450:: with SMTP id t16mr13494555pgk.3.1597762162542;
        Tue, 18 Aug 2020 07:49:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:9214:36a5:5cec:a06d? ([2605:e000:100e:8c61:9214:36a5:5cec:a06d])
        by smtp.gmail.com with ESMTPSA id fh14sm171070pjb.38.2020.08.18.07.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:49:21 -0700 (PDT)
Subject: Re: [PATCH] block/rnbd: Ensure err is always initialized in
 process_rdma
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Brooke Basile <brookebasile@gmail.com>
References: <CAMGffE=2m7XOdKS9xG1bNY7MYR2x6AgQm9YZFHm6D4biO860sw@mail.gmail.com>
 <20200818064924.3984068-1-natechancellor@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d6c0f92d-6c0c-cad4-24d3-e17f0f59a8c0@kernel.dk>
Date:   Tue, 18 Aug 2020 07:49:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818064924.3984068-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/20 11:49 PM, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/block/rnbd/rnbd-srv.c:150:6: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>         if (IS_ERR(bio)) {
>             ^~~~~~~~~~~
> drivers/block/rnbd/rnbd-srv.c:177:9: note: uninitialized use occurs here
>         return err;
>                ^~~
> drivers/block/rnbd/rnbd-srv.c:150:2: note: remove the 'if' if its
> condition is always false
>         if (IS_ERR(bio)) {
>         ^~~~~~~~~~~~~~~~~~
> drivers/block/rnbd/rnbd-srv.c:126:9: note: initialize the variable 'err'
> to silence this warning
>         int err;
>                ^
>                 = 0
> 1 warning generated.
> 
> err is indeed uninitialized when this statement is taken. Ensure that it
> is assigned the error value of bio before jumping to the error handling
> label.

Applied, thanks.

-- 
Jens Axboe

