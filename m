Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F8AC433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 22:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0556B6509E
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 22:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCEWev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 17:34:51 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:38397 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCEWeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 17:34:44 -0500
Received: by mail-oo1-f54.google.com with SMTP id z12so373777ooh.5
        for <linux-block@vger.kernel.org>; Fri, 05 Mar 2021 14:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z91xx6uF+CymxsUAgbHYk97Wmf+hUIZkoC3XTJ1WcCA=;
        b=qaex2K/ahYhO+MoscrOj4EVF2MRvBcychWY31KCA81r7WWB8xHc7WHxQd8RJ6pqKc4
         BgMMz+g/BskaMqHf4oY7ueSW600qIn3K0RAtf/C9zM6dAcdznZhhh0b2tSkPv8Wo9C6q
         j4Pv4XrcKEUre/8aD03PpOAN6Icp9jNlm1sDc0W8ZOtGVmlQGEULrMoKpjry9GkAIkSt
         Re14zKtaOk7zFNJ7MXkzjgjn/AbWc1iVcPPJXFDjcjqoxj7JxL3oKsZtBMkWUqsmoL0L
         YjvSR+iJEd7JKY/SBX0nM2AlVhroo1wuTxoXHDa9vlK1OM5z9mcNGRv409XFIBSrix6f
         TQDw==
X-Gm-Message-State: AOAM531IPV32sWhmMlTQRnw+1zYDYp6ohHun1u0uce+3Zn9kvLnPY8fH
        onZtYXh9nxhvfHh/G7KUIb0=
X-Google-Smtp-Source: ABdhPJwWOKWF2C6T3L6kGGMZUi5QXH+3Uk+W67cHAbje2gOFxAjaof2HNYaeidDuB3XaNpAycG7jhQ==
X-Received: by 2002:a4a:aacd:: with SMTP id e13mr9515704oon.35.1614983684391;
        Fri, 05 Mar 2021 14:34:44 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9? ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
        by smtp.gmail.com with ESMTPSA id g21sm830972ooa.15.2021.03.05.14.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 14:34:43 -0800 (PST)
Subject: Re: [PATCH V8 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20201020085555.1554255-1-ming.lei@redhat.com>
 <cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3aa5407c-0800-2482-597b-4264781a7eac@grimberg.me>
Date:   Fri, 5 Mar 2021 14:34:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> About nvme_stop_queues need long times for large number namespaces,
> If work with multipath and one path fails, It cause wait long times
> to fail over to retry, and the more namespaces the longer the time.
> This has a great impact on delay-sensitive services.
> there are two options to fix it:
> 1. Use percpu instead of SRCU. Ming's patchset.
> 2. Use tagset quiesce interface with SRCU. Sagi's patchset.
> The two patchsets are still pending.
> 
> It is a serious bug, I expect that we can revisit the solution.
> Maybe we don't have the best option, but we need to choose a relatively
> acceptable option.
> 
> Can we fix the bug for non-blocking queues(which used by fc&rdma) first?
> 
> Sagi & Ming, what do you think?

I don't recall any outstanding concerns that I had (I think they
were all addressed). I'm fine with moving forward with it.
