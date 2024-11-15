Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A41D5AA0
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685414; cv=none; b=Ut3WO7xICbuJ4WJwhmdpar81dSH+tsaB+513d0BuNNgRmDU5D2G9zn/3DR3xBoKaICdgKnZHxBgoEpi/lwNOOLZkNayXKXByyTEpTkRaBm3F4twnv+1e+EcjMe5Ltnze0I3p9g2y4CFHtJYwMeSgyg0b2v39mSAqaUDHY4q5uOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685414; c=relaxed/simple;
	bh=1qyFUaQBktu8yOtf8eX4mf98EtiN3o3Pb9HEcmvihBI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L0gVoFITmwfMN7yL5WvzTE6ypYzNL8uPJdiv0Ad5Ml+qT0iF8/R6hDCMw6kI24kK+28nLg88wFR9VbFYQr4s01840WQJQ+4RWME8YmjcUccnHsuUKZk6Tv9flRFRX9ppE8CnxmNMI3eoaEWCgllkOM9UDR5Ux40c7yvtRH4yvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTGeoY0/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTGeoY0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731685411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=miyu1cnSaJCJvT17HGrQe5RaBRja3jWYsTw+4Y3RWbg=;
	b=aTGeoY0/1RCnSdeils51aBjZLAHW6qKSFt9aiPORiHnQ7nJivkohJAqJryR4kBuJZIhZ1f
	VsOqv4FzQAK5rtQ14ge8XguWya2siI6Id0B/sR7rp3GX1AEzb80D5n2Dvt3R7cIU2yqK0/
	PRXcEYQDJ0SgBHvEErM32AC/qI5wCmY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-AUroYhlGPteRY2z9LWmzRg-1; Fri,
 15 Nov 2024 10:43:30 -0500
X-MC-Unique: AUroYhlGPteRY2z9LWmzRg-1
X-Mimecast-MFC-AGG-ID: AUroYhlGPteRY2z9LWmzRg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43EC51977323;
	Fri, 15 Nov 2024 15:43:29 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D927E19560A3;
	Fri, 15 Nov 2024 15:43:26 +0000 (UTC)
Date: Fri, 15 Nov 2024 09:43:24 -0600
From: Eric Blake <eblake@redhat.com>
To: linux-block@vger.kernel.org, nbd@other.debian.org, 
	Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: question on NBD idempotency
Message-ID: <2i75j4d6tt6aben6au4a3s63burx3kvtywhb3ecbh3w2eoallm@ye34afaah6ih>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20241002
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I'm trying to develop a Kubernetes CSI driver that, among other
things, will be creating and tearing down NBD connections to other
hosts in the cluster, and am looking for idempotency design ideas.
Right now, when you call `nbd-client $host 10809`, nbd-client uses the
netlink interface to allocate an unused /dev/nbd$N device and outputs
the name of the device it created, then the userspace process exits
(unless TLS is in use, in which case the userspace sticks around to do
TLS translation of the TCP traffic into plaintext over Unix socketpair
to the kernel).  That means that any later `nbd-client -c /dev/nbd$N`
can output the pid of a process that no longer exists (or, less
likely, has been recycled into use by an unrelated process), making it
very difficult to have a race-free implementation that will be able to
look up which server(s) are currently in use by which NBD device(s),
since I can't use /proc/$pid/cmdline to see what server I originally
connected to.

In one direction, if I try to create an NBD device first and then
record the device name in a k8s CR, I run the risk that the CR update
fails.  A second attempt to `nbd-client $host 10809` will NOT report
that the server is already in use, but happily allocate yet another
device, so the only safe thing to do is if the attempt to record the
device name in a CR fails, I must immediately call `nbd-client -d
/dev/nbd$N` rather than use the first device, to avoid leaking it.

In the other direction, if I successfully record which /dev/nbd$N is
tied to a server after the device is created (and tear down the client
device if my recording is not successful), then I have a race in the
opposite direction: when I know it is time to clean up the device
because the server is going (or has already gone) away, if I try to
call `nbd-client -d /dev/nbd$N` more than once, I risk closing an
unrelated device on the second call if someone else allocated the same
id to an unrelated server in the meantime.  I have to be careful that
I don't clean up the device more than once, while still balancing
competing cleanups (cleaning up both my mapping and the client); I
shouldn't delete my mapping until I know the device is gone (so I
don't leak the device), but if cleaning up my mapping fails on the
first attempt and I need to retry it later, the second attempt should
not retry deleting the device.

It is possible to use `nbd-client -L $host $ip /dev/nbd$N` where _I_
manage the device numbers instead of letting netlink do
auto-allocation, but then I'm risking a race in the opposite
direction: if any other process in the system is also trying to
allocate NBD devices, the name I thought was unused when I called
nbd-client could end up already tied to a different server in parallel
by that other process, at which point I'm no longer guaranteed that
/dev/nbd$N is connected to the server I want.  So I really _do_ want
to use the netlink interface.

Is there an existing set of ioctls where the creation of an NBD device
could associate a user-space tag with the device, and I can then later
query the device to get the tag back?  A finite-length string would be
awesome (I could store "nbd://$ip:$port/$export" as the tag on
creation, to know precisely which server the device is talking to),
but even an integer tag (32- or 64-bit) might be enough (it's easier
to choose an integer tag in the full 2^64 namespace that is unlikely
to cause collisions with other processes on the system, than it is to
avoid collisions in the limited first few $N of the /dev/nbd$N device
names chosen to pick the lowest unused integer first).  If not, would
it be worth adding such ioctls for the NBD driver?

Usage-wise, I'm envisioning something like `nbd-client --tag $mytag
$host $ip` which creates the kernel device, associates the tag with
it, and outputs /dev/nbd$N on success; then later `nbd-client --tag -c
/dev/nbd$N` to output the tag name in addition to the originating pid
if the NBD device is still connected to the server.  Maybe even have a
way for `nbd-client --tag $tag -d /dev/nbd$N` which either atomically
succeeds (if the device indeed has that tag) or fails (if the tag does
not match what was already associated with the device).

But if there are no such ioctls (and no desire to accept a patch to
add them), then it looks like I _have_ to use /dev/nbd$N as the tag
that I map back to server details, and just be extremely careful in my
bookkeeping that I'm not racing in such a way that creates leaked
devices or which closes unintended devices, regardless of whether
there are secondary failures in trying to do the k8s bookkeeping to
track the mappings.  Ideas on how I can make this more robust would be
appreciated (for example, maybe it is more reliable to use symlinks in
the filesystem as my data store of mapped tags, than to try and
directly rely on k8s CR updates to synchronize).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


