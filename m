Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A9C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 23:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABF52175B
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 23:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfBNXgf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:36:35 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:33505 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfBNXge (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 18:36:34 -0500
Received: by mail-pf1-f176.google.com with SMTP id c123so3903530pfb.0
        for <linux-block@vger.kernel.org>; Thu, 14 Feb 2019 15:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBPK5arBvsXuTbj6BFEwKOCB4by+Zoefi0RwElQDjSk=;
        b=gIEPKk/qLSz42hTFfKLaA+ZrYNmamxKq814SKA2gP7hN1DPLgHPedHqmpd9P6E/gE5
         MafAhHJ+IfSQutrzqw62nmF+bhrOXGIF2H1umr7f2iL+plM/4mhtuhSMdRCIetIigmIU
         1ClLGKa4dKxf4hw6c3jg92dzLLvoe+R/l8Mv3V3IA2JWIHplRclnVmwJPhnrEvsE36at
         W4eNZssRXHVtnKVxOZcXQxApXk7IEpahMC25Mx3t3qbtZTyicxpojSJuqV9k/hXZfl6t
         YRcU82pk/+KVAJfe9siNIrmygChvE7LtQAtEttcx6vKWrIlutog/mxLPNduvNixH8tmG
         y3eA==
X-Gm-Message-State: AHQUAuayej1V5wkBpb/e1RlVSUsc2grxkPLOXttstgCXHY7lujEvCuXl
        VxjWsEqu4GnuOaGq94uOgag=
X-Google-Smtp-Source: AHgI3IbWrXRtM/yTg8a5g5KdK7ZlgPkXksVd0Ql26VDv7cu8ee1ib/x1JiPBejHPUuhwuaJSWilzdw==
X-Received: by 2002:a62:4641:: with SMTP id t62mr6654346pfa.141.1550187393691;
        Thu, 14 Feb 2019 15:36:33 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h15sm4922841pfn.9.2019.02.14.15.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 15:36:32 -0800 (PST)
Message-ID: <1550187391.31902.87.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Evan Green <evgreen@google.com>
Date:   Thu, 14 Feb 2019 15:36:31 -0800
In-Reply-To: <71fb9eff-43eb-24aa-fb67-be56a3a97983@kernel.dk>
References: <1545261885.185366.488.camel@acm.org>
         <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
         <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
         <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
         <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
         <1545328865.185366.508.camel@acm.org>
         <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
         <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
         <1545339362.185366.511.camel@acm.org>
         <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
         <1545340987.185366.515.camel@acm.org>
         <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
         <1545341470.185366.519.camel@acm.org>
         <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
         <1545342043.185366.523.camel@acm.org>
         <60b4819c-4c19-a4e3-41f3-e21b0544c9a4@kernel.dk>
         <68c73daa-10e7-29da-b890-bf167ec164c2@kernel.dk>
         <1545344398.185366.531.camel@acm.org>
         <1864f5b8-cf64-a406-a3e0-9f5124ff95b5@kernel.dk>
         <a04dee3c-f355-4d28-caa4-21c7265ccae4@kernel.dk>
         <5869f2ed-dc65-135f-f12f-c14a1184125e@kernel.dk>
         <71fb9eff-43eb-24aa-fb67-be56a3a97983@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-20 at 15:50 -0700, Jens Axboe wrote:
+AD4 +-static void blk+AF8-fq+AF8-rcu+AF8-free(struct work+AF8-struct +ACo-work)
+AD4 +-+AHs
+AD4 +-	struct blk+AF8-flush+AF8-queue +ACo-fq +AD0 container+AF8-of(to+AF8-rcu+AF8-work(work),
+AD4 +-							struct blk+AF8-flush+AF8-queue,
+AD4 +-							rcu+AF8-work)+ADs
+AD4 +-
+AD4 +-	kfree(fq-+AD4-flush+AF8-rq)+ADs
+AD4 +-	kfree(fq)+ADs
+AD4 +-+AH0
+AD4 +-
+AD4  void blk+AF8-free+AF8-flush+AF8-queue(struct blk+AF8-flush+AF8-queue +ACo-fq)
+AD4  +AHs
+AD4  	/+ACo bio based request queue hasn't flush queue +ACo-/
+AD4  	if (+ACE-fq)
+AD4  		return+ADs
+AD4  
+AD4 -	kfree(fq-+AD4-flush+AF8-rq)+ADs
+AD4 -	kfree(fq)+ADs
+AD4 +-	INIT+AF8-RCU+AF8-WORK(+ACY-fq-+AD4-rcu+AF8-work, blk+AF8-fq+AF8-rcu+AF8-free)+ADs
+AD4 +-	queue+AF8-rcu+AF8-work(system+AF8-wq, +ACY-fq-+AD4-rcu+AF8-work)+ADs
+AD4  +AH0

Can INIT+AF8-RCU+AF8-WORK() +- queue+AF8-rcu+AF8-work() be changed into call+AF8-rcu()? The latter
namely uses a smaller data structure.

+AD4 diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
+AD4 index 2089c6c62f44..c39b58391ae8 100644
+AD4 --- a/block/blk-mq-tag.c
+AD4 +-+-+- b/block/blk-mq-tag.c
+AD4 +AEAAQA -228,13 +-228,15 +AEAAQA static bool bt+AF8-iter(struct sbitmap +ACo-bitmap, unsigned int bitnr, void +ACo-data)
+AD4  
+AD4  	if (+ACE-reserved)
+AD4  		bitnr +-+AD0 tags-+AD4-nr+AF8-reserved+AF8-tags+ADs
+AD4 -	rq +AD0 tags-+AD4-rqs+AFs-bitnr+AF0AOw
+AD4 +-	if (tags-+AD4-rqs+AFs-bitnr+AF0.queue +ACEAPQ hctx-+AD4-queue)
+AD4 +-		return true+ADs

Since blk+AF8-mq+AF8-tag+AF8-set+AF8-rq() is not serialized against this function I doubt that
the tags-+AD4-rqs+AFs-bitnr+AF0.queue +ACEAPQ hctx-+AD4-queue check helps. Can it be left out?

+AD4 +-struct rq+AF8-tag+AF8-entry +AHs
+AD4 +-       struct request+AF8-queue +ACo-queue+ADs
+AD4 +-       struct request +ACo-rq+ADs

If the new test can be left out from bt+AF8-iter(), can this new data structure be
left out too? In other words, keep the existing approach of only storing the
request pointer and not the queue pointer.

Thanks,

Bart.
