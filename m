Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BEBC4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 18:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41522070B
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 18:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfDBSHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:07:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34689 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDBSHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 14:07:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so6773229pfd.1;
        Tue, 02 Apr 2019 11:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RhwuA5N/5e6H1WDwCI44CeLX6VSkzofI8H9pzxU7LZc=;
        b=TivN2aofY1EGjQgaPpm1OHH6yukPlN8vX4bdSEAFTjx+I6bPVeJqJ8lWH0cNXMzj5R
         YiXkfM04xXqeHslAO/bFbraPHta/rBga1Lq9UL0z2D7jR8RNNZ8yCFxEy5FYPtiparNo
         7zFLVNxVbA5Ac6ifPUbiI+uY2qF0phEz4dKbsj8VOs8nAaCU4wpaASUXpE74GFzMXbga
         vQHR1bWooL9N3KmHUsngBma1Oi3xGU3fJOEHrHeofuw3cqnHUxic4WoV71q3gcJdfECU
         sWWcHFMoHQhGkARU/xog4cDoM36MWuvhZKOOwW37uBv/MKskZwQv7zLAAnqDRDYvpo6n
         xU1g==
X-Gm-Message-State: APjAAAXcDsdOFdFrSLId4kB0aYDcOS9Rxnr/yCAb4Jo2dHSMZlKrkPPJ
        GRxS/giWiADk+fvM/GaqW/A=
X-Google-Smtp-Source: APXvYqyPVGAoebpALI4iE6lLgYN+hMeU0hDHJL/Dft1ullZ+TbvnP7EIhUIZGV2t/FCD1yluvl0fdg==
X-Received: by 2002:a63:4e64:: with SMTP id o36mr66623230pgl.213.1554228437120;
        Tue, 02 Apr 2019 11:07:17 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f5sm7651348pgo.75.2019.04.02.11.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 11:07:16 -0700 (PDT)
Message-ID: <1554228435.118779.163.camel@acm.org>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
From:   Bart Van Assche <bvanassche@acm.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Date:   Tue, 02 Apr 2019 11:07:15 -0700
In-Reply-To: <fa9375ec-a2a7-d065-b941-7822f3791242@oracle.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
         <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
         <20190401020036.GB30776@ming.t460p>
         <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
         <fa9375ec-a2a7-d065-b941-7822f3791242@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-04-01 at 10:44 +-0800, jianchao.wang wrote:
+AD4 percpu+AF8-ref+AF8-tryget would be better to get pending requests to be issued when queue is frozen.

Agreed.

Thanks,

Bart.
