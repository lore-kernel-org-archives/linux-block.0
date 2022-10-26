Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BBCC38A2D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiJZM6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiJZM6y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:58:54 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A6FF708D
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:58:47 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id r6-20020a1c4406000000b003cf4d389c41so463230wma.3
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=b4Lhd5ZJEZFY/1mLafdq9ylqV2+BpamYlIuiUCTOsGOQ2Wc5fTBoteEHeqH3AZd6rk
         YydQplbxRlmZkGIXUvXeJqbq3WmsvpGEpp8sWll+rDhfFz57H/56a4CML2Z0g75QoQ6e
         YBlAtj5Yd5ZlwUXxyVricrEX5/MCK89INPbPcZyLWsK5q2eg/2hMhgzBd944enqN+YrI
         vzUkfpILrc4/TaI1K1MTrIPinhoaDrzW43rZ8dVLKKU+pCZBKQjaKgFPm3FOuY4jmIzp
         gfgbS23q68tVpycdVGcme2KeZwMim1iTZRy22ZnV2Ry+72AAKXh22ggL6SyW6mCH2sq4
         7GwQ==
X-Gm-Message-State: ACrzQf0WPaRb1owLjO+mPyxuA494enL1EPtu7DCsbOE8JGHYOfcRpcou
        CVR3NzO9nmT6L1CcrfuQhEI=
X-Google-Smtp-Source: AMsMyM5vTwNXD2B3fsKTpl+TMNn+mB3Xpe4zOea8a8MY9E3qVzdVXi9FabT62QrQg3zPFcNHrojVig==
X-Received: by 2002:a05:600c:538b:b0:3c6:b66d:4027 with SMTP id hg11-20020a05600c538b00b003c6b66d4027mr2289881wmb.146.1666789126359;
        Wed, 26 Oct 2022 05:58:46 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d58d0000000b0023662d97130sm5150608wrf.20.2022.10.26.05.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:58:45 -0700 (PDT)
Message-ID: <5d8a1201-554c-0273-351e-c9fb7e32509b@grimberg.me>
Date:   Wed, 26 Oct 2022 15:58:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 12/17] nvme-pci: don't unquiesce the I/O queues in
 apple_nvme_reset_work
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-13-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
