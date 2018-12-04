Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B13C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4884520659
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4884520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeLDRid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:38:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39201 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDRid (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:38:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so8644541pld.6
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nnCL9TXfBifJz2lDE9btrjc8NtgPrhHDRU5AgMINSjQ=;
        b=RuwkcBzlUUUABHMqh6SSvFPOI0z39nqJtN8t/GK+C/Txo8Y4YSlHJVIrzth0MHHGjM
         Oy52yyL3SfF0BNwCLSSzoyegRmnKS4okwW88ltuXMRwn/2Mtoev4FuL5AeEckoCjqR7Z
         DHyLC7HPAHO8k3G4e1nFdP/H6blepFGBs4/KAWmadHfLWuN2gOqk66tqluG/k3FK1X/r
         Fg3jYFrC1w1sWYMRhYmd7gaO8H4e7GLGI6ChbcI/XXBlLu5GWMioFQQOdHEpq8lH2wBd
         7E8M9ijdoOxVh8YFpvgpMu7S6w1cfX8GShkumGDmF/4zo08CdX1UEFRGP7oxnZ5C5NRH
         K4xQ==
X-Gm-Message-State: AA+aEWbjhlV/J26B1kg+V7S5WeqHXX2btGDbZ0j1mDJHjt0HFz2IP54a
        Wx2ivjdGXEPg1p3bxoaEh2DM61i+
X-Google-Smtp-Source: AFSGD/VMF2U/2cOOQ8iueAqzPuE1LQg01Ed4hN8Yuvbv6iogFBrAHzB9l11+kqgr4fPc+QwHfhgLMg==
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr21372122plz.80.1543945111714;
        Tue, 04 Dec 2018 09:38:31 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id h19sm21810092pfn.114.2018.12.04.09.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:38:30 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
To:     Keith Busch <keith.busch@intel.com>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <11e02aa5-b0cb-b4cf-0af4-da3db8db9e36@grimberg.me>
Date:   Tue, 4 Dec 2018 09:38:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204154559.GJ14775@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Yes, I'm very much in favour of this, too.
>>> We always have this IMO slightly weird notion of stopping the queue, set
>>> some error flags in the driver, then _restarting_ the queue, just so
>>> that the driver then sees the error flag and terminates the requests.
>>> Which I always found quite counter-intuitive.
>>
>> What about requests that come in after the iteration runs? how are those
>> terminated?
> 
> If we've reached a dead state, I think you'd want to start a queue freeze
> before running the terminating iterator.

Its not necessarily dead, in fabrics we need to handle disconnections
that last for a while before we are able to reconnect (for a variety of
reasons) and we need a way to fail I/O for failover (or requeue, or
block its up to the upper layer). Its less of a "last resort" action
like in the pci case.

Does this guarantee that after freeze+iter we won't get queued with any
other request? If not then we still need to unfreeze and fail at
queue_rq.
