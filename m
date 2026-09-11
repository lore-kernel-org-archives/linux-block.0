Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73F26982C
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097689; cv=none; b=TDuU2qX3T1eJbvOoylYAeLvvBSVMksO6lgxVbUKAArhNZNODc0vWAhbpQpj3hz+xdNS5K45QbgUiFAI7KKmuUwGQ+5Yi+SjE5+tYA0TZ9sKlQdZrvOgIGTJzIJxIHLbouDi0AdogpfMYjJFomjDmw2xvGanZKzaKUijNj1sUNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097689; c=relaxed/simple;
	bh=Tu8pKOZMUv7MW57ziXM+jjfR2tJTZJ5OdKiSdiJIjOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9Bngl1jYfGVIdMiO9wDYqKUPJRFl1NHXKD2aHeEW449Lxqfu/IAp6SDKzKk1ixQX07vag25YcVRC+Vyu1Q/p+7miEY7vbINr1C3rMuFpty5bZjyTGXkaiSKz1IxkJmThf7S7Of+I9ulTTfPbvd+H7iY2SGaK/jYOKbKGlm/W6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gtUj6Mp5; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gtUj6Mp5"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so396143b3a.1
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789097687; x=1789702487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fuXAmveLdtY834MnFfaJv8gpo2I0H6i9bOQiKf03dlw=;
        b=gtUj6Mp5AlOxNHmRhIfvG9DS5l/+7oq1gXw6q89QzWlV2Vh8joSZxw2S2FRLPKHr7/
         FjkI3KoG745uPh16//87TFLHtND0hFFmueWRUuHSb2N+DkkORtEVZlDwg6O2+HCN8ge7
         USIRKa+nBMARSZWC1zls352FtGfwDZDwNDFwQckQwymnIUcbMwhAcNNQ9gMWb6/WfMbX
         e/wb/pTqtQSYStP1zF44MxQDXUENyRxTYPO6JbvepS+U3Yv/F4oiCbH4eDT057YLN6Oo
         aJNPYAw+8KoXAnFrqWXWox5uz5ljJPqKdKg4O6ucVxelZYuphJWoW1Yer+eXJF0wFdI8
         CaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789097687; x=1789702487;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuXAmveLdtY834MnFfaJv8gpo2I0H6i9bOQiKf03dlw=;
        b=d5dpdbtklvuMPJSafxMifSuKhUp3kuPqeZbKX39KH3mEwR7sSW8O9JGrHDvdyVfaH2
         uSGmNJwHCZwvaJoblmWGQIZaaX4S/SgxSCyAV7TOSjLUpPowJUTJw/l3iuffb4PtGfPE
         +9wXr857x8W1UoFOttfF8gFiZ4LJqU6JQWJgWvHG0HBBxHZ8gko7zqdhxkGx/ML3ivCU
         tAK/WHTBzllNLeuTjZwIER+t7CxtaVM6UToumHKiLEzvHF2HGASRhYGgamo5L/ij7R3p
         ij4k5eeQbCxDZyjd1PujHcNaEm9OXB+plglkXzSZC5loTwfgfZojlFOUcZ3ZC0rCwKpN
         rF5A==
X-Gm-Message-State: AFuF++nj+gn4ErtFWWQi9Y3habfQVaGD5BO5UWoh4x2hUhi2cQdrNzzR
	cOan9DoHbrDrFpEgNUgq89jq7sb+FAjXJDgXjUK5d/kKTKj2n0vR+iXFcBpOmlJ0ZY0=
X-Gm-Gg: AYBFou28bovBmhdjo8/EInGI64PJ1xV5/S+Dm7SQUS6tzVgbJ1iIA1tzCJ75vANW12J
	Q9Qfon02VoyLCQqEVDUxahE7u2TMuw0cdmp7NB86PiGrtXEclzoh2g8S3dm/C/XlU2yWV8YGR7n
	PoePrc3GPm+S+fbgnx6+JvBEcuQT0qyKmpztS1anTBTNacqJc9EZCCziYw70fEmY0yOIOSsENOa
	CnQwdKOc0ZciORXTz0mJU84lg8iC4CcjCswsm60xfXpQSrDB4QxUqabRxxjpiW7qP0qDzjfn6h4
	qchGSKjMSdHRqzQ3vH6zFodymyb630xiqfP69fu8MSgyDU8HRlprTPcvOVBgRjLb4G6cu4TXU6n
	IjOL2vcua7QT16BqPcE61e/zWoMiIm/Klp3x/nLMexJRc0qXBcLq7AtU79s0+R8352CbrySII29
	ZqRNLiYpU1HT7p4h5dhusdar2GtABByIc0MOWqAjMWIxhbo5sx1gpa5WSeB+CEsZVVoRdvp9Xbp
	t/YYc/MCm3qGCyBdGA61SlFjmZgkP0iKTk1m0BkZSM=
X-Received: by 2002:a05:6a00:148d:b0:848:6c9c:4074 with SMTP id d2e1a72fcca58-86b30413328mr3281646b3a.1.1789097686524;
        Thu, 10 Sep 2026 20:34:46 -0700 (PDT)
Received: from [100.81.12.150] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b291bf622sm397251b3a.27.2026.09.10.20.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 20:34:46 -0700 (PDT)
Message-ID: <5e19472a-514a-4483-91c4-3c3b62c71600@bytedance.com>
Date: Fri, 11 Sep 2026 11:34:41 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH 2/7] fs: introduce sb_for_each_inodes().
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gfs2@lists.linux.dev, linux-security-module@vger.kernel.org,
 agruenba@redhat.com, mic@digikod.net, gnoack@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 aleksa@amutable.com, legion@kernel.org, djwong@kernel.org,
 ebiggers@kernel.org, sandeen@redhat.com
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
 <20260909090112.790006-3-sunjunchao@bytedance.com>
 <yhfoyto6skszguj447a7ifajl2r6qiwj5japcg2zsj2ooshi4r@tgkq5fadmyto>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <yhfoyto6skszguj447a7ifajl2r6qiwj5japcg2zsj2ooshi4r@tgkq5fadmyto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 1:47 AM, Jan Kara wrote:
> On Wed 09-09-26 17:01:07, Julian Sun wrote:
>> Add sb_for_each_inodes() to share s_inodes traversal and preserve its
>> position while s_inode_list_lock is dropped.
>>
>> Track active iterators on sb->s_inodes_iters and advance their saved
>> positions before unlinking an inode. Callbacks manage inode references
>> and per-inode work, allowing both normal walks and eviction to use the
>> same interface.
>>
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> 
> So I'm not generally opposed the to a superblock inode iterator idea but
> what you have looks more complex than I'd expect. Also we shouldn't tie
> that to the fix of the lockup in evict_inodes(). So first I'd just
> concentrate on fixing that lockup, then we can have a look at the iterator
> idea.
> 
> You can take some inspiration about inode iteration API from the Dave
> Chinner's patch set [1]. That looked more like what I'd expect although
> Christoph had some comments on it too.
> 
> Regarding the fix I'd just make evict_inodes() do what all other inode
> iterators do when they decide to drop s_inode_list_lock - pin an inode in
> the list by grabbing refcount and then resume from it.

Thanks for the feedback. I agree that we should fix the lockup separately,
and I'll focus on that first.

I had seen Dave Chinner's series before. I'll revisit it and the review
comments when working on the inode iteration API.>
> 								Honza
> 
> [1] https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/
> 
>> ---
>>   fs/inode.c                     | 93 ++++++++++++++++++++++++++++++++++
>>   fs/super.c                     |  1 +
>>   include/linux/fs.h             | 15 ++++++
>>   include/linux/fs/super_types.h |  3 +-
>>   4 files changed, 111 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/inode.c b/fs/inode.c
>> index ba7da39be4a3..b4279063a5dd 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -69,6 +69,15 @@ const struct address_space_operations empty_aops = {
>>   };
>>   EXPORT_SYMBOL(empty_aops);
>>   
>> +struct inode_iter {
>> +	struct list_head	iters_node;	/* sb->s_inodes_iters */
>> +	struct list_head	*next;		/* next node going to iterate */
>> +	unsigned int flags;
>> +	inode_iter_cb func;
>> +	void *data;
>> +	int ret;
>> +};
>> +
>>   static DEFINE_PER_CPU(unsigned long, nr_inodes);
>>   static DEFINE_PER_CPU(unsigned long, nr_unused);
>>   
>> @@ -641,12 +650,96 @@ void inode_sb_list_add(struct inode *inode)
>>   }
>>   EXPORT_SYMBOL_GPL(inode_sb_list_add);
>>   
>> +static void inode_sb_iter_start(struct super_block *sb, struct inode_iter *it,
>> +				unsigned int flags, inode_iter_cb fn, void *data)
>> +{
>> +	it->flags = flags;
>> +	it->func = fn;
>> +	it->data = data;
>> +	it->ret = 0;
>> +	spin_lock(&sb->s_inode_list_lock);
>> +	it->next = sb->s_inodes.next;
>> +	list_add(&it->iters_node, &sb->s_inodes_iters);
>> +}
>> +
>> +static void inode_sb_iter_end(struct inode_iter *it, struct super_block *sb)
>> +{
>> +	list_del(&it->iters_node);
>> +	spin_unlock(&sb->s_inode_list_lock);
>> +}
>> +
>> +static bool inode_sb_iter_next(struct inode_iter *it, struct super_block *sb)
>> +{
>> +	struct inode *inode = NULL;
>> +	int ret;
>> +
>> +	while (!inode && it->next != &sb->s_inodes) {
>> +		inode = list_entry(it->next, struct inode, i_sb_list);
>> +		if (it->flags & INODE_ITER_UNUSED) {
>> +			if (icount_read_once(inode)) {
>> +				it->next = it->next->next;
>> +				continue;
>> +			}
>> +
>> +			spin_lock(&inode->i_lock);
>> +			if (icount_read(inode)) {
>> +				spin_unlock(&inode->i_lock);
>> +				it->next = it->next->next;
>> +				continue;
>> +			}
>> +		} else {
>> +			spin_lock(&inode->i_lock);
>> +		}
>> +
>> +		if ((it->flags & INODE_ITER_NORMAL) &&
>> +		    (inode_state_read(inode) & (I_NEW | I_FREEING | I_WILL_FREE))) {
>> +			spin_unlock(&inode->i_lock);
>> +			it->next = it->next->next;
>> +			continue;
>> +		}
>> +
>> +		it->next = it->next->next;
>> +		ret = it->func(inode, it->data);
>> +		if (ret) {
>> +			it->ret = ret;
>> +			return false;
>> +		}
>> +
>> +		if (need_resched()) {
>> +			spin_unlock(&sb->s_inode_list_lock);
>> +			cond_resched();
>> +			spin_lock(&sb->s_inode_list_lock);
>> +		}
>> +	}
>> +
>> +	return it->next == &sb->s_inodes ? false : true;
>> +}
>> +
>> +int sb_for_each_inodes(struct super_block *sb, unsigned int flags,
>> +		       inode_iter_cb fn, void *data)
>> +{
>> +	struct inode_iter it;
>> +
>> +	inode_sb_iter_start(sb, &it, flags, fn, data);
>> +	while (inode_sb_iter_next(&it, sb))
>> +		;
>> +	inode_sb_iter_end(&it, sb);
>> +
>> +	return it.ret;
>> +}
>> +EXPORT_SYMBOL(sb_for_each_inodes);
>> +
>>   static inline void inode_sb_list_del(struct inode *inode)
>>   {
>>   	struct super_block *sb = inode->i_sb;
>> +	struct inode_iter *it;
>>   
>>   	if (!list_empty(&inode->i_sb_list)) {
>>   		spin_lock(&sb->s_inode_list_lock);
>> +		list_for_each_entry(it, &sb->s_inodes_iters, iters_node) {
>> +			if (it->next == &inode->i_sb_list)
>> +				it->next = inode->i_sb_list.next;
>> +		}
>>   		list_del_init(&inode->i_sb_list);
>>   		spin_unlock(&sb->s_inode_list_lock);
>>   	}
>> diff --git a/fs/super.c b/fs/super.c
>> index 05e443173038..3e069150c544 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -382,6 +382,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>>   	spin_lock_init(&s->s_roots_lock);
>>   	mutex_init(&s->s_sync_lock);
>>   	INIT_LIST_HEAD(&s->s_inodes);
>> +	INIT_LIST_HEAD(&s->s_inodes_iters);
>>   	spin_lock_init(&s->s_inode_list_lock);
>>   	INIT_LIST_HEAD(&s->s_inodes_wb);
>>   	spin_lock_init(&s->s_inode_wblist_lock);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 09c4db5e9ae0..f3176ab10e65 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -870,6 +870,21 @@ struct inode {
>>   	void			*i_private; /* fs or device private pointer */
>>   } __randomize_layout;
>>   
>> +enum inode_iter_flags_enum {
>> +	INODE_ITER_NORMAL = (1U << 1),  /* Exclude inodes with (I_NEW | I_FREEING | I_WILL_FREE). */
>> +	INODE_ITER_UNUSED = (1U << 2),  /* Only return inodes with (i_count == 0). */
>> +};
>> +
>> +/*
>> + *                             start          end
>> + *  inode->i_lock              locked         unlocked
>> + *  sb->s_inode_list_lock      locked         locked
>> + */
>> +typedef int (*inode_iter_cb) (struct inode *, void *);
>> +
>> +int sb_for_each_inodes(struct super_block *sb, unsigned int flags,
>> +		       inode_iter_cb fn, void *data);
>> +
>>   /*
>>    * i_state handling
>>    *
>> diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
>> index ecd96aeb1cee..1f81cc219b8e 100644
>> --- a/include/linux/fs/super_types.h
>> +++ b/include/linux/fs/super_types.h
>> @@ -269,9 +269,10 @@ struct super_block {
>>   	 */
>>   	int s_stack_depth;
>>   
>> -	/* s_inode_list_lock protects s_inodes */
>> +	/* s_inode_list_lock protects s_inodes and s_inodes_iters */
>>   	spinlock_t				s_inode_list_lock ____cacheline_aligned_in_smp;
>>   	struct list_head			s_inodes;	/* all inodes */
>> +	struct list_head			s_inodes_iters; /* all iterators */
>>   
>>   	spinlock_t				s_inode_wblist_lock;
>>   	struct list_head			s_inodes_wb;	/* writeback inodes */
>> -- 
>> 2.39.5
>>

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
