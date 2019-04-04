Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20319C10F0C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F0C20882
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 14:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfDDO7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:59:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37921 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfDDO7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 10:59:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so1302431plb.5;
        Thu, 04 Apr 2019 07:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJYNobn3kmha0Vnk1pXBPZoT8IYrm+fGP1Eqz6B1+40=;
        b=D3FbZ0PyDfItLHZ5wPc/KScYIRNFU71iO8/VO9aTx92mXMoaTqVyD0csAKl0u/99JD
         gxKKHYprF4UgwmWhP8I5lSCwrJgqnvo7gJ3YHA/o2eeIJTFFAZsM0MWVRDrpLseW+VTB
         Z51bvIK18b9DTKvYXcmfD1aoMPCipGmH66NFnNykGtloQPOE/FwczMoKtozb1+o9KK/9
         C2D+GyB7ytkn6yBLdeFmAzXIS1awlsaIUMJVQw2idgk6c2OF4myXyaxanG+1YstAWa0A
         elzvTS8bXo/oO8A7TVV3GtuC0P6oV7qT0B5q+UwifKKZwrUPETTmnQFN+p3IIgXYuYsO
         QyZg==
X-Gm-Message-State: APjAAAWejYMfkJgpFQpSibL1fJDYHnhoxFTjPQkkYRQlKNaysBhvc4jj
        GLgr8lJiHPpFL3oqqf9hUKY=
X-Google-Smtp-Source: APXvYqzc3ltma1AHfudI439IHNdXh2wCb6o0exSK0mCmg/6r5m4Ac20jR/M7bNkUze954stNL6w/GQ==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr6980793pls.311.1554389985577;
        Thu, 04 Apr 2019 07:59:45 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id n17sm9784701pgk.81.2019.04.04.07.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 07:59:44 -0700 (PDT)
Message-ID: <1554389983.118779.237.camel@acm.org>
Subject: Re: [PATCH] block: Fix blk_mq_try_issue_directly()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Date:   Thu, 04 Apr 2019 07:59:43 -0700
In-Reply-To: <20190404070849.GD5004@ming.t460p>
References: <20190403201126.22819-1-bvanassche@acm.org>
         <20190404070849.GD5004@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 15:08 +-0800, Ming Lei wrote:
+AD4 On Wed, Apr 03, 2019 at 01:11:26PM -0700, Bart Van Assche wrote:
+AD4 +AD4 If blk+AF8-mq+AF8-try+AF8-issue+AF8-directly() returns BLK+AF8-STS+ACoAXw-RESOURCE that means that
+AD4 +AD4 the request has not been queued and that the caller should retry to submit
+AD4 +AD4 the request. Both blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert() and
+AD4 +AD4 blk+AF8-mq+AF8-sched+AF8-insert+AF8-request() guarantee that a request will be processed.
+AD4 +AD4 Hence return BLK+AF8-STS+AF8-OK if one of these functions is called. This patch
+AD4 +AD4 avoids that blk+AF8-mq+AF8-dispatch+AF8-rq+AF8-list() crashes when using dm-mpath.
+AD4 +AD4 
+AD4 +AD4 Cc: Christoph Hellwig +ADw-hch+AEA-infradead.org+AD4
+AD4 +AD4 Cc: Hannes Reinecke +ADw-hare+AEA-suse.com+AD4
+AD4 +AD4 Cc: James Smart +ADw-james.smart+AEA-broadcom.com+AD4
+AD4 +AD4 Cc: Ming Lei +ADw-ming.lei+AEA-redhat.com+AD4
+AD4 +AD4 Cc: Jianchao Wang +ADw-jianchao.w.wang+AEA-oracle.com+AD4
+AD4 +AD4 Cc: Keith Busch +ADw-keith.busch+AEA-intel.com+AD4
+AD4 +AD4 Cc: Dongli Zhang +ADw-dongli.zhang+AEA-oracle.com+AD4
+AD4 +AD4 Cc: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
+AD4 +AD4 Tested-by: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
+AD4 +AD4 Reviewed-by: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
+AD4 +AD4 Reported-by: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
+AD4 +AD4 Fixes: 7f556a44e61d (+ACI-blk-mq: refactor the code of issue request directly+ACI) +ACM v5.0.
+AD4 +AD4 Cc: +ADw-stable+AEA-vger.kernel.org+AD4
+AD4 +AD4 Signed-off-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4
+AD4 +AD4 ---
+AD4 +AD4  block/blk-mq.c +AHw 9 +-+--------
+AD4 +AD4  1 file changed, 2 insertions(+-), 7 deletions(-)
+AD4 +AD4 
+AD4 +AD4 diff --git a/block/blk-mq.c b/block/blk-mq.c
+AD4 +AD4 index 652d0c6d5945..b2c20dce8a30 100644
+AD4 +AD4 --- a/block/blk-mq.c
+AD4 +AD4 +-+-+- b/block/blk-mq.c
+AD4 +AD4 +AEAAQA -1859,16 +-1859,11 +AEAAQA blk+AF8-status+AF8-t blk+AF8-mq+AF8-try+AF8-issue+AF8-directly(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4 +AD4  	case BLK+AF8-STS+AF8-RESOURCE:
+AD4 +AD4  		if (force) +AHs
+AD4 +AD4  			blk+AF8-mq+AF8-request+AF8-bypass+AF8-insert(rq, run+AF8-queue)+ADs
+AD4 +AD4 -			/+ACo
+AD4 +AD4 -			 +ACo We have to return BLK+AF8-STS+AF8-OK for the DM
+AD4 +AD4 -			 +ACo to avoid livelock. Otherwise, we return
+AD4 +AD4 -			 +ACo the real result to indicate whether the
+AD4 +AD4 -			 +ACo request is direct-issued successfully.
+AD4 +AD4 -			 +ACo-/
+AD4 +AD4 -			ret +AD0 bypass ? BLK+AF8-STS+AF8-OK : ret+ADs
+AD4 +AD4 +-			ret +AD0 BLK+AF8-STS+AF8-OK+ADs
+AD4 +AD4  		+AH0 else if (+ACE-bypass) +AHs
+AD4 +AD4  			blk+AF8-mq+AF8-sched+AF8-insert+AF8-request(rq, false,
+AD4 +AD4  						    run+AF8-queue, false)+ADs
+AD4 +AD4 +-			ret +AD0 BLK+AF8-STS+AF8-OK+ADs
+AD4 +AD4  		+AH0
+AD4 
+AD4 This change itself is correct.
+AD4 
+AD4 However, there is other issue introduced by 7f556a44e61d.
+AD4 
+AD4 We need blk+AF8-insert+AF8-cloned+AF8-request() to pass back BLK+AF8-STS+AF8-RESOURCE/BLK+AF8-STS+AF8-RESOURCE
+AD4 to caller, so that dm-rq driver may see the underlying queue is busy, then tell
+AD4 blk-mq to deal with the busy condition from dm-rq queue, so that IO
+AD4 merge can get improved.
+AD4 
+AD4 That is exactly what 396eaf21ee17c476e8f6 (+ACI-blk-mq: improve DM's blk-mq IO merging
+AD4 via blk+AF8-insert+AF8-cloned+AF8-request feedback+ACI) did.
+AD4 
+AD4 There must be performance regression with 7f556a44e61d by cut the feedback.
+AD4 
+AD4 So could you fix them all in one patch?

Since commit 7f556a44e61d introduced multiple problems and since fixing
these is nontrivial, how about reverting that commit?

Thanks,

Bart.
