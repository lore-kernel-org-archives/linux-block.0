Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4FC433DF
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 08:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E6A22227
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 08:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbgJIILt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 04:11:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44642 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbgJIILt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 04:11:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id h2so4086207pll.11
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2020 01:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GmdwN6RgmFBHTx+x7HRiGyQc4DYAkB723WY+/xGkPKg=;
        b=CXHgH7H4psKtye2Kw5s5TLjQq/lCNOsZAYREvItd+4nhfJ04WqotGFAma/hJgETMPh
         Dw82fh3380DF5fS1egmed0Td4Chh3qx7xAtyQa3RYA3cJ2khyT9JIe8zZnXfEzl30DLK
         ReeDgpxEXEt0DL25ULf92OCBBDIGb87KiA23DivM9Fhrlz9NMZX3A2ijjHGZ8umRYNf8
         p/R6Y2yvJ12kpUbn8kzueP9wu80EeeUiRp4uqLc2RvF8GfV3dEH3bQ6APIA2QwPKVpP+
         3Qm5Hv/oWglAOuev8X1jU12jlqpuDmMaYXWRiE9MAg3ZYZ6rz0bWti8zFx6A5i0innAF
         qfsg==
X-Gm-Message-State: AOAM5307uwanc/aHWoNAxTSMwXjhqsYxeNFavLjCiIMg1NQiwm+ez/gd
        5t2TdcJjZY0gydgtcf+D5RY=
X-Google-Smtp-Source: ABdhPJyc0AUuDke+a4lSFc9O/N5IzIATMVN7/BoxK6g0Hh5gz99JlcSMPRMl51mzGMzZUgX3EAr6WA==
X-Received: by 2002:a17:902:74c1:b029:d3:effa:14ac with SMTP id f1-20020a17090274c1b02900d3effa14acmr10554741plt.64.1602231108852;
        Fri, 09 Oct 2020 01:11:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e430:c9cb:46e0:d242? ([2601:647:4802:9070:e430:c9cb:46e0:d242])
        by smtp.gmail.com with ESMTPSA id x4sm3258254pfj.114.2020.10.09.01.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 01:11:48 -0700 (PDT)
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <189a7d80-ff0f-e6b0-f8f0-b50dfdd028f8@grimberg.me>
Date:   Fri, 9 Oct 2020 01:11:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009043938.GC27356@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 8f4f29f18b8c..629b025685d1 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2177,7 +2177,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>>   	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>>   	if (!blk_mq_request_completed(rq)) {
>>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>> -		blk_mq_complete_request(rq);
>> +		blk_mq_complete_request_sync(rq);
> 
> Or complete the request in the following way? Then one block layer API
> can be saved:
> 
> 	blk_mq_complete_request_remote(rq);
> 	nvme_complete_rq(rq);

Not sure I follow, how does this work?

Anyways, I think that blk_mq_complete_request_sync is a clean
and useful interface. We can do it in nvme but I don't think
it would be better.
