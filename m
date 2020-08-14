Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83344C433DF
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF5B20771
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 20:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgHNUpW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:45:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36117 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgHNUpW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 16:45:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id m8so5128029pfh.3
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2020 13:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pmkh8BPJsGYU0dWtb4D8/FWMc/a6NOcENQVLZIHuvPY=;
        b=MpxPqDFauXOe3JVf9rnZMqcxfGBVzsyqElOVc4YihBl+YCECIMU4bCJHGE8HM6L8lg
         tX+rdGI7xpEUrQvvBKau4LVRxKWcOMeBvgd3eMWkrS0Y3+8tbWzbthpAprYb3bNPKJJ0
         IPJ6mP3AOPMELs6qPbbhc2rkCdVkz7Sx4y3eA3vbKM4x1LklRPEPL65R6ZXYbUSChPEd
         E3Rpqp1yw+uHPeGW5yqtQwXd19BIB4DudXdY3Bf/my9LMgWcCnUb+iCnVC+BfeY59wN4
         rxDKfX0+vfxo/LlS9IqR6CXJhmRlRl4g3+SfMV/g1jQ/dTlqZ8OgnLqzo1xxCKip3IFL
         WinA==
X-Gm-Message-State: AOAM532eNtwrve+VheRDvNpSdFn1pxKhBTCn+geEwgE+rCzeGLLmUtfi
        EgTKsUyj5blRHGwYFl7bxkyJRpmPbEzPpw==
X-Google-Smtp-Source: ABdhPJz5fPJt8+qdOEqEqPiQpAN3SlE9t5zf/ZATPSZg9bXmFMNeWdKzve49feAFopd7kfAkfxMGMQ==
X-Received: by 2002:a62:aa07:: with SMTP id e7mr2972987pff.71.1597437921644;
        Fri, 14 Aug 2020 13:45:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f? ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id y65sm9987836pfb.155.2020.08.14.13.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 13:45:21 -0700 (PDT)
Subject: Re: [PATCH v4 7/7] nvme: support rdma transport type
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-8-sagi@grimberg.me>
 <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
 <af7154de-f2bb-fde6-4c6c-243711f971cb@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1d211ba1-c791-54b8-6811-b159a8a2868b@grimberg.me>
Date:   Fri, 14 Aug 2020 13:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <af7154de-f2bb-fde6-4c6c-243711f971cb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> @@ -124,6 +134,11 @@ _setup_nvmet() {
>>>           modprobe nvmet-${nvme_trtype}
>>>       fi
>>>       modprobe nvme-${nvme_trtype}
>>> +    if [[ "${nvme_trtype}" == "rdma" ]]; then
>>> +        start_soft_rdma
>>> +        rdma_intfs=$(rdma_network_interfaces)
>>> +        def_traddr=$(get_ipv4_addr ${rdma_intfs[0]})
> The first rdma_intfs here maybe have DOWN state, which doesn't have an 
> addr[1], I found similar check code here[2]
> [1]
> # echo $rdma_intfs
> rdma_intfs:eno1
> eno2
> eno3
> eno4
> eno49
> eno50
> # [root@hpe-dl380gen9-01 blktests]# ip a s
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
> group default qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>      inet 127.0.0.1/8 scope host lo
>         valid_lft forever preferred_lft forever
>      inet6 ::1/128 scope host
>         valid_lft forever preferred_lft forever
> 2: eno1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state 
> DOWN group default qlen 1000
>      link/ether 3c:a8:2a:21:7d:a4 brd ff:ff:ff:ff:ff:ff
> 3: eno49: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP 
> group default qlen 1000
>      link/ether 8c:dc:d4:1e:7a:78 brd ff:ff:ff:ff:ff:ff
>      inet 10.16.203.27/24 brd 10.16.203.255 scope global dynamic 
> noprefixroute eno49
>         valid_lft 84814sec preferred_lft 84814sec
>      inet6 2620:52:0:10cb:8edc:d4ff:fe1e:7a78/64 scope global dynamic 
> noprefixroute
>         valid_lft 2591978sec preferred_lft 604778sec
>      inet6 fe80::8edc:d4ff:fe1e:7a78/64 scope link noprefixroute
>         valid_lft forever preferred_lft forever
> [2]
> # grep -rin rdma_network_ tests/nvmeof-mp/
> tests/nvmeof-mp/rc:93:        for i in $(rdma_network_interfaces); do
> tests/nvmeof-mp/rc:235:        ) && for i in $(rdma_network_interfaces); do

This is annoying, I wish it would just work on the lo interface but it
doesn't for some reason...
