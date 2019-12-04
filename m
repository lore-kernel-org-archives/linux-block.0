Return-Path: <SRS0=bBnE=Z2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27778C43603
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 09:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC86720803
	for <linux-block@archiver.kernel.org>; Wed,  4 Dec 2019 09:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gucdqSjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfLDJ4T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:56:19 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20593 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfLDJ4S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 04:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575453378; x=1606989378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MMrvsNDMLWAbO9MEILS+TGm8he4BEQEN8YqOwckuQ28=;
  b=gucdqSjonYHQmMsCEWVSWqqYZ60hnejCFCtCMs42PjMRTscBaQ2PskhT
   6v6OztecqDdn+PPbbSRUite9MFB0MiKPM36887bCXfOnastvJqwykabVz
   pnIqktXz30ocPRLHAJ1HwsMzeK31M3YtUwd5f8sC5uSeoN8oynSub0fzj
   FnTs0bKLah8DBCtByL9U57AphoeNpbdOC900opNIMYn6/3G4nhInt+W6H
   nZIhbO/EMSH8WwiBkZ3nodCtD62zeu4GvXrklYJR0LsjV/eNDuE6DATni
   b7dp3yHjy3whOKxbgPQhYy4lPXsboTRWM11WArGEGSjdlWLMkvka5XjYr
   A==;
IronPort-SDR: aKXmKjVRUkKE8iwJNshlIPLRqo6g+AtE8o9yo0fAmaj0VEFHYz1u3hRJoPhJTRPwBavB8x+1Fe
 kVdQCqU6xfBXK+CJxcWXtmkZ15SZaDd8qWm+HnA7JtuFFhnXnTrS9arEn8VlfzO4fghjj151T7
 beLltUwUNXhgNhskCYgRRkr7RCIBOFVwaqNUPDIZBuB14MsuSe3C9/tRKlFcqPADKwm/supzFY
 dIPS+wguCW6Q7Y716qLtuoI6/osLlmdu8EOAacseQ1mor0EJLhoIXJQbkumQGzzxWaIvSgSayN
 BaM=
X-IronPort-AV: E=Sophos;i="5.69,277,1571673600"; 
   d="scan'208";a="125363481"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 17:56:18 +0800
IronPort-SDR: WEUnwhIVQYIKrP2/Kxc7b0dvSWUALKTptRDdbg6PgBcjfKm+SHNhakENdN+ZMCfHp8M9M5K9Qm
 0u/F+5ot23YO9s7ewqEUcyOv9VojB+zTASL7LGRqluIBv4hdZJ+RNFRjEh4agVJSJYC7E38qOQ
 8CiuMNqFHztXRJHvGhgxGE4mVnB9A2Wjv74fvWS/r4+SjjenGr9Qw6luSuoPNCwMN31NnospxN
 Omv8PdcZEIa6lYlN1pyrx8/OeXAK8PKcDI7zrkG9DpudOgh87aOWpOi8Er0NQ9Q+uTgVkH57ah
 My2mqd3hjg9qtKINaqL698UX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 01:51:05 -0800
IronPort-SDR: 2+0hE7nYdSw2DI7ET7vzyzVgDLnT6I53JDmEJH5Nsy1KZSawtvq8njkWFl9HdZra7trNIVvI9+
 +C3jml8b1i7kk66snO1rJW0Yl6flU2QlI60KsHSx9tad1F7Ls6eiIwTonTvkZFRABdIm7iXkCT
 P4qkpuriPOl+U1UUmICciYWBWYGIFFp7jwfuppSvxWFB86hsMWVYpUlBX0QhqvxfmBZexH07Vb
 AtXjBp9ii+mFLhHRWztk6f9NNxjx5ozr6XIrvjCdyH49tnHx9XC7LLjcEviRXPwCZTpiYRQJoW
 DC4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with SMTP; 04 Dec 2019 01:56:16 -0800
Received: (nullmailer pid 1154193 invoked by uid 1000);
        Wed, 04 Dec 2019 09:56:15 -0000
Date:   Wed, 4 Dec 2019 18:56:15 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        takafumi.kubota1012@sslab.ics.keio.ac.jp
Subject: Re: [PATCH] block/genhd: Fix memory leak in error path of
 __alloc_disk_node()
Message-ID: <20191204095615.m3bgg276re3qlzzm@naota>
References: <20191127024057.5827-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191127024057.5827-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

I think you can also add:

Fixes: 6c71013ecb7e ("block: partition: convert percpu ref")

On Wed, Nov 27, 2019 at 02:40:57AM +0000, Keita Suzuki wrote:
>'disk->part_tbl' is malloced in disk_expand_part_tbl() and should be
>freed before leaving from the error handling cases. However, current code
>does not free this, causing a memory leak. Add disk_replace_part_tbl()
>before freeing 'disk'.
>
>I have tested this by randomly causing failures to the target code,
>and verified on kmemleak that this memory leak does occur.
>
>unreferenced object 0xffff888006dad500 (size 64):
>  comm "systemd-udevd", pid 116, jiffies 4294895558 (age 121.716s)
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  backtrace:
>    [<00000000eec79bf3>] disk_expand_part_tbl+0xab/0x170
>    [<00000000624e7d03>] __alloc_disk_node+0xb1/0x1c0
>    [<00000000ca3f4185>] 0xffffffffc01b8584
>    [<000000006f88a6ee>] do_one_initcall+0x8b/0x2a4
>    [<0000000016058199>] do_init_module+0xfd/0x380
>    [<00000000b6fde336>] load_module+0x3fae/0x4240
>    [<00000000c523d013>] __do_sys_finit_module+0x11a/0x1b0
>    [<00000000f07bba26>] do_syscall_64+0x6d/0x1e0
>    [<00000000979467fd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
>---
> block/genhd.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/block/genhd.c b/block/genhd.c
>index ff6268970ddc..8c4b63d7f507 100644
>--- a/block/genhd.c
>+++ b/block/genhd.c
>@@ -1504,6 +1504,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
> 		 */
> 		seqcount_init(&disk->part0.nr_sects_seq);
> 		if (hd_ref_init(&disk->part0)) {
>+			disk_replace_part_tbl(disk, NULL);
> 			hd_free_part(&disk->part0);
> 			kfree(disk);
> 			return NULL;
>-- 
>2.17.1
>
