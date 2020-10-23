Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37431C4363A
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8C2208E4
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 13:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VCC09/Lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464849AbgJWNaD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Oct 2020 09:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464848AbgJWNaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 09:30:02 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9BEC0613CE
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2020 06:30:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p15so1790827ioh.0
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2020 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wo33AF/eHl++Ndc4RAiFaBKLGpgps3aqCkCP9OF1aaE=;
        b=VCC09/LmkVAnukssUgfSBi9Djclq4e3kv/XMUshDAlsoQ69J8XkKZAX9jI2WNNlMUW
         dwL/b/GwFHJUnhzQZXDig70fEoCpibkUN395N61QZIfEtV5XwQeFrzDcaFJCDa6fh2OR
         /3k/Wd8/hjBunCvL2tzHWybkz/xNPxSa5PrF55R1t0F1UAsU8PN3OVPSh3EwtoS8z52o
         ip6cLFED0Gu/vo6ENfa8cyDwdSCXhqZ5lGQk2+NZJjUK7YHoXBm1+KlW+xo14QasyTO+
         eSWHnEGC1uOqIw7+TIWBmGi8MR73CRoREgSIw88/jT49jS6bO/ZwHwM/ivu3UCWroYdZ
         4WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wo33AF/eHl++Ndc4RAiFaBKLGpgps3aqCkCP9OF1aaE=;
        b=aIb8VoBQm7LPFjuLMOlNdZGy3ItrrB6d9R9jebP6Mb5f42n3ddRKszAoUP65v/akEJ
         WGsF1Xdtq1FTG3nt/f0HoOmLE+4Fb2VZmA4YatjCCd1yehHyuMcsYL7WSq16pUmcwdJA
         Dx0/6CSC1/yxjSBICjXTyigMw/zoju3N7BmFvt56ivR/21ztWBAOqEu+Gx/SfeY4QfV9
         sG1gz/1LJkLQIxiTVpPymi7kNHYPzDLDrjBq8O93yHGV65g2HL+NpQVUSm1dOz/EPYLO
         MEVHSTPAQrSq+1oVHB4wBB7ECoBb9JE347PZa4G4CNg8ta4BUET35s0B73EUcsuxRiSm
         oXHA==
X-Gm-Message-State: AOAM531nCB7XRWUsfgCOVHFPj3/zIUa6InDoacxxnXaMPdOtCzEVB12j
        SvjsTS/E3Q8V/OVklHdMDX6hshrcs/UXvA==
X-Google-Smtp-Source: ABdhPJzi8cVQHujhSxpuIjUe0YPPRanj0p5gTW6m5d+T4mscJHJ1ed6v9ixcli+/EXwS+SxKKuPc3A==
X-Received: by 2002:a6b:fd08:: with SMTP id c8mr1580771ioi.16.1603459801254;
        Fri, 23 Oct 2020 06:30:01 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o13sm781343iop.46.2020.10.23.06.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 06:30:00 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.10-rc1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201023110035.GA3504312@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e3120d9-7c08-1aba-1481-118131a459b0@kernel.dk>
Date:   Fri, 23 Oct 2020 07:30:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023110035.GA3504312@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/23/20 5:00 AM, Christoph Hellwig wrote:
> The following changes since commit cb3a92da231bcf55c243d00fa619ee36281b0001:
> 
>   block: remove unused members for io_context (2020-10-20 07:10:14 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-23

Pulled, thanks.

-- 
Jens Axboe

