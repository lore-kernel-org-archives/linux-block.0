Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BDC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7007720661
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCHSTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:19:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41046 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfCHSTL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 13:19:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id k11so13778483pgb.8
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 10:19:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tqb6njjgZwOTa1+L4wOQIvuyMcnt7IEofQ6Z5m8yj0=;
        b=sC2r2dX/21/ZfGRfOv1MpMGjqZHm76hti6lklYPUih2xI/y91oc2TTldYWnqJdFNbK
         KTaS31QctEo7WHhzbEYFcXEozO33/E2X3DalPGYvEch1hGu5Y/Xa+b3D93NDviozjOGt
         mxrG3YATB7V3i+2rgrck0lyEFhsxjYeyW6Mv9ReYu1N/kOG/FmKITqSkhG0tJVju+ZIP
         wTNRcU/FYS1eOp3QX+1aNRzFQOWFayg5Ma9YjatkXjAoG7s69chnIb65QFnMpI0x+v0W
         IdsrhknmN9KyPiBwwRatE5xLz2Id0iDJ3ZXIsD0CJsMRxfyoDNIzLfMG1Urcy1jl7O/L
         vRpg==
X-Gm-Message-State: APjAAAVUKSNimWTNquIrzlRMciXMSa8jMn30zjoDkSS0HRTFcPLy44fh
        uH3KIM1gEgznnBZJrh6JQEI=
X-Google-Smtp-Source: APXvYqz+Z5od7ZNoxoqPlYvpG5qjSRbnG3L7vLlotpe8tgnoprR+mYU5FBYb5KtrLyKdC+rvp0hLAQ==
X-Received: by 2002:a17:902:28e6:: with SMTP id f93mr20429514plb.264.1552069150415;
        Fri, 08 Mar 2019 10:19:10 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id q62sm14596867pga.32.2019.03.08.10.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:19:09 -0800 (PST)
Message-ID: <1552069148.45180.32.camel@acm.org>
Subject: Re: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Date:   Fri, 08 Mar 2019 10:19:08 -0800
In-Reply-To: <20190308174006.5032-5-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
         <20190308174006.5032-5-keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
+AD4 +-static bool nvme+AF8-fail+AF8-queue+AF8-request(struct request +ACo-req, void +ACo-data, bool reserved)
+AD4 +-+AHs
+AD4 +-	struct nvme+AF8-iod +ACo-iod +AD0 blk+AF8-mq+AF8-rq+AF8-to+AF8-pdu(req)+ADs
+AD4 +-	struct nvme+AF8-queue +ACo-nvmeq +AD0 iod-+AD4-nvmeq+ADs
+AD4 +-
+AD4 +-	if (+ACE-test+AF8-bit(NVMEQ+AF8-ENABLED, +ACY-nvmeq-+AD4-flags))
+AD4 +-		blk+AF8-mq+AF8-end+AF8-request(req, BLK+AF8-STS+AF8-IOERR)+ADs
+AD4 +-	return true+ADs
+AD4 +-+AH0

Same question here as for patch 4/5: what prevents concurrent calls of
blk+AF8-mq+AF8-complete+AF8-request() with the blk+AF8-mq+AF8-end+AF8-request() call in the
above function?

Thanks,

Bart.
