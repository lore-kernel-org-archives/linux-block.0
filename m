Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA24C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 22:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B405121738
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 22:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfC0WA7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:00:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44025 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC0WA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 18:00:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id v32so20782167qtc.10
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2019 15:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tf6G0dHzadVUegGnVo8C99zV8ykJvebnEQd99I/vDps=;
        b=pjE4/GS1gDjalYZyRmEVfGrzxqyz7t18X+25UhmWA1jgHENqWmd2HB/glelOCT1wim
         rosj8wFDJ9cOoIctzYV5n7tjSqF1JFfqeeGw8uW9iZrL3Uk6ZLz4tvffVE0MZbJf4uXo
         nQ0PvDVFO0mVnt7+j/C0ROtW3JY09PxfEnZ5Vbbb01FBm9+Ii3d1BimVYk9pe2KLWusc
         PARxtf22Qj93vYES+wsgtTXpgG4KY5Kvkn1o/d/PxVNuz0z8NNuaUkhmpiAUyKLdo3El
         UG6Dsxf7VhNdYYbCY8r6sXyDDeKu0gGVmyXM3NBB/7ddxi4MDGUyithvBSeywkqW2lLJ
         jL/A==
X-Gm-Message-State: APjAAAV00sTso3/jkeGDQfyINrmGBUYpqQXi+L8ok+y/AjO1IbQXvjnN
        MQIfcdOoPG+F7VIprp56pzyNZQ==
X-Google-Smtp-Source: APXvYqwgXymfBh/T8yD5crXoPNH7gx6OT/QYIWn+sTaasp7mbOR+qlbVwkinjmonVALiniBok3c59A==
X-Received: by 2002:ac8:33dd:: with SMTP id d29mr34421294qtb.320.1553724058235;
        Wed, 27 Mar 2019 15:00:58 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:422c:9885:a6c:81b2])
        by smtp.gmail.com with ESMTPSA id i11sm11164001qkg.33.2019.03.27.15.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 15:00:57 -0700 (PDT)
Message-ID: <74e767afc0e10054f87fc821fa15966449d3dd2a.camel@redhat.com>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Laurence Oberman <loberman@redhat.com>
To:     Ming Lei <tom.leiming@gmail.com>, jianchao.w.wang@oracle.com
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 27 Mar 2019 18:00:55 -0400
In-Reply-To: <5d79ef69efecba45718c87110e8a37a37f973bea.camel@redhat.com>
References: <6e19971d315f4a3ce2cc20a1c6693f4a263a280c.camel@redhat.com>
         <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
         <1553113730.65329.60.camel@acm.org>
         <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
         <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
         <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
         <CACVXFVOfZvnDo_ccVm1+cFRo_oSoiexgLfe_pyXp84v=0eQ7rQ@mail.gmail.com>
         <38a35a9c6a74371ebaea6cdf210184b8dee4dbeb.camel@redhat.com>
         <5d79ef69efecba45718c87110e8a37a37f973bea.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-03-27 at 08:56 -0400, Laurence Oberman wrote:
> Truncating email content, starting bisect again as suggested.
> Email was getting too long with repetition.
> 
> Crux of the issue repeated here so easy to understand topic
> 
> We got to dispatch passing rq_list and the list is corrupted/freed so
> we panic. Clearly a race and is in v5.x+ kernels.
> This new bisect will find it.
> 
> crash> bt
> PID: 9191   TASK: ffff9dea0a8395c0  CPU: 1   COMMAND: "kworker/1:1H"
>  #0 [ffffa9fe0759fab0] machine_kexec at ffffffff938606cf
>  #1 [ffffa9fe0759fb08] __crash_kexec at ffffffff9393a48d
>  #2 [ffffa9fe0759fbd0] crash_kexec at ffffffff9393b659
>  #3 [ffffa9fe0759fbe8] oops_end at ffffffff93831c41
>  #4 [ffffa9fe0759fc08] no_context at ffffffff9386ecb9
>  #5 [ffffa9fe0759fcb0] do_page_fault at ffffffff93870012
>  #6 [ffffa9fe0759fce0] page_fault at ffffffff942010ee
>     [exception RIP: blk_mq_dispatch_rq_list+114]
>     RIP: ffffffff93b9f202  RSP: ffffa9fe0759fd90  RFLAGS: 00010246
>     RAX: ffff9de9c4d3bbc8  RBX: ffff9de9c4d3bbc8  RCX:
> 0000000000000004
>     RDX: 0000000000000000  RSI: ffffa9fe0759fe20  RDI:
> ffff9dea0dad87f0
>     RBP: 0000000000000000   R8: 0000000000000000   R9:
> 8080808080808080
>     R10: ffff9dea33827660  R11: ffffee9d9e097a00  R12:
> ffffa9fe0759fe20
>     R13: ffff9de9c4d3bb80  R14: 0000000000000000  R15:
> ffff9dea0dad87f0
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #7 [ffffa9fe0759fe18] blk_mq_sched_dispatch_requests at
> ffffffff93ba455c
>  #8 [ffffa9fe0759fe60] __blk_mq_run_hw_queue at ffffffff93b9e3cf
>  #9 [ffffa9fe0759fe78] process_one_work at ffffffff938b0c21
> #10 [ffffa9fe0759feb8] worker_thread at ffffffff938b18d9
> #11 [ffffa9fe0759ff10] kthread at ffffffff938b6ee8
> #12 [ffffa9fe0759ff50] ret_from_fork at ffffffff94200215
> 
Hello Jens, Jianchao
Finally made it to this one.
I will see if I can revert and test

7f556a44e61d0b62d78db9a2662a5f0daef010f2 is the first bad commit
commit 7f556a44e61d0b62d78db9a2662a5f0daef010f2
Author: Jianchao Wang <jianchao.w.wang@oracle.com>
Date:   Fri Dec 14 09:28:18 2018 +0800

    blk-mq: refactor the code of issue request directly
    
    Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
    into one interface to unify the interfaces to issue requests
    directly. The merged interface takes over the requests totally,
    it could insert, end or do nothing based on the return value of
    .queue_rq and 'bypass' parameter. Then caller needn't any other
    handling any more and then code could be cleaned up.
    
    And also the commit c616cbee ( blk-mq: punt failed direct issue
    to dispatch list ) always inserts requests to hctx dispatch list
    whenever get a BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, this is
    overkill and will harm the merging. We just need to do that for
    the requests that has been through .queue_rq. This patch also
    could fix this.
    
    Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>



