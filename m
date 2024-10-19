Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C8646
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350225; cv=none; b=U7FCiDEBVHPJEj42EJsz0YxPGVLdvxfqmGbdYFNKF3Gvmr987V27UfzaQx4mm+JkTuVA8HdJ366tcCNevvyNqlYQYjyIk+IuhPkY08hyJokTBumWdvktIeENRmpTvgkmguu4maLDLaTaTgEx4zGYoDAe99pJDu6wwQ1uVumNWe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350225; c=relaxed/simple;
	bh=xgGJ41ET2qYtevxt/n6WlO7XjdpJC3EYiJ+iD9eQe5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl1zj8P/ozldEtiIKiMpWKdImQF1WSX7Ap3/zEldHJNXT1BAJQy6xLAGGOaWirH/5YjngpjP/3NfM/5NSiNkP++pH1XZPKpKPXR8tOBT0SuHOvIxDUuyLRVw5a6Nwl92ITKzkX2OmJI+PBPgJ9ZsobmUe+L7DgetOLsp3e6+Hf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc5RcGmz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc5RcGmz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729350222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PDk4Lc//Q3E8TWoq6NHSFSQSdxX2bviUkhNv31txiI=;
	b=Sc5RcGmzBA9OwQTy3mo0GvQE0d2Y08eoSzTGXrpHzbqJlEbZf8hoKU5h1/+fEagVvVFIzr
	sua/xmtVfke4XSzRfn0y+r4lSPQLn2HrlNJQW1CjghEtizVSHEfdOeuftZ69sPBSAls5Ng
	7djScKuakJCQrX4ZgZQPQ3gAT3L78R4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-HtEt1gloMceWPkuB2Dh0GA-1; Sat,
 19 Oct 2024 11:03:38 -0400
X-MC-Unique: HtEt1gloMceWPkuB2Dh0GA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C7FB1956089;
	Sat, 19 Oct 2024 15:03:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E9C219560A2;
	Sat, 19 Oct 2024 15:03:32 +0000 (UTC)
Date: Sat, 19 Oct 2024 23:03:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <ZxPKP8SEb7Y4ceOq@fedora>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
 <20241019123727.GE1279924@google.com>
 <ZxOrGeZnI52LcGWF@fedora>
 <20241019125804.GF1279924@google.com>
 <ZxOvfpI6vgH5oXjg@fedora>
 <20241019135010.GG1279924@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019135010.GG1279924@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Oct 19, 2024 at 10:50:10PM +0900, Sergey Senozhatsky wrote:
> On (24/10/19 21:09), Ming Lei wrote:
> > On Sat, Oct 19, 2024 at 09:58:04PM +0900, Sergey Senozhatsky wrote:
> > > On (24/10/19 20:50), Ming Lei wrote:
> > > > On Sat, Oct 19, 2024 at 09:37:27PM +0900, Sergey Senozhatsky wrote:
> [..]
> > 
> > Then we need to root-cause it first.
> > 
> > If you can reproduce it
> 
> I cannot.
> 
> All I'm having are backtraces from various crash reports, I posted
> some of them earlier [1] (and in that entire thread).  This loos like
> close()->bio_queue_enter() vs usb_disconnect()->del_gendisk() deadlock,
> and del_gendisk() cannot drain.  Doing drain under the same lock, that
> things we want to drain currently hold, looks troublesome in general.
> 
> [1] https://lore.kernel.org/linux-block/20241008051948.GB10794@google.com

Probably bio_queue_enter() waits for runtime PM, and the queue is in
->pm_only state, and BLK_MQ_REQ_PM isn't passed actually from
ioctl_internal_command() <- scsi_set_medium_removal().

And if you have vmcore collected, it shouldn't be not hard to root cause.

Also I'd suggest to collect intact related dmesg log in future, instead of
providing selective log, such as, there isn't even kernel version...


Thanks,
Ming

