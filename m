Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C092749F1
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761277794; cv=none; b=RghfVBMJfHdTsM0ImmOhqPYiGfcpQoi/xlTpqzsaoEgD4K9GYcVvyE++vb1sglu7gn8dAsKRhTqf3dSdF3fVYbyFJdPULws6El+VKgCuq5p2l40hliXv8RvCAhaQvI2DTx2lunCiED0vR08uLCWdGI4zmWgAC563byVOGNKBDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761277794; c=relaxed/simple;
	bh=qmaB1CXtUY1e+C/t58DgmOYZlR8DAdBz6UTk8GaUBVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XK9yxHeCqmfBSbBxLPn3QJDDE9hbI4HPBhiOJtJQ9V+H/zQgQBNgf/4yvvxq7c0nEU7TlQFLWLRg6vGUpskhBLN6lkrHIUFwS652P+6S6pHrp/7IkEkrFPefkywZGDoi4YiIq80wLSKG+fXTfbiEOP/DuFwNHaaNKQcmXbkdQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IA6iWw6y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IA6iWw6y"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26816246a0aso2210485ad.2
        for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761277792; x=1761882592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvoYolrDujURIIQNBp29WK1/vhNin2pPqJIBDrWNzE4=;
        b=IA6iWw6yVIbRiWEyNoiqiwosgLZ/KcAJtTQvoa+GTfyECyAZA2wF9FPTt66NyPMdEw
         QMqrT9zbQbFt1kKO4MW69O+AwuXp8d3lDCbz1HVqLa5Pp3Dm+jun9AK4g60iUm8hZlik
         KbIaiPuKp6aCFfLZ1GKBuw8gnGdp5BdpEBhrncin9Pj1AfijMkUnbM/Qmx0xUTeq7qMo
         Ul5zBINgV/n0pm9YtyCsxjqb9HwHy2NR9e0oA8WqpFSU4dexTIzk949K5GlGboqHEZ50
         WVZc/UU6VjgdMJfmXb3KfH11N0kzEN1ITmTluW1NJDTOhCfJx3Cdn6ZUrOGp2gy+tqCH
         Ptag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761277792; x=1761882592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvoYolrDujURIIQNBp29WK1/vhNin2pPqJIBDrWNzE4=;
        b=tANBuqGWC7mKy8BdaiP52pxf9+pAoBDPfmekQNJSWn7+CMmy3TQyaj97cVnaiDREOK
         50l/D2Dkuh1Gx2VMzAVtTO74whVZq3QCMEK1W0LceCEGieFZuh9yoxRkYf21qSeZ68RH
         1bxzQ8OquYEtP8hM63W1lZI3QY4C/4NC8379ZBzaCx4PCFOAdm5IT/63HmC4flVSxZRn
         tJ7VK0Jqo4f9QsO4X+hRygIO4UGKqVgo6VRIOzuwiWZQPgZZ8Wt/WGhE3dBYDukvafTG
         fFJFUhb6ebByQB+BcgBqv1vH/dNGJGnC5gxzPEcc7MBLcATxQK19jqE6qnNX+UnQQRn9
         v7GA==
X-Forwarded-Encrypted: i=1; AJvYcCWIhPzvd4TA/bQlkqqEfHrYUMLErHmgSaX1/2xUW81G4naRS1pUUO7k+O1xmazvdMF1KrTBMKHWm3Tpuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4D1qUtFeVhngaxYbeqF/+CwspY3exa4zb1bTP0dYz6dT+Esw
	f9o/EeawVvzAlcSFhUSNj93WQu+YnQqQCvDryteXF2ZdeF9TWKwOpa4sA6tKNcvD1Pc5GID5K8i
	2sBCVaKJftFB5Jej0tmuxX501O+rt0LaGRk1Gry9JAA==
X-Gm-Gg: ASbGncth/Vp/c5tmnqTr8lioxQsWGAOJR8Ri04luX1fxzCRusHoontuzleLf1jBCcIP
	urPx96P5z2JJvRHBA8Jk2hBaHvt4gdRNfNpUhP/W06O8LmalTAAhXE/Jx3C8F6UK7as04K5CtXp
	jcqAW58tNo6kbl8PFKJ+e1SVmM9i67cu9J0YNfY024xGlyxkMD3SuaMnh7IoauMcHoQ1MgG6ZtR
	tOHZsX86XYxz1bXvYYNFP9vJChh1l6TsCCOXgD6WaUktH7o5oaApwijQyozdJusZOz5VAjodLtl
	Fmi7o+QGVVqUEsqtzRASSd/z4wRW
X-Google-Smtp-Source: AGHT+IGVLYN9Qj6K5Oe/DW7c2O9tXpDx7qrMeaGk8fBmXzVZ28GOkgKOMdnoBQ6ElA4mEZO6qJsf1CoAlmZoTYuCH80=
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id
 d9443c01a7336-292d3fb7f47mr85578795ad.7.1761277792499; Thu, 23 Oct 2025
 20:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-4-csander@purestorage.com> <aPr1i-k0byzYjv8G@fedora>
In-Reply-To: <aPr1i-k0byzYjv8G@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Oct 2025 20:49:40 -0700
X-Gm-Features: AS18NWDTISZzm2iqXdmRxUGBIwGGbwvM87S0nOqV0xhWOuEGVlx6sx6Z4Yq4U7g
Message-ID: <CADUfDZp21icTKrWHcgRTfmsxtdab85b6R75wAYXW2dA+dzXmoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 8:42=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Oct 23, 2025 at 02:18:30PM -0600, Caleb Sander Mateos wrote:
> > io_uring task work dispatch makes an indirect call to struct io_kiocb's
> > io_task_work.func field to allow running arbitrary task work functions.
> > In the uring_cmd case, this calls io_uring_cmd_work(), which immediatel=
y
> > makes another indirect call to struct io_uring_cmd's task_work_cb field=
.
> > Define the uring_cmd task work callbacks as functions whose signatures
> > match io_req_tw_func_t. Define a IO_URING_CMD_TASK_WORK_ISSUE_FLAGS
> > constant in io_uring/cmd.h to avoid manufacturing issue_flags in the
> > uring_cmd task work callbacks. Now uring_cmd task work dispatch makes a
> > single indirect call to the uring_cmd implementation's callback. This
> > also allows removing the task_work_cb field from struct io_uring_cmd,
> > freeing up some additional storage space.
>
> The idea looks good.
>
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  block/ioctl.c                |  4 +++-
> >  drivers/block/ublk_drv.c     | 15 +++++++++------
> >  drivers/nvme/host/ioctl.c    |  5 +++--
> >  fs/btrfs/ioctl.c             |  4 +++-
> >  fs/fuse/dev_uring.c          |  5 +++--
> >  include/linux/io_uring/cmd.h | 16 +++++++---------
> >  io_uring/uring_cmd.c         | 13 ++-----------
> >  7 files changed, 30 insertions(+), 32 deletions(-)
> >
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index d7489a56b33c..5c10d48fab27 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -767,13 +767,15 @@ long compat_blkdev_ioctl(struct file *file, unsig=
ned cmd, unsigned long arg)
> >  struct blk_iou_cmd {
> >       int res;
> >       bool nowait;
> >  };
> >
> > -static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int is=
sue_flags)
> > +static void blk_cmd_complete(struct io_kiocb *req, io_tw_token_t tw)
> >  {
> > +     struct io_uring_cmd *cmd =3D io_kiocb_to_cmd(req, struct io_uring=
_cmd);
> >       struct blk_iou_cmd *bic =3D io_uring_cmd_to_pdu(cmd, struct blk_i=
ou_cmd);
> > +     unsigned int issue_flags =3D IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
>
> Now `io_kiocb` is exposed to driver, it could be perfect if 'io_uring_cmd=
'
> is kept in kernel API interface, IMO.

You mean change the io_req_tw_func_t signature to pass struct
io_uring_cmd * instead of struct io_kiocb *? I don't think that would
make sense because task work is a more general concept, not just for
uring_cmd. I agree it's a bit ugly exposing struct io_kiocb * outside
of the io_uring core, but I don't see a way to encapsulate it without
other downsides (the additional indirect call or the gross macro from
v1). Treating it as an opaque pointer type seems like the least bad
option...

>
> ...
>
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index b84b97c21b43..3efad93404f9 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -9,18 +9,13 @@
> >  /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
> >  #define IORING_URING_CMD_CANCELABLE  (1U << 30)
> >  /* io_uring_cmd is being issued again */
> >  #define IORING_URING_CMD_REISSUE     (1U << 31)
> >
> > -typedef void (*io_uring_cmd_tw_t)(struct io_uring_cmd *cmd,
> > -                               unsigned issue_flags);
> > -
> >  struct io_uring_cmd {
> >       struct file     *file;
> >       const struct io_uring_sqe *sqe;
> > -     /* callback to defer completions to task context */
> > -     io_uring_cmd_tw_t task_work_cb;
> >       u32             cmd_op;
> >       u32             flags;
> >       u8              pdu[32]; /* available inline for free use */
>
> pdu[40]

I considered that, but wondered if we might want to reuse the 8 bytes
for something internal to uring_cmd rather than providing it to the
driver's uring_cmd implementation. If we increase pdu and a driver
starts using more than 32 bytes, it will be difficult to claw back. It
seems reasonable to reserve half the space for the io_uring/uring_cmd
layer and half for the driver.

Best,
Caleb

>
>
>
> Thanks,
> Ming
>
