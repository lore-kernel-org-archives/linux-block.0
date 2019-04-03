Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E7BC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CDE206C0
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDCQVo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:21:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36434 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCQVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 12:21:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so8579127pgc.3;
        Wed, 03 Apr 2019 09:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kF9xdYj7VmLG6JQOZShHL46JwBfngjKV0n0QU3w8qNc=;
        b=jb20fCUdMztW2p7bXz2R16J1Wgp+NrXj+1ddvKDIZASEHgo2eaGGOuJzOgVTAsFI9L
         y40EFwC+NijBNwtfWLKn/sJyM8F7P8qwp7JSDrUCD7y+/WMUlM27e1itc8F+PqTOeRHa
         quAvHylESXoZ/y8wok0tExQxoDcdSj91sk/Umu7roJT4YQeFaDKZTf/j+IpviS82WU5a
         OVkEGarLQ754YrmxDm3g6IHDQX1ejgGAVzBy7t5xo5liU5RZhDEEaZgQfMy0tBioSibB
         3UyWq6qH1AJSWJpqFTZyZTqDstZc/9NhOA7JXe0u3o7FcnFO4w4h4+8knnC+TNaYdxmS
         THow==
X-Gm-Message-State: APjAAAUReTiL2mcxjxvyILBDnAA2aHitQymx6xwAUK7Z4mYtic3lsBmO
        zNYyb3tfOjuXCvmOnLBLq4c=
X-Google-Smtp-Source: APXvYqxo3bxujDEDd7Q1hnzivBVY2PQxuuoijEsXAsZfCq+jd5asCh0Hj+5OzW5GGdgys+I19fq0FA==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr551558pga.66.1554308503479;
        Wed, 03 Apr 2019 09:21:43 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s4sm19012487pgp.89.2019.04.03.09.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:21:42 -0700 (PDT)
Message-ID: <1554308501.118779.217.camel@acm.org>
Subject: Re: [PATCH V3 4/6] blk-mq: move cancel of hctx->run_work into
 blk_mq_hw_sysfs_release
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
Date:   Wed, 03 Apr 2019 09:21:41 -0700
In-Reply-To: <20190403102609.18707-5-ming.lei@redhat.com>
References: <20190403102609.18707-1-ming.lei@redhat.com>
         <20190403102609.18707-5-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 18:26 +-0800, Ming Lei wrote:
+AD4 hctx is always released after requeue is freed.
+AD4 
+AD4 With holding queue's kobject refcount, it is safe for driver to run queue,
+AD4 so one run queue might be scheduled after blk+AF8-sync+AF8-queue() is done.
+AD4 
+AD4 So moving the cancel of hctx-+AD4-run+AF8-work into blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-release()
+AD4 for avoiding run released queue.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


