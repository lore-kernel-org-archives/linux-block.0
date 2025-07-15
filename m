Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DD23D2AC
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594156; cv=none; b=KBGMsk+FDKX+12r0bZz7ADTgDMfPPTltrN9oxe7s+EvoA/CVnNMlQoOzzM/5QDNrOUkbvaJxS6BQ4n6hvXgMll/lsx1682EuDqq9CAOsP308gtd4QmS7h6OM1UPqlyo5s9Yo/vpXzAqvD1cvrLo/VCi3VtXuDPBgkKkpbZET3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594156; c=relaxed/simple;
	bh=CnFrdU/CLd5Uo7IeIOWRjv4AwAG+qbZ6Y6jac5R/jrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgBZwq+IQiQ8uCElX23bnE+aAb50KhZ4POh8MqYm8QN9jbyui5uzyFh8Xg+0RiAbi+y319NfdS/9F/3k5kcc4dZCctSQI+59WHMA7ZWA7y0A2K1/cUdbBGZljBzy2ZHJiD96NRaB4b+W0JB+p2oWa7nPBfbAU5mrAYjthAslmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYI/Muww; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYI/Muww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtMWUluETrhWC9Obzl7SntwBvTLoVcQTwOKn3D5k5Dg=;
	b=JYI/MuwwEn5d8c1Xo/UsnmCU09EAZfORyD+lvQq2zmlWR/25fGq6snsZyhAhVeBnhCHlbU
	sUHLdWZFOucRCBlisGlKezjL4m5HCD/FaP/h8LGh0vtso8MOf/txaG/4jJpQ9GUn+hTYjZ
	m4FADiE9FCxjeJGZ2s7dmMH/E1J2b9U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-joicd0NxMPelSBw4gdvWtA-1; Tue,
 15 Jul 2025 11:42:30 -0400
X-MC-Unique: joicd0NxMPelSBw4gdvWtA-1
X-Mimecast-MFC-AGG-ID: joicd0NxMPelSBw4gdvWtA_1752594149
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC31F1956096;
	Tue, 15 Jul 2025 15:42:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A65A1956096;
	Tue, 15 Jul 2025 15:42:24 +0000 (UTC)
Date: Tue, 15 Jul 2025 23:42:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V3 01/17] ublk: validate ublk server pid
Message-ID: <aHZ22o0znAVFFDJf@fedora>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
 <20250713143415.2857561-2-ming.lei@redhat.com>
 <CADUfDZrZ+SDQFC_-upFJNx2cj=xGuggvHMMubfWCaVGy_D4BjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrZ+SDQFC_-upFJNx2cj=xGuggvHMMubfWCaVGy_D4BjA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Jul 15, 2025 at 10:50:39AM -0400, Caleb Sander Mateos wrote:
> On Sun, Jul 13, 2025 at 10:34 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > ublk server pid(the `tgid` of the process opening the ublk device) is stored
> > in `ublk_device->ublksrv_tgid`. This `tgid` is then checked against the
> > `ublksrv_pid` in `ublk_ctrl_start_dev` and `ublk_ctrl_end_recovery`.
> >
> > This ensures that correct ublk server pid is stored in device info.
> >
> > Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index a1a700c7e67a..2b894de29823 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -237,6 +237,7 @@ struct ublk_device {
> >         unsigned int            nr_privileged_daemon;
> >         struct mutex cancel_mutex;
> >         bool canceling;
> > +       pid_t   ublksrv_tgid;
> >  };
> >
> >  /* header of ublk_params */
> > @@ -1528,6 +1529,7 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> >         if (test_and_set_bit(UB_STATE_OPEN, &ub->state))
> >                 return -EBUSY;
> >         filp->private_data = ub;
> > +       ub->ublksrv_tgid = current->tgid;
> >         return 0;
> >  }
> >
> > @@ -1542,6 +1544,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
> >         ub->mm = NULL;
> >         ub->nr_queues_ready = 0;
> >         ub->nr_privileged_daemon = 0;
> > +       ub->ublksrv_tgid = -1;
> 
> Should this be reset to 0? The next patch checks whether ublksrv_tgid
> is 0 in ublk_timeout().

No, swapper pid is 0.

The check in next patch just tries to double check if ublk char device
is opened.

> Also, the accesses to it should probably be
> using {READ,WRITE}_ONCE() since ublk server open/close can happen
> concurrently with ublk I/O timeout handling.

ublk_abort_queue() is called in ublk_ch_release(), and any inflight request
is either requeued or failed, so ublk I/O timeout handling won't happen
concurrently with ublk char open()/close().


Thanks, 
Ming

