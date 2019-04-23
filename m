Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41611C10F03
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3D7217D9
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 15:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfDWPdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:33:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35565 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWPdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 11:33:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so7806221pgf.2;
        Tue, 23 Apr 2019 08:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8F2GaXzjXPtwQrCyRhxcpdjHDa+rNSdgkddePiDdCY=;
        b=cJTBZrIG9zE8nBvzAFRjqJgLAtqt7t3TSxnn/E5j9hY3jG0ygyq94OInmUKTTao4t+
         U1EKlMVdN1qjAuP6Juf9HEYhyXW+/V3Bvjme1IUlol5qiFvNMzz2yMMlkcZDm8GpoXFN
         mLpXde3e3azbmYdL4sQHQXFmcaOYB23CRP1tQlecoB6RQM8OXkO1qVZa/8CeziLjI31j
         R//i7mtGPcb1Ja4MT77JeMlfrBimfi/eDKpLT0qqFhfvAIxgLuEYJjwp1LaGS4EmbHjc
         fgKJ1sTi1EJGt9d+3JNaKueuer6tNlRpPpwpwb2h7XHOdc7pWCFgEPQhOGWmDsAHx6oN
         p7qg==
X-Gm-Message-State: APjAAAUzEBSpOCcxYhrKNVyygGCDIktT5mFu2NMQH+iOXrXs6pUZ73Bi
        +Usf4VPwgHBcE6GE68QdWPzXurHj
X-Google-Smtp-Source: APXvYqyKfAOvXzX8+SQlFij6LZlBnjJsMeUZ9TOIUYoe+bKLu/PRiktqMZQNng/CvyrUBehhMoglPg==
X-Received: by 2002:a62:fb0a:: with SMTP id x10mr27140852pfm.179.1556033630107;
        Tue, 23 Apr 2019 08:33:50 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 71sm46892573pfs.36.2019.04.23.08.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 08:33:49 -0700 (PDT)
Message-ID: <1556033627.161891.120.camel@acm.org>
Subject: Re: [PATCH 1/2] scsi: core: avoid to pre-allocate big chunk for
 protection meta data
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Date:   Tue, 23 Apr 2019 08:33:47 -0700
In-Reply-To: <20190423103240.29864-2-ming.lei@redhat.com>
References: <20190423103240.29864-1-ming.lei@redhat.com>
         <20190423103240.29864-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-23 at 18:32 +-0800, Ming Lei wrote:
+AD4 +-/+ACo
+AD4 +- +ACo Size of integrity meta data size is usually small, 1 inline sg
                        +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBeAF4AXg
Please change this into +ACI-metadata+ACI. Mentioning +ACI-size+ACI twice is not
useful.
+AD4 +- +ACo should cover normal cases.
+AD4 +- +ACo-/
+AD4 +-+ACM-define  SCSI+AF8-INLINE+AF8-PROT+AF8-SG+AF8-CNT  1
+AD4 +-
+AD4  static struct kmem+AF8-cache +ACo-scsi+AF8-sdb+AF8-cache+ADs
+AD4  static struct kmem+AF8-cache +ACo-scsi+AF8-sense+AF8-cache+ADs
+AD4  static struct kmem+AF8-cache +ACo-scsi+AF8-sense+AF8-isadma+AF8-cache+ADs
+AD4 +AEAAQA -553,12 +-559,21 +AEAAQA static void scsi+AF8-uninit+AF8-cmd(struct scsi+AF8-cmnd +ACo-cmd)
+AD4         +AH0
+AD4  +AH0
+AD4  
+AD4 +-static inline bool scsi+AF8-prot+AF8-use+AF8-inline+AF8-sg(struct scsi+AF8-cmnd +ACo-cmd)
+AD4 +-+AHs
+AD4 +-       if (+ACE-scsi+AF8-prot+AF8-sglist(cmd))
+AD4 +-               return false+ADs

Since scsi+AF8-prot+AF8-use+AF8-inline+AF8-sg() is only called if scsi+AF8-prot+AF8-sg+AF8-count() +AD4 0,
is the above test necessary?

+AD4 +-       return cmd-+AD4-prot+AF8-sdb-+AD4-table.sgl +AD0APQ
+AD4 +-               (struct scatterlist +ACo)(cmd-+AD4-prot+AF8-sdb +- 1)+ADs
+AD4 +-+AH0
+AD4 +-
+AD4  static void scsi+AF8-mq+AF8-free+AF8-sgtables(struct scsi+AF8-cmnd +ACo-cmd)
+AD4  +AHs
+AD4         if (cmd-+AD4-sdb.table.nents)
+AD4                 sg+AF8-free+AF8-table+AF8-chained(+ACY-cmd-+AD4-sdb.table, true)+ADs
+AD4 -       if (scsi+AF8-prot+AF8-sg+AF8-count(cmd))
+AD4 -               sg+AF8-free+AF8-table+AF8-chained(+ACY-cmd-+AD4-prot+AF8-sdb-+AD4-table, true)+ADs
+AD4 +-       if (scsi+AF8-prot+AF8-sg+AF8-count(cmd) +ACYAJg +ACE-scsi+AF8-prot+AF8-use+AF8-inline+AF8-sg(cmd))
+AD4 +-               sg+AF8-free+AF8-table+AF8-chained(+ACY-cmd-+AD4-prot+AF8-sdb-+AD4-table, false)+ADs
+AD4  +AH0
+AD4  
+AD4  static void scsi+AF8-mq+AF8-uninit+AF8-cmd(struct scsi+AF8-cmnd +ACo-cmd)
+AD4 +AEAAQA -1044,9 +-1059,11 +AEAAQA blk+AF8-status+AF8-t scsi+AF8-init+AF8-io(struct scsi+AF8-cmnd +ACo-cmd)
+AD4                 +AH0
+AD4  
+AD4                 ivecs +AD0 blk+AF8-rq+AF8-count+AF8-integrity+AF8-sg(rq-+AD4-q, rq-+AD4-bio)+ADs
+AD4 -
+AD4 -               if (sg+AF8-alloc+AF8-table+AF8-chained(+ACY-prot+AF8-sdb-+AD4-table, ivecs,
+AD4 -                               prot+AF8-sdb-+AD4-table.sgl)) +AHs
+AD4 +-               if (ivecs +ADwAPQ SCSI+AF8-INLINE+AF8-PROT+AF8-SG+AF8-CNT)
+AD4 +-                       prot+AF8-sdb-+AD4-table.nents +AD0 prot+AF8-sdb-+AD4-table.orig+AF8-nents +AD0
+AD4 +-                               SCSI+AF8-INLINE+AF8-PROT+AF8-SG+AF8-CNT+ADs

Please call sg+AF8-init+AF8-table() instead of open-coding it.

+AD4 +-               else if (sg+AF8-alloc+AF8-table+AF8-chained(+ACY-prot+AF8-sdb-+AD4-table, ivecs,
+AD4 +-                                       NULL)) +AHs
+AD4                         ret +AD0 BLK+AF8-STS+AF8-RESOURCE+ADs
+AD4                         goto out+AF8-free+AF8-sgtables+ADs
+AD4                 +AH0

Bart.
