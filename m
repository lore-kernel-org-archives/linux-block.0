Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A8C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538562075E
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfDCPVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:21:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42001 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCPVO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 11:21:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so8202810plb.9;
        Wed, 03 Apr 2019 08:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTjfdzTXV0IDuwAyV4lRfQem2KbhWobNLrH/l9V32GA=;
        b=XuIv+nvAKlIen4iUPkE+dJ+5DJpub2P0Yd+huLcBTYzklHn4KPD9+ysk8k9xzc0Axi
         8MSYLfyFjIh5A0B14My7hkJAckb/+fvvklor8rI235nqqfnmoXzMAJPYjkT9ApNPk+F9
         gSnT2Ykr2psOHWtvOjIQWtsALW9GCKEZquRFwmXma3pIBy7psm1PMPjgXIXYD++aYFt7
         9xlwY5BIRPA9cRypk5JfksTwhqyjmZve9xio2bnqdWqh3LbI8EXclmcNUbMc9m9i7PtB
         XAgUW27nT8Fm4Y6EUyUtZhRETCC9dOKQXTrLg+LbJYT4qKfLrM7GKes8zDf/44XXJ+iH
         5hmw==
X-Gm-Message-State: APjAAAVcK5miMQB1fh/N0l8FBAQAgkTFkK6PDK5s3CypHMHoWP+qVvuH
        3NXR/+u8Nm2pM9fV0pYgOhk=
X-Google-Smtp-Source: APXvYqyHZ0c/D3YCOoi1TNLG8p9ycnNPyehK4XQ/nZuKSG+XZaf7q/NDzkwf+pZZFY36+lBDyXv8Ig==
X-Received: by 2002:a17:902:2888:: with SMTP id f8mr506300plb.244.1554304873583;
        Wed, 03 Apr 2019 08:21:13 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b3sm21841794pfi.82.2019.04.03.08.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:21:12 -0700 (PDT)
Message-ID: <1554304871.118779.185.camel@acm.org>
Subject: Re: [PATCH V3 1/6] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Date:   Wed, 03 Apr 2019 08:21:11 -0700
In-Reply-To: <20190403102609.18707-2-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
         <20190403102609.18707-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 18:26 +-0800, Ming Lei wrote:
+AD4 However, if request is staggered into plug list, and finally queued
+AD4 from plug code path, the refcount in submission side is actually missed.
+AD4 And we may start to run queue after queue is removed, then kernel oops
+AD4 is triggered.

I don't think that this patch is necessary. blk+AF8-mq+AF8-get+AF8-request() increases
q+AF8-usage+AF8-counter. In other words, as long as at least one request has been
allocated that has not finished it is guaranteed that q+AF8-usage+AF8-counter +AD4 0.
So there is no need for additional protection in blk+AF8-mq+AF8-flush+AF8-plug+AF8-list().

Bart.
