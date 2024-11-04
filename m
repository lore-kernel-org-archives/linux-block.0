Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930151B6CFB
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725714; cv=none; b=YXl71bKvnmoWDrreEHSYtqy4FrW+LbiUvyBm2VSZ+u8RmCoO5Wq4krqgfy3nxFoyK8hwXp0w1C860OSoVcsvGpnqJI9k3dmNRWxFvba74SEjU9iVsdBY/GyRcEnYCJ2tJ8Ck3ofS9Ff/383JnZOA81O30mAoS507m5pSCEfG+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725714; c=relaxed/simple;
	bh=gTgCwlj6bWgs30tP/OjumVsS8UJGqtW8qZLcDgxlA8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASa8GwdUPBvUbh6fGajVywKvuP+1s57vloA5dYvwksRQ1qcEjuJZLzN+UipZqZfL0v2zoJkd3pRZwEto0PQegepUv8uOkqP8lSXDix331bjkLHdtuUxyUa3HBXuf1/TcDRIpUTEGo7ADoKekk52GJZuq4QzL3RhYnu0cLlyXZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg+TlhuB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg+TlhuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730725711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twhpbXq1kEbakvhtR6RjEHuzDyq/X3h4MIVNR37MRAs=;
	b=Sg+TlhuBpRGjO95u/Wu5eUNCRCi2uJ+UIOb+Bos3f9fEosyZaCV3MbcKnhZ3WIgAbTFrUx
	O9O8mv+R3LsnPdodayncgrstgGHaQdo9wKWFdKUUUPeZoA2KcwuZl6mqPKLaNkEmUM5/03
	iNJ99xQopiWyE1M+sQDV6Ebc9ko0uuw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-tPNIfP3YOlSo-2G8uwWl-A-1; Mon,
 04 Nov 2024 08:08:28 -0500
X-MC-Unique: tPNIfP3YOlSo-2G8uwWl-A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A59519560B2;
	Mon,  4 Nov 2024 13:08:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B05D319560AD;
	Mon,  4 Nov 2024 13:08:21 +0000 (UTC)
Date: Mon, 4 Nov 2024 21:08:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>
Subject: Re: [PATCH V8 5/7] io_uring: support leased group buffer with
 REQ_F_GROUP_KBUF
Message-ID: <ZyjHQN9VITpOlyPA@fedora>
References: <ZyGBlWUt02xJRQii@fedora>
 <bbf2612e-e029-460f-91cf-e1b00de3e656@gmail.com>
 <ZyGURQ-LgIY9DOmh@fedora>
 <40107636-651f-47ea-8086-58953351c462@gmail.com>
 <ZyQpH8ttWAhS9C5G@fedora>
 <4802ef4c-84ca-4588-aa34-6f1ffa31ac49@gmail.com>
 <ZygSWB08t1PPyPyv@fedora>
 <0cd7e62b-3e5d-46f2-926b-5e3c3f65c7dd@gmail.com>
 <ZyghmwcI1U4WizyX@fedora>
 <74d8d323-789c-4b4d-8ce6-ada6a567b552@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d8d323-789c-4b4d-8ce6-ada6a567b552@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Nov 04, 2024 at 12:23:04PM +0000, Pavel Begunkov wrote:
> On 11/4/24 01:21, Ming Lei wrote:
> > On Mon, Nov 04, 2024 at 01:08:04AM +0000, Pavel Begunkov wrote:
> > > On 11/4/24 00:16, Ming Lei wrote:
> ...
> > > > > > > > > I agree, it's not hot, it's a failure path, and the recv side
> > > > > > > > > is of medium hotness, but the main concern is that the feature
> > > > > > > > > is too actively leaking into other requests.
> > > > > > > > The point is that if you'd like to support kernel buffer. If yes, this
> > > > > > > > kind of change can't be avoided.
> > > > > > > 
> > > > > > > There is no guarantee with the patchset that there will be any IO done
> > > > > > > with that buffer, e.g. place a nop into the group, and even then you
> > > > > > 
> > > > > > Yes, here it depends on user. In case of ublk, the application has to be
> > > > > > trusted, and the situation is same with other user-emulated storage, such
> > > > > > as qemu.
> > > > > > 
> > > > > > > have offsets and length, so it's not clear what the zeroying is supposed
> > > > > > > to achieve.
> > > > > > 
> > > > > > The buffer may bee one page cache page, if it isn't initialized
> > > > > > completely, kernel data may be leaked to userspace via mmap.
> > > > > > 
> > > > > > > Either the buffer comes fully "initialised", i.e. free of
> > > > > > > kernel private data, or we need to track what parts of the buffer were
> > > > > > > used.
> > > > > > 
> > > > > > That is why the only workable way is to zero the remainder in
> > > > > > consumer of OP, imo.
> > > > > 
> > > > > If it can leak kernel data in some way, I'm afraid zeroing of the
> > > > > remainder alone won't be enough to prevent it, e.g. the recv/read
> > > > > len doesn't have to match the buffer size.
> > > > 
> > > > The leased kernel buffer size is fixed, and the recv/read len is known
> > > > in case of short read/recv, the remainder part is known too, so can you
> > > > explain why zeroing remainder alone isn't enough?
> > > 
> > > "The buffer may bee one page cache page, if it isn't initialized
> > > completely, kernel data may be leaked to userspace via mmap."
> > > 
> > > I don't know the exact path you meant in this sentence, but let's
> > > take an example:
> > > 
> > > 1. The leaser, e.g. ublk cmd, allocates an uninitialised page and
> > > leases it to io_uring.
> > > 
> > > 2. User space (e.g. ublk user space impl) does some IO to fill
> > > the buffer, but it's buggy or malicious and fills only half of
> > > the buffer:
> > > 
> > > recv(leased_buffer, offset=0, len = 2K);
> > > 
> > > So, one half is filled with data, the other half is still not
> > > initialsed.
> > 
> > io_req_zero_remained() is added in this patch and called after the
> > half is done for both io_read() and net recv().
> 
> It zeroes what's left of the current request, but requests
> don't have to cover the entire buffer.

io_req_zero_remained() exactly covers the part of the buffer for this
request instead of the whole buffer, range of buffer are actually
passed from SQE(read/write, send/recv).

> 
> > > 3. The lease ends, and we copy full 4K back to user space with the
> > > unitialised chunk.
> > > 
> > > You can correct me on ublk specifics, I assume 3. is not a copy and
> > > the user in 3 is the one using a ublk block device, but the point I'm
> > > making is that if something similar is possible, then just zeroing is not
> > > enough, the user can skip the step filling the buffer. If it can't leak
> > 
> > Can you explain how user skips the step given read IO is member of one group?
> 
> (2) Illustrates it, it can also be a nop with no read/recv

As I explained before, the application has to be trusted, and it must
have the permission to open the device & call into the buffer lease
uring_cmd.

It is in same situation with any user emulated storage, such as qemu,
fuse, and the application has to do things right.

> 
> > > any private data, then the buffer should've already been initialised by
> > > the time it was lease. Initialised is in the sense that it contains no
> > 
> > For block IO the practice is to zero the remainder after short read, please
> > see example of loop, lo_complete_rq() & lo_read_simple().
> 
> It's more important for me to understand what it tries to fix, whether
> we can leak kernel data without the patch, and whether it can be exploited
> even with the change. We can then decide if it's nicer to zero or not.
> 
> I can also ask it in a different way, can you tell is there some security
> concern if there is no zeroing? And if so, can you describe what's the exact
> way it can be triggered?

Firstly the zeroing follows loop's handling for short read.

Secondly, if the remainder part of one page cache buffer isn't zeroed, it might
be leaked to userspace via another read() or mmap() on same page.



Thanks,
Ming

