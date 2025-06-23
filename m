Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C2B663
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 02:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750644830; cv=none; b=ExX/sn17rW55bTX/urua22nXyJU3rO5OqOeN5kd5t2QFF+FmG7y0Pob3gnbePX0M78iiaU/L4QjtWZFENuKYOocN+HgBjRs8n0/KXumucCg54X2vcFynwtmy7i13kHJa7via8X1BMvoRGOaijeFqbrzUWcVpXcRSphsqRpRB9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750644830; c=relaxed/simple;
	bh=wHfg+4KacDx3C2EUrMoqez3JE327RNb2BGSNw+aBXTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVDDPzC+z/ygl+irwjO/cypmWwUYOYj+1uS+K7wVJiHuQcqOHBCl9mJq5Jk68p9ntBngmrhCZL455Hk+j3iXZ6+k0y7X/io5MfqdpGLA8EPdg7x50wB7EGj1MWwY3XxjcIw0cktX4rJNjQ5VrthPvI5NOfhSZG0rYmRPk9R/L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aswetLir; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aswetLir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750644827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sj+OxDIqRQWvvPOtCRF3f1c+T40zaAeLU0Ma+vTjujc=;
	b=aswetLiri1Jtkl23CKVRA1T91xyLNr4ryeK6Y2M7ppL/pi8sgpXL3dor70usFmOtnpJOJ6
	3dNcjeOVxvebVioEPThAwgSZw96C+1sbwmlzw0JtHFBt7A9HgqzA/k3YxhflVu3Bp9r5dG
	3aXY4f9JWH7YRiN0jkFjNMdmjOLOeUs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-NSpttJjBP1eRHtCF2tVqTQ-1; Sun,
 22 Jun 2025 22:13:44 -0400
X-MC-Unique: NSpttJjBP1eRHtCF2tVqTQ-1
X-Mimecast-MFC-AGG-ID: NSpttJjBP1eRHtCF2tVqTQ_1750644823
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CA9D19560AE;
	Mon, 23 Jun 2025 02:13:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82509195608D;
	Mon, 23 Jun 2025 02:13:38 +0000 (UTC)
Date: Mon, 23 Jun 2025 10:13:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Message-ID: <aFi4TYy2q5BoaoPl@fedora>
References: <20250522163523.406289-1-ming.lei@redhat.com>
 <20250522163523.406289-3-ming.lei@redhat.com>
 <DM4PR12MB6328039487A411B3AF0C678BA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEK6uZBU1qeJLmXe@fedora>
 <DM4PR12MB6328BB31153930B5D0F3A3C7A968A@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEWfWynspv75UJlZ@fedora>
 <DM4PR12MB63280BC70C29A91E973E8080A974A@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEqanYVjHgVOjcwR@fedora>
 <DM4PR12MB63285592EDAA9C03DB1D6BFCA974A@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB63285592EDAA9C03DB1D6BFCA974A@DM4PR12MB6328.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 12, 2025 at 12:04:39PM +0000, Yoav Cohen wrote:
> 
> Hi Ming,
> 
> So I know it's a radical situation but my only concern is that:
> 
> 0) On our application timeout of IO may be set to few minutes as it is goes over the network.
> 1) Let's assume we have 1 queue with QD=1.
> 2) the Only IO is in the userspace application but as we send the IOs over the network it may be stuck due to connectivy issues.
> 3) User trying to upgrade/stop the application so we issue Quiesce_DEV with infinite timeout as we want to ensure it works.
> 4) We are stuck now until network connection will recover or Our datapath will somehow Issue the COMMIT_AND_FETCH back to to the kernel so it we can get the ABORT later and QUICESE_DEV can finish.
> 
> Problem is that I don't want to wait for this IO until recovery but on the other end I don't want to complete the IO with error to the user.
> So on this case I guess we can abort the application or something but maybe it will be cleaner that on Quiesce_DEV will need to issue another SQE per queue or something so we can notify the application this way about it.
> 
> Anyway also on our case it will be super rare to happen where there is a queue without an idle operation + network is currently down but we try to be complete as possible.
> What do you think?

Hi Yoav,

The multishot approach for fetching io command should address the issue
wrt. single queue depth case:

https://github.com/ming1/linux/commits/ublk2-cmd-batch.v3/

In which there is always one multishot FETCH_IO_CMDS for notifying ublk
server for new io commands(requests) in batch way.


Thanks, 
Ming

