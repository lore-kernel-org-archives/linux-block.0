Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B4DC433E6
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384436507B
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhCPOdT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbhCPOcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 10:32:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA18C06174A
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 07:32:46 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e7so12835673ile.7
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AIXKXn4V6KkoJZ6335EhpGbuiRlD0jFB/a1rrupY8QM=;
        b=cS1JmGn2rJptT7YQqIPEEOI22LChvn9/DXBR5sv6XUdPsVLnxaBVrLAld78wHmFJty
         pP1yYsm98NhR5taOI6AwDi+LZvKNNTpZgn1LnC72j0z7wz8MPLtH3kgvHRnmFkwYbpfg
         PhmVY7BnxVmwY0yKETWF2UtqyGp+C7VWLGrNVuE0gJSTeqWAV8tlEyZZVIJ13oo3vemZ
         BrgbA5+FBgDbaiBDYWJsFPv7i9RQWvtHg5d5cEZ9JY/ctFzaUNoXMjK/jwyHvhcKvNlT
         29FGUC0OZ508cPKL4HOZ695yznjPlnwWBNys5f49Fg6dCIRer9riCUVzYPFdbl2KWld4
         1QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AIXKXn4V6KkoJZ6335EhpGbuiRlD0jFB/a1rrupY8QM=;
        b=Vgew2Up7Gqagjmn7N8WaUx76Jly2suMwfhsDda/NXtms2aS/o1lvX6XdEg9ypusk95
         a9dQ3IKD1dwTmBWDf7Cwedb50yNrZJSPIAAyx6DkswJF7aOUVCSdcrE/kXYv+ktiM/rb
         8WBs/Rq7QChA86rLkMHHtwgHXCpg4NIDnzizBuqaH90jHNrK67bjtDobSQNVrlVzWsky
         68IdOCq3iGl4kWTkH8SYFhrTdKRNNbjRt33Hho5TU6s+bpH6w1/Wma93PVyyIIGkv/ok
         t1DZnLuoXBODEFhJqcuvq9skhDnkDqIE6aBzIBRLX5yWAM8wvEvnjhcdl4gnmGBSLTv5
         0Wqw==
X-Gm-Message-State: AOAM533FDc5fbXC3bvze/r+T6PvDtY/EX1/HOwoinl0K0jZXQqqTUJya
        PVqsVA+BAv8eCOgwTI9xdapFow==
X-Google-Smtp-Source: ABdhPJxl4tkgFxLgyMgFP9Z257Azxecrh39URoO9Ci+5LcDSRsR4IX+GtbDUC53HzZqFnsVW2kRrfA==
X-Received: by 2002:a05:6e02:968:: with SMTP id q8mr4215049ilt.31.1615905165655;
        Tue, 16 Mar 2021 07:32:45 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k10sm8593938iop.42.2021.03.16.07.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 07:32:45 -0700 (PDT)
Subject: Re: [PATCH] sbitmap: Fix sbitmap_put()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Omar Sandoval <osandov@fb.com>
References: <20210316035420.2584-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b578af4d-2a2b-375c-396e-2ad57f6e579e@kernel.dk>
Date:   Tue, 16 Mar 2021 08:32:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316035420.2584-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/21 9:54 PM, Bart Van Assche wrote:
> This patch fixes the following kernel warning:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: scsi_eh_0/152
> caller is debug_smp_processor_id+0x17/0x20
> CPU: 1 PID: 152 Comm: scsi_eh_0 Tainted: G        W         5.12.0-rc1-dbg+ #6
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack+0xaf/0xf3
>  check_preemption_disabled+0xce/0xd0
>  debug_smp_processor_id+0x17/0x20
>  scsi_device_unbusy+0x13a/0x1c0 [scsi_mod]
>  scsi_finish_command+0x4d/0x290 [scsi_mod]
>  scsi_eh_flush_done_q+0x1e7/0x280 [scsi_mod]
>  ata_scsi_port_error_handler+0x592/0x750 [libata]
>  ata_scsi_error+0x1a0/0x1f0 [libata]
>  scsi_error_handler+0x19e/0x330 [scsi_mod]
>  kthread+0x222/0x250
>  ret_from_fork+0x1f/0x30

It'd be nice to have a bit of a description in here on what is being
fixed, eg that we're preemptible and cannot safely use this_cpu_ptr(),
and why that it's OK to use raw_cpu_ptr() instead for this particular
application.

-- 
Jens Axboe

