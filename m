Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5DCC433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D92761038
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 19:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhJQTHp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhJQTHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 15:07:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B4BC06161C
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 12:05:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m21so13741167pgu.13
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=sVZ1DpKubbsy0mUluCung6Lb4g+ZDWWHKNC9xDOp0vg=;
        b=C02LI67+2ZPiugNXvYaOmGL98YqfmmxyWDmW7S4oeR03TQqYJ96AXsWonYnyPAQoy4
         eBulv4UnGbODftpstssZ8N3diWPz0Q0Z5OElPPjXavgjRFFgMht/LpET7MztjcDOzupM
         y9UMViZNqUI4nLfYaycdkOXo4kMNFG9gxeR8H1/wpb/DywIUukjHv4A/IOsZ0uB1IJW2
         ZxTr8XYT/7TVgPsnm1e6YIeUaLXjOI/qS4uvFXJO0dRFkGK9ONG9fDhlJgi1V5KH5ARL
         RFJVgAfW19o2236OCRyFQxblkAghM2nH+C7LR9U9Q5rhGiChobRajw6dlWTjGlhrDR5n
         ljxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sVZ1DpKubbsy0mUluCung6Lb4g+ZDWWHKNC9xDOp0vg=;
        b=My+xXyBId/ChDHc6o1ghMqsmG7mIXlHKtbr57kIrTsgQafETzBhYzFrqJooPbdx5ZM
         E1qa8N4bDmPgYlGyEDd0QYDplhjfWX5UKlMq/g8QmDVY028I03vxGPnnZcX59Smz2Q9P
         b8mQ2ju9TtEKAniqRqxFlBipNGO91iDgZzoUNnINUXJz8um7L39Nvao0D8LXoxwcFD9w
         OvhDaiTK5FPRsEhEPqACmh4ktAPUJRRsHOVdpHtLAZkrhF0dzlFlHdTNQrXFhlr09K3Y
         WaTA/gxbN7rFR+DDO0vJGlo+AFldvwq0WOcogLT4Aepe+z2r6p1DnJgsfJfvDlazL4kf
         rnZg==
X-Gm-Message-State: AOAM531P5p0avfISauwe2kfmIyXhwh5dT/w4I9y/c9pR0JbBgRGnOXjn
        fjHFWWy291BYPTXYmyzMpjM=
X-Google-Smtp-Source: ABdhPJxcQBhk8amYdId8Be83F9e2AIrOMgQCIu6V0M+uERz2loUSIKHh1+fGimFW/p25shPgLcqPWA==
X-Received: by 2002:aa7:9523:0:b0:44c:c171:9ae with SMTP id c3-20020aa79523000000b0044cc17109aemr24679197pfp.75.1634497534318;
        Sun, 17 Oct 2021 12:05:34 -0700 (PDT)
Received: from [10.1.1.26] (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id c140sm10589025pfc.31.2021.10.17.12.05.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Oct 2021 12:05:33 -0700 (PDT)
Subject: Re: [PATCH v2] ataflop: remove ataflop_probe_lock mutex
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Finn Thain <fthain@linux-m68k.org>
References: <1d9351dc-baeb-1a54-625c-04ce01b009b0@i-love.sakura.ne.jp>
 <6d26961c-3b51-d6e1-fb95-b72e720ed5d0@gmail.com>
 <5524e6ee-e469-9775-07c4-7baf5e330148@i-love.sakura.ne.jp>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <7bf8ba1a-ed7c-059b-f4a1-cd7cfb5c21da@gmail.com>
Date:   Mon, 18 Oct 2021 08:05:28 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <5524e6ee-e469-9775-07c4-7baf5e330148@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

On 17/10/21 15:09, Tetsuo Handa wrote:
> Commit bf9c0538e485b591 ("ataflop: use a separate gendisk for each media
> format") introduced ataflop_probe_lock mutex, but forgot to unlock the
> mutex when atari_floppy_init() (i.e. module loading) succeeded. This will
> result in double lock deadlock if ataflop_probe() is called. Also,
> unregister_blkdev() must not be called from atari_floppy_init() with
> ataflop_probe_lock held when atari_floppy_init() failed, for
> ataflop_probe() waits for ataflop_probe_lock with major_names_lock held
> (i.e. AB-BA deadlock).
>
> __register_blkdev() needs to be called last in order to avoid calling
> ataflop_probe() when atari_floppy_init() is about to fail, for memory for
> completing already-started ataflop_probe() safely will be released as soon
> as atari_floppy_init() released ataflop_probe_lock mutex.
>
> As with commit 8b52d8be86d72308 ("loop: reorder loop_exit"),
> unregister_blkdev() needs to be called first in order to avoid calling
> ataflop_alloc_disk() from ataflop_probe() after del_gendisk() from
> atari_floppy_exit().
>
> By relocating __register_blkdev() / unregister_blkdev() as explained above,
> we can remove ataflop_probe_lock mutex, for probe function and __exit
> function are serialized by major_names_lock mutex.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: bf9c0538e485b591 ("ataflop: use a separate gendisk for each media format")
> ---
> Changes in v2:
>   Remove ataflop_probe_lock mutex than unlocking.
>
> Finn Thain wrote:
>> So I wonder if it would have been possible to use Aranym to find the
>> regression, or avoid it in the first place?
>
> OK, there is an emulator for testing this module. But I'm not familiar
> with m68k environment. Luis Chamberlain is proposing patchset for adding
> add_disk() error handling. I think that an answer would be to include
> m68k's mailing list into a patch for this module in order to notify of
> changes and expect m68k developers to review/test the patch.
>
> Michael Schmitz wrote:
>> Not as a module, no. I use the Atari floppy driver built-in. Latest kernel version I ran was 5.13.
>
> Great. Can you try this patch alone?

Doesn't appear to work, sorry.

Regards,

	Michael Schmitz

>
>  drivers/block/ataflop.c | 55 ++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index a093644ac39f..adfe198e4699 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1986,8 +1986,6 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
>  	return 0;
>  }
>
> -static DEFINE_MUTEX(ataflop_probe_lock);
> -
>  static void ataflop_probe(dev_t dev)
>  {
>  	int drive = MINOR(dev) & 3;
> @@ -1998,12 +1996,30 @@ static void ataflop_probe(dev_t dev)
>
>  	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
>  		return;
> -	mutex_lock(&ataflop_probe_lock);
>  	if (!unit[drive].disk[type]) {
>  		if (ataflop_alloc_disk(drive, type) == 0)
>  			add_disk(unit[drive].disk[type]);
>  	}
> -	mutex_unlock(&ataflop_probe_lock);
> +}
> +
> +static void atari_floppy_cleanup(void)
> +{
> +	int i;
> +	int type;
> +
> +	for (i = 0; i < FD_MAX_UNITS; i++) {
> +		for (type = 0; type < NUM_DISK_MINORS; type++) {
> +			if (!unit[i].disk[type])
> +				continue;
> +			del_gendisk(unit[i].disk[type]);
> +			blk_cleanup_queue(unit[i].disk[type]->queue);
> +			put_disk(unit[i].disk[type]);
> +		}
> +		blk_mq_free_tag_set(&unit[i].tag_set);
> +	}
> +
> +	del_timer_sync(&fd_timer);
> +	atari_stram_free(DMABuffer);
>  }
>
>  static int __init atari_floppy_init (void)
> @@ -2015,11 +2031,6 @@ static int __init atari_floppy_init (void)
>  		/* Amiga, Mac, ... don't have Atari-compatible floppy :-) */
>  		return -ENODEV;
>
> -	mutex_lock(&ataflop_probe_lock);
> -	ret = __register_blkdev(FLOPPY_MAJOR, "fd", ataflop_probe);
> -	if (ret)
> -		goto out_unlock;
> -
>  	for (i = 0; i < FD_MAX_UNITS; i++) {
>  		memset(&unit[i].tag_set, 0, sizeof(unit[i].tag_set));
>  		unit[i].tag_set.ops = &ataflop_mq_ops;
> @@ -2072,7 +2083,12 @@ static int __init atari_floppy_init (void)
>  	       UseTrackbuffer ? "" : "no ");
>  	config_types();
>
> -	return 0;
> +	ret = __register_blkdev(FLOPPY_MAJOR, "fd", ataflop_probe);
> +	if (ret) {
> +		printk(KERN_ERR "atari_floppy_init: cannot register block device\n");
> +		atari_floppy_cleanup();
> +	}
> +	return ret;
>
>  err:
>  	while (--i >= 0) {
> @@ -2081,9 +2097,6 @@ static int __init atari_floppy_init (void)
>  		blk_mq_free_tag_set(&unit[i].tag_set);
>  	}
>
> -	unregister_blkdev(FLOPPY_MAJOR, "fd");
> -out_unlock:
> -	mutex_unlock(&ataflop_probe_lock);
>  	return ret;
>  }
>
> @@ -2128,22 +2141,8 @@ __setup("floppy=", atari_floppy_setup);
>
>  static void __exit atari_floppy_exit(void)
>  {
> -	int i, type;
> -
> -	for (i = 0; i < FD_MAX_UNITS; i++) {
> -		for (type = 0; type < NUM_DISK_MINORS; type++) {
> -			if (!unit[i].disk[type])
> -				continue;
> -			del_gendisk(unit[i].disk[type]);
> -			blk_cleanup_queue(unit[i].disk[type]->queue);
> -			put_disk(unit[i].disk[type]);
> -		}
> -		blk_mq_free_tag_set(&unit[i].tag_set);
> -	}
>  	unregister_blkdev(FLOPPY_MAJOR, "fd");
> -
> -	del_timer_sync(&fd_timer);
> -	atari_stram_free( DMABuffer );
> +	atari_floppy_cleanup();
>  }
>
>  module_init(atari_floppy_init)
>
