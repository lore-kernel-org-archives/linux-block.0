Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804A302CD6
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584784; cv=none; b=TppHCJ2ZD7XB59nASUS1szbM6MqIVe68eWkUmkjHEWE+aPdJRQdFXhiA+4WruOTJJV7gLkeY/lwJeufPhZEzSkae7GKNDUqfc7Mvqs8cOd6QbB4g4oZh5xLWLeLxfd+Zzh/rmKPsCtOTwFnf7ZKXnee2hG3u6UkkEzWoH2lyqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584784; c=relaxed/simple;
	bh=4SFXATvP8kVmlwyyuWuLH9i5BrHBE1bAdUP6sF7i9F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqdkQTnrHN+j5uGIR1iSU7/iN9fLMEgLCsv05O9c53p4+mx6rInrMqjrV9mT3cEj1hJRoLg1mOml010jcdPBjRA9s3aTVCvp2cIJMlFGeCx+Vk/vlB63mBzoRTJDdvdmoZ4pjnw7PauRHgxuNJ41ZUH0ogx+H6B8yTotpt4jQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwZa1g1D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwZa1g1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764584782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2ueVZ+GU+MB9ZiacsNuLayuq7gCIjs8hKLxpvcfhCs=;
	b=YwZa1g1DpXZh1NXJHeCFBdSfKjw0Kv+zzcfFoL4ZQpsxibumuH4z+lNnQsqQnCaJNV3CNG
	UmrLIanXjhmGj/hG9yrN3voPmXGSsphV54G7utJ9AIrYdCQKi7lgA95dinBlbXm8VP9NsV
	D5wtRl/0U8mYgVaUXm8ztNN2mdHG+Ek=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-gBbb01_tNgOkrwdv4MRgHg-1; Mon,
 01 Dec 2025 05:26:18 -0500
X-MC-Unique: gBbb01_tNgOkrwdv4MRgHg-1
X-Mimecast-MFC-AGG-ID: gBbb01_tNgOkrwdv4MRgHg_1764584777
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78C561956088;
	Mon,  1 Dec 2025 10:26:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C05830001A4;
	Mon,  1 Dec 2025 10:26:08 +0000 (UTC)
Date: Mon, 1 Dec 2025 18:25:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 11/27] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
Message-ID: <aS1tLp7tBi8K_NWk@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-12-ming.lei@redhat.com>
 <CADUfDZqtoN=Xv17txG5cZ9foD3ToxgiiW_DSgnABG2ocK7p-UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqtoN=Xv17txG5cZ9foD3ToxgiiW_DSgnABG2ocK7p-UQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Nov 30, 2025 at 08:39:49AM -0800, Caleb Sander Mateos wrote:
> On Thu, Nov 20, 2025 at 5:59 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Handle UBLK_U_IO_COMMIT_IO_CMDS by walking the uring_cmd fixed buffer:
> >
> > - read each element into one temp buffer in batch style
> >
> > - parse and apply each element for committing io result
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 117 ++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/ublk_cmd.h |   8 +++
> >  2 files changed, 121 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 66c77daae955..ea992366af5b 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -2098,9 +2098,9 @@ static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_uring_cmd
> >         return 0;
> >  }
> >
> > -static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> > -                                   struct io_uring_cmd *cmd,
> > -                                   u16 *buf_idx)
> > +static void __ublk_handle_auto_buf_reg(struct ublk_io *io,
> > +                                      struct io_uring_cmd *cmd,
> > +                                      u16 *buf_idx)
> 
> The name could be a bit more descriptive. How about "ublk_clear_auto_buf_reg()"?

Looks fine.

> 
> >  {
> >         if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG) {
> >                 io->flags &= ~UBLK_IO_FLAG_AUTO_BUF_REG;
> > @@ -2118,7 +2118,13 @@ static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> >                 if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
> >                         *buf_idx = io->buf.auto_reg.index;
> >         }
> > +}
> >
> > +static int ublk_handle_auto_buf_reg(struct ublk_io *io,
> > +                                   struct io_uring_cmd *cmd,
> > +                                   u16 *buf_idx)
> > +{
> > +       __ublk_handle_auto_buf_reg(io, cmd, buf_idx);
> >         return ublk_set_auto_buf_reg(io, cmd);
> >  }
> >
> > @@ -2553,6 +2559,17 @@ static inline __u64 ublk_batch_buf_addr(const struct ublk_batch_io *uc,
> >         return 0;
> >  }
> >
> > +static inline __u64 ublk_batch_zone_lba(const struct ublk_batch_io *uc,
> > +                                       const struct ublk_elem_header *elem)
> > +{
> > +       const void *buf = (const void *)elem;
> 
> Unnecessary cast

OK

> 
> > +
> > +       if (uc->flags & UBLK_BATCH_F_HAS_ZONE_LBA)
> > +               return *(__u64 *)(buf + sizeof(*elem) +
> > +                               8 * !!(uc->flags & UBLK_BATCH_F_HAS_BUF_ADDR));
> 
> Cast to a const pointer?

OK, but I feel it isn't necessary.

> 
> 
> > +       return -1;
> > +}
> > +
> >  static struct ublk_auto_buf_reg
> >  ublk_batch_auto_buf_reg(const struct ublk_batch_io *uc,
> >                         const struct ublk_elem_header *elem)
> > @@ -2708,6 +2725,98 @@ static int ublk_handle_batch_prep_cmd(const struct ublk_batch_io_data *data)
> >         return ret;
> >  }
> >
> > +static int ublk_batch_commit_io_check(const struct ublk_queue *ubq,
> > +                                     struct ublk_io *io,
> > +                                     union ublk_io_buf *buf)
> > +{
> > +       struct request *req = io->req;
> > +
> > +       if (!req)
> > +               return -EINVAL;
> 
> This check seems redundant with the UBLK_IO_FLAG_OWNED_BY_SRV check?

I'd keep the check, which has document benefit, or warn_on()?

> 
> > +
> > +       if (io->flags & UBLK_IO_FLAG_ACTIVE)
> > +               return -EBUSY;
> 
> Aren't UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_OWNED_BY_SRV mutually
> exclusive? Then this check is also redundant with the
> UBLK_IO_FLAG_OWNED_BY_SRV check.

OK.

> 
> > +
> > +       if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
> > +               return -EINVAL;
> > +
> > +       if (ublk_need_map_io(ubq)) {
> > +               /*
> > +                * COMMIT_AND_FETCH_REQ has to provide IO buffer if
> > +                * NEED GET DATA is not enabled or it is Read IO.
> > +                */
> > +               if (!buf->addr && (!ublk_need_get_data(ubq) ||
> > +                                       req_op(req) == REQ_OP_READ))
> > +                       return -EINVAL;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int ublk_batch_commit_io(struct ublk_queue *ubq,
> > +                               const struct ublk_batch_io_data *data,
> > +                               const struct ublk_elem_header *elem)
> > +{
> > +       struct ublk_io *io = &ubq->ios[elem->tag];
> > +       const struct ublk_batch_io *uc = &data->header;
> > +       u16 buf_idx = UBLK_INVALID_BUF_IDX;
> > +       union ublk_io_buf buf = { 0 };
> > +       struct request *req = NULL;
> > +       bool auto_reg = false;
> > +       bool compl = false;
> > +       int ret;
> > +
> > +       if (ublk_dev_support_auto_buf_reg(data->ub)) {
> > +               buf.auto_reg = ublk_batch_auto_buf_reg(uc, elem);
> > +               auto_reg = true;
> > +       } else if (ublk_dev_need_map_io(data->ub))
> > +               buf.addr = ublk_batch_buf_addr(uc, elem);
> > +
> > +       ublk_io_lock(io);
> > +       ret = ublk_batch_commit_io_check(ubq, io, &buf);
> > +       if (!ret) {
> > +               io->res = elem->result;
> > +               io->buf = buf;
> > +               req = ublk_fill_io_cmd(io, data->cmd);
> > +
> > +               if (auto_reg)
> > +                       __ublk_handle_auto_buf_reg(io, data->cmd, &buf_idx);
> > +               compl = ublk_need_complete_req(data->ub, io);
> > +       }
> > +       ublk_io_unlock(io);
> > +
> > +       if (unlikely(ret)) {
> > +               pr_warn("%s: dev %u queue %u io %u: commit failure %d\n",
> > +                       __func__, data->ub->dev_info.dev_id, ubq->q_id,
> > +                       elem->tag, ret);
> 
> This warning can be triggered by userspace. It should probably be
> rate-limited or changed to pr_devel().

Looks fine.



Thanks, 
Ming

