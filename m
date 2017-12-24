Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37076 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdLXIu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Dec 2017 03:50:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so28187889wmd.2
        for <linux-block@vger.kernel.org>; Sun, 24 Dec 2017 00:50:28 -0800 (PST)
Subject: Re: [PATCH V2 6/6] nvme-pci: remove .init_request callback
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Keith Busch <keith.busch@intel.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20171214023103.18272-1-ming.lei@redhat.com>
 <20171214023103.18272-7-ming.lei@redhat.com>
 <0fcf3176-7864-8631-e293-2bfa7aacea38@grimberg.me>
 <20171222013445.GA4545@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6420530f-1403-b0f4-0c95-d16fa396e095@grimberg.me>
Date: Sun, 24 Dec 2017 10:50:24 +0200
MIME-Version: 1.0
In-Reply-To: <20171222013445.GA4545@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Please prepare a formal one(at least tested in normal case), either I
> or Zhang Yi may test/verify it.

OK.

>> @@ -1387,10 +1385,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev,
>> struct nvme_queue *nvmeq,
>>   static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>>                                                          int depth, int node)
>>   {
>> -       struct nvme_queue *nvmeq = kzalloc_node(sizeof(*nvmeq), GFP_KERNEL,
>> -                                                       node);
>> -       if (!nvmeq)
>> -               return NULL;
>> +       struct nvme_queue *nvmeq = &dev->queues[qid];
> 
> Maybe you need to zero *nvmeq again since it is done in current code.

Relying on this is not a good idea, so I think we better off without
it because I want to know about it and fix it.

>> @@ -2470,8 +2465,9 @@ static int nvme_probe(struct pci_dev *pdev, const
>> struct pci_device_id *id)
>>          dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
>>          if (!dev)
>>                  return -ENOMEM;
>> -       dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void
>> *),
>> -                                                       GFP_KERNEL, node);
>> +
>> +       alloc_size = (num_possible_cpus() + 1) * sizeof(struct nvme_queue
>> *);
> 
> The element size should be 'sizeof(struct nvme_queue)'.

Right.
