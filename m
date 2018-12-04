Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38418C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03F42082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03F42082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeLDRS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:18:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42558 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLDRS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:18:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so8527918pfr.9
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+mgy4unuJ1juyyL51JBLvu9CSAb4d1ApDRGi/24h5D0=;
        b=dBbY/LTgJL3oPmoliuH9OsCO8gHtwftyll1nGo5y3XLusId7ZNg0vvNja/o3cQLKm0
         VGVG5vf4ye11guo2l8Qa6fUgYj1jo6IfKTbc8c8TjxFUJbDvyWnWFckFAr/ip1BsGixR
         i760xoCKdHyP7/ntMFtirmtgF2+aNTK/jcEA9RLe4V5/r7fEIEi0quLgkUO4NjglImvZ
         NzTUeXtqMWl8pGQ0kvz8vBSUNcmSYCd5SC3cOTGqv1uy/7BT3JEVJY8wp9Groeb3jVn7
         Ytfu11bKZ1w0mtgo47icRxqsC5fp+k9llcEKQP3guAmbSmeTa9A703s6wLnJ0rVHYFbG
         KBrg==
X-Gm-Message-State: AA+aEWaCJ+FuRXhWNc+Wz1KXaSkqruLJBzSImyqZh5fbx0e1uIM8/J2/
        iSDIFBvLYLGfxQWsWfg07QQgMAKi
X-Google-Smtp-Source: AFSGD/XW17bw7WbyG+RbrFRWCLFgvKEHLS1xCngOVIPHvxKsdtMWq17f9rxJiQUpGLVUqZkbsXImgA==
X-Received: by 2002:a62:b80a:: with SMTP id p10mr20808671pfe.32.1543943905193;
        Tue, 04 Dec 2018 09:18:25 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id c13sm24695817pfo.121.2018.12.04.09.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:18:24 -0800 (PST)
Subject: Re: [PATCH 10/13] nvme-mpath: remove I/O polling support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-11-hch@lst.de>
 <f62ed781-28cd-dae0-f3aa-544d75cdc4fc@grimberg.me>
 <20181204150729.GD3630@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <76b2d640-aba6-3869-4420-8c09b8e2ea77@grimberg.me>
Date:   Tue, 4 Dec 2018 09:18:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204150729.GD3630@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> If it really becomes an issue we
>>> should rework the nvme code to also skip the multipath code for any
>>> private namespace, even if that could mean some trouble when rescanning.
>>>
>>
>> This requires some explanation? skip the multipath code how?
> 
> We currently always go through the multipath node as long the the
> controller is multipath capable.  If we care about e.g. polling
> on a private namespace on a dual ported U.2 drive we'd have to make
> sure we don't go through the multipath device node for private namespaces
> that can only have one path, but only for shared namespaces.

But we'd still use the multipath node for shared namespaces (and also
polling if needed). I agree that private namespaces can skip the
multipath node.
