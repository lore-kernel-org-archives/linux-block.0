Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC864C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 08:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FFD20724
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 08:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgFWIqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:46:02 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:50392 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbgFWIqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 04:46:01 -0400
Received: by mail-wm1-f45.google.com with SMTP id l17so2195717wmj.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 01:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gAql2ytndmiwbbO1Vjs4Cy1RuvipqnhUBj8+L8dTKDdZYQZjw4wqb/EPD3iQiWC4nb
         IVtHWQ2omy5liKEHDYVuL7ze4IW4fh/VO9Raalxa/MRNkOLb+CVlI5mcaxbB3+kgYSfq
         s6Zb4gQaxPj6dXxpV8BiTB0akN11kZCLKldO4++AtrWn0PsI94wOacmo6/AqmAm7b0Xg
         eJegEqh3FNZBM8RLwq9TmJGL0Y9kgUQ5qT8TdlMb5CNpmsdp1Bmx8zz6S+AMacTOUMKO
         oIqCQRF/7S4Ehi09r5lgZu+eWto7y2lWEU0vPLoK19b9pQahVUDyt+VFO+CG+cLx7wnX
         kMlw==
X-Gm-Message-State: AOAM532AgY3EyW3qXc3O/Anzpxx7bXUY/kxZsX7vLJ8zTVrHP+AiOQNS
        aub+dCzM5oEYQuMC8jF2PDD9jb3Q
X-Google-Smtp-Source: ABdhPJyNJfs/3/jaj2aCzVTBvNH+O+4+3xXwcEwbFgRFKnRRaXZszobiTB8illGRGAMhwTB8IvpZ7Q==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr22558007wmg.88.1592901960191;
        Tue, 23 Jun 2020 01:46:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8927:798c:48dc:eaa9? ([2601:647:4802:9070:8927:798c:48dc:eaa9])
        by smtp.gmail.com with ESMTPSA id 33sm15220987wri.16.2020.06.23.01.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 01:45:59 -0700 (PDT)
Subject: Re: [PATCHv3 2/5] null_blk: introduce zone capacity for zoned device
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Aravind Ramesh <aravind.ramesh@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-3-kbusch@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fdd93c42-ead4-0365-5d60-fc81068492b0@grimberg.me>
Date:   Tue, 23 Jun 2020 01:45:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-3-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
