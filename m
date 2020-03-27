Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA560C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E65620658
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 16:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oqs4yyDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgC0QZj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:25:39 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40758 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgC0QZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 12:25:39 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so3975047pjb.5
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZ/2eIIHKKjs0cMEAc8LpHNkwem5h/jEq452IH82PJg=;
        b=oqs4yyDFclgrDRhoMmzTkx4IvWDpTVV3/VGeI1oUvIoLhc1Z4BBQmCjcf1nt0LpWQP
         HHSf9NxT/eQMDBfQw0uP5zmTNDYgP4EuYyNMF1ycyVMTQT/vqceXzZPjc2fOxtTwm83r
         NWjBZXGyiP3hrPbRPM4DlI5kCn77VunT9j7eKQ8dGEg9PS1LdJYltm8bthGtn8qoS0D6
         xozURWzhMKQqFq9KEHNH42PT4j7lwdOliZ5+J3kZ5bnMKkNj6ODn/Efv0gvvozS5aHIw
         kYf8szYWpmrLnsjk6ByMeg42x/kmOCgaFlbhkKj6G0H2OHV2rDFrK8eCCJMcRxDVTT6P
         x/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZ/2eIIHKKjs0cMEAc8LpHNkwem5h/jEq452IH82PJg=;
        b=eFyx5QljShZhH+dDEWWHtZP1E8fD5DfFItqKuB0Z8bcuiqCikV6RQ/Hn9am2pMLyv7
         bcbWN9H1yh0TVZVDTEd1GbbIse91J/Ax+661RykWi0nZsBQo1lAAHMDaE8xxiXlExyBO
         0/EBaM1ph1bLo8w/Y9V9T1M0C3nF8zrMCbDulNsYRIPivcwNtqQtuEglxal833aYx7p6
         PaQsyXdshqjXquHFi1SV/Gc2sEzaVIGyv95IxIIXE1m2KaqLrOByLJqFS/V1LIlQeXNS
         qyVjPzoFmiEsNWCgiNvbo7ELm/nIK3cyg0OyCNmElRf4nJzLWmJHCIITA0/D4NrB6OUo
         a9gQ==
X-Gm-Message-State: ANhLgQ2kVnLL0W9ItPsNUlI77D8S0ucg8SJgaiBaNni7rV5PjZcrKwfH
        /8xbE79KeW9c+dWiPXCmHNXsq6qYCNdTJA==
X-Google-Smtp-Source: ADFU+vsJjoS9XZFzz1BLRv18rznzUzFqsZnppTzODT0Wo3yh0SIYw8SlCZlR/NUVc+xGlYUrvmGtmA==
X-Received: by 2002:a17:902:bf0c:: with SMTP id bi12mr6976930plb.312.1585326337241;
        Fri, 27 Mar 2020 09:25:37 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g4sm4487037pfb.169.2020.03.27.09.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 09:25:36 -0700 (PDT)
Subject: Re: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB496594887E19F1C972CEC9B786CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <093c4ab1-924f-b109-31a8-ce5813f52e14@kernel.dk>
 <CO2PR04MB2343F7076EE9192F1015C34FE7CC0@CO2PR04MB2343.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e7916d89-6e94-a93d-5d74-536e87c7786d@kernel.dk>
Date:   Fri, 27 Mar 2020 10:25:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CO2PR04MB2343F7076EE9192F1015C34FE7CC0@CO2PR04MB2343.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/20 10:05 AM, Damien Le Moal wrote:
> On 2020/03/28 0:35, Jens Axboe wrote:
>> On 3/26/20 9:12 PM, Chaitanya Kulkarni wrote:
>>> Hi Jens,
>>>
>>> Can we get this in ?
>>
>> There still seems to be the unresolved issue of the function
>> declaration. I agree that we should not have a declaration for
>> a function if CONFIG_BLK_DEV_ZONED isn't set, so move it under
>> the existing ifdef.
> 
> The latest v4 series that Chaitanya posted addressed this issue.
> The subject of this email is indeed v3 though...

What's the msgid of that posting, I don't see it here?

-- 
Jens Axboe

