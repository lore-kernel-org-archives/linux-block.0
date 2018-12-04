Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE75AC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE59320672
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE59320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeLDROj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:14:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33650 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeLDROj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:14:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so7675599pgu.0;
        Tue, 04 Dec 2018 09:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGVBwA3Eu7LHZi3kMu+nrKdJZvJMSb1KomRQOiB/jck=;
        b=KB+tFJDTmZl7ETCp1pOlotCRTZ+iMNgqG1tzUzrDhGTZlvmuJD4k4CzOJ5+7OnzzX1
         EVBRSuu9peTRdqIyWq3F+8dvUCeTWktsTUYKnxoj8Rj/6rpZTtIBGZiAVj/iSpNUFzyq
         Y3sMohkDuGNOPy8c9Nw7taYnyQJAqAN7Xfwx5Q2im93eS669el9VGg/7HBmNyFyRIG79
         pLnjxkng5U9SzUf6T2LWAUp6cdow/hRwoVJ84ZHgBQhne0ANUhkuePx214LkYIw2hd/2
         5BbdnIQOlzHG6lcZxHAAIpcFLS6vrZmo5eOu44DAjEgRitQmjfzcZcF3fOib0qrZrZic
         Pgxw==
X-Gm-Message-State: AA+aEWb6j5GEjNW/JUIkClETRiLFkzE1VxJsjm/bScfYNXF3eSIorThm
        iEqIuKrX0Bo3QfgYVKmP4YI=
X-Google-Smtp-Source: AFSGD/Ujq62AKkh3aZnaJHj0tMxbClVBWwL5IYy1bVEVIoz1wPgbP117BiEtTE16sZmjWIXZzYBYpg==
X-Received: by 2002:a62:3006:: with SMTP id w6mr21086366pfw.258.1543943676887;
        Tue, 04 Dec 2018 09:14:36 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 202sm33905168pfy.87.2018.12.04.09.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:14:35 -0800 (PST)
Message-ID: <1543943674.185366.194.camel@acm.org>
Subject: Re: [PATCH] blk-mq: Set request mapping to NULL in
 blk_mq_put_driver_tag
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Date:   Tue, 04 Dec 2018 09:14:34 -0800
In-Reply-To: <d56ddf2b485c13445fff5f9c36dd3c87@mail.gmail.com>
References: <CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe_pkFVGJg73v0Wp7O38A@mail.gmail.com>
         <7e8e1fe2-9f91-a370-a98c-43cdad1f6e8e@acm.org>
         <d56ddf2b485c13445fff5f9c36dd3c87@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-04 at 22:17 +-0530, Kashyap Desai wrote:
+AD4 +- Linux-scsi
+AD4 
+AD4 +AD4 +AD4 diff --git a/block/blk-mq.h b/block/blk-mq.h
+AD4 +AD4 +AD4 index 9497b47..57432be 100644
+AD4 +AD4 +AD4 --- a/block/blk-mq.h
+AD4 +AD4 +AD4 +-+-+- b/block/blk-mq.h
+AD4 +AD4 +AD4 +AEAAQA -175,6 +-175,7 +AEAAQA static inline bool
+AD4 +AD4 +AD4 blk+AF8-mq+AF8-get+AF8-dispatch+AF8-budget(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx)
+AD4 +AD4 +AD4   static inline void +AF8AXw-blk+AF8-mq+AF8-put+AF8-driver+AF8-tag(struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx,
+AD4 +AD4 +AD4                          struct request +ACo-rq)
+AD4 +AD4 +AD4   +AHs
+AD4 +AD4 +AD4 +-    hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0 +AD0 NULL+ADs
+AD4 +AD4 +AD4       blk+AF8-mq+AF8-put+AF8-tag(hctx, hctx-+AD4-tags, rq-+AD4-mq+AF8-ctx, rq-+AD4-tag)+ADs
+AD4 +AD4 +AD4       rq-+AD4-tag +AD0 -1+ADs
+AD4 +AD4 
+AD4 +AD4 No SCSI driver should call scsi+AF8-host+AF8-find+AF8-tag() after a request has
+AD4 +AD4 finished. The above patch introduces yet another race and hence can't be
+AD4 +AD4 a proper fix.
+AD4 
+AD4 Bart, many scsi drivers use scsi+AF8-host+AF8-find+AF8-tag() to traverse max tag+AF8-id to
+AD4 find out pending IO in firmware.
+AD4 One of the use case is -  HBA firmware recovery.  In case of firmware
+AD4 recovery, driver may require to traverse the list and return back pending
+AD4 scsi command to SML for retry.
+AD4 I quickly grep the scsi code and found that snic+AF8-scsi, qla4xxx, fnic,
+AD4 mpt3sas are using API scsi+AF8-host+AF8-find+AF8-tag for the same purpose.
+AD4 
+AD4 Without this patch, we hit very basic kernel panic due to page fault.  This
+AD4 is not an issue in non-mq code path. Non-mq path use
+AD4 blk+AF8-map+AF8-queue+AF8-find+AF8-tag() and that particular API does not provide stale
+AD4 requests.

As I wrote before, your patch doesn't fix the race you described but only
makes the race window smaller. If you want an example of how to use
scsi+AF8-host+AF8-find+AF8-tag() properly, have a look at the SRP initiator driver
(drivers/infiniband/ulp/srp). That driver uses scsi+AF8-host+AF8-find+AF8-tag() without
triggering any NULL pointer dereferences. The approach used in that driver
also works when having to support HBA firmware recovery.

Bart.
