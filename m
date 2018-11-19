Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ED5C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 21:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D405F20870
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 21:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D405F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbeKTICn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:02:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36588 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbeKTICm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 03:02:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so4950562oix.3;
        Mon, 19 Nov 2018 13:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iTphMejhUWSby5xrJ39AmOiKztkMAhoN78wcfuoiFkY=;
        b=YUMutcvjxiLk9a6pQDgVz9n8DL9rwHvsW0UNZ1/vnpMB0NyBvXuDROaTAjLkER+Kk9
         VdegP43huDLcbUExQla0s8txUdQ8w7u/4R+nLXrfFIOzXWLlQMmYNlryY4QFRrvD81bU
         qMUbZXzQvVURZ0NzGIuQTY6Z/KCmhUYzT2pzjJcFT9p5U0/T8WBQ/1zKSb69DnrVK8zt
         Wl/p2r3miAvGvFlp8c9jqkPsXGd43lTjHTykEetN6rz9Q2mrKm0C0P+MeVOoigNS3DXr
         E8TdDAVliW1OyOzJ9BHAwVFR6f2X2w+1TrPHSaxiB5wFUxXEcDJ+PbCQav8l1pEyKD/0
         zBgg==
X-Gm-Message-State: AGRZ1gI/dAtw9H+gUrA3OfzqRXEw0uytxP9UnjP0AExFjSV0JFe1hBVm
        +z4sMrnWhiRF5M8osZzS2v0=
X-Google-Smtp-Source: AJdET5c4DLd0wr02dnBoqAf70QrZRYQgViQTUQQRKRB9lCAbMS5aHGuqu/Dd1V/0NPJ5/ANieCYRCA==
X-Received: by 2002:aca:af53:: with SMTP id y80mr8437417oie.170.1542663426538;
        Mon, 19 Nov 2018 13:37:06 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a201sm19859561oii.27.2018.11.19.13.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:37:05 -0800 (PST)
Subject: Re: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
To:     Max Gurtovoy <maxg@mellanox.com>,
        David Miller <davem@davemloft.net>, sagi@lightbitslabs.com
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        keith.busch@intel.com, hch@lst.de, linux-nvme@lists.infradead.org
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
 <59335e55-7e19-3201-2f8b-beb681aba810@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <97c63ee4-62b5-b083-6b2e-28acf062b0ed@grimberg.me>
Date:   Mon, 19 Nov 2018 13:37:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <59335e55-7e19-3201-2f8b-beb681aba810@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> +static unsigned nvmet_tcp_recv_budget = 8;
>>> +module_param_named(recv_budget, nvmet_tcp_recv_budget, int, S_IRUGO 
>>> | S_IWUSR);
>>> +MODULE_PARM_DESC(recv_budget, "recvs budget");
>>> +
>>> +static unsigned nvmet_tcp_send_budget = 8;
>>> +module_param_named(send_budget, nvmet_tcp_send_budget, int, S_IRUGO 
>>> | S_IWUSR);
>>> +MODULE_PARM_DESC(send_budget, "sends budget");
>>> +
>>> +static unsigned nvmet_tcp_io_work_budget = 64;
>>> +module_param_named(io_work_budget, nvmet_tcp_io_work_budget, int, 
>>> S_IRUGO | S_IWUSR);
>>> +MODULE_PARM_DESC(io_work_budget, "io work budget");
>> I strongly suggest moving away from module parameters for this stuff.
> 
> agree here.
> 
> also, Sagi, can you explain about the performance trade-offs seen during 
> your development for these values ?
> 
> are they HCA/NIC dependent ?
> 
> should send/recv ratio be 1:1 ?
> 
> should total/send/recv ratio be 8:1:1 ?

These are not really HW dependent at all, its more about the tradeoff
between aggregation vs. fairness multiplexing. The budgets are designed
to control how much a specific workload (e.g. nvme queue) can hog the
cpu/wire when nvmet is servicing a large number of hosts.

There no constraints about the ratios of the budgets. Its advised though
that the io_work_budget would be able to catch at least a few
sends/recvs for reasonable aggregation.

I commented to Dave that I prefer not to expose them at this point given
that they are not trivial and would require an additional interface to
the driver (and its corresponding tool chain).
