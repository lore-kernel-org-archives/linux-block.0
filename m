Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EEEB64DD
	for <linux-block@archiver.kernel.org>; Fri, 23 Jun 2023 20:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjFWUcL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jun 2023 16:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjFWUcI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 16:32:08 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CEA2940
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 13:32:02 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-666e3b15370so719133b3a.0
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 13:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552321; x=1690144321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGv2rb1selntlCSDa2Tb3nWJbq6tcSirIWLkOUFc+xM=;
        b=XRm2knvuhgVB9WwIx1MBXd4QgUAvNdYV9la9PEYiu8lpDPZJGdy9my2sBWxcM0KYIA
         GDx5qhZmfTocQtOeRBOUfLeBliG0LyVv9pbrx4PgLPFINeqp2DJpKiuzYorTdWOW++ca
         0f9WGHEhjCB0M01HBJHTtAA3OUXanyIGsVXRLXuqUeSASnkYRAH9VDfkUyew41gHpZaH
         Z8+1RzNmT/ZMo6hYizKwxIGEvFRXvOihNiNvtCKICLo1zX0YGsOlfBTXcRqXGVAf3/OQ
         2WPdZegWT9PFVSJOZHSfOh7XMq+Vldf/Kn2X/depIqpGgeJNaKDbfwzhvhqOsvBMt69/
         Nfyw==
X-Gm-Message-State: AC+VfDzYzhXk/WrhR5gGHAx5Tej63k37Enc+pH8N0gA60ztun6mJTukf
        fZD96EU5HDX+Kjm81HDMHXM=
X-Google-Smtp-Source: ACHHUZ7/LV7XbjJJPsagpUq88CXfat9Kv2yBDLq+Hwdj7VhQDzTKCp/axfswVxkz2EiYUc9BUhVZTQ==
X-Received: by 2002:a17:902:c642:b0:1b3:bbe3:25a8 with SMTP id s2-20020a170902c64200b001b3bbe325a8mr129528pls.55.1687552321106;
        Fri, 23 Jun 2023 13:32:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8f2:1321:dd41:5ef? ([2620:15c:211:201:8f2:1321:dd41:5ef])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b682336f83sm1673plh.42.2023.06.23.13.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 13:32:00 -0700 (PDT)
Message-ID: <0fb59d43-f124-575d-0d5c-b415b3280a4d@acm.org>
Date:   Fri, 23 Jun 2023 13:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org>
 <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
 <1d2fc2c5-18fc-a937-7944-7d7808c00a0b@acm.org>
 <ZG1a610jtBDPDPip@ovpn-8-17.pek2.redhat.com>
 <a40b10d9-4e30-438f-2509-28bb0df4a161@acm.org>
 <bf32b0f9-d85b-367f-e6f4-83d58c418d7a@kernel.org>
 <43cc01f3-c1fa-84c4-c3a0-5a1b62982bcd@acm.org>
 <a11b7721-1eaf-43d6-bcaa-d7fdeb9904ad@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a11b7721-1eaf-43d6-bcaa-d7fdeb9904ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/23 16:45, Damien Le Moal wrote:
> On 6/21/23 09:34, Bart Van Assche wrote:
>> Regarding removing zone write locking, would it be acceptable to
>> implement a solution for SCSI devices before it is clear how to
>> implement a solution for NVMe devices? I think a potential solution for
>> SCSI devices is to send requests that should be requeued to the SCSI
>> error handler instead of to the block layer requeue list. The SCSI error
>> handler waits until all pending requests have timed out or have been
>> sent to the error handler. The SCSI error handler can be modified such
>> that requests are sorted in LBA order before being resubmitted. This
>> would solve the nasty issues that would otherwise arise when requeuing
>> requests if multiple write requests for the same zone are pending.
> 
> I am still thinking that a dedicated hctx for writes to sequential zones may be
> the simplest solution for all device types:
> 1) For scsi HBAs, we can likely gain high qd zone writes, but that needs to be
> checked. For AHCI though, we need to keep the max write qd=1 per zone because of
> the chipsets reordering command submissions. So we'll need a queue flag saying
> "need zone write locking" indicated by the adapter when creating the queue.
> 2) For NVMe, this would allow high QD writes, with only the penalty of heavier
> locking overhead when writes are issued from multiple CPUs.
> 
> But I have not started looking at all the details. Need to start prototyping
> something. We can try working on this together if you want.

Hi Damien,

I'm interested in collaborating on this. But I'm not sure whether a 
dedicated hardware queue for sequential writes is a full solution. 
Applications must submit zoned writes (other than write appends) in 
order. These zoned writes may end up in a software queue. It is possible 
that the software queues are flushed in such a way that the zoned writes 
are reordered. Or do you perhaps want to send all zoned writes directly 
to a hardware queue? If so, is this really a better solution than a 
single-queue I/O scheduler? Is the difference perhaps that higher read 
IOPS can be achieved because multiple hardware queues are used for reads?

Even if all sequential writes would be sent to a single hardware queue, 
to support queue depths > 1, we still need a mechanism for resubmitting 
requests in order after a request has been requeued. If e.g. three zoned 
writes are in flight and a unit attention is reported for the second 
write then resubmitting the two writes that have to be resubmitted must 
only happen after both writes have completed.

Another possibility is to introduce a new request queue flag that 
specifies that only writes should be sent to the I/O scheduler. I'm 
interested in this because of the following observation for zoned UFS 
devices for a block size of 4 KiB and a random read workload:
* mq-deadline scheduler:  59 K IOPS.
* no I/O scheduler:      100 K IOPS.
In other words, 70% more IOPS with no I/O scheduler compared to 
mq-deadline. I don't think that this indicates a performance bug in the 
mq-deadline scheduler. From a quick measurement with the null_blk driver 
it seems to me that all I/O schedulers saturate around 150 K - 170 K IOPS.

Thanks,

Bart.

