Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B48FC352A1
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 15:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLGP4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGPz7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 10:55:59 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2DB6341
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 07:55:57 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id v1so7412235ioe.4
        for <linux-block@vger.kernel.org>; Wed, 07 Dec 2022 07:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vY3sTW09olG5iwk17y/KR4D0PYJv7DXQwuDqwAnD9N0=;
        b=NkggO5F8DoFYdKtn1k6ejKKSlg5bK57Iwa0ddvFWyT325M6hyXtfDm1Wq0TXYtxPBA
         nwhAnxfhlCOrGL/Sr86Nl845ukAtYsvSBAY7lsJcm9zC15xloOrjhgpKLQHRjYO8BH3Y
         iTNfn4ocRb/MGgmXS76CgXifN7frB1m03xDcOLWSjW+ROzDb5QDzNZolr4nij4rIBvzf
         QgNN9NV+FmuUZzi4a5vEgH5IoGTaTy35U8nBYvJw4mrXWs4Fc5qHnnmNGmLXuETGfoqN
         ewg0fG+MeqjhmxOTaJyFzFXwKtoFwb8+7S3oOjQg9vUXIeCGK2PYQgiq1fBSbgWK9h0e
         7dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY3sTW09olG5iwk17y/KR4D0PYJv7DXQwuDqwAnD9N0=;
        b=D4u87KoIGu+l5GY2Ndt0K7Esuior8sgdGZsXkDrXAeYWKKSKsH8o+9ze3FX5FoXjtt
         M5pjSCraAHx4xWj+gVPUo8UElt5GwwEfWbGrulY8VTetCdWHl8dJpDFDJlqPdSrro3ZN
         nOVTXVqUbaVR6baH0tsnbtrSPMOsktmvEYHGP6PFuaM4QEZIHeha+Myyf2wj6a7B2vIR
         3va8vDWUgPn6aEtHVBJv38rdfxmg7nJ/F5LwD4b7/w7xI5EVXRoLZQduEf94Jf9vq5d3
         E/yfdOEoRXgUa3nBcdHOhxwRm5rQZmqS63mtmAiJZpyV8Jqj6fyS6TcbSvNZOP7UL/As
         xPwQ==
X-Gm-Message-State: ANoB5pl6gIP09pPTVNRQqMZa8pyunrwLDzQwImYwzbs0i+HO8iDlvb6F
        xKT40aFBP2mjUdxhd8sECKVCwQ==
X-Google-Smtp-Source: AA0mqf581SVve8KUfSOdCN+l1E4b+gi1ZlHBtixl5dJR3Q6aRCQATAq1lSIK4Ft+p/OfTVGxc59MpQ==
X-Received: by 2002:a02:7164:0:b0:38a:e96:862f with SMTP id n36-20020a027164000000b0038a0e96862fmr13427756jaf.214.1670428556311;
        Wed, 07 Dec 2022 07:55:56 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u188-20020a0223c5000000b003762308fe54sm7780959jau.93.2022.12.07.07.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:55:55 -0800 (PST)
Message-ID: <a3829d8a-9db5-d92d-7e41-dbc59e092e38@kernel.dk>
Date:   Wed, 7 Dec 2022 08:55:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y5CeoZZcOCYaS/P9@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y5CeoZZcOCYaS/P9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/22 7:09 AM, Christoph Hellwig wrote:
> The following changes since commit 899d2a05dc14733cfba6224083c6b0dd5a738590:
> 
>   nvme: fix SRCU protection of nvme_ns_head list (2022-11-30 14:37:46 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-12-07
> 
> for you to fetch changes up to 6f2d71524bcfdeb1fcbd22a4a92a5b7b161ab224:
> 
>   nvme initialize core quirks before calling nvme_init_subsystem (2022-12-06 09:05:59 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.1
> 
>  - initialize core quirks before calling nvme_init_subsystem
>    (Pankaj Raghav)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe


