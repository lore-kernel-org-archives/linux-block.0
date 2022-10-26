Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C04C433FE
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiJZMkv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiJZMkV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:40:21 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881807CA9F
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:40:00 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5so2324529wmo.1
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=q5IvpM/yQeEl4yYS0K8b0mBf5PoYF64Ba+y55cfDoQRYoq1HIQN8Q5caI5L8FOt5SB
         1GRRMp9CWs4Gj3HNGewkaYac4awDdzEFwPk8ysn/HuistbHelvNMD205CKOZD9KKTkkS
         R4WrVGJ/Iw7Mc11Qr5q87ha5zpkNitN7MMrzr0Zds+5KKMPtnqsPyhXHmsqRKm4lRu3w
         Omq0tcRJ9cr/DY/RPZDdc4da+roES0G7qxUXK1hPoYdikT8imgS8tUew/Uj1dEJetTjT
         2/cADPSiG68PNyTBJ7/HlfhCtdftpl3c29tMYPmLZgMpG5SyBbYrOiT1y290Oxntaeag
         GYEw==
X-Gm-Message-State: ACrzQf1UDYzlG/LYsliverR1mmpAouHasLULIMkP4EkeeE0C+3+ZWJzY
        jl+yeZOXbK0fxbrfNX+RIPI=
X-Google-Smtp-Source: AMsMyM7rqOmWZX3SBMgIJK4VT+DcXle31VeUtHi0/7xyK+NzupYdd2xmp82KQS3XFa0kS1Bh/glsEA==
X-Received: by 2002:a7b:c5d6:0:b0:3c6:f970:e755 with SMTP id n22-20020a7bc5d6000000b003c6f970e755mr2307678wmk.132.1666787999091;
        Wed, 26 Oct 2022 05:39:59 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a2-20020a056000050200b0023662245d3csm5250657wrf.95.2022.10.26.05.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:39:58 -0700 (PDT)
Message-ID: <8945ffa7-607c-e791-5ec0-3648628bc595@grimberg.me>
Date:   Wed, 26 Oct 2022 15:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 01/17] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-2-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
