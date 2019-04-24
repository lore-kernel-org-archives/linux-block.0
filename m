Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFE6C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BEA21773
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 15:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfDXPcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:32:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42595 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfDXPcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 11:32:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so5106146pln.9;
        Wed, 24 Apr 2019 08:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21IrJIPY4WASQMXJxvHa6tECdnvuNRFGPuWyU5YNk48=;
        b=J5Kn+PGsSjAieOHKZRZpfgREubjJZrKdg3cKoQ/dWvlFIYvMMGbK6OCEcd8nuNttsp
         fvLgMhrk6AfPUSj2IWnyb+knHTpc3S+5YRI4yz9yzuqvbj8zr/gKnIIeRTh72C9BjrfT
         xZx3/OV8lekyV/2epcGtbRoOm+wwijYau6W1fzbUNYWmJuwZN+WqzkjTfPxV7NBOthkT
         MUbulKeFImZbstIb2hD8tCB0iU1E8F5WjK364Oj3X50GCok79ugKScEXrGD3EgsjrzFY
         l76JCa8V8TAelVLE68KM9q/wjNpohYdBxoiGeORXyGWCzWHG8YFAicktpTpLeHfSfnH8
         3avQ==
X-Gm-Message-State: APjAAAVnOfEuCSl6SJuWsXggk2VQXPfdA5n+n3vuSlnmCi9eWGhLi7+y
        bCy1UafMrpeL7Ut/w4vLOZo=
X-Google-Smtp-Source: APXvYqx3yvIKymPX30YR7IRpwrDmenmlXrrLgBMpKRQnw48qB10YB30wgdpp9YCOtV0wAFufdydWyA==
X-Received: by 2002:a17:902:e693:: with SMTP id cn19mr19966346plb.255.1556119954088;
        Wed, 24 Apr 2019 08:32:34 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z14sm26138489pfn.161.2019.04.24.08.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 08:32:32 -0700 (PDT)
Message-ID: <1556119951.161891.126.camel@acm.org>
Subject: Re: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg
 list
From:   Bart Van Assche <bvanassche@acm.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Date:   Wed, 24 Apr 2019 08:32:31 -0700
In-Reply-To: <1556119450.3043.8.camel@HansenPartnership.com>
References: <20190423103240.29864-1-ming.lei@redhat.com>
         <20190423103240.29864-3-ming.lei@redhat.com>
         <1556033835.161891.123.camel@acm.org> <20190424075233.GA32345@ming.t460p>
         <1556119450.3043.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-24 at 08:24 -0700, James Bottomley wrote:
+AD4 On Wed, 2019-04-24 at 15:52 +-0800, Ming Lei wrote:
+AD4 +AD4 On Tue, Apr 23, 2019 at 08:37:15AM -0700, Bart Van Assche wrote:
+AD4 +AD4 +AD4 On Tue, 2019-04-23 at 18:32 +-0800, Ming Lei wrote:
+AD4 +AD4 +AD4 +AD4  +ACM-define  SCSI+AF8-INLINE+AF8-PROT+AF8-SG+AF8-CNT  1
+AD4 +AD4 +AD4 +AD4  
+AD4 +AD4 +AD4 +AD4 +-+ACM-define  SCSI+AF8-INLINE+AF8-SG+AF8-CNT  2
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 So this patch inserts one kmalloc() and one kfree() call in the hot
+AD4 +AD4 +AD4 path for every SCSI request with more than two elements in its
+AD4 +AD4 +AD4 scatterlist? Isn't
+AD4 +AD4 
+AD4 +AD4 Slab or its variants are designed for fast path, and NVMe PCI uses
+AD4 +AD4 slab for allocating sg list in fast path too.
+AD4 
+AD4 Actually, that's not really true  base kmalloc can do all sorts of
+AD4 things including kick off reclaim so it's not really something we like
+AD4 using in the fast path.  The only fast and safe kmalloc you can rely on
+AD4  in the fast path is GFP+AF8-ATOMIC which will fail quickly if no memory
+AD4 can easily be found.  +ACo-However+ACo the sg+AF8-table allocation functions are
+AD4 all pool backed (lib/sg+AF8-pool.c), so they use the lightweight GFP+AF8-ATOMIC
+AD4 mechanism for kmalloc initially coupled with a backing pool in case of
+AD4 failure to ensure forward progress.
+AD4 
+AD4 So, I think you're both right: you shouldn't simply use kmalloc, but
+AD4 this implementation doesn't, it uses the sg+AF8-table allocation functions
+AD4 which correctly control kmalloc to be lightweight and efficient and
+AD4 able to make forward progress.

Another concern is whether this change can cause a livelock. If the system
is running out of memory and the page cache submits a write request with
a scatterlist with more than two elements, if the kmalloc() for the
scatterlist fails, will that prevent the page cache from making any progress
with writeback?

Bart.

