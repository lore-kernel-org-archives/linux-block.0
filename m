Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1978F59
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688037; cv=none; b=QLnNv3B205putMCKnYYEE4fNYidwrE6Zd1p7rHugLtHxXJlrHIcpG3zf2SwBbX51CTX8wuSrwEjECl+NnVIpr3kHDoR+2ASN7Bwj4Qc3waRDz88S6rrvrRbN6cwQWImRfr9IWAs1RpfEvwQ93yxPpi8mjN4Gd7GCtLEKaNCwk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688037; c=relaxed/simple;
	bh=tDjBCpqAycGisTZIQyHYZjGpH2iOiXQYIOLz7Zxu3S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0kZ1oOGgyi55UZEfAK8PJaQkQsGJECw/yDOqQect97BKIGqKrKr2crX7FMurGd/8gvd9npeXx5K5ajLL1ovan6bEjBNAfbJkQmTOcOsaYfQU3Lf9HvMl88epmVKE7icc6FYCEv1gLxZNhHPlOsfody1YOEi3BbQNNeWag+WsNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkQaAbnt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkQaAbnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744688034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw7QxfLhfEwSLIjVFrjLePWqJnd85P/46B8/AlvysjI=;
	b=VkQaAbntOSQhzOpRYfJtQ+eX4Ge08vxuGU5OVmheqm9Pe5ivdy85QLIbvXc8F4qg5B8+Wb
	tNM1HC89ggwJ7a1AsOE5yK8ZeukTqGlt0LSEivsfKLXggZDAejgcibARAhMkwjdfL3O0pm
	fzQcz+eyQ2mBw/ZvVBfDn915aBJMLPw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Sicnh_p6Mfea7ODT1sbOBg-1; Mon,
 14 Apr 2025 23:33:52 -0400
X-MC-Unique: Sicnh_p6Mfea7ODT1sbOBg-1
X-Mimecast-MFC-AGG-ID: Sicnh_p6Mfea7ODT1sbOBg_1744688031
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42FB8180049D;
	Tue, 15 Apr 2025 03:33:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C146B180175D;
	Tue, 15 Apr 2025 03:33:47 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:33:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, djwong@kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: stop using vfs_iter_{read,write} for buffered I/O
Message-ID: <Z_3TlhSs1c5sYkiY@fedora>
References: <20250409130940.3685677-1-hch@lst.de>
 <Z_Z5ydIl7UGkFrz6@fedora>
 <20250410073439.GA461@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410073439.GA461@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Apr 10, 2025 at 09:34:39AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 09, 2025 at 09:44:41PM +0800, Ming Lei wrote:
> > On Wed, Apr 09, 2025 at 03:09:40PM +0200, Christoph Hellwig wrote:
> > > vfs_iter_{read,write} always perform direct I/O when the file has the
> > > O_DIRECT flag set, which breaks disabling direct I/O using the
> > > LOOP_SET_STATUS / LOOP_SET_STATUS64 ioctls.
> > 
> > So dio is disabled automatically because lo_offset is changed in
> > LOOP_SET_STATUS, but backing file is still opened with O_DIRECT,
> > then dio fails?
> > 
> > But Darrick reports it is caused by changing sector size, instead of
> > LOOP_SET_STATUS.
> 
> LOOP_SET_STATUS changes the direct I/O flag.

It isn't true in the following test case.

> 
> This is the minimal reproducer, dev needs to be a 4k lba size device:
> 
> dev=/dev/nvme0n1
> 
> mkfs.xfs -f $dev
> mount $dev /mnt
> 
> truncate -s 30g /mnt/a
> losetup --direct-io=on -f --show /mnt/a
> losetup --direct-io=off /dev/loop0

direct I/O flag is changed by LOOP_SET_DIRECT_IO instead of LOOP_SET_STATUS.

losetup forgets the backfile is opened as O_DIRECT, and util-linux
need fix too, such as call F_GETFL/F_SETFL to clear O_DIRECT.

I guess it is hard to figure out one simple kernel fix to clear IOCB_DIRECT of
file->f_iocb_flags for backporting.


Thanks, 
Ming

