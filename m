Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA32C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FBC21A49
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 09:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLJDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:03:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:34856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727321AbfKLJDW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 04:03:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13748AC4D;
        Tue, 12 Nov 2019 09:03:19 +0000 (UTC)
Subject: Re: [PATCH] block: check bi_size overflow before merge
To:     Ming Lei <ming.lei@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
 <20191112084617.GA26804@ming.t460p>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 mQINBE6KyREBEACwRN6XKClPtxPiABx5GW+Yr1snfhjzExxkTYaINHsWHlsLg13kiemsS6o7
 qrc+XP8FmhcnCOts9e2jxZxtmpB652lxRB9jZE40mcSLvYLM7S6aH0WXKn8bOqpqOGJiY2bc
 6qz6rJuqkOx3YNuUgiAxjuoYauEl8dg4bzex3KGkGRuxzRlC8APjHlwmsr+ETxOLBfUoRNuE
 b4nUtaseMPkNDwM4L9+n9cxpGbdwX0XwKFhlQMbG3rWA3YqQYWj1erKIPpgpfM64hwsdk9zZ
 QO1krgfULH4poPQFpl2+yVeEMXtsSou915jn/51rBelXeLq+cjuK5+B/JZUXPnNDoxOG3j3V
 VSZxkxLJ8RO1YamqZZbVP6jhDQ/bLcAI3EfjVbxhw9KWrh8MxTcmyJPn3QMMEp3wpVX9nSOQ
 tzG72Up/Py67VQe0x8fqmu7R4MmddSbyqgHrab/Nu+ak6g2RRn3QHXAQ7PQUq55BDtj85hd9
 W2iBiROhkZ/R+Q14cJkWhzaThN1sZ1zsfBNW0Im8OVn/J8bQUaS0a/NhpXJWv6J1ttkX3S0c
 QUratRfX4D1viAwNgoS0Joq7xIQD+CfJTax7pPn9rT////hSqJYUoMXkEz5IcO+hptCH1HF3
 qz77aA5njEBQrDRlslUBkCZ5P+QvZgJDy0C3xRGdg6ZVXEXJOQARAQABtCpIYW5uZXMgUmVp
 bmVja2UgKFN1U0UgTGFicykgPGhhcmVAc3VzZS5kZT6JAkEEEwECACsCGwMFCRLMAwAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJOisquAhkBAAoJEGz4yi9OyKjPOHoQAJLeLvr6JNHx
 GPcHXaJLHQiinz2QP0/wtsT8+hE26dLzxb7hgxLafj9XlAXOG3FhGd+ySlQ5wSbbjdxNjgsq
 FIjqQ88/Lk1NfnqG5aUTPmhEF+PzkPogEV7Pm5Q17ap22VK623MPaltEba+ly6/pGOODbKBH
 ak3gqa7Gro5YCQzNU0QVtMpWyeGF7xQK76DY/atvAtuVPBJHER+RPIF7iv5J3/GFIfdrM+wS
 BubFVDOibgM7UBnpa7aohZ9RgPkzJpzECsbmbttxYaiv8+EOwark4VjvOne8dRaj50qeyJH6
 HLpBXZDJH5ZcYJPMgunghSqghgfuUsd5fHmjFr3hDb5EoqAfgiRMSDom7wLZ9TGtT6viDldv
 hfWaIOD5UhpNYxfNgH6Y102gtMmN4o2P6g3UbZK1diH13s9DA5vI2mO2krGz2c5BOBmcctE5
 iS+JWiCizOqia5Op+B/tUNye/YIXSC4oMR++Fgt30OEafB8twxydMAE3HmY+foawCpGq06yM
 vAguLzvm7f6wAPesDAO9vxRNC5y7JeN4Kytl561ciTICmBR80Pdgs/Obj2DwM6dvHquQbQrU
 Op4XtD3eGUW4qgD99DrMXqCcSXX/uay9kOG+fQBfK39jkPKZEuEV2QdpE4Pry36SUGfohSNq
 xXW+bMc6P+irTT39VWFUJMcSuQINBE6KyREBEACvEJggkGC42huFAqJcOcLqnjK83t4TVwEn
 JRisbY/VdeZIHTGtcGLqsALDzk+bEAcZapguzfp7cySzvuR6Hyq7hKEjEHAZmI/3IDc9nbdh
 EgdCiFatah0XZ/p4vp7KAelYqbv8YF/ORLylAdLh9rzLR6yHFqVaR4WL4pl4kEWwFhNSHLxe
 55G56/dxBuoj4RrFoX3ynerXfbp4dH2KArPc0NfoamqebuGNfEQmDbtnCGE5zKcR0zvmXsRp
 qU7+caufueZyLwjTU+y5p34U4PlOO2Q7/bdaPEdXfpgvSpWk1o3H36LvkPV/PGGDCLzaNn04
 BdiiiPEHwoIjCXOAcR+4+eqM4TSwVpTn6SNgbHLjAhCwCDyggK+3qEGJph+WNtNU7uFfscSP
 k4jqlxc8P+hn9IqaMWaeX9nBEaiKffR7OKjMdtFFnBRSXiW/kOKuuRdeDjL5gWJjY+IpdafP
 KhjvUFtfSwGdrDUh3SvB5knSixE3qbxbhbNxmqDVzyzMwunFANujyyVizS31DnWC6tKzANkC
 k15CyeFC6sFFu+WpRxvC6fzQTLI5CRGAB6FAxz8Hu5rpNNZHsbYs9Vfr/BJuSUfRI/12eOCL
 IvxRPpmMOlcI4WDW3EDkzqNAXn5Onx/b0rFGFpM4GmSPriEJdBb4M4pSD6fN6Y/Jrng/Bdwk
 SQARAQABiQIlBBgBAgAPBQJOiskRAhsMBQkSzAMAAAoJEGz4yi9OyKjPgEwQAIP/gy/Xqc1q
 OpzfFScswk3CEoZWSqHxn/fZasa4IzkwhTUmukuIvRew+BzwvrTxhHcz9qQ8hX7iDPTZBcUt
 ovWPxz+3XfbGqE+q0JunlIsP4N+K/I10nyoGdoFpMFMfDnAiMUiUatHRf9Wsif/nT6oRiPNJ
 T0EbbeSyIYe+ZOMFfZBVGPqBCbe8YMI+JiZeez8L9JtegxQ6O3EMQ//1eoPJ5mv5lWXLFQfx
 f4rAcKseM8DE6xs1+1AIsSIG6H+EE3tVm+GdCkBaVAZo2VMVapx9k8RMSlW7vlGEQsHtI0FT
 c1XNOCGjaP4ITYUiOpfkh+N0nUZVRTxWnJqVPGZ2Nt7xCk7eoJWTSMWmodFlsKSgfblXVfdM
 9qoNScM3u0b9iYYuw/ijZ7VtYXFuQdh0XMM/V6zFrLnnhNmg0pnK6hO1LUgZlrxHwLZk5X8F
 uD/0MCbPmsYUMHPuJd5dSLUFTlejVXIbKTSAMd0tDSP5Ms8Ds84z5eHreiy1ijatqRFWFJRp
 ZtWlhGRERnDH17PUXDglsOA08HCls0PHx8itYsjYCAyETlxlLApXWdVl9YVwbQpQ+i693t/Y
 PGu8jotn0++P19d3JwXW8t6TVvBIQ1dRZHx1IxGLMn+CkDJMOmHAUMWTAXX2rf5tUjas8/v2
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <56841826-f00a-0ff3-ecae-c0d4360fb232@suse.de>
Date:   Tue, 12 Nov 2019 10:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191112084617.GA26804@ming.t460p>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/19 9:46 AM, Ming Lei wrote:
> On Tue, Nov 12, 2019 at 07:19:58AM +0000, Junichi Nomura wrote:
>> __bio_try_merge_page() may merge a page to bio without bio_full() check
>> and cause bi_size overflow.
>>
>> The overflow typically ends up with sd_init_command() warning on zero
>> segment request with call trace like this:
>>
>>     ------------[ cut here ]------------
>>     WARNING: CPU: 2 PID: 1986 at drivers/scsi/scsi_lib.c:1025 scsi_init_io+0x156/0x180
>>     CPU: 2 PID: 1986 Comm: kworker/2:1H Kdump: loaded Not tainted 5.4.0-rc7 #1
>>     Workqueue: kblockd blk_mq_run_work_fn
>>     RIP: 0010:scsi_init_io+0x156/0x180
>>     RSP: 0018:ffffa11487663bf0 EFLAGS: 00010246
>>     RAX: 00000000002be0a0 RBX: ffff8e6e9ff30118 RCX: 0000000000000000
>>     RDX: 00000000ffffffe1 RSI: 0000000000000000 RDI: ffff8e6e9ff30118
>>     RBP: ffffa11487663c18 R08: ffffa11487663d28 R09: ffff8e6e9ff30150
>>     R10: 0000000000000001 R11: 0000000000000000 R12: ffff8e6e9ff30000
>>     R13: 0000000000000001 R14: ffff8e74a1cf1800 R15: ffff8e6e9ff30000
>>     FS:  0000000000000000(0000) GS:ffff8e6ea7680000(0000) knlGS:0000000000000000
>>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>     CR2: 00007fff18cf0fe8 CR3: 0000000659f0a001 CR4: 00000000001606e0
>>     Call Trace:
>>      sd_init_command+0x326/0xb40 [sd_mod]
>>      scsi_queue_rq+0x502/0xaa0
>>      ? blk_mq_get_driver_tag+0xe7/0x120
>>      blk_mq_dispatch_rq_list+0x256/0x5a0
>>      ? elv_rb_del+0x24/0x30
>>      ? deadline_remove_request+0x7b/0xc0
>>      blk_mq_do_dispatch_sched+0xa3/0x140
>>      blk_mq_sched_dispatch_requests+0xfb/0x170
>>      __blk_mq_run_hw_queue+0x81/0x130
>>      blk_mq_run_work_fn+0x1b/0x20
>>      process_one_work+0x179/0x390
>>      worker_thread+0x4f/0x3e0
>>      kthread+0x105/0x140
>>      ? max_active_store+0x80/0x80
>>      ? kthread_bind+0x20/0x20
>>      ret_from_fork+0x35/0x40
>>     ---[ end trace f9036abf5af4a4d3 ]---
>>     blk_update_request: I/O error, dev sdd, sector 2875552 op 0x1:(WRITE) flags 0x0 phys_seg 0 prio class 0
>>     XFS (sdd1): writeback error on sector 2875552
>>
>> __bio_try_merge_page() should check the overflow before actually doing
>> merge.
>>
>> Fixes: 07173c3ec276c ("block: enable multipage bvecs")
>> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> Cc: Jens Axboe <axboe@kernel.dk>
>>
>> diff --git a/block/bio.c b/block/bio.c
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -751,7 +751,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
>>  	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>>  		return false;
>>  
>> -	if (bio->bi_vcnt > 0) {
>> +	if (bio->bi_vcnt > 0 && !bio_full(bio, len)) {
>>  		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
>>  
>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {
>>
> 
> Looks fine:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
Oh f**k.
That is the bug I've been hunting for years now.
Thanks Junichi!

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
