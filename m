Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69688C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3752820661
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3752820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeLDRIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:08:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39092 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLDRIg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:08:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so7646095pgl.6
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E857BGqXGVL/o8OR18iJdYMZapGl3qVUhhCIW64zE/I=;
        b=SUSU5kYZ4pOauGtDMo0EVlfEHQheLIs4uLb0Fv+QxJruKpOnSpQyIpE8+UqcbehcRS
         uVX8LPjDGXRizfTPIKrQvOaqOtJGPiC0xi/OhSJ+68JLFiBCf+Djk1X8W8HqxzuorEq9
         wsoq5A42YEUl6xNSKAgfdshYf1bgLwNHalKRHaRAbIKDtp35SKpZc/2p5x+MF/Tkfl89
         yK7VySJGdq1en8VOPmtpVZq1RvtS9aOrbh0jwSkmSv2z2yL3lDU177Sijnpn06ongSkk
         syQWZ8XWr2kbP6D5tkQBeqwxu4auZHH7dEqrsZ9isVF0Y7q67xN6LisDz7tKHJbJoVRV
         X3oA==
X-Gm-Message-State: AA+aEWZwIfnjspSGdZ4Vig/4dAMdV/NGh/p6IBKvxfRFRxC2OYDD02Eq
        5dKQwfA1c7mQZR/eqfuqwEEu0SFy
X-Google-Smtp-Source: AFSGD/WMi1rvMdP4k/rkwImbUlIJkStqDnZxqCcoQbL2AgGDQlx725onIXHIDQhayKo12JtGVNhrSA==
X-Received: by 2002:a63:1321:: with SMTP id i33mr17786712pgl.380.1543943315372;
        Tue, 04 Dec 2018 09:08:35 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id w128sm25788867pfw.79.2018.12.04.09.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:08:34 -0800 (PST)
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-2-hch@lst.de>
 <5a1cd7aa-8937-ae23-c9ae-c8ddaf525080@grimberg.me>
 <20181204150022.GA3440@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <35684119-ac22-df3a-94cf-ede80ab3ce8d@grimberg.me>
Date:   Tue, 4 Dec 2018 09:08:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204150022.GA3440@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Nit, there seems to be an extra newline that can be omitted here before
>> the else if statement (if I'm reading this correctly)...
> 
> Empty lines can always be ommited, but in this case I actually like it
> as it seems to help readability..

If you think its useful I'm fine with it as is...
