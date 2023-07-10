Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25196EB64DC
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 09:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjGJJdM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 05:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjGJJcL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 05:32:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CAC1715
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:30:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso9014175e9.0
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981370; x=1691573370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TUJ0McwBWfefuisHs1dJUs2fOEeDEmLCOetq4CUSnjkjzKsqJnxYNquP5R61GzHJtf
         JzJr/ly0EygI6c+o9HVAoO7CxQnPuqerdb8TlPif3tnuQLRiwfAV5EGckXZCLA40Nv4S
         +eKw43l/btEOy2x3tYdb8AOY3pKSTJ3qU8VsxjFVBvPvsxtT/yGzmgbVnTt2Kzqoi16K
         eC8NJu8thrrDZBcwCO8lMybfSJtX17Pc3oXJgwRpv22aXle4SPn9aqG2+9oZ05aQ9qTy
         lL19W0vROQKRxC1JdiELG/LlLcc0nP34jxqsmjdWk2rpvqWBmxCJjoto/lRbo18TDFW6
         aC+g==
X-Gm-Message-State: ABy/qLYK9KkzAU/apLUyIccvlX+89MrXd+ngsYt3UYy/mhdr2gIoHI1p
        k4cmTQeCFZU0+x7Fru2uG+E=
X-Google-Smtp-Source: APBJJlEICPLIIB8HPjX1V78fyHKqZt4Ymy34m8iOn29c0ojF0TgRk/U76vBiUo6Dp3FY9lpoacB2cw==
X-Received: by 2002:a05:600c:4709:b0:3f6:8a3:8e59 with SMTP id v9-20020a05600c470900b003f608a38e59mr12498101wmo.1.1688981369684;
        Mon, 10 Jul 2023 02:29:29 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c230b00b003fbaade0735sm9724982wmo.19.2023.07.10.02.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:29:29 -0700 (PDT)
Message-ID: <5f6ea693-d4b7-8117-9151-3666ea86e59f@grimberg.me>
Date:   Mon, 10 Jul 2023 12:29:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707094616.108430-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
