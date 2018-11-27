Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901FBC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 07:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623C620873
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 07:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623C620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeK0SpI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:45:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbeK0SpI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 13:45:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so21589811wrb.2;
        Mon, 26 Nov 2018 23:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNgpRiIMm6UVnBOQ2U0iDLW87cddWDRCfOZfZY2+aMc=;
        b=aPQZ0jA4cWbbrks5zH4rAdoAvh6lbFtHnrVzKeepAcH9gbrjniA82Hknsl0V7J+1ZM
         2SfNBWmUMIw7DcMNz07HHu4GIAFKoQv6Ob4e3dyMWW3JNJUCNpThBJUPbCiiS5CqDYc7
         gqjd5o/xOPV2ob+ygHqRuW9KHLAZRFCXwT4GDhpt+kEbntOJKpQb2+UfCOTFAr/OcGuQ
         6ZeUNElx1M5C0UM/ML6NmJiHLYtvk7iKN726I1Bk2QvIblmCZOjWDktj02YO6zMbP3LR
         /Y1uKx2YbSKYwGlI2r1b09gMo1B5sMtGHFANKAwXW/TXRTVzu58UFrP/uL3xxxBqXr5m
         VOog==
X-Gm-Message-State: AA+aEWbLtklP4Iz9RF29ZqgoFqlngE6JCRn2K1aUYOf1F4tZlBheo+sQ
        MEukl1mdZCbBX3lK6qeN6+8=
X-Google-Smtp-Source: AFSGD/XyP1wHHR/grFWw2J0NZdB7XZlpuT9N8tc1R2b06EOcOLT2RW9YuAxKqfI4DmItZOrJaXMo0w==
X-Received: by 2002:adf:f504:: with SMTP id q4mr27797638wro.321.1543304886590;
        Mon, 26 Nov 2018 23:48:06 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id m4sm455937wrw.67.2018.11.26.23.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 23:48:06 -0800 (PST)
Subject: Re: [PATCH v3 13/13] nvme-tcp: add NVMe over TCP host driver
To:     Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-14-sagi@grimberg.me> <20181122080224.GA26504@lst.de>
 <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>
 <e4407485-843a-7968-c367-29d60baf8373@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <43ad34a0-799d-5f78-a07f-e2c51f64a854@grimberg.me>
Date:   Mon, 26 Nov 2018 23:48:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e4407485-843a-7968-c367-29d60baf8373@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> This looks odd.  It's not really the timeout handlers job to
>>> call nvme_end_request here.
>>
>> Well.. if we are not yet LIVE, we will not trigger error
>> recovery, which means nothing will complete this command so
>> something needs to do it...
>>
>> I think that we need it for rdma too..
> 
> 
> yes we do. and we've patches in our pipe.
> 
> I'm thinking on a wider change in the error/recovery flows but might 
> send it "as is" meanwhile.

I have it too in the pipe. Do you want to send it out or should I?
