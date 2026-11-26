Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707141;
	b=f3BJMha96nzS05RKVYXS0ypalDV7fcweghDyoqYvg4BBPyyzbyVLA2/s8DHWZTK7CVku
	 JdmEquO6gC1Q4/5BJNLmzhrqN7sqTjn8Xk+wi5kegIhQPUDFqYINTIybbKTBEvZG4lBwH
	 qutlhX9BNlm3P1bAMADS8WLbodmpaVd5P9026fyu9CK1QpY9wdC2Ds9Q/ccMbA0ShfgNN
	 hoQNO/eKH17rjiMQza1dXHzbToksEitJawrxcx+SEjltFY5hw8AXRP5DE44MaIMEAN5Pj
	 pIjGJjVcPwuELmDw9amtjOoEazFH9jmlM4icPd+K7YJxxNgyystJbag0mvGHDWWLBLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PNRTFodZeg3klhEIHpNcqT1+QKIt6csRkW2GBELWkCs=;
	b=Z9zqDLNLITZVLl+hvGuZNv09ZYgigtRIpMf3MXPx/BJi2msND8Sx9za78BMtkFTqEiZt
	 Sy77F+ZvJX0aKTToR5IOTk1ZTquAzf+o7dd5lY3E30T3t4qPC3bu4hIjzF6gLDgiUhPEX
	 9VzqEFdlW5d2ltUyzKKl4MHQve74K2CGkYifhPC8InDEB6oFPzhvrjUaCCkTNOFaRjAge
	 sOuPW+Kx2dQRqjsXRnKUbt7Y7PxaZSVWLPLI71IRg21iHWtKnvMs1iS82B5fukbY7SP4/
	 GFcJN/xfUjkWXXB76+sce4TbdDkWTfhZVfodeeGBr33JmwdvveyJ7u47YSMmtM3vanQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="38CVG2/u";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51566606A31E;
	Thu, 26 Nov 2026 15:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51566606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=38CVG2/u
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jb0sc4lYZz1XLwXS;
	Thu, 26 Nov 2026 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795707134; x=1798299135; bh=PNRTFodZeg3klhEIHpNcqT1+
	QKIt6csRkW2GBELWkCs=; b=38CVG2/uMumHKcw/S8mzwUmeTxIHZL3YTBVvnCBD
	4UvbmY20qQttqp7QYeiaI3lNjsB3pBGO1UHCvy3I+uWcLZ1o+dPWNaQiFQtDay+g
	Weruj3T/U02BoK1usxsOdwpKvDb4JcJ60x/kFhO0pjPJ74J8yFdQzC0WC+NE55X/
	pF0VejWN644e2bGhcTRpzVG/5HPmXVuxZSh/LC62s0r8+01037Kljjjg53U8K25A
	Qogqx8HmcLIQILl2UK62GQa5krp+I2iDh7FTlx5hI/L1JVE865w+5Y7pjkAOVXPf
	82yIknVm2IFzPW9835lFHaB7VtVbM0X5OSjoHE3tI7LEpQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zjxEdK-9Tc2n; Thu, 26 Nov 2026 15:32:14 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jb0sT6v67z1XLyhd;
	Thu, 26 Nov 2026 15:32:13 +0000 (UTC)
Message-ID: <46cefe96-a193-40f9-bc1a-facc73cf6afa@acm.org>
Date: Thu, 26 Nov 2026 07:32:12 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20261126054223.176824-1-cui.tao@linux.dev>
 <20261126135628.495497-1-cui.tao@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261126135628.495497-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/26 5:56 AM, Tao Cui wrote:
> loop_clear_limits() calls queue_limits_commit_update() directly from
> the loop workqueue that processes the request.  That does a
> non-atomic struct assignment to q->limits without freezing the queue,
> which races with lockless readers of q->limits on other CPUs, such
> as bio splitting reading max_hw_sectors and the discard path reading
> max_hw_discard_sectors, letting them observe torn values.  The
> trigger is a discard or write-zeroes request on a loop device whose
> backing file does not support the corresponding fallocate operation.
> 
> The code already has an XXX comment saying this should move to a
> workqueue.  Do that: schedule a work item on the system workqueue,
> where it is safe to freeze the queue around the limits update.  The
> work item takes the queue limits lock before freezing, matching the
> order used by loop_set_dio() and loop_set_block_size().  The
> unsupported modes live under a new mutex, lo->clear_limits_lock,
> guarded by a backing-file check that drops records from a racing
> unbind or rebind.  The work item is scheduled while holding that
> lock, so an unbind resets the verdicts under the lock before calling
> cancel_work_sync() and cannot miss a schedule from a request that is
> still in flight.  Requests that arrive while the clear is in flight
> fail quietly, so the console report stays at the first failure.
> loop_remove() also cancels the work item before the queue becomes
> unreachable.

This patch is more complicated and harder to verify than it should. Has
it been considered to allocate memory dynamically instead of adding new
members to struct loop_device, as is done in the untested patch below?

Thanks,

Bart.


diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d122cb008811..bd9c453a9b8c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -222,26 +222,76 @@ static void loop_set_size(struct loop_device *lo, 
loff_t size)
  		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
  }

-static void loop_clear_limits(struct loop_device *lo, int mode)
+/*
+ * Information passed from lo_fallocate() to loop_clear_limits_workfn().
+ * @lo_backing_file holds a reference to prevent that the backing file is
+ * freed and its address is reused by another backing file before
+ * loop_clear_limits_workfn() has finished.
+ */
+struct loop_clear_limits_work {
+	struct work_struct	clear_limits_work;
+	struct loop_device	*lo;
+	struct file		*lo_backing_file;
+	int			mode;
+};
+
+static void loop_clear_limits_workfn(struct work_struct *work)
  {
-	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
+	struct loop_clear_limits_work *w = container_of(work,
+				struct loop_clear_limits_work, clear_limits_work);
+	struct loop_device *lo = w->lo;
+	struct queue_limits lim;
+	unsigned int memflags;
+	bool changed = false;

-	if (mode & FALLOC_FL_ZERO_RANGE)
-		lim.max_write_zeroes_sectors = 0;
+	mutex_lock(&lo->lo_mutex);
+	/* Skip the update if the loop device has been unbound or rebound. */
+	if (lo->lo_state != Lo_bound || lo->lo_backing_file != w->lo_backing_file)
+		goto unlock;

-	if (mode & FALLOC_FL_PUNCH_HOLE) {
+	lim = queue_limits_start_update(lo->lo_queue);
+	if ((w->mode & FALLOC_FL_ZERO_RANGE) && lim.max_write_zeroes_sectors) {
+		lim.max_write_zeroes_sectors = 0;
+		changed = true;
+	}
+	if ((w->mode & FALLOC_FL_PUNCH_HOLE) && lim.max_hw_discard_sectors) {
  		lim.max_hw_discard_sectors = 0;
  		lim.discard_granularity = 0;
+		changed = true;
  	}
-
-	/*
-	 * XXX: this updates the queue limits without freezing the queue, which
-	 * is against the locking protocol and dangerous.  But we can't just
-	 * freeze the queue as we're inside the ->queue_rq method here.  So this
-	 * should move out into a workqueue unless we get the file operations to
-	 * advertise if they support specific fallocate operations.
-	 */
+	if (!changed) {
+		queue_limits_cancel_update(lo->lo_queue);
+		goto unlock;
+	}
+	memflags = blk_mq_freeze_queue(lo->lo_queue);
  	queue_limits_commit_update(lo->lo_queue, &lim);
+	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+
+unlock:
+	mutex_unlock(&lo->lo_mutex);
+	fput(w->lo_backing_file);
+	kfree(w);
+}
+
+/*
+ * The queue limits can't be modified from inside lo_fallocate() since that
+ * would require freezing the queue while a request is being processed. 
Hence
+ * defer the queue limits update to a work item. The work item is queued on
+ * lo->workqueue such that lo_free_disk() waits for it to finish.
+ */
+static void loop_clear_limits(struct loop_device *lo, struct file *file,
+			      int mode)
+{
+	struct loop_clear_limits_work *w;
+
+	w = kmalloc_obj(*w, GFP_NOIO);
+	if (!w)
+		return;
+	INIT_WORK(&w->clear_limits_work, loop_clear_limits_workfn);
+	w->lo = lo;
+	w->lo_backing_file = get_file(file);
+	w->mode = mode;
+	queue_work(lo->workqueue, &w->clear_limits_work);
  }

  static int lo_fallocate(struct loop_device *lo, struct request *rq, 
loff_t pos,
@@ -268,7 +318,7 @@ static int lo_fallocate(struct loop_device *lo, 
struct request *rq, loff_t pos,
  	 * supported and clear them here if that turns out not to be true.
  	 */
  	if (unlikely(ret == -EOPNOTSUPP))
-		loop_clear_limits(lo, mode);
+		loop_clear_limits(lo, file, mode);

  	return ret;
  }

