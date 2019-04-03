Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D07FC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 21:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13999206DD
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 21:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDCVyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:54:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33836 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCVyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 17:54:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so258890pfd.1;
        Wed, 03 Apr 2019 14:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAsKgmq9qCo9UwwC8EfJkUV6JRIXspayCAP6lYILkJU=;
        b=Z/Yzg1uDRZuGhf3Rv7m8rKQKEcYTicqngxys409tWXeFmIqvr6bJVQYV8hk6uGRKEm
         uFeaDaC3Dlh7cSFkDi+if58r/Pp0w4jQBzQ99C0nM1nlIPGl/VFzSwcJ9S2haykkWlzP
         AsT3mscCL/68XdtKyi5f2tkiug9jsSVq+C7u4qjvOUZQ6YDnwbSRQk374eyIhsUWLeOh
         ZikuZ1/2GAZTFbv0hh6JIsFDzlRZtKzAkngsza9wyjYLm45DL9JzWNa3MPPIrlB9aqCg
         67tGmVZjYajKTjinwx7sUkFqWE3EwXlMVXHZLQARKt1+o+BMn0dLPjp6EuvHGTTjiAdi
         IkBg==
X-Gm-Message-State: APjAAAWLu0eA2YpvkZ9PVR0eYh85FSKSXkV31CNr6ytojlVTYO18ZHAT
        2y1EDIqyngAKqpMuS6EEZsmlfsj5BH0=
X-Google-Smtp-Source: APXvYqwSLSP+FOG10asbLp38x2jp2ODFGLlq0NDb6Xa/cO13soszMdW1vhmTrLZ5ZhiLMsUx0W5ssA==
X-Received: by 2002:a63:9a4a:: with SMTP id e10mr2047769pgo.366.1554328461947;
        Wed, 03 Apr 2019 14:54:21 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id t24sm16229246pfe.110.2019.04.03.14.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 14:54:21 -0700 (PDT)
Message-ID: <1554328459.118779.236.camel@acm.org>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Bart Van Assche <bvanassche@acm.org>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Laurence Oberman <loberman@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>, jianchao.w.wang@oracle.com
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 03 Apr 2019 14:54:19 -0700
In-Reply-To: <71cb067b-2267-c151-dbdc-a21f78d5fb0c@grimberg.me>
References: <6e19971d315f4a3ce2cc20a1c6693f4a263a280c.camel@redhat.com>
         <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
         <1553113730.65329.60.camel@acm.org>
         <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
         <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
         <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
         <CACVXFVOfZvnDo_ccVm1+cFRo_oSoiexgLfe_pyXp84v=0eQ7rQ@mail.gmail.com>
         <38a35a9c6a74371ebaea6cdf210184b8dee4dbeb.camel@redhat.com>
         <5d79ef69efecba45718c87110e8a37a37f973bea.camel@redhat.com>
         <74e767afc0e10054f87fc821fa15966449d3dd2a.camel@redhat.com>
         <1554313972.118779.233.camel@acm.org>
         <71cb067b-2267-c151-dbdc-a21f78d5fb0c@grimberg.me>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 14:47 -0700, Sagi Grimberg wrote:
+AD4 +AD4 I have not been able to reproduce this issue. But you may want to try
+AD4 +AD4 the following patch (applies on top of v5.1-rc3):
+AD4 +AD4 
+AD4 +AD4 
+AD4 +AD4 Subject: +AFs-PATCH+AF0 block: Fix blk+AF8-mq+AF8-try+AF8-issue+AF8-directly()
+AD4 +AD4 
+AD4 +AD4 If blk+AF8-mq+AF8-try+AF8-issue+AF8-directly() returns BLK+AF8-STS+ACoAXw-RESOURCE that means that
+AD4 +AD4 the request has not been queued and that the caller should retry to submit
+AD4 +AD4 the request. Both blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert() and
+AD4 +AD4 blk+AF8-mq+AF8-sched+AF8-insert+AF8-request() guarantee that a request will be processed.
+AD4 +AD4 Hence return BLK+AF8-STS+AF8-OK if one of these functions is called. This patch
+AD4 +AD4 avoids that blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list() crashes when using dm-mpath.
+AD4 +AD4 
+AD4 +AD4 Reported-by: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
+AD4 +AD4 Fixes: 7f556a44e61d (+ACI-blk-mq: refactor the code of issue request directly+ACI) +ACM v5.0.
+AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 +AD4 ---
+AD4 +AD4   block/blk-mq.c +AHw 9 +-+--------
+AD4 +AD4   1 file changed, 2 insertions(+-), 7 deletions(-)
+AD4 +AD4 
+AD4 +AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 +AD4 index 652d0c6d5945..b2c20dce8a30 100644
+AD4 +AD4 --- a/block/blk-mq.c
+AD4 +AD4 +-+-+- b/block/blk-mq.c
+AD4 +AD4 +AEAAQA -1859,16 +-1859,11 +AEAAQA blk+AF8-status+AF8-t blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4 +AD4   	case BLK+AF8-STS+AF8-RESOURCE:
+AD4 +AD4   		if (force) +AHs
+AD4 +AD4   			blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert(rq, run+AF8-queue)+ADs
+AD4 +AD4 -			/+ACo
+AD4 +AD4 -			 +ACo We have to return BLK+AF8-STS+AF8-OK for the DM
+AD4 +AD4 -			 +ACo to avoid livelock. Otherwise, we return
+AD4 +AD4 -			 +ACo the real result to indicate whether the
+AD4 +AD4 -			 +ACo request is direct-issued successfully.
+AD4 +AD4 -			 +ACo-/
+AD4 +AD4 -			ret +AD0 bypass ? BLK+AF8-STS+AF8-OK : ret+ADs
+AD4 +AD4 +-			ret +AD0 BLK+AF8-STS+AF8-OK+ADs
+AD4 +AD4   		+AH0 else if (+ACE-bypass) +AHs
+AD4 +AD4   			blk+AF8-mq+AF8-sched+AF8-insert+AF8-request(rq, false,
+AD4 +AD4   						    run+AF8-queue, false)+ADs
+AD4 +AD4 +-			ret +AD0 BLK+AF8-STS+AF8-OK+ADs
+AD4 +AD4   		+AH0
+AD4 
+AD4 I would move the ret assignment here after the condition statement.

How is that expected to work for the +ACE-force +ACYAJg bypass case? I don't
want to alter +ACI-ret+ACI in that case.

Thanks,

Bart.
