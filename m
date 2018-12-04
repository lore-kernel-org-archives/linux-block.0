Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629C1C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC7A20661
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC7A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLDRLb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:11:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36837 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDRLb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:11:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so8540998pfc.3
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjwsIRTMf/i0UtDvRvHV8cTj4uecIcwTF7S5eFkKuUc=;
        b=IDseJBfVsgMwWRbCSvwEalicpr9nvbaz8jqh5I/RizaYueWcJbT7OrR+eTM06P6DaS
         5U6U0zJfm/CICYEj2mlFNg86y5ZBgszCO2OAHkN1hbWUk6RuRaQHKivWzzMBu8E22QjD
         cSut9tqOAe41KA9F6T4DWd9xQQFP6iIywd6U874FlB36THRZaJHSFkD1WzfchkOq19uL
         w9E/LHgFT/yug7a91TDwQYxjXRZqjAhkNRD1YKglmZezSldNbFvuQ+r3IpjgqphhwQ5A
         GsswOoxOVOiSLdA91MmYx1ITYMqKCtLNlqwGFzhuUAOOD1T4h0wD/n6oDfiFKP97HXe/
         tiZw==
X-Gm-Message-State: AA+aEWZr2/PsOs/7N4qisidkL0wYsKKZmxMEeX7fLk9VYW+/xLHe8Tdz
        C12EubjxN0NotWmCDZmrD4tWHopB
X-Google-Smtp-Source: AFSGD/VXqtHFoPIuSv5xsdhbTKkC5/CXDHQMNOmUaPZW43B4uPcwLNtdTiiYfgmRAUQbqmkZ6O0a/Q==
X-Received: by 2002:a63:6205:: with SMTP id w5mr17373045pgb.53.1543943490001;
        Tue, 04 Dec 2018 09:11:30 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id x12sm18758904pgr.55.2018.12.04.09.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:11:28 -0800 (PST)
Subject: Re: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue enabled
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-3-hch@lst.de>
 <1ad65e6d-8b42-6f8e-8eb7-0b28b04e5dd4@grimberg.me>
 <20181204150403.GA3630@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <93e33763-ca30-2995-7040-9bfd92a09d7d@grimberg.me>
Date:   Tue, 4 Dec 2018 09:11:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204150403.GA3630@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> @@ -2173,6 +2157,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>>      	if (nr_io_queues == 0)
>>>    		return 0;
>>> +	
>>> +	clear_bit(NVMEQ_ENABLED, &adminq->flags);
>>>    
>>
>> This is a change of behavior, looks correct though as we can fail
>> nvme_setup_irqs after we freed the admin vector. Needs documentation
>> though..
> 
> I have a hard time parsing the above, can you point to where the problem
> is?

This flag replaces cq_vector = -1 for indicating the queue state so I'd
expect that it would not appear where the former didn't. In this case
we clear the flag in a place that before we did not set the cq_vector
before, which seems correct to me though.
