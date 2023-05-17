Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF04DC77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjEQHzI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEQHzG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:55:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF510E6
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 941B66430C
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 07:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328A8C433EF;
        Wed, 17 May 2023 07:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684310105;
        bh=7WcibAZjUjfjrkcpyq0klXf62lH30p5KxV7AgUpOJzw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TUHTgmiht3ya7WiCL/IDTExpxWsHkOasAc5cw3LFIV/orhqXAu2M5+BhmLfGgrz2Q
         +4oQgQvaNl7P+GfNMF9CtthqrZ8GKMNA9JXRXwzMYoNeCNa2asGV8rf5vZAuXMS9sS
         lb06eZXHVisnphvQXbvD9/AqvPu9kfvaBPSY+tMlEQ6Hndfkr+C/tVVdXaDZ4TV8ex
         vnWI87CObUmmoYSl0luyuuABAq6iIoCq+LXSVDKBLkbT1ABKVKdmvz10aH9GCEYoi/
         VVqGRp930pLdUEHZpTxAM4h1TdOl4NoLwXpXtsfrpbaYf5LE8wX73TgPYExYRuzLBd
         KAtz8m6GWrD2w==
Message-ID: <7fa469d9-dac3-f2ac-7bb1-73432fc3dc96@kernel.org>
Date:   Wed, 17 May 2023 16:55:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 07/11] block: mq-deadline: Improve
 deadline_skip_seq_writes()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-8-bvanassche@acm.org>
 <2471f31c-763f-1935-ec32-c32447c9379e@suse.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2471f31c-763f-1935-ec32-c32447c9379e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 16:41, Hannes Reinecke wrote:
> On 5/17/23 00:33, Bart Van Assche wrote:
>> Make deadline_skip_seq_writes() do what its name suggests, namely to
>> skip sequential writes.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   block/mq-deadline.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index 6276afede9cd..dbc0feca963e 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -308,7 +308,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>>   	do {
>>   		pos += blk_rq_sectors(rq);
>>   		rq = deadline_latter_request(rq);
>> -	} while (rq && blk_rq_pos(rq) == pos);
>> +	} while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq));
>>   
>>   	return rq;
>>   }
> 
> Please merge it with the previous patch.

Please no. Let's drop this change.

> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

