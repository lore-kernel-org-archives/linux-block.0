Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2831C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 21:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJUVMQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJUVMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 17:12:15 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B129CBB1
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 14:12:14 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id pq16so3481838pjb.2
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 14:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pcjz87d34ZLL9ZZDYHNrEVpvA2PEjvPMwiSpgcT6SWQ=;
        b=pubr/h3Ec4P1qa0h/KQK/ZLjxaeRUNKLfrganJ2nwTfWmzXXAOuV08aT8BK14zjgji
         ZXCpwsUqpjr2mnISJzfJWvua/5lcF5d9LR5uzdVMjuhzduqNoBQObk6AfNqib4h5zLlB
         FCAhBdoRHSVkUrEoef8hVH2/7URRwo2Zlme4louYHotUWqlTkqQBNd7RQ7+1PpF/vk/m
         xwDMVNfPSTcOQ3BNnSQcrhDP6hqv1UpTIGGh05NJekZ313WGCYfTe4Q23N/CaAzyxGAR
         AR07wq08h9UFGQyGosOsdyMb13Opv3xOTNOlsmQJL4sJXhNbkZ4XiY+4cRfy1kgGkDpE
         wfdA==
X-Gm-Message-State: ACrzQf2WCuU9j2HnJ+elYWNBNgGAQp6sHHQdaULj3u/3G0dxXDFKjyJA
        pfmHZ/BXfu3DnumE4Q8lJ20=
X-Google-Smtp-Source: AMsMyM6yHva/jmanLq8t+P2Y5eaV6hJ0WMqvjtEOki7lZBwAN/QENndu8aDK5QJqKK9mzOdmphwsJw==
X-Received: by 2002:a17:902:778f:b0:17f:8347:ff83 with SMTP id o15-20020a170902778f00b0017f8347ff83mr20721524pll.146.1666386734082;
        Fri, 21 Oct 2022 14:12:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3bff:84a:36de:737? ([2620:15c:211:201:3bff:84a:36de:737])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ab30b00b00202618f0df4sm278032pjr.0.2022.10.21.14.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:12:13 -0700 (PDT)
Message-ID: <a954e484-af67-d41e-38f2-843a945d1de2@acm.org>
Date:   Fri, 21 Oct 2022 14:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221020105608.1581940-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 03:56, Christoph Hellwig wrote:
> +	/* stop buffered writers from dirtying pages that can't written out */

Hi Christoph,

If this series is reposted, please insert the missing verb "be" in the 
above comment.

Thanks,

Bart.
