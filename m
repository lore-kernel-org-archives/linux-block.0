Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77521157E6B
	for <linux-block@vger.kernel.org>; Tue,  8 Apr 2025 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744078737; cv=none; b=WF17PVsfR+FkcwnR0bGUXE3wthH8uw5y/iHHt4QZUCbat9MLlXboe9aYIfgQIefBAIDSY5dNUh3nlfWN83544PhqVW4sjBPo+vl1ZSneuv6pzhGf/2iHv/XiOE/FBPZESK+pC9kzimLfV2+RNdpdLrbX339lpJ/tRQlK3RyyWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744078737; c=relaxed/simple;
	bh=PGknkL79QrF0GWiMVHIjmUZq9fxHfFywiGclnhTR5Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhIky2p96qWhy3XakYKF/Sg8R/DKb4jlbRTMjTPPZJ+KUd/jHhVTHavUlWg6ps49NLA14CSykZ7lk/pT+raQSUp9ipSmAXbl9LVDC65DNyvIECxq9iSdutkh2sDHjipeS7jVk9cSB+t/nnA45KdJRW+9QUE5VtG7+Nsz4ZCQ8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isq88Sq5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isq88Sq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744078734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2ir94nAodn7ZBCiKYPmHi42mGL9HdQDliiivjmmEPg=;
	b=isq88Sq5BmD/AmRlibHYZoBzSdyBdRQ1ImZskw7rUiO3Lp24VSnfO59jG8ZvU1yOR7Cvxb
	JqOdW44v3d7mKePEcP7qbwPEEcVVGjvw591LBma9EJ1d0iVy6Z4x953K41LL4xVvp53afE
	AKTE1oNqTz3jtf/nDSG3k2pVL8hnO3k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-Z70jT3cHOyK4klZ9cj9ZnQ-1; Mon,
 07 Apr 2025 22:18:40 -0400
X-MC-Unique: Z70jT3cHOyK4klZ9cj9ZnQ-1
X-Mimecast-MFC-AGG-ID: Z70jT3cHOyK4klZ9cj9ZnQ_1744078719
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB3161828B8E;
	Tue,  8 Apr 2025 02:18:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3E4B180174E;
	Tue,  8 Apr 2025 02:18:26 +0000 (UTC)
Date: Tue, 8 Apr 2025 10:18:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, io-uring@vger.kernel.org
Subject: Re: [PATCH 01/13] ublk: delay aborting zc request until io_uring
 returns the buffer
Message-ID: <Z_SHbVr3QM9Ay3ed@fedora>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
 <20250407131526.1927073-2-ming.lei@redhat.com>
 <CADUfDZodKfOGUeWrnAxcZiLT+puaZX8jDHoj_sfHZCOZwhzz6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZodKfOGUeWrnAxcZiLT+puaZX8jDHoj_sfHZCOZwhzz6A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 07, 2025 at 08:02:24AM -0700, Caleb Sander Mateos wrote:
> On Mon, Apr 7, 2025 at 6:15 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > When one request buffer is leased to io_uring via
> > io_buffer_register_bvec(), io_uring guarantees that the buffer will
> > be returned. However ublk aborts request in case that io_uring context
> > is exiting, then ublk_io_release() may observe freed request, and
> > kernel panic is triggered.
> 
> Not sure I follow how the request can be freed while its buffer is
> still registered with io_uring. It looks like __ublk_fail_req()
> decrements the ublk request's reference count (ublk_put_req_ref()) and
> the reference count shouldn't hit 0 if the io_uring registered buffer
> is still holding a reference. Is the problem the if
> (ublk_nosrv_should_reissue_outstanding()) case, which calls
> blk_mq_requeue_request() without checking the reference count?

Yeah, that is the problem, the request can be failed immediately after
requeue & re-dispatch, then trigger the panic, and I verified that the
following patch does fix it:


diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b..41bed67508f2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1140,6 +1140,25 @@ static void ublk_complete_rq(struct kref *ref)
 	__ublk_complete_rq(req);
 }
 
+static void ublk_do_fail_rq(struct request *req)
+{
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+		blk_mq_requeue_request(req, false);
+	else
+		__ublk_complete_rq(req);
+}
+
+static void ublk_fail_rq_fn(struct kref *ref)
+{
+	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
+			ref);
+	struct request *req = blk_mq_rq_from_pdu(data);
+
+	ublk_do_fail_rq(req);
+}
+
 /*
  * Since ublk_rq_task_work_cb always fails requests immediately during
  * exiting, __ublk_fail_req() is only called from abort context during
@@ -1153,10 +1172,13 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
-		blk_mq_requeue_request(req, false);
-	else
-		ublk_put_req_ref(ubq, req);
+	if (ublk_need_req_ref(ubq)) {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+		kref_put(&data->ref, ublk_fail_rq_fn);
+	} else {
+		ublk_do_fail_rq(req);
+	}
 }
 
 static void ubq_complete_io_cmd(struct ublk_io *io, int res,


Thanks,
Ming

