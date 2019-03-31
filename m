Return-Path: <SRS0=bw4W=SC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15622C10F00
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 03:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6F820881
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 03:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgs8789z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfCaDLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Mar 2019 23:11:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41288 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbfCaDLs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Mar 2019 23:11:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so7366657wrq.8;
        Sat, 30 Mar 2019 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BXAx0oPinNF+csSL1VCs9lI63B1cXxXTyYtnihNhOk=;
        b=hgs8789zDdI281nC66/ObhkUviSxQnWoZm8NQts2t3Egq4LGTmFv58E1lrZ8NYDJQ2
         +Yktj7DcZHzEOFbts290NJdtNICCb0Z97C/cKgNk+TIo0bKCSIVbVWn9Iuk8LzZzNiaX
         8tA/b3Di8SrcLxn0Ts0F8gvff6b9U9cJA33oDCnNqaXyvss+YZE/vvLLQsOdCokHnMAC
         /Tej9op5DeDwLQ0AhrIgP4o3dmlLYcbas9tujEAZ9URyYFOBn9jmUBSwc+ofwu/ZuIAp
         tbiFciX+zYcab4CcNmdwrYALVdOu0EcspOw8m+3ER+1RdCM8npxPBNi3DXQ9bs0Tq9r0
         Q/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BXAx0oPinNF+csSL1VCs9lI63B1cXxXTyYtnihNhOk=;
        b=arG72ej0QmcU8gFBC4/44peIXnlMvNAJaZTcEkwfqF6QDYoexLGH3CtnLYHvzcOjrT
         4YEe/vzM7d0V9JYZzYfzp5tc7DTmr6Tq7JJ8eFybPdKvizbYR0Ref5jERl1PbWhRLAn3
         iIY85jY4Ry604sBj1NMn0LEIsQB7xFfEEMVtbAyejGubIW/4ajsJZWjY0gJruqo8Tj3h
         5eT8M4g6B2PKYqtjaEjNOhQODuBIXSy6M9+HebD7dUagjw2Cu5gucJZsa0WbyINlqvSQ
         4SVLWmfDD3fHVTLsBbnv2Ii5zUMkorMHcdTT0D3nlJsCZqAgEpgwJlUoNLXwrG/xhVTo
         cegQ==
X-Gm-Message-State: APjAAAUCXLerQA86tU+MZop/rxhCDiw/NhWaVzW3AH2PakWRy6lzzf/w
        /xI3I9HDvOThOZ33lHcH9MsEN8Oqs+rqiScnaxY=
X-Google-Smtp-Source: APXvYqyrTZCEKOran2JekYmCJtF2HORbcTUQIQXsh67ycNOGFuQFmbCuZCd3nVpxBXz1BqpaiA7EA+9rI/l73htHZMs=
X-Received: by 2002:adf:b60a:: with SMTP id f10mr34924757wre.116.1554001905970;
 Sat, 30 Mar 2019 20:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181114082551.12141-1-ming.lei@redhat.com> <63c063ad-7d74-4268-bfd4-2de89908949e@kernel.dk>
 <4e24ace9-c83f-5311-5419-18f4a0fb5148@kernel.dk> <20181122010034.GA20814@ming.t460p>
 <dc374ec8-2ea2-0792-4677-0ae81fa7826e@kernel.dk> <baba41b1-8495-8bd1-0bea-341d207852a7@broadcom.com>
In-Reply-To: <baba41b1-8495-8bd1-0bea-341d207852a7@broadcom.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sun, 31 Mar 2019 11:11:33 +0800
Message-ID: <CACVXFVNRd7+C9ASNex8DY5eK+Cq4Y4d+hd-rhvLcLcWn9whh4Q@mail.gmail.com>
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
To:     James Smart <james.smart@broadcom.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 30, 2019 at 4:21 AM James Smart <james.smart@broadcom.com> wrote:
>
>
>
> On 11/21/2018 5:42 PM, Jens Axboe wrote:
> > On 11/21/18 6:00 PM, Ming Lei wrote:
> >> On Wed, Nov 21, 2018 at 02:47:35PM -0700, Jens Axboe wrote:
> >>> On 11/14/18 8:20 AM, Jens Axboe wrote:
> >>>> On 11/14/18 1:25 AM, Ming Lei wrote:
> >>>>> c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
> >>>>> already fixed this race, however the implied synchronize_rcu()
> >>>>> in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
> >>>>> performance regression.
> >>>>>
> >>>>> Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
> >>>>> tried to quiesce queue for avoiding unnecessary synchronize_rcu()
> >>>>> only when queue initialization is done, because it is usual to see
> >>>>> lots of inexistent LUNs which need to be probed.
> >>>>>
> >>>>> However, turns out it isn't safe to quiesce queue only when queue
> >>>>> initialization is done. Because when one SCSI command is completed,
> >>>>> the user of sending command can be waken up immediately, then the
> >>>>> scsi device may be removed, meantime the run queue in scsi_end_request()
> >>>>> is still in-progress, so kernel panic can be caused.
> >>>>>
> >>>>> In Red Hat QE lab, there are several reports about this kind of kernel
> >>>>> panic triggered during kernel booting.
> >>>>>
> >>>>> This patch tries to address the issue by grabing one queue usage
> >>>>> counter during freeing one request and the following run queue.
> >>>> Thanks applied, this bug was elusive but ever present in recent
> >>>> testing that we did internally, it's been a huge pain in the butt.
> >>>> The symptoms were usually a crash in blk_mq_get_driver_tag() with
> >>>> hctx->tags == NULL, or a crash inside deadline request insert off
> >>>> requeue.
>
> All,
>
> We are seeing errors with the following error:
>
> [44492.814347] BUG: unable to handle kernel NULL pointer dereference at
> (null)
> [44492.814383] IP: [<ffffffff8135a10b>] sbitmap_any_bit_set+0xb/0x30
> ...
> [44492.815634] Call Trace:
> [44492.815652]  [<ffffffff81303a88>] blk_mq_run_hw_queues+0x48/0x90
> [44492.819755]  [<ffffffff813053cc>] blk_mq_requeue_work+0x10c/0x120
> [44492.819777]  [<ffffffff81098cb4>] process_one_work+0x154/0x410
> [44492.819781]  [<ffffffff81099896>] worker_thread+0x116/0x4a0
> [44492.819784]  [<ffffffff8109edb9>] kthread+0xc9/0xe0
> [44492.819790]  [<ffffffff81619b05>] ret_from_fork+0x55/0x80
> [44492.822798] DWARF2 unwinder stuck at ret_from_fork+0x55/0x80
> [44492.822798]
> [44492.822799] Leftover inexact backtrace:
>
> [44492.822802]  [<ffffffff8109ecf0>] ? kthread_park+0x50/0x50
> [44492.822818] Code: c6 44 0f 46 ce 83 c2 01 45 89 ca 4c 89 54 01 08 48
> 8b 4f
> 10 2b 74 01 08 39 57 08 77 d8 f3 c3 90 8b 4f 08 85 c9 74 1f 48 8b 57 10
> <48> 83
> 3a 00 75 18 31 c0 eb 0a 48 83 c2 40 48 83 3a 00 75 0a 83
> [44492.822820] RIP  [<ffffffff8135a10b>] sbitmap_any_bit_set+0xb/0x30
> [44492.822821]  RSP <ffff8807219ffdd8>
> [44492.822821] CR2: 0000000000000000
>
> It appears the queue has been freed thus the bitmap is bad.
>
> Looking at the commit relative to this email thread:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/scsi/scsi_lib.c?id=8dc765d438f1e42b3e8227b3b09fad7d73f4ec9a
>
> It's interesting that the queue reference taken was released after the
> kblockd_schedule_work() call was made, and it's this work element that
> is hitting the issue. So perhaps the patch missed keeping the reference
> until the requeue_work item finished ?

Hi James,

Please test the following patchset:

https://lore.kernel.org/linux-block/20190331030954.22320-1-ming.lei@redhat.com/T/#u


Thanks.
Ming Lei
