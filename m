Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C2221731
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744767565; cv=none; b=pHUiiKDCCWWYD4niB+xpjNxrzk/TTUImWdPA0pXMe285MrjBPM2SA20oYjOyQ+7JChUhTg9AYhKezpxv0n8VAIlYTSEKgm1LF7fmdbBYuClcTXuKRJQVcCLemI6DJZ9TMlZ0blCjn6R2zp/xaIJ6aavLXpnwUD5ALs9/5BFl/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744767565; c=relaxed/simple;
	bh=fVJaK2bnIJQnzdjq884fcHjuN/S9eGWwEBEXziHHlJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtfwUatncyh4dDjjxcSX2rM+SYXi4dPdzmqUPiuKYtrBcFBfSI0YACImGwSJh5Yb8BV8uHKUPu29BVwdjLtYATgOjf45pFRgf5GJcah8HpVhs6VHTa42WU+kQ73VDPCDGb7s6R5lLCHzhlB3T3KQ5MJUPbVUS1jyx6MruEIbXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iv6HTwyy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iv6HTwyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744767561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lWJvtE2yVM+pSYwHCDbf4OjqJQMOiKHWyefO6Wue7k=;
	b=Iv6HTwyyd/tV184FcXLkTBz6y6UjnvsiLTRXqDu/vnO5bTTyPPfQTfg8NT2lsJIEmEpmnq
	asf4fTp/AzcAtXkOh3ZqJcnIrJXFUZPJ4NNxCGb8WEk2COP7vO0zq+r9ziLTWAAaqI0l+T
	+0gakKsVjuNAhP46P5o3hJBxmtbPUpA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-3t2ceug_OFauwRhPpQEo_w-1; Tue,
 15 Apr 2025 21:39:17 -0400
X-MC-Unique: 3t2ceug_OFauwRhPpQEo_w-1
X-Mimecast-MFC-AGG-ID: 3t2ceug_OFauwRhPpQEo_w_1744767557
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9A09180035C;
	Wed, 16 Apr 2025 01:39:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55EE819560AD;
	Wed, 16 Apr 2025 01:39:12 +0000 (UTC)
Date: Wed, 16 Apr 2025 09:39:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Yoav Cohen <yoav@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: ublk: Graceful Upgrade of ublk server application
Message-ID: <Z_8KO5uJfkB-SKvT@fedora>
References: <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_49m8awtNFsY8pl@fedora>
 <DM4PR12MB63285A6617D8A9B9F22B912BA9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z/7/LTSxqLH7JgAl@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/7/LTSxqLH7JgAl@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Apr 15, 2025 at 06:51:57PM -0600, Uday Shankar wrote:
> On Tue, Apr 15, 2025 at 07:46:51PM +0000, Yoav Cohen wrote:
> > Hi Ming,
> > 
> > Thank you for the fast reply.

oops, looks I didn't get your reply, :-(

> > To be clear, I don't want calling DELETE_DEV or STOP_DEV as I want the kernel bdev will be stay while upgrading the ublk server application.

Can you explain a bit what is upgrading? Is it simple application binary
replacement?

> > It would be nice to have a nice way to have something like FREEZE_DEV that we may use which will also make all the cmds back with ABORT result but both block and char device will be stay until a new userspace application will reconnect.
> 

Looks one reasonable requirement, maybe SUSPEND_DEV and RESUME_DEV command,
which exists on RAID/DM too.

Also when device is in (new)suspended state, parameter can be re-configured.

Most of recover code can be reused, in theory it shouldn't be hard to
support, but one trouble could be what if both uring exiting and SUSPEND_DEV
happen at the same time? This corner case need to be take into account. 

I'd suggest to cover more requirements given it should be one generic
interface.

> Have you taken a look at the recovery flags? These offer slightly
> different behaviors around how I/O is handled while the ublk server is
> dying/when it is dead, but they all keep the block device up even after
> the ublk server exits.
> 
> The flags are documented at https://docs.kernel.org/block/ublk.html

The recovery mechanism is triggered passively, and here the upgrading
needs to suspend device voluntarily & gracefully.

Maybe add one control command of COOP_CANCEL_FOR_RECOVERY or ABORT_URING_CMD
to abort active uring_cmd for triggering recovery from userspace? Which looks
much easier. But it need cooperation between ublk driver and server.


Thanks,
Ming

