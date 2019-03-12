Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E5C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEF42075C
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfCLO6W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33502 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfCLO6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id h11so2052888pgl.0;
        Tue, 12 Mar 2019 07:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/hlvZZ2Bfj2OmjmNPeAbbx2XEfNC0GHv4jmOznXxy8=;
        b=f9bFumIMPVdFb7B4zvZDwQfkN/ndV5AWg/uRRQzmx3/aed9xfEzCns9hlzzqnESSca
         82AFh2G3O6hkv3W+VAbDixQMWxVVooAEF+zeXp4CWuDPW+8uIJeIHIPDvxnutb9KH1ko
         MEg2RZIclwMLtitc2ipfu0PXMMQ8AIxbvO8WwJRQkRVTgorMxvOpdnWvUI6O9aFOT8lC
         fbONZuuPIzJEKCOAObPU+l+lIGX5Rwkjyb9nlXQ8ZEBhmDYtbryfIdW6Bt/bVBEf0BVW
         boFTHNczGnfDEMj8IHPA6fK2ZBNlo66z+HKu+tOQ26DK9+IT8UVIO3W3E+GEpKxYsqqi
         Ygxw==
X-Gm-Message-State: APjAAAW+B/F9lSys1vawzxXrYvz1xodqseAMLDoazaj3+WcVAqgQZmNw
        iHaEjEjCpqeRh04Du8oVR4E=
X-Google-Smtp-Source: APXvYqyCAqTOu0OSKWAikJJnC9blsbF20D88CTHmIoX1aInhQ8MfhJLa1sK+BCjqQ/p4yJn9aE5V7g==
X-Received: by 2002:a62:ea08:: with SMTP id t8mr38717532pfh.60.1552402701114;
        Tue, 12 Mar 2019 07:58:21 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b85sm19508384pfj.56.2019.03.12.07.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 07:58:20 -0700 (PDT)
Message-ID: <1552402699.45180.106.camel@acm.org>
Subject: Re: kernel 5.0 blk_clear_pm_only triggers a warning during resume
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 12 Mar 2019 07:58:19 -0700
In-Reply-To: <20190312132826.12c5f166@xhacker.debian>
References: <20190312132826.12c5f166@xhacker.debian>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-03-12 at 05:35 +-0000, Jisheng Zhang wrote:
+AD4 I got below warning during resume:
+AD4 
+AD4 +AFs  673.658888+AF0 sd 0:0:0:0: +AFs-sda+AF0 Starting disk
+AD4 +AFs  673.658899+AF0 WARNING: CPU: 3 PID: 1039 at blk+AF8-clear+AF8-pm+AF8-only+-0x2a/0x30
+AD4 +AFs  673.658902+AF0 CPU: 3 PID: 1039 Comm: kworker/u8:49 Not tainted 5.0.0+- +ACM-1
+AD4 +AFs  673.658902+AF0 sd 2:0:0:0: +AFs-sdb+AF0 Starting disk
+AD4 +AFs  673.658903+AF0 Hardware name: LENOVO 4180F42/4180F42, BIOS 83ET75WW (1.45 ) 05/10/2013
+AD4 +AFs  673.658906+AF0 Workqueue: events+AF8-unbound async+AF8-run+AF8-entry+AF8-fn
+AD4 +AFs  673.658909+AF0 RIP: 0010:blk+AF8-clear+AF8-pm+AF8-only+-0x2a/0x30
+AD4 +AFs  673.658911+AF0 Code: b8 ff ff ff ff f0 0f c1 87 80 00 00 00 83 e8 01 78 18 74 01 c3 48 81 c7 58 05 00 00 31 c9 31 d2 be 03 00 00 00 e9 36 97 e2 ff +ADw-0f+AD4 0b c3 0f 1f 00 48 81 c7 90 00 00 00 e9 04 01
+AD4 3a 00 0f 1f 40 00
+AD4 +AFs  673.658911+AF0 RSP: 0000:ffff8881115a7e48 EFLAGS: 00010297
+AD4 +AFs  673.658913+AF0 RAX: 00000000ffffffff RBX: ffff888118d42800 RCX: ffff8881194c9a00
+AD4 +AFs  673.658914+AF0 RDX: ffff888118ab1a00 RSI: 0000000000000000 RDI: ffff888117e70000
+AD4 +AFs  673.658915+AF0 RBP: ffff888118d42f90 R08: 0000000000000004 R09: 000000000001f900
+AD4 +AFs  673.658915+AF0 R10: 0000000045698a8e R11: 0000000000000010 R12: ffff888119421000
+AD4 +AFs  673.658916+AF0 R13: 0000000000000000 R14: ffff88800030ea80 R15: 0ffff88811942100
+AD4 +AFs  673.658918+AF0 FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:0000000000000000
+AD4 +AFs  673.658918+AF0 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
+AD4 +AFs  673.658919+AF0 CR2: 0000000000000000 CR3: 000000000200c001 CR4: 00000000000606e0
+AD4 +AFs  673.658920+AF0 Call Trace:
+AD4 +AFs  673.658924+AF0  ? scsi+AF8-device+AF8-resume+-0x28/0x50
+AD4 +AFs  673.658926+AF0  ? scsi+AF8-dev+AF8-type+AF8-resume+-0x2b/0x80
+AD4 +AFs  673.658927+AF0  ? async+AF8-run+AF8-entry+AF8-fn+-0x2c/0xd0
+AD4 +AFs  673.658930+AF0  ? process+AF8-one+AF8-work+-0x1f0/0x3f0
+AD4 +AFs  673.658932+AF0  ? worker+AF8-thread+-0x28/0x3c0
+AD4 +AFs  673.658933+AF0  ? process+AF8-one+AF8-work+-0x3f0/0x3f0
+AD4 +AFs  673.658935+AF0  ? kthread+-0x10c/0x130
+AD4 +AFs  673.658936+AF0  ? +AF8AXw-kthread+AF8-create+AF8-on+AF8-node+-0x150/0x150
+AD4 +AFs  673.658938+AF0  ? ret+AF8-from+AF8-fork+-0x1f/0x30
+AD4 +AFs  673.658940+AF0 ---+AFs end trace ce18772de33e283e +AF0----

Hi Jisheng,

Is this something that occurred once or is this something that you can reproduce
easily? In the latter case, can you verify whether the patch below is sufficient
to make this warning disappear?

Thanks,

Bart.

---
 drivers/scsi/scsi+AF8-lib.c +AHw 6 +-+-+-+---
 1 file changed, 4 insertions(+-), 2 deletions(-)

diff --git a/drivers/scsi/scsi+AF8-lib.c b/drivers/scsi/scsi+AF8-lib.c
index f3f24dfd8fd5..33e1a72d47fa 100644
--- a/drivers/scsi/scsi+AF8-lib.c
+-+-+- b/drivers/scsi/scsi+AF8-lib.c
+AEAAQA -2540,8 +-2540,10 +AEAAQA void scsi+AF8-device+AF8-resume(struct scsi+AF8-device +ACo-sdev)
 	 +ACo device deleted during suspend)
 	 +ACo-/
 	mutex+AF8-lock(+ACY-sdev-+AD4-state+AF8-mutex)+ADs
-	sdev-+AD4-quiesced+AF8-by +AD0 NULL+ADs
-	blk+AF8-clear+AF8-pm+AF8-only(sdev-+AD4-request+AF8-queue)+ADs
+-	if (sdev-+AD4-quiesced+AF8-by) +AHs
+-		sdev-+AD4-quiesced+AF8-by +AD0 NULL+ADs
+-		blk+AF8-clear+AF8-pm+AF8-only(sdev-+AD4-request+AF8-queue)+ADs
+-	+AH0
 	if (sdev-+AD4-sdev+AF8-state +AD0APQ SDEV+AF8-QUIESCE)
 		scsi+AF8-device+AF8-set+AF8-state(sdev, SDEV+AF8-RUNNING)+ADs
 	mutex+AF8-unlock(+ACY-sdev-+AD4-state+AF8-mutex)+ADs

