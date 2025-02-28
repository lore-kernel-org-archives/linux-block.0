Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1E8F6B
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731983; cv=none; b=XkDDi4IK7oSWSiOIdTKys0mSqSsWiuA/h4Egj9TRzN3mihT5EbL28ojccwnUcOH4MszYVu0Dd1iS3SICJ2VqPd9ySJRcPJgKPn5E/GIY5k0KZtU/JYX93q0dvt2lBYbC6uPn8kJXOiAPe/EqSQmvfVWS9FPN33ynjuRFeM+z6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731983; c=relaxed/simple;
	bh=uNpyDSD91dEgWRG7A0p7jn0exP42DN7yvkbI3wu6fx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhTcgOBldJGg0w8XuFA7kqtinfuYqBDWh9GfH3KwqOKhHc0MnCvIAu639V1v4G00hDgT2yQoLkR66PNomks8JrMPrP/cBzkWMfJChbZmceuydZmGk5zhcX04yTasJXWkuSiY5kYToTdSjuOTZMc+z1aH8gSaPWZs+pQDiJ1VobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vo3hn6nR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vo3hn6nR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740731981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYfh9WT+o2XKu5oja2IH2OKyNoHtk8il4vhpz9M/dB0=;
	b=Vo3hn6nRJCrpJhPwnoGsk9UnHXeYxaAD7dylRIikBI0JfwCp3zq2z+Vg8IXCS65pF+PyJD
	ki+IaOpxtlZF+fznWTrSc3r7WgtljM9GLuAHdx1A2rUZxvD3eTXTZY+Ob4AYpPuKCwpJHC
	S5MrHRV82Q1/bqvA9wzhDASf0wP/E5Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-uBrq8IP3MTK6kiawE6l1vg-1; Fri,
 28 Feb 2025 03:39:35 -0500
X-MC-Unique: uBrq8IP3MTK6kiawE6l1vg-1
X-Mimecast-MFC-AGG-ID: uBrq8IP3MTK6kiawE6l1vg_1740731974
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFE851800873;
	Fri, 28 Feb 2025 08:39:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE9BB1800371;
	Fri, 28 Feb 2025 08:39:27 +0000 (UTC)
Date: Fri, 28 Feb 2025 16:39:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv5 2/7] block: move q->sysfs_lock and queue-freeze under
 show/store method
Message-ID: <Z8F2OaeT6GowvnhL@fedora>
References: <20250226124006.1593985-1-nilay@linux.ibm.com>
 <20250226124006.1593985-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226124006.1593985-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Feb 26, 2025 at 06:09:55PM +0530, Nilay Shroff wrote:
> In preparation to further simplify and group sysfs attributes which
> don't require locking or require some form of locking other than q->
> limits_lock, move acquire/release of q->sysfs_lock and queue freeze/
> unfreeze under each attributes' respective show/store method.
> 
> While we are at it, also remove ->load_module() as it's used to load
> the module before queue is freezed. Now as we moved queue-freeze under
> ->store(), we could load module directly from the attributes' store
> method before we actually start freezing the queue. Currently, the
> ->load_module() is only used by "scheduler" attribute, so we now load
> the relevant elevator module before we start freezing the queue in
> elv_iosched_store().
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

