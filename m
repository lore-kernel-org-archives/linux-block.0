Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797BC10F03
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4120D218B0
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfDWPhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:37:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42033 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWPhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 11:37:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so7791294pgh.9;
        Tue, 23 Apr 2019 08:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAbwObAVEINLQoh71l5aWMQg83PuwbnDUjroYZiflUo=;
        b=hBmixv3bHpFkuDLln2UNqp2os5zgrHBV8WgaAMffNfo10r6+xjdQXv3a9kg/wQEktH
         vf2dT7kVZk/oqT/MomDAoEv86E65jfw0dls2fnhhSrSJuxxDnGmrwQCMiuJnvUMQ1QeN
         E3calvr/VR9vMXPRnq+JttYmo8PEDPDHpBC6/XTS+kpb6oTxzxkTy7n8zc5vQT3l+mZl
         oU0aQGMUPKGOhrdQ1HAhNXbraPsJsk98VCGwSX5PM35sEsk+6Da95DWO7Lx0u752u0BD
         rEy2NKg3HwW2bxug/KENoPU+QChpYabeVfZY2LqLIZilIl75UbH0JHcSbdHQgKX0obwR
         ZH7A==
X-Gm-Message-State: APjAAAXmSxL7OzwnbwjlRpNi6sLHYSl96VyNWoggRM1uugX4SaXm2MbQ
        e6fqpWHNCB4jbADvSx2K3yS4U4zL
X-Google-Smtp-Source: APXvYqyInS45KepImKSi/9sftpAbNAjV2w8pL3fiHEOLScGhO+Z2fzpWHgfrG3DXibGwzGMRHZmVqw==
X-Received: by 2002:a63:6e01:: with SMTP id j1mr25445573pgc.442.1556033837390;
        Tue, 23 Apr 2019 08:37:17 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 66sm25273307pfr.44.2019.04.23.08.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 08:37:16 -0700 (PDT)
Message-ID: <1556033835.161891.123.camel@acm.org>
Subject: Re: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg
 list
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Date:   Tue, 23 Apr 2019 08:37:15 -0700
In-Reply-To: <20190423103240.29864-3-ming.lei@redhat.com>
References: <20190423103240.29864-1-ming.lei@redhat.com>
         <20190423103240.29864-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-23 at 18:32 +-0800, Ming Lei wrote:
+AD4  +ACM-define  SCSI+AF8-INLINE+AF8-PROT+AF8-SG+AF8-CNT  1
+AD4  
+AD4 +-+ACM-define  SCSI+AF8-INLINE+AF8-SG+AF8-CNT  2

So this patch inserts one kmalloc() and one kfree() call in the hot path
for every SCSI request with more than two elements in its scatterlist? Isn't
+ACI-2+ACI too low? Or in other words, what is the performance impact of this patch
for a real-world workload?

Thanks,

Bart.
