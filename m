Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79935C43381
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 01:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F620222D9
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 01:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FkiIkI/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbfBPByk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 20:54:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38155 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfBPByk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 20:54:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so5832797plb.5
        for <linux-block@vger.kernel.org>; Fri, 15 Feb 2019 17:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FkYxdSLSYKazdd/Z5jjcFJ72p1rjuMhATYP5xRDdzPg=;
        b=FkiIkI/4p5TDiybPnJeKLcRpSM1fmlbIUoyMOat/8LWGOea3MVEY+FI1T07gyxEBuR
         vzPo0pJT/JvF+TQoeHH5Mu8WCP0LDc1QA+oK6LEA2ZnKLyO/3gAYhPXFkgVxDhTXHmtL
         0+MmDQBuFO/GQ0+5F4GaiXssUCgpqRbDFkbIXsmyR8U5P4NQbgnGkd0J4udmYDPDVPHl
         HucaB+A0WDIKBy3BmOjzRw13p5XimTPgAxbA1z2KGPZK8NywXio9wnAJ7FFvzAbTwmxD
         J2Ve5rLAPS/9Edyvy21Clg/dygLNjJdPMbHyPuj+h1oqIyoVWlBExmJ/0CWBuZCsq6Uc
         5aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FkYxdSLSYKazdd/Z5jjcFJ72p1rjuMhATYP5xRDdzPg=;
        b=i2La3qh00Z/kDSr78E999cujOdap1WIDXi61SmAkpYUKENL7wcZ921creqXGKqFpKR
         6jnoErGozDsjbjJggzH/NSfWkErsRREulXNsQiJ3Kx8rD1aW4Ipwefgq5Wc+uo+1OMZq
         61phnmyDpgYvz7vKBX7GLB8c7oIQVoK6FwdLEM0ZPcU27z2Zx8/m9dp41q6NUnqkJZhe
         FZd/FzkwuUz22IJv6PxHTdHZAcTD9RXm8imA81ECjfjseNtRSkW6StVyqghpr78NlZfI
         ing0F06YRT7QjkiTzw0rG3IlvIrrEGAfObKd0Ss7QdudF9BktiKg7OKdF1JCJvPTDoOK
         I0lQ==
X-Gm-Message-State: AHQUAubjabf8LjSgd2bxVZFP+AnXyARCiHjOEtP448rHjzRvF/q1HdxV
        32Nx8CgxmN6hstFBRz3NqHCB+A==
X-Google-Smtp-Source: AHgI3IaphlliGTyXE+MHakC5Kr8nYdQRS89Rb6QVmO82JYs4xCOcBC0nxPnb6QB3I0IFYLj/6JvG8g==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr13243286ply.132.1550282079513;
        Fri, 15 Feb 2019 17:54:39 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p2sm480501pgs.7.2019.02.15.17.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 17:54:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
To:     Felipe Franciosi <felipe@nutanix.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
 <1550266894.31902.104.camel@acm.org>
 <11A6C7D0-A26D-410F-8EE3-9AF524DF2050@nutanix.com>
Message-ID: <5a370041-bd59-049f-3cb4-7635dedac8f8@kernel.dk>
Date:   Fri, 15 Feb 2019 18:54:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <11A6C7D0-A26D-410F-8EE3-9AF524DF2050@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(resending, as my phone email client turned this into html crap)

> Hi Bart,
>
> I configured 5.0-rc6 and had a look at the io_uring code. Finally worked out how to use FIO's t/io_uring to submit IO and poll completions without system calls. My _initial_ numbers still show SPDK being faster and more efficient.
>
> Searching the lists, I found a few mentions that Jens published a comparison stating otherwise, but I can't find it. Could you please give me some pointers?

I posted some numbers with v5:

https://lore.kernel.org/linux-block/20190116175003.17880-1-axboe@kernel.dk/

Sounds like you are using sqpoll, you probably don’t want to do that for
peak performance. And you probably want to experiment a bit to reach the
best performance, both in terms of setup/placement and kernel
configuration, runtime options (like iostats), etc.

-- 
Jens Axboe

