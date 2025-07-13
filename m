Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A12E3705
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752373888; cv=none; b=R1PUvkBNVvNV9PpUC8emvrtd3J4cj+fgB59gGyexQDl0S+GTYpl/j4upt48AdW3+uIDrXhCjCyZ6DJ5YOBD+EVMg9BUmMFpofgNL1jAhFD/3GZ463xbWCISySjKP78v80DgI+t/Wuq9QLsIxsTZrJ7Fvrdw8VUr6MAid1fhUODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752373888; c=relaxed/simple;
	bh=I2/SIS8ibrn0GR2Tl+7utPSKeOa70uGhyNTGdm8l+2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/4DQ72FOErzaDc2paIm4aKpNC2JhA7dmFiqiqBpp8wBS02/NxRagVOPUmM9y5JkYTJ/ksXwuoXIzXwJauBALaOLRSxhVFunYqH9blSF8g/eQHpPSYSDALRxTIYs9BIggrTr757Y6bmI63wwdzyKLFCTWJs4UYGrpZ8IBs1Qos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VK/8SHEA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK/8SHEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752373884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uoz3NER+ku7Ippj+3QQAhF7dTUF7EH3QjvuFzmNtPA=;
	b=VK/8SHEAWlOuswPmXjJSFpGVBamD4Hr8Hvf2J1ErbToW3QS7B7bedNfOLTEWW9TRvVPzON
	8P1MK8D84+JRcDvOeKqbI5VRXfCk4YUdfFii8FU+WjLSRxE7B5V0UGFPqoKBwVAV4rSntW
	QWZZ6gIxHV0O7Az911usvKRDEIJnw7s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-yWdUMy5iNlSTY0ZsbBmqaQ-1; Sat,
 12 Jul 2025 22:31:18 -0400
X-MC-Unique: yWdUMy5iNlSTY0ZsbBmqaQ-1
X-Mimecast-MFC-AGG-ID: yWdUMy5iNlSTY0ZsbBmqaQ_1752373878
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AB2B180028C;
	Sun, 13 Jul 2025 02:31:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.7])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15C04180045B;
	Sun, 13 Jul 2025 02:31:13 +0000 (UTC)
Date: Sun, 13 Jul 2025 10:31:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2 02/16] ublk: look up ublk task via its pid in timeout
 handler
Message-ID: <aHMabA97fb9dCR6y@fedora>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
 <20250708011746.2193389-3-ming.lei@redhat.com>
 <CADUfDZpvqsQUNrcGefQo+dakaC-aijnXfSYSAPV2sEtoUFfWKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpvqsQUNrcGefQo+dakaC-aijnXfSYSAPV2sEtoUFfWKA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jul 11, 2025 at 09:20:31AM -0400, Caleb Sander Mateos wrote:
> On Mon, Jul 7, 2025 at 9:18 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Look up ublk process via its pid in timeout handler, so we can avoid to
> > touch io->task, because it is fragile to touch task structure.
> >
> > It is fine to kill ublk server process and this way is simpler.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 65daa6ed3a8e..d7b5ee96978a 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1367,14 +1367,19 @@ static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >         struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > -       struct ublk_io *io = &ubq->ios[rq->tag];
> > -
> > -       if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > -               send_sig(SIGKILL, io->task, 0);
> > -               return BLK_EH_DONE;
> > -       }
> > -
> > -       return BLK_EH_RESET_TIMER;
> > +       struct task_struct *p;
> > +       struct pid *pid;
> > +
> > +       if (!(ubq->flags & UBLK_F_UNPRIVILEGED_DEV))
> > +               return BLK_EH_RESET_TIMER;
> > +
> > +       rcu_read_lock();
> > +       pid = find_vpid(ubq->dev->dev_info.ublksrv_pid);
> 
> It looks like ublksrv_pid is set based on whatever the ublk server
> provides in the UBLK_U_CMD_START_DEV/UBLK_U_CMD_END_USER_RECOVERY
> command. I don't see any validation that this is actually the ublk
> server's PID. So couldn't a buggy/malicious ublk server that doesn't
> provide its own PID cause ublk_timeout() to kill some other process
> and leave the ublk I/O pending forever?

Good catch!

Looks we can store the real ublk server pid in ublk_ch_open(), then validate
the passed `ublksrv_pid` in ublk_ctrl_start_dev(), or even always use
the real ublk server pid stored from  ublk_ch_open().

Will do it in next version.


Thanks,
Ming

