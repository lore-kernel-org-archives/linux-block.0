Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B93C433E1
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4F320774
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgHNGEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:04:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54669 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgHNGEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:04:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id d190so6505559wmd.4;
        Thu, 13 Aug 2020 23:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vPALidMW+fF/GY55nQjLH9o8dJ+J86ReCVm/X6/kzsY=;
        b=CaFaXxQ90asjOIOAWID1M/3mYB//WZE6TXWZS2IVXOnXj6vsl6+yFjKmLukzZe1KPz
         gOdfdgYDqyGvbxkUbIMqCnUN2LL24YtwQHVZBOv4IvkmtJbAI6muujCHbjYeIkgMpk/o
         ertwA/xqWRc1XTzsULkbAIbZ+uJO+DwybiBVeHw7BLu6nSokzScipXSl9e5i5HpJLYWv
         qW3gxaYZNB9grDmxZMF+w/QXUvx7Os2gtXV4NuR1QnZDH3cCMG426+5pSuc1ufhRAfRq
         XGxT5zLkIqAYoJtQsP+ZgEXlMxY15z5xnl/9g62ddYmu5RcHqeK2GFzDB9baV0d1u24L
         0ggw==
X-Gm-Message-State: AOAM5312dQUVzO25PM0uaqJcxgus9bOqh3hVoBsAsdFyF+LU9j36O+GR
        EUHrPwY/TgTB6BOStWB3hUM=
X-Google-Smtp-Source: ABdhPJyLfOoJ39cpyJDuUL+tU5wQhF112G02dJXAZioVEhaG5hyPc5D1oW/NxBT9ROo/KumxVB3xQQ==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr1008363wma.6.1597385088054;
        Thu, 13 Aug 2020 23:04:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f? ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id k4sm14550383wrd.72.2020.08.13.23.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 23:04:47 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
To:     Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20200812232444.18310-1-logang@deltatee.com>
 <20200813003200.GA1640756@dhcp-10-100-145-180.wdl.wdc.com>
 <829bed01-44c9-cac7-eb1b-9d1ccca7fd47@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <498ea4cf-1edd-e50e-35aa-b5529616337b@grimberg.me>
Date:   Thu, 13 Aug 2020 23:04:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <829bed01-44c9-cac7-eb1b-9d1ccca7fd47@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> There's an unrelated whitespace change in nvme_init_identify().
>> Otherwise, looks fine.
> 
> Oops, sorry. can this be fixed up when it's merged?

Fixed and queued.
