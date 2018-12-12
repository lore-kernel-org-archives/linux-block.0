Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3991C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A32084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2A32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeLLH3h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:29:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46543 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLH3g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:29:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so8434737pfe.13;
        Tue, 11 Dec 2018 23:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wixUjq+Tj9OUuNdTw1suDG5BtcXDd0mNQJo84zNvI3Y=;
        b=TYnShXPEAUjx5Z5hKguuuGD/InuH63V50kgckJvg82oueGp7+XpnfJiAtBTIiyxVd2
         TRyrSoqLHqGJSM5UdHS5Vfbt9AV0aMTbEVDUB6gn8SXboiTQW9yAE+BYuJlU5Ec3gDi1
         LbccyYr2LEh5BdqBcWBdDbmaZqLs8qTHZBbx5MbHuNjZ4HxvblG4Lju9XzFc972vUE3e
         O98AE6dSSpBX1xWYs5XBufcXD/aZsIrZGE3eZfJy6TW3WPHYuuxkObW/+Gcnz65AMUHi
         qywnlGzrIWvgbmfvaGVODD1cEHU+u+uCnezRsvn/iIxqiPRS3hgQjLbfXRnw78dReswa
         Nf8g==
X-Gm-Message-State: AA+aEWY+WeVpl3nXJjc5M43fb+bSStYZR2khTGXb1PONAhjt0IPzppBI
        qfdp6AWm0gvbu4dgiuxIdhNQY7Y9
X-Google-Smtp-Source: AFSGD/WJd+Fte4hLaPVL1wycsQWljpKNuPI0kAnJHT1ZgdnKV+VFVJN5nRM58Aq+ERa0dozoNlhrxw==
X-Received: by 2002:a63:d450:: with SMTP id i16mr17060657pgj.246.1544599776275;
        Tue, 11 Dec 2018 23:29:36 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id q195sm21347319pgq.7.2018.12.11.23.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 23:29:35 -0800 (PST)
Subject: Re: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-5-sagi@grimberg.me> <20181212071140.GD28461@lst.de>
 <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>
 <20181212072132.GA28850@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f134d4e7-5d0e-7345-0414-9aa3524c75e9@grimberg.me>
Date:   Tue, 11 Dec 2018 23:29:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212072132.GA28850@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> So we need to make sure in the block layer or I/O submitter that
>>> REQ_HIPRI is only set if QUEUE_FLAG_POLL is supported.  I think it would
>>> also help if we rename it to REQ_POLL to make this more obvious.
>>
>> It used to check for it, but was changed to look at nr_maps instead...
>> So I think this is a regression...
> 
> blk_mq_map_queue looks at both QUEUE_FLAG_POLL and nr_maps for the
> queue selection, but that doesn't help with the problem that we should
> never pass poll requests through stacking devices.

Yea I agree.. Would probably make better sense to forbid it in the core,
but I'm not entirely sure how this is possible make_request drivers...
