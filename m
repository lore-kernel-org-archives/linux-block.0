Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AED49658;
	Fri, 23 Aug 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398260; cv=none; b=sXvzGbe/TKSBeajS057bVShMe+QYIPA3qVsXLZ46Zc6lRt3dKoBObPYOIWnHqQ5zOD5x2rpSdaQxspcvvLRMt216Ashy3F+fiGjxkxCxy+ZxuuWHD4JHNL+JFyb+D8CLS4AuDG1y7CMv3646C/tOXgdwl6kWbb5pHpi7eAmbLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398260; c=relaxed/simple;
	bh=HTgsS8yGkQgwz0KrbrnUtMjEAjYauKvLeg9BAKwSCrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQjD0KLn79nLQv7ltsBGpbDOTTreMWV/S8ae8G1F93g9bUCoz6RImYcqv27FzSlrEZx24o0I5mAzKDt0a8V75QJ8sQxE/iOnjSKHmlwGVAh84tRxEK2CJJ2ZLlWisebeMl2WgXkdHJo6+7+jqzRvcU5Gyr/XkJopOx32Z6e4bc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GzXzqG/K; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GzXzqG/K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nQaTVEoUYWxzonOOhuvizub87Mn74w/Jwvu9FqsOAOY=; b=GzXzqG/KNy8kDi3MRjm9nwoW7B
	fLW4VL6gOMWR1VJkpHjLSumwpByjhru/77E2q4I8u7MfAHdbUk7TX+NM3ilF7SW4RRb5qX2bDM2dN
	7KrhJFXVHyFvVcVtd04Uk+MAs7Pj+7vhK3xjFqMlgFD7eFKXbCAmm9kUoAkRGqp0+XOQXvx4HnspH
	togDE0cFpzSTV9P5B5JbZ4OfymrM6JPWG4gab25YpE7XFi6R0m+E04hwaZBxOxiRho6UcRO9tjA4w
	/yTM74n9UTnCOpFNmtTuvJqzPNfnhrAVFGyKUNNxviVFRMkRXLmfm09Hl7H+RxP+SiMblF47Ye+db
	3LOez50A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1shOl5-00000004RGn-0mnb;
	Fri, 23 Aug 2024 07:30:55 +0000
Date: Fri, 23 Aug 2024 08:30:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: axboe@kernel.dk, justin@coraid.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aoe: Use IS_ERR_OR_NULL() to clean code
Message-ID: <20240823073055.GD1049718@ZenIV>
References: <20240823052640.3668-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823052640.3668-1-zhangjiao2@cmss.chinamobile.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 23, 2024 at 01:26:40PM +0800, zhangjiao2 wrote:
> From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Use IS_ERR_OR_NULL() to make the code cleaner.

ITYM "obfuscate the bogus code".

Take a look at kthread_run() definition:

#define kthread_run(threadfn, data, namefmt, ...)                          \
({                                                                         \
        struct task_struct *__k                                            \
                = kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
        if (!IS_ERR(__k))                                                  \
                wake_up_process(__k);                                      \
        __k;                                                               \
})

OK, what would need to happen for that to return NULL?  kthread_create()
returning NULL *AND* wake_up_process(NULL) surviving, right?

int wake_up_process(struct task_struct *p)
{
        return try_to_wake_up(p, TASK_NORMAL, 0);
}

OK, so we'd need try_to_wake_up(NULL, ...) to survive execution:

int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
{
        guard(preempt)();
        int cpu, success = 0;

        if (p == current) {
		whatever, current is never NULL or a lot of places would be
		utterly screwed
	}
	/* some comment */
        scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {

... and that would start with trying to grab &NULL->pi_lock, which is not
going to survive.

>  	task = kthread_run(kthread, k, "%s", k->name);
> -	if (task == NULL || IS_ERR(task))
> +	if (IS_ERR_OR_NULL(task))
>  		return -ENOMEM;

In other words, task == NULL had been pointless all along.  Your change only
makes it harder to spot.

IS_ERR_OR_NULL is almost never the right thing to do; there are cases where
a function may legitimately return a pointer to object, NULL *or* ERR_PTR(something),
but most of the time it's either impossible (and the caller couldn't have been
arsed to check what the calling conventions are) or a sign of a function in
bad need of saner calling conventions.

In this case it's the former - kthread_run() never returns a NULL and
actually if you look into kthread_create() you'll see that it returns
a pointer to new task_struct instance on success and ERR_PTR(-E...) on
failure.  NULL is never returned by that thing.

This kind of "defensive" programming only confuses the readers; please,
don't paper over that garbage.
