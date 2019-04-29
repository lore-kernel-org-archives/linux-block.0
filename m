Return-Path: <SRS0=IEWf=S7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E918C43219
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 18:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E858D2075E
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 18:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfD2SQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:16:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46815 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2SQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 14:16:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi2so664627plb.13;
        Mon, 29 Apr 2019 11:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLkZ493/1cphoGwpLIb9H6qasE7OtGYtVCVCps4qXrE=;
        b=GMgnYuebgPvTcDZfKu1oiDfjT9Cr/8GS7nbUkYUo7edo0jBZ9y6tQD4ZT+7ALW8fvO
         hjlDHcZh5eSmUp4OL1fV5RdAI2CIL+JBEiGKe03m4OSunGl7+OmUMOpq+gFdh4YfWbof
         2htMal6QOv6GayZoEhBigogFJCWGNMsUgEcasXMkCW15Ky+yEkEvV0Uqymk7FIjOWI/u
         25tEb2V7t1EctnVpq2SPHE2X2LJWEaL9yGhUjn+1EeFd2LcvbQqhbLYJyFcGbuMGu9vc
         f41LW2XFicz/6omOPjHB4m2c5p4V0bbekO6Iv7j8iq/2ftbb2rV3srEA7MxOOMmqlYiO
         aV5w==
X-Gm-Message-State: APjAAAUuuEu+T9rrdaa6Bc8gR5JVROXbjh3XS2RB8NdtwdGJCw0a1Kau
        T29xojDjM8lh1Vhk6D+BXYCeBkFF
X-Google-Smtp-Source: APXvYqwaDN3hsVmsoZIUFFdHMxshS0Ml2pvXLwfgKp2v4Jta1b0Rlg3VKQSEOvS12SWIGVS4Gp4+bw==
X-Received: by 2002:a17:902:5910:: with SMTP id o16mr9150656pli.289.1556561799622;
        Mon, 29 Apr 2019 11:16:39 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d15sm11992646pfr.179.2019.04.29.11.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 11:16:38 -0700 (PDT)
Message-ID: <1556561798.161891.166.camel@acm.org>
Subject: Re: [PATCH V4 3/3] scsi: core: avoid to pre-allocate big chunk for
 sg list
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Date:   Mon, 29 Apr 2019 11:16:38 -0700
In-Reply-To: <20190428073932.9898-4-ming.lei@redhat.com>
References: <20190428073932.9898-1-ming.lei@redhat.com>
         <20190428073932.9898-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-04-28 at 15:39 +-0800, Ming Lei wrote:
+AD4 Now scsi+AF8-mq+AF8-setup+AF8-tags() pre-allocates a big buffer for IO sg list,
+AD4 and the buffer size is scsi+AF8-mq+AF8-sgl+AF8-size() which depends on smaller
+AD4 value between shost-+AD4-sg+AF8-tablesize and SG+AF8-CHUNK+AF8-SIZE.
+AD4 
+AD4 Modern HBA's DMA is often capable of deadling with very big segment
+AD4 number, so scsi+AF8-mq+AF8-sgl+AF8-size() is often big. Suppose the max sg number
+AD4 of SG+AF8-CHUNK+AF8-SIZE is taken, scsi+AF8-mq+AF8-sgl+AF8-size() will be 4KB.
+AD4 
+AD4 Then if one HBA has lots of queues, and each hw queue's depth is
+AD4 high, pre-allocation for sg list can consume huge memory.
+AD4 For example of lpfc, nr+AF8-hw+AF8-queues can be 70, each queue's depth
+AD4 can be 3781, so the pre-allocation for data sg list is 70+ACo-3781+ACo-2k
+AD4 +AD0-517MB for single HBA.
+AD4 
+AD4 There is Red Hat internal report that scsi+AF8-debug based tests can't
+AD4 be run any more since legacy io path is killed because too big
+AD4 pre-allocation.
+AD4 
+AD4 So switch to runtime allocation for sg list, meantime pre-allocate 2
+AD4 inline sg entries. This way has been applied to NVMe PCI for a while,
+AD4 so it should be fine for SCSI too. Also runtime sg entries allocation
+AD4 has verified and run always in the original legacy io path.
+AD4 
+AD4 Not see performance effect in my big BS test on scsi+AF8-debug.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


