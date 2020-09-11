Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60E0C433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 19:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8121922208
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKTMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:12:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32996 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgIKTMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 15:12:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id c196so8256275pfc.0
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 12:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0EZdsEbsw4gysyiAKGMhLHWhQpRqzgR7hyI3NYj5RXU=;
        b=LRSNZJbYHzj0Fvh2g9x9ACTH2UQrTTqkFw5IYKnt1JnoyGESJR2HCRr+U7OX+VUblA
         iPeTXRyyh2qiID09HSdgqh+vqjHZzBf716IGwOvKk58k8hlLpD6Ioc/sKL7nTImmauPx
         7kO81Y+dEkKVr81k4tcBPcnXmyOghE9i1k2VldbgwfqC1LfEcmkr+pF8gciPB7Ic5snT
         vvl/i+piAumewFXcHsyeXFpGV/Du0isKS592YV2rOZk53JgGq4ZvgFIfERHdvGiWIa3G
         YeaEDjj6Jg0Ers1sldnsVaBigLOA9azIl4AIjdPVkKYc5edGsMeVkLWW2yDN8Gzafb+r
         aOhA==
X-Gm-Message-State: AOAM533n8asWKPMijyifguNiLfDtHQW+ZE+YyIjOySqo5vQy/Cih0MhQ
        2cu3+KBzJhtQVFDxOlfdTPY=
X-Google-Smtp-Source: ABdhPJwagpZDui+DFScg0zjWY4rW/dHBBpm2xj5uUcagDXDgwN9y1ye1szOhTd/Wr0bLY1mbXSsVYw==
X-Received: by 2002:aa7:8756:: with SMTP id g22mr3462404pfo.37.1599851559621;
        Fri, 11 Sep 2020 12:12:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4428:73d8:a159:7fcc? ([2601:647:4802:9070:4428:73d8:a159:7fcc])
        by smtp.gmail.com with ESMTPSA id i62sm3030204pfe.140.2020.09.11.12.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:12:38 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <8bb90a44-c088-9b10-8665-ec083063e49c@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e517d3c4-86de-95bd-2013-d59eb48ba789@grimberg.me>
Date:   Fri, 11 Sep 2020 12:12:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8bb90a44-c088-9b10-8665-ec083063e49c@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Hi Jens,
>>
>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>> and prepares for replacing srcu with percpu_ref.
>>
>> The 2nd patch replaces srcu with percpu_ref.
>>
>> The 3rd patch adds tagset quiesce interface.
>>
>> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> What is this series against?

It didn't apply cleanly to me too until I realized it is
on top of v4 of: "percpu_ref & block: reduce memory footprint of 
percpu_ref in fast path"
