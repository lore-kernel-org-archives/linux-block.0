Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB351344050
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596859; cv=none; b=Atlh83lupb2sDaJ2C47T8ZP+agkhHv7553+/aK+bYQLujPwYGvqHVrj5ykqgnau0MchXa8R2xXhTfBjhwvhcbl7DlFdKNQjfej/hJ2fjSYxXy3TGUsI9DyAUHB4r0xjp71Lhc585wJbljBblmU5W6E/ZooDb4rItvIx+FJafeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596859; c=relaxed/simple;
	bh=v80JkCPVzhXzhoeBRwlLhfn9tS3CbYzDQEhYPgC8/cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+EXEfS/eUJrNhmnLdK0vS8r81wqLPFIsPeH07bhj/Os7i6blWQCp2l0JRAtoKyBbv9YxxA+pbxerOoMQNAcVeduvy9Mjqo9W7taBbdGqtH8EuuKDLm/ikYlCy0jZwKLPwkvbaMvgCjES1nAw2RRNdJyQ2W7/CzXeVL99uxWT0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtdYLq+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtdYLq+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771596856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xlvVlAc4De5O6CGGQkhYnkfj//p44jm65jlYo4krZv8=;
	b=UtdYLq+W3NzG4wIVFBDNUKVLcNAjEvUoXFboBgj8YJGddvKq1hDM+38uy3bAksNHWTW5ze
	VB+DdMII0ev2ME0Yg9a2gASa/5e/pnRC4Sss470kZ6lnKsfFQCg5gjJ5eajrhqrvtJwXZ2
	+jSxchZW+Z2YOBJuc38sf8znVsRgyas=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-hcCoDzB9MnCY64QMM7u8uQ-1; Fri,
 20 Feb 2026 09:14:15 -0500
X-MC-Unique: hcCoDzB9MnCY64QMM7u8uQ-1
X-Mimecast-MFC-AGG-ID: hcCoDzB9MnCY64QMM7u8uQ_1771596854
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 896B4195609E;
	Fri, 20 Feb 2026 14:14:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DB61195419E;
	Fri, 20 Feb 2026 14:14:04 +0000 (UTC)
Date: Fri, 20 Feb 2026 22:13:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Xiao Ni <xni@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
Message-ID: <aZhsIVa2TJ9-bMhj@fedora>
References: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Xiao,

On Thu, Feb 19, 2026 at 01:38:46PM +0800, Xiao Ni wrote:
> Hi all
> 
> I'm doing some work on user-space RAID recently. I'd like to propose a
> topic for LSF/MM 2026 regarding the implementation of RAID5 in user
> space using ublk and io_uring bpf[1], particularly focusing on the
> challenges encountered and potential kernel improvements needed.
> 
> Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
> with the goal of leveraging io_uring's zero-copy capabilities and
> BPF[1] for performance optimization. The implementation includes:
> * RAID5 stripe handling with configurable chunk sizes
> * Multi-queue support via io_uring
> * Degraded mode for single disk failure tolerance
> * Integration with io_uring BPF struct_ops framework
> 
> During the implementation, I encountered several technical challenges.
> The primary challenge is performing XOR parity calculations in a true
> zero-copy manner:
> 
> 1. Bpf program support
> Raid5 needs to calculate parity with data. Now io_uring already
> supports zero copy. For targets such as raid0/raid1, it's enough. But
> for targets such as raid5, it still needs to copy data to userspace
> and calculate the parity. Bpf program is a nice solution[1] to resolve
> this issue. Besides the patch set[1], it still needs another bpf kfunc
> uring_bpf_xor() support.
> 
> 2. Register buffer per io
> Raid5 needs to calculate parity with data. So it still needs to
> pre-alloc buffer and register it for each io. The total memory is
> controlled by queue number and queue depth. With the pre-alloc memory
> and bpf program support, target such as raid5 can support true
> zero-copy manner.
> 
> Question for discussion:
> * Should the kernel provide XOR operation kfuncs for io_uring BPF?
> * What would be the appropriate API design?
> * Are there security or verification concerns with BPF performing XOR
> on registered buffers?
> 
> Current Status:
> * Basic RAID5 functionality: implemented
> * BPF struct_ops framework: successfully integrated
> * Performance testing: in progress
> * Main blocker: zero-copy XOR implementation waiting for kernel
> support I've written a patch for testing based on [1]
> 
> Why this matters
> User-space block devices (ublk) offer several advantages:
> * Faster development and iteration
> * Easier debugging
> *  Ability to leverage user-space libraries
> * No kernel panic risks during development
> * Easy to evaluate/compare performance between kernel raid and ublk
> based userspace raid.
> 
> Desired Outcome
> * If proposal in [1] would be acceptable
> * Get feedback on whether `uring_bpf_xor()` kfunc would be acceptable
> * Discuss API design for BPF-based computation on io_uring buffers
> * Understand the roadmap for io_uring + BPF capabilities
> * Learn best practices from the community for similar implementations

I am interested in this topic, and looks Caleb Sander Mateos has similar
requirement too.


Thanks,
Ming

