Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCC8C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 09:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiFZJZn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiFZJZm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 05:25:42 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9210561
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 02:25:41 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id n1so8912569wrg.12
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 02:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bgwMBZ/44kBvyjk/DCghNGQCqRJPEOibUDJ8MtpWeJRYyzkfftvYM05HL7ZbIKB/sm
         LLbli2w8dSNHXuouuXyEMG3wpgI3Ar+WLYdcXwaRYCMqASvaRYvJPRWuk4dh/lprh9Pu
         hXkx++tbTKyY2b3/dPm3JHkvMP72suUhvZmrpdy79/pSPtT2FqX3+BbXfau0K7XX6/6d
         MzmkRXnvKKAeFKt+nYcA7Sb+d7zyMdT0kjmpArDULuFVHXgNlJFYf3jCSUt82+8Gmnf8
         212Lxe7kQ5NjiTCJzSAe17GmCPlwj3AEPbbelaDnS6DZyH2zikRok90mx3mQjsBZJqW6
         Rgdg==
X-Gm-Message-State: AJIora+vTDimbIRfxYAsvWPKeVCis4+B5UkPygG/rHrJpdK2JIk8R4EB
        ZL2NMcJApuiEzyP+7kGhK6hB5thY9L0=
X-Google-Smtp-Source: AGRyM1uGFNEchvlYrTrQBosl7nAPe8vBD3iEubsuvUdD8kF9EH9rzYchcBES59v/EgfWV1aHuiqnlg==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr7294075wrr.2.1656235540006;
        Sun, 26 Jun 2022 02:25:40 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c3b8200b0039c4ba160absm1475875wms.2.2022.06.26.02.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 02:25:39 -0700 (PDT)
Message-ID: <331952f6-eeb1-94ef-120e-d954f228b88a@grimberg.me>
Date:   Sun, 26 Jun 2022 12:25:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 27/51] nvme/host: Use the enum req_op and blk_opf_t types
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-28-bvanassche@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220623180528.3595304-28-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
