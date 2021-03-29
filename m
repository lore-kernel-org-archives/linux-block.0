Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910FEC433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 01:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501986146B
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 01:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhC2Bd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Mar 2021 21:33:28 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:34454 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhC2BdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Mar 2021 21:33:20 -0400
Received: by mail-pg1-f178.google.com with SMTP id i6so1239186pgs.1
        for <linux-block@vger.kernel.org>; Sun, 28 Mar 2021 18:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MOJf8hKhe/Ue0c4xf4oxRzQ+S8na3cKxiLXrfqEaMsE=;
        b=XgV7sDV9YLUARnL9Gpp+YryL13wiw6YMR0I3Vb1Tgt7vRCBXLMpHbCOpLJL0r6LtpW
         +Rll2WATWIuu0pc5LeynEpNMeXzACdvJo1yCFnSx+9MR61X3Qi97N1pt8sVPjIYlYvT3
         DfmJC4NPet/UI7l1VtwvDeLG4VA3W9bVuS1MTsTOtEni0MuG5fAXNpYcnT/wLoIETO+V
         vrW7eAvFhXbspjtFIjMfdvsSnrwBW9xXjoWREPE0kiBWl9FL8psvpZaygddaIxbYBA1D
         ma1ZJWk1zIuYwhDU/qte92/rbbCkhdiFMzCOxajsChJBdpupGVPmXqBDz9H/nJIxWGSv
         hkoA==
X-Gm-Message-State: AOAM533vemuY+1h7Y37H3iQI1qve5sbfQ7cPnKyRMuJ12130v8YRVOa7
        aut/+Tgl/G+/FQ5hwJr/59UH4hQf0Ec=
X-Google-Smtp-Source: ABdhPJw1Mkd5u8Sr+PXaLo2ECk2OPT8deqv3QzdSvgOTgoDGjhRqvhrRBzqX5l3Q1t7Izrec3yqfqA==
X-Received: by 2002:a63:5c1e:: with SMTP id q30mr21323745pgb.259.1616981599881;
        Sun, 28 Mar 2021 18:33:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7123:9470:fec5:1a3a? ([2601:647:4000:d7:7123:9470:fec5:1a3a])
        by smtp.gmail.com with ESMTPSA id 76sm15892419pfw.156.2021.03.28.18.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 18:33:18 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
References: <20210326022919.19638-1-bvanassche@acm.org>
 <20210326022919.19638-4-bvanassche@acm.org>
 <20210326084456.tymobjbpy2oh7vx3@shindev.dhcp.fujisawa.hgst.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4453d38d-3369-f32a-dd21-0c5899c02211@acm.org>
Date:   Sun, 28 Mar 2021 18:33:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210326084456.tymobjbpy2oh7vx3@shindev.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/21 1:44 AM, Shinichiro Kawasaki wrote:
> I applied this series on v5.12-rc4 and ran blktests block/005 with a HDD behind
> SAS-HBA, and I observed kernel INFO and WARNING [1]. It looks like that
> tags->iter_rwsem is not initialized. I found blk_mq_init_tags() has two paths
> to "return tags". I think when blk_mq_init_tags() returns at the first path to
> "return tags", tags->iter_rwsem misses the initialization. To confirm it, I
> moved the init_rwsem() before the first "return tags", then saw the kernel
> messages disappeared (use-after-free disappeared also).

Hi Shinichiro,

Thanks for the quick feedback. I agree with your analysis and will fix
this in v4 of this patch series.

Bart.
