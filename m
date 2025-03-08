Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DD11DE3C3
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450684; cv=none; b=HmOk3mJXtNFDjxJwb2gDwregzEeYlCOyQcPkzUK32Z6CarVfiMCn8gzsvCtTdq97CJ+whk7fuHPcFYTOC/A6xWAqItcdFDyK10Rnms49c7eH5yLqDNaTheOn/dg2ZAX3jaVzGj+tkS677FOZ3LXDdlVacu4T6iFPloXHAKsw5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450684; c=relaxed/simple;
	bh=6rgAATNpbrHWAyf3nmp89tHFjdnvE1wf/zEqgljc+Wk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bow/7Z/B9BCf/gbYCo/Rah6AGp9NsiyXeXMJXxScEww4fcBi8L7aHLF/3Co9K9oXF941Bq/P+mtiwgMS36vuEPThpv2Ysa8uR+ZqSQoR787UWxyohzehv/63zq1jrxFsJ73A7teDmUVi4/81lVJ2X2cnePEsgTkFD91aC7z+Psc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7GfZDRJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7GfZDRJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741450681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZI83pNIJgRMtOtpiPEX53vVUj4S3RCVxFTA7DIwLyg=;
	b=L7GfZDRJaogFHMqS2O3MY98FQt/Q2N0ZgziNzoobiXrl7DEM0n71hutbLiiOzrkWsPYAbU
	58oXfyyHSt00ZJvTWspE0VBjdJW37aZGb62BhlNV2wG9eHBzu9bjE+txwNe72msd6aO9aV
	JxneRF2AGDIsxfdLum3zdw6OzJQCoOs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-Gjd99XUNPfSfmskBoUdfhA-1; Sat,
 08 Mar 2025 11:17:59 -0500
X-MC-Unique: Gjd99XUNPfSfmskBoUdfhA-1
X-Mimecast-MFC-AGG-ID: Gjd99XUNPfSfmskBoUdfhA_1741450679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDBC71800258;
	Sat,  8 Mar 2025 16:17:58 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449A3180174F;
	Sat,  8 Mar 2025 16:17:55 +0000 (UTC)
Date: Sun, 9 Mar 2025 00:17:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: loop: share code of reread partitions
Message-ID: <Z8xtrnFu5WEob69o@fedora>
References: <20250308161504.1639157-1-ming.lei@redhat.com>
 <20250308161504.1639157-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308161504.1639157-2-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Mar 09, 2025 at 12:14:51AM +0800, Ming Lei wrote:
> loop_reread_partitions() has been there for rereading partitions, so
> replace the open code in __loop_clr_fd() with loop_reread_partitions()
> by passing 'locked' parameter.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

oops, please ignore this one.


Thanks,
Ming

