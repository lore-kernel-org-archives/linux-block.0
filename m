Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3304DC25B08
	for <linux-block@archiver.kernel.org>; Wed, 17 Aug 2022 10:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiHQKcC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 06:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiHQKcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 06:32:02 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5207379A74
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 03:32:01 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so1564356wmk.1
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 03:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=5r24GNrIg2yIQUrwarpvbccB2d84d4m/XO9IavCxkR7UqI6+6d9TGHW3/pUGWOfSFx
         zxK0nGjSOJmH1yREjV8RYVeV8n3Yf1IBJn6c4YRVlqIeH6+BVRIgrFaFAKOW9XfcgPxQ
         PEJUkAeKtZDBKt84+DSJfsOFm5VjdfesKk5zUhnXwzqNLEKlX86R/aCs/54z7Xg7pg7p
         uotPrrM2r+3xh+Rbobniw6jNxQFcaW0aw/DRGiSyFLjWrfEnG5my/8ParPnoj4OTt9jR
         Vr79mrd/b8zXU5ICOSFuW+TfmhuKssFhs9u4VYBYWXnwa2k8z5dWjCiLcDsjZIKiU12t
         T3fA==
X-Gm-Message-State: ACgBeo3GANbxcH6kFCpzoVEJ1rUUlyT2cqKGo2Jk6502GpSiXOjWcteI
        TZd1X3kwswsR6fo4b/P0GG0=
X-Google-Smtp-Source: AA6agR72yoMkjSFw5iwKx63+DUx5P/vKsgSqBuPrBVBpiznMXtPMZrwCzdpoNHgL7sLGUapL03qisQ==
X-Received: by 2002:a05:600c:5102:b0:3a5:a46d:5d4b with SMTP id o2-20020a05600c510200b003a5a46d5d4bmr1818926wms.68.1660732319939;
        Wed, 17 Aug 2022 03:31:59 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b003a5f54e3bbbsm1994824wmq.38.2022.08.17.03.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 03:31:59 -0700 (PDT)
Message-ID: <69dcf8c1-814d-7f76-853f-aaa6c924c09a@grimberg.me>
Date:   Wed, 17 Aug 2022 13:31:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] block: Change the return type of
 blk_mq_map_queues() into void
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        James Smart <james.smart@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Don Brace <don.brace@microchip.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20220815170043.19489-1-bvanassche@acm.org>
 <20220815170043.19489-3-bvanassche@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220815170043.19489-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
