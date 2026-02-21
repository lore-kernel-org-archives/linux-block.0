Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA12DF12F
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771665125; cv=pass; b=IrkFmrA0Ytfc01YmMFQJkZ7n34lRssq2TMLywNoa/ocyAyqSz1iBvK04V7wOO2lM9UWW0iiyJ7quFSLanqZ8L7RZmkpqxlb4KPbgfuwDPwnr85mvKs2I4X5onWL786wekqjsCXHO5yAihHeadcsRHGRJK9iP72qKmswM+q5U3gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771665125; c=relaxed/simple;
	bh=YLMy/eJC33SeA+X6nkHRGtxREcz9ZXeGvlp94b9j/OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mM3RIS779lz8nYciNgD1gwSsDmkhlzASN1eDeDbu+etfnM/DSrjUTGtl5w1Jg0RwURaiCWTnHM8iNobIPJcMGy3qNh5OozuBML5K/u63j7EJXh4eoQaTTFSxDingTb167b5DOuKJ1mpuzQsPXDqpDGAplA7CALRUriBBBeJjxos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvOk4n7a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUwZIYWz; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvOk4n7a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUwZIYWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771665122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Med7MAxXcpqee2OOIkX9OPTkN8DI7LIqce9DvMMQG8=;
	b=WvOk4n7ay2Rx4BZRdJiL2sbIeSYEVkzfUTg4tuTZo3InWJ656gC8KnxqRSKVBrfR5JPA5Z
	1UKAwSfmqUdF/xdl6qUjAtDnG9pCA8QV20htWXdT+S4PX2ycz6izRWVJv1LPDQC/isCOJI
	4P/07kLX2UYGA9E8ISnLE5BRvGh4pv4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-R7q7-XIeM8-JntcPglvpHA-1; Sat, 21 Feb 2026 04:12:00 -0500
X-MC-Unique: R7q7-XIeM8-JntcPglvpHA-1
X-Mimecast-MFC-AGG-ID: R7q7-XIeM8-JntcPglvpHA_1771665119
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59e0abad4fbso1369742e87.2
        for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 01:12:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771665118; cv=none;
        d=google.com; s=arc-20240605;
        b=Jy3OjTKljNxqyNi4W74B5i4cWdwb9SiTm8sC+/UhMKthLmvJCzdOk5OwVoJXmireu9
         jDyC/UwH5q5Y/xBM/poMlS1hoid11K/6IAeet9bhDte8bEz++ap0sjTG09Jpujv4DX9K
         dRIx+A2TOx9Se0g/sh9J/a/pINCLts0obN7ogiEO3oi2m0LJEctywMLtAxjy9ZK2GCjE
         xB4Vym6WF6LMhsW4+QZ/xNq+efOogzwPE1c89lXUPjyhLt9b+JiF4qy3l196uqaO+gzL
         6bxfeJmGyR4PS2OqhHIhhsPMuwJEpc67hmHlI42OQf2MPKgCnr5sTrIDpfCIIOd/4cQs
         YlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Med7MAxXcpqee2OOIkX9OPTkN8DI7LIqce9DvMMQG8=;
        fh=XBWDWzjFnltviZKYu4SXVdzRT4IZF9u6kBbr2jLb5J4=;
        b=h9IiYPD+8VxRtMbRQuC3q5tgMPOdKpjdSzLJIJEVUEveGTag+XbUEHZC+vuG6Qb4N8
         xK2NHqDOYw4OO+FAF82qzGzcWqeWqv5qG2SPsOzrKuPkl6zvEhKQY+nOuBz6ZoLlWfhs
         qo1AESZnC6S5lPV0WqV+N8FAWikXK6NwwcwnMx+1IFEw3hWPBzIhbiUQ8WpFPBq2JWiX
         78W0BwG7fs+kqPPJRb/dbWjalbB0IYPJmsUW6I5QiVQR4BHdGagGL01z9hP54G5CJr9N
         bl/H0i7ZnsIJzgCyJtrLJLyViV144WUAi9HHK/fXTayIu6YAwRfnBYT/CeQCBpTBzrCX
         XDNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771665118; x=1772269918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Med7MAxXcpqee2OOIkX9OPTkN8DI7LIqce9DvMMQG8=;
        b=eUwZIYWz8kVvqHRqIyucU44mxnCfw6vQz/2tzMC5pVdYGeMSAg9WYzGXGiwtNm7Sww
         66dF6KGmcfa1M6GjQwO6B6HGwO0QQS5qt6xvSaYNfX9mc2X2cnWJ6kRe3DZwwI2R7iEc
         QSJjjPC7k/96qpyK5JuigawI8Cj6SBT3HiFDfpPJjxBDLrKrPPh859ZilwptQXUCILQD
         SIlNXlmVuYjrA/bqTfReaKx+x0Wn/j8CWUZBkkNH9CXi3Q/jWd64zux264En+RpxNCIx
         sBShO/aj8G7zqjAyK7nkE8SGK0NTfEsVkoZMF3i7y+lYPwispS+dTqLQsmHnIAgkjlpb
         5Mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771665118; x=1772269918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Med7MAxXcpqee2OOIkX9OPTkN8DI7LIqce9DvMMQG8=;
        b=OAMNMlDRaSmuQvc8ngU8r5sbwZ9aX3w+9xeuScO7oDLHWOseh/JNGuvV3MQfcArWbv
         IeVOr6vB2xlxt0UTh3V1GUqo90JjtEAY/9q0YAM8DWm6HZnKQIlWChV4Xk5S6qPqN339
         RR8SHxqyMxbCbtrVru9BeSrhh+VE7uEwlhGicLyJ1SyzGhPwocqfXfuAwLCicupg47rM
         2eJKIJT/+ErMv/nTmT/PirtLCOPNMc0P4EsebhlzGfAdF8V8wc3yzW/zfvVzbq9srA0Y
         Bn77koZHgbMSSdNR7VnAFjERvi6SAETc7p3RlIrZLSWRoxOpNHbeQr3Qyx6w/vZFLjji
         dtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5WSii2kmEdf5P/JjUkF1w1c3x/ikv2t0K6fT9mKjM+mERCFMoS8MRXrm2uMcqZrrd1c5PFfkLKMggRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YW+LFSZUxVUhRBDsjOIdjT7Lbul4Ql4COoyzSL8ABFnihm7i
	nBY39ya1QobL+aKYigHT0BrVh6Ls0SK3uc9FY8E/FSmqAJ2K9sMg0gmyiljSHPiXsRN1tWYcDJL
	nVhK7x7ZwNtz3XJ+7r/u4ih9s/UzDcGHGLF+23pdhpdtrTxyQO/I+Eexp08OgjohefVljeeNwiH
	1+CWyGG1OCLlzeXi3GxJwaYu0/ImTPHAH4kWI3K6lXIqm5HQ0=
X-Gm-Gg: AZuq6aIOkZ8+H5IwcmCDWb7Vwsv5Dt2/24/b7tV4mSloqNfkM1FCQXYPMhLXJ8rro8b
	cnmnRyCyOcApvXtaJMtPiLjAOxb8EuuLlPzz1UDYEH95XbtS4JD4AVtJNpqWwz2FLA1gmBax4mc
	pmXMc9V+w5vbXaP5CJYUzKMFYNST2rIpoezLXHMJ++i5G45f0VGgqDY6AVRW4zuqVPgAaqpaytU
	7xpEdkZiuJ0DU7rB54XztspExVHMGiV7AkQzoIiz9wotBIKu8/KXv8BmapMs7L16+k2Aj7YZQqW
	q4pLrQ==
X-Received: by 2002:a05:6512:ac5:b0:59e:64d2:71a0 with SMTP id 2adb3069b0e04-5a0ed8973d0mr739517e87.18.1771665117758;
        Sat, 21 Feb 2026 01:11:57 -0800 (PST)
X-Received: by 2002:a05:6512:ac5:b0:59e:64d2:71a0 with SMTP id
 2adb3069b0e04-5a0ed8973d0mr739509e87.18.1771665117295; Sat, 21 Feb 2026
 01:11:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
 <aZhsIVa2TJ9-bMhj@fedora>
In-Reply-To: <aZhsIVa2TJ9-bMhj@fedora>
From: Xiao Ni <xni@redhat.com>
Date: Sat, 21 Feb 2026 17:11:45 +0800
X-Gm-Features: AaiRm53ma7jtT6vamly0SrGhEI1ssRVkr2jsQhQTJq5DZzr5sP6W0rlDwudIYu0
Message-ID: <CALTww2_8B=rZbGgJCDjG7bqa64RfE3tK9MdCKkJBzW8qXomkdQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
To: Ming Lei <ming.lei@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org, 
	Caleb Sander Mateos <csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 10:14=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Hi Xiao,
>
> On Thu, Feb 19, 2026 at 01:38:46PM +0800, Xiao Ni wrote:
> > Hi all
> >
> > I'm doing some work on user-space RAID recently. I'd like to propose a
> > topic for LSF/MM 2026 regarding the implementation of RAID5 in user
> > space using ublk and io_uring bpf[1], particularly focusing on the
> > challenges encountered and potential kernel improvements needed.
> >
> > Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
> > with the goal of leveraging io_uring's zero-copy capabilities and
> > BPF[1] for performance optimization. The implementation includes:
> > * RAID5 stripe handling with configurable chunk sizes
> > * Multi-queue support via io_uring
> > * Degraded mode for single disk failure tolerance
> > * Integration with io_uring BPF struct_ops framework
> >
> > During the implementation, I encountered several technical challenges.
> > The primary challenge is performing XOR parity calculations in a true
> > zero-copy manner:
> >
> > 1. Bpf program support
> > Raid5 needs to calculate parity with data. Now io_uring already
> > supports zero copy. For targets such as raid0/raid1, it's enough. But
> > for targets such as raid5, it still needs to copy data to userspace
> > and calculate the parity. Bpf program is a nice solution[1] to resolve
> > this issue. Besides the patch set[1], it still needs another bpf kfunc
> > uring_bpf_xor() support.
> >
> > 2. Register buffer per io
> > Raid5 needs to calculate parity with data. So it still needs to
> > pre-alloc buffer and register it for each io. The total memory is
> > controlled by queue number and queue depth. With the pre-alloc memory
> > and bpf program support, target such as raid5 can support true
> > zero-copy manner.
> >
> > Question for discussion:
> > * Should the kernel provide XOR operation kfuncs for io_uring BPF?
> > * What would be the appropriate API design?
> > * Are there security or verification concerns with BPF performing XOR
> > on registered buffers?
> >
> > Current Status:
> > * Basic RAID5 functionality: implemented
> > * BPF struct_ops framework: successfully integrated
> > * Performance testing: in progress
> > * Main blocker: zero-copy XOR implementation waiting for kernel
> > support I've written a patch for testing based on [1]
> >
> > Why this matters
> > User-space block devices (ublk) offer several advantages:
> > * Faster development and iteration
> > * Easier debugging
> > *  Ability to leverage user-space libraries
> > * No kernel panic risks during development
> > * Easy to evaluate/compare performance between kernel raid and ublk
> > based userspace raid.
> >
> > Desired Outcome
> > * If proposal in [1] would be acceptable
> > * Get feedback on whether `uring_bpf_xor()` kfunc would be acceptable
> > * Discuss API design for BPF-based computation on io_uring buffers
> > * Understand the roadmap for io_uring + BPF capabilities
> > * Learn best practices from the community for similar implementations
>
> I am interested in this topic, and looks Caleb Sander Mateos has similar
> requirement too.

Hi Ming

Thanks and any suggestion is welcome :)

Best Regards
Xiao
>
>
> Thanks,
> Ming
>

