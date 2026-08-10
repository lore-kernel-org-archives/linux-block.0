Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FD339705;
	Mon, 10 Aug 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377276; cv=none; b=JrrXZ8kwSHCft1QAXt42SLiNf3JWarhIyDk14JVr4in8UstwfT+yondJLkSE2O0R+rV37hsS6w50T+/SdkjNCLNepRb26bbGXXphOfn0bSf1dsIUsLvK1s08D+gFfZoLWh/h3jmRBhepjck1i6Pvim5tpoQ9i7tEpoy/gV+kbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377276; c=relaxed/simple;
	bh=CZB+FIFgj8GkiKO7/uo/Bgz7+QWPVye49dy2UcGXwgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSoq/wzdc3mH5/YOgd/pg7owwk51gh8eguLSx6un2b2B8NakQANGzaUhKf1YXcOhw8wVcJnhmE57UUWcFt45BnR8RfkaBuKjCEKdFT0FvWztRS/MCfPw/LBHHd1Gz51Sw6t3EpzP82Iuroffc/1/NlyAOFWbaTtLZgWuUgTcDCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sjPTJB5d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sjPTJB5d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5W2D9NN9Ny8fEUtMojHwdi1k4eGZtoza9fQy08Zc8Hk=; b=sjPTJB5dG37IzlNhIDWM1A9/jd
	SjykkYloj6PthA5Y5R7tbmIvIvJOOZt1YON6I9JPBunZeXxBJUNRGQlzJXkvXIQM2cvfu/ks2DCiL
	lKpye4ZP4gWqptUpnVs7f5hJz3Pe2ZGHNHYFlmxvGhjoFcuGSOvNsTTw7Yh/9I+8wUek/OHmMepGu
	YZpRLtjFC+iWZYmlhKVTTXQe7U5V6/FVGzN3VJz1D1DIeRtulvRVfMn94QWA6kVEmDeMYqJ9c57RE
	W8dJL+0zIZUSua5Kch6mS67EF/r+yvL9OtNLfLvQrJkSgHIXbRmTF8Tm+ZHmpwaqOROdA5lI/oD10
	oq5JyUIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtSKe-0000000CJeq-29rg;
	Mon, 10 Aug 2026 15:54:32 +0000
Date: Mon, 10 Aug 2026 08:54:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: quiesce background threads during system
 suspend using PM notifier
Message-ID: <ann0OPPglToV_hjs@infradead.org>
References: <20260806170108.2100312-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806170108.2100312-1-daeho43@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 06, 2026 at 10:01:08AM -0700, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> During system suspend, a race condition can cause f2fs_gc and f2fs_discard
> threads to call submit_bio() while the underlying block device (e.g., UFS)
> is in Runtime PM suspend. Because Runtime PM worker threads are already
> frozen during task freezing, the threads become trapped in
> __bio_queue_enter() waiting on mq_freeze_wq, leading to a PM freezer
> timeout.

That does sound like a general issue with our block device / threading
handling.

> To prevent this deadlock, register a PM notifier to set SBI_IS_SUSPENDING
> during PM_SUSPEND_PREPARE. Background GC and discard threads check this
> flag and immediately stop issuing new bios, allowing them to enter a
> freezable sleep state cleanly before process freezing begins.
> 
> In addition, check freezing() as a fast path to stop issuing new I/O
> when non-PM freezing (e.g. dm-snapshot or cgroup freezer) is requested.

.. which means that we really sould have all the relevant parties
invited into figuring out whast is happening here, rather than
band-aiding something that looks like a horrible hack inside a
file system.

Unfortunately I see this a lot with f2fs.  Please reach out to all
relevant maintainers for something that does not look strictly local
to f2fs.


> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: check freezing() together for non-PM freezing.
> ---
>  fs/f2fs/f2fs.h    |  9 +++++++++
>  fs/f2fs/gc.c      | 13 ++++++++-----
>  fs/f2fs/segment.c | 12 ++++++++----
>  fs/f2fs/super.c   | 25 +++++++++++++++++++++++++
>  4 files changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f1774d4e18d2..2a7b0fe8419b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -25,6 +25,7 @@
>  #include <linux/quotaops.h>
>  #include <linux/part_stat.h>
>  #include <linux/rw_hint.h>
> +#include <linux/suspend.h>
>  
>  #include <linux/fscrypt.h>
>  #include <linux/fsverity.h>
> @@ -1492,6 +1493,7 @@ enum {
>  	SBI_IS_FREEZING,			/* freezefs is in process */
>  	SBI_IS_WRITABLE,			/* remove ro mountoption transiently */
>  	SBI_ENABLE_CHECKPOINT,			/* indicate it's during f2fs_enable_checkpoint() */
> +	SBI_IS_SUSPENDING,			/* system suspend is in progress */
>  	MAX_SBI_FLAG,
>  };
>  
> @@ -1755,6 +1757,7 @@ struct f2fs_sb_info {
>  	struct f2fs_rwsem sb_lock;		/* lock for raw super block */
>  	int valid_super_block;			/* valid super block no */
>  	unsigned long s_flag;				/* flags for sbi */
> +	struct notifier_block pm_nb;		/* for PM notifier */
>  	struct mutex writepages;		/* mutex for writepages() */
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> @@ -2309,6 +2312,12 @@ static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
>  	clear_bit(type, &sbi->s_flag);
>  }
>  
> +static inline bool f2fs_is_suspending(struct f2fs_sb_info *sbi)
> +{
> +	return is_sbi_flag_set(sbi, SBI_IS_SUSPENDING) ||
> +				unlikely(freezing(current));
> +}
> +
>  static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
>  {
>  	return le64_to_cpu(cp->checkpoint_ver);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index ffaa7ba76a1b..6c7ea38eb70d 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -71,7 +71,8 @@ static int gc_thread_func(void *data)
>  		if (kthread_should_stop())
>  			break;
>  
> -		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
> +		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE ||
> +			f2fs_is_suspending(sbi)) {
>  			increase_sleep_time(gc_th, &wait_ms);
>  			stat_other_skip_bggc_count(sbi);
>  			continue;
> @@ -1064,8 +1065,9 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
>  		struct node_info ni;
>  		int err;
>  
> -		/* stop BG_GC if there is not enough free sections. */
> -		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
> +		/* stop BG_GC if there is not enough free sections or suspending/freezing. */
> +		if (gc_type == BG_GC && (has_not_enough_free_secs(sbi, 0, 0) ||
> +					f2fs_is_suspending(sbi)))
>  			return submitted;
>  
>  		if (check_valid_map(sbi, segno, off) == 0)
> @@ -1611,7 +1613,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  		 * Or, stop GC if the segment becomes fully valid caused by
>  		 * race condition along with SSR block allocation.
>  		 */
> -		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
> +		if ((gc_type == BG_GC && (has_not_enough_free_secs(sbi, 0, 0) ||
> +					f2fs_is_suspending(sbi))) ||
>  			(!force_migrate && get_valid_blocks(sbi, segno, true) ==
>  							CAP_BLKS_PER_SEC(sbi)))
>  			return submitted;
> @@ -2015,7 +2018,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>  		goto stop;
>  	}
>  retry:
> -	if (unlikely(freezing(current))) {
> +	if (f2fs_is_suspending(sbi)) {
>  		ret = 0;
>  		goto stop;
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d71ddb3ee918..7b03b3d06161 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1300,7 +1300,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  	if (dc->state != D_PREP)
>  		return 0;
>  
> -	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
> +	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_is_suspending(sbi))
>  		return 0;
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> @@ -1341,6 +1341,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		unsigned long flags;
>  		bool last = true;
>  
> +		if (f2fs_is_suspending(sbi))
> +			break;
> +
>  		if (len > max_discard_blocks) {
>  			len = max_discard_blocks;
>  			last = false;
> @@ -1615,7 +1618,7 @@ static void __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>  		if (dc->state != D_PREP)
>  			goto next;
>  
> -		if (*issued > 0 && unlikely(freezing(current)))
> +		if (f2fs_is_suspending(sbi))
>  			break;
>  
>  		if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
> @@ -1688,7 +1691,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  		list_for_each_entry_safe(dc, tmp, pend_list, list) {
>  			f2fs_bug_on(sbi, dc->state != D_PREP);
>  
> -			if (issued > 0 && unlikely(freezing(current))) {
> +			if (f2fs_is_suspending(sbi)) {
>  				suspended = true;
>  				break;
>  			}
> @@ -1955,7 +1958,8 @@ static int issue_discard_thread(void *data)
>  			continue;
>  		if (kthread_should_stop())
>  			return 0;
> -		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
> +		if (f2fs_is_suspending(sbi) ||
> +			is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
>  			!atomic_read(&dcc->discard_cmd_cnt)) {
>  			wait_ms = dpolicy.max_interval;
>  			continue;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index c448d992ff2a..8c97b5d1ee68 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1979,6 +1979,26 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>  	kvfree(sbi->devs);
>  }
>  
> +static int f2fs_pm_notifier(struct notifier_block *nb,
> +			    unsigned long action, void *ptr)
> +{
> +	struct f2fs_sb_info *sbi = container_of(nb, struct f2fs_sb_info, pm_nb);
> +
> +	switch (action) {
> +	case PM_HIBERNATION_PREPARE:
> +	case PM_SUSPEND_PREPARE:
> +	case PM_RESTORE_PREPARE:
> +		set_sbi_flag(sbi, SBI_IS_SUSPENDING);
> +		break;
> +	case PM_POST_SUSPEND:
> +	case PM_POST_HIBERNATION:
> +	case PM_POST_RESTORE:
> +		clear_sbi_flag(sbi, SBI_IS_SUSPENDING);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
>  static void f2fs_put_super(struct super_block *sb)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> @@ -1986,6 +2006,8 @@ static void f2fs_put_super(struct super_block *sb)
>  	int err = 0;
>  	bool done;
>  
> +	unregister_pm_notifier(&sbi->pm_nb);
> +
>  	/* unregister procfs/sysfs entries in advance to avoid race case */
>  	f2fs_unregister_sysfs(sbi);
>  
> @@ -5436,6 +5458,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	f2fs_update_time(sbi, REQ_TIME);
>  	clear_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
>  
> +	sbi->pm_nb.notifier_call = f2fs_pm_notifier;
> +	register_pm_notifier(&sbi->pm_nb);
> +
>  	sbi->umount_lock_holder = NULL;
>  	return 0;
>  
> -- 
> 2.55.0.654.g21b8a5bc05-goog
> 
> 
---end quoted text---
