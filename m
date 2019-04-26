Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22404C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF1F206C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 16:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rJCcskcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfDZQ0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:26:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42022 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZQ0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 12:26:20 -0400
Received: by mail-io1-f67.google.com with SMTP id m188so3400215ioa.9
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2019 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXXN8ZW+v88jWMlh10pROUrjh/PUlsjxAJQZsTeTEqQ=;
        b=rJCcskcjKgbNaj/MaGdTFKmeBZAtMEKpQd1WeunPpiNzWvrHiaDOn+zbFOTXJ9lPfR
         Mn0Y/0aoyLgUUTwTfuhNcR2mrN4widPCud+3V/eQaSS5cPPcwGO2PmInlY41QLmwJ2Jl
         8U34f9t7ydyy/SVbvDineM8L/7bao0Qloh7jsOz65NW7o5TDhhAygP+W9AhfxgTZIvLj
         ZIcPDLFMSTXGtQQS7t5eWz3tNXGkvUoZ0NgIHEVj4qk39ENCndRPyp9SZHoZ67C52J/r
         VTQ4iPmliACUoiaUc0VA0qhYyVqCt3wEKVlng9mH9c8N6qopaJ0r4QnaC2io6b+HXOGY
         geJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXXN8ZW+v88jWMlh10pROUrjh/PUlsjxAJQZsTeTEqQ=;
        b=LoQ6wUXH1e/if2SgftLDy3aB8etxEInHp4OOZS9LLD2rPpRyl6VaT6nrV5CPCqpn5L
         98aEmEihrPm7p2187OuzvAGq//CsWbIqqQybHEumKss1VfHSg/+4DpTNnQ2i3gwLUhAL
         WXnlZ2IJBRqTn3sS34Fd4U2PG8keLV6U6fpANDsT8RZIRlUf199LOU4mB00yMemig+DI
         lTtibNOmxkjYoXWFo8b9uzY91nmm+sWshKw0yejhlbGr4h+EeX4tr9HZQXTzxS8aJaEg
         NkuxCWlnDm1WO/jLIHJb21jc+KL+8HqSPtzmix5w9QS2mW0ATWJP7QWHKfYXkPFiRldT
         DOhQ==
X-Gm-Message-State: APjAAAWm67HLBosEAmxZaoCLJN5dN6CXvNVWOlqu/EXjGP7C6zfKI6GK
        nIUNYEJwoiA8xObnd5G2sGnVsQ==
X-Google-Smtp-Source: APXvYqw/ROR8LtHhjb2brj2EdJfASxxw72QFzIZ+wNw2dGGdBTvCDoP2U40w0S5lr3xFozG9tgloLw==
X-Received: by 2002:a6b:b7c2:: with SMTP id h185mr14855303iof.263.1556295980061;
        Fri, 26 Apr 2019 09:26:20 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j10sm1476338iop.39.2019.04.26.09.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:26:18 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.2
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190426144744.GA28094@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9cde332-7bd2-46f5-3b6a-b436199f8ad6@kernel.dk>
Date:   Fri, 26 Apr 2019 10:26:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426144744.GA28094@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/19 8:47 AM, Christoph Hellwig wrote:
> The following changes since commit 95f18c9d1310730d075499a75aaf13bcd60405a7:
> 
>   bcache: avoid potential memleak of list of journal_replay(s) in the CACHE_SYNC branch of run_cache_set (2019-04-24 10:56:29 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.2

Pulled, thanks.

-- 
Jens Axboe

