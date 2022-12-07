Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B998EC352A1
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 19:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLGTkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 14:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGTkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 14:40:33 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD5D2A240
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 11:40:32 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z18so2262931ils.3
        for <linux-block@vger.kernel.org>; Wed, 07 Dec 2022 11:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zFLoHLb1Dak8B2hEAlRd1msRP6Th/qVOfnIe/tfsAo=;
        b=0h5EajkaNDlkepqaplu4kd0DtQzDvNutIS/6I16Gs3Zqe2qFPpJg5r8fE5qef74UvW
         5r1DUd+RkRH/lRKg5IZ8bKETHSCStUT+OPQ15WNbQIhVGhjqEXe2awUqT/oAQfPAtYot
         ENTaSeq8aS9iwgoxyK7bNtIIc0rCLrxiLmXhgcQgzPG92rsSASg4ijiMDfLRZLNmRA6O
         ATQ3BhoIbANJ1T1Ac1xbh15uUVIQduvneERofvvUCvg4BBPUpqC9EmwBf1ZYQ0Thv06W
         3P773wJ5V5gFlkcqqepB5pJuC3qrYWiJh9VFITMecmwXPA64lPruxuQDBo7e/4HBHcSF
         1OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zFLoHLb1Dak8B2hEAlRd1msRP6Th/qVOfnIe/tfsAo=;
        b=BBBROrg99NHNDgdwmr4VH3hNZIVa+P2NbepKZmKEkOWJD8fcv1aPtVWbCi8oPXGMcs
         ODLDJt5uOwl8FWc5C503xR3u0Sg+qUfWnfKoSEDl0aSigWyRXT6QUk/doY+Z7iaGnCzP
         utcd20KOCOOQg2h5aC3mEb8IOMeQ0L7kEYTkyvEf7xkfM7+AxZRsuGVs12zIs6is2Y5V
         7LlcGN/PiVyaU1xO8L1um4eHRjnLg5c4nItfL6ZlIqRoWzz5j+JJfpQIs+EM5HHHJHW1
         C2aPXQQaNEf3OMYMVJllzsMKZeG4nFfhUIkBxkfjuYkGPKQiRM3ei8FiPJ9lFk00Tudm
         /6tA==
X-Gm-Message-State: ANoB5pm/IhIACO4ikZrm7NwA7NuTptMHF2VOxgTjBQ1FCp5/Gw5Nnx/V
        rqYjj20pm0egKvJZ551yLRJBXg==
X-Google-Smtp-Source: AA0mqf6Jz5PYh1LkEVLw9teBsWBYb8QL6Bw523dDiFXvPgFWqFFhFCmOenpWa4gWj+hTE0+OnXDX9A==
X-Received: by 2002:a92:870e:0:b0:2fa:f47:d960 with SMTP id m14-20020a92870e000000b002fa0f47d960mr33450223ild.19.1670442031401;
        Wed, 07 Dec 2022 11:40:31 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d9-20020a026049000000b00375e136bf95sm7952621jaf.127.2022.12.07.11.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 11:40:30 -0800 (PST)
Message-ID: <3747bc85-967c-fd5a-66e5-7cad42d00bcd@kernel.dk>
Date:   Wed, 7 Dec 2022 12:40:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] nvme updates for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y5DbMySCBMWI7CbE@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y5DbMySCBMWI7CbE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/22 11:28 AM, Christoph Hellwig wrote:
> The following changes since commit eea3e8b74aa1648fc96b739458d067a6e498c302:
> 
>   blk-throttle: Use more suitable time_after check for update of slice_start (2022-12-05 13:45:31 -0700)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-6.2-2022-12-07

I pulled:

git://git.infradead.org/nvme tags/nvme-6.2-2022-12-07

-- 
Jens Axboe


