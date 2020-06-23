Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67592C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 08:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45ABB20720
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 08:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgFWIoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:44:23 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52143 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgFWIoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 04:44:23 -0400
Received: by mail-wm1-f47.google.com with SMTP id 22so1318709wmg.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 01:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ZAjPxJtQQBFykxB0BgwPO3kNWIBgssqt+KGeLEe4BRvaJpWyno5arTqWYSuCPnpqw5
         UebqeiiwqMJCH7KeDL004SEvewsQgQBs6+BHiqxJlFt+8c7O9dpwRKOoKOndTGatQDzy
         r6r4se9ZAFvI0phL0fNhvzogjs00Xj/Ezewex/aQuLBfmT/Vd9ojcYEAHdkP6q/Fv0mD
         lOaUO/htGkIsvvh/xNDajDQmc/wDyNSw9yO1L4hZjuVMRwXl97sQ9prwnITKsQAVbOnd
         9gLvDFSlnTQPXNxeuUaPndZvidFvUwELctSZ9rJtu5vVZGZWqUQcyjaCiaeuDr5M5dUf
         +atQ==
X-Gm-Message-State: AOAM5323MuVVWOcW2DynhWIno9jf+z8MiMGhFRwaUtxy+UfdQCGUiYis
        b5SBVYTNBPLDA9zfsqIzzgw=
X-Google-Smtp-Source: ABdhPJz5uBmybXZvsjR1XbzhCKgIjhl6R39axhBOAfYh6wLH2qPsoRZon3q3zpmRLb02MQ0bns6sRA==
X-Received: by 2002:a1c:4343:: with SMTP id q64mr11388172wma.20.1592901860798;
        Tue, 23 Jun 2020 01:44:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8927:798c:48dc:eaa9? ([2601:647:4802:9070:8927:798c:48dc:eaa9])
        by smtp.gmail.com with ESMTPSA id 11sm2803012wmg.41.2020.06.23.01.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 01:44:20 -0700 (PDT)
Subject: Re: [PATCHv3 1/5] block: add capacity field to zone descriptors
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-2-kbusch@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <28be49cc-a930-bac1-0432-9c29454d7692@grimberg.me>
Date:   Tue, 23 Jun 2020 01:44:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-2-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
