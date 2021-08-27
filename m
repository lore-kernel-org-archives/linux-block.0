Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B2DC432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C464A60F92
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhH0Qoo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhH0Qoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:44:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B939C061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:43:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h29so7627515ila.2
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yb3KGuyL5rMZgN6GyD1kiCREDkipvhQZpPdIo8x6buk=;
        b=DobXX9syAR5llofWhk+UgIJ5/wbC7g8KaEyevggDj1rPZg9hKFOSeMUNRVtQ+NvCt+
         kTK8i5IVSRjlYuR3po7i/wvq0ahy2QYVDptUo+OFODSgWcr94tWCwchHAi93QGZE2NhE
         O5UOomne+uZFsimN4aeEuZ2wU69FD92y1rHtR3zzX8gI8/aUkaLwHp5AU0Db4SZl9V+U
         806iUCT1ksxHe7RMbgBJ5k7X5cM4V4q+NGDsI75MnJF1Gg4BxNpgmnhzCaiqeqkiecan
         KXrByYDHKk6yYaTjkLzRWA16IQny2Py0OM3fvc4gBgYvzjXjcsHJ/eYlHwGppJ0MkR65
         ow+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yb3KGuyL5rMZgN6GyD1kiCREDkipvhQZpPdIo8x6buk=;
        b=PaPwDvbPPlNdZ3hbPaAuVQW+Q76tN02TVzcBbgITwMvFXB0CJcJt2qyQPWYiElBztw
         eHOPkGJEJP4bL0NWi/INSAhhNMXmiXHbXayoqp6s2a0BJjd+ryymXEC9S7iySvxkmE5/
         mxuAHtkSdnVch4gk8TsgaFn4r/HS/n1s4PFPe8SmzA23B828gzVY+QYjmjJ2ygfpYYM8
         JAYqCRB+tyo6choWRE3qvzzrc25joSUicbQPtohhjV2M1LqT42gizVjhYTcjrt4DlcPK
         pTLrd0VB1PRiLvt3mNYvpKhTFj1fXPqSUh9533l/YMomB6U7syqK4k12abL5ru/jG1Ur
         424Q==
X-Gm-Message-State: AOAM530nkawkA3cGLHx1XmUEy2NlKeNjN7PUC5JBnt4qeGmD/AibVTtI
        UkzD7l93qHsFvNXo+9ZXvkjGM9yBlfavxA==
X-Google-Smtp-Source: ABdhPJwCUiPgDnas08mIHfHMbtwbvDGvxzukpkavd4lRyweNBMBnFUetVk9A7cEscgxOIGWn4uKMvw==
X-Received: by 2002:a92:d211:: with SMTP id y17mr7215696ily.93.1630082634564;
        Fri, 27 Aug 2021 09:43:54 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a17sm3743084ios.36.2021.08.27.09.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 09:43:54 -0700 (PDT)
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210827163250.255325-1-hch@lst.de>
 <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk>
 <20210827164051.GA26147@lst.de>
 <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk>
 <20210827164325.GA26364@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7e538b3-e669-1963-b6c5-475285e96784@kernel.dk>
Date:   Fri, 27 Aug 2021 10:43:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210827164325.GA26364@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/21 10:43 AM, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 10:42:59AM -0600, Jens Axboe wrote:
>> But what's the point? Why not just wait for 5.15, it's not like we're
>> in a mad dash to get it removed.
> 
> Actually we kinda are :)

Because?

-- 
Jens Axboe

