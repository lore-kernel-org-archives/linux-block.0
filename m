Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED0AC77B7C
	for <linux-block@archiver.kernel.org>; Wed, 31 May 2023 09:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjEaJkM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 May 2023 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjEaJkL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 05:40:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC3C0
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 02:40:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so5555286f8f.0
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685526008; x=1688118008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrOxajovW5T4Rbc75jHs3zSIJj4eFv63SxzUYy8QEwU=;
        b=qUlVbwtJBWmIyaMOTjCP/Jml9WD6DnDXO4a8G5HdiF/aIRwSGT9KLO1PItVeboq7RW
         4se6h/UfuCnFxfNORMrQMgwKI56A2x/tV4LZ9HZQlos09T8x2x2GollQ8kkZsooJZS6Z
         JERGkcC87yHxF8AmnB2ONMaEXiBuKcMvi6Gh5MP8HfCFtFXuV49G+xaRg0GmyLsoZc0K
         QycT3N4DLTpkhqnuFESrGpxBiePWXdvPjnBgZ1njZslPsHu7ZJ1QFZstxHFLyc1/ZP4O
         GqoG+M/mM5pqDG8rNHzMit31d4DUyLje7OENUzOaQjra61WtsRZWt6e01Z51ugTx6S/q
         Koaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526008; x=1688118008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrOxajovW5T4Rbc75jHs3zSIJj4eFv63SxzUYy8QEwU=;
        b=Hw3L3W0KeGicXBc52kypJyN3XHHTbHaxcC833pxXZfNYBBtEpSmuFJ79ls1OcoPG77
         OvgqIcAoLEuHkVy5zniqdKKfkSe8zZ0h+LMLDS9Wj0SUZxFcrwm/FKsVxKpoyBYBpCVq
         8znPNhY2M+RWNCqULdnDY689T8zH/t8aNXHO53qmHwE9KxgDcUsZbXtZM7nRJyL2fPZf
         OcIl5Vl5WnuqYaH+2f6pw9Qi5L08erLpSoqc5uH23xmJsVliiHeQgVXUBIzAynNlNQCO
         u6KWh9D9LCwkgheIT/DHJ3u/sKlbJRo05AvBlOyFoK0r2zfrlzHLQxIyeA2p03/L52xu
         HOvg==
X-Gm-Message-State: AC+VfDys/kARQFSimR5luw8IUy8TNj4hXRtScaDL9cZp8tLRIZDwyed+
        PJY0mO2kZMp489EjmXKwDYy1ZA==
X-Google-Smtp-Source: ACHHUZ7QLmP32Ur33JMLykY91ywIOn9nnqyILXvyiJhEBzynYD4c3RWkXh/LJXNTMuCZPlJB3qhBvg==
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id x18-20020adfdd92000000b0030ab46aa443mr3268355wrl.51.1685526008093;
        Wed, 31 May 2023 02:40:08 -0700 (PDT)
Received: from [10.1.3.59] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b0030632833e74sm6170228wrs.11.2023.05.31.02.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 02:40:07 -0700 (PDT)
Message-ID: <af5df07e-f93f-9588-4fdb-b89b37aa28a1@baylibre.com>
Date:   Wed, 31 May 2023 11:40:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] blk-mq: check on cpu id when there is only one ctx
 mapping
Content-Language: en-US
To:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk
Cc:     kbusch@kernel.org, liusong@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        peter.wang@mediatek.com, stanley.chu@mediatek.com,
        powen.kao@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com
References: <20230531083828.8009-1-ed.tsai@mediatek.com>
 <20230531083828.8009-2-ed.tsai@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230531083828.8009-2-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 31/05/2023 10:38, Ed Tsai wrote:
> commit f168420 ("blk-mq: don't redirect completion for hctx withs only
> one ctx mapping") When nvme applies a 1:1 mapping of hctx and ctx, there
> will be no remote request.
> 
> But for ufs, the submission and completion queues could be asymmetric.
> (e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
> ctx won't complete request on the submission cpu. In this situation,
> this nr_ctx check could violate the QUEUE_FLAG_SAME_FORCE, as a result,
> check on cpu id when there is only one ctx mapping.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

