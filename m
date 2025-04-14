Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD74288DB
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744597948; cv=none; b=DUeRn+S0UACJPYMzp+I0QqlCcnH4LQSQceVN0RAt79Q7hpLLnn29ImJpc7McoQOOm/2XWV7GHvKuzI8kNmRFT/kORlJ28uq8veYmt40d6knmOk5NOyCTcKy62S7kajgEg6Mwk5rHdnulUInR/X1xNRGRj+tK+S0LjfjaUxxqGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744597948; c=relaxed/simple;
	bh=nj/OJiT3Uv7efORJaLdxmk6LbxLS0A4fgcn6bGaUDHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW50YTCHkJQPjMxq0nq5LZXXUBUmG9ezGPPnIMyQRTyNX7DJTPNuIX98umzbh7Uu3hzfkQg1wXoecm5aTsm9cHC5/kxavP1EEQi31/JD0TdSEvmZwC2j/iJWkfALtBEVPtelNTGu8W6icp9tV3BHhLw7Fom7bKQS3QLYJjcoBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i30hF3z+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i30hF3z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744597945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkS82OAQdY+39unthVL4zwadcdh17zRWtCDKUDSmcU4=;
	b=i30hF3z+5GiAY11uAEn0bvc7K9Tl0lS6H/KBteNyUHsqMmFVjdqWAzZ8JjSOa9yablh8R/
	swWUwz27RzoJQCzu9nZpaCguMX/BWjINRHRCmRETFbJp6m0SyzeDUnyyc53V8DyZOfUa/X
	mDGgYiK5LMHwfy0EGxDf3jL4zEt8YVM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-vK05lPYcMw-mE7NptueaZA-1; Sun,
 13 Apr 2025 22:32:21 -0400
X-MC-Unique: vK05lPYcMw-mE7NptueaZA-1
X-Mimecast-MFC-AGG-ID: vK05lPYcMw-mE7NptueaZA_1744597940
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 004D3195608A;
	Mon, 14 Apr 2025 02:32:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B35E180B489;
	Mon, 14 Apr 2025 02:32:15 +0000 (UTC)
Date: Mon, 14 Apr 2025 10:32:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	WoZ1zh1 <wozizhi@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 3/3] blk-throttle: carry over directly
Message-ID: <Z_xzqpzEuoahiKGJ@fedora>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
 <20250305043123.3938491-4-ming.lei@redhat.com>
 <14e6c54f-d0d9-0122-1e47-c8a56adbd5db@huaweicloud.com>
 <Z_ku5L3sVZbHdbQ_@fedora>
 <646e8bdd-9186-2c54-4962-be3b4962b959@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <646e8bdd-9186-2c54-4962-be3b4962b959@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Apr 12, 2025 at 08:37:28AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/04/11 23:01, Ming Lei 写道:
> > On Fri, Apr 11, 2025 at 10:53:12AM +0800, Yu Kuai wrote:
> > > Hi, Ming
> > > 
> > > 在 2025/03/05 12:31, Ming Lei 写道:
> > > > Now ->carryover_bytes[] and ->carryover_ios[] only covers limit/config
> > > > update.
> > > > 
> > > > Actually the carryover bytes/ios can be carried to ->bytes_disp[] and
> > > > ->io_disp[] directly, since the carryover is one-shot thing and only valid
> > > > in current slice.
> > > > 
> > > > Then we can remove the two fields and simplify code much.
> > > > 
> > > > Type of ->bytes_disp[] and ->io_disp[] has to change as signed because the
> > > > two fields may become negative when updating limits or config, but both are
> > > > big enough for holding bytes/ios dispatched in single slice
> > > > 
> > > > Cc: Tejun Heo <tj@kernel.org>
> > > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > > Cc: Yu Kuai <yukuai3@huawei.com>
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >    block/blk-throttle.c | 49 +++++++++++++++++++-------------------------
> > > >    block/blk-throttle.h |  4 ++--
> > > >    2 files changed, 23 insertions(+), 30 deletions(-)
> > > > 
> > > > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > > > index 7271aee94faf..91dab43c65ab 100644
> > > > --- a/block/blk-throttle.c
> > > > +++ b/block/blk-throttle.c
> > > > @@ -478,8 +478,6 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
> > > >    {
> > > >    	tg->bytes_disp[rw] = 0;
> > > >    	tg->io_disp[rw] = 0;
> > > > -	tg->carryover_bytes[rw] = 0;
> > > > -	tg->carryover_ios[rw] = 0;
> > > >    	/*
> > > >    	 * Previous slice has expired. We must have trimmed it after last
> > > > @@ -498,16 +496,14 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
> > > >    }
> > > >    static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
> > > > -					  bool clear_carryover)
> > > > +					  bool clear)
> > > >    {
> > > > -	tg->bytes_disp[rw] = 0;
> > > > -	tg->io_disp[rw] = 0;
> > > > +	if (clear) {
> > > > +		tg->bytes_disp[rw] = 0;
> > > > +		tg->io_disp[rw] = 0;
> > > > +	}
> > > >    	tg->slice_start[rw] = jiffies;
> > > >    	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
> > > > -	if (clear_carryover) {
> > > > -		tg->carryover_bytes[rw] = 0;
> > > > -		tg->carryover_ios[rw] = 0;
> > > > -	}
> > > >    	throtl_log(&tg->service_queue,
> > > >    		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
> > > > @@ -617,20 +613,16 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
> > > >    	 */
> > > >    	time_elapsed -= tg->td->throtl_slice;
> > > >    	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
> > > > -					     time_elapsed) +
> > > > -		     tg->carryover_bytes[rw];
> > > > -	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed) +
> > > > -		  tg->carryover_ios[rw];
> > > > +					     time_elapsed);
> > > > +	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
> > > >    	if (bytes_trim <= 0 && io_trim <= 0)
> > > >    		return;
> > > > -	tg->carryover_bytes[rw] = 0;
> > > >    	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
> > > >    		tg->bytes_disp[rw] -= bytes_trim;
> > > >    	else
> > > >    		tg->bytes_disp[rw] = 0;
> > > > -	tg->carryover_ios[rw] = 0;
> > > >    	if ((int)tg->io_disp[rw] >= io_trim)
> > > >    		tg->io_disp[rw] -= io_trim;
> > > >    	else
> > > > @@ -645,7 +637,8 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
> > > >    		   jiffies);
> > > >    }
> > > > -static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
> > > > +static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
> > > > +				  long long *bytes, int *ios)
> > > >    {
> > > >    	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
> > > >    	u64 bps_limit = tg_bps_limit(tg, rw);
> > > > @@ -658,26 +651,28 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
> > > >    	 * configuration.
> > > >    	 */
> > > >    	if (bps_limit != U64_MAX)
> > > > -		tg->carryover_bytes[rw] +=
> > > > -			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> > > > +		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> > > >    			tg->bytes_disp[rw];
> > > >    	if (iops_limit != UINT_MAX)
> > > > -		tg->carryover_ios[rw] +=
> > > > -			calculate_io_allowed(iops_limit, jiffy_elapsed) -
> > > > +		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
> > > >    			tg->io_disp[rw];
> > > > +	tg->bytes_disp[rw] -= *bytes;
> > > > +	tg->io_disp[rw] -= *ios;
> > > 
> > > This patch is applied before I get a chance to review. :( I think the
> > > above update should be:
> > 
> > oops, your review period takes too long(> 1 month), :-(
> 
> Yes, I just didn't review in detail when I see this set is applied...
> > 
> > > 
> > > tg->bytes_disp[rw] = -*bytes;
> > > tg->io_disp[rw] = -*ios;
> > 
> > I think the above is wrong since it simply override the existed dispatched
> > bytes/ios.
> > 
> > The calculation can be understood from two ways:
> > 
> > 1) delta = calculate_bytes_allowed(bps_limit, jiffy_elapsed) - tg->bytes_disp[rw];
> > 
> > `delta` represents difference between theoretical and actual dispatch bytes.
> > 
> > If `delta` > 0, it means we dispatch too less in past, and we have to subtract
> > `delta` from ->bytes_disp, so that in future we can dispatch more.
> 
> But the problem is that in this patch, slice_start is set to *jiffies*,
> keep the old disp filed that is between old slice_start to jiffies does
> not make sense.



> > 
> > Similar with 'delta < 0'.
> > 
> > 2) from consumer viewpoint:
> > 
> > tg_within_bps_limit(): patched
> > 
> > 	...
> > 	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
> > 	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
> > 		...
> > 
> > tg_within_bps_limit(): before patched
> > 	...
> >      bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
> > 		tg->carryover_bytes[rw];
> > 	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
> > 		...
> > 
> > So if `delta` is subtracted from `bytes_allowed` in patched code, we should
> > subtract same bytes from ->byte_disp[] side for maintaining the relation.
> > 
> 
> In the original carryover calculation, bytes_disp is always set to 0,
> while slice start is set to jiffies. Patched version actually will be
> less than old version if bytes_disp is not 0;

Indeed, you are right, care to send one fix?

Otherwise, please let me know, and I can do it too.


Thanks,
Ming

