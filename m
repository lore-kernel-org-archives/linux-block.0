Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E8C4363D
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 13:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06002083B
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 13:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LTL8okOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJFNaO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 09:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNaN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 09:30:13 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CDCC061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 06:30:13 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id z5so10969444ilq.5
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CV/n82N+Yw4dUynXeCjpgLLJjo1Vn/U93uGC+f0K6GM=;
        b=LTL8okOju/srYLpXofX4O7HOScBCt48jBPFY015YTDu+My39wVINUCSABXWKOKIDwv
         oq9ogO0I7LO8ViNih7wW2OsDyrvLuBPEZuqMnt6FJPM5bdcZIfjeYHha+blUsfT4Ij0U
         dAqkVqS+A+9/oNxaTatwhTOZSR6DmQSq01nWrO9ya/GRl88YQGOKtmLfDrj82QCfLMkt
         2/KSC5mRzqv9TSKyGmUOabpKEuEoDsQCpTfN64ZykfV3XVt72rMgCbpr75KKgzr0H1Qo
         1Vy9J9kQnPnMIWBzPQTpZOCmvUsRXkMaAU3jtIqvuB5kUaO62p3zQixap6D99np4YikE
         N9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CV/n82N+Yw4dUynXeCjpgLLJjo1Vn/U93uGC+f0K6GM=;
        b=WKvl57OPC1rwkr3TrJVKXwV5Tjc0meWbMj4XVY59lAPJVqH5avdNXNBVPz2vnCtcqz
         ygHfbc3TytlTyjKKbe3tSBhsGk+Ew4Mki44hYr8ZCHTkvkDYgFP5m9ps9592gLBGyv4g
         pFvMAkimz6UJ5WvnrtqdFL1TEIiDtQdar6h2+Wh4l4F8OhwhGHnOpFbUCRz1g9pwSOwv
         y5J/FEN6leKXttTgxdKwjktEjxF/z03yIhrp4FFrnsAl2shhAp1/kbLYgZAl7mQIMu/a
         VbtCpoeyfhPTHWnRo8wB9Gyzl3g0ByQ7N21BtCdUxI7boD/ltYbH5NETJozH3p8JGods
         r7kQ==
X-Gm-Message-State: AOAM533VR6bb0LBfhAG4r3g9QcrE4nwZ/o/Dh1/b1VsBQRMEK/uh9Rr3
        wOtShKCowCPxKwK9hvocnqzK5Cdd6LSATw==
X-Google-Smtp-Source: ABdhPJww/mIMxuhGvqvNkBvvH6NuQEVjPKJ/axGsFfVeGDVTkS1WK7sFNnCjSWj5u2sGYm/Lp49ctA==
X-Received: by 2002:a92:89c3:: with SMTP id w64mr3153508ilk.49.1601991012309;
        Tue, 06 Oct 2020 06:30:12 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u15sm1494860ior.6.2020.10.06.06.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 06:30:11 -0700 (PDT)
Subject: Re: trivial block layer merging cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
References: <20201006070719.427627-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <78b927ef-0934-08c4-4cbb-1097e77c81a8@kernel.dk>
Date:   Tue, 6 Oct 2020 07:30:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006070719.427627-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/20 1:07 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series has a bunch of trivial cleanups for the merging code.

Applied, thanks.

-- 
Jens Axboe

