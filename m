Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E1BC4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 15:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DAD20645
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfDBPvh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:51:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41934 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfDBPvh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 11:51:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so6587647pfd.8;
        Tue, 02 Apr 2019 08:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isXTwTDwFuc/MLvGnCDIPJlYEf6FVp5ei54uSmD+uHo=;
        b=EZPKGDUFwQ8z2hDeOAQZeHW0qJH8fhjlRQ56mTiwhDT4pCtl6yH2MVlOKm+IhgoPkO
         VoV2MEvh+YOyBW/6JHGZ3bQiF7jRxuc7T1qfBjQIU06rC1cFT4MkXtN3JNeX4iAIlRdB
         1RCz8SwjpzZXdh1iDBkojDMNjk6vkayap58a4BoA3sBBH8sPT1//g7eyb1Mith7OTnKH
         bIW8mOI5jhv6IDAuSEeNgUXE/BeFEu67iHx5uiuilUqaH5Pn0P5lJ09h6ile4jMhE702
         ebio8ayd/k+A9aelSjVkAZg4Ub67VqXTbkNIxGaF1uZF2b5TolKAVSD05bvwiFJrjOnL
         fHfA==
X-Gm-Message-State: APjAAAXXeDPfffIqYVKU73o7+upJYCgCaB5zfBrKZHV8yEZfSwm/z7GX
        B01PU5F9HQc1HRK0rGhGC8A=
X-Google-Smtp-Source: APXvYqym1EdJTlWgBICq0IXRUAasTORhAJ2hg7z6qtaOZEZpfRMJJIhklG/5fs9ehw8fZ/TUXIWu5w==
X-Received: by 2002:a63:e050:: with SMTP id n16mr66708384pgj.210.1554220295851;
        Tue, 02 Apr 2019 08:51:35 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h4sm17989638pfo.119.2019.04.02.08.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:51:35 -0700 (PDT)
Message-ID: <1554220294.118779.142.camel@acm.org>
Subject: Re: [PATCH] SCSI: don't hold device refcount in IO path
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        jianchao wang <jianchao.w.wang@oracle.com>
Date:   Tue, 02 Apr 2019 08:51:34 -0700
In-Reply-To: <20190402114800.2281-1-ming.lei@redhat.com>
References: <20190402114800.2281-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 19:48 +-0800, Ming Lei wrote:
+AD4 scsi+AF8-device's refcount is always grabed in IO path.
                                   +AF4AXgBeAF4AXgBe
                                   grabbed?

+AD4 Turns out it isn't necessary, becasue blk+AF8-queue+AF8-cleanup() will
+AD4 drain any in-flight IOs, then cancel timeout/requeue work, and
+AD4 SCSI's requeue+AF8-work is canceled too in +AF8AXw-scsi+AF8-remove+AF8-device().
+AD4 
+AD4 Also scsi+AF8-device won't go away until blk+AF8-cleanup+AF8-queue() is done.
+AD4 
+AD4 So don't hold the refcount in IO path.

Holding the device reference count was definitely necessary in the past.
You may want to reflect this in the patch description by mentioning that
grabbing that reference count is no longer required today because the
draining mechanism now waits for requeuing to occur. I don't think that
was the case for the legacy block layer.

Bart.
