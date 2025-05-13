Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FB41C7F
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747103233; cv=none; b=bykLtGItUbFDA5xa0MVOxJI7Pv1Msgr+RxI76pdM2s9kczlLL7pRqAu8+6ybYe20zP26U5Ef8/ByLGwotMAvhgfb7AIyFBLn9X4yj6BUfnrSgJT54Uyk11Ne6V0dJPGkrlPXUsnROZRIMU+EQOC5yId6awowI8iyLV/9xPvVaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747103233; c=relaxed/simple;
	bh=na/1HPVz+HYITHvaCGk9iiMtT9bsj58Tf2mN3phDHbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAIPl0Q90lsFol4DygaEeAduc3PlIpcqCmVJmRartRneKUB+9yI6KAK9GVwpTVjYT/xD4aQzV6pXLbLYNeW8cx8NCn5Lqd+GtBojam9StUdd/6ctjx0ENgZonPlPLvyMryI3oOeOFgvUN65zVRtW+S5obJMr+Z04KOIbFLRrRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cupWqqFP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cupWqqFP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747103231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abkHAFhf7HZGnuP3f7x/0GcEC+3xW5U7lyBGHFO+BEI=;
	b=cupWqqFPNxUIAvdVuBIBMALCDESAxTac4KeuP6jj3dHe0B6g4SMfi+/p7MMQ0UpfTi/LU6
	7jy1mSw5/VyX7a4szODCBDbJDNkoFYDjZnNTz3vBGBJnKeomfCFSXU5KXsdDX10OapQ2rS
	5LKqPvOeuBoSVJFhrNwmoC0GXk/v3HU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-qz0N9VwLPUiDRIbEs5YsqA-1; Mon,
 12 May 2025 22:27:07 -0400
X-MC-Unique: qz0N9VwLPUiDRIbEs5YsqA-1
X-Mimecast-MFC-AGG-ID: qz0N9VwLPUiDRIbEs5YsqA_1747103226
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87A841955E72;
	Tue, 13 May 2025 02:27:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8455C1945CB4;
	Tue, 13 May 2025 02:27:02 +0000 (UTC)
Date: Tue, 13 May 2025 10:26:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 1/6] ublk: allow io buffer register/unregister command
 issued from other task contexts
Message-ID: <aCKt8ZLpZctP020J@fedora>
References: <20250509150611.3395206-1-ming.lei@redhat.com>
 <20250509150611.3395206-2-ming.lei@redhat.com>
 <CADUfDZqfEnOM1hmZJw7VTNUUu_zqf1fBcju_ZvDt9tNe3-KcHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqfEnOM1hmZJw7VTNUUu_zqf1fBcju_ZvDt9tNe3-KcHw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, May 12, 2025 at 10:39:57AM -0700, Caleb Sander Mateos wrote:
> On Fri, May 9, 2025 at 8:06 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > `ublk_queue` is read only for io buffer register/unregister command. Both
> > `ublk_io` and block layer request are read-only for IO buffer register/
> > unregister command.
> >
> > So the two command can be issued from other task contexts.
> 
> I mentioned this before in
> https://lore.kernel.org/linux-block/CADUfDZqZ_9O7vUAYtxrrujWqPBuP05nBhCbzNuNsc9kJTmX2sA@mail.gmail.com/
> 
> But UBLK_IO_(UN)REGISTER_IO_BUF still reads io->flags. So it would be
> a race condition to handle it on a thread other than ubq_daemon, as
> ubq_daemon may concurrently modify io->flags. If you do want to
> support UBLK_IO_(UN)REGISTER_IO_BUF on other threads, the writes to
> io->flags should use WRITE_ONCE() and the reads on other threads
> should use READ_ONCE(). With those modifications, it should be safe
> because __ublk_check_and_get_req() atomically checks the state of the
> request and increments its reference count.

UBLK_IO_(UN)REGISTER_IO_BUF just reads the flag, if
UBLK_IO_FLAG_OWNED_BY_SRV is cleared, the OP is failed.

Otherwise, __ublk_check_and_get_req() covers everything because both
'ublk_io' and 'request' are pre-allocation. The only race is that new
recycled request buffer is registered, that is fine, because it can be
treated as logic bug.

So I think it isn't necessary to use READ_ONCE/WRITE_ONCE, or can you show
what the exact issue is?


Thanks, 
Ming

