Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740DC43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 18:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DF0207FF
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 18:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EI7+7bOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfLJS7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:59:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33569 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfLJS7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 13:59:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so237889pls.0
        for <linux-block@vger.kernel.org>; Tue, 10 Dec 2019 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bJAw7uTlX8W1IoIuJ5TDy+lULB0vG9JUy0IfVUsq2S0=;
        b=EI7+7bOGUQMYjwlJO0zhF8MXWszNRiv4HfT+YDW29L8hzs+tXCqJJPvZjqvWlHOsHW
         K9HbWh+w0fTIZovcpVcIAQkoeUukofnGgiVuscqe6aorkYSxbS236iuqaaTpkNH75VEX
         g+qOOSfwKjdljld7zs/kuVrpCKQ6Q771Sb5fZt/V1mCwi+iozD+KSz6jh/ZzUAzOMj6c
         tEn6FlJwESEGV4LO5EHw/KUbmNV3CelxOcL42fWAjgYOZt5psUPN/4E9+L81yiTuV2oz
         l74jEBGc9gSWDILVUaB7EJDF3mJ8dflFApbaAexjMU9IvSCrChQB+nNmeZgbmWc/MJ4u
         wPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bJAw7uTlX8W1IoIuJ5TDy+lULB0vG9JUy0IfVUsq2S0=;
        b=FdjvG2ZpkTFa95j+6uV4zCcan5b7LNaD8E+JFmBNWVXfpT/g+D7Eu7tkEe39sqF3Fb
         eygMexP3uVx5nJj4hor6lMVdUNZEX8Pq0USqlUu1jQ0oAeQbXjFJdXcZLz3u+mWVehUO
         vPcJQuloaJE11zHhZPHFrNbb0jHl5iaJsF7TCvp7GlSZ1gHyGVoCOCjEsKVNl3lJOKZg
         DB6y6v4rjE2lA4zzPU7PXnUm+euijpHSEkbBuEN+XXLxPReLAK9YjEJXaBli6tx66Q1i
         J+4V69HZfEEy9mX/V1qfBPIOoTpVf5d2Iz8fG8Q7U/GMqnUErEskYVeU1Mo1/pXlLXxu
         0/6g==
X-Gm-Message-State: APjAAAVOuDc77kJ3CtEFtpqjX/OsqnEbGnrkFuB8mSMCeZjI9ducNEPW
        GVuyMeDlH1X9o54a6w+W7aKcpA==
X-Google-Smtp-Source: APXvYqzU/bIQBcJg2Gt7EdZdXbFPnYCFb3BMzJY4gPrehtLJzBZQURQOE/bhXV7rJARTGRVp07TnKg==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr23361441plz.295.1576004344608;
        Tue, 10 Dec 2019 10:59:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1365? ([2620:10d:c090:180::b7af])
        by smtp.gmail.com with ESMTPSA id d22sm4405284pfo.187.2019.12.10.10.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 10:59:03 -0800 (PST)
Subject: Re: [PATCH] block: fix NULL pointer dereference in account statistics
 with IDE
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>
References: <20191210184704.24081-1-logang@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81ec258d-3bfe-f55a-ba55-83047743bbbe@kernel.dk>
Date:   Tue, 10 Dec 2019 11:59:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210184704.24081-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/19 11:47 AM, Logan Gunthorpe wrote:
> The IDE driver creates some passthru requests which never get
> submitted to the block layer in such a way that blk_account_io_start()
> gets called. However, the driver still calls __blk_mq_end_request() in
> ide_end_rq() which will call blk_account_io_completion() which tries
> to dereferences req->part which is never set. See ide_prep_sense() for
> an example of where these requests come from.
> 
> To fix this, blk_account_io_completion() and blk_account_io_done()
> should do nothing if req->part is not set.
> 
> The back trace of this bug is:
> 
>     BUG: kernel NULL pointer dereference, address: 000002ac
>     #PF: supervisor write access in kernel mode
>     #PF: error_code(0x0002) - not-present page
>     *pde = 00000000
>     Oops: 0002 [#1]
>     CPU: 0 PID: 237 Comm: kworker/0:1H Not tainted
>     5.4.0-rc2-00011-g48d9b0d43105e #1
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1
>     04/01/2014
>     Workqueue: kblockd drive_rq_insert_work
>     EIP: blk_account_io_completion+0x7a/0xf0
>     Code: 89 54 24 08 31 d2 89 4c 24 04 31 c9 c7 04 24 02 00 00 00 c1 ee
>     09 e8 f5 21 a6 ff e8 70 5c a7 ff 8b 53 60 8d 04 bd 00 00 00 00 <01> b4
>     02 ac 02 00 00 8b 9a 88 02 00 00 85 db 74 11 85 d2 74 51 8b
>     EAX: 00000000 EBX: f5b80000 ECX: 00000000 EDX: 00000000
>     ESI: 00000000 EDI: 00000000 EBP: f3031e70 ESP: f3031e54
>     DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010046
>     CR0: 80050033 CR2: 000002ac CR3: 03c25000 CR4: 000406d0
>     Call Trace:
>      <IRQ>
>       blk_update_request+0x85/0x420
>       ide_end_rq+0x38/0xa0
>       ide_complete_rq+0x3d/0x70
>       cdrom_newpc_intr+0x258/0xba0
>       ide_intr+0x135/0x250
>       __handle_irq_event_percpu+0x3e/0x250
>       handle_irq_event_percpu+0x1f/0x50
>       handle_irq_event+0x32/0x60
>       handle_level_irq+0x6c/0x110
>       handle_irq+0x72/0xa0
>       </IRQ>
>       do_IRQ+0x45/0xad
>       common_interrupt+0x115/0x11c

Why not just:

diff --git a/block/blk.h b/block/blk.h
index 6842f28c033e..d7407b5d0200 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -250,7 +250,7 @@ int blk_dev_init(void);
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
-	return rq->rq_disk && (rq->rq_flags & RQF_IO_STAT);
+	return rq->part && rq->rq_disk && (rq->rq_flags & RQF_IO_STAT);
 }
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)

-- 
Jens Axboe

