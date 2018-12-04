Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF0EC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6F020672
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6F020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeLDRNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:13:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35990 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeLDRNv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:13:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so8544157pfc.3
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4ifFJ/gsxwKs7qHNPdv77qdgbmG2+UFZhkUzSdkET0=;
        b=h4FBBXV1Jv+GxpTZW1K1TZepGjgL03hzoqFMrgWIvaNkqx3PZtsVp7789u3I1Edc0S
         hnHc5RIHtyxxlNcLFbUdojg88RNyLnCvc6ulxmtBZxWSh86e7TlnWMbC/TCcOBML8f3l
         yOE5yCqMgXKzMMqEcA/ljRQNF15CH1ZJOc0Try3Vh01dJ/wIDnFONryze2IQFLpla/9o
         ssVJc1nFyECXQnaKUyk0upTyiWfKrdMmgsL1QYHtobFsgHcZ9rHh8vGddS2FjPhhXDP7
         dV2luNz8xSP6BV7notscBsMITxlKK6xupmDxLfgRbk7Z5UsA4DaZ0WCu5n0HbweWNMLx
         O33Q==
X-Gm-Message-State: AA+aEWYApIFVieQYmMETwg6fXUJW6j0jhij4FAW1JoaRrDsu7k/qb6zh
        UvfjuHLrjnnBxTErdFptW/gfM9fj
X-Google-Smtp-Source: AFSGD/XbROue62w7/R9T85SRrzGH/auXSmVkGw4vaQdyb1W4sZaN39ehfakH4Pt7oLLbbwm+oEKSzg==
X-Received: by 2002:a65:58ca:: with SMTP id e10mr15838708pgu.99.1543943630813;
        Tue, 04 Dec 2018 09:13:50 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id r4sm27816855pgn.54.2018.12.04.09.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:13:50 -0800 (PST)
Subject: Re: [PATCH 05/13] nvme-pci: consolidate code for polling
 non-dedicated queues
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-6-hch@lst.de>
 <9abd8fde-58c4-0704-1e42-d066b674bb90@grimberg.me>
 <20181204150449.GB3630@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <687e3fd9-fe73-5205-5656-d4861d7dd274@grimberg.me>
Date:   Tue, 4 Dec 2018 09:13:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204150449.GB3630@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> +static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
>>
>> Do we still need to carry the tag around?
> 
> Yes, the timeout handler polls for a specific tag.

Does it have to? the documentation suggests that we missed
an interrupt, so it is probably waiting on the completion queue.

I'd say that it'd be better if the tag search would be implemented
on the timeout handler alone so we don't have to pass the tag around
for everyone... Thoughts?
