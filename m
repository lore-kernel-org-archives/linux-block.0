Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFC7C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 21:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790982080C
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 21:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790982080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeKTHvs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:51:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44389 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbeKTHvs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 02:51:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id z33so29016929otz.11;
        Mon, 19 Nov 2018 13:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c6q4gjbS1bwuOR6TdRN+udHcQwqtlDLHgcmIh4g7aUc=;
        b=R5Q+La7E25JZGQyWWksltUCb1XJa4YYejY8zXEwzjasxgmoSkJ+0UTvKgZA0gE8zxS
         21Ywr9rfWpKWvBxxqhN72ObGOZyYPS0fjDh5SMvUZDecUlydbLpvzFKJx+jw5dQUkVaU
         RRiTYQsYHspjyYq9HQM6u5XzC5/b2pXexzAxs5P5BaSHpuNACJZnVjC28SAvb+lndQWj
         0K81c8fg/ILJ6K19alsgVgxiGk98LcS7LZTOVUjiRiJOTjXpF3+5FORKKsEjjw4w0ZJs
         OgsBOQWP96ERRncammV0U20TLxZFGUCTTvuWe3j8Ii/evhIGvEtvvfkkxDBVJzQmvP/j
         7DAQ==
X-Gm-Message-State: AGRZ1gJgJrZ77CHqaQhyvoNMMs2w3JTFHXeGnCuaPTdt9MsVpRV8nn0d
        R3tXdqvLVotxVIKwcpJ43Gk=
X-Google-Smtp-Source: AJdET5cnV1nC9iihjzsEOxYXHNz8F+drBKFtstHghTQwNebZnPdPTVO4l5sWi/79WG91xPTxJwv23A==
X-Received: by 2002:a9d:30d4:: with SMTP id r20mr14600741otg.277.1542662775240;
        Mon, 19 Nov 2018 13:26:15 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id w62sm6154267oiw.34.2018.11.19.13.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:26:14 -0800 (PST)
Subject: Re: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
To:     David Miller <davem@davemloft.net>, sagi@lightbitslabs.com
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        keith.busch@intel.com, hch@lst.de, linux-nvme@lists.infradead.org
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>
Date:   Mon, 19 Nov 2018 13:26:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181117.121510.1754018619653365187.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +static unsigned nvmet_tcp_recv_budget = 8;
>> +module_param_named(recv_budget, nvmet_tcp_recv_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(recv_budget, "recvs budget");
>> +
>> +static unsigned nvmet_tcp_send_budget = 8;
>> +module_param_named(send_budget, nvmet_tcp_send_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(send_budget, "sends budget");
>> +
>> +static unsigned nvmet_tcp_io_work_budget = 64;
>> +module_param_named(io_work_budget, nvmet_tcp_io_work_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(io_work_budget, "io work budget");
> 
> I strongly suggest moving away from module parameters for this stuff.
> 
> Create a genetlink socket family and allow run time configuration of these knobs
> by the user.

Thanks for the feedback Dave.

Given that these are non-trivial knobs to configure at runtime, I think
that I'll degenerate them to sane defaults for the initial submission
and figure out what interface makes sense afterwards.

Now that I have your attention ;)
I would love you to look at skb_copy_and_hash_datagram_iter as these
changes will require an ack from you.
