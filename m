Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83534431
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888547; cv=none; b=d5lV1kVhC3mDMGMEjVKpMA5aH8wXMPTkX+1Tc8olcw80MT2fw1CwzBFjkrXXyR7jDeku/RQe1kaCWoKiDXFg9aUekwIkrlr9+aqkZVZ+1ZoTxy9+2oAqa5wnN0N5GwkPf0lZHwyXH3cpRpetNtNXMSefVAnOF9IJGk6QJ0qJSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888547; c=relaxed/simple;
	bh=wxP8ZGxzLKvv5y8Y8WT7XgwpE+aaOYH/1gai8YrONq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnHQFv7qfXgZuW/mvLnX8+G7GO24feglajmIbQ2Mj6L6IUpEPNxFDAGd6nEpQO1nPgw/GQ8dOwim6Z/gZ6UcY6Ic1pNdWa6LwzLtJstCZ4FYoHQziLbDYaFsrMSgDa9YSYK9IZZ7n17vPEHdx2VxdAhUwYEt1LFe9XhOXqUF0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEPGGYwI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEPGGYwI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745888544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04+P1JhcEi/JgpKo0ZXzqLSVxHf5qt3INAlj9ukW+VY=;
	b=gEPGGYwIJJ/++V71VVzwFyr5YTSZV/5Tm57ybeNNf0ro8I6gsPyOBO9UyAh11jaPZNUiST
	eZXwSSaKAdqDdnGmdPusxI6E9dpq7xBIcf1VMklb58QT8yZcTZb5WhrQtAW68cKU8DYzrI
	Rns54G04aySQ3GAQ1ktXD26Bp2nYSkA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-v5O2wJ4DNgW5MlMCdlIQ-Q-1; Mon,
 28 Apr 2025 21:02:20 -0400
X-MC-Unique: v5O2wJ4DNgW5MlMCdlIQ-Q-1
X-Mimecast-MFC-AGG-ID: v5O2wJ4DNgW5MlMCdlIQ-Q_1745888539
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9A2E180048E;
	Tue, 29 Apr 2025 01:02:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05B3A1800352;
	Tue, 29 Apr 2025 01:02:15 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:02:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v6.15 3/3] ublk: enhance check for register/unregister io
 buffer command
Message-ID: <aBAlEzqzx2Vmn661@fedora>
References: <20250427134932.1480893-1-ming.lei@redhat.com>
 <20250427134932.1480893-4-ming.lei@redhat.com>
 <CADUfDZrVOUE+Wweaz0pg9qfSB5Ye8FHuf-FmDjO2VOz0GU-cNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrVOUE+Wweaz0pg9qfSB5Ye8FHuf-FmDjO2VOz0GU-cNg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 28, 2025 at 09:28:07AM -0700, Caleb Sander Mateos wrote:
> On Sun, Apr 27, 2025 at 6:50 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > The simple check of UBLK_IO_FLAG_OWNED_BY_SRV can avoid incorrect
> > register/unregister io buffer easily, so check it before calling
> > starting to register/un-register io buffer.
> >
> > Also only allow io buffer register/unregister uring_cmd in case of
> > UBLK_F_SUPPORT_ZERO_COPY.
> >
> > Also mark argument 'ublk_queue *' of ublk_register_io_buf as const.
> >
> > Fixes: 1f6540e2aabb ("ublk: zc register/unregister bvec")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 0a3a3c64316d..c624d8f653ae 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -201,7 +201,7 @@ struct ublk_params_header {
> >  static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> >  static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> > -               struct ublk_queue *ubq, int tag, size_t offset);
> > +               const struct ublk_queue *ubq, int tag, size_t offset);
> >  static inline unsigned int ublk_req_build_flags(struct request *req);
> >  static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
> >                                                    int tag);
> > @@ -1949,13 +1949,20 @@ static void ublk_io_release(void *priv)
> >  }
> >
> >  static int ublk_register_io_buf(struct io_uring_cmd *cmd,
> > -                               struct ublk_queue *ubq, unsigned int tag,
> > +                               const struct ublk_queue *ubq, unsigned int tag,
> >                                 unsigned int index, unsigned int issue_flags)
> >  {
> >         struct ublk_device *ub = cmd->file->private_data;
> > +       const struct ublk_io *io = &ubq->ios[tag];
> >         struct request *req;
> >         int ret;
> >
> > +       if (!ublk_support_zero_copy(ubq))
> > +               return -EINVAL;
> > +
> > +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > +               return -EINVAL;
> 
> I would still prefer to see this common UBLK_IO_FLAG_OWNED_BY_SRV
> check moved to __ublk_ch_uring_cmd() along with the existing flag
> checks. Something like this:

This way mixes bug fix with cleanup.

We are close to v6.15-rc5, and bug fix should keep simple for minimizing
regression.

But it is fine to make it one cleanup aiming at v6.16.


thanks,
Ming

