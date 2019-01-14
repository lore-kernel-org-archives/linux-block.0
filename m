Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50599C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 12:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF3220656
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 12:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfANMCw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:02:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44121 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfANMCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 07:02:52 -0500
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1gj0x7-0008Bj-TK
        for linux-block@vger.kernel.org; Mon, 14 Jan 2019 12:02:49 +0000
Received: by mail-qk1-f198.google.com with SMTP id b185so16511958qkc.3
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 04:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:cc:to:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+pynt6QMEEup01J5ik4WKrC7TTQX1Y8jwuXqqHNOKM8=;
        b=OguEbSpSM/oWEqcLWSuFnj2Tx6euRw2ysOZKYGcJjw3n8n+soI9QXgKRyivTXCixaq
         +qmnhaOR+FwRlSNJfX5yX8SQXxH7R4lo72LWiVR+IIB2IalV8zHSmWgNDmdE1uxCgxfp
         FupKFSig0lN1wkOTgdmdwqVAa81GNyIkunSm0kP9BNphmbOQcHiIf7J4g4uWLuJaEDhB
         duR/WQ4xNz0VF/tj83FV27sb/M6Wd8PwYTcGMgNMRyAHFYoCoBElMBUoGN/lvuPwLIDD
         ZjsyA5E0eNo5oI2VIX70IZH1OPBPr4WuPx4vkSWRp0yXAEBue86O/FGkd78v7q93M6Qn
         r3SA==
X-Gm-Message-State: AJcUukdaYtYZDduRIEK9dFKJfMpQuWtcTf9clWKx16mwqZlxBHTO9dZ0
        A+SzS31Anps3apXZ1TzgLkUmrD9VpVOnmxC0MFhoQEImoMXusPxoYERSD6Vs8tZsKFc1Z8aEFMB
        OEH81jJyDYTUt+lTKod/I2Ef+RUSjunqzgcylyPm6
X-Received: by 2002:ac8:71d0:: with SMTP id i16mr24104160qtp.386.1547467369032;
        Mon, 14 Jan 2019 04:02:49 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7OhvCYxcRYSQ3r1fa5Ii935iDhOJUV5pxvSrOk/vIkYQ2E+LIwD6lr0QYJ3TYqVkslIaV+iQ==
X-Received: by 2002:ac8:71d0:: with SMTP id i16mr24104133qtp.386.1547467368732;
        Mon, 14 Jan 2019 04:02:48 -0800 (PST)
Received: from [192.168.1.206] ([191.13.50.232])
        by smtp.gmail.com with ESMTPSA id o75sm24096931qki.97.2019.01.14.04.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 04:02:47 -0800 (PST)
Subject: Re: NULL ptr deref in blk_queue_split with bcache: bio->bi_io_vec ==
 NULL
References: <87zhs3ogd6.fsf@linkitivity.dja.id.au>
Cc:     Daniel Axtens <dja@axtens.net>, Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org,
        Mauricio Oliveira <mauricio.oliveira@canonical.com>,
        gpiccoli@canonical.com
To:     linux-block@vger.kernel.org
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <a2eee193-df00-047e-0600-61e6b96ff824@canonical.com>
Date:   Mon, 14 Jan 2019 10:02:43 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87zhs3ogd6.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/01/2019 05:20, Daniel Axtens wrote:
> Hi,
> 
> We have a couple of machines that are experiencing NULL pointer
> dereferences when executing fstrim.
> 
> It can be reliably reproduced on at least:
>  - HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 12/27/2015
>  - Cisco Systems Inc UCSC-C240-M5L/UCSC-C240-M5L
> 
> In both cases we have:
> 1) LVM/devmapper involved (bcache backing device is LVM volume) 
> 2) writeback cache involved (bcache cache_mode is writeback) 
> 
> On the HP box, we can reliably reproduce it with:
> 
> # echo writeback > /sys/block/bcache0/bcache/cache_mode # not sure if this is required
> # mount /dev/bcache0 /test 
> # for i in {0..10}; do file="$(mktemp /test/zero.XXX)"; dd if=/dev/zero of="$file" bs=1M count=256; sync; rm $file; done; fstrim -v /test 
> This has been Oopsing in the first try.
> 
> We have seen it on mainline (commit 40a31da), and as far back as v4.15.
> 
> The panic reads as follows:
> 
> [  421.796849] EXT4-fs (bcache0): mounted filesystem with ordered data mode. Opts: (null)
> [  529.803060] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [  530.183928] #PF error: [normal kernel read fault]
> [  530.412392] PGD 8000001f42163067 P4D 8000001f42163067 PUD 1f42168067 PMD 0 
> [  530.750887] Oops: 0000 [#1] SMP PTI
> [  530.920869] CPU: 10 PID: 4167 Comm: fstrim Kdump: loaded Not tainted 5.0.0-rc1+ #3
> [  531.290204] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 12/27/2015
> [  531.693137] RIP: 0010:blk_queue_split+0x148/0x620
> [  531.922205] Code: 60 38 89 55 a0 45 31 db 45 31 f6 45 31 c9 31 ff 89 4d 98 85 db 0f 84 7f 04 00 00 44 8b 6d 98 4c 89 ee 48 c1 e6 04 49 03 70 78 <8b> 46 08 44 8b 56 0c 48 8b 16 44 29 e0 39 d8 48 89 55 a8 0f 47 c3
> [  532.838634] RSP: 0018:ffffb9b708df39b0 EFLAGS: 00010246
> [  533.093571] RAX: 00000000ffffffff RBX: 0000000000046000 RCX: 0000000000000000
> [  533.441865] RDX: 0000000000000200 RSI: 0000000000000000 RDI: 0000000000000000
> [  533.789922] RBP: ffffb9b708df3a48 R08: ffff940d3b3fdd20 R09: 0000000000000000
> [  534.137512] R10: ffffb9b708df3958 R11: 0000000000000000 R12: 0000000000000000
> [  534.485329] R13: 0000000000000000 R14: 0000000000000000 R15: ffff940d39212020
> [  534.833319] FS:  00007efec26e3840(0000) GS:ffff940d1f480000(0000) knlGS:0000000000000000
> [  535.224098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  535.504318] CR2: 0000000000000008 CR3: 0000001f4e256004 CR4: 00000000001606e0
> [  535.851759] Call Trace:
> [  535.970308]  ? mempool_alloc_slab+0x15/0x20
> [  536.174152]  ? bch_data_insert+0x42/0xd0 [bcache]
> [  536.403399]  blk_mq_make_request+0x97/0x4f0
> [  536.607036]  generic_make_request+0x1e2/0x410
> [  536.819164]  submit_bio+0x73/0x150
> [  536.980168]  ? submit_bio+0x73/0x150
> [  537.149731]  ? bio_associate_blkg_from_css+0x3b/0x60
> [  537.391595]  ? _cond_resched+0x1a/0x50
> [  537.573774]  submit_bio_wait+0x59/0x90
> [  537.756105]  blkdev_issue_discard+0x80/0xd0
> [  537.959590]  ext4_trim_fs+0x4a9/0x9e0
> [  538.137636]  ? ext4_trim_fs+0x4a9/0x9e0
> [  538.324087]  ext4_ioctl+0xea4/0x1530
> [  538.497712]  ? _copy_to_user+0x2a/0x40
> [  538.679632]  do_vfs_ioctl+0xa6/0x600
> [  538.853127]  ? __do_sys_newfstat+0x44/0x70
> [  539.051951]  ksys_ioctl+0x6d/0x80
> [  539.212785]  __x64_sys_ioctl+0x1a/0x20
> [  539.394918]  do_syscall_64+0x5a/0x110
> [  539.568674]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Looking at the disassembly for blk_queue_split, it appears that the
> issue is that bi_io_vec is NULL.  The address of the bio is in r8, and
> indeed bi_io_vec is NULL:
> 
> crash> struct bio ffff940d3b3fdd20
> struct bio {
>   bi_next = 0x0, 
>   bi_disk = 0xffff940c17c56800, 
>   bi_opf = 1, 
>   bi_flags = 1540, 
>   bi_ioprio = 0, 
>   bi_write_hint = 0, 
>   bi_status = 0 '\000', 
>   bi_partno = 0 '\000', 
>   bi_phys_segments = 0, 
>   bi_seg_front_size = 0, 
>   bi_seg_back_size = 0, 
>   bi_iter = {
>     bi_sector = 212452816, 
>     bi_size = 286720, 
>     bi_idx = 0, 
>     bi_bvec_done = 0
>   }, 
>   __bi_remaining = {
>     counter = 1
>   }, 
>   bi_end_io = 0xffffffffc0455810 <bch_data_insert_endio>, 
>   bi_private = 0xffff940c04f698a0, 
>   bi_blkg = 0xffff940c129a7400, 
>   bi_issue = {
>     value = 1261008425052734119
>   }, 
>   {
>     bi_integrity = 0x0
>   }, 
>   bi_vcnt = 0, 
>   bi_max_vecs = 0, 
>   __bi_cnt = {
>     counter = 1
>   }, 
>   bi_io_vec = 0x0, 
>   bi_pool = 0xffff940d3a280de0, 
>   bi_inline_vecs = 0xffff940d3b3fdda8
> }
> 
> 
> The stack being a bit odd, we used ftrace to get a function graph
> trace. That clarified things a bit - here is the chronology:
> 
> Looking at generic_make_request(), we see:
> 
> 	bio_list_init(&bio_list_on_stack[0]);
> 	current->bio_list = bio_list_on_stack;
> 	do {
> 		struct request_queue *q = bio->bi_disk->queue;
> 		blk_mq_req_flags_t flags = bio->bi_opf & REQ_NOWAIT ?
> 			BLK_MQ_REQ_NOWAIT : 0;
> 
> 		if (likely(blk_queue_enter(q, flags) == 0)) {
> 			struct bio_list lower, same;
> 
> 			/* Create a fresh bio_list for all subordinate requests */
> 			bio_list_on_stack[1] = bio_list_on_stack[0];
> 			bio_list_init(&bio_list_on_stack[0]);
> 			ret = q->make_request_fn(q, bio);
> 
> On the first iteration of the loop, q->make_request_function invokes
> cached_dev_make_request(). That calls generic_make_request a few times -
> making what I understand to be requests to write out to the underlying
> device. Then cached_dev_make_request returns, and in the next iteration
> of the loop, one of the new entries is pulled off the list,
> blk_mq_make_request attempts to call blk_queue_split on it, and that
> explodes.
> 
> I'm not quite sure why the new bios have bi_io_vec as NULL - it would
> seem to imply the original bio had it as NULL too. I don't know why
> that would be and I haven't been able to trace that far backwards just
> yet.
> 
> I'm having some trouble unpicking the closures that make up bcache, so
> I was hoping someone would be able to point me in the right direction?
> 
> As I said, we can reproduce this easily so we're happy to gather any
> extra information required or test anything.
> 
> Regards,
> Daniel
> 


+linux-block

Cheers,


Guilherme
