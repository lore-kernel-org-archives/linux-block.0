Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325018A6A8
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268800; cv=none; b=BgznLXjcCCmfyc0R30BFPImkDupMmnPK2kjYyhwlhy0psMCLBy64MLVBQ+EqnDuO64WTzRaIy3EUHAsNM9saDsg9WjyWIruyWtUTF7ciirV0ad3LiepDH5bPTqSB+B4kC0fjiCtyFuX5gn5/h3Zy2ybud+P/EcVofDUeBoEe0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268800; c=relaxed/simple;
	bh=vlQ6PbNTgweewm9g1WmTQWWao+QKtRnvXfdhU56HTzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdZcQx8cwhafzyXmRYZJDNr2tMiEgUpAezqS9MnRWhgsbzRvfFe3tcACkB94Uz3nIiUUpbQC5e+beovkgtEj3dU7ky4bt1IBUMdzJDd9rHeEnHHyS+zgmucWvDqx/lhJvcy2wwmAjIZiWZ075tVWbi7OuR5qvThr/MF05D9iCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdjD/BrK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdjD/BrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768268797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBryUrkEahPaceWmMdWmGfkBzgky4fj3Ki6z0shPLDI=;
	b=AdjD/BrKU+9j0Z/Dw70kS6sGx4k9RDQsSCq6WpchqPCFsXyZ76XQp5Jizciv9rPftpDK7x
	s3gvb57Ha2jd0J8/RuegVLseV9OVhdL/c7x/1r6UkkmXvmEGQNh2XANkbPSCTgMmbQEXty
	XybiAp5r+xQWZZUo4Kz+KAbZyunY738=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-CH9z17UkNAqqG4jvQAGcng-1; Mon,
 12 Jan 2026 20:46:34 -0500
X-MC-Unique: CH9z17UkNAqqG4jvQAGcng-1
X-Mimecast-MFC-AGG-ID: CH9z17UkNAqqG4jvQAGcng_1768268793
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEE4B1954B06;
	Tue, 13 Jan 2026 01:46:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51EC430001A2;
	Tue, 13 Jan 2026 01:46:28 +0000 (UTC)
Date: Tue, 13 Jan 2026 09:46:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Seamus Connor <sconnor@purestorage.com>
Subject: Re: [PATCH 2/2] selftests/ublk: fix garbage output and cleanup on
 failure
Message-ID: <aWWj8Ae8FLNLuXG4@fedora>
References: <20260112041209.79445-1-ming.lei@redhat.com>
 <20260112041209.79445-3-ming.lei@redhat.com>
 <CADUfDZpnX1yU-+7xDcEtSqTMuaR2q5zgzgMs0Bh3x8+c=1g+_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpnX1yU-+7xDcEtSqTMuaR2q5zgzgMs0Bh3x8+c=1g+_w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jan 12, 2026 at 09:36:39AM -0800, Caleb Sander Mateos wrote:
> On Sun, Jan 11, 2026 at 8:12 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Fix several issues in kublk:
> >
> > 1. Initialize _evtfd to -1 in struct dev_ctx to prevent garbage output
> >    in foreground mode. Without this, _evtfd is zero-initialized to 0
> >    (stdin), and when ublk_send_dev_event() is called on failure, it
> >    writes binary data to stdin which appears as garbage on the terminal.
> 
> Nice, I always wondered why that happened!
> 
> >
> > 2. Move fail label in ublk_start_daemon() to ensure pthread_join() is
> >    called before queue deinit on the error path. This ensures proper
> >    thread cleanup when startup fails.
> >
> > 3. Add async parameter to ublk_ctrl_del_dev() and use async deletion
> >    when the daemon fails to start. This prevents potential hangs when
> >    deleting a device that failed during startup.
> >
> > Also fix a debug message format string that was missing __func__ and
> > had wrong escape character.
> 
> These all look good, but maybe they would make sense as separate commits?

Fine, I will split it into two patches:

- one is for fixing start_dev failure handling

- another one is for fixing misc debug message problems

> 
> >
> > Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tools/testing/selftests/ublk/kublk.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> > index 185ba553686a..0c62a967f2cb 100644
> > --- a/tools/testing/selftests/ublk/kublk.c
> > +++ b/tools/testing/selftests/ublk/kublk.c
> > @@ -153,11 +153,10 @@ static int ublk_ctrl_add_dev(struct ublk_dev *dev)
> >         return __ublk_ctrl_cmd(dev, &data);
> >  }
> >
> > -static int ublk_ctrl_del_dev(struct ublk_dev *dev)
> > +static int ublk_ctrl_del_dev(struct ublk_dev *dev, bool async)
> >  {
> >         struct ublk_ctrl_cmd_data data = {
> > -               .cmd_op = UBLK_U_CMD_DEL_DEV,
> > -               .flags = 0,
> > +               .cmd_op = async ? UBLK_U_CMD_DEL_DEV_ASYNC: UBLK_U_CMD_DEL_DEV,
> >         };
> >
> >         return __ublk_ctrl_cmd(dev, &data);
> > @@ -1063,11 +1062,11 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
> >         else
> >                 ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
> >
> > + fail:
> >         /* wait until we are terminated */
> >         for (i = 0; i < dev->nthreads; i++)
> >                 pthread_join(tinfo[i].thread, &thread_ret);
> 
> Is it valid to call pthread_join() on a zeroed pthread_t value? If
> ublk_queue_init() fails, there is a goto fail before any of the
> tinfo[i].thread have been assigned. And there's no checking of the
> return value from pthread_create(), so if pthread_create() fails,
> tinfo[i].thread may not be assigned either.

Good catch, will add new fail_queue_init label for covering it.
 

Thanks,
Ming

