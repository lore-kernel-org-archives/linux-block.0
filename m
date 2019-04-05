Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2A1C282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 22:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8852175B
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 22:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nyBeMrol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfDEWWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:22:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41081 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEWWI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 18:22:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so3761494pgs.8
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 15:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s0RPRlUMaxt3ZvlDuzAunfgodw5J6FXqJvlwNy/JAX8=;
        b=nyBeMrolLAlj9o6JSOjfO1xLDa8qQrN8MTSnIKMZJYWMfY8XAZP5fQ7dPndakEbP9b
         tmWt71LmPFEk8S1yTxU+/VHdThztUBxaqLdTOD+qCXR6XeJmPFuAgqFCbkV+Vnt81UJl
         u+X0ZmFVLfziAY9bXCw7PhqOL6HHiNRfYd7lRmXtem3NUu6+s8PvLm//YcjSGb1+1Csk
         vkHMSJSDVY0n/bzfiCDMvYLUpsu6S5SMF5WtLMpV9Q+a9FIvTVuOAQ5e6dZ8cqMEYj43
         W3ZJebEe6zhi0IHKW9UyhclP1KG4GN9prle50mCgUuN10jddRQJozQDrioM4bdIHIpV3
         iH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s0RPRlUMaxt3ZvlDuzAunfgodw5J6FXqJvlwNy/JAX8=;
        b=S9tFHwPNAEIJxMWmtPH+3rGUzFYGL9hsA0Ybn1NDD6LHTHmvRRymI8NnY88ClOAZHa
         SjjB8VEl7UFp0aKw0FsE56yD/TDnUEkfDoixpo+kJUZr+VkEGeOtmgORtSfIRRrzHGJf
         QNN0RQo95kun/N3Dor5poVE6qOzbRVtzLmujtR/+tZ/9aAJn4Q3aFDF+U0YXC7ssxWIw
         mVqnkSw++4Oc95hzchrQvU+dz9fHvliIvjRjVIUPcKFej0T/PuMk/ttCitHORNYRyg/K
         NUPw3/kMFtS8tilF/xOC3pXwCImw67pUTWyXVTB7fzkvCMV9avkE6cu297Ggm+0syyEM
         LCmg==
X-Gm-Message-State: APjAAAXO7sWyWKLATTRGQETBolOPHw+0Xdd6IYbfZ5NQx4RLrOr04FTv
        0yqCP5lc558BwXvjku1wFXAyiAjEp+plDw==
X-Google-Smtp-Source: APXvYqxWLBGhk94TO6QuQiiwSgkeXH+NNeRcIQB9+9a6Rst57HCIS2PE8+nnj8ejyw9Bt67P5YOFrw==
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr13592889pfv.10.1554502927375;
        Fri, 05 Apr 2019 15:22:07 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x9sm38798503pfn.60.2019.04.05.15.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:22:06 -0700 (PDT)
Subject: Re: [PATCH] null_blk: prevent crash from bad home_node value
To:     John Pittman <jpittman@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190405214245.19834-1-jpittman@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f737dfe8-9e7f-4cb2-1f15-82daa62c479c@kernel.dk>
Date:   Fri, 5 Apr 2019 16:22:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405214245.19834-1-jpittman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 3:42 PM, John Pittman wrote:
> At module load, if the selected home_node value is greater than
> the available numa nodes, the system will crash in
> __alloc_pages_nodemask() due to a bad paging request.  Prevent this
> user error crash by detecting the bad value, logging an error, and
> setting g_home_node back to the default of NUMA_NO_NODE.

Applied, thanks.

-- 
Jens Axboe

