Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39FCC54EBE
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 17:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjALRyw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 12:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbjALRyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 12:54:21 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F2775D18
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 09:14:57 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id g23so5279305plq.12
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 09:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xodou0l4BaDnnpBfVnK1ZD7KmHNFP+cawJfYdg7Sq9k=;
        b=D4INT/JNOgTBbwg+pQdYixd14mbiJuzIZKX2/BADBW/9RCCTxB5xTdbE+hYDvjlOMn
         gfx1++uo75pcKaeX+B9PyEaRLCrBpoNVZsXAZRdQuA6JLsjWg2vA1ZwqGFQzyY5gQPqT
         bF3Dv1EeWQNBIlQmXKZ4UkV8VdozgsqnFkgpbxx9vyspWcIEQb+Qwd2NZp1w8ZW0HH65
         XTJKpeF24wlduCyEiDOtQwO9TL8moVUoospjxd0yrOPnQJsvoeXYV67BKqS7GqfRXGyx
         BRmZKXFfYiSERQ3HTmDkGOOx7atetsUazM59y1vMsSbuAhyP/b2kmMi2OqmCjU6BuZTk
         CubQ==
X-Gm-Message-State: AFqh2kqNUnt6dCwNgkE1u9eqQLt4w/XWLuvLK016K9i9SNzJlAQQqiho
        eN0ngbclZ1tobzvTLrwAAL4=
X-Google-Smtp-Source: AMrXdXu1T6TtiWxdui0JTEYYQiVYrf+UhwqQFOxRLuIMlT63emy0C4S+sP9uXpGS2+v61jy8xEG3Ew==
X-Received: by 2002:a05:6a20:8362:b0:ac:7a44:db55 with SMTP id z34-20020a056a20836200b000ac7a44db55mr75570934pzc.39.1673543696606;
        Thu, 12 Jan 2023 09:14:56 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:3345:7bfe:9541:882b? ([2620:15c:211:201:3345:7bfe:9541:882b])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b001930b189b32sm5680480pli.189.2023.01.12.09.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 09:14:55 -0800 (PST)
Message-ID: <ccc8bedc-1ca0-5da5-289d-330d7a494360@acm.org>
Date:   Thu, 12 Jan 2023 09:14:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/3] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        gost.dev@samsung.com, snitzer@kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20230110143635.77300-1-p.raghav@samsung.com>
 <CGME20230110143638eucas1p1551ada551876f82df671162860f08d7d@eucas1p1.samsung.com>
 <20230110143635.77300-3-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230110143635.77300-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 06:36, Pankaj Raghav wrote:
> Instead of open coding to check for zone start, add a helper to improve
> readability and store the logic in one place.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

