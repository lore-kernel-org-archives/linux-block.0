Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA2C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E483A208E4
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfDXQJp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:09:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45562 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbfDXQJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:09:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so9527778pfi.12;
        Wed, 24 Apr 2019 09:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rC6I+HY49tbJX96PnYvaCkBk0yHHMUVgihXWArYUEHU=;
        b=XU6Rk7BUirCXcJYJ+ZvbmaY9xx105TTUn5EbxOkz2n5uzNaOqY3SDzwsGrcRfVt78s
         wrusdG3ufSiZl0aJWjrjfJW5agpVb3S1rj2xyPU+AvRxsYA+5lvTmHclNAJheTRF3ntX
         WOg9X76xixQE7tWDtmFLSCej+ihQN/3fGSXnrPlOCpHzz4+rOQtP381e+FzV/jAK9HUf
         vydfDEVaw2wqnyE3qpp8RR7eZNjcuzAAXhXZDbtIEAvyN08fgxM1etv/DOzDlcVGj90S
         KQNK6wP5aUHiCGl7HQzuAr6RVxBtu3K6SIHLZY0gZ7q6kCz4533pa129/ssBYF38aW+h
         jw9Q==
X-Gm-Message-State: APjAAAXvEKHvp8c5fL0VBFCvjvqvnsOif5MCknMdILNVoO+J2t6fjs72
        HxySVABlkURMjtItT+ilCrY=
X-Google-Smtp-Source: APXvYqyUDCVg+sN5GZXK8nNlch8dkB+B/erEa1THxS+gpGJB54BOZ+52cC1n4LOWFIB015Av06OvOA==
X-Received: by 2002:a63:ed4f:: with SMTP id m15mr32130617pgk.387.1556122184370;
        Wed, 24 Apr 2019 09:09:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x128sm37639587pfx.103.2019.04.24.09.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 09:09:43 -0700 (PDT)
Message-ID: <1556122182.161891.135.camel@acm.org>
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
Date:   Wed, 24 Apr 2019 09:09:42 -0700
In-Reply-To: <1556120991.3043.20.camel@HansenPartnership.com>
References: <20190423103240.29864-1-ming.lei@redhat.com>
         <20190423103240.29864-3-ming.lei@redhat.com>
         <1556033835.161891.123.camel@acm.org> <20190424075233.GA32345@ming.t460p>
         <1556119450.3043.8.camel@HansenPartnership.com>
         <1556119951.161891.126.camel@acm.org>
         <1556120991.3043.20.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-24 at 08:49 -0700, James Bottomley wrote:
+AD4 On Wed, 2019-04-24 at 08:32 -0700, Bart Van Assche wrote:
+AD4 +AD4 Another concern is whether this change can cause a livelock. If the
+AD4 +AD4 system is running out of memory and the page cache submits a write
+AD4 +AD4 request with a scatterlist with more than two elements, if the
+AD4 +AD4 kmalloc() for the scatterlist fails, will that prevent the page cache
+AD4 +AD4 from making any progress with writeback?
+AD4 
+AD4 It's pool backed, as I said.  Is the concern there isn't enough depth
+AD4 in the pools for a large write?

That memory pool is used by multiple drivers. Most but not all
sg+AF8-alloc+AF8-table+AF8-chained() calls happen from inside .queue+AF8-rq() implementations.
One sg+AF8-alloc+AF8-table+AF8-chained() call occurs in the NFS server code. I'm not sure
whether it is guaranteed that an sg+AF8-alloc+AF8-table+AF8-chained() will succeed sooner
or later under low memory conditions. Additionally, new
sg+AF8-alloc+AF8-table+AF8-chained() could be added in drivers any time.

Bart.
