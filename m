Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A585DC64ED6
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 14:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCAOux (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCAOuu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 09:50:50 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C73A842
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 06:50:48 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i4so8458318ils.1
        for <linux-block@vger.kernel.org>; Wed, 01 Mar 2023 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677682248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJFIlarrjVJwPJRCl6YvPmLvQz3xc4je2RmrHpaRSCA=;
        b=GHZw0khq3kSQ6YlQej6S98YxeK5PeU76sYzkcSpn6eMLiiCO9bBj1zpI37GiGZ5lan
         FMsJERkETKo8m+7P59NIyyD2ECRFULsr086vEApkQuFJoqLzu9fFzETwJswIwuWx8Gsu
         r3kSCMaFKv9qkCJIHJVzSpRZ/WaK3mCACQv+zM9TlpfoCttQIG2RUi4pgFYxuUmGNnCM
         +OawypJMQ7vFTaSYDf4eevAi9pxrrHHMHzEsxpi5gSTWGnNMDkbqZETGtP1pzVT55bPD
         Xb8POw2T5Vo5JufIYPy60k7se/QBcFUckCQETdA3M596jDQ45eNN6hZ0EMH/AozOeaXi
         gWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677682248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJFIlarrjVJwPJRCl6YvPmLvQz3xc4je2RmrHpaRSCA=;
        b=fC6wtopyP6zMFIeLe77F2tiQYRPeCFFOcKw9ah2j3IqojLUuuQPC/d7qhbvtpC+EuK
         ldoyhjZbrRJdTdLBl0Zhs6ueHhYjARfVzyccNk1xnjU0S5jB1xFm6GVrhMp7BwRFSsJA
         NX56mocv3U4OaY3oci8nobVmU8cY8slqilnCklivy9M9dsg+JK11cd5ZIgAkQrxDMuoj
         k1H9BJPpBw9zkENZ9cjvTHTMwPNfNSd3jK/FPiso1U/U0ZW0vEwU/SEZlS3HYbIggum4
         DS5puZq5eWevtIGqwhJtjuIkok+7ki0XCqyq4n4gy/9Hrya3/LOiEQ0aw7EMD2XcIc4S
         pHkA==
X-Gm-Message-State: AO0yUKUiWgJqe12WpHxPVvyGSruqHrN9TxaeGygEQ3dsfKvowotaLhaE
        w+KzRImZF8pIDw1obbZ9qHCELA==
X-Google-Smtp-Source: AK7set9EltZZrojlAUGifnFi1l+Q38lmH9doSBfrFMr+bO6GkySqbALWbVM7F64wsrr8qZxRjb4CQw==
X-Received: by 2002:a05:6e02:1a04:b0:317:33fe:7d59 with SMTP id s4-20020a056e021a0400b0031733fe7d59mr5131341ild.2.1677682247932;
        Wed, 01 Mar 2023 06:50:47 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u12-20020a92d1cc000000b00313f1b861b7sm3612802ilg.51.2023.03.01.06.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:50:47 -0800 (PST)
Message-ID: <65c8524f-e21c-04e4-c56f-8bb24eca9cb0@kernel.dk>
Date:   Wed, 1 Mar 2023 07:50:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [GIT PULL] nvme fix for Linux 6.3
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y/9Xn595ioya85dO@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y/9Xn595ioya85dO@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/1/23 6:48 AM, Christoph Hellwig wrote:
> The following changes since commit 310726c33ad76cebdee312dbfafc12c1b44bf977:
> 
>   block: be a bit more careful in checking for NULL bdev while polling (2023-02-24 13:19:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2022-03-01
> 
> for you to fetch changes up to 26a57cb35548ae67c14871cccbf50da3edb01ea4:
> 
>   nvme-fabrics: show well known discovery name (2023-02-28 06:14:44 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - don't access released socket during error recovery (Akinobu Mita)
>  - bring back auto-removal of deleted namespaces during sequential scan
>    (Christoph Hellwig)
>  - fix an error code in nvme_auth_process_dhchap_challenge
>    (Dan Carpenter)
>  - show well known discovery name (Daniel Wagner)
>  - add a missing endianess conversion in effects masking (Keith Busch)

Pulled, thanks.

-- 
Jens Axboe


