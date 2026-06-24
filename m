Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EB25B0AE
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294263; cv=none; b=eIO8u16Tkwrvb4xUutbNzgoVqMCe4fKw7cGunq++NfdAVTLNM9gOvSMoPIYUBvr2cunMAztyhjdKJxWXyLnotmSoh1V3Tpk8oW2zTfUw0gObn761HwAEseabPQecigIy39966jCIA7JyMDlhleZJUOjlWcGQL3C7PUVoIFu/K6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294263; c=relaxed/simple;
	bh=Er+CoXlE0qKr6Wl1gnIUVk81x+XWv9ivbXqtAwduT7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTF4p2GTq6HinXDjmViS6ndq9nk2TlTjtnDeJbhS79jO3vwWwOVRGmnEiIF7Z4PnGsvk0uWU6b7PrQ7++HJbVrnfsKtruq+X8SGBrlvE5Fw/CfF2sRVCV1CKnNdyyiqQjCmA0Ab/eNT6a4Jpl5g8IUZ1TZqPFbbbLu2VDyq4QkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCNd0mBm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCNd0mBm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91591f19c30so115711985a.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782294260; x=1782899060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWahjBaYCGUkSS6UYvn12GjsQBiXfoKJkyEVr7CwIq4=;
        b=dCNd0mBmOnSNlY9AZSAhSfYLFBYZs29Ejzilj57cT1w0QBpL073FlwGf0S3wM8WCsF
         zU5FdjGhVwyLw4mAm6VAjerkw6zL+E+aZeRIpzARqIe9IxJW65XYXYuuTA3xYEpTjYoj
         yvZIjcXaM88mw2A5oJiJXKKpprEdy00uZKQXWjek32NNw/HBZricTzNSEFzexCcP5z2Y
         XJ0mrZtBIMK1Db8AFA2kxKCjE/hhoIM9SeDNESuCWvOEjjNo5cLiA1IFFIrCbgpP5nr6
         TE7cfnSPh4dY8dcY6G6J/LsYd2+JkCPiNt6AiduT41O3WcBh+GjdKTmHHwb7t/cRz4wj
         VMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782294260; x=1782899060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWahjBaYCGUkSS6UYvn12GjsQBiXfoKJkyEVr7CwIq4=;
        b=LJ7EhnZyMSZY9NEtV/R9Fk7fBebXSiSiRqpRkTU2xsFC8/R+pYGW8PuekB4KrvftpR
         DfYsik463pRVa7OpnevGhsLwaQ6nZn9OLQnWrHBrAoW1SGlUsARYSx5ckLKAYralszvY
         y9mFqbEZaT2et5HUMBiyn8vEyl3bdVag6JlAlq+kbCtBLAIkS4DDsxIUi1QwkafufYJ1
         dCPVOhLiFQOGr8Vc/hyztKCSTExUcFqAhoycbPHr+kfCghLqc+z8bS0EE3FPV1emJ2rf
         Xa0gUrI0YoOsUMHqnq7jWz5Xzsy93zeWtXLtT2j1aTYwVKOT54dBOvWYvoERWW6mN/ie
         ZN+g==
X-Gm-Message-State: AOJu0YxhSNFfH+tWhzAwUkMqjZunC6+WXRgKUUsohPnJuDpGTVyhqM/i
	4s7ITJHytnW4VUGKuxRx0fTu+DhVKj3An2THB4xUQEDQ378F1fh6eAEE
X-Gm-Gg: AfdE7cn/LK0gJvL28+UlrQ0Gt6YX9GD2UWwbG1sqfGv8gLTPktIGa9irZsmCI/Y/vur
	yQRXnGWlEi4MgLVXJrZrdtPpZvCTLqiiS5BXPEWv1utngWdKrxbrWPmIYrqNn5Uxg1C4lMJdL/3
	QBcHPg1MUgjVpnVSLZfzwsKHkWX70DzO+EfHPMXheORmwxn1YHPRzi7Mb/Cyk8fLw5R/bYTOZcx
	A0aXDMkwKONgVfrkGknV1iMKEH+Cc3EvvZW/KgLV993LzTkMjZVCmIuHlQsXlB9vKPveySk+/GQ
	IWwvz2vWorjM8DBp83qJrsIMfG+My7e59rPSHPzhFikORtcgHCO+93my+vSlMnA0wpcWPTOnECM
	uD00KxLbutpJjsoeGOiHo50ZCo0cLLdCECsZlu4Yzx1UbjiqPqnlfrOYZT9VbGgxMD51OcXLGF5
	/f1eh/qIVMWWiQaDuGN3kcPKhGTBb0jhs30vaVUoyzxf+kAIR9B2MLVS8Jj67F5tHtORP8SYTVH
	2BBvTSX
X-Received: by 2002:a05:620a:2610:b0:915:bf79:3e0a with SMTP id af79cd13be357-9277df588d3mr414741085a.26.1782294260421;
        Wed, 24 Jun 2026 02:44:20 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ac1acsm503817685a.32.2026.06.24.02.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:44:19 -0700 (PDT)
Date: Wed, 24 Jun 2026 04:44:14 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] block: serialize elevator changes for the same queue
 using a writer lock
Message-ID: <ajum7l5BPDRoeJgi@fedora>
References: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>

On Tue, Jun 23, 2026 at 10:32:38AM +0900, Shin'ichiro Kawasaki wrote:
> When elevator_change() is called concurrently for the same queue, the
> elevator_change_done() function runs concurrently as well. This function
> adds or deletes kobjects for the debugfs entry of the queue. Then the
> concurrent calls cause memory corruption of the kobjects and result in a
> process hang. The core part of the elevator switch is protected by queue
> freeze and q->elevator_lock. However, since the commit 559dc11143eb
> ("block: move elv_register[unregister]_queue out of elevator_lock"), the
> elevator_change_done() is not serialized. Hence the memory corruption
> and the hang.
> 
> The failures are observed when udev-worker writes to a sysfs
> queue/scheduler attribute file while the blktests test case block/005
> writes to the same attribute file. The failure also can be recreated by
> running two processes that write to the same queue/scheduler file
> concurrently. The failure is observed since another commit 370ac285f23a
> ("block: avoid cpu_hotplug_lock depedency on freeze_lock"). This commit
> changed the behavior of queue freeze and it unveiled the failure.
> 
> Fix the failure by changing elv_iosched_store() to acquire
> update_nr_hwq_lock as the writer lock instead of the reader lock. This
> serializes the whole elevator switch steps, including the
> elevator_change_done() call.
> 
> Fixes: 559dc11143eb ("block: move elv_register[unregister]_queue out of elevator_lock")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> I observed that the blktests test case block/005 hung on a specific
> server hardware using a specific HDD as a block device. During the test
> case run, the kernel reported KASAN null-ptr-deref and slab-use-after-
> free errors. The failure happened when a sysfs queue/scheduler attribute
> file is written concurrently. I reported the failure and shared a
> candidate fix patch as RFC [1]. Based on the comments and discussion on
> the RFC patch, I propose this v2 patch that avoids introducing a new
> lock. My thanks go to Ming and Nilay for the discussion.
> 
> Please refer to [1] for details of the failure. Also, I created a
> blktests test case that recreates the hang [2], which I used to test the
> fix.
> 
> * Changes from RFC v1
> - Instead of adding a new mutex to struct request_queue, replace the
>   reader lock on update_nr_hwq_lock with the writer lock in
>   elv_iosched_store().
> 
> [1] https://lore.kernel.org/linux-block/20260611074200.474676-1-shinichiro.kawasaki@wdc.com/
> [2] https://github.com/kawasaki/blktests/commit/8e80b3ccc0bbbe3f209d00eacd138d020de97fc6
> 
>  block/elevator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 3bcd37c2aa34..b03185a217ff 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
>  	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
>  	 */
> -	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
> +	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -824,7 +824,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  	} else {
>  		ret = -ENOENT;
>  	}
> -	up_read(&set->update_nr_hwq_lock);
> +	up_write(&set->update_nr_hwq_lock);

I feel this is still abuse of the above lock, which serves writer vs
reader wrt. updating hw queue.

How about the following fix?


diff --git a/block/elevator.c b/block/elevator.c
index 3bcd37c2aa34..0375eb77646e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -627,8 +627,10 @@ static void elv_exit_and_release(struct elv_change_ctx *ctx,
 static int elevator_change_done(struct request_queue *q,
 				struct elv_change_ctx *ctx)
 {
+	bool exit_and_release = false;
 	int ret = 0;
 
+	mutex_lock(&q->elevator_lock);
 	if (ctx->old) {
 		struct elevator_resources res = {
 			.et = ctx->old->et,
@@ -640,10 +642,24 @@ static int elevator_change_done(struct request_queue *q,
 		kobject_put(&ctx->old->kobj);
 	}
 	if (ctx->new) {
+		if (ctx->new != q->elevator) {
+			ret = -EBUSY;
+			goto unlock;
+		}
 		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
+		/*
+		 * Tear down the failed elevator after dropping elevator_lock:
+		 * elv_exit_and_release() freezes the queue and re-acquires
+		 * elevator_lock itself, so it must not be called nested here.
+		 */
 		if (ret)
-			elv_exit_and_release(ctx, q);
+			exit_and_release = true;
 	}
+unlock:
+	mutex_unlock(&q->elevator_lock);
+
+	if (exit_and_release)
+		elv_exit_and_release(ctx, q);
 	return ret;
 }
 


Thanks,
Ming
