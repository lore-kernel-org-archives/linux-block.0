Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA011C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 12:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJTMon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJTMol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 08:44:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF64239100
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 05:44:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c24so20217269plo.3
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SD1SmgBy8yy81OdjQiEz8k7nIalu/meQTVoilBM0ZmE=;
        b=ZGCXAu3f1sz3wGahRpQhqGQc5mdl07tJeVUiHYHWXzJK2WDjCudxEYGUbg3wvU/q70
         +mUFcE4t2zOxVvo351O4rlSq9gEqnOm3r5KBjyA6qoIvzo8Q6V+aL3pcPgT4IQ9EuN0d
         FAx4N0XVSurc6XMZg6Yi3o+svKmHkgT/Y8VaMbitaH4dvSnVdnAKQD4WqU9/nKppm9e6
         8l3nLXJfWzY4GzKq3Gce/p/JbMLqmxuEEtp0ime5KnbzBVAuDy353ipbxSbIcvouLq/5
         gIZjk5UNfqzLgzouxGme+JonP68Y6uHFb67ZEHWBphFm6BWFp/HkDEIgODe/WKCQM2ty
         yRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SD1SmgBy8yy81OdjQiEz8k7nIalu/meQTVoilBM0ZmE=;
        b=SCCsQgiGz+ShVxe08UdjpboiBgU5PxM54TYZz3c42qTSJQvyKYFATlnhNZeCjCH3Rk
         6PvbagBH0jnmOZnmNkJYgH899tbzVIhVqeiGyCe+oOVzHuiFAOoTTJbYPu76JL/+ShSE
         Hx7Pz0tYYcKvGoiGJXl6Xp40Zx2jeaf4SU2nomTu9LnHbUEyMFXV23iHDjX2UA61tcKt
         Bv8u9nrfTJQyqLZyjH8VQsDhpEDicYUrmhacuA2OAmt1lJbg/XuEZgq23jIXuC7CUODM
         DYnsn5HJEuPdw29Hmw1ZR12ZfIY5LHyrfUUyvByd5daGSLdFoujnjZY+XwmD03wS0H4z
         6EYQ==
X-Gm-Message-State: ACrzQf3ctpfYQw2UaspJp+TMp7JMr0KzBuVWLADbvlJsygl7PFSdLllQ
        80ihRq2oBlVoheAmcjIw3wT1lA==
X-Google-Smtp-Source: AMsMyM5Cr4DfPUctp2wz7vrf1Tij5yVA1d/FPQfZuTli2Oz5HcpDtR4Ep8Q/FKjYhaV9Wv+uOUSEpw==
X-Received: by 2002:a17:90a:bd87:b0:20b:1cb4:2c92 with SMTP id z7-20020a17090abd8700b0020b1cb42c92mr16264857pjr.210.1666269879296;
        Thu, 20 Oct 2022 05:44:39 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b00179f370dbfasm12907953plg.26.2022.10.20.05.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:44:38 -0700 (PDT)
Message-ID: <3c07d444-7863-a658-8b7b-755654d390d3@kernel.dk>
Date:   Thu, 20 Oct 2022 05:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <Y1ENi1X5gi7yU9VS@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y1ENi1X5gi7yU9VS@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 1:57 AM, Christoph Hellwig wrote:
> The following changes since commit e0539ae012ba5d618eb19665ff990b87b960c643:
> 
>   Documentation: document ublk user recovery feature (2022-10-18 05:12:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-22

Pulled, thanks.

-- 
Jens Axboe


