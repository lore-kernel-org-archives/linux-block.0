Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06634C433E4
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5A5207BB
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qHhvmYUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJOCR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJOCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 10:02:17 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C463BC08C5CE
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 07:02:16 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t27so5124437ill.9
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=feSplbdpMN3GL73AIVEFNJv5/fgFSu0hAgIYhS6v32Q=;
        b=qHhvmYUqJQM477rO/uq9GuC/S6vQrrzy6XK8a73LAmgRPIL2w0x+N4M7SawSrMLj4l
         5MdUuruSqxG3HAF4ayP13MkBqojz6gUgqbbK+fpcczM/Bii3qZdyVztQvqIZXQnFrTkP
         fTRHtxWgTtjMFP5seQU7T97BCMjYT75IOm52If4Hz34GCs88vnqrKo+/651sdVsgyP8l
         QGpKfakdfkEB/E7al4li1UReHxEDylfAT7ynW04GZvDhs5d/7ahZdIroybT4fNI1tW9Z
         fJQoR+9SyRqIfvTGX3TOWQQxnpG0V419sbU7NcUs2b8WC5KRaLCnQsYKcKqgYttFTwrR
         +lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=feSplbdpMN3GL73AIVEFNJv5/fgFSu0hAgIYhS6v32Q=;
        b=PIUygYZzKemThoci6ICiNRr1m5n28u9ohhxhLPrbx6vqpLD/DqsGw1TbKYpPTWiUGM
         Rbjt/UEFI0K9MSEfNLswk5uInRRp/430zhUOW8z9vuNJGactTp6HzbIYtL55T6G1fDXh
         2zUwUrw0phXK6ixENvxjYRd7zcWokzFzbPNSkwLNdHoL/UIPRNsArYSYd4XfZqU18Awh
         2/8Km219fPztJLXSMgCecdy4wKIdAA4IQAUi0rVGp8rjYrUu0iyu3P2YQ+GanOC0vh9u
         u1PbtrE+TWThtcvRPGjE46g2f4sNR9VgmqFOHgdDfPHLIyOtjeDsNGWbJq5U/z5vFdSI
         EAkA==
X-Gm-Message-State: AOAM533/+ODajPLy2Z8exYs5/Wo8xnKtSeZDUCP9enHIfC99xBKuIsMj
        eKFTfWyKdIwqqPZ18k4wTis7FA==
X-Google-Smtp-Source: ABdhPJyEG+rPLTvIhTU4mi92nYP+7MDu609t4g1jTerr2y82OCJ0b777KUBjLgTuN4pkX3yCOR0VIA==
X-Received: by 2002:a92:bb55:: with SMTP id w82mr53553900ili.146.1594389736045;
        Fri, 10 Jul 2020 07:02:16 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x1sm3430633ilh.29.2020.07.10.07.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:02:15 -0700 (PDT)
Subject: Re: [GIT PULL] first round of nvme updates for 5.9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200710134826.GA537445@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b7f32ad5-c3e0-61a6-18c1-b37ad81f90e5@kernel.dk>
Date:   Fri, 10 Jul 2020 08:02:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710134826.GA537445@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/20 7:48 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is the current large chunk we have in the nvme tree for 5.9:
> 
>  - ZNS support (Aravind, Keith, Matias, Niklas)
>  - misc cleanups and optimizations
>    (Baolin, Chaitanya, David, Dongli, Max, Sagi)

Pulled, thanks.

-- 
Jens Axboe

