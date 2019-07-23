Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775F1C76186
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 19:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50869229EB
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 19:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfGWTWt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 15:22:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34495 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfGWTWt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 15:22:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so19630396pfo.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2019 12:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I7H9WuepZHm6Wu+kvlLtlyscOcPVk1KhXWvH7V20mi8=;
        b=nV6gPnUu/yfzweJfUHb336WJeZRtGcjHc+USd314juDersu0zVI0EWhHlpmg/ApFqI
         D99Dzsg3bFf1DJEwgINHXE0/uT8k5eKYAbV6hz5D8t6UMiDMjubq6FiZ9DXJaRmwC1Nh
         9W2dVkWO2rCiXrGulV3tI+hQ+ke9G4Yc9by27IJkFXHzUTtmtG9aqC2HLYep1mlyohIi
         5rfNZMoAA5MbTphReY1LV0/o1N7HtW4NwlqBnTzpzacZCYROxr6sff5Dkm7t15OQA6p2
         0vr9K1HTl716HhFqDDEGJUhErWpr5xr7Dst7FelYLYv2X3MNNs6qZ/7PAQO7E0Q02WU6
         q9VA==
X-Gm-Message-State: APjAAAW3yt53JWDXk87dHHAwg0kXAgGplIefdYD5O2C8xhX8QJr24FH4
        SEZpB3JNdcpfUuVoGmvMf5A=
X-Google-Smtp-Source: APXvYqxjE4Y2rGs5mdh8ZNkeDWgeKP2d1HmOqHBZfr1CZ924v2aIYcbdPWqf+hxKJ2VEcNr13Tpnrw==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr83146483pja.106.1563909768770;
        Tue, 23 Jul 2019 12:22:48 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 85sm45303752pfv.130.2019.07.23.12.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 12:22:47 -0700 (PDT)
Subject: Re: [PATCH 3/5] nvme: don't abort completed request in
 nvme_cancel_request
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-4-ming.lei@redhat.com>
 <d82ead02-c893-4d14-307e-70a6d4596439@acm.org>
 <20190723010845.GD30776@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7e484af3-15d5-06fd-5c7b-2fbe38e5b8f1@acm.org>
Date:   Tue, 23 Jul 2019 12:22:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723010845.GD30776@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/19 6:08 PM, Ming Lei wrote:
> On Mon, Jul 22, 2019 at 08:27:32AM -0700, Bart Van Assche wrote:
>> On 7/21/19 10:39 PM, Ming Lei wrote:
>>> Before aborting in-flight requests, all IO queues have been shutdown.
>>> However, request's completion fn may not be done yet because it may
>>> be scheduled to run via IPI.
>>>
>>> So don't abort one request if it is marked as completed, otherwise
>>> we may abort one normal completed request.
>>>
>>> Cc: Max Gurtovoy <maxg@mellanox.com>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Cc: Keith Busch <keith.busch@intel.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/nvme/host/core.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index cc09b81fc7f4..cb8007cce4d1 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -285,6 +285,10 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
>>>    bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>>>    {
>>> +	/* don't abort one completed request */
>>> +	if (blk_mq_request_completed(req))
>>> +		return;
>>> +
>>>    	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>>>    				"Cancelling I/O %d", req->tag);
>>
>> Something I probably already asked before: what prevents that
>> nvme_cancel_request() is executed concurrently with the completion handler
>> of the same request?
> 
> The commit log did mention the point:
> 
> 	Before aborting in-flight requests, all IO queues have been shutdown.
> 
> which implies that no concurrent normal completion.

How about adding that explanation as a comment above
nvme_cancel_request()? That would make that explanation much easier to 
find compared to having to search through commit logs.

Thanks,

Bart.
