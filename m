Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05139C4321E
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 13:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiK2N4K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiK2N4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 08:56:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A94553EF9
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 05:56:07 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w79so13773103pfc.2
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 05:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScAb/G98utGY/Ri5BRIKKvQo6kiX6XyD6LkBEbj7PMw=;
        b=glLiVxZ+ODnLngOEu3a8LfcfPb8IcvT3sKH15iWaap7xKRd/1pewlm6GFUrKy0I/BL
         BSnYsEpq/y9qjrKO9XTsBczR1V+gJ9VAauMUeUzHNM/xxNJRg3YGXUmlGy00SbRVoSg7
         fgsFFKEuc2uynCF/RuLN6PMzTK8wIPD9X1x2KrcrhLdbrXIi73Y86Vw+fjRiCRzEGsFw
         km0wQdzGkhEdgkYbZKIvDmZ4aMKELq6ScsIK+F+wywnTn9WDd91TUFSrGwGpbo1FjVD+
         TmfycIEU9KWSGNLz197UP04lZpqnrVAHEKHsDfPp/3itc+shfH0c/HueYUpVwoqgnaxN
         FrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScAb/G98utGY/Ri5BRIKKvQo6kiX6XyD6LkBEbj7PMw=;
        b=1b6JQJinQ09qQJbG+UgRGn1Ayn/rQl//eC/0rtiJ5NDh15Qfud7QHRo4tLmm/E6/W2
         CoxNrJ0DZuEiLZYPPIP8OIo8hPiN+RZ5fvHumQ5H/5y8NrcoMnuszzc7DiYYgYV6osyl
         N56Az/rOEGe5Xw9qgCzLf+Tb1dFW0EiT1kRZfJJ+WV8ECIDkL/0BPfbqxpmhu29Iolcg
         v5VaDNQhmTK/ePZOFqfUQNP9mmCXbQaumkPhnmS8dSdrFkZ2P0mxX6WruMjh8cQuzFLR
         iHaDeraIDUv+ZihmPJJ5Tbj8ypAKyNnfIs4JvegjVwi13my5q0KWRrAPTfMU7qEUzGBp
         K8kA==
X-Gm-Message-State: ANoB5pm8Klm4uixEmYAsDHZzeQnsoRjJZMJpd0IuD2KABneDwNusjVGU
        Xvo/CNVT2nmuNIswzuByMXb5zA==
X-Google-Smtp-Source: AA0mqf6dwR7YBNnOfHAbN4yoR/g74vSRx8Es33XgfcJh88vjkfCizuYJeROGkh/I/igM5gw3U/wVug==
X-Received: by 2002:a05:6a00:26c8:b0:574:c159:ce3b with SMTP id p8-20020a056a0026c800b00574c159ce3bmr21160653pfw.74.1669730166584;
        Tue, 29 Nov 2022 05:56:06 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x129-20020a628687000000b0056baebf23e7sm10302195pfd.141.2022.11.29.05.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:56:05 -0800 (PST)
Message-ID: <ae390dde-9041-4f0e-337f-410539727272@kernel.dk>
Date:   Tue, 29 Nov 2022 06:56:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [GIT PULL] nvme updates for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y4XJPNP74KmdI8+7@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y4XJPNP74KmdI8+7@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 1:56 AM, Christoph Hellwig wrote:
> This is just the first round, there is quite a bit more in the queue.
> 
> The following changes since commit 5626196a5ae0937368b35c3625c428a2125b0f44:
> 
>   Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.2/block (2022-11-14 12:57:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2022-11-29
> 
> for you to fetch changes up to 68c5444c317208f5a114f671140373f47f0a2cf6:
> 
>   nvmet: expose firmware revision to configfs (2022-11-21 08:35:58 +0100)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.2
> 
>  - support some passthrough commands without CAP_SYS_ADMIN
>    (Kanchan Joshi)
>  - refactor PCIe probing and reset (Christoph Hellwig)
>  - various fabrics authentication fixes and improvements (Sagi Grimberg)
>  - avoid fallback to sequential scan due to transient issues
>    (Uday Shankar)
>  - implement support for the DEAC bit in Write Zeroes (Christoph Hellwig)
>  - allow overriding the IEEE OUI and firmware revision in configfs for
>    nvmet (Aleksandr Miloserdov)
>  - force reconnect when number of queue changes in nvmet (Daniel Wagner)
>  - minor fixes and improvements (Uros Bizjak, Joel Granados,
>    Sagi Grimberg, Christoph Hellwig, Christophe JAILLET)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe


