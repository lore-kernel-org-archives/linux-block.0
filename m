Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966CEC04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AF02145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AF02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeK3MaP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:30:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44351 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3MaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 07:30:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so1924778pls.11;
        Thu, 29 Nov 2018 17:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/77D9u0MQjuKb5azGe+ufI2U8qqKQ8Hi1bgZqlywjrc=;
        b=ISRbBNL5x8JzBy5aXrMQZNST6JRl2zW4osKVfzUTk4yicnuC4NZwSMJLUhY2Mh6M5N
         yPse12JrvZ+Wd9uOaTzo+EzuQPpP2cDWWCWBkt+uvUKagfPubw1HHj1Wujvu3YF4+4V+
         JlgupAJ+v1gH0pV7QVwx8lD4V7nD3gVzBOq6jfqNhTvTJoJBPdKm0cPFX8VX34zqKMf0
         yTe442pbR4iQGnVljSMR/eRCWpDHzZ4nCiKKIY4HO8OnBI56Y/bNEMjAHATRcM1+INmp
         q9FVYkUZRZSAFPUHBRyh1Rz1QZJSUfNTgiXr5MDUy8VPDIsyt12eHQZ6gts+wM/eo2/g
         Qw6A==
X-Gm-Message-State: AA+aEWYUKQ6x70M3qoqyjubxwWfJsEVOggkrT7VEd58h+hGGSkVnjJ7c
        IIZy4xDm1NjDBBNvXQXbgp8=
X-Google-Smtp-Source: AFSGD/VelOnUU2Qb2q0ej89O251BZyN4xj8hIuwEtjvGGX4aVifOTUdNtP6u3V30m//o4KkBVxFiVA==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr3713907plk.208.1543540964627;
        Thu, 29 Nov 2018 17:22:44 -0800 (PST)
Received: from [10.1.124.47] ([199.36.244.14])
        by smtp.gmail.com with ESMTPSA id e65sm4683036pfc.74.2018.11.29.17.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 17:22:43 -0800 (PST)
Subject: Re: [PATCH v4 11/13] nvmet-tcp: add NVMe over TCP target driver
To:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181127231615.9446-1-sagi@grimberg.me>
 <20181127231615.9446-12-sagi@grimberg.me>
 <4ad0ce00-46a6-9aff-44ba-6c4374a9386e@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9068fee7-e299-afe1-3d29-22c2448379c7@grimberg.me>
Date:   Thu, 29 Nov 2018 17:22:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4ad0ce00-46a6-9aff-44ba-6c4374a9386e@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +static inline void nvmet_tcp_put_cmd(struct nvmet_tcp_cmd *cmd)
>> +{
>> +    if (unlikely(cmd == &cmd->queue->connect))
>> +        return;
> 
> if you don't return connect cmd to the list please don't add it to it in 
> the first place (during alloc_cmd). and if you use it once, we might 
> think of a cleaner/readable way to do it.
> 
> why there is a difference between regular cmd and connect_cmd ? can't 
> you increase the nr_cmds by 1 and not distinguish between the two types ?

We don't have the queue size before we connect, hence we allocate a
single command for nvmf connect and when we process it we allocate the
rest.

Its done this way such that the command processing code does not
differentiate this case with a dedicated condition, hence I prefer to
keep it in the command list for the first pass such that we don't have
this check in the normal command processing code.

The reason it doesn't go back to the list is because it does not
belong to the cmds array which we rely on to lookup our command context
based on the ttag.

>> +static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>> +        struct socket *newsock)
>> +{
>> +    struct nvmet_tcp_queue *queue;
>> +    int ret;
>> +
>> +    queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>> +    if (!queue)
>> +        return -ENOMEM;
>> +
>> +    INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>> +    INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
>> +    queue->sock = newsock;
>> +    queue->port = port;
>> +    queue->nr_cmds = 0;
>> +    spin_lock_init(&queue->state_lock);
>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>> +    INIT_LIST_HEAD(&queue->free_list);
>> +    init_llist_head(&queue->resp_list);
>> +    INIT_LIST_HEAD(&queue->resp_send_list);
>> +
>> +    queue->idx = ida_simple_get(&nvmet_tcp_queue_ida, 0, 0, GFP_KERNEL);
>> +    if (queue->idx < 0) {
>> +        ret = queue->idx;
>> +        goto out_free_queue;
>> +    }
>> +
>> +    ret = nvmet_tcp_alloc_cmd(queue, &queue->connect);
>> +    if (ret)
>> +        goto out_ida_remove;
>> +
>> +    ret = nvmet_sq_init(&queue->nvme_sq);
>> +    if (ret)
>> +        goto out_ida_remove;
> 
> please add a goto free_connect_cmd:
> 
> nvmet_tcp_free_cmd(&queue->connect);
> 
> to avoid memory leak in error flow.

Will do, thanks.
