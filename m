Received: from mail-pf1-f230.google.com (mail-pf1-f230.google.com [209.85.210.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACD366
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762333; cv=none; b=kJ5pzs0WwtBsB8O5r3WvP1RFX5ii3L9Bo0dO+JcRIuDFNP2VniIwCIsLAwVcR5+QEgps5oabk1sV/JEsMPRGEcJPBChv4wTwYaiazZDHF9K36q1nauKBiXgW3z4uNOp8WpolgbbnxCoOoEAL2S5uCzAVPPQSJd0kqU+hQhcEzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762333; c=relaxed/simple;
	bh=JDk8LqgwfL/+dtJw3LvsgV4i88OwIAtrCrWKeCxQUOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQF5BwXOJo+H672rIy+TA5+GaNUbg+p0UB3/1kzrNLt/P6jhwQkJd8AeNwmokJjsD8eLccl66qkdya921s0Z4yJ27PLFIYDfnZ12g/Sh5IioFlHYB3/9kDPQxyMBewDAoUearZfAdl0gF1uLhY8V5cWSqcKy4Ej99HL3ZdVtleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cKOYqN48; arc=none smtp.client-ip=209.85.210.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cKOYqN48"
Received: by mail-pf1-f230.google.com with SMTP id d2e1a72fcca58-7399838db7fso197285b3a.0
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 17:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744762330; x=1745367130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9tvCT6nGWGuLvXuDAJbd6QoqHy00nODvJNAVVZOzt0=;
        b=cKOYqN48FtdcruqkJo2U8penzjaL0FB8v8DBDruzWPHtyVvwmupOVgDRR65575KDR5
         Ey1MYtK3NxuN4Hh/FF8TzoiULa1Jq/A8Akc4cThd9gQczf+njBARqySpTHppjX6uf2Vy
         G3jripYR41AKNGVtS8OtJ6ZhPLq++HVTbiSuZNWuKAAFJLwQ4E229wBWH4/KggDuDVeb
         /uGorSZVXJwizMnyyrDPAXpl2ynL+HfZ4Mewe8rZrlg9utmBAIxPkZkt5q2//V1q+1RE
         OHT8D8zFMAs0w8VZuBvI2OOwW8JtVdoEuJF59JXcNaFf8lc2k2Dk81dyepWy2loYcO5W
         Qdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744762330; x=1745367130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9tvCT6nGWGuLvXuDAJbd6QoqHy00nODvJNAVVZOzt0=;
        b=nvS0TJ/Q8iWX/2Gvmw+DHgbTNK9Qjd3xpIlTVDRLK73FWn1fz/KPaFdFpZlKqTFG8t
         v/230JX+NcH9VqFrOoeOSukAr+3vlZIUgIuDPJWz3xLqFDHsLAFwJE7PkKp0GfcGP0iF
         NkhH3n0SlEdNthevJWYlM6YFZGEmZ8Pti33ZhGkmF39XEuRg06Dn+EYT4lEEAAPbdzjW
         lYXQwKrJ3bB7CtpM6b7CMUBBK4p9jvGa5UKn/NaZ1vpSu+/N5e1lFdkiVxijs97K0kCB
         cbhHMRWG96mr6iyuFwXIcFn0ysnDcVfcH4s1eA03evnqeJ8zckH7lLC3WvkFeQAcsKbK
         60Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVdIud7bnIaBJjMZIJ4OBEfANdawbj9tcakgrgqo309WmSM1X8kgiZ0DRcaMITZisR+teIxELncmECyiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkByhhrAuaFRNZu5WDh+7DiH0z/Lq860GLipu1ReXQQ7Nq3FR3
	zUeyzBFvX6ml0tFmI8y+hnDGSsbVRaAPsT4OlqJ/0GAO02NLxGsO463udHZufeOnuRIExafid6f
	YtuIEBtepnTC6RGP3N75e5sI48TU1Su4yTsa7iTLBTuPs/ay7
X-Gm-Gg: ASbGncvE/jHb7/ry8AVuIyD/tAngQ4vcSjEjDyJYO1+nC04xmhDWmN62dAbejdBTF5p
	rihX0NBlehhSzYZ5/+ugNsdEc1zEwFv/YSTjPY/NsI5uAKuPf8ZVTVKFml53p8N3o8xnqNRZa8P
	XoKWxdqjgfVr2iT/Ztux1QYHWiTRrwa+iKuryCb9Gtmc5WsxnLKnhMfYt14IPquVaSKp91GJ2AK
	ZESU4z8ZeoyONW19x0rvsdhNdC2MSVweIBeQfKwhvWitsKVN53w//8ar764KbMCtZ8eFw5K3Kt5
	fhE8HJBKN5h6KRuhe4dO+8fWgGpPWN4=
X-Google-Smtp-Source: AGHT+IFPI/ATzrnFkKZbpq8yzSb+boReXT1S34oio+O4o6crjGfuV8KDVN3ClM3651CK78iIoa63tXQgi0oA
X-Received: by 2002:a05:6a20:e687:b0:1ee:a410:4aa5 with SMTP id adf61e73a8af0-203acb11b2bmr2206594637.17.1744762330393;
        Tue, 15 Apr 2025 17:12:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-73bd21e4a67sm590809b3a.12.2025.04.15.17.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:12:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A7BB53401FD;
	Tue, 15 Apr 2025 18:12:09 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 9B73AE402BD; Tue, 15 Apr 2025 18:12:09 -0600 (MDT)
Date: Tue, 15 Apr 2025 18:12:09 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v3 2/2] ublk: require unique task per io instead of
 unique task per hctx
Message-ID: <Z/712T8dBZgTRLA4@dev-ushankar.dev.purestorage.com>
References: <20250410-ublk_task_per_io-v3-0-b811e8f4554a@purestorage.com>
 <20250410-ublk_task_per_io-v3-2-b811e8f4554a@purestorage.com>
 <Z_jYfwFN_AYkUNJK@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_jYfwFN_AYkUNJK@fedora>

On Fri, Apr 11, 2025 at 04:53:19PM +0800, Ming Lei wrote:
> On Thu, Apr 10, 2025 at 06:17:51PM -0600, Uday Shankar wrote:
> > Currently, ublk_drv associates to each hardware queue (hctx) a unique
> > task (called the queue's ubq_daemon) which is allowed to issue
> > COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> > to do so, the command fails immediately with EINVAL. When considered
> > together with the block layer architecture, the result is that for each
> > CPU C on the system, there is a unique ublk server thread which is
> > allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> > performance under imbalanced load generation. For an extreme example,
> > suppose all the load is generated on CPUs mapping to a single ublk
> > server thread. Then that thread may be fully utilized and become the
> > bottleneck in the system, while other ublk server threads are totally
> > idle.
> > 
> > This issue can also be addressed directly in the ublk server without
> > kernel support by having threads dequeue I/Os and pass them around to
> > ensure even load. But this solution requires inter-thread communication
> > at least twice for each I/O (submission and completion), which is
> > generally a bad pattern for performance. The problem gets even worse
> > with zero copy, as more inter-thread communication would be required to
> > have the buffer register/unregister calls to come from the correct
> > thread.
> 
> Agree.
> 
> The limit is actually originated from current implementation, both
> REGISTER_IO_BUF and UNREGISTER_IO_BUF should be fine to run from other
> pthread because the request buffer 'meta' is actually read-only.
> 
> > 
> > Therefore, address this issue in ublk_drv by requiring a unique task per
> > I/O instead of per queue/hctx. Imbalanced load can then be balanced
> > across all ublk server threads by having threads issue FETCH_REQs in a
> > round-robin manner. As a small toy example, consider a system with a
> > single ublk device having 2 queues, each of queue depth 4. A ublk server
> > having 4 threads could issue its FETCH_REQs against this device as
> > follows (where each entry is the qid,tag pair that the FETCH_REQ
> > targets):
> > 
> > poller thread:	T0	T1	T2	T3
> > 		0,0	0,1	0,2	0,3
> > 		1,3	1,0	1,1	1,2
> > 
> > Since tags appear to be allocated in sequential chunks, this setup
> > provides a rough approximation to distributing I/Os round-robin across
> > all ublk server threads, while letting I/Os stay fully thread-local.
> 
> BLK_MQ_F_TAG_RR can be set for this way, so is it possible to make this
> as one feature? And set BLK_MQ_F_TAG_RR for this feature.

Yes, it would be easy enough to add. However we have been testing with
the v1 patch [1] for a while now, and have seen pretty even load
balancing even without BLK_MQ_F_TAG_RR. So I am not sure if it is worth
it/if we will use the flag, especially considering that it is documented
as reducing performance.

[1] https://lore.kernel.org/all/20241002224437.3088981-1-ushankar@purestorage.com/

> Also can you share what the preferred implementation is for ublk server?
> 
> I think per-io pthread may not be good, maybe partition tags space into
> fixed range/pthread?

By "unique task per io" I mean that each io can have its own task
(including two ios in the same queue can have different tasks), but two
ios can have the same task.

That's roughly what we're doing, we have a handful of threads (around
8-16) and we split up the I/Os between them. With this patch we lift the
restriction that each thread corresponds 1:1 with a ublk_queue/hctx.

> `ublk_queue' reference is basically read-only in IO code path, I think
> it need to be declared explicitly as 'const' pointer in IO code/uring code
> path first. Otherwise, it is easy to trigger data race with per-io task
> since it is lockless.

That is a good suggestion.

