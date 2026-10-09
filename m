Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9A457E45
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553413; cv=none; b=ldhNIYJ5lY8a/Ih92/CvvpvwuRPbSO8yuhr1xzx49R0EXu3g1GbDstJSTdrT0FggYlVknjWhDDjrVPQUn7nC045IPBxJldk5nDkhZyo6dqXWM3LkYTHk0ZlEjJoYYoRX8nPhOjrXhvuLx40tyxanJxY89onIpIwPpbO1O9YQysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553413; c=relaxed/simple;
	bh=ypVmCCMKSAGx4n9ZqsbPFzdOI2ZRgUAGK7idkJ2ZE8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtnVJhNwqaMusydT0zsBdr8ctFG4eaHShVGL8gNW/8d/Krz2K8ua7BKpNRddTpwx0krmCJZLq7J6a4OG//jmYUJRupnimy5zNFRUielcWg+qapkLcZpPGVIyjAm2VDBX4u8L1OSpazQsf5wzOvRckrbeLuMqvCx2TdZ5sKkWkN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhpFhZUg; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhpFhZUg"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6de3360d905so2998465eaf.3
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791553410; x=1792158210; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WB8cPyudhf9LpBI+ZcbVJmxyo6jag82UunLUUKc59QE=;
        b=dhpFhZUgOLEM6VCxu48xp6Oo6JyYtIs3esmODXNW46dQCpQAHc7dyQb1A0oQD1F9YS
         0S7v0ID4bf1zFcyeMNakgMGZi+QuKrTpcgHVakAce/qMnxY92w6008iBo3wXs6+wadhr
         H5PtY35oTVquHk6C+L4I9vAOJIeRj5gBH7xHvPQJGnMkRLhlcrPmmiu6TTah6WZeCxhI
         dlh1bGgQTc65he+k5nO1yv9AY+Y15sysFA7wDE7P1FUEhJTetLwW3gX+pywHPrx4nxMl
         uoE/Y9K7tzHTmpc/YLE12rrA2y1rLhfFr4kO/KN+4xBVUp4an3bazzwGhvaQQ1pp5aBr
         4bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553410; x=1792158210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WB8cPyudhf9LpBI+ZcbVJmxyo6jag82UunLUUKc59QE=;
        b=sFaJdZykAfa5kytGdCQrRg5d2tx1BZoliSG9cnBmTnsGaUX8HOEIvLjE4WrmxdmE2H
         yqm5EKNQC1Hp6oU7p/a54WZsIYY2B+O6O6yGpFDPfwUZcNMma0oicUciaMTSj0m/Hc+l
         NAitpKuJkwmb154HHSkm84ucmk6d2SYMAlf87JupNAY082MUvVrvRkdcHBtnyMaNa0IE
         uVQl4Yx5sm2BOvHjJcrAV//FP7QR+8sIg5Rin/nWlE6F/DiDbt3smXQik1pTXSy/r9Sf
         kmNU5YPQSD2CynJqmrZ0swjDUdIqHmoztxLg+NsiTpU4m7tK+Sq7xK9+RZ6gyciCwN4N
         mICA==
X-Forwarded-Encrypted: i=1; AKwUvBz3Ok3rmCSOqxrx125AqWXn8pDHV+JVGC2/BcIISrTr3B07YGKXZ0boTZwhftQTGAxl4zvFc0JzY9EDFw==@vger.kernel.org
X-Gm-Message-State: AFuF++mGtloIA0+srR0TpqrdYwkwM5cnlgWoXj3XeQFt9njTOIadRTnk
	57hAR0Ge1niMs9++09l7BJinIPtFfg4YLtctSDT1wG+W/jnE+BG06IV1
X-Gm-Gg: AYBFou0Fo+F/cPvy2JqZ4RYqs3mVCa5lmKsOR9qqee5cFWE3cMRLtA6y9+2YJvqNVuY
	nambw7Yr4VFPvLJOa+zVUzh1uWgFPtffEhdKuDfVF0ZYt4Fe2LmXcJRBgwTXHPNjg7hCYWMKM6l
	F5B+kahIQfMKSiAuE99MGmaE8byPNsxqQ86/YXsdYs7xwrobBWTSJRxdNHpdgnqbe8rOvKWTPrZ
	nGQceRh7OWkSUYk0LKRWklGd1UH3ixo2R3QalQ0oEewmiWMfBwavZ6JHUj6sILdLwJWendxJtyN
	o9EakGWIGWsWggVcC+JD85Ue2Y8CtNufwkeg0G48ZK3KWKUqJAvHCGFuvZX0nPea4FAft/E+ou0
	hEv3306mxP9yKlaOrK9F2fm2e0rQ2LjE/BB107unnmN2NK0Z6hPhj5vyk418ucQ5m9R5qBufySF
	dn4kIp61RviolCOL5CEK58zGcaEq6ddU6dYAOAoS+p/SKrbI9e6b9MzqDIl/DMcyMzNvjDd+8DM
	PhBB4IEHT7Hx3WG0h5cvHtN5fHnjruhE13BGkSgiO53vpykY5ckT9hxMRg3LHZpEkicOVyjmneu
	X14=
X-Received: by 2002:a05:6820:200b:b0:6be:5642:7e65 with SMTP id 006d021491bc7-6ef0e6e5aafmr1342990eaf.43.1791553410521;
        Fri, 09 Oct 2026 06:43:30 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef011ecbedsm1602117eaf.8.2026.10.09.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:43:29 -0700 (PDT)
Date: Fri, 9 Oct 2026 08:43:21 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Yoav Cohen <yoav@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, jholzman@nvidia.com, omril@nvidia.com
Subject: Re: [PATCH v2 1/2] ublk: honor rq_affinity on request completion
Message-ID: <asjveZylpV0swnp8@fedora-laptop>
References: <20261006190348.85094-1-yoav@nvidia.com>
 <20261006190348.85094-2-yoav@nvidia.com>
 <CADUfDZrX7v+0-Zxv7AwoJBH-e0ohLcAgm_dvPoDpGv2jZfN2XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrX7v+0-Zxv7AwoJBH-e0ohLcAgm_dvPoDpGv2jZfN2XA@mail.gmail.com>

On Tue, Oct 06, 2026 at 02:53:47PM -0700, Caleb Sander Mateos wrote:
> On Tue, Oct 6, 2026 at 12:04 PM Yoav Cohen <yoav@nvidia.com> wrote:
> >
> > ublk ends successfully completed requests inline on the server thread
> > that issued UBLK_IO_COMMIT_AND_FETCH_REQ, so rq_affinity never
> > redirects completion back to the submitting CPU, unlike NVMe, SCSI,
> > virtio-blk, loop, nbd and rnbd.
> >
> > Route completion through blk_mq_complete_request_remote(), with a new
> > ->complete() callback, ublk_end_rq(). This covers every completion
> > outcome -- reads, writes, flush/discard, errors, and the zero-copy/
> > user-copy/auto-buf-reg/shmem-zc paths that skip the copy-back step --
> > not just the classic-copy-mode successful-read case, since
> > ublk_end_rq() re-derives which of those __ublk_complete_rq() took from
> > @req and @io state rather than assuming one.
> >
> > Gate it behind a new UBLK_F_SUPPORT_RQ_AFFINITY flag that a server
> > must request at ADD_DEV time; servers that don't ask for it keep
> > today's always-local completion unchanged. Add ublk_support_rq_affinity()
> > alongside the existing ublk_support_*() helpers, and check it before
> > calling blk_mq_complete_request_remote() at both call sites.
> >
> > Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> > ---
> >  drivers/block/ublk_drv.c      | 98 +++++++++++++++++++++++++++--------
> >  include/uapi/linux/ublk_cmd.h |  8 +++
> >  2 files changed, 84 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 66eb55e7162e..b94293296b73 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -90,7 +90,8 @@
> >                 | UBLK_F_BATCH_IO \
> >                 | UBLK_F_NO_AUTO_PART_SCAN \
> >                 | UBLK_F_SHMEM_ZC \
> > -               | UBLK_F_IO_DESC_SIZE)
> > +               | UBLK_F_IO_DESC_SIZE \
> > +               | UBLK_F_SUPPORT_RQ_AFFINITY)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > @@ -452,6 +453,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
> >         return ubq->flags & UBLK_F_USER_COPY;
> >  }
> >
> > +static inline bool ublk_support_rq_affinity(const struct ublk_queue *ubq)
> > +{
> > +       return ubq->flags & UBLK_F_SUPPORT_RQ_AFFINITY;
> > +}
> > +
> >  static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
> >  {
> >         return ub->dev_info.flags & UBLK_F_USER_COPY;
> > @@ -1468,6 +1474,14 @@ static inline bool ublk_need_unmap_req(const struct request *req)
> >                (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
> >  }
> >
> > +/* Whether __ublk_complete_rq() takes the copy-back/partial-completion path */
> > +static inline bool ublk_rq_need_unmap(const struct ublk_queue *ubq,
> > +                                     struct request *req)
> > +{
> > +       return ublk_need_map_io(ubq) && ublk_need_unmap_req(req) &&
> > +              !ublk_iod_is_shmem_zc(ubq, req->tag);
> > +}
> > +
> >  static unsigned int ublk_map_io(const struct request *req,
> >                                 const struct ublk_io *io)
> >  {
> > @@ -1549,13 +1563,62 @@ static void ublk_end_request(struct request *req, blk_status_t error)
> >         local_bh_enable();
> >  }
> >
> > +/*
> > + * Update @req with its result and requeue it if it was only partially
> > + * completed. Returns true if @req was requeued, in which case the caller
> > + * must not touch it any further.
> > + *
> > + * Run bio->bi_end_io() with softirqs disabled. If the final fput happens
> > + * off this path, then that will prevent ublk's blkdev_release() from
> > + * being called on current's task work, see fput() implementation.
> > + *
> > + * This matters for the caller completing @req locally on the ublk
> > + * server's own thread: it may already be holding disk->open_mutex, e.g.
> > + * reading the partition table from bdev_open(), and an fput() running
> > + * inline there could deadlock on it. Preferably we would not be doing
> > + * IO with a mutex held that is also used for release, but this
> > + * work-around will suffice for now. A caller reached instead via
> > + * blk_mq_complete_request_remote()'s softirq/IPI redirect never runs on
> > + * that thread, so it isn't exposed to this hazard, but disabling
> > + * softirqs here is harmless for it too.
> > + */
> > +static inline bool ublk_update_and_requeue(struct request *req,
> > +                                          struct ublk_io *io)
> > +{
> > +       bool requeue;
> > +
> > +       local_bh_disable();
> > +       requeue = blk_update_request(req, BLK_STS_OK, io->res);
> > +       local_bh_enable();
> > +       if (requeue)
> > +               blk_mq_requeue_request(req, true);
> > +       return requeue;
> > +}
> > +
> > +static void ublk_end_rq(struct request *req)
> > +{
> > +       struct ublk_queue *ubq = req->mq_hctx->driver_data;
> > +       struct ublk_io *io = &ubq->ios[req->tag];
> > +
> > +       /* matches the two outcomes __ublk_complete_rq() may have redirected */
> > +       if (io->res >= 0 && ublk_rq_need_unmap(ubq, req)) {
> > +               if (!ublk_update_and_requeue(req, io) &&
> > +                   likely(!blk_should_fake_timeout(req->q)))
> > +                       __blk_mq_end_request(req, BLK_STS_OK);
> > +               return;
> > +       }
> > +
> > +       ublk_end_request(req, io->res < 0 ? errno_to_blk_status(io->res) :
> > +                                           BLK_STS_OK);
> > +}
> > +
> >  /* todo: handle partial completion */
> >  static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
> >                                       bool need_map, struct io_comp_batch *iob)
> >  {
> > +       struct ublk_queue *ubq = req->mq_hctx->driver_data;
> 
> mq_hctx->driver_data and ubq->flags are likely to both be cache misses
> on a ublk server thread servicing many queues. req->mq_hctx is
> probably a hit as it's in the same cache line as req->cmd_flags
> accessed just before in ublk_ch_uring_cmd_local() for the req_op(req)
> == REQ_OP_ZONE_APPEND check. It would be nice to avoid these
> additional dereferences, can we prevent queue_rq_affinity_store() from
> setting rq_affinity to a value other than 0 if
> UBLK_F_SUPPORT_RQ_AFFINITY isn't enabled? Perhaps indicated via a new
> BLK_FEAT_SUPPORTS_RQ_AFFINITY flag in struct queue_limits's features
> field?

ubq is only for ublk_support_rq_affinity(ubq), `maybe rq_affinity` can be
passed by __ublk_complete_rq() parameter via
ublk_dev_support_rq_affinity(ub).

BTW, the one for ublk_iod_is_shmem_zc() can't be avoided.


Thanks,
Ming
