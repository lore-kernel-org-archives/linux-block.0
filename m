Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D739C001E0
	for <linux-block@archiver.kernel.org>; Sat, 21 Oct 2023 16:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjJUQNq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Oct 2023 12:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUQNp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Oct 2023 12:13:45 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A551A4
        for <linux-block@vger.kernel.org>; Sat, 21 Oct 2023 09:13:43 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-27d8e2ac2b1so1244668a91.2
        for <linux-block@vger.kernel.org>; Sat, 21 Oct 2023 09:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697904822; x=1698509622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWdVxYXF1zU7nc2tu2ZPDpyYNlqzpnocsCqhm3dBt9w=;
        b=rNalInkP/wURaBDo4ptQRBkW5hBtlDsjtxmb3ZgFFESqSolTDStmjOB0aEeu5PzNi5
         1bWFTEghA+oyW2SBG7BbDvzO4aHlYTZ5YyH9z31LP7a2vFzOzTMuSvwu5wk9cOsuspv+
         go1AsEIdG4g8sHyubX8Ph/39l0DJDTD1iu48/CNqhBIcm5uo4ie440fiBa/jIWhSQ0gL
         0coLzWIt5Gt+BsO56MrennAV+TOvWdBoP73LuOhEhy5+HYCFCohLSuwJohuES86p5dEl
         s0sLq3QM2Sg/+drLjF+MfVSkcKasd1BSxmDpOr5QOaI/4uy3xhdUppTWTQyCpvRd0+wH
         +Fhg==
X-Gm-Message-State: AOJu0YyxNP8sEe89QEe5DONh3uSQiOeNL6rDdF7mb/o0lhaqQzfhCzaH
        W38rF2C+0LkF9mOtr9BevJU=
X-Google-Smtp-Source: AGHT+IHKWpSipMoeKyOJy1VJOHlJi8Y38MUTykX+3yLfexKNIudi23r2ERIMsNF17fccnZErwlheIA==
X-Received: by 2002:a17:90b:2d8d:b0:27d:4ab9:fccb with SMTP id sj13-20020a17090b2d8d00b0027d4ab9fccbmr4426810pjb.5.1697904822520;
        Sat, 21 Oct 2023 09:13:42 -0700 (PDT)
Received: from [192.168.197.167] (236.sub-174-194-192.myvzw.com. [174.194.192.236])
        by smtp.gmail.com with ESMTPSA id iw22-20020a170903045600b001bc930d4517sm3371117plb.42.2023.10.21.09.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 09:13:41 -0700 (PDT)
Message-ID: <c768b829-8c86-4574-a1ec-fcc0bf60e270@acm.org>
Date:   Sat, 21 Oct 2023 09:13:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve shared tag set performance
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <20231020044159.GB11984@lst.de>
 <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org> <ZTKqAzSPNcBp4db0@kbusch-mbp>
 <f2728de6-ff3c-4693-b51f-58c3d46d0fbf@acm.org> <ZTK0NcqB4lIQ_zHQ@kbusch-mbp>
 <dbdc6dbe-5e2a-4414-bea6-1d2160ffdfdd@acm.org> <ZTMp3zwaKKQPKmqS@fedora>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZTMp3zwaKKQPKmqS@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/23 18:31, Ming Lei wrote:
> If two LUNs are attached to same host, one is slow, and another is fast,
> and the slow LUN can slow down the fast LUN easily without this fairness
> algorithm.
> 
> Your motivation is that "One of these logical units (WLUN) is used
> to submit control commands, e.g. START STOP UNIT. If any request is
> submitted to the WLUN, the queue depth is reduced from 31 to 15 or
> lower for data LUNs." I guess one simple fix is to not account queues
> of this non-IO LUN as active queues?

Hi Ming,

For fast storage devices (e.g. UFS) any time spent in an algorithm for
fair sharing will reduce IOPS. If there are big differences in the
request processing latency between different request queues then fair
sharing is beneficial. Whether or not the fair sharing algorithm is
improved, how about making it easy to disable fair sharing, e.g. with
something like the untested patch below? I think that will work better
than ignoring fair sharing per LUN. UFS devices support multiple logical
units and with the current fair sharing approach it takes long until
tags are taken away from an inactive LUN (request queue timeout).

Thanks,

Bart.


diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..b06b161d06de 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -416,7 +416,8 @@ static inline bool hctx_may_queue(struct 
blk_mq_hw_ctx *hctx,
  {
  	unsigned int depth, users;

-	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
+	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) ||
+	    hctx->queue->disable_fair_sharing)
  		return true;

  	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f25982..63b04cf65887 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -523,6 +523,7 @@ struct request_queue {
  	struct mutex		debugfs_mutex;

  	bool			mq_sysfs_init_done;
+	bool			disable_fair_sharing;
  };

  /* Keep blk_queue_flag_name[] in sync with the definitions below */

