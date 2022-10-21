Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFFEC433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 21:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJUVW5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJUVW4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 17:22:56 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14A17E17
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 14:22:53 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id h185so3616868pgc.10
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 14:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oL1rxmsbULnQ7bVykV93AVdpvYDqMSKfMYqBHBTEVB8=;
        b=K7brStnpv5YW3gT731/S1z7vhxjn2tINcR6IzoxKoG5R+nh8sC1kXmBdtBATNQRBe2
         W0K8D1AhU130dSIDxTkwFsDsGhtyVdBX3DLy6d/7mhbcEEEFMHYKn/xGFT1O55rSLaoh
         VNfWyU+fUJxB27jXQekCSbi0fxnfkvcybgFShE8JKNGy39vBYl1MpjLiv8TTp2jmuDC+
         FIVOt1gmQd0j/+RfEG/sjnsE7rCuprpkjEyg2jJJkaRtVwsS/BrntTOzH7ZXHo9J7MEC
         HgcxnmqAZUWGPBgvVs6Ln8vqh/sOWqfzgd4r+LJQQgn1O444AXDubP5el5ygLlYPeF/1
         y0jA==
X-Gm-Message-State: ACrzQf2mk0sAE3NQpNpyMrh+jdivf20EtpEH0+AA0BokTrcJ6AelmTjC
        8ymN8WdsQImsR0iLhGcXvsQ=
X-Google-Smtp-Source: AMsMyM6srn2f9RgF906preCFswu5M5dN4aBh3C9WcyEJiG+QF7I4ae8DFMhHWv1JHUtUkGMPrWo3tQ==
X-Received: by 2002:a63:1162:0:b0:450:a0e9:c996 with SMTP id 34-20020a631162000000b00450a0e9c996mr17666933pgr.140.1666387373324;
        Fri, 21 Oct 2022 14:22:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3bff:84a:36de:737? ([2620:15c:211:201:3bff:84a:36de:737])
        by smtp.gmail.com with ESMTPSA id nt14-20020a17090b248e00b0020a0571b354sm1930147pjb.57.2022.10.21.14.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:22:52 -0700 (PDT)
Message-ID: <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
Date:   Fri, 21 Oct 2022 14:22:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221020105608.1581940-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 03:56, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> Drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an
> interface to quiesce all the queues on a given tagset. This interface is
> useful because it can speedup the quiesce by doing it in parallel.
> 
> Because some queues should not need to be quiesced(e.g. nvme connect_q)

should not need -> do not have

> when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to

quiesce -> quiescing

. So -> ,

> tagset quiesce interface to skip the queue.

Hi Christoph,

Are there any drivers that may call blk_mq_quiesce_tagset() concurrently 
from two different threads? blk_mq_quiesce_queue() supports this but 
blk_mq_quiesce_tagset() cannot support this because of the mechanism 
used to mark request queues that should be skipped (queue flag).

Thanks,

Bart.
