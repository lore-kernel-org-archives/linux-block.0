Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8681720
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450823; cv=none; b=HUk4aBNwvUqT30lLXLdP1N2RJJksLZXV21RuV4rktHx43XnxVf4YvnXel8tA9OFLelQK8uu+J29W85ksaf1CTEfS5NLH7SS3ccjl7WNX/NsOckwmr7S3PsaazIXdyTl8RFeJvNFq0SvwB9K0whTb0qIS+/QacyG6M7mYUMtNbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450823; c=relaxed/simple;
	bh=LCOBpCj68Sjolavpnaixk0A3OhUadkZRuV2eEHhqp/E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atbp1YuJy1ScjrnH3p+Zmx38ch4ZrwS+WmTvZRsCvMKj/BHIfMpy8tt5S/bJxTGTwIRx8c/vD11y65gvKEYRrEMuhzcqrEezfLUjchPJY4C+EqAONpORTJZ0RdnYfoARwq7VOeV0jrYHSsv3MdbUKbPLyj5/20+rRqsM7jF61BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOKEX4Gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOKEX4Gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741450820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B1ve0Yxk7Yvvic5Sydn/sQ2wggF9rVdA1PZiIqnQfkE=;
	b=QOKEX4GgRJL/5GAC9EKRdHz9d69eT9NbrZco5KsYB0Nq9ylIYLP2MKSQeJ5IsQbFrDqVYm
	cS/QYj65xOS1ofmsk4PJ/XLLHBIxgyrz3lOOyuz0MM+oXKVbL8kHxOeNgB32AbEL/9Lxvk
	LaYgzArOmfnLeYxDcpIvChUjrA1YrTA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-yU8V4MyoP8S6b8-2YIWsbw-1; Sat,
 08 Mar 2025 11:20:17 -0500
X-MC-Unique: yU8V4MyoP8S6b8-2YIWsbw-1
X-Mimecast-MFC-AGG-ID: yU8V4MyoP8S6b8-2YIWsbw_1741450816
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B3A01801A00;
	Sat,  8 Mar 2025 16:20:16 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2689195608F;
	Sat,  8 Mar 2025 16:20:13 +0000 (UTC)
Date: Sun, 9 Mar 2025 00:20:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <Z8xuN2mk8ZBFIq0s@fedora>
References: <20250308161504.1639157-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308161504.1639157-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Mar 09, 2025 at 12:14:50AM +0800, Ming Lei wrote:
> Hello Jens,
> 
> This patchset improves loop aio perf by using IOCB_NOWAIT for avoiding to queue aio
> command to workqueue context, meantime refactor lo_rw_aio() a bit.
> 
> The last patch adds MQ support, which improves perf a bit in case of multiple
> IO jobs.
> 
> In my test VM, loop disk perf becomes very close to perf of the backing block
> device(nvme/mq virtio-scsi).
> 
> Thanks,
> Ming

Please ignore this patchset, since several unrelated patches are included
accidentally.


Thanks,
Ming

