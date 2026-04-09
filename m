Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06E310763
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761613; cv=none; b=jzD5v5OSir1ePduWBvydHZypjrWamjRAXopJ8NM+kogyBREpPJbcNi3wTcc+r5GzpZggg6W8YJNetnvlLo9pss5/DPWLduGmLcoB3jLr331zDPgSIefZgMmjlRx7t2ztTA3pBrezmZskMhvrVe4dVOoCXIMqFzVzAdPGaz1eJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761613; c=relaxed/simple;
	bh=zqlBAzwJwf55qlCt+QrAHleMc651qA0pd79wkNcy8Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t92R409tP/2v5VwaBTuG0+VsdoQTZazWgXblo9LQ1DgTa6fxYQl2famJ4Di3wiDWDu0qEQbe8J9A2136EBwX7s93POz1hWvyXH9ygkyaWLXEbgklUduKruX7JRJKzySdHKZ1U7PSZ6u9/+fav+f/JyzOWJM2PcfhgLYNROs1nao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=SHkTUWBV; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="SHkTUWBV"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639IuTRF736020
	for <linux-block@vger.kernel.org>; Thu, 9 Apr 2026 15:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=X0TE
	3BpM0SejjMSyXXnavLwv4WumjR4yqmxJerJDH+M=; b=SHkTUWBVb5JV+5wswx/3
	fv3VdJgOn6EtZ9VVGJlmI/22efGQJpycDNew19wu+FXgt7Za/gyUhXJJMlSUYAPC
	29HU3fCO9N88R9N5oxKVh12v49IMAzQ2ew+abamYRLUaNbyZTDGuZKwVmD2GUWjK
	c61x1PU925wali6CMgdXbOXu6Y8+8a3ro2C664uFJUBjm8WCYRkOEumIrCIQm9b5
	RXZIUcycY+g0+4EB2yt/rCBNQcYA28a5aWplv/gv+Qvosr3aC7DvRDl8mT+j24cT
	fpTLl9x8pJbu0ndQochguTkPSfsZ7eqjuVURAQ/IRf1T/QZlRt7fR5cxBARE+yQS
	KQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dee5e2bbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 15:06:50 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d984c74a8so32490161cf.1
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 12:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775761610; x=1776366410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0TE3BpM0SejjMSyXXnavLwv4WumjR4yqmxJerJDH+M=;
        b=cHcvwSvOC3E5nRExfoQARsaMyr9Ab+L3N+N2bJZGkZnPX7mUmzdsqoeKbWPMqNiBP8
         WHfwXUeWX6mFBR03ypQGlK+Qg5PY9Hnh7tN1jrgjANJyBDkCJQrqUf1GAXujixQxXWH7
         VCXYv02ng6jdEvHVZIVY5fqyrXsRB8Qcku29cEZQ5H+wjrsj7jCWIN+CBvniYsRK/Sp4
         tcslDPTjolg4f/8gxpti9CY1pxhO8WDmFWdCwwjaFQO0tYsAeA1qGIao7jeqjQYCI2eR
         pbJCyfIlQuGplV5tnqblwdDvWmVgM/Jxk3LJOe1yTxFspMw/+AbVEMB/KlStY5CLhW3a
         /6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtBlm0Ls5bYVgh1ThL7dM5h9kbRZgA/8010v+4/KUyRqk3PUFCegR3JWNrIc89+2aLuejF76t2ZI4fRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq//+gEuPr8CxOBW8ZW3J2WCE765p0DMTXwssYQBaO8+1R3S7x
	jURfg0duIkVnOAlqxFPx3D4T3PTVskoFz1YO5g+GjSpoGdStQA+BuaN40UHMCi5nuY7LuJUCx56
	7C1iHx+aUjAW0/xR4sGxHQ5iFtpJsyfEbGfvVGyiuNv8gAsxSyZ8g1SrGMk+chPSDEibq
X-Gm-Gg: AeBDieuaZuUiFQ3DIqyVM3SD8mKojDG1c9byPY9KiATOGxkTyUOfKFHof4wnct3tvMR
	xhZ/EctOidiYLHZHQoVr6W/IGkdaXHNjUpi3IAiiGKrGLi1gUUKap/8e2p4bPCCmsBJrireSKpb
	Fr0WESlwXrMVsWfNcKIohMB3RDqASIbesU9ogGPTf6U70N/PXQqzLJ40JFpW2GiQXqmBiJQbJ9P
	sKWoXGyNQim+ozcwLNYEdW5fh6vMIcrmz0Mv/TCmKri8qHyTxa05eoeq4/q66c/M3LjF8sJolz9
	21ZBw5Kx2xIMgriKsAqUnx3pWwyDWcyQg13KvLZvF6rMmR3E98k5nPSjZjt1mth559kVZtWTAGh
	7f0abKTEMzqD/n8I4srttRMKnEmfZTzvmpSa4Lj7Z
X-Received: by 2002:a05:620a:4453:b0:8cf:d441:c7c0 with SMTP id af79cd13be357-8ddcefc12bbmr8529585a.34.1775761610147;
        Thu, 09 Apr 2026 12:06:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4453:b0:8cf:d441:c7c0 with SMTP id af79cd13be357-8ddcefc12bbmr8523385a.34.1775761609626;
        Thu, 09 Apr 2026 12:06:49 -0700 (PDT)
Received: from [10.206.71.59] ([129.236.231.31])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb6949954sm23897685a.21.2026.04.09.12.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 12:06:49 -0700 (PDT)
Message-ID: <2cdaa767-c071-4e84-b9d7-1c944407f5bb@columbia.edu>
Date: Thu, 9 Apr 2026 15:06:47 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] RFC: use a TASK_FIFO kthread for read completion
 support
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260409160243.1008358-1-hch@lst.de>
 <20260409160243.1008358-9-hch@lst.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260409160243.1008358-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3NSBTYWx0ZWRfX4gLfBIBZB/xG
 gsb66wbvky2uCMQOXJMP40noScZCie6YvGI1eq4beOqBxxBMEeoBESyUwfdHOd5fZz5vBIWSzFO
 T8u80GESFtRnO6mUO4WWSa1VUnbJfvQKLsuCKiXPKFRWpEpWpJgw+vuqXtvX6TSUPekLhgsI3p9
 bhMc19tp4VUHG467zvPjJqg1S3TQGZ3y+FSQt/jxyWVl6lNcnNm5Zp9XSV5dvMn+vcl7eG2P69k
 dOlDusK5KrZMuZ6UTqn1N1wTfcuWb8zAwlMJy529N/b6JzSfYaGCLXgCH9jH8TjhqKGo+/unmso
 FQ4mt8hnbbXyk9zajHkIZ8S5h5g6s/xRqgM+MAvs+fvDdIItAKtdX9vnGDVnV2eGiG9KumycI9i
 hZJunVJeGej8hdVYsJ20LYQtCckKjc/0aQjsWJbxGQ7x582hC5mBg8zT7HAFAZ3z2YDyLgETTg0
 0COT87iSbdekmaintdQ==
X-Proofpoint-ORIG-GUID: Yz3FwbH2avlUEQsoxlkSBWKV1lO0GFTM
X-Proofpoint-GUID: Yz3FwbH2avlUEQsoxlkSBWKV1lO0GFTM
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=69d7f8cb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=RFpAoTwO7tzpE9r8PTiuXw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=JydwF5vtCPpp8KBJ6BUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11754
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=10 clxscore=1015 impostorscore=10
 lowpriorityscore=10 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090175



On 4/9/26 12:02 PM, Christoph Hellwig wrote:
> Commit 3fffb589b9a6 ("erofs: add per-cpu threads for decompression as an
> option") explains why workqueue aren't great for low-latency completion
> handling.  Switch to a per-cpu kthread to handle it instead.  This code
> is based on the erofs code in the above commit, but further simplified
> by directly using a kthread instead of a kthread_work.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bio.c | 117 +++++++++++++++++++++++++++++-----------------------
>   1 file changed, 65 insertions(+), 52 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 88d191455762..6a993fb129a0 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -19,7 +19,7 @@
>   #include <linux/blk-crypto.h>
>   #include <linux/xarray.h>
>   #include <linux/kmemleak.h>
> -#include <linux/llist.h>
> +#include <linux/freezer.h>

Why freezer.h and not kthread.h?

>   #include <trace/events/block.h>
>   #include "blk.h"
> @@ -1718,51 +1718,83 @@ void bio_check_pages_dirty(struct bio *bio)
>   EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
>   
>   struct bio_complete_batch {
> -	struct llist_head list;

If we go with this approach, we should remove the newly-added bi_llist from
struct bio too.

> -	struct delayed_work work;
> -	int cpu;
> +	spinlock_t lock;
> +	struct bio_list bios;
> +	struct task_struct *worker;
>   };
>   
>   static DEFINE_PER_CPU(struct bio_complete_batch, bio_complete_batch);
> -static struct workqueue_struct *bio_complete_wq;
>   
> -static void bio_complete_work_fn(struct work_struct *w)
> +static bool bio_try_complete_batch(struct bio_complete_batch *batch)
>   {
> -	struct delayed_work *dw = to_delayed_work(w);
> -	struct bio_complete_batch *batch =
> -		container_of(dw, struct bio_complete_batch, work);
> -	struct llist_node *node;
> -	struct bio *bio, *next;
> +	struct bio_list bios;
> +	unsigned long flags;
> +	struct bio *bio;
>   
> -	do {
> -		node = llist_del_all(&batch->list);
> -		if (!node)
> -			break;
> +	spin_lock_irqsave(&batch->lock, flags);
> +	bios = batch->bios;
> +	bio_list_init(&batch->bios);
> +	spin_unlock_irqrestore(&batch->lock, flags);
>   
> -		node = llist_reverse_order(node);
> -		llist_for_each_entry_safe(bio, next, node, bi_llist)
> -			bio->bi_end_io(bio);
> +	if (bio_list_empty(&bios))
> +		return false;
>   
> -		if (need_resched()) {
> -			if (!llist_empty(&batch->list))
> -				mod_delayed_work_on(batch->cpu,
> -						    bio_complete_wq,
> -						    &batch->work, 0);
> -			break;
> -		}
> -	} while (1);
> +	__set_current_state(TASK_RUNNING);
> +	while ((bio = bio_list_pop(&bios)))
> +		bio->bi_end_io(bio);
> +	return true;
> +}
> +
> +static int bio_complete_thread(void *private)
> +{
> +	struct bio_complete_batch *batch = private;
> +
> +	for (;;) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (!bio_try_complete_batch(batch))
> +			schedule();
> +	}
> +
> +	return 0;
>   }
>   
>   void __bio_complete_in_task(struct bio *bio)
>   {
> -	struct bio_complete_batch *batch = this_cpu_ptr(&bio_complete_batch);
> +	struct bio_complete_batch *batch;
> +	unsigned long flags;
> +	bool wake;
> +
> +	get_cpu();
> +	batch = this_cpu_ptr(&bio_complete_batch);
> +	spin_lock_irqsave(&batch->lock, flags);
> +	wake = bio_list_empty(&batch->bios);
> +	bio_list_add(&batch->bios, bio);
> +	spin_unlock_irqrestore(&batch->lock, flags);
> +	put_cpu();
>   
> -	if (llist_add(&bio->bi_llist, &batch->list))
> -		mod_delayed_work_on(batch->cpu, bio_complete_wq,
> -				    &batch->work, 1);
> +	if (wake)
> +		wake_up_process(batch->worker);
>   }
>   EXPORT_SYMBOL_GPL(__bio_complete_in_task);
>   
> +static void __init bio_complete_batch_init(int cpu)
> +{
> +	struct bio_complete_batch *batch =
> +		per_cpu_ptr(&bio_complete_batch, cpu);
> +	struct task_struct *worker;
> +
> +	worker = kthread_create_on_cpu(bio_complete_thread,
> +			per_cpu_ptr(&bio_complete_batch, cpu),
> +			cpu, "bio_worker/%u");
> +	if (IS_ERR(worker))
> +		panic("bio: can't create kthread_work");
> +	sched_set_fifo_low(worker);
> +
> +	spin_lock_init(&batch->lock);
> +	bio_list_init(&batch->bios);
> +	batch->worker = worker;
> +}
> +
>   static inline bool bio_remaining_done(struct bio *bio)
>   {
>   	/*
> @@ -2028,16 +2060,7 @@ EXPORT_SYMBOL(bioset_init);
>    */
>   static int bio_complete_batch_cpu_dead(unsigned int cpu)
>   {
> -	struct bio_complete_batch *batch =
> -		per_cpu_ptr(&bio_complete_batch, cpu);
> -	struct llist_node *node;
> -	struct bio *bio, *next;
> -
> -	node = llist_del_all(&batch->list);
> -	node = llist_reverse_order(node);
> -	llist_for_each_entry_safe(bio, next, node, bi_llist)
> -		bio->bi_end_io(bio);
> -
> +	bio_try_complete_batch(per_cpu_ptr(&bio_complete_batch, cpu));
>   	return 0;
>   }
>   
> @@ -2055,18 +2078,8 @@ static int __init init_bio(void)
>   				SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
>   	}
>   
> -	for_each_possible_cpu(i) {
> -		struct bio_complete_batch *batch =
> -			per_cpu_ptr(&bio_complete_batch, i);
> -
> -		init_llist_head(&batch->list);
> -		INIT_DELAYED_WORK(&batch->work, bio_complete_work_fn);
> -		batch->cpu = i;
> -	}
> -
> -	bio_complete_wq = alloc_workqueue("bio_complete", WQ_MEM_RECLAIM, 0);
> -	if (!bio_complete_wq)
> -		panic("bio: can't allocate bio_complete workqueue\n");
> +	for_each_possible_cpu(i)
> +		bio_complete_batch_init(i);
>   
>   	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "block/bio:complete:dead",
>   				NULL, bio_complete_batch_cpu_dead);
> -- 
> 2.47.3
> 

