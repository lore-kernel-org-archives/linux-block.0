Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B4BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 10:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25297610C8
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 10:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhJMKsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 06:48:00 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33596 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhJMKr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 06:47:59 -0400
Received: by mail-wr1-f46.google.com with SMTP id m22so6995766wrb.0;
        Wed, 13 Oct 2021 03:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VW45l1InU/0hgcRaSQIqYWKRP/V+IvDGrOgCoOFc6SIBbWwLidPJ/aAhOnbgFMBjfr
         aAndq0X6eX16IquV47d7WIct7SALYPH/IiZqsCbTTfVrUYxY9g+acxlP7AuszSAnkIQr
         sCEY5IfRXRAfbt47kCdop9ekl238vLKzUnC6J5ni1JOsrjsttgr78wxOuDZFn8Mx5gBn
         F6kd+bqgq/XMIfEQjU67++8WjWEajCTqgQIjYjqW9Uw8o43PC3UZC+5eOZMyOumkCNzF
         kQPsxxefFSHpzMP2nC51ffwP9OTF9d2RP1Jiqs9OJErIC8DglUoqFWSJ7aUhkgRRmyPO
         Gk/Q==
X-Gm-Message-State: AOAM533esy3YGt5Alin9RjIMpaJaj/WIe/3vedePc6ACVGrT91bUdobV
        0pv8jf1E8kTczZD/Vt78kyw=
X-Google-Smtp-Source: ABdhPJxuCWpusAcRSBUL/YOkPjghlssAoi3ijytswLvfEFC2/EM+Jqn4gCl/ELUOVhnjYe/paL8r6g==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr37769054wrg.23.1634121955635;
        Wed, 13 Oct 2021 03:45:55 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w5sm12858163wrq.86.2021.10.13.03.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 03:45:55 -0700 (PDT)
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dde98ff3-0770-69ad-fce7-8efb0a335416@grimberg.me>
Date:   Wed, 13 Oct 2021 13:45:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-15-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
