Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2015BC48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D80613D1
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 16:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFRQar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:30:47 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:36795 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhFRQap (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 12:30:45 -0400
Received: by mail-pj1-f52.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so8400217pjn.1
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 09:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TB+xd/WSxZWnsyjLccyCtcyMdeVU3FmRMO9NcLh7oSI=;
        b=mjauJzjpEMoe7DBi/lNsvLvV9TUcglwl/niREy5bj181s4nWE/IZ5GtKbdhRC4/8XG
         1GyQlVvw1XeQJArbuyxjva9Fo9YzEaT6VzIbvzxMH3hvKIZnjnmeLVhhfcEmigRA5NEc
         tUao0Bgdt598IejjZ0yfiSQVw8/gaWfgKOA/C+8IgyTBPZ2LmaAKAUM/4/Kgnab9QC9J
         3SVDgMsj/vGn+U0yQ5l2h2rwR1CM+iPwjJkLUDfHtUBRoEmHaaasUhoHTYJPPelWbYO9
         jb3zoyeon67kPlDLJUZVxZbu0EMgPVN7mNlWZsLdTAZaIbj/7fGs8VoADMPqpk4FqPRS
         smig==
X-Gm-Message-State: AOAM531JBBoIw8yM9HQIEyJuq5NZZh5CAV894zpy1ga4+5Vlg30ar7Cg
        s7uweZxqA67Ypcyba1u9JlushLYX/wA=
X-Google-Smtp-Source: ABdhPJx8xJk0pyrUmp3c9d3CE3urnXi4OEDnwa8uTh1revbxGCdn1GDsiQuRZsIyRiREzVx0SVpy1g==
X-Received: by 2002:a17:902:c24d:b029:121:db3a:5088 with SMTP id 13-20020a170902c24db0290121db3a5088mr2407050plg.27.1624033715752;
        Fri, 18 Jun 2021 09:28:35 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id g8sm8527824pfu.177.2021.06.18.09.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 09:28:35 -0700 (PDT)
Subject: Re: [PATCH] block: Remove unnecessary elevator operation checks
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20210618015922.713999-1-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <754f929e-1d72-591c-70c8-836a45940652@acm.org>
Date:   Fri, 18 Jun 2021 09:28:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618015922.713999-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/21 6:59 PM, Damien Le Moal wrote:
> The insert_requests and dispatch_request elevator operations are
> mandatory for the correct execution of an elevator, and all implemented
> elevators (bfq, kyber and mq-deadline) implement them. As a result,
> there is no need to check for these operations before calling them when
> a queue has an elevator set. This simplifies the code in
> __blk_mq_sched_dispatch_requests() and blk_mq_sched_insert_request().
> 
> To avoid out-of-tree elevators to crash the kernel in case of bad
> implementation, add a check in elv_register() to verify that these
> operations are implemented.
> 
> A small, probably not significant, IOPS improvement of 0.1% is observed
> with this patch applied (4.117 MIOPS to 4.123 MIOPS, average of 20 fio
> runs doing 4K random direct reads with psync and 32 jobs).

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
