Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA0C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 20:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734DF20675
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 20:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3rRjlwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEFUNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 16:13:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34726 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFUNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 16:13:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so7019494pgt.1
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FdxMRVR3sNdM8SN6kFBJuI0oFnzpMCrw35bl/txvaPE=;
        b=B3rRjlwrVX6rV8C9rLso/OS24/SQbI1QRLifwuT4T8PJgeu4n3FMZNykw402sAuAIN
         EL4rfSkiC+cIk2PDI3Fa277TGIOHr6d3aueAjGTTHQKpXTDyA0EXMaI5UKuItRAjJcaU
         EviTZZSpwyeNnua5bVqhncVKNY0xI9v4HuHHyvX1nwRORrBTYJYhjBisr50JUidRDNH/
         XfUyaHjKl3qGIsEX5O/EoaNWFKynoW9yWmyxLa2STV4xdz/4XUx/EltgA+4m3Iah1N1x
         2u+1nXRy/fXhKJTfeqALNAYleLSlwSdNhpR5k/EvQOfbfXYQhVzm46JjLeXP0S4RqL08
         dQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdxMRVR3sNdM8SN6kFBJuI0oFnzpMCrw35bl/txvaPE=;
        b=f50F56h5qnRVogWt7cRW8P0gMX6Njx3xHEQWxK0AuLZeshEnbXEkNn0wyJk10fSMh9
         IRcz9HSiwluu2eGi47hH/B1E4RXb2y8d2XgVLbE98EP3v4BKq8QemZIIojBpq0sOMmba
         E8sdkYWfahvP0spxQ73tCYDR5FyYu2V2YUjnm2IWWbMx5CybcmhnJJS56DiUIeh0/0yS
         wdfWv6+huotRS4Xcr6JyB4iBQ/l6ZuPO8hvM1P1NqcASMEBjkxPMGeCLU+xMquzK2iNq
         yIg8EoHlB8AobjrXrolOAIDsAJbbBkYZ0ViA1fJq+0M2kXkoJXkbqI5PtRWN1NONyL/H
         XwOw==
X-Gm-Message-State: APjAAAUZTNIuvkX/4Co/LPtRrBoeuUfh3P0sSRe8t+HXpnwQ7TpkbZco
        wFPROsJvCQX7yfCXeSuqa2k=
X-Google-Smtp-Source: APXvYqzumHQCvubh0KMw/O472DTpQbH+Xo5C9TqEWO7Dnfc7qJ1ZXhYjR+bCQwcz40LNITdumKOhpA==
X-Received: by 2002:a63:5c5b:: with SMTP id n27mr24718784pgm.52.1557173585892;
        Mon, 06 May 2019 13:13:05 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id y4sm12951415pgj.34.2019.05.06.13.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 13:13:04 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
 <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com>
Date:   Tue, 7 May 2019 05:13:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> I wasn't clear enough.
> 
> It doesn't check for the return value for now. What needs to happen is :-
> 
> 1. Get rid of the variable strings which are not part of the discovery
>      log page entries such as Generation counter.
> 2. Validate each log page entry content.

Question again here.
Do you mean that log page entry contents validation should be in bash 
level instead of *.out comparison?

> 3. Check the return value.

nvme-cli is currently returning value like:
   > 0 :   failed with nvme status code (but the actual value may not be 
the same with status)
   == 0 : done successfully
   < 0 :   failed with -errno

But, ( > 0) case may be removed from nvme-cli soon due to [1] discuss. 
Anyway, if nvme-cli is going to return 0 for both cases: success, error 
with nvme status, then test case is going to be hard to check the error 
status by a return value.  It should be with output string parsing which 
would be great if it's going to be commonized.

[1] https://github.com/linux-nvme/nvme-cli/pull/492
