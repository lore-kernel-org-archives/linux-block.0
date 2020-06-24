Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ED0C433E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 21:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16FD20768
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 21:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbgFXVRc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:17:32 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35321 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbgFXVRc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 17:17:32 -0400
Received: by mail-pj1-f66.google.com with SMTP id i4so1788201pjd.0
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 14:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b1eB2sGqcQ7HKCpKRxwDHuRLdFhJipYSwNVv0yPPktc=;
        b=PwVIrLsl0aKlAODDoZc26psqhN6Advw27t0eHPG1H226uvxr0sEqdaL1fMO40WCOYR
         o3elc06PnDNgbPtFFLk5/XTW2PYPbnvZ1zjWvAW9L4f5SW8vKTioxgRnuYVikQJi85Ea
         Ab7QN8Ek96XFbXBJR512DDLTs4bPgCf9HkzUqnipfWRnmcahYmBP/GxqH5A5AvQDot0V
         Bz/o7YAF+YB+2ANhAcUKTp6utyMe+rjrqeaA41A1zdjQ5RLRVkGGPPNHeeXWJG44pna+
         Zz9xDzUg7kfiiKy9lxAJ/EfWOKzVH3vSyXN8YF/rE+o2I1hpGC50KI9/rn6TChbC1qKf
         jGGA==
X-Gm-Message-State: AOAM5337bSTouQW/3LjmHo0rt5b1oxAT/98tzNJgza4d2Q83omSoLpsd
        FsvGVUJzo6M5yogV2qC5+3s=
X-Google-Smtp-Source: ABdhPJyvOZ+gNSwE9W6wjgbV5Ulm7M7kvGUqhvu1vYxNZ4gb99nzBXiuQaRWkWhbGCeN4qeCI8hv1g==
X-Received: by 2002:a17:90b:347:: with SMTP id fh7mr30484013pjb.64.1593033451134;
        Wed, 24 Jun 2020 14:17:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947? ([2601:647:4802:9070:4c08:474f:e61d:6947])
        by smtp.gmail.com with ESMTPSA id k2sm17788780pgm.11.2020.06.24.14.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 14:17:30 -0700 (PDT)
Subject: Re: [PATCH V5 0/6] blk-mq: support batching dispatch from scheduler
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20200603094337.2064181-1-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4c5d8c1b-2b5a-1bee-b5eb-5f4b7336b979@grimberg.me>
Date:   Wed, 24 Jun 2020 14:17:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603094337.2064181-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hi Jens,
> 
> More and more drivers want to get batching requests queued from
> block layer, such as mmc[1], and tcp based storage drivers[2]. Also
> current in-tree users have virtio-scsi, virtio-blk and nvme.
> 
> For none, we already support batching dispatch.
> 
> But for io scheduler, every time we just take one request from scheduler
> and pass the single request to blk_mq_dispatch_rq_list(). This way makes
> batching dispatch not possible when io scheduler is applied. One reason
> is that we don't want to hurt sequential IO performance, becasue IO
> merge chance is reduced if more requests are dequeued from scheduler
> queue.
> 
> Tries to start the support by dequeuing more requests from scheduler
> if budget is enough and device isn't busy.
> 
> Simple fio test over virtio-scsi shows IO can get improved by 5~10%.
> 
> Baolin has tested previous versions and found performance on MMC can be improved.
> 
> Patch 1 ~ 4 are improvement and cleanup, which can't applied without
> supporting batching dispatch.
> 
> Patch 5 ~ 6 starts to support batching dispatch from scheduler.
> 
> 
> 
> [1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
> [2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/
> 
> V5:
> 	- code style changes suggested by Damien
> 
> V4:
> 	- fix releasing budgets and avoids IO hang(5/6)
> 	- dispatch more batches if the device can accept more(6/6)
> 	- verified by running more tests
> 
> V3:
> 	- add reviewed-by tag
> 	- fix one typo
> 	- fix one budget leak issue in case that .queue_rq returned *_RESOURCE in 5/6
> 
> V2:
> 	- remove 'got_budget' from blk_mq_dispatch_rq_list
> 	- drop patch for getting driver tag & handling partial dispatch

Hey Ming,

What ever happened to this one?
