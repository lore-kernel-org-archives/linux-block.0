Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E3DC77B70
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjDKRRq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjDKRRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:17:33 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0915B6A62
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:17:20 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id j8so7087383pjy.4
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233439; x=1683825439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EauxfmWKqu0NM5k6QUmQ9ZPdAfK+9nbsD8ufAxbBZ2Y=;
        b=J/X+O9Y4tZaaEANfkmuC8labABIrOiJUxwGSd1IDIQIHImifAs4azV/hOOHbXYQOS7
         x7ZeqQO0e9+VuwRk2cxA+GsXAE9wzhtwR9CkinVjKZqMVUTNGAGWVUYPosiV+Hga+YgG
         vxhpwmTRe7zccmTlyKRcVDuoiyYIYGA9MdrrCve6WjB88lgPfHfX4xdNacZPvGMzeGBg
         USLDh4aTjIun/XIbBZ46kQ5Q79Uea1sI4TCHjkNjjhrg4FC6XzfFGDAOQFR4sRSDTHbt
         soQGJrOlwGylYxM+0jhokXwyYJkMhCB+osac7My0U0C59XgtM0jhY9s/gQejBch7sWoI
         RO0Q==
X-Gm-Message-State: AAQBX9eqx1O3rC1jbTGa0+kqrzbU1isZIXU3PM7F0x50v/DeqQCK95zh
        0B7K6ZTJiEKo1vmbMsfIHKJK/DlfkoE=
X-Google-Smtp-Source: AKy350Z40KQLc2LSDlOeVlNMsHdrhXoGVVpIF/n1t8rsRBK8sHj7eEgwepWYFRngshCr1FVcnZi6Yg==
X-Received: by 2002:a05:6a20:3b27:b0:eb:7eea:825e with SMTP id c39-20020a056a203b2700b000eb7eea825emr528574pzh.9.1681233439035;
        Tue, 11 Apr 2023 10:17:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id s10-20020a65690a000000b0051b0e564963sm2726387pgq.49.2023.04.11.10.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:17:18 -0700 (PDT)
Message-ID: <2a6975d0-e428-6435-1657-32825793d7ba@acm.org>
Date:   Tue, 11 Apr 2023 10:17:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 03/12] block: Send requeued requests to the I/O
 scheduler
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-4-bvanassche@acm.org> <20230411123806.GA14106@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411123806.GA14106@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 05:38, Christoph Hellwig wrote:
> On Fri, Apr 07, 2023 at 04:58:13PM -0700, Bart Van Assche wrote:
>> @@ -2065,9 +2057,14 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>>   		if (nr_budgets)
>>   			blk_mq_release_budgets(q, list);
>>   
>> -		spin_lock(&hctx->lock);
>> -		list_splice_tail_init(list, &hctx->dispatch);
>> -		spin_unlock(&hctx->lock);
>> +		if (!q->elevator) {
>> +			spin_lock(&hctx->lock);
>> +			list_splice_tail_init(list, &hctx->dispatch);
>> +			spin_unlock(&hctx->lock);
>> +		} else {
>> +			q->elevator->type->ops.insert_requests(hctx, list,
>> +							/*at_head=*/true);
>> +		}
> 
> But I have no idea how this is related in any way.

Hi Christoph,

The I/O scheduler can only control the order in which requests are 
dispatched if:
- blk_mq_run_hw_queue() moves requests from the requeue list to the I/O
   scheduler before it asks the I/O scheduler to dispatch a request.
- No requests end up on any other queue than the I/O scheduler queue or
   the requeue list.

The scope of this patch is to send requeued requests back to the I/O 
scheduler. Hence the above change.

Thanks,

Bart.
