Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CBC67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AB420835
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 23:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AB420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeLLXy4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:54:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39946 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeLLXyz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 18:54:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so107569pfo.7;
        Wed, 12 Dec 2018 15:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+61rvmzfSdAZe1Oh34hSvbDO8st4DilaDi6ymfCQzS0=;
        b=T6zoVOGfL/hozmuYjhYzlthO2AbD8tkaQUUyDrKYRVXIgP2xSsOTlzhFPAo2HOHCdM
         zSDYRZ87kBhtAxUodJooi13gBKpJm+qb8thFlOIjdbsKbvld3CWkm+gDC4o7atcaEL77
         mf1yIT9k1ddPEtimQqFHDZAExijXnGOqq/QfKFGZkDE/h28KgNWX0w2QCr/5liIDjax/
         H1/pRmzplWUZcUpVclBqi7CRS1NKNxPAg6Th+t6Mpu7kWnmu04WYp779MWzFhZoIwkOR
         evUY+U2mHLH62Mn/dVtaMDoG+F8pj22LTBBtBoX9Yy7jVLPU0uODqBz9v1m2RcvsBnt7
         Z/xQ==
X-Gm-Message-State: AA+aEWa9e1DRpv5bjVdGdfd1zaiHEatUbNaTX8Cp86LDZue07n3intyx
        PbKyzt/ALYFWmfikODfP/YM=
X-Google-Smtp-Source: AFSGD/VHEyDrhJOi3V8vqOyVGsUwEV/p+cqiYhQnmuuCyAUBFLEs47Bd4jJgTFbvliP1IodZIVXYBA==
X-Received: by 2002:a62:6303:: with SMTP id x3mr22789351pfb.110.1544658894730;
        Wed, 12 Dec 2018 15:54:54 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id r12sm118677pgv.83.2018.12.12.15.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 15:54:54 -0800 (PST)
Message-ID: <1544658892.185366.412.camel@acm.org>
Subject: Re: [PATCH] blkcg: handle dying request_queue when associating a
 blkg
From:   Bart Van Assche <bvanassche@acm.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Date:   Wed, 12 Dec 2018 15:54:52 -0800
In-Reply-To: <20181212040643.GA73727@dennisz-mbp.dhcp.thefacebook.com>
References: <20181211230308.66276-1-dennis@kernel.org>
         <1544570173.185366.397.camel@acm.org>
         <20181212040643.GA73727@dennisz-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-11 at 23:06 -0500, Dennis Zhou wrote:
+AD4 Hi Bart,
+AD4 
+AD4 On Tue, Dec 11, 2018 at 03:16:13PM -0800, Bart Van Assche wrote:
+AD4 +AD4 On Tue, 2018-12-11 at 18:03 -0500, Dennis Zhou wrote:
+AD4 +AD4 +AD4 diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
+AD4 +AD4 +AD4 index 6bd0619a7d6e..c30661ddc873 100644
+AD4 +AD4 +AD4 --- a/block/blk-cgroup.c
+AD4 +AD4 +AD4 +-+-+- b/block/blk-cgroup.c
+AD4 +AD4 +AD4 +AEAAQA -202,6 +-202,12 +AEAAQA static struct blkcg+AF8-gq +ACo-blkg+AF8-create(struct blkcg +ACo-blkcg,
+AD4 +AD4 +AD4  	WARN+AF8-ON+AF8-ONCE(+ACE-rcu+AF8-read+AF8-lock+AF8-held())+ADs
+AD4 +AD4 +AD4  	lockdep+AF8-assert+AF8-held(+ACY-q-+AD4-queue+AF8-lock)+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +-	/+ACo request+AF8-queue is dying, do not create/recreate a blkg +ACo-/
+AD4 +AD4 +AD4 +-	if (blk+AF8-queue+AF8-dying(q)) +AHs
+AD4 +AD4 +AD4 +-		ret +AD0 -ENODEV+ADs
+AD4 +AD4 +AD4 +-		goto err+AF8-free+AF8-blkg+ADs
+AD4 +AD4 +AD4 +-	+AH0
+AD4 +AD4 +AD4 +-
+AD4 +AD4 +AD4  	/+ACo blkg holds a reference to blkcg +ACo-/
+AD4 +AD4 +AD4  	if (+ACE-css+AF8-tryget+AF8-online(+ACY-blkcg-+AD4-css)) +AHs
+AD4 +AD4 +AD4  		ret +AD0 -ENODEV+ADs
+AD4 +AD4 
+AD4 +AD4 What prevents that the queue state changes after blk+AF8-queue+AF8-dying() has returned
+AD4 +AD4 and before blkg+AF8-create() returns? Are you sure you don't need to protect this
+AD4 +AD4 code with a blk+AF8-queue+AF8-enter() / blk+AF8-queue+AF8-exit() pair?
+AD4 +AD4 
+AD4 
+AD4 Hmmm. So I think the idea is that we rely on normal shutdown as I don't
+AD4 think there is anything wrong with creating a blkg on a dying
+AD4 request+AF8-queue. When we are doing association, the request+AF8-queue should
+AD4 be pinned by the open call. What we are racing against is when the
+AD4 request+AF8-queue is shutting down, it goes around and destroys the blkgs.
+AD4 For clarity, QUEUE+AF8-FLAG+AF8-DYING is set in blk+AF8-cleanup+AF8-queue() before
+AD4 calling blk+AF8-exit+AF8-queue() which eventually calls blkcg+AF8-exit+AF8-queue().
+AD4 
+AD4 The use of blk+AF8-queue+AF8-dying() is to determine whether blkg shutdown has
+AD4 already started as if we create one after it has started, we may
+AD4 incorrectly orphan a blkg and leak it. Both blkg creation and
+AD4 destruction require holding the queue+AF8-lock, so if the QUEUE+AF8-FLAG+AF8-DYING
+AD4 flag is set after we've checked it, it means blkg destruction hasn't
+AD4 started because it has to wait on the queue+AF8-lock. If QUEUE+AF8-FLAG+AF8-DYING is
+AD4 set, then we have no guarantee of knowing what phase blkg destruction is
+AD4 in leading to a potential leak.

Hi Dennis,

To answer my own question: since all queue flag manipulations are protected
by the queue lock and since blkg+AF8-create() is called with the queue lock held
the above code does not need any further protection. Hence feel free to add
the following:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4



