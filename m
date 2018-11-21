Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808A8C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54902206BB
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 22:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54902206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390097AbeKVJFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:05:03 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:47022 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390093AbeKVJFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 04:05:03 -0500
Received: by mail-oi1-f195.google.com with SMTP id x202so5865450oif.13;
        Wed, 21 Nov 2018 14:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KuZ7+mGoNARFkNhv4eb810vmNUiq/Q6YY4LsAmlzen8=;
        b=uLUw2cx9V/W/qU5reaGyRWGaI5u5bEtjbgzVtJdRBop/m4U+iEzi9+Unjd6+dzHiAX
         SQfjaDFuVrWDvKbDQ2jIOAPTW6dGMhYfIJMlE1ioLkl74zn/VyAYfdZF2CGeu9tuXp+a
         258aa9On020++YevwbuZFqGo9sU74Jvb13HAAIe8/Sc1/x91fbGzyo7GGDoL9WaldAf+
         w/VER0lO6IkRgIm3L0M50cCLNlrUqG7upcS2iaJ27wtkISbdsWVr2KGgurxGfhh7VHyC
         QzX3lprsWG+TOb+QAh6/6W7RfzQizLF08qns62uShAyklwuzeyJZWGGh+zlFJh8K3ePM
         40Yw==
X-Gm-Message-State: AGRZ1gKzqzoTWwr+WB+VKgHIfflw4umt6JQbICBLIMr6R7wqOzEHgV9x
        KmqcwGEs1iasw4RCV3HvTPI=
X-Google-Smtp-Source: AJdET5cu3+0ALvcUawD+L7/Vu0KJs3A+dOMW4DnpWIdPLqj4viFsq/Ku6f2OZaYBkHUudHrqP9OqoQ==
X-Received: by 2002:aca:4b4f:: with SMTP id y76mr4860291oia.88.1542839324263;
        Wed, 21 Nov 2018 14:28:44 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 102sm18419379otj.65.2018.11.21.14.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 14:28:43 -0800 (PST)
Subject: Re: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
To:     Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me> <8736rufxmg.fsf@solarflare.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7eb460c9-2d91-a643-d246-c8eae6256374@grimberg.me>
Date:   Wed, 21 Nov 2018 14:28:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8736rufxmg.fsf@solarflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/21/18 4:01 AM, Mikhail Skorzhinskii wrote:
> Sagi Grimberg <sagi@grimberg.me> writes:
>   > +static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req)
>   > +{
>   > +	struct nvme_tcp_queue *queue = req->queue;
>   > +
>   > +	spin_lock_bh(&queue->lock);
>   > +	list_add_tail(&req->entry, &queue->send_list);
>   > +	spin_unlock_bh(&queue->lock);
>   > +
>   > +	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   > +}
> 
> May be I missing something, but why bother with bottom half version of
> locking?
> 
> There are few places where this lock could be accessed:
> 
>   (1) From ->queue_rq() call;
>   (2) From submitting new AEN request;
>   (3) From receiving new R2T;
> 
> Which one if these originates from bottom half? Not 100% about queue_rq
> data path, but (2) and (3) looks perfectly safe for me.

Actually, (3) in former versions was invoked in a soft-irq context which
was why this included the bh disable, but I guess it can be removed now.
