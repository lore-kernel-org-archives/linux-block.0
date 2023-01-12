Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9988C54EBE
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbjALSKJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 13:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbjALSJk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 13:09:40 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1238275742
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 09:37:57 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id v6so167186ilq.3
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 09:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vzEEFu6ah+pd11aCqEyHz92UyrRsWaxfqGc/IwuLEE=;
        b=6o7irQ9T2sXSzyzIBiTCY3++VoL9Y9edcc0yFyN2FOC2D6vQGDB4D6UEj7mc9wPWX6
         xdv5zFf2rxIwun+M6tYIDhDVMgzGpezvUm+x0Q+nYvpQ+ph06HajgJ5B9gWyJk4Uitjv
         DBtaKqHmu+cFxKa9Q1lK1HmuA1ZtZ5ZMajDkTvfvKN+M3i/oAEAwCIPvEAg7m5d9XSW9
         QCzQQpr0xn33VvO+Gdv+ie4OrCsTtJ9ZnI8ADoCuvQOOrIKTkBw/fAYiMGbaP8Ghq8AJ
         GQpjPB7KyGrtpQjny8F37HBghN42+N4hI8OSviWybU9px0n63NuHPyMW5r/epDrmZL3U
         h9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vzEEFu6ah+pd11aCqEyHz92UyrRsWaxfqGc/IwuLEE=;
        b=D+dsfK780Z5c/bCM0YiwXEdqfdRhuENHsPiEuRKf1qshwEY8sbsBR4TJBhM2CRK06J
         haKU3iNCblZi8ll+M4vnsy8W3nJM5GGYu1OIfqQdDP96PPtbSKZKPAuIbyijXRVW8+pE
         t1yKgzcgIk6lzFvoYjEiog5jBXYEOvnS7gtSG2T4CJytyhHcxA24zTkaWeZZtlSxSmC9
         z1xv5ke4px/YBISu6BaSUNFuuJEmTdHqsLc1BMJ/zXG3B6G00VoSbV7n8wTzHcY/uv4q
         OF2WYeh0ixak3o5Ci/GMwJrCqKkv4h/S7mkvOHImRSSQqCPP3Ukxh94+AfUZiDaAuRVp
         d4Pw==
X-Gm-Message-State: AFqh2ko/ufzp2gT4/ISm6QXu1SLYw2YZf3Zb4iVy2m8e9azczI4nGVdl
        KEIh038vUsHj57Ehb0QHp1QEIg==
X-Google-Smtp-Source: AMrXdXuy91qcTH6QYEYlYY9Ke3oRmT3uQRx3pJ0m38xplz5S8q6hZMQDkxASWGkAjQbFNUjsE/B6EA==
X-Received: by 2002:a05:6e02:20e7:b0:30d:9eea:e51 with SMTP id q7-20020a056e0220e700b0030d9eea0e51mr4063359ilv.1.1673545076251;
        Thu, 12 Jan 2023 09:37:56 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o192-20020a0222c9000000b0039e92d559a3sm2969186jao.166.2023.01.12.09.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 09:37:55 -0800 (PST)
Message-ID: <76dc39b2-2f46-6cd8-9894-b069ffed2a1d@kernel.dk>
Date:   Thu, 12 Jan 2023 10:37:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y7/D64Qubtqmdv04@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y7/D64Qubtqmdv04@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/12/23 1:25 AM, Christoph Hellwig wrote:
> The following changes since commit 49e4d04f0486117ac57a97890eb1db6d52bf82b3:
> 
>   block: Drop spurious might_sleep() from blk_put_queue() (2023-01-08 20:29:28 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-01-12
> 
> for you to fetch changes up to c7c0644ead24c59cc5e0f2ff0ade89b21783614a:
> 
>   MAINTAINERS: stop nvme matching for nvmem files (2023-01-10 08:16:39 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - Identify quirks for Apple controllers (Hector Martin)
>  - fix error handling in nvme_pci_enable (Tong Zhang)
>  - refuse unprivileged passthrough on partitions (Christoph Hellwig)
>  - fix MAINTAINERS to not match nvmem subsystem headers (Russell King)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe


