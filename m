Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A525EC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8F22084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfDCRwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:52:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCRwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 13:52:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so8695893pgc.3;
        Wed, 03 Apr 2019 10:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UblkV5nvwtUPrXnlNvow4K1XVguKvcswnxoaL5xCEf0=;
        b=D5qme6/ype8KwaeCbgdb+i3lfrBnuwBZg9Z2ZIgYw+DJjzhTDqMVeLGzEFFf5RlVCs
         chEN5q7GHpQZhXEiE9q2+8Bza8LPSsa6UV6eau2IM69XQuzcTisklW1nDO63bAqb/0Io
         81DJYg0+FqSXJYLW7bgsbKWKXHAtvxzn6KpU/ubfymSUQf1us/IfeoMeQBq9x3gbEHd8
         +KH5M2TtNkByoaIs94xWBuuAx5lwBeg8g4KLcIesGO+OydXTeBNE4QNmMfDTLPxBkqSo
         h8RHGrovEoqnvsT7tGRrsyLQTVZ9OYWqhOvj89eLP5wfZVKCB3yD6TbTlTxcBOWm8LbG
         ZQJA==
X-Gm-Message-State: APjAAAVIMsmvD/Ondg5dB1gKZob7dO4TLUDVFe81UA45srKHFTBW7CHE
        wD6x08zLM8VKaBll0fH823M=
X-Google-Smtp-Source: APXvYqx5u1dlFpExnkEpBn+PkKFERG/0zZe7r020mzWnD9ojOiTMSIvpnnsjuTI/wPFkczeYCtbQTg==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr850571pfo.20.1554313974421;
        Wed, 03 Apr 2019 10:52:54 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id k26sm21346848pfo.111.2019.04.03.10.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 10:52:53 -0700 (PDT)
Message-ID: <1554313972.118779.233.camel@acm.org>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Bart Van Assche <bvanassche@acm.org>
To:     Laurence Oberman <loberman@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>, jianchao.w.wang@oracle.com
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 03 Apr 2019 10:52:52 -0700
In-Reply-To: <74e767afc0e10054f87fc821fa15966449d3dd2a.camel@redhat.com>
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
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-03-27 at 18:00 -0400, Laurence Oberman wrote:
+AD4 Hello Jens, Jianchao
+AD4 Finally made it to this one.
+AD4 I will see if I can revert and test
+AD4 
+AD4 7f556a44e61d0b62d78db9a2662a5f0daef010f2 is the first bad commit
+AD4 commit 7f556a44e61d0b62d78db9a2662a5f0daef010f2
+AD4 Author: Jianchao Wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
+AD4 Date:   Fri Dec 14 09:28:18 2018 +-0800
+AD4 
+AD4     blk-mq: refactor the code of issue request directly
+AD4     
+AD4     Merge blk+AF8-mq+AF8-try+AF8-issue+AF8-directly and +AF8AXw-blk+AF8-mq+AF8-try+AF8-issue+AF8-directly
+AD4     into one interface to unify the interfaces to issue requests
+AD4     directly. The merged interface takes over the requests totally,
+AD4     it could insert, end or do nothing based on the return value of
+AD4     .queue+AF8-rq and 'bypass' parameter. Then caller needn't any other
+AD4     handling any more and then code could be cleaned up.
+AD4     
+AD4     And also the commit c616cbee ( blk-mq: punt failed direct issue
+AD4     to dispatch list ) always inserts requests to hctx dispatch list
+AD4     whenever get a BLK+AF8-STS+AF8-RESOURCE or BLK+AF8-STS+AF8-DEV+AF8-RESOURCE, this is
+AD4     overkill and will harm the merging. We just need to do that for
+AD4     the requests that has been through .queue+AF8-rq. This patch also
+AD4     could fix this.
+AD4     
+AD4     Signed-off-by: Jianchao Wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
+AD4     Signed-off-by: Jens Axboe +ADw-axboe+AEA-kernel.dk+AD4

Hi Laurence,

I have not been able to reproduce this issue. But you may want to try
the following patch (applies on top of v5.1-rc3):


Subject: +AFs-PATCH+AF0 block: Fix blk+AF8-mq+AF8-try+AF8-issue+AF8-directly()

If blk+AF8-mq+AF8-try+AF8-issue+AF8-directly() returns BLK+AF8-STS+ACoAXw-RESOURCE that means that
the request has not been queued and that the caller should retry to submit
the request. Both blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert() and
blk+AF8-mq+AF8-sched+AF8-insert+AF8-request() guarantee that a request will be processed.
Hence return BLK+AF8-STS+AF8-OK if one of these functions is called. This patch
avoids that blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list() crashes when using dm-mpath.

Reported-by: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
Fixes: 7f556a44e61d (+ACI-blk-mq: refactor the code of issue request directly+ACI) +ACM v5.0.
Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
---
 block/blk-mq.c +AHw 9 +-+--------
 1 file changed, 2 insertions(+-), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 652d0c6d5945..b2c20dce8a30 100644
--- a/block/blk-mq.c
+-+-+- b/block/blk-mq.c
+AEAAQA -1859,16 +-1859,11 +AEAAQA blk+AF8-status+AF8-t blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
 	case BLK+AF8-STS+AF8-RESOURCE:
 		if (force) +AHs
 			blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert(rq, run+AF8-queue)+ADs
-			/+ACo
-			 +ACo We have to return BLK+AF8-STS+AF8-OK for the DM
-			 +ACo to avoid livelock. Otherwise, we return
-			 +ACo the real result to indicate whether the
-			 +ACo request is direct-issued successfully.
-			 +ACo-/
-			ret +AD0 bypass ? BLK+AF8-STS+AF8-OK : ret+ADs
+-			ret +AD0 BLK+AF8-STS+AF8-OK+ADs
 		+AH0 else if (+ACE-bypass) +AHs
 			blk+AF8-mq+AF8-sched+AF8-insert+AF8-request(rq, false,
 						    run+AF8-queue, false)+ADs
+-			ret +AD0 BLK+AF8-STS+AF8-OK+ADs
 		+AH0
 		break+ADs
 	default:


Thanks,

Bart.
