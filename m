Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA9C636D7
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 03:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBPDZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 22:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBPDZz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 22:25:55 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD3746D4A
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:25:45 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id x31so446553pgl.6
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 19:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRrk+huqvLsREB4fXPHKW0WRe3uiCIWHsOsh8pv/9a4=;
        b=XTY7W7y3/FP0g25KTBnE6zZ5SpKVS70UtpSkBFbfZ/iBFaBf8bn+NhQ+Y3jjBZS8Qj
         zaIll7sroEo6SZBI+OasIkdd2Rvz5/zuz03DLEy6yreDLbJ/09+he64yieO18bBffvJX
         YxYOUJrBH6P/SkojlujxtRkdNgIIyOcGp6t0ntW/s41Hdy2s6XSAMQ1LKS+QkLNVAUqH
         KeqKuPlXKJBL1JvFs4T1RmscL4bNpMkiiBKXEi5UXdq6WhmMQWGkcmR20YXmwniM8wN0
         Wd2PUrfgQ+oapHwkiEyZ2LJRPpCBNiXRO5FpAWlU9ENK9dM4lLUJ8RikeZoH41ZwJs/A
         iH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRrk+huqvLsREB4fXPHKW0WRe3uiCIWHsOsh8pv/9a4=;
        b=Ky6iJkmhGtcjek3B13EoZ34am0KLac7K2joxLDic1gE6of40PomX70b1CQjL9mBV3d
         ZROb+2Gv+oLw76P8JpYoUJtr5nF2TCtM1j0Qckb/AQQt8TtPIeCSfG0aAsLOpxQ5Yg0M
         IY7Yg66YXCRnsywixFXbPvA/5D/lB/dLgbgg36HSoMRKrX/JGURbHtQ7e6VXfDbKEKTE
         H3ItgkUV1drTIOgf4M57sS42G7ChJ+xquE/QhCRuhBposLjEA8WIt4O1bn9W6lE7HCQ3
         AocADXMkOGjLnzzJgWDgzuO1qH79Zlit7scOY4b4iOIPf82FWlsY2BaEgP85dLa8/C1p
         CQoA==
X-Gm-Message-State: AO0yUKVXhLY9Lc9FWbs6eZ7/7r184jmrhtVLWqjht3SdGLNrcTlfTjt1
        owhf9pUt6x/03G/GEnTWW72h6g==
X-Google-Smtp-Source: AK7set9xQgpAoiffZypZuNUXQrvgcty21gEMPpnubTu+FZKm+RPYKyijBEDBbIObbqucc6tRvtqHMg==
X-Received: by 2002:a62:dbc2:0:b0:5a8:bc61:d6e9 with SMTP id f185-20020a62dbc2000000b005a8bc61d6e9mr3479436pfg.2.1676517944672;
        Wed, 15 Feb 2023 19:25:44 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b005a9051241b0sm91787pfm.129.2023.02.15.19.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 19:25:44 -0800 (PST)
Message-ID: <4c2ddb31-b384-2d39-e49e-2f6683062f01@kernel.dk>
Date:   Wed, 15 Feb 2023 20:25:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y+0hG6t1gTse7yfo@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+0hG6t1gTse7yfo@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/15/23 11:14 AM, Christoph Hellwig wrote:
> The following changes since commit 38c33ece232019c5b18b4d5ec0254807cac06b7c:
> 
>   Merge tag 'nvme-6.2-2023-02-09' of git://git.infradead.org/nvme into block-6.2 (2023-02-09 08:12:06 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-15
> 
> for you to fetch changes up to dc785d69d753a3894c93afc23b91404652382ead:
> 
>   nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev (2023-02-14 06:39:02 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - always return an ERR_PTR from nvme_pci_alloc_dev (Irvin Cote)
>  - add bogus ID quirk for ADATA SX6000PNP (Daniel Wagner)
>  - set the DMA mask earlier (Christoph Hellwig)

Pulled, thanks.

-- 
Jens Axboe


