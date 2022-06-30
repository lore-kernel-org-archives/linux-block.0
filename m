Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E12C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 20:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiF3UQb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiF3UQ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 16:16:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D54443E9
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:16:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 9so370937pgd.7
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9JGRYdL+NhBmDdxP0DtJXAMH0Xw0VEt3PcBHxt+iWhE=;
        b=U4VwhHgWpLYbo1yfhPVQYypekxNNnEGuOM39MrAR9tkg1SltW/yMrcL+tHOb19/5Ld
         U/uBofEPFhpyT5K89997+zTpHQ5hX/fT89PzFr0/T8qk2YraR0QsVV2WyweYsSHzdhjV
         fXPtvlVryE/DgGWZfQPZ3hpc3RzzHwwHzShjd88g5TwXjZqt4w9Ii5J3G3YTOGjXeiuZ
         GQQYLgI1bEe0Y9r7QDshAARZHioszMPiKSttRie9LhXN7bxHAkakbXC6VUoUbACwDt3M
         8D5I36plM/3/cAd6huDtkkvDdPEhMsQv/Qg8JKR3nuW5rXOm2D698SlpKQEXDDAl4CjU
         QYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9JGRYdL+NhBmDdxP0DtJXAMH0Xw0VEt3PcBHxt+iWhE=;
        b=AsQOJ/xoN+SOtt1SVkGtPoyd7Q+4DRHnu73exlkHZHOFMgq2gNLltivz75wjDnj4MI
         9J2/INghvg+axvmS+5eEUDieldfGOTBanUZ8d9NYEdB4noCZp/F08mz8+1OHrBtq/SnK
         amhPN4hRMWoBGRvZk7RJ7rCgpeTls3jGZ9nEYfyssm5zM6HpNezpdJPqnCcCZUkat12L
         PBulpgoGt5UjY5yA1971VVdBJ4mEyJljxMLf3UM7GcblORLqBPQH5Tj6s5jWaevFlRVt
         dQ+sC9pv7qGy9YrkhXyX+bi4tH5jW4fhnVU3VDKmF6yCOKp2ZKpZ9jrS1loOBaXwqPq0
         5fXw==
X-Gm-Message-State: AJIora+t1BB6MGpgRMq+KKQLfh/ILplP4SIcS5Z1xugg6wHJP2x3+9Vf
        bgHlsG9Ly8IYLZvpvRaxfUZbJDhFziZVFw==
X-Google-Smtp-Source: AGRyM1vlDQn9cUzTQTt5cUwURyDkBcN61qK5SuSsmMxNNVX03FweUi2PyEwMtvC53jflfXsY/iBXKA==
X-Received: by 2002:a65:6bd6:0:b0:39d:4f85:9ecf with SMTP id e22-20020a656bd6000000b0039d4f859ecfmr9392530pgw.336.1656620187287;
        Thu, 30 Jun 2022 13:16:27 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y11-20020a63de4b000000b0040c644e82efsm13705811pgi.43.2022.06.30.13.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 13:16:26 -0700 (PDT)
Message-ID: <a0fd82a0-f0fa-c9ec-cd55-b6db6b60f326@kernel.dk>
Date:   Thu, 30 Jun 2022 14:16:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <Yr39dC2Hf2/LtgXq@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yr39dC2Hf2/LtgXq@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/22 1:45 PM, Christoph Hellwig wrote:
> The following changes since commit fbb564a557809466c171b95f8d593a0972450ff2:
> 
>   lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch() (2022-06-25 10:58:55 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-30
> 
> for you to fetch changes up to e1c70d79346356bb1ede3f79436df80917845ab9:
> 
>   nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1 (2022-06-30 08:24:33 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 5.19
> 
>  - more quirks (Lamarque Vieira Souza, Pablo Greco)
>  - fix a fabrics disconnect regression (Ruozhu Li)
>  - fix a nvmet-tcp data_digest calculation regression (Sagi Grimberg)
>  - fix nvme-tcp send failure handling (Sagi Grimberg)
>  - fix a regression with nvmet-loop and passthrough controllers
>    (Alan Adamson)

Pulled, thanks.

-- 
Jens Axboe

