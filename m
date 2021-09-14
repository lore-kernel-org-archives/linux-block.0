Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D20610A6
	for <linux-block@archiver.kernel.org>; Tue, 14 Sep 2021 07:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbhINHU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:20:58 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41720 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhINHU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 03:20:57 -0400
Received: by mail-wr1-f44.google.com with SMTP id w29so17758679wra.8
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 00:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=dZ44BHZct1Lo8kn+NaqU2RIadaSU4Gc1d0UEwmNARqHkWytXspOf/a6Dye/6k3io/B
         XeNMSoEzzxszcVs0f/mx9nlyIAF6Gb/Rwg4HkA8e8zUJQILdAPCwa6bHlNFHKfWqRJUP
         Xbf0oPlvuteA1BQOAjsDP0y2u9AGFcrbvfP/1dTFNwN0m/42dXU/vvzfBAL22bi3J1Rr
         OYeeBqxN3MMgwTRAl5K3iK2oxf84sCHxb1aDwnYg39ywuD/nvNB+s4mz5nscrJeCpumy
         GWCQP9tgPnq3ZmpPEOrtA8kTXQ26+f5FD1Mob+DrZEGMT30SMlhn2p8VKOnb+9GRNXRN
         J7kQ==
X-Gm-Message-State: AOAM531Hxz/lkoVCabSXkjr49jNuncE3BJ6iZ5BkDvRunzaFTolop6Yl
        45jx2obDphAcwbZxxifr7DRPUYokEr8=
X-Google-Smtp-Source: ABdhPJy9z6CpITP67ev5Ol8EfatoT8ipd25xq3VsulzVTvvzDTCzJ1JtAavl6Y6hJgM8XBImgbNQUQ==
X-Received: by 2002:adf:b748:: with SMTP id n8mr17074321wre.133.1631603979895;
        Tue, 14 Sep 2021 00:19:39 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k17sm9500325wrq.7.2021.09.14.00.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:19:39 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: remove the call to nvme_update_disk_info in
 nvme_ns_remove
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com
Cc:     Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210914070657.87677-1-hch@lst.de>
 <20210914070657.87677-4-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dbb48ddd-dc90-782f-c129-275ad2f96ebf@grimberg.me>
Date:   Tue, 14 Sep 2021 10:19:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914070657.87677-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
