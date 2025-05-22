Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70EF9DA
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931798; cv=none; b=Cikkp+N9dtQEC5impeXlkbwIdTsZ9chrFp/mFodbJM2BfiD2s+Ndi/zsF+PPI+zHDDf8wayxXA6yWcxKSRqoooS2gMneF9eZ92t5HqAbyj0ldO3MKLtlqn15qtxbVzju49nU6GFym6/p1qs4gtDKgXHnbDwfQ7wJwWFEDod+Ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931798; c=relaxed/simple;
	bh=E8/QcLlLRZf01wrR3Tv226Ivf2qRsP7sVaDSpN3SQts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1g7k+OGnEJ3+cdLGuWdzBjSU+aV+ehm7uT7yKxzThu56iYt+q1bbECyW8TC1e6hqSMMIRkec6SX4bnK8UOa5EB67LpnhKVYjHAc4FlBrOO/RJc3UNS3CnLOA3jHo9GSJjcmHUneYdEvSDoCJsBz5TlTxyw63W+uZcQiW/UzrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBmaFJAA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBmaFJAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747931796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDGP8EBDLVtel446JgA4i79D48Avvx+YDEeWMkgWhWM=;
	b=FBmaFJAAykqZYrG9OODM0mZuwpd7ui+nvuHLyuu6/Gl8yCMLqe+rt5RIXF0kslKN1sVaX5
	jCbFDfJTsMnKUt0g2HAAjLgvJTMhDfW8JS/IDBvgLAXYl/UZpwXtIPZNmobrixMeSdYjy8
	iaNy5Ef7xEFjnjiultvfG82wMZJ/xvk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-ewzaQSGpPRuv4WBjdA9h-Q-1; Thu,
 22 May 2025 12:36:34 -0400
X-MC-Unique: ewzaQSGpPRuv4WBjdA9h-Q-1
X-Mimecast-MFC-AGG-ID: ewzaQSGpPRuv4WBjdA9h-Q_1747931794
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6E1D1956094;
	Thu, 22 May 2025 16:36:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 970C519560AF;
	Thu, 22 May 2025 16:36:30 +0000 (UTC)
Date: Fri, 23 May 2025 00:36:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] loop: add fs_start_write() and fs_end_write()
Message-ID: <aC9SiaBxtf7rHZyS@fedora>
References: <20250522143547.395304-1-ming.lei@redhat.com>
 <CADUfDZo0D4GBEAQSTbaD4Dr-_fUq0oPg8-Tq3njPbFQwfyg7Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo0D4GBEAQSTbaD4Dr-_fUq0oPg8-Tq3njPbFQwfyg7Tw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, May 22, 2025 at 08:31:41AM -0700, Caleb Sander Mateos wrote:
> On Thu, May 22, 2025 at 7:37 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > fs_start_write() and fs_end_write() should be added around ->write_iter().
> 
> Do you mean file_start_write() and file_end_write()?

Yeah, will change it if V2 is needed.

Thanks,
Ming

