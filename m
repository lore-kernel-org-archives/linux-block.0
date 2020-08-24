Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761F9C433E1
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D30F207D3
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 08:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHXIUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:20:00 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56093 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgHXIT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 04:19:59 -0400
Received: by mail-pj1-f65.google.com with SMTP id 2so3882806pjx.5
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2020 01:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05Mv8NGDlOkaCdlHqQEOQS1giktqLGYhCuCEfRGwKF0=;
        b=K4jRWIIEqrn3RuG5kRsPKUrbBIONvwXoAE1K6bIEzrfbk5c3vPO5NdqrhxBghuKfDv
         3gTR2L1mF1p7B0IEWuQFuV2QP6w+P733KU5M6CMupVMTP3l7yzDTT5w0VmpnKDxsuzQi
         UQMsqpvgl4V9IYcSp20F2eGYhfTWmLevvq15cds15Ia51obGufHZ8zLTWvyqOLtrnbmS
         nNH5NmQ8HtElF6RkiFASsHxSAT6tvYGPxc2CBoskiH950yCpKh6cMaXSrvGELcHQ9jAL
         2C3MjmXrscBqpAEnyffbwIBlvh0D6awQdkkl9s8eVC5vU/2a4ccpl93p2ChaduSryqY6
         vQVg==
X-Gm-Message-State: AOAM532aVfRRIuLYg/zdtmasp53ShYCN7MAuuathhUY2XWSYKK3t+95j
        sL5p0KEmbJWq8KKGxw/cBy4=
X-Google-Smtp-Source: ABdhPJy/3mmtd08DhrZ9AdShj82mjofaf9s0xrbMW7wU8mbqftPNgPHc8Z8Xd/x2tw7zGNEQhvM+/A==
X-Received: by 2002:a17:90a:dc13:: with SMTP id i19mr3413643pjv.161.1598257198530;
        Mon, 24 Aug 2020 01:19:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d? ([2601:647:4802:9070:cda6:bf68:c972:645d])
        by smtp.gmail.com with ESMTPSA id z26sm8808398pgc.44.2020.08.24.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 01:19:57 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
 <856f6108-2227-67e8-e913-fdef296a2d26@grimberg.me>
 <20200822133954.GC3189453@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <619a8d4f-267f-5e21-09bd-16b45af69480@grimberg.me>
Date:   Mon, 24 Aug 2020 01:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200822133954.GC3189453@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index bb5636cc17b9..5fa8bc1bb7a8 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -572,6 +572,10 @@ struct request_queue {
>>>    	struct list_head	tag_set_list;
>>>    	struct bio_set		bio_split;
>>> +	/* only used for BLK_MQ_F_BLOCKING */
>>> +	struct percpu_ref	dispatch_counter;
>>
>> Can this be moved to be next to the q_usage_counter? they
>> will be taken together for blocking drivers...
> 
> I don't think it is a good idea, at least hctx->srcu is put at the end
> of hctx, do you want to move it at beginning of hctx?

I'd think it'd be an improvement, yes.

> .q_usage_counter should have been put in the 1st cacheline of
> request queue. If it is moved to the 1st cacheline of request queue,
> we shouldn't put 'dispatch_counter' there, because it may hurt other
> non-blocking drivers.

q_usage_counter currently there, and the two will always be taken
together, and there are several other stuff that we can remove from
that cacheline without hurting performance for anything.

And when q_usage_counter is moved to the first cacheline, then I'd
expect that the dispatch_counter also moves to the front (maybe not
the first if it is on the expense of other hot members, but definitely
it should be treated as a hot member).

Anyways, I think that for now we should place them together.

>> Also maybe a better name is needed here since it's just
>> for blocking hctxs.
>>
>>> +	wait_queue_head_t	mq_quiesce_wq;
>>> +
>>>    	struct dentry		*debugfs_dir;
>>>    #ifdef CONFIG_BLK_DEBUG_FS
>>>
>>
>> What I think is needed here is at a minimum test quiesce/unquiesce loops
>> during I/O. code auditing is not enough, there may be driver assumptions
>> broken with this change (although I hope there shouldn't be).
> 
> We have elevator switch / updating nr_request stress test, and both relies
> on quiesce/unquiesce, and I did run such test with this patch.

You have a blktest for this? If not, I strongly suggest that one is
added to validate the change also moving forward.
