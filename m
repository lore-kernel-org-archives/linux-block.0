Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D20C61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 11:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C282084C
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 11:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfASLDt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:03:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727790AbfASLDt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 06:03:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0ED62AE6E;
        Sat, 19 Jan 2019 11:03:47 +0000 (UTC)
Subject: Re: [PATCH] bcache: never writeback a discard operation
To:     Daniel Axtens <dja@axtens.net>
Cc:     "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-bcache@vger.kernel.org,
        Mauricio Oliveira <mauricio.oliveira@canonical.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20190118051825.18196-1-dja@axtens.net>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <b269c2f9-91fe-3b61-75e7-f319ba2b39de@suse.de>
Date:   Sat, 19 Jan 2019 19:03:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118051825.18196-1-dja@axtens.net>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2019/1/18 ÏÂÎç1:18, Daniel Axtens Ð´µÀ:
> Some users see panics like the following when performing fstrim on a bcached volume:
> 
> [  529.803060] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> [  530.183928] #PF error: [normal kernel read fault]
> [  530.412392] PGD 8000001f42163067 P4D 8000001f42163067 PUD 1f42168067 PMD 0
> [  530.750887] Oops: 0000 [#1] SMP PTI
> [  530.920869] CPU: 10 PID: 4167 Comm: fstrim Kdump: loaded Not tainted 5.0.0-rc1+ #3
> [  531.290204] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 12/27/2015
> [  531.693137] RIP: 0010:blk_queue_split+0x148/0x620
> [  531.922205] Code: 60 38 89 55 a0 45 31 db 45 31 f6 45 31 c9 31 ff 89 4d 98 85 db 0f 84 7f 04 00 00 44 8b 6d 98 4c 89 ee 48 c1 e6 04 49 03 70 78 <8b> 46 08 44 8b 56 0c 48
> 8b 16 44 29 e0 39 d8 48 89 55 a8 0f 47 c3
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
> We have observed it where both:
> 1) LVM/devmapper is involved (bcache backing device is LVM volume) and
> 2) writeback cache is involved (bcache cache_mode is writeback)
> 
> On one machine, we can reliably reproduce it with:
> 
>  # echo writeback > /sys/block/bcache0/bcache/cache_mode # not sure if this is required
>  # mount /dev/bcache0 /test
>  # for i in {0..10}; do file="$(mktemp /test/zero.XXX)"; dd if=/dev/zero of="$file" bs=1M count=256; sync; rm $file; done; fstrim -v /test
> 
> Observing this with tracepoints on, we see the following writes:
> 
> fstrim-18019 [022] .... 91107.302026: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4260112 + 196352 hit 0 bypass 1
> fstrim-18019 [022] .... 91107.302050: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4456464 + 262144 hit 0 bypass 1
> fstrim-18019 [022] .... 91107.302075: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4718608 + 81920 hit 0 bypass 1
> fstrim-18019 [022] .... 91107.302094: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5324816 + 180224 hit 0 bypass 1
> fstrim-18019 [022] .... 91107.302121: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5505040 + 262144 hit 0 bypass 1
> fstrim-18019 [022] .... 91107.302145: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5767184 + 81920 hit 0 bypass 1
> fstrim-18019 [022] .... 91107.308777: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 6373392 + 180224 hit 1 bypass 0
> <crash>
> 
> Note the final one has different hit/bypass flags.
> 
> This is because in should_writeback(), we were hitting a case where
> the partial stripe condition was returning true and so
> should_writeback() was returning true early.
> 
> If that hadn't been the case, it would have hit the would_skip test, and
> as would_skip == s->iop.bypass == true, should_writeback() would have
> returned false.
> 
> Looking at the git history from 72c270612bd3 ("bcache: Write out full
> stripes"), it looks like the idea was to optimise for raid5/6:
> 
>        * If a stripe is already dirty, force writes to that stripe to
> 	 writeback mode - to help build up full stripes of dirty data
> 
> To fix this issue, make sure that should_writeback() on a discard op
> never returns true.
> 
> More details of debugging: https://www.spinics.net/lists/linux-bcache/msg06996.html
> 
> Previous reports:
>  - https://bugzilla.kernel.org/show_bug.cgi?id=201051
>  - https://bugzilla.kernel.org/show_bug.cgi?id=196103
>  - https://www.spinics.net/lists/linux-bcache/msg06885.html
> 
> Cc: Kent Overstreet <koverstreet@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 72c270612bd3 ("bcache: Write out full stripes")
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/md/bcache/writeback.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
> index 6a743d3bb338..4e4c6810dc3c 100644
> --- a/drivers/md/bcache/writeback.h
> +++ b/drivers/md/bcache/writeback.h
> @@ -71,6 +71,9 @@ static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
>  	    in_use > bch_cutoff_writeback_sync)
>  		return false;
>  
> +	if (bio_op(bio) == REQ_OP_DISCARD)
> +		return false;
> +
>  	if (dc->partial_stripes_expensive &&
>  	    bcache_dev_stripe_dirty(dc, bio->bi_iter.bi_sector,
>  				    bio_sectors(bio)))
> 

Hi Daniel,

Nice catch! I add this one to my for-next directory, for v5.1 merge window.

Thanks.

-- 

Coly Li
