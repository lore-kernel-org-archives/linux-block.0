Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC011D2F59
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990356; cv=none; b=CoudKT1m8TfkOJyadI8lbRspiHX7oWCT4o/itpx8vgpMsi9SuVCRInOnSewoxqsFStYSg023zq32q7+mEWkki0Wc7vdCYe/e9y9hAPLwvw2IstsFCpqn3hDqyoOE4uA+gQ6JFQKOCMRmr4zanSn9wRzBGtTMNs1ybS3gDlWGMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990356; c=relaxed/simple;
	bh=U00EW894ngRqBGywaGurd+gTIctyjO96dNEDmp/fKKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqucbx+A29uWuKMn40yYwHk6joKSA/i31A4eiHccro3leNOOTbVcTczqm/aL9bo/bBsPccZ8aUAIgBOwNV4q1NHZ9VE+l3nG6gKo5+KqjouK3iH3NJ5EzbXkrQSvI87OGIjnS/eDppgwEcWXYqErZzNIeGAZH8TdRP11XG4nZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwGxXG/n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwGxXG/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728990353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aBy4dXPWpCDXg2gtGeZoHHZwRgQaIs97cDX25wcUK8w=;
	b=NwGxXG/nbUqBLw5E80Pg5aZIxxKE4nBSrUdBjck9B+LZEpR/Dl6YVlfy+YWH06O3veEv1v
	9DwEunESbBHhIrughIbhuOLMNtLUCY4vHzNWS77J8c0uxnmY1OwvMsQBijKSdoW2kxa/25
	rHX/UXXWDGd2evPkayaom58StQfsuPo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-2TE_fIyROXGtuzTKah87Kw-1; Tue,
 15 Oct 2024 07:05:52 -0400
X-MC-Unique: 2TE_fIyROXGtuzTKah87Kw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02C2219560A2;
	Tue, 15 Oct 2024 11:05:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.121])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 853BC19560AE;
	Tue, 15 Oct 2024 11:05:41 +0000 (UTC)
Date: Tue, 15 Oct 2024 19:05:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH V6 7/8] io_uring/uring_cmd: support provide group kernel
 buffer
Message-ID: <Zw5Mf3pe06UOYLFW@fedora>
References: <4b40eff1-a848-4742-9cb3-541bf8ed606e@gmail.com>
 <655b3348-27a1-4bc7-ade7-4d958a692d0b@kernel.dk>
 <ZwiN0Ioy2Y7cfnTI@fedora>
 <44028492-3681-4cd4-8ae2-ef7139ad50ad@kernel.dk>
 <ZwiWdO6SS_jlkYrM@fedora>
 <051e74c9-c5b4-40d7-9024-b4bd3f5d0a0f@kernel.dk>
 <Zwk0SQBiTUBLNvj0@fedora>
 <a7eefe36-55fd-48f7-b05b-afed16a32d0c@kernel.dk>
 <ZwlIEiWpTMMh-NTL@fedora>
 <221eb1e4-a631-451e-be84-9012d40186c9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221eb1e4-a631-451e-be84-9012d40186c9@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Oct 14, 2024 at 07:40:40PM +0100, Pavel Begunkov wrote:
> On 10/11/24 16:45, Ming Lei wrote:
> > On Fri, Oct 11, 2024 at 08:41:03AM -0600, Jens Axboe wrote:
> > > On 10/11/24 8:20 AM, Ming Lei wrote:
> > > > On Fri, Oct 11, 2024 at 07:24:27AM -0600, Jens Axboe wrote:
> > > > > On 10/10/24 9:07 PM, Ming Lei wrote:
> > > > > > On Thu, Oct 10, 2024 at 08:39:12PM -0600, Jens Axboe wrote:
> > > > > > > On 10/10/24 8:30 PM, Ming Lei wrote:
> > > > > > > > Hi Jens,
> ...
> > > > > > Suppose we have N consumers OPs which depends on OP_BUF_UPDATE.
> > > > > > 
> > > > > > 1) all N OPs are linked with OP_BUF_UPDATE
> > > > > > 
> > > > > > Or
> > > > > > 
> > > > > > 2) submit OP_BUF_UPDATE first, and wait its completion, then submit N
> > > > > > OPs concurrently.
> > > > > 
> > > > > Correct
> > > > > 
> > > > > > But 1) and 2) may slow the IO handing.  In 1) all N OPs are serialized,
> > > > > > and 1 extra syscall is introduced in 2).
> > > > > 
> > > > > Yes you don't want do do #1. But the OP_BUF_UPDATE is cheap enough that
> > > > > you can just do it upfront. It's not ideal in terms of usage, and I get
> > > > > where the grouping comes from. But is it possible to do the grouping in
> > > > > a less intrusive fashion with OP_BUF_UPDATE? Because it won't change any
> > > > 
> > > > The most of 'intrusive' change is just on patch 4, and Pavel has commented
> > > > that it is good enough:
> > > > 
> > > > https://lore.kernel.org/linux-block/ZwZzsPcXyazyeZnu@fedora/T/#m551e94f080b80ccbd2561e01da5ea8e17f7ee15d
> 
> Trying to catch up on the thread. I do think the patch is tolerable and
> mergeable, but I do it adds quite a bit of complication to the path if
> you try to have a map in what state a request can be and what

I admit that sqe group adds a little complexity to the submission &
completion code, especially dealing with completion code.

But with your help, patch 4 has become easy to follow and sqe group
is well-defined now, and it does add new feature of N:M dependency,
otherwise one extra syscall is required for supporting N:M dependency,
this way not only saves one syscall, but also simplify application.

> dependencies are there, and then patches after has to go to every each
> io_uring opcode and add support for leased buffers. And I'm afraid

Only fast IO(net, fs) needs it, not see other OPs for such support.

> that we'll also need to feedback from completion of those to let
> the buffer know what ranges now has data / initialised. One typical
> problem for page flipping rx, for example, is that you need to have
> a full page of data to map it, otherwise it should be prezeroed,
> which is too expensive, same problem you can have without mmap'ing
> and directly exposing pages to the user.

From current design, the callback is only for returning the leased
buffer to owner, and we just need io_uring to do the favor for driver
by running aio with the leased buffer.

It can becomes quite complicated if we add feedback from completion.

Your catch on short read/recv is good, which may leak kernel
data, the problem exists on any other approach(provide kbuf) too, the
point is that it is kernel buffer, what do you think of the
following approach?

diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index d72a6bbbbd12..c1bc4179b390 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -242,4 +242,14 @@ static inline void io_drop_leased_grp_kbuf(struct io_kiocb *req)
 	if (gbuf)
 		gbuf->grp_kbuf_ack(gbuf);
 }
+
+/* zero remained bytes of kernel buffer for avoiding to leak data */
+static inline void io_req_zero_remained(struct io_kiocb *req, struct iov_iter *iter)
+{
+	size_t left = iov_iter_count(iter);
+
+	printk("iter type %d, left %lu\n", iov_iter_rw(iter), left);
+	if (iov_iter_rw(iter) == READ && left > 0)
+		iov_iter_zero(left, iter);
+}
 #endif
diff --git a/io_uring/net.c b/io_uring/net.c
index 6c32be92646f..022d81b6fc65 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -899,6 +899,8 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 		*ret = IOU_STOP_MULTISHOT;
 	else
 		*ret = IOU_OK;
+	if (io_use_leased_grp_kbuf(req))
+		io_req_zero_remained(req, &kmsg->msg.msg_iter);
 	io_req_msg_cleanup(req, issue_flags);
 	return true;
 }
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 76a443fa593c..565b0e742ee5 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -479,6 +479,11 @@ static bool __io_complete_rw_common(struct io_kiocb *req, long res)
 		}
 		req_set_fail(req);
 		req->cqe.res = res;
+		if (io_use_leased_grp_kbuf(req)) {
+			struct io_async_rw *io = req->async_data;
+
+			io_req_zero_remained(req, &io->iter);
+		}
 	}
 	return false;
 }

> 
> > > At least for me, patch 4 looks fine. The problem occurs when you start
> > > needing to support this different buffer type, which is in patch 6. I'm
> > > not saying we can necessarily solve this with OP_BUF_UPDATE, I just want
> > > to explore that path because if we can, then patch 6 turns into "oh
> > > let's just added registered/fixed buffer support to these ops that don't
> > > currently support it". And that would be much nicer indeed.
> ...
> > > > > would be totally fine in terms of performance. OP_BUF_UPDATE will
> > > > > _always_ completely immediately and inline, which means that it'll
> > > > > _always_ be immediately available post submission. The only think you'd
> > > > > ever have to worry about in terms of failure is a badly formed request,
> > > > > which is a programming issue, or running out of memory on the host.
> > > > > 
> > > > > > Also it makes error handling more complicated, io_uring has to remove
> > > > > > the kernel buffer when the current task is exit, dependency or order with
> > > > > > buffer provider is introduced.
> > > > > 
> > > > > Why would that be? They belong to the ring, so should be torn down as
> > > > > part of the ring anyway? Why would they be task-private, but not
> > > > > ring-private?
> > > > 
> > > > It is kernel buffer, which belongs to provider(such as ublk) instead
> > > > of uring, application may panic any time, then io_uring has to remove
> > > > the buffer for notifying the buffer owner.
> > > 
> > > But it could be an application buffer, no? You'd just need the
> > > application to provide it to ublk and have it mapped, rather than have
> > > ublk allocate it in-kernel and then use that.
> > 
> > The buffer is actually kernel 'request/bio' pages of /dev/ublkbN, and now we
> > forward and borrow it to io_uring OPs(fs rw, net send/recv), so it can't be
> > application buffer, not same with net rx.
> 
> I don't see any problem in dropping buffers from the table
> on exit, we have a lot of stuff a thread does for io_uring
> when it exits.

io_uring cancel handling has been complicated enough, now uring
command have two cancel code paths if provide kernel buffer is
added:

1) io_uring_try_cancel_uring_cmd()

2) the kernel buffer cancel code path

There might be dependency for the two.

> 
> 
> > > > In concept grouping is simpler because:
> > > > 
> > > > - buffer lifetime is aligned with group leader lifetime, so we needn't
> > > > worry buffer leak because of application accidental exit
> > > 
> > > But if it was an application buffer, that would not be a concern.
> > 
> > Yeah, but storage isn't same with network, here application buffer can't
> > support zc.
> 
> Maybe I missed how it came to app buffers, but the thing I
> initially mentioned is about storing the kernel buffer in
> the table, without any user pointers and user buffers.

Yeah, just some random words, please ignore it.

> 
> > > > - the buffer is borrowed to consumer OPs, and returned back after all
> > > > consumers are done, this way avoids any dependency
> > > > 
> > > > Meantime OP_BUF_UPDATE(provide buffer OP, remove buffer OP) becomes more
> > > > complicated:
> > > > 
> > > > - buffer leak because of app panic
> 
> Then io_uring dies and releases buffers. Or we can even add
> some code removing it, as mentioned, any task that has ever
> submitted a request already runs some io_uring code on exit.
> 
> > > > - buffer dependency issue: consumer OPs depend on provide buffer OP,
> > > > 	remove buffer OP depends on consumer OPs; two syscalls has to be
> > > > 	added for handling single ublk IO.
> > > 
> > > Seems like most of this is because of the kernel buffer too, no?
> > 
> > Yeah.
> > 
> > > 
> > > I do like the concept of the ephemeral buffer, the downside is that we
> > > need per-op support for it too. And while I'm not totally against doing
> > 
> > Can you explain per-op support a bit?
> > 
> > Now the buffer has been provided by one single uring command.
> > 
> > > that, it would be lovely if we could utilize and existing mechanism for
> > > that rather than add another one.
> 
> That would also be more flexible as not everything can be
> handled by linked request logic, and wouldn't require hacking
> into every each request type to support "consuming" leased
> buffers.

I guess you mean 'consuming' the code added in net.c and rw.c, which
can't be avoided, because it is kernel buffer, and we are supporting
it first time:

- there isn't userspace address, not like buffer select & fixed buffer
- the kernel buffer has to be returned to the provider
- the buffer has to be imported in ->issue(), can't be done in ->prep()
- short read/recv has to be dealt with

> 
> Overhead wise, let's say we fix buffer binding order and delay it
> as elaborated on below, then you can provide a buffer and link a
> consumer (e.g. send request or anything else) just as you do
> it now. You can also link a request returning the buffer to the
> same chain if you don't need extra flexibility.
> 
> As for groups, they're complicated because of the order inversion,

IMO, group complication only exists in the completion side, fortunately
it is well defined now.

buffer and table causes more complicated application, with bad
performance:

- two syscalls(uring_enter trips) are added for each ublk IO
- one extra request is added(group needs 2 requests, and add buffer
needs 3 requests for the simples case), then bigger SQ & CQ size
- extra cancel handling

group simplifies buffer lifetime a lot, since io_uring needn't to
care it at all.

> the notion of a leader and so. If we get rid of the need to impose
> more semantics onto it by mediating buffer transition through the
> table, I think we can do groups if needed but make it simpler.

The situation is just that driver leases the buffer to io_uring, not
have to transfer it to io_uring. Once it is added to table, it has to
be removed from table.

It is just like local variable vs global variable, the latter is more
complicated to use.

> 
> > > What's preventing it from registering it in ->prep()? It would be a bit
> > > odd, but there would be nothing preventing it codewise, outside of the
> > > oddity of ->prep() not being idempotent at that point. Don't follow why
> > > that would be necessary, though, can you expand?
> > 
> > ->prep() doesn't export to uring cmd, and we may not want to bother
> > drivers.
> > 
> > Also remove buffer still can't be done in ->prep().
> > 
> > Not dig into further, one big thing could be that dependency isn't
> > respected in ->prep().
> 
> And we can just fix that and move the choosing of a buffer
> to ->issue(), in which case a buffer provided by one request
> will be observable to its linked requests.

This patch does import buffer in ->issue(), as I explained to Jens:

- either all OPs are linked together with add_kbuf  & remove_kbuf, then
all OPs can't be issued concurrently

- or two syscalls are added for handling single ublk IO

The two are not great from performance viewpoint, but also complicates
application.

I don't think the above two can be avoided, or can you explain how to
do it?


thanks,
Ming

