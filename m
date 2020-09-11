Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D86EC43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D83522205
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 17:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIKR3z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:29:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56255 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgIKR3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 13:29:52 -0400
Received: by mail-pj1-f67.google.com with SMTP id q4so2036803pjh.5
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 10:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aVIVVhDyL7377dgQv2tmJZmOuhn7zWUqlZOPCZ0N11E=;
        b=mfpINU2GT/oZqp6iH9sGHS7sqqp1caawuj1xZOKYeazKOn3AA/4ItscUnEJVM7bfSW
         WbkjOiw7vZZOPedIW27NqNnc6um75mGaj4v8svMmKrZIFuTy/KrSxPxZpSi+WviPO/3R
         +nw0YIuUv6i1tDDfavMdiXz03kDuo56qYXRiAU0XpR2pkdbpP0zurJ+DHZh/RNvh4QtJ
         s1XtW/g+dvizuwsQHfOIdMx/xq9FS/0Jf/HCVZeCcot+WVOUoNfN1R9LhAcWYkgAekJf
         SsJNQRG8e37IYWbNez1jLZGxzdbVojVIHnLzHohV1Jyj/y7VywsGzzXZzHuD9bM+aXi5
         8acA==
X-Gm-Message-State: AOAM531WNIWJ7u2hFM9hriff3dWnnGYZFFZTlymV/Gy4nFujpDLograh
        yyNrqvqlCpmrHs6K0TaXFVo=
X-Google-Smtp-Source: ABdhPJwWN/oRHNqzQ0rgktkhGO08Iw+dD3PrZwS1Pd5SiSZWRW3eZo0ECqvuX1mm8NGMcsiUbugesQ==
X-Received: by 2002:a17:90a:7481:: with SMTP id p1mr3114935pjk.33.1599845391149;
        Fri, 11 Sep 2020 10:29:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4428:73d8:a159:7fcc? ([2601:647:4802:9070:4428:73d8:a159:7fcc])
        by smtp.gmail.com with ESMTPSA id gj16sm2408568pjb.13.2020.09.11.10.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:29:50 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
Date:   Fri, 11 Sep 2020 10:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.

Tested some reset storms and target restarts during traffic with
nvme-tcp.

Seems that no apparent breakage.

So:

Tested-by: Sagi Grimberg <sagi@grimberg.me>
