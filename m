Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8C407592
	for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273243; cv=none; b=P4TJigJNIqz3kVAURjxKy2tjdHMEL2g8/JbE6g+Fswu1HsaHuR/fPTE4S3B/TkahZIngZAKqyCV1zxnObFFk78lNo2UuVG5XdY8yP1dWZEI0iWgyilkquF/8DSHv8cdR8e7mB8nqm5oGMA1mrDHnYc0WevYVjC/xNWOrThHv3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273243; c=relaxed/simple;
	bh=r7FrafWFLD75BwaFOEQnoS752Vpr4ZJJUsd0QyvHunQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxvovLLWB+ZAZY/NPGEP1OmCncuZf62xzzeGD/TSnJD5cqHp0WMwpSWEEFd1b0Vq+QxFAJs9pGAyiotjOwgHEFwq9eOwGvGWyk6ao9H4S5U32hM57dHY934qk5fcMlSL99aFKw+x/+eiFvRQ8qo/6/iD5ac78eMUjaSaJdi75Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfFY4hzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfFY4hzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772273240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vFPCx8t+IBcgP1koaAFrhpXMtwWz8NFTHfWqMoUUzw=;
	b=cfFY4hzJHNucMZX0bmhaj2DyPb2+syjp8BwPKCSXcZCkY8HnMykkrOCv1KDgRYv+8PzNzU
	FEr8qpSsABJXCVr4muOL41m8PQdASeCPQ7gsidglH45q8nn5YZ+bSmb+MnXfp0+UJ9/xcJ
	VWfYgRxI4/18hvO5v4W8gvwcwzV20K8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-yUc4HU0YOhOgkzWemRya3g-1; Sat,
 28 Feb 2026 05:07:16 -0500
X-MC-Unique: yUc4HU0YOhOgkzWemRya3g-1
X-Mimecast-MFC-AGG-ID: yUc4HU0YOhOgkzWemRya3g_1772273235
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EBB31800366;
	Sat, 28 Feb 2026 10:07:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.144])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EFCC1800370;
	Sat, 28 Feb 2026 10:07:11 +0000 (UTC)
Date: Sat, 28 Feb 2026 18:07:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ublk: document partition flags, kublk and update
 external links
Message-ID: <aaK-S2TsKxdVpny_@fedora>
References: <20260227145756.3877069-1-alex@zazolabs.com>
 <20260227145756.3877069-4-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227145756.3877069-4-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Feb 27, 2026 at 02:57:55PM +0000, Alexander Atanasov wrote:
> Add section about partition handling on ublk devices.
> Document UBLK_F_NO_PARTITIONS and UBLK_F_NO_AUTO_PART_SCAN.
> 
> Add section for kublk to be used as reference.
> 
> Update extenal github links - repos have moved to ublk-org
> and README is renamed to README.rst
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

