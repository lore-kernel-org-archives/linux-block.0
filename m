Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DB3C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470C8218AE
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545248700;
	bh=m+8H9AUX0VJUw9uxTHxT4O/cbxA+1eGYoEtsamIE4jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CAy1pHQ6e2Wmb2cDL+VP1pYWNZ4DX8yyiKVxJpjZYE7L6qqPuvp09xs7orC2uGf0Y
	 1d7M4rTsLP2y0JAA6FNgjfJj/yjYOZyoUDD99rHGLOWKAuujlwyKbp0Q5XoHL59u37
	 zK/euRwW4CIbOD5PDfNlyPJNNvmBUbeOXL4T44kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeLSTo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:44:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34436 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeLSTo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 14:44:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so10201474qke.1
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 11:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Ao8/OFCAZdaVBWP+8DIkh17YoSkVDBxJv+D1NjxreA=;
        b=pt20Hp1G6g7DDKD3pOK5qPBzAGEdcm55eJ4w06VdwLZEA89gUHxXv5YEyDXrQFT3b8
         EVT2OIBLszm23Ii9XvrLgEhzJFi94iIf6aadIAslKq1aI95QRcbReU7Lmra8BYI3tZol
         3W45pna3a3SNFUJEy2qWcKQmnrtxaprpSicEoEsrZFysaxngTHRIABSCxAIJPgT2eBeV
         HzQxFt79b0w0PoZClmsCB0zlLROr8iJCUL9G+PZGtSNGLrG3i2f6xBOMxrkGVoXo3khE
         HS8ZNb/n2G99uzniEK1KwjdvMHaCb23GwJCczJN7Rlw/fhdqi/eWeOgrcLYFWkn5anYO
         3F8g==
X-Gm-Message-State: AA+aEWaNUsvcf0HKiLXxyiGbYhF+AKBDEEZXVcV0EIzBek4cXPiCpVpG
        kwK0mvXnYOvULa7FNbFxw6k=
X-Google-Smtp-Source: AFSGD/X03yBIzQr2d32fE8ype36ZgXm2Q3gdi7qHLqf2iwsLesPuAH45mHlfshCwGd1NCECfXQ3gAA==
X-Received: by 2002:a37:268b:: with SMTP id m11mr21400402qkm.131.1545248697987;
        Wed, 19 Dec 2018 11:44:57 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:180::1:5938])
        by smtp.gmail.com with ESMTPSA id d50sm2999832qta.31.2018.12.19.11.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 11:44:57 -0800 (PST)
Date:   Wed, 19 Dec 2018 13:44:54 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH] block: save irq state in blkg_lookup_create()
Message-ID: <20181219194454.GB11497@dennisz-mbp.dhcp.thefacebook.com>
References: <20181219162915.23512-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219162915.23512-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 20, 2018 at 12:29:15AM +0800, Ming Lei wrote:
> blkg_lookup_create() may be called from pool_map() in which
> irq state is saved, so we have to do that in blkg_lookup_create().
> 
> Otherwise, the following lockdep warning can be triggered:
> 
> [  104.258537] ================================
> [  104.259129] WARNING: inconsistent lock state
> [  104.259725] 4.20.0-rc6+ #545 Not tainted
> [  104.260268] --------------------------------
> [  104.260865] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [  104.261727] swapper/49/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
> [  104.262444] 00000000db365b5d (&(&pool->lock)->rlock#3){+.?.}, at: thin_endio+0xcf/0x2a3 [dm_thin_pool]
> [  104.263747] {SOFTIRQ-ON-W} state was registered at:
> [  104.264417]   _raw_spin_unlock_irq+0x29/0x4c
> [  104.265014]   blkg_lookup_create+0xdc/0xe6
> [  104.265609]   bio_associate_blkg_from_css+0xd3/0x13f
> [  104.266312]   bio_associate_blkg+0x15a/0x1bb
> [  104.266913]   pool_map+0xe8/0x103 [dm_thin_pool]
> [  104.267572]   __map_bio+0x98/0x29c [dm_mod]
> [  104.268162]   __split_and_process_non_flush+0x29e/0x306 [dm_mod]
> [  104.269003]   __split_and_process_bio+0x16a/0x25b [dm_mod]
> [  104.269971]   __dm_make_request.isra.14+0xdc/0x124 [dm_mod]
> [  104.270973]   generic_make_request+0x3f5/0x68b
> [  104.271676]   process_prepared_mapping+0x166/0x1ef [dm_thin_pool]
> [  104.272531]   schedule_zero+0x239/0x273 [dm_thin_pool]
> [  104.273245]   process_cell+0x60c/0x6f1 [dm_thin_pool]
> [  104.273967]   do_worker+0x60c/0xca8 [dm_thin_pool]
> [  104.274635]   process_one_work+0x4eb/0x834
> [  104.275203]   worker_thread+0x318/0x484
> [  104.275740]   kthread+0x1d1/0x1e1
> [  104.276203]   ret_from_fork+0x3a/0x50
> [  104.276714] irq event stamp: 170003
> [  104.277201] hardirqs last  enabled at (170002): [<ffffffff81bcc33e>] _raw_spin_unlock_irqrestore+0x44/0x6b
> [  104.278535] hardirqs last disabled at (170003): [<ffffffff81bcc1ad>] _raw_spin_lock_irqsave+0x20/0x55
> [  104.280273] softirqs last  enabled at (169978): [<ffffffff810d13d4>] irq_enter+0x4c/0x73
> [  104.281617] softirqs last disabled at (169979): [<ffffffff810d1479>] irq_exit+0x7e/0x11d
> [  104.282744]
> [  104.282744] other info that might help us debug this:
> [  104.283640]  Possible unsafe locking scenario:
> [  104.283640]
> [  104.284452]        CPU0
> [  104.284803]        ----
> [  104.285150]   lock(&(&pool->lock)->rlock#3);
> [  104.285762]   <Interrupt>
> [  104.286130]     lock(&(&pool->lock)->rlock#3);
> [  104.286750]
> [  104.286750]  *** DEADLOCK ***
> [  104.286750]
> [  104.287564] no locks held by swapper/49/0.
> [  104.288129]
> [  104.288129] stack backtrace:
> [  104.288738] CPU: 49 PID: 0 Comm: swapper/49 Not tainted 4.20.0-rc6+ #545
> [  104.289700] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
> [  104.290858] Call Trace:
> [  104.291204]  <IRQ>
> [  104.291502]  dump_stack+0x9a/0xe6
> [  104.291968]  mark_lock+0x56c/0x7a6
> [  104.292442]  ? check_usage_backwards+0x209/0x209
> [  104.293086]  __lock_acquire+0x400/0x15bf
> [  104.293662]  ? check_chain_key+0x150/0x1aa
> [  104.294236]  lock_acquire+0x1a6/0x1e3
> [  104.294768]  ? thin_endio+0xcf/0x2a3 [dm_thin_pool]
> [  104.295444]  ? _raw_spin_unlock_irqrestore+0x44/0x6b
> [  104.296143]  ? process_prepared_discard_fail+0x36/0x36 [dm_thin_pool]
> [  104.297031]  _raw_spin_lock_irqsave+0x46/0x55
> [  104.297659]  ? thin_endio+0xcf/0x2a3 [dm_thin_pool]
> [  104.298335]  thin_endio+0xcf/0x2a3 [dm_thin_pool]
> [  104.298997]  ? process_prepared_discard_fail+0x36/0x36 [dm_thin_pool]
> [  104.299886]  ? check_flags+0x20a/0x20a
> [  104.300408]  ? lock_acquire+0x1a6/0x1e3
> [  104.300954]  ? process_prepared_discard_fail+0x36/0x36 [dm_thin_pool]
> [  104.301865]  clone_endio+0x1bb/0x22d [dm_mod]
> [  104.302491]  ? disable_write_zeroes+0x20/0x20 [dm_mod]
> [  104.303200]  ? bio_disassociate_blkg+0xc6/0x15f
> [  104.303836]  ? bio_endio+0x2b2/0x2da
> [  104.304349]  clone_endio+0x1f3/0x22d [dm_mod]
> [  104.304978]  ? disable_write_zeroes+0x20/0x20 [dm_mod]
> [  104.305709]  ? bio_disassociate_blkg+0xc6/0x15f
> [  104.306333]  ? bio_endio+0x2b2/0x2da
> [  104.306853]  clone_endio+0x1f3/0x22d [dm_mod]
> [  104.307476]  ? disable_write_zeroes+0x20/0x20 [dm_mod]
> [  104.308185]  ? bio_disassociate_blkg+0xc6/0x15f
> [  104.308817]  ? bio_endio+0x2b2/0x2da
> [  104.309319]  blk_update_request+0x2de/0x4cc
> [  104.309927]  blk_mq_end_request+0x2a/0x183
> [  104.310498]  blk_done_softirq+0x16a/0x1a6
> [  104.311051]  ? blk_softirq_cpu_dead+0xe2/0xe2
> [  104.311653]  ? __lock_is_held+0x2a/0x87
> [  104.312186]  __do_softirq+0x250/0x4e8
> [  104.312705]  irq_exit+0x7e/0x11d
> [  104.313157]  call_function_single_interrupt+0xf/0x20
> [  104.313860]  </IRQ>
> [  104.314163] RIP: 0010:native_safe_halt+0x2/0x3
> [  104.314792] Code: 63 02 df f0 83 44 24 fc 00 48 89 df e8 cc 3f 7a ff 48 8b 03 a8 08 74 0b 65 81 25 9d 31 45 7e ff ff ff 7f 5b 5d 41 5c c3 fb f4 <c3> f4 c3 0f 1f 44 00 00 41 56 41 55 41 54 55 53 e8 a2 0d 5c ff e8
> [  104.317339] RSP: 0018:ffff888106c9fdc0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff04
> [  104.318390] RAX: 1ffff11020d92100 RBX: 0000000000000000 RCX: ffffffff81159ac7
> [  104.319366] RDX: 1ffffffff05d5e69 RSI: 0000000000000007 RDI: ffff888106c90d1c
> [  104.320339] RBP: 0000000000000000 R08: dffffc0000000000 R09: 0000000000000001
> [  104.321313] R10: ffffed1025d57ba0 R11: ffffed1025d57b9f R12: 1ffff11020d93fbf
> [  104.322328] R13: 0000000000000031 R14: ffff888106c90040 R15: 0000000000000000
> [  104.323307]  ? lockdep_hardirqs_on+0x26b/0x278
> [  104.323927]  default_idle+0xd9/0x1a8
> [  104.324427]  do_idle+0x162/0x2b2
> [  104.324891]  ? arch_cpu_idle_exit+0x28/0x28
> [  104.325467]  ? mark_held_locks+0x28/0x7f
> [  104.326031]  ? _raw_spin_unlock_irqrestore+0x44/0x6b
> [  104.326719]  cpu_startup_entry+0x1d/0x1f
> [  104.327261]  start_secondary+0x2cb/0x308
> [  104.327806]  ? set_cpu_sibling_map+0x8a3/0x8a3
> [  104.328421]  secondary_startup_64+0xa4/0xb0
> 
> Fixes: b978962ad4f7f9 ("blkcg: update blkg_lookup_create() to do locking")
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-cgroup.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index c30661ddc873..c8cc1cbb6370 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -359,9 +359,11 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>  	struct blkcg_gq *blkg = blkg_lookup(blkcg, q);
>  
>  	if (unlikely(!blkg)) {
> -		spin_lock_irq(&q->queue_lock);
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&q->queue_lock, flags);
>  		blkg = __blkg_lookup_create(blkcg, q);
> -		spin_unlock_irq(&q->queue_lock);
> +		spin_unlock_irqrestore(&q->queue_lock, flags);
>  	}
>  
>  	return blkg;
> -- 
> 2.9.5
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

I know it's already applied, but thanks Ming for helping me debug the
blkg series.

Thanks,
Dennis
