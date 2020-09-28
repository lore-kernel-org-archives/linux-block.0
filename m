Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B1C2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 15:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AA121D95
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 15:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C44J497K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1PDl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgI1PDl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 11:03:41 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6536AC061755
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2020 08:03:41 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l14so1561632ilj.7
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2020 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xh1VP/VnNfBNF4YXtIYhq/tFvDo4NDnupoPdqgecyK0=;
        b=C44J497KcQDvfvdsBiKn3FKLvi7DWom6fq6+zvhppAhQO+2k3qW03pQuuBa9raLnyj
         XOsSohcs970v9YbXtchrMOvvMxjACSEwZN3qlonyK/qwpMK11YJxko8/WoE4398/Pomt
         Sb+nRjd4WIgBKG/4s5rV1ep5aVSds1ClLeTYgZvsKoWjq8r1e/sKVuHOwnhqkALOs/JK
         KzG3ZqDWvbANLj/yOlcEq2t1XN10KDS8U2SF/U6ASr6NxJW7wLrD6TQ6JcIAERf1oBMQ
         uO9Ml5btBlA/z7og3i4v+eXBFvghUTYa3D7On9l0nMo81cvJxGxd1W1z8btVhUsL7TBL
         DWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xh1VP/VnNfBNF4YXtIYhq/tFvDo4NDnupoPdqgecyK0=;
        b=pDvdsPhvqj3ykRAwB6pgSoxLnYGIMDyffstJ7E9DYs7C7UQVHBF/zOn7ovr7Ke3pl/
         CvmDPCB3RYngmPqvE2roJsNygQ64SSXD6QhR0Po8R378GnYgOCiuaGSIVbESAl3SJqKj
         uRUIyKBJ87XI5Eti+i1383atUzuZ/3q5D6uYgXF/bZ+DrJaMzXwOzlhuB2GAf04S+n6r
         sYKnrd1K48F0vJ9p2B1ziuoB0UieQJBTB3ATV039wK3BFbBLVE97L6eIzBBl0ACcpchJ
         o2xbOJ1epNY+BwnW6SHdFO1jfaQ8bUp/ZwXFUx02MyNoj5OXM3o1XfRmsg5CLPVIMzN5
         iDzQ==
X-Gm-Message-State: AOAM531KA2CwSxGbpUvaAdDsidgDmHfcP35ekbDqhcCFzjyBRAlZtJOv
        0/dAdJbLKjCZBXcOFZhlAt18mA==
X-Google-Smtp-Source: ABdhPJxPxQcFv/QNjIea1RXUeViyDl6Wyoxfixl5JT0Sgq3nvWzkIMmovI+VTHNg143wGUAryHA0ng==
X-Received: by 2002:a05:6e02:1066:: with SMTP id q6mr1391611ilj.12.1601305420673;
        Mon, 28 Sep 2020 08:03:40 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m18sm736338ila.27.2020.09.28.08.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 08:03:39 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200927072343.GA381603@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f724198e-fd0b-765f-a089-2b03dab899cc@kernel.dk>
Date:   Mon, 28 Sep 2020 09:03:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200927072343.GA381603@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/20 1:23 AM, Christoph Hellwig wrote:
> The following changes since commit 163090c14a42778c3ccfbdaf39133129bea68632:
> 
>   Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.10/drivers (2020-09-25 07:48:20 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-09-27

Pulled, thanks.

-- 
Jens Axboe

