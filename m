Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48B1EB5D6
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663983; cv=none; b=eyW8eA5I5OcBnvsGDCz33FF2/2KuuuftS6DuU29I7r1oD6SkNNCYyBD7AD9y/j5u5R8dw7tC4Zq5IQ5cJjJdNHaCDJPQCrAklPQGvR/SyoEpbwGvoytEzFj4VXhpDAo+qU5yk+ZlvuP0GkdPDbnjkCNe7dx47+3YbMsTtMczWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663983; c=relaxed/simple;
	bh=czacHrj70cGIRoNj2Xnp1uC2BVAJF5/kvdZrXDKZAKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8q04uXzJYtbcL1GPTwsfPkptPAhYCfMw16V6gzwuFHTynz5NQeSTJ1ODQmkAbtT5ziuosxR1yC5t0FyQF5+lDjFHy7l+Uy7w2eziyeMjh7g+nAD/G8SebLsBKR/Ja2g5yxHtVYY0nJUnGM3bupyuJMhDUEmRKULfOswKQrEEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=USUtMYBo; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="USUtMYBo"
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so445667639f.1
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744663980; x=1745268780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zyT6eWD5BEH0TSnkcUrCE70q/7RVO5KJq3nPibSIHQ=;
        b=USUtMYBofMaStDteerspQfBrtLrMFWhnKuxG8W4HddHhLdK9XrGbp6LPJtJCL6DE0r
         R7gUkvSt/OizdcsGA5x4bNrnsbU0v8Uy7HVLhk5JTfIxkgPMiN7g3xyj1WaztOH1yc50
         zw56/62QpQMel9Mrb2ik8k4egW/iAbhum6pfapYFErpAXQ253Vd+rs4VmdW+3hMAAi+B
         QW+jzRZ84dPfC2DXr1S6N7BGhbQL4r/4EZb7TFCAhqZaLQzbiirPIkBZTOJ9bsHxdvt+
         XVMflyOrzvmzK3GI4katYVyESepWHzCSi6+DnonL0xbv2lWGKoRN5KeKbAixv6+XABF3
         aL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744663980; x=1745268780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zyT6eWD5BEH0TSnkcUrCE70q/7RVO5KJq3nPibSIHQ=;
        b=EcT0dd15jNfNa+c/Wd7TJ4B6koM/eA/NKvkperPAJ1epFBF2PgLWfDcH2P96E0kiKJ
         jQnx8wMpWe+DRe/QgzauIY+SUTKZ1e03cDplvjPfCZ5TQpGeZGYKlBtRBbYMvOPQnlia
         7veyif3pYeNMTR/SLiOQvYTsOLRKSImBJD3bAoNjht7h6YSN5vwSvdggod2mj1sADrgs
         fV6PiHaV6W9wFsC0YQUtPZ89LYmIQadCgC2gEKLe8sm4XY5fkNvSHSjoyeV1JacQQoBz
         q04kBlmv3SS/CwIi7kui7dFRZm85cDgwWYhpQmeBhDBbh1dZBwg1a0CZrSTtDaoFycGL
         Wmhg==
X-Forwarded-Encrypted: i=1; AJvYcCWaRKZ0JktymnuopER52qyZ1WpnP0VkQiDZ9XwnMmyn1DiPSNreUeuP3832InpTLOXTDWLpavpENM5YBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMU86jOYXAQ5qp6fByhMLiCUYBZQ/bGhuZN1iOeXwyeVQVEQN
	qsy7FFrmkOtmdjpGT1+1mp44s0ixXEjrk6sSbyESgqNMhaQUOWL9oLedBxVOZJbw2EdCIdWXqVK
	d1XGY5aeLADLqRKFVGHP890LNxNfecmVj
X-Gm-Gg: ASbGncuU3bg4tBKVQurStTWeX4umyiezoXgFuDZfw0CUEWCYelVem5BLiYzap85os4q
	Vfq7TXtt3vv8FPDW8i55X6t01SWLTJnGLEJjx+NkJ1I+eIZMStSbMKCMLryCJgnGy9YLTOvB3Ic
	G6y7tZQfhEWCvanp2OoPUN/69CE7mc13E/Xauz7NVBSnBWPJS9hxijb82X02hV+oYk3TLicTw5s
	WVXLBnVxnIj1GWlGytJtLZvLGd6YIEEKX5wiRl4+MSWc2xgPhCRhRtJXAaT9w7msQeWF+Babt9i
	SqsOqP4ZeDC9q0g+sY/o/M1fnkJHgNg2sfAXxHmP3SamkQ==
X-Google-Smtp-Source: AGHT+IELjrthdEQCLX0YXgxmiQORZ8hyLBU903EgVGTjit4hrY20LbQmNKSy2AP1KDXjDmKfzIksPUwQpbm0
X-Received: by 2002:a05:6e02:152a:b0:3d0:4a82:3f43 with SMTP id e9e14a558f8ab-3d7ec1cad7dmr132993825ab.5.1744663980221;
        Mon, 14 Apr 2025 13:53:00 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d7dc596605sm6708825ab.59.2025.04.14.13.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:53:00 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 63DCF3401C3;
	Mon, 14 Apr 2025 14:52:59 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4BEBAE402BD; Mon, 14 Apr 2025 14:52:59 -0600 (MDT)
Date: Mon, 14 Apr 2025 14:52:59 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/9] ublk: properly serialize all FETCH_REQs
Message-ID: <Z/11q+J0rW6rAJI9@dev-ushankar.dev.purestorage.com>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-3-ming.lei@redhat.com>
 <Z/1o946/z43QETPr@dev-ushankar.dev.purestorage.com>
 <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc912318-f649-46bd-8d7b-e5d18b3c45b5@kernel.dk>

On Mon, Apr 14, 2025 at 02:39:33PM -0600, Jens Axboe wrote:
> On 4/14/25 1:58 PM, Uday Shankar wrote:
> > +static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
> > +		      struct ublk_queue *ubq, struct ublk_io *io,
> > +		      const struct ublksrv_io_cmd *ub_cmd,
> > +		      unsigned int issue_flags)
> > +{
> > +	int ret = 0;
> > +
> > +	if (issue_flags & IO_URING_F_NONBLOCK)
> > +		return -EAGAIN;
> > +
> > +	mutex_lock(&ub->mutex);
> 
> This looks like overkill, if we can trylock the mutex that should surely
> be fine? And I would imagine succeed most of the time, hence making the
> inline/fastpath fine with F_NONBLOCK?

Yeah, makes sense. How about this?

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cdb1543fa4a9..bf4a88cb1413 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1832,8 +1832,8 @@ static void ublk_nosrv_work(struct work_struct *work)
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1845,7 +1845,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
@@ -1929,6 +1928,55 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
+		      struct ublk_queue *ubq, struct ublk_io *io,
+		      const struct ublksrv_io_cmd *ub_cmd,
+		      unsigned int issue_flags)
+{
+	int ret = 0;
+
+	if (!mutex_trylock(&ub->mutex)) {
+		if (issue_flags & IO_URING_F_NONBLOCK)
+			return -EAGAIN;
+		else
+			mutex_lock(&ub->mutex);
+	}
+
+	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
+	if (ublk_queue_ready(ubq)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* allow each command to be FETCHed at most once */
+	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * FETCH_RQ has to provide IO buffer if NEED GET
+		 * DATA is not enabled
+		 */
+		if (!ub_cmd->addr && !ublk_need_get_data(ubq))
+			goto out;
+	} else if (ub_cmd->addr) {
+		/* User copy requires addr to be unset */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+	ublk_mark_io_ready(ub, ubq);
+
+out:
+	mutex_unlock(&ub->mutex);
+	return ret;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1985,34 +2033,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
-		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
-		if (ublk_queue_ready(ubq)) {
-			ret = -EBUSY;
-			goto out;
-		}
-		/*
-		 * The io is being handled by server, so COMMIT_RQ is expected
-		 * instead of FETCH_REQ
-		 */
-		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * FETCH_RQ has to provide IO buffer if NEED GET
-			 * DATA is not enabled
-			 */
-			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
-		} else if (ub_cmd->addr) {
-			/* User copy requires addr to be unset */
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_mark_io_ready(ub, ubq);
-		break;
+		return ublk_fetch(cmd, ub, ubq, io, ub_cmd, issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
 

