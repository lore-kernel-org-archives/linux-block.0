Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D391BC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E5A2087C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfCNVnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:43:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35891 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfCNVnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 17:43:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id r124so4895472pgr.3
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 14:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Smdn6NZXayT8Pz0ThM9EfLXn0yojkYIVnasoTWBhfxI=;
        b=W+pzc+uo60GMVl7e4bxbzOJu0f4NBY5x7jTghoRYq1G6urw2mRqO+IgXvVse5/KQ7B
         N/5vVxbOFDHcLXNzSmAN+Zg3KN85627svfdN9TAw3evfmRZoYaZznM9Nw0jM78cl7JQn
         El9ThiWkdnSUrAfzbI/VZ6jQn8N2E7mcDfZS/hBAf3VbdpAxZ6QCW34iyz7+IbzuukjW
         WwZhHjpjvVnIEU+ZcwwCcFJzglYwjoYAOYR+lAHG1Z5QttgG2s9XYVFnKAo/Upf7SNER
         yL9K/iaWBchpA+KO4UBeR6IP7kwpx3AWDQBfujAtz+Uz030QPDz6UvsDg91ZdgkD8BvV
         nYRQ==
X-Gm-Message-State: APjAAAW3MyKCsoK9VCiMq3+4m43+oALQAgtpkOwgunqv40FEEjC2+wzN
        Ld/JSfLnZK8IgblCe1X4ARc=
X-Google-Smtp-Source: APXvYqyWaKD/8RY3Sz89W4Qg94eCHflth+K8TGDbeFS7crcAKMWHKaRVWvTV/ayDVBx+rbWrFQCnjA==
X-Received: by 2002:a63:c26:: with SMTP id b38mr84387pgl.382.1552599829728;
        Thu, 14 Mar 2019 14:43:49 -0700 (PDT)
Received: from [10.80.2.71] ([209.37.102.131])
        by smtp.gmail.com with ESMTPSA id 23sm92661pfn.2.2019.03.14.14.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:43:48 -0700 (PDT)
Subject: Re: [PATCH 07/17] nvme-fc: use nr_phys_segments to determine
 existence of sgl
To:     Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20190313175510.20725-1-hch@lst.de>
 <20190313175510.20725-8-hch@lst.de>
 <a488077e-d68e-a388-4d45-5b966f01f96e@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <543489d1-a08f-e293-2212-57156e7ba407@grimberg.me>
Date:   Thu, 14 Mar 2019 14:43:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a488077e-d68e-a388-4d45-5b966f01f96e@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> From: James Smart <jsmart2021@gmail.com>
>>
>> For some nvme command, when issued by the nvme core layer, there
>> is an internal buffer which can cause blk_rq_payload_bytes() to
>> return a non-zero value yet there is no actual/real command payload
>> and sg list.  An example is the WRITE ZEROES command.
>>
>> To address this, when making choices on whether to dma map an sgl,
>> use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes().
>> When there is a sgl, blk_rq_payload_bytes() will return the amount
>> of data to be transferred by the sgl.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> Signed-off-by: James Smart <jsmart2021@gmail.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> 
> I guess we'll need it for all transport.
> 
> I saw that pci is covered, RDMA isn't.

RDMA patch is already in AFAIR...

> Also IMO tcp should be fixed (didn't dive into it yet, just high level 
> check for blk_rq_payload_bytes).

tcp already looks into RQF_SPECIAL_PAYLOAD so the issue does not apply 
to it.
