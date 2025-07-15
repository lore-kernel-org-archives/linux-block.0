Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39684039
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619185; cv=none; b=Wqane3doJ4/jRTZ1hziLuGPnBp3cNmxE90InL+ocjzFTr2Ydsi8ts+I9M18MOPL1UBbuKpCrMwaqtiTw30q9fw50bVJkKv6CdExG+Kk0dq5LlEreIyw9/2b7Kli4eXUAKpyaridvB4or6K9LDUyrmxk1EJR6xUh6bfjAMetrtY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619185; c=relaxed/simple;
	bh=ZpNH1jnCeB5PPJsnkQyUSzSKCbgUTqy1xjJEBocq5zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X57vvBqxV5fsY97WbBESFFjRR/hpXyUOd3V8/Fw/fNp+3az/R7e7UR0VrqXnXIFMX0w6q6ouhBO4lNQbZnsV56J8pqErvHov/JMgBtOdTYIMd0lPAGHN4aG0EGRXK31Jc440Lxts8P33q1I0wtiPn/JIuNHVBXMWni3hymf+F2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDBOuNKx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDBOuNKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752619181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/66JEk3x6PmRxLdAnC7OG5cC1QUqF6YwVGJTe2MFkpU=;
	b=iDBOuNKxFzQq/M5FCXq+bBnKNHpYOLLq8pFUk52Xu6Lai2Czr42yxTVYn9Kx5ibML+Vf4o
	NVoNHB/l1kN7wZ5oyN20+gdp7MDaOafNoqbs5KLDW8qPL7anpMmr2lHKQ+pcETJ/kkXfQ/
	UREvYxLoAnsK541WyhlEUv3n8N/OiuY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-8bhaPhJWOmeeuLvE3WB5qA-1; Tue,
 15 Jul 2025 18:39:40 -0400
X-MC-Unique: 8bhaPhJWOmeeuLvE3WB5qA-1
X-Mimecast-MFC-AGG-ID: 8bhaPhJWOmeeuLvE3WB5qA_1752619179
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 060481800289;
	Tue, 15 Jul 2025 22:39:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 852D019560A7;
	Tue, 15 Jul 2025 22:39:35 +0000 (UTC)
Date: Wed, 16 Jul 2025 06:39:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V3 01/17] ublk: validate ublk server pid
Message-ID: <aHbYosQjY2cxkH2b@fedora>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
 <20250713143415.2857561-2-ming.lei@redhat.com>
 <CADUfDZrZ+SDQFC_-upFJNx2cj=xGuggvHMMubfWCaVGy_D4BjA@mail.gmail.com>
 <aHZ22o0znAVFFDJf@fedora>
 <CADUfDZq86kMtc=OLCK6jUNwgRf6+VTmVqzHXqyD+5zK0FEqfSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq86kMtc=OLCK6jUNwgRf6+VTmVqzHXqyD+5zK0FEqfSw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Jul 15, 2025 at 11:48:12AM -0400, Caleb Sander Mateos wrote:
> On Tue, Jul 15, 2025 at 11:42 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 10:50:39AM -0400, Caleb Sander Mateos wrote:
> > > On Sun, Jul 13, 2025 at 10:34 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > ublk server pid(the `tgid` of the process opening the ublk device) is stored
> > > > in `ublk_device->ublksrv_tgid`. This `tgid` is then checked against the
> > > > `ublksrv_pid` in `ublk_ctrl_start_dev` and `ublk_ctrl_end_recovery`.
> > > >
> > > > This ensures that correct ublk server pid is stored in device info.
> > > >
> > > > Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index a1a700c7e67a..2b894de29823 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -237,6 +237,7 @@ struct ublk_device {
> > > >         unsigned int            nr_privileged_daemon;
> > > >         struct mutex cancel_mutex;
> > > >         bool canceling;
> > > > +       pid_t   ublksrv_tgid;
> > > >  };
> > > >
> > > >  /* header of ublk_params */
> > > > @@ -1528,6 +1529,7 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> > > >         if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
> > > >                 return -EBUSY;
> > > >         filp->private_data = ub;
> > > > +       ub->ublksrv_tgid = current->tgid;
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -1542,6 +1544,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
> > > >         ub->mm = NULL;
> > > >         ub->nr_queues_ready = 0;
> > > >         ub->nr_privileged_daemon = 0;
> > > > +       ub->ublksrv_tgid = -1;
> > >
> > > Should this be reset to 0? The next patch checks whether ublksrv_tgid
> > > is 0 in ublk_timeout().
> >
> > No, swapper pid is 0.
> >
> > The check in next patch just tries to double check if ublk char device
> > is opened.
> >
> > > Also, the accesses to it should probably be
> > > using {READ,WRITE}_ONCE() since ublk server open/close can happen
> > > concurrently with ublk I/O timeout handling.
> >
> > ublk_abort_queue() is called in ublk_ch_release(), and any inflight request
> > is either requeued or failed, so ublk I/O timeout handling won't happen
> > concurrently with ublk char open()/close().
> 
> Thanks for explaining. If the ublk server closing the char device
> ensures there are no in-flight requests, does that make the
> ublksrv_tgid check in ublk_timeout() unnecessary?

Yes, the check should have been WARN_ON_ONCE().

Thanks,
Ming

