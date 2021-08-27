Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF86C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB37E60FE7
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhH0Q61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhH0Q6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:58:25 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3155C061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:57:36 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z1so9339731ioh.7
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qa25SpUXSabE0dbWJZO34NKwQuuOTzfC13g1xeo9TgQ=;
        b=YFOKHx9j8FLLl67VJd3NetNuBzIPOKJubhojGMhUNC8/SY8VvUYKPNp94cx6Ck6Cjy
         zEA6K49OA8WcvvrnPQE1mGmJoq1dgiXWFAHTY8DT4mWGptEsSmjxkMWD/vHAvRsn35KP
         2ytGCWa8EgU1gm18foWQkFWJ5KYgu8E63Zpppu9WIiVEqUVxIQ263PkJP6S/yC4pF8Dg
         3Dpf9iPmDPfTVK7S07xTEK8naQIMaLAbQzONkBBME0g/aa80jCZsvU0QdKns2/q14/xi
         ImVMELkKVEjqFXk1uQWBxvD9fAZjwfk1kbaerrhjIlzkq3OhM6D6Fw3xhgZ310Wf98l6
         QrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qa25SpUXSabE0dbWJZO34NKwQuuOTzfC13g1xeo9TgQ=;
        b=mtf0jFh9q89P9Ibdt01EDdkSxATuoOcKgN+sYkaaOL6g2DDjlXnxJcS/P005lK5+53
         3nO7WEEA7AVKcfb6cXIbRD3Irw92SM3M0Tt1GEM+tJaVV94dG5Ufw+CEN7NI8Ltsne1k
         jb/WXmSs4VH+4VnwgG4DIiV+B1hJ56h8ZQ8TfxYDSiMALeO4dwNYwzmKAG4j/QCKoVRc
         GzNnxbjKxLbQVdb3nzjdHq+r4Q96B+PKO1lEL67rs8wMuFeqQ9e+g553sH+dL1vphoOv
         QXoywaCeYz6ksj6wTB4t2MZ6U4Yn6yst0BIl3avf7Q13MKEq1pqVIvWoNxEWFciVf8el
         stqQ==
X-Gm-Message-State: AOAM533vntXnxT+dRFgpL2xAtdI3GUzJRZcWsbLiHLn5KtFPzBKDOQBD
        INXh9aamlRxcWL5+9Oo+1ZQt+RGHKGRU6A==
X-Google-Smtp-Source: ABdhPJxQqBOLMlRwlFGi+I+Xo9f6bqsQkMjiTbjTfAVyFXeZSOc6wBlV2fzCCUPHfm2a3D7REX0cPA==
X-Received: by 2002:a05:6638:2384:: with SMTP id q4mr9006762jat.54.1630083456077;
        Fri, 27 Aug 2021 09:57:36 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s16sm3743944iln.5.2021.08.27.09.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 09:57:35 -0700 (PDT)
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210827163250.255325-1-hch@lst.de>
 <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk>
 <20210827164051.GA26147@lst.de>
 <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk>
 <20210827164325.GA26364@lst.de>
 <c7e538b3-e669-1963-b6c5-475285e96784@kernel.dk>
 <20210827164637.GA26631@lst.de>
 <5724b5a9-e8e9-d05d-83fe-8a0920261573@kernel.dk>
 <20210827165019.GB26631@lst.de>
 <6332d413-291c-7b1a-504e-aa69d6bf300e@kernel.dk>
 <20210827165528.GA27254@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e67cdaa4-7d79-7cfd-e377-d15cd62527f0@kernel.dk>
Date:   Fri, 27 Aug 2021 10:57:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210827165528.GA27254@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/21 10:55 AM, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 10:52:52AM -0600, Jens Axboe wrote:
>> As I said, I don't really care that much about it, but it would be nice
>> to have some actual justification for WHY it should go out asap. It's
>> not really about risk.
> 
> Because as part of the overall huge loop discussion it has resurfaces
> how broken it is, and how it is in the way of how the loop driver works.
> Milan for example has argued for just removing it ASAP because of that,
> but I guess providing at least a bit of time of deprecation would
> be nice.  Then again given that state I'd be perfectly fine with just
> removing it in 5.16 without much of a warning either.

OK fair enough, I'll queue it for 5.14.

-- 
Jens Axboe

