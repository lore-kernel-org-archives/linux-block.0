Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD13C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FFC20663
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDCQY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:24:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37862 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCQY5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 12:24:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so8415043pfr.4;
        Wed, 03 Apr 2019 09:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVmgympk/P0O0HDHwa3oMzJoDt0DlaVDKoO8/aTIg34=;
        b=CYOdAhrBOdp0As5HolgasELk86N3q/CU35/WectYWTkC25wKQ+FflVjfToEDuLqc/R
         qhC2S4dqwE8jiemTbnEhS/2tTeQWrBgsTc51YO/PvbamFmsh39X5K0yE+r4OT7pkWlcm
         Hi2ZMoc9DQZIeacFKzUOymFIfrb2vdPhUVhlgrfmzYzHEe/vcFZAYWxLZMt9xzqiXEY5
         lGbiHka86xw4Nor5JyXTJ7j6JkKLeEvosxEGcQzBo99LWEln2QVscTuAK9PM9qLFtlFy
         fg3j2db1W1WaFwxP3evAQJYoKlLpuvUTY059OT1p3BoEtfnDMrNtmGMUWWfYKYu+RxGF
         rWhw==
X-Gm-Message-State: APjAAAU0SokLp8HjVbxh+uTmhiO9OPCsEixEIXddENDC49tFvhWy6dsH
        JUWOP7IRErFK0Va2zwWOtAe9ufoe3ro=
X-Google-Smtp-Source: APXvYqwONXSk5+2dFL190k61AGZOsr0QDX3nLptctCUGX19+KA3wDC8MDDMX3oGkZ6DeOXh0uoKhTA==
X-Received: by 2002:a65:5ac3:: with SMTP id d3mr610341pgt.168.1554308696783;
        Wed, 03 Apr 2019 09:24:56 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g67sm25830331pfg.94.2019.04.03.09.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:24:56 -0700 (PDT)
Message-ID: <1554308694.118779.219.camel@acm.org>
Subject: Re: [PATCH V3 6/6] SCSI: don't hold device refcount in IO path
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
Date:   Wed, 03 Apr 2019 09:24:54 -0700
In-Reply-To: <20190403102609.18707-7-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
         <20190403102609.18707-7-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 18:26 +-0800, Ming Lei wrote:
+AD4         /+ACo
+AD4 -        +ACo Before a SCSI command is dispatched,
+AD4 -        +ACo get+AF8-device(+ACY-sdev-+AD4-sdev+AF8-gendev) is called and the host,
+AD4 -        +ACo target and device busy counters are increased. Since
+AD4 -        +ACo requeuing a request causes these actions to be repeated and
+AD4 -        +ACo since scsi+AF8-device+AF8-unbusy() has already been called,
+AD4 -        +ACo put+AF8-device(+ACY-device-+AD4-sdev+AF8-gendev) must still be called. Call
+AD4 -        +ACo put+AF8-device() after blk+AF8-mq+AF8-requeue+AF8-request() to avoid that
+AD4 -        +ACo removal of the SCSI device can start before requeueing has
+AD4 -        +ACo happened.
+AD4 +-        +ACo Before a SCSI command is dispatched, the host, target and
+AD4 +-        +ACo device busy counters are increased. Since requeuing a request
+AD4 +-        +ACo causes these actions to be repeated and since scsi+AF8-device+AF8-unbusy()
+AD4 +-        +ACo has already been called.
+AD4          +ACo-/

The last sentence of the new comment looks incomplete to me (+ACI-Since ...+ACI).

Thanks,

Bart.
