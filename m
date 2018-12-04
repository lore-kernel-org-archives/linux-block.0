Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4A3C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D57C2081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 19:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="TXuxE6OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D57C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeLDTsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:48:43 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34874 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDTsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 14:48:43 -0500
Received: by mail-yw1-f67.google.com with SMTP id h32so7495753ywk.2
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 11:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s+VP0A474Tn5W27kbi2McsJ3o8jRy8Pe/xLsJObravE=;
        b=TXuxE6OXamLMpftTaSywcaxH6buXuteXDw6YAvhwyWP5Ilhszc8nNplZozwycnERdt
         K9wa6Z5NLf/T6bTOYzzx6TcBWmsZIiOw1anKCR4zK+38Kp2HZfHb8fSiBqrRlpqbk7Wh
         NvvLyWWYzflnENQXLFCC/Zhz/NQ9LdvjDxdaf+P+sXS3wTDCGZYp5LVgys7slXZWF9Rt
         AOAvS074N3tCvoR9yJNHjkgz8DeL6t29p1dj3hKDslsHQy8qn01MJxlDY/cmHOkUqdyE
         XLY0MkGS+wKuajdXZ2G0IYPpmuTliseWMKwHRd8+V+YJfcoixFepVBEHMsT8w2wXt1qB
         Oulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s+VP0A474Tn5W27kbi2McsJ3o8jRy8Pe/xLsJObravE=;
        b=I05gIctnh1reIeOlgo5vTCZ9QWy5Iza2JJuqBmaFxoVtOXShu6QyEqkzPiPR8PpOhu
         emou7WaxUPXilLr30+F9QME1QtAhVuDATIa7PS4agZEFvYd3XZ94HsZxsxeMycOvoJsj
         McRMT8DzotcJiPSNTXrF69c3Q/2+QL9YA8jlBhXBs0bRN6LOe5aaX3BVtCc/s9uq6dkR
         zN+BqjqiepdsK73BMmz/Sx1P0n202a94GhhWWWEIMMnV69fDTbhi+F5AiDnz6I3cTgem
         AGSulxOpPeS/VbOJVg3/j9sgW8MYjwueMWm+Y18ZYIVXQ5pthz8JrPWI94rBwEjf113f
         Mv5A==
X-Gm-Message-State: AA+aEWauZuSZeYqUZ1L+EV44I3kP8mrZmS8EW9PKw/wljvM65x/ZVr4m
        3hmfPRjV3ALRjhKGHrRXfIedBQ==
X-Google-Smtp-Source: AFSGD/V1pyirlPgNfZ6QTMnWBFYFfLd/Hi7fHd7X1n4rwLyPwK2klSsRbUMBfIQeKDv9HiO4t9aEug==
X-Received: by 2002:a81:a4d1:: with SMTP id b200mr20349089ywh.316.1543952921817;
        Tue, 04 Dec 2018 11:48:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g70sm5827232ywe.105.2018.12.04.11.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:48:40 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:48:39 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] blkcg: associate blkg when associating a device
Message-ID: <20181204194838.ylk546legwikfrik@MacBook-Pro-91.local>
References: <20181204183600.99746-1-dennis@kernel.org>
 <20181204183600.99746-7-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204183600.99746-7-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 01:35:52PM -0500, Dennis Zhou wrote:
> Previously, blkg association was handled by controller specific code in
> blk-throttle and blk-iolatency. However, because a blkg represents a
> relationship between a blkcg and a request_queue, it makes sense to keep
> the blkg->q and bio->bi_disk->queue consistent.
> 
> This patch moves association into the bio_set_dev macro(). This should
> cover the majority of cases where the device is set/changed keeping the
> two pointers consistent. Fallback code is added to
> blkcg_bio_issue_check() to catch any missing paths.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  block/bio.c                |  1 +
>  block/blk-iolatency.c      |  4 +---
>  block/blk-throttle.c       |  1 -
>  include/linux/bio.h        |  2 ++
>  include/linux/blk-cgroup.h | 11 +++--------
>  5 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 41ebb3f8e2fc..1e852ab904aa 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -2074,6 +2074,7 @@ void bio_associate_blkg(struct bio *bio)
>  
>  	rcu_read_unlock();
>  }
> +EXPORT_SYMBOL_GPL(bio_associate_blkg);
>  
>  /**
>   * bio_disassociate_task - undo bio_associate_current()
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index cdbd10564e66..e6b47c255521 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -472,14 +472,12 @@ static void check_scale_change(struct iolatency_grp *iolat)
>  static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
>  {
>  	struct blk_iolatency *blkiolat = BLKIOLATENCY(rqos);
> -	struct blkcg_gq *blkg;
> +	struct blkcg_gq *blkg = bio->bi_blkg;
>  	bool issue_as_root = bio_issue_as_root_blkg(bio);
>  
>  	if (!blk_iolatency_enabled(blkiolat))
>  		return;
>  
> -	bio_associate_blkg(bio);
> -	blkg = bio->bi_blkg;
>  	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
>  
>  	while (blkg && blkg->parent) {
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 228c3a007ebc..1c6529df2002 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2118,7 +2118,6 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
>  static void blk_throtl_assoc_bio(struct bio *bio)
>  {
>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> -	bio_associate_blkg(bio);
>  	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
>  #endif
>  }
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 62715a5a4f32..6ee2ea8b378a 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -491,12 +491,14 @@ do {						\
>  		bio_clear_flag(bio, BIO_THROTTLED);\
>  	(bio)->bi_disk = (bdev)->bd_disk;	\
>  	(bio)->bi_partno = (bdev)->bd_partno;	\
> +	bio_associate_blkg(bio);		\
>  } while (0)
>  
>  #define bio_copy_dev(dst, src)			\
>  do {						\
>  	(dst)->bi_disk = (src)->bi_disk;	\
>  	(dst)->bi_partno = (src)->bi_partno;	\
> +	bio_clone_blkcg_association(dst, src);	\
>  } while (0)
>  
>  #define bio_dev(bio) \
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index c08e96e521ed..3c87ae71156f 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -802,21 +802,17 @@ static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg
>  static inline bool blkcg_bio_issue_check(struct request_queue *q,
>  					 struct bio *bio)
>  {
> -	struct blkcg *blkcg;
>  	struct blkcg_gq *blkg;
>  	bool throtl = false;
>  
> -	rcu_read_lock();
> +	if (!bio->bi_blkg)
> +		bio_associate_blkg(bio);
>  

Should we maybe WARN_ON_ONCE() here since this really shouldn't happen?
Otherwise you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
