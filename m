Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A106EF9D9
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556346; cv=none; b=H8hvD1kN3t8zovfisXadW3XkTQtYZn4SF4o0S83i3hESf96e5mBy2N7Uiv0VnTPqKSTvhIG2zyYYaUxmMAxnrAm9GDBN6iTHE4IIXo7F94g/XCoXVscBaqBduxv7ZjPtTkNcY2IweM6lPb0ZfejIbekyqQBUDsZ6ATdi3B0vFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556346; c=relaxed/simple;
	bh=Qn1/tFfe/nKDcFVWjQu85BaOPphZtSYVLKVIz7/n97E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCacWg5jdouFlLSD3USYool36m+xhOVgbEezLOBuNtpm11I4c7YNlAlp8GHcEtEbxs76oC3woxt6zNMz6I5DVkHwtyC+X80zDZhix9vTdSdor8oZGjue4URtzm1R6G+Dq0+yAWRqArL7Fy+yw99yxPUXJ8/Dg0gsmbS0aQ3Vspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7jLTaZM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7jLTaZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764556343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsy47gOVXF295PDw6td5A7WFjcIylY5ZmKRFoRC/Kq8=;
	b=T7jLTaZMySUtiQKMl6tSD3G3/SD4wB9YZDJbceyxHfWtj8d7KxsDhRXv605nrxlIo8jqQq
	7USlrP2cHnTKUzzcYA/P7cxZYtb1UbjQcvUwWtLgVcppVIhlIHmzL34J74HvbnlV65+ZWb
	snT7Jy+D5ZvCuudkMutyEJZygOwCggE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-lxj42qQ_O1GNqzmzzGvJ-A-1; Sun,
 30 Nov 2025 21:32:19 -0500
X-MC-Unique: lxj42qQ_O1GNqzmzzGvJ-A-1
X-Mimecast-MFC-AGG-ID: lxj42qQ_O1GNqzmzzGvJ-A_1764556338
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29A311800350;
	Mon,  1 Dec 2025 02:32:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAE241800451;
	Mon,  1 Dec 2025 02:32:12 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:32:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 13/27] ublk: add batch I/O dispatch infrastructure
Message-ID: <aSz-J4BhqwrkmGgs@fedora>
References: <20251121015851.3672073-1-ming.lei@redhat.com>
 <20251121015851.3672073-14-ming.lei@redhat.com>
 <CADUfDZrsH_Bhhs_r0YqEU=3i6DcQCWVt-aEmbu1ouzX=e3WqYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZrsH_Bhhs_r0YqEU=3i6DcQCWVt-aEmbu1ouzX=e3WqYg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sun, Nov 30, 2025 at 11:24:12AM -0800, Caleb Sander Mateos wrote:
> On Thu, Nov 20, 2025 at 6:00 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add infrastructure for delivering I/O commands to ublk server in batches,
> > preparing for the upcoming UBLK_U_IO_FETCH_IO_CMDS feature.
> >
> > Key components:
> >
> > - struct ublk_batch_fcmd: Represents a batch fetch uring_cmd that will
> >   receive multiple I/O tags in a single operation, using io_uring's
> >   multishot command for efficient ublk IO delivery.
> >
> > - ublk_batch_dispatch(): Batch version of ublk_dispatch_req() that:
> >   * Pulls multiple request tags from the events FIFO (lock-free reader)
> >   * Prepares each I/O for delivery (including auto buffer registration)
> >   * Delivers tags to userspace via single uring_cmd notification
> >   * Handles partial failures by restoring undelivered tags to FIFO
> >
> > The batch approach significantly reduces notification overhead by aggregating
> > multiple I/O completions into single uring_cmd, while maintaining the same
> > I/O processing semantics as individual operations.
> >
> > Error handling ensures system consistency: if buffer selection or CQE
> > posting fails, undelivered tags are restored to the FIFO for retry,
> > meantime IO state has to be restored.
> >
> > This runs in task work context, scheduled via io_uring_cmd_complete_in_task()
> > or called directly from ->uring_cmd(), enabling efficient batch processing
> > without blocking the I/O submission path.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 189 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 189 insertions(+)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 6ff284243630..cc9c92d97349 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -91,6 +91,12 @@
> >          UBLK_BATCH_F_HAS_BUF_ADDR | \
> >          UBLK_BATCH_F_AUTO_BUF_REG_FALLBACK)
> >
> > +/* ublk batch fetch uring_cmd */
> > +struct ublk_batch_fcmd {
> 
> I would prefer "fetch_cmd" instead of "fcmd" for clarity
> 
> > +       struct io_uring_cmd *cmd;
> > +       unsigned short buf_group;
> > +};
> > +
> >  struct ublk_uring_cmd_pdu {
> >         /*
> >          * Store requests in same batch temporarily for queuing them to
> > @@ -168,6 +174,9 @@ struct ublk_batch_io_data {
> >   */
> >  #define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
> >
> > +/* used for UBLK_F_BATCH_IO only */
> > +#define UBLK_BATCH_IO_UNUSED_TAG       ((unsigned short)-1)
> > +
> >  union ublk_io_buf {
> >         __u64   addr;
> >         struct ublk_auto_buf_reg auto_reg;
> > @@ -616,6 +625,32 @@ static wait_queue_head_t ublk_idr_wq;      /* wait until one idr is freed */
> >  static DEFINE_MUTEX(ublk_ctl_mutex);
> >
> >
> > +static void ublk_batch_deinit_fetch_buf(const struct ublk_batch_io_data *data,
> > +                                       struct ublk_batch_fcmd *fcmd,
> > +                                       int res)
> > +{
> > +       io_uring_cmd_done(fcmd->cmd, res, data->issue_flags);
> > +       fcmd->cmd = NULL;
> > +}
> > +
> > +static int ublk_batch_fetch_post_cqe(struct ublk_batch_fcmd *fcmd,
> > +                                    struct io_br_sel *sel,
> > +                                    unsigned int issue_flags)
> > +{
> > +       if (io_uring_mshot_cmd_post_cqe(fcmd->cmd, sel, issue_flags))
> > +               return -ENOBUFS;
> > +       return 0;
> > +}
> > +
> > +static ssize_t ublk_batch_copy_io_tags(struct ublk_batch_fcmd *fcmd,
> > +                                      void __user *buf, const u16 *tag_buf,
> > +                                      unsigned int len)
> > +{
> > +       if (copy_to_user(buf, tag_buf, len))
> > +               return -EFAULT;
> > +       return len;
> > +}
> > +
> >  #define UBLK_MAX_UBLKS UBLK_MINORS
> >
> >  /*
> > @@ -1378,6 +1413,160 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
> >         }
> >  }
> >
> > +static bool __ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> > +                                      const struct ublk_batch_io_data *data,
> > +                                      unsigned short tag)
> > +{
> > +       struct ublk_device *ub = data->ub;
> > +       struct ublk_io *io = &ubq->ios[tag];
> > +       struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
> > +       enum auto_buf_reg_res res = AUTO_BUF_REG_FALLBACK;
> > +       struct io_uring_cmd *cmd = data->cmd;
> > +
> > +       if (!ublk_start_io(ubq, req, io))
> 
> This doesn't look correct for UBLK_F_NEED_GET_DATA. If that's not
> supported in batch mode, then it should probably be disallowed when
> creating a batch-mode ublk device. The ublk_need_get_data() check in
> ublk_batch_commit_io_check() could also be dropped.

OK.

BTW UBLK_F_NEED_GET_DATA isn't necessary any more since user copy.

It is only for handling WRITE io command, and ublk server can copy data to
new buffer by user copy.

> 
> > +               return false;
> > +
> > +       if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
> > +               res = __ublk_do_auto_buf_reg(ubq, req, io, cmd,
> > +                               data->issue_flags);
> 
> __ublk_do_auto_buf_reg() reads io->buf.auto_reg. That seems racy
> without holding the io spinlock.

The io lock isn't needed.  Now the io state is guaranteed to be ACTIVE,
so UBLK_U_IO_COMMIT_IO_CMDS can't commit anything for this io.

> 
> > +
> > +       if (res == AUTO_BUF_REG_FAIL)
> > +               return false;
> 
> Could be moved into the if (ublk_support_auto_buf_reg(ubq) &&
> ublk_rq_has_data(req)) statement since it won't be true otherwise?

OK.

> 
> > +
> > +       ublk_io_lock(io);
> > +       ublk_prep_auto_buf_reg_io(ubq, req, io, cmd, res);
> > +       ublk_io_unlock(io);
> > +
> > +       return true;
> > +}
> > +
> > +static bool ublk_batch_prep_dispatch(struct ublk_queue *ubq,
> > +                                    const struct ublk_batch_io_data *data,
> > +                                    unsigned short *tag_buf,
> > +                                    unsigned int len)
> > +{
> > +       bool has_unused = false;
> > +       int i;
> 
> unsigned?
> 
> > +
> > +       for (i = 0; i < len; i += 1) {
> 
> i++?
> 
> > +               unsigned short tag = tag_buf[i];
> > +
> > +               if (!__ublk_batch_prep_dispatch(ubq, data, tag)) {
> > +                       tag_buf[i] = UBLK_BATCH_IO_UNUSED_TAG;
> > +                       has_unused = true;
> > +               }
> > +       }
> > +
> > +       return has_unused;
> > +}
> > +
> > +/*
> > + * Filter out UBLK_BATCH_IO_UNUSED_TAG entries from tag_buf.
> > + * Returns the new length after filtering.
> > + */
> > +static unsigned int ublk_filter_unused_tags(unsigned short *tag_buf,
> > +                                           unsigned int len)
> > +{
> > +       unsigned int i, j;
> > +
> > +       for (i = 0, j = 0; i < len; i++) {
> > +               if (tag_buf[i] != UBLK_BATCH_IO_UNUSED_TAG) {
> > +                       if (i != j)
> > +                               tag_buf[j] = tag_buf[i];
> > +                       j++;
> > +               }
> > +       }
> > +
> > +       return j;
> > +}
> > +
> > +#define MAX_NR_TAG 128
> > +static int __ublk_batch_dispatch(struct ublk_queue *ubq,
> > +                                const struct ublk_batch_io_data *data,
> > +                                struct ublk_batch_fcmd *fcmd)
> > +{
> > +       unsigned short tag_buf[MAX_NR_TAG];
> > +       struct io_br_sel sel;
> > +       size_t len = 0;
> > +       bool needs_filter;
> > +       int ret;
> > +
> > +       sel = io_uring_cmd_buffer_select(fcmd->cmd, fcmd->buf_group, &len,
> > +                                        data->issue_flags);
> > +       if (sel.val < 0)
> > +               return sel.val;
> > +       if (!sel.addr)
> > +               return -ENOBUFS;
> > +
> > +       /* single reader needn't lock and sizeof(kfifo element) is 2 bytes */
> > +       len = min(len, sizeof(tag_buf)) / 2;
> 
> sizeof(unsigned short) instead of 2?

OK

> 
> > +       len = kfifo_out(&ubq->evts_fifo, tag_buf, len);
> > +
> > +       needs_filter = ublk_batch_prep_dispatch(ubq, data, tag_buf, len);
> > +       /* Filter out unused tags before posting to userspace */
> > +       if (unlikely(needs_filter)) {
> > +               int new_len = ublk_filter_unused_tags(tag_buf, len);
> > +
> > +               if (!new_len)
> > +                       return len;
> 
> Is the purpose of this return value just to make ublk_batch_dispatch()
> retry __ublk_batch_dispatch()? Otherwise, it seems like a strange
> value to return.

If `new_len` becomes zero, it means all these requests are handled already,
either fail or requeue, so return `len` to tell the caller to move on. I
can comment this behavior.

> 
> Also, shouldn't this path release the selected buffer to avoid leaking it?

Good catch, but io_kbuf_recycle() isn't exported, we may have to call
io_uring_mshot_cmd_post_cqe() by zeroing sel->val.

> 
> > +               len = new_len;
> > +       }
> > +
> > +       sel.val = ublk_batch_copy_io_tags(fcmd, sel.addr, tag_buf, len * 2);
> 
> sizeof(unsigned short)?

OK

> 
> > +       ret = ublk_batch_fetch_post_cqe(fcmd, &sel, data->issue_flags);
> > +       if (unlikely(ret < 0)) {
> > +               int i, res;
> > +
> > +               /*
> > +                * Undo prep state for all IOs since userspace never received them.
> > +                * This restores IOs to pre-prepared state so they can be cleanly
> > +                * re-prepared when tags are pulled from FIFO again.
> > +                */
> > +               for (i = 0; i < len; i++) {
> > +                       struct ublk_io *io = &ubq->ios[tag_buf[i]];
> > +                       int index = -1;
> > +
> > +                       ublk_io_lock(io);
> > +                       if (io->flags & UBLK_IO_FLAG_AUTO_BUF_REG)
> > +                               index = io->buf.auto_reg.index;
> 
> This is missing the io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd)
> check from ublk_handle_auto_buf_reg().

As you replied, it isn't needed because it is the same multishot command
for registering bvec buf.

> 
> > +                       io->flags &= ~(UBLK_IO_FLAG_OWNED_BY_SRV | UBLK_IO_FLAG_AUTO_BUF_REG);
> > +                       io->flags |= UBLK_IO_FLAG_ACTIVE;
> > +                       ublk_io_unlock(io);
> > +
> > +                       if (index != -1)
> > +                               io_buffer_unregister_bvec(data->cmd, index,
> > +                                               data->issue_flags);
> > +               }
> > +
> > +               res = kfifo_in_spinlocked_noirqsave(&ubq->evts_fifo,
> > +                       tag_buf, len, &ubq->evts_lock);
> > +
> > +               pr_warn("%s: copy tags or post CQE failure, move back "
> > +                               "tags(%d %zu) ret %d\n", __func__, res, len,
> > +                               ret);
> > +       }
> > +       return ret;
> > +}
> > +
> > +static __maybe_unused int
> 
> The return value looks completely unused. Just return void instead?

Yes, looks it is removed in following patch.


Thanks,
Ming

