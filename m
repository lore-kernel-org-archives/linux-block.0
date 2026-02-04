Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10591246BB2
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167658; cv=none; b=s1/vwR/WdMY/UFWKq0AJJYrmiljxCssGhXsj0PYL1Fx04c1qzBc8uYgEnHUBwJpSws7NYI/UImw7nu0SH0kHba4NCtAg/uAVtn0QytwCiWLxXfbWKOn6KNxlyMdtCTIyfKrMK4gflfewzdPz5Whyhl27yYIbC1fhwD2wtiDLVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167658; c=relaxed/simple;
	bh=fF9rFqhkHvJdYOKnvNTQJArc4LvOk6gTNLR29UcpJQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeYiuPdp5Puzdhjxyq/6lyXSnIl3yKnApopCm5oZLDDOzD/UNi6eJVfx0G3R4KjtXZjI0bzuwqDPlfWSJkOkdzh8zygNEpcuCasxRpooWdf5Wd+R6/XRgpn3pQUiPkiFvbl+n6o28b2aEWoH4nKaO2oNV/210tJYxwv/6+BEkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKrEyDJi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKrEyDJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770167655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xjBRAILllbiil6uqa4uIRKWQgWlKn8ntrdvr6J4sf/I=;
	b=EKrEyDJi9v7achi5qPCJlCk+hNXT7sQq2HnYKR/UYmwxizK1IGujeVyqLnNpLiT3lRIpZH
	Jy4LKFWMQbROF80beHeVeJfzBXaon1yjphpN0ZbZva9zaVwLc+Cco4H1RP8z3hFq462qpb
	4J+DlCh0uVht1E4AvrcqCDckEg8u7CQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-KSNMtdGmMBKhM-Cfzgz2eA-1; Tue,
 03 Feb 2026 20:14:12 -0500
X-MC-Unique: KSNMtdGmMBKhM-Cfzgz2eA-1
X-Mimecast-MFC-AGG-ID: KSNMtdGmMBKhM-Cfzgz2eA_1770167651
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A99C180034F;
	Wed,  4 Feb 2026 01:14:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EABE1800109;
	Wed,  4 Feb 2026 01:14:07 +0000 (UTC)
Date: Wed, 4 Feb 2026 09:14:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BFP TOPIC] Block-layer device resets
Message-ID: <aYKdWsdnSVrZ3UC7@fedora>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <aYFoBafih46bLK0T@fedora>
 <65937263-912c-4250-af26-054b2b6be72b@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65937263-912c-4250-af26-054b2b6be72b@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Feb 03, 2026 at 06:51:25AM +0100, Hannes Reinecke wrote:
> On 2/3/26 04:14, Ming Lei wrote:
> > Hi Hannes,
> > 
> > On Sun, Feb 01, 2026 at 06:06:52PM +0100, Hannes Reinecke wrote:
> > > Hi all,
> > > 
> > > We are currently working on implementing cross-controller resets for
> > > NVMe, which requires to send a command to the target which then should
> > > terminate all commands on a given controller.
> > 
> > Can you provide a little background why this reset is required? And for
> > solve which problem?
> > 
> Sure. It got triggered by me wanting to use a ublk device as a backing
> device for nvmet namespace.

ublk supports it, either delete & re-add the disk or use UBLK_F_USER_RECOVERY &
UBLK_F_QUIESCE for keeping disk node.

> During a nvme reconnect the target is supposed to abort/flush all
> outstanding commands on the backing device. As this is a block device
> we would need to have an interface into the block layer allowing us
> to do so.

It could be hard to provide such generic(ioctl) block interface:

1) use queue freeze

- hang risk, because some or many block devices don't implement timeout or
error handling

2) use queue quiesce

- still need driver cooperation for draining the inflight IOs

Basically the hard part is in driver side.

Thanks,
Ming

