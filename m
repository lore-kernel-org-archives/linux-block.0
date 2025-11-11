Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711932D0EE
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829639; cv=none; b=GKkW7EHyV/vVXUvPyZCSzh3vkOzcDFr1Nu+Zz4+6m0y+Sgg6XKxZd+ibuUFAlsboCUHE4CnpqR/Y7MNbccKb8AL7eViOMKhMRKOnRq7GyI+5DqFbzCsk5RdbGPxMgrKc0m0rD/R3eG5Bhj3bXnD+0xv5ICpNLK3sUR3k8GBTtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829639; c=relaxed/simple;
	bh=3atscSA95EDLAHatrd2MucXWusRLVEj3dkEA98pSh58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0S2yLR8DIz0TPgaan7tRkkDYAd5aFlBgTiZM18YyHDM6VlF/OXTPCFLJfLe3PfqWppPE1T0hmOPdgrCoZ/G4k4sKIV4QhtNQ3lL2SkD29lqtKQH39wn/pv8izPsB7JwG3UNHeLLbYbjem/MxNnnVoBNwRmZiYR7bZMji0QnOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rjqdzkt9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjqdzkt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762829636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IU+NN+XGaSaTWAdfZcs0ImOP49qN+xgbKIWJBhleqUQ=;
	b=Rjqdzkt9Codai8UPN2wAXg8c1YopciypcL9NhWCnfSjhAmMDgTCiACIy+/VSSF7wXzjdfj
	5dOmvdThN6YT1Et1noBK0U34bE6ffFByFdCzwmzVXB8M6YrEXkMTN4d92VQ+krXR+FHqYc
	eTMYrmwLqzYJPb/5DnREzvEgfR3AFi0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-pz_CCmhcOzOsd_GAnSgn8w-1; Mon,
 10 Nov 2025 21:53:52 -0500
X-MC-Unique: pz_CCmhcOzOsd_GAnSgn8w-1
X-Mimecast-MFC-AGG-ID: pz_CCmhcOzOsd_GAnSgn8w_1762829631
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EF16180048E;
	Tue, 11 Nov 2025 02:53:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EC4D19560A2;
	Tue, 11 Nov 2025 02:53:44 +0000 (UTC)
Date: Tue, 11 Nov 2025 10:53:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv4 3/5] block: introduce alloc_sched_data and
 free_sched_data elevator methods
Message-ID: <aRKlNI6bJWA5FbJL@fedora>
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
 <20251110081457.1006206-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110081457.1006206-4-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 10, 2025 at 01:44:50PM +0530, Nilay Shroff wrote:
> The recent lockdep splat [1] highlights a potential deadlock risk
> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
> mutex. The trace shows that the issue occurs when the Kyber scheduler
> allocates dynamic memory for its elevator data during initialization.
> 
> To address this, introduce two new elevator operation callbacks:
> ->alloc_sched_data and ->free_sched_data. The subsequent patch would
> build upon these newly introduced methods to suppress lockdep splat[1].
> 
> [1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

