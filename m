Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89474C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B22207FF
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 19:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfLJTCe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:02:34 -0500
Received: from ale.deltatee.com ([207.54.116.67]:39734 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfLJTCe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 14:02:34 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iekmE-0000Ch-DB; Tue, 10 Dec 2019 12:02:31 -0700
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>
References: <20191210184704.24081-1-logang@deltatee.com>
 <81ec258d-3bfe-f55a-ba55-83047743bbbe@kernel.dk>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <eaa2c3ae-b71b-acca-32a0-494e545d60d9@deltatee.com>
Date:   Tue, 10 Dec 2019 12:02:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <81ec258d-3bfe-f55a-ba55-83047743bbbe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: rong.a.chen@intel.com, torvalds@linux-foundation.org, hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] block: fix NULL pointer dereference in account statistics
 with IDE
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-12-10 11:59 a.m., Jens Axboe wrote:
> On 12/10/19 11:47 AM, Logan Gunthorpe wrote:
>> The IDE driver creates some passthru requests which never get
>> submitted to the block layer in such a way that blk_account_io_start()
>> gets called. However, the driver still calls __blk_mq_end_request() in
>> ide_end_rq() which will call blk_account_io_completion() which tries
>> to dereferences req->part which is never set. See ide_prep_sense() for
>> an example of where these requests come from.
>>
>> To fix this, blk_account_io_completion() and blk_account_io_done()
>> should do nothing if req->part is not set.
>>
>> The back trace of this bug is:
>>
>>     BUG: kernel NULL pointer dereference, address: 000002ac
>>     #PF: supervisor write access in kernel mode
>>     #PF: error_code(0x0002) - not-present page
>>     *pde = 00000000
>>     Oops: 0002 [#1]
>>     CPU: 0 PID: 237 Comm: kworker/0:1H Not tainted
>>     5.4.0-rc2-00011-g48d9b0d43105e #1
>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1
>>     04/01/2014
>>     Workqueue: kblockd drive_rq_insert_work
>>     EIP: blk_account_io_completion+0x7a/0xf0
>>     Code: 89 54 24 08 31 d2 89 4c 24 04 31 c9 c7 04 24 02 00 00 00 c1 ee
>>     09 e8 f5 21 a6 ff e8 70 5c a7 ff 8b 53 60 8d 04 bd 00 00 00 00 <01> b4
>>     02 ac 02 00 00 8b 9a 88 02 00 00 85 db 74 11 85 d2 74 51 8b
>>     EAX: 00000000 EBX: f5b80000 ECX: 00000000 EDX: 00000000
>>     ESI: 00000000 EDI: 00000000 EBP: f3031e70 ESP: f3031e54
>>     DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010046
>>     CR0: 80050033 CR2: 000002ac CR3: 03c25000 CR4: 000406d0
>>     Call Trace:
>>      <IRQ>
>>       blk_update_request+0x85/0x420
>>       ide_end_rq+0x38/0xa0
>>       ide_complete_rq+0x3d/0x70
>>       cdrom_newpc_intr+0x258/0xba0
>>       ide_intr+0x135/0x250
>>       __handle_irq_event_percpu+0x3e/0x250
>>       handle_irq_event_percpu+0x1f/0x50
>>       handle_irq_event+0x32/0x60
>>       handle_level_irq+0x6c/0x110
>>       handle_irq+0x72/0xa0
>>       </IRQ>
>>       do_IRQ+0x45/0xad
>>       common_interrupt+0x115/0x11c
> 
> Why not just:
> 
> diff --git a/block/blk.h b/block/blk.h
> index 6842f28c033e..d7407b5d0200 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -250,7 +250,7 @@ int blk_dev_init(void);
>   */
>  static inline bool blk_do_io_stat(struct request *rq)
>  {
> -	return rq->rq_disk && (rq->rq_flags & RQF_IO_STAT);
> +	return rq->part && rq->rq_disk && (rq->rq_flags & RQF_IO_STAT);
>  }

Because blk_account_io_start() also checks blk_do_io_stat() and, in that
case, rq->part will never be set (seeing that's the function that
typically sets it); thus that solution would disable stats entirely.

Logan
