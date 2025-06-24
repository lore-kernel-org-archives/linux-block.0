Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9702D23BA
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774905; cv=none; b=ZXCR09gtAofSNQQUF37lPvfdDEpiSerNKPbOSWLNmDlEvkpmL8hnAq6BSabx8vFcyckflCxmhyl7aSOExeK2282XqbTEEHc5OxxIDYitM93DmhyaH/hXjkbmKqVjcbTcCMKcLMu/d8rklBDPP51CnbgLKsgQ6FbBpJQgNIoTFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774905; c=relaxed/simple;
	bh=XwnGdWQkYlApWdZit8M7GQi5s2uWr0s+SHL5bLPxKSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/fPHiKeO8o7+vq3FRixkoGlCKz+H59X3reMo0gFVACpyN3doVd9e8K8BjgdlLq+gKkWzlLgU5rEu7xDM4/Oj7BWfMtSWgfq+2Bmk3ZTGZFMux4ZKz4Xl4RxBRlqTPpzZ4Nytb/Pde9++47xrALxWredp9U+jwSk3cnq3Za+ESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKobWYRf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKobWYRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750774902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14xIxMy2YUHY1lgAeFKa78vWXvA9MuYA/3dz475p8Z8=;
	b=hKobWYRfivmKJbJ6L2X3QgN8kO0iUQmkvHkW4N3Z0My93c7qyYIgs6Lnq0eXFFWdhvSqfM
	sG+UErm6fsj3bsyEeEKOTwdzjLOhU5ihXryrHj6xchXZqNtksWFX5J4u/jXeNxAqwmgOes
	8Ldt7bzwwxg7cMhVJEiBhzrJXO8Pa/I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-hGP6hvCiNb-sjmbiglANbw-1; Tue, 24 Jun 2025 10:21:39 -0400
X-MC-Unique: hGP6hvCiNb-sjmbiglANbw-1
X-Mimecast-MFC-AGG-ID: hGP6hvCiNb-sjmbiglANbw_1750774899
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7cf6c53390eso435590685a.2
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 07:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774899; x=1751379699;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14xIxMy2YUHY1lgAeFKa78vWXvA9MuYA/3dz475p8Z8=;
        b=ja3nw6BvTOdsebAvvLlakxndMTm2/D/nbTtIZeixICSUMKRAZeE2keUpj/5O0AfANO
         9N2DrxTZmM6Yx70PjNF7jgqyR1EAtvDi+1salncdc32prIskW0j9CHIr0Q6Vx34yOrrM
         DZyjGPWqqc98J2GVUWBppkJPwxPqMVJhRpmJGFkt5dTC2XeLMt5A5v74J6fStQwQqpPm
         Q0qWdgptSKJj130z5qtkTFz6MEimlLD5/+3WB8Szk3+8KLc9Z/Lexy3ENZo1oc8fKWLL
         A36UkFbIP1R5PxqadKjdJI5NVB9n0Dv3isKZttiQsZJWFDC5sFtktmI8DiE0KYOp1Pbw
         5omw==
X-Forwarded-Encrypted: i=1; AJvYcCXh7pjBCE55L4vOvRA14f/wVmz9NBf4Nr8Z0/k2SVPPytAm/YlWdHqlx5sp0dpHrsHK/bs14g+zp6Gp5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bHxTdx4jmiXQS7N6WcgFVc2f1BTbJ4Lbe/qE0HJTawr9Q3g3
	dTn+frsGfsmTK4//fW0RBIFpqQq8RO+NLXtwNIVHUBIBlr+n8xtRc6CIxZ3Fcj9TgFtSnCYQq7b
	oeyuB/dvbEFFsX9wxs0kAS9XaTTX/Uzb6yQlBQ7i1tC9W0FuS0mufRxjdDvTLYTfv
X-Gm-Gg: ASbGncv3vy9mD495lbZXPzbl/U+uCX7lhtaNzzoSD/1XUlyAZITql8fnsZ9+C+OoZLy
	cyzwxXqo9aMqADfEe/BvGm2FCezYT47JHhih4pu/5n20hVNAj4V360n6SKGoPVbLTenXUvE5Z0h
	6k4dXMA/i3uxm0lqK+PO8ZhUDKjocCFw3lHIktNWwEdE9VaVxeTNeuaj9Ysd0+ay3PuAoK9pHAN
	j+Ml0ZirrbadcCyoH6HfBnPcIJcxrjWpToputXW//j1VWetePi0nO5A0zQShOCBy+pv1zjBoLjk
	8kO93zMuqZtYkofqdx1Uq3NJbAbGatmTewVvvfTlJk1xR98hLJhBntqt2tcvd+i03qYbs5fHzeR
	Y8WlyJpdL0pgxS5l5
X-Received: by 2002:a05:620a:410f:b0:7d3:c67f:7532 with SMTP id af79cd13be357-7d3f99327ccmr2313482985a.40.1750774899260;
        Tue, 24 Jun 2025 07:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR3cDql3VJLUr0EuiZIXkdr5u/svh4yWrVWPkzjWNmljf9JBpmaP0fofJOKq3rHI7yZwMwag==
X-Received: by 2002:a05:620a:410f:b0:7d3:c67f:7532 with SMTP id af79cd13be357-7d3f99327ccmr2313476085a.40.1750774898607;
        Tue, 24 Jun 2025 07:21:38 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99a6755sm504639885a.32.2025.06.24.07.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:21:37 -0700 (PDT)
Message-ID: <a665dead67bf4f3432cf1bddf29d2c573ab71673.camel@redhat.com>
Subject: Re: fix virt_boundary_mask handling in SCSI
From: Laurence Oberman <loberman@redhat.com>
To: Christoph Hellwig <hch@lst.de>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>, 
	"K. Y. Srinivasan"
	 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	 <wei.liu@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Tue, 24 Jun 2025 10:21:36 -0400
In-Reply-To: <20250623080326.48714-1-hch@lst.de>
References: <20250623080326.48714-1-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2025-06-23 at 10:02 +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes a corruption when drivers using virt_boundary_mask
> set
> a limited max_segment_size by accident, which Red Hat reported as
> causing
> data corruption with storvsc.  I did audit the tree and also found
> that
> this can affect SRP and iSER as well.
> 
> Note that I've dropped the Tested-by from Laurence because the patch
> changed very slightly from the last version.
> 
> Diffstat:
>  infiniband/ulp/srp/ib_srp.c |    5 +++--
>  scsi/hosts.c                |   20 +++++++++++++-------
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
Grabbing latest and will test tomorrow and reply

