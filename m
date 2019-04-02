Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE99C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC5F2082C
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 17:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfDBRxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:53:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37463 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBRxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 13:53:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so6754842pfr.4;
        Tue, 02 Apr 2019 10:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihq0+HHXrKXoQ9ri2G2M4qsztCBZ/k0+e5mcJh5HueI=;
        b=CXUZh4RNKxN2AK66dENTVDs287oyhqj2arn/0BFYf3XAyR06Mpfov6pF70QyNbAP1B
         e535Bgc9SIaUH0FGq8BCSlj5VZ0HNo/PAJnWPxnfjmdkifyN5+JtrEH5UKbOEvewH4eu
         MvvT80YZ5vtsdFrdbLpYHOnvoGIoPsT1uFdOqWzl4q7fCwiMmMX09y5Ajhusgj/B7Glg
         5dOOqpW6ApuvOdr3KAk5v9vtrVECKDvJlOzWFYRuaESZpzmuV/P0zfGURSrl0lYAXzzD
         +sR5cUXc6gkHdDyHYzen+LKjch8jJruf8HNAcNbw9Xh9vBMaPk6iCZAERQgrNsH9qxZC
         pyeQ==
X-Gm-Message-State: APjAAAX1ZiuLfLZ2mF+VQauVSOLJlJptun1z2ND4mmudZ6xKInRwaUAN
        y6zkcbgjoAefcf7th/xephk=
X-Google-Smtp-Source: APXvYqy5rr483CGvVsFPy/4+bmG4ME3pIC+li3U3Di2wFQSB1V9YaBECWhZeZtCvkj17k+aPvMB/fQ==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr34282727pfd.232.1554227582338;
        Tue, 02 Apr 2019 10:53:02 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o76sm40032924pfa.156.2019.04.02.10.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 10:53:01 -0700 (PDT)
Message-ID: <1554227580.118779.158.camel@acm.org>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Date:   Tue, 02 Apr 2019 10:53:00 -0700
In-Reply-To: <20190402110558.GA12221@ming.t460p>
References: <20190401020036.GB30776@ming.t460p>
         <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
         <20190401025237.GE30776@ming.t460p>
         <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
         <20190401032852.GG30776@ming.t460p>
         <ef192658-74cd-e193-cb40-aed546c2b309@oracle.com>
         <20190401100334.GA5493@ming.t460p>
         <ad0f8f4c-5efe-e50f-a3a7-4f7e3d368d28@oracle.com>
         <20190402025505.GB26316@ming.t460p>
         <ac11c70b-0914-cce7-7ed4-22acb292a965@oracle.com>
         <20190402110558.GA12221@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 19:05 +-0800, Ming Lei wrote:
+AD4 On Tue, Apr 02, 2019 at 04:07:04PM +-0800, jianchao.wang wrote:
+AD4 +AD4 percpu+AF8-ref is born for fast path.
+AD4 +AD4 There are some drivers use it in completion path, such as scsi, does it really
+AD4 +AD4 matter for this kind of device ? If yes, I guess we should remove blk+AF8-mq+AF8-run+AF8-hw+AF8-queues
+AD4 +AD4 which is the really bulk and depend on hctx restart mechanism.
+AD4 
+AD4 Yes, it is designed for fast path, but it doesn't mean percpu+AF8-ref
+AD4 hasn't any cost. blk+AF8-mq+AF8-run+AF8-hw+AF8-queues() is called for all blk-mq devices,
+AD4 includes the fast NVMe.

I think the overhead of adding a percpu+AF8-ref+AF8-get/put pair is acceptable for
SCSI drivers. The NVMe driver doesn't call blk+AF8-mq+AF8-run+AF8-hw+AF8-queues() directly.
Additionally, I don't think that any of the blk+AF8-mq+AF8-run+AF8-hw+AF8-queues() calls from
the block layer matter for the fast path code in the NVMe driver. In other
words, adding a percpu+AF8-ref+AF8-get/put pair in blk+AF8-mq+AF8-run+AF8-hw+AF8-queues() shouldn't
affect the performance of the NVMe driver.

+AD4 Also:
+AD4 
+AD4 It may not be enough to just grab the percpu+AF8-ref for blk+AF8-mq+AF8-run+AF8-hw+AF8-queues
+AD4 only, given the idea is to use the percpu+AF8-ref to protect hctx's resources.
+AD4 
+AD4 There are lots of uses on 'hctx', such as other exported blk-mq APIs.
+AD4 If this approach were chosen, we may have to audit other blk-mq APIs,
+AD4 cause they might be called after queue is frozen too.

The only blk+AF8-mq+AF8-hw+AF8-ctx user I have found so far that needs additional
protection is the q-+AD4-mq+AF8-ops-+AD4-poll() call in blk+AF8-poll(). However, that is not
a new issue. Functions like nvme+AF8-poll() access data structures (NVMe
completion queue) that shouldn't be accessed while blk+AF8-cleanup+AF8-queue() is in
progress. If blk+AF8-poll() is modified such that it becomes safe to call that
function while blk+AF8-cleanup+AF8-queue() is in progress then blk+AF8-poll() won't
access any hardware queue that it shouldn't access.

Bart.

