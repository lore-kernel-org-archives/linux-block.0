Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BC5C433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 19:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiBCTii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243647AbiBCTih (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Feb 2022 14:38:37 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BCDC061714
        for <linux-block@vger.kernel.org>; Thu,  3 Feb 2022 11:38:37 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r144so4602431iod.9
        for <linux-block@vger.kernel.org>; Thu, 03 Feb 2022 11:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KMyvXxqCDb6LDE7y3iumEmVuNT5U4aq7Dap4O63m+bI=;
        b=qXz0rS8NcYokjoLP9Ksn6b1Hl1UVTBZaVHrJZ/PkYB88MuVq1hiYtw2qHxOD73i0UU
         LZAIz6CSg/6FWHKseg91LFs9a3sWBsNjneTIV1ka2N2sTPotIZ37b52mPC1ufUe1MEeT
         QajGSxOwVsAP7PJ0z+VV3CDgduVozaWIpch9fRM0DF/8aHk9jawswO7iBt1bOcGdhgNA
         HZnB+Lv1KGi6eRTrH4AbiKjc9S9uk3nsuqljwoji6y0Xht8TDqSIrK8UzfyiaR/VXq1s
         Ut4UWgfHahOtIi5XwM1S6HOmYBqXu+8qN1NIWYlHX0QWj5Nanpja2FG2w8zun3vi5Tzy
         9SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMyvXxqCDb6LDE7y3iumEmVuNT5U4aq7Dap4O63m+bI=;
        b=gYVvMDcskvHlMRceW3XBuHMS3eCK7SM8rJ9xtgqqRooByHdR0O596xWrhyfFMH0CEF
         QCmonNTcMkSKgNjXRZGuiqqKnKPoAECTi0zD1lU+iDRLUs2pREzXCzCtLlvMJSKEnF0r
         StTpPF97WtoK6ZLmq1D8Fw7g5JCLW+L+i+jNEFgO1G8slJB6qlLLdMbEjEZc5CZIDPp7
         qKjfkxlq80cQVOoFU5Kt34RmsIWUOFOgUDD4ot0w2qo/AAi9NWH7UECri6IBnSkNj+qw
         t/onH+sT2JUFqDps55Wf55HyoiPM4UX7misw2itSm03vM9QuxnyVZtCi7xX1YD766l5H
         Dbyw==
X-Gm-Message-State: AOAM531Z6yQHsIMcCaEGocxewDve3Bxh7EXuVbgjSEOh8ryoiehrKraR
        XbinhkvA23Z1/1PbxmHpGH9jdFHEY+W9IA==
X-Google-Smtp-Source: ABdhPJzH56mqARnyv2gDESVGncDRHuJg9OxnfaW41W3OT+nVoAKMFr3MHvb0IEmtLf2ouXK/3GcGRQ==
X-Received: by 2002:a05:6638:2105:: with SMTP id n5mr3761688jaj.266.1643917116406;
        Thu, 03 Feb 2022 11:38:36 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d2sm5229241ilg.43.2022.02.03.11.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 11:38:36 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YfwukSSzRWJE2Jy2@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <26d483ec-e397-822b-343e-3f7e9f09927f@kernel.dk>
Date:   Thu, 3 Feb 2022 12:38:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfwukSSzRWJE2Jy2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/22 12:35 PM, Christoph Hellwig wrote:
> The following changes since commit b879f915bc48a18d4f4462729192435bb0f17052:
> 
>   dm: properly fix redundant bio-based IO accounting (2022-01-28 12:28:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-03
> 
> for you to fetch changes up to 6a51abdeb259a56d95f13cc67e3a0838bcda0377:
> 
>   nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts() (2022-02-03 07:30:57 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 5.17
> 
>  - fix a use-after-free in rdm and tcp controller reset (Sagi Grimberg)
>  - fix the state check in nvmf_ctlr_matches_baseopts (Uday Shankar)
> 
> ----------------------------------------------------------------
> Sagi Grimberg (3):
>       nvme: fix a possible use-after-free in controller reset during load
>       nvme-tcp: fix possible use-after-free in transport error_recovery work
>       nvme-rdma: fix possible use-after-free in transport error_recovery work
> 
> Uday Shankar (1):
>       nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts()
> 
>  drivers/nvme/host/core.c    | 9 ++++++++-
>  drivers/nvme/host/fabrics.h | 1 +
>  drivers/nvme/host/rdma.c    | 1 +
>  drivers/nvme/host/tcp.c     | 1 +
>  4 files changed, 11 insertions(+), 1 deletion(-)

Pulled, thanks.

-- 
Jens Axboe

