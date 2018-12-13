Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C286C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 16:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B21D20879
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 16:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B21D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeLMQPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:15:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35321 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeLMQPC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 11:15:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so1289057plo.2;
        Thu, 13 Dec 2018 08:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SrCFpkY34lbiT3XHof78IvR9UsOB2zPNo5rGTN5exzs=;
        b=iYC6k79l/Fkle3cCeFPwmbaXpGpJYUAezUlvnCSVtzD3lVoK3uJtssMlo+wTULT7/G
         rjKfrPu2yLY0Z28+fMWaN4MKnNB9bKHmwITqRmoeXSEdwS71GxIdWlEO5hjzqbhAQvvf
         k1QTvQNMBGgvPxFtwGL1H+RPByEgoSGLg0Gtd0XJcxQC2GML+jEg/aL7faBf1sDhaL95
         L7nSHdrsKaELZYVKMdCKQ62TeJA/1RK+aUxTEXpf6rOYKwDLdeHHaGIvV6aoYlu969yo
         ncp0/dmizJyvxHdGi4JqQRveRPDexmRdZwFsSNQ1TZn5RxbjW/TkOjf8POfVfAdoUdBJ
         gTwg==
X-Gm-Message-State: AA+aEWajHGzV07Dlv+rt2/BYrmffKJ4id5Gxt3S6EwWYkBKkYZPSxrfS
        oyeaG559FYaf9o3IQIeLv+wvmTvB
X-Google-Smtp-Source: AFSGD/WZI2DCG85s/Ra5g6QePE/KUqjI9xH00zpzw+6Vi5KNUN8W5p9GupZQZyBpPNwvL2yJOp1vpw==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr24321177plb.169.1544717700528;
        Thu, 13 Dec 2018 08:15:00 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id b7sm5755954pfa.52.2018.12.13.08.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 08:14:59 -0800 (PST)
Subject: Re: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-7-sagi@grimberg.me> <20181213083157.GD869@lst.de>
 <4f3f213e-9042-5963-d47d-0ee501bf94fa@grimberg.me>
 <20181213155235.GA10566@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0c5c172f-9b34-3cba-37ab-a39ad9351da5@grimberg.me>
Date:   Thu, 13 Dec 2018 08:14:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213155235.GA10566@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>>> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>>> +		bio->bi_opf &= ~REQ_HIPRI;
>>> +
>>
>> Maybe we can simply check (q->queue_flags & (1 << QUEUE_FLAG_POLL)) and
>> avoid the extra atomic operation in the host path?
>>
>> Would it make sense?
> 
> test_bit is not usually implemented as an atomic operation.
> 
> Take a look at e.g.
> 
> arch/x86/include/asm/bitops.h:constant_test_bit()

Ah.. But its still read from volatile argument so still more expensive?
