Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D2770E2
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781489; cv=none; b=iEyk6fdv5D4Ft2lhrawPkxPqyGua0zbsKzzK7t7I+ix+LDKlmJjis32rYeKXjlkr+dbqhGn3ro0qIqJWydGYfBz5xcebRo8303o+AF/wGDt4EQhGYGyLNCWrDOLaK7w4LPcSVSmbSBam281U1qkJMJuG8xn4SAYhfzvf+nFkb9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781489; c=relaxed/simple;
	bh=rpyrgzPqYdwj0KtWllHYX+bkm3/xQH68qnPbDJoG8UA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9i3Jp6n5DmfChGaz4m+746iPdAtazbjpGJVfFyLQdMcauBiTXJv0erMtqpY1vRBOYv85dDEbGkctBJ/YRtzsHafmTE+iZwvSkdI50kusyNOhqjKY18NkEmxfOgYxehfKF4qF7fK+wOqhX/d6XeBJ9oyTgivZnKOVzG5ZHTnuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C++ScmVj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C++ScmVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750781486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vAplsu0koS/gXiH5wLf6N4Z+Ah3uxNPhjuFlpZhWyo=;
	b=C++ScmVjEEybHsXqgDJGom5kA/IvDZO4XkiKZp7dE4iKwAniIHiLijwqHfUFBAQgY3aC8a
	7MaAYLuLUYaN0+i0Cd3IQK9DLnUDkbMRds7i9zYVaGTUKmAU4tR9tG387U2dz53N0mx0H/
	rN5pCzRmxJstksWfKkQVuZdyykd+BIU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-XHFDrMZ2NrijA9rniVrjWQ-1; Tue, 24 Jun 2025 12:11:25 -0400
X-MC-Unique: XHFDrMZ2NrijA9rniVrjWQ-1
X-Mimecast-MFC-AGG-ID: XHFDrMZ2NrijA9rniVrjWQ_1750781485
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a44c8e11efso163361271cf.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 09:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781485; x=1751386285;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vAplsu0koS/gXiH5wLf6N4Z+Ah3uxNPhjuFlpZhWyo=;
        b=VXreewgmJh8MvrFjzgQ5qhHZPPQW0ngugJT/HhWJzkckoxwf1tGlHtCdf26FkE6hb+
         zPw5UOvs3xTlnd0VEI4pJYLjHwFJrPIr6CWiN1J6S6n0/9w1UK5QjAthFOnHmaaI+g6M
         MPOCQ5rDFYozW4O9VsA3Ot1DlF8+SG452ircwk4eHB+ibbA0fSurr+IIO2r1W77UChur
         yJETfOg0DmJfMjHg3siSwvRBh+Uc2bryQPil+3ZGhSl4k6XFiOECARmkUWSrs2u89qmZ
         fQBVLzVTyC0i6/wcgR7uHRLF7ASqp+eKY1z5zsGDE7A61/mdEpVvbmweHrr4cHauHniq
         bkjA==
X-Forwarded-Encrypted: i=1; AJvYcCU7K1i5OHQRkp+62ZAKDSA6IHZdG0KeIc1j4LvSLcEZtbOwRBmMGoFqzqBRfW0PBTR2WXqdmOARKIV+vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLGv67oFSVoZlERIt3lwggk5ftXacS9V5jNtVhSuuAdPU3i5c
	Fmmre3jtqrt+tF3glUDbWYitunRHVHzQwLObHLVUH2TzCjTKLlTm3X2r5TRgh21pkoxkwccCNeS
	lJPCEm0IRRrvpdy/TCuoVtePBH14Wqjl4n+IzwmIf8IZuQHmxR+T2Y2YOptZgWKZV
X-Gm-Gg: ASbGncszOpbdrSD+EyUoITwgknMOFa9w8d+UoE3paBKrOM7YEdbZMFHfjFvUEPabDgA
	20gA0ZGDt1DFvpDxZzeqAG7qgGWCNzfns/4Ysb3V1ziSFa8qZ+u8850RzkNmcbCvPY/Tox1756W
	8IzJj2ktFarXwWOnm6EyGdrxVylqrbt4mR/6NNV16OUh1Ah211hFWQiWlvaGd9LWx1fOBJuYEZJ
	s87H7OcBNhpgKTD6iyR+LZEADNq/lLW6O2NarRjZaubPUcvnEOOMsAIjlJNsNngiBjAq/Vc+EWL
	gf4u3H4B76S13xlwCH9dPYCkcjDUEOfqvyrYZphbdiII2dzsMi7C3FDJGrme7pfRYNPoGmkL4CJ
	RJFcljZzOJMyqVCq+
X-Received: by 2002:a05:6214:509c:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-6fd0a54dc0emr331829226d6.23.1750781484662;
        Tue, 24 Jun 2025 09:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwO+fys6xaB3QgCvBNDb3NtvnbriukxpK0WFjoLSLnIQz+mQojAEJiClWr0nrT4Mndrjbm/g==
X-Received: by 2002:a05:6214:509c:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-6fd0a54dc0emr331828566d6.23.1750781484146;
        Tue, 24 Jun 2025 09:11:24 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99efaa9sm517427385a.58.2025.06.24.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:11:23 -0700 (PDT)
Message-ID: <487a4646387595383bf8ae24584c5b54ec6aa179.camel@redhat.com>
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
Date: Tue, 24 Jun 2025 12:11:22 -0400
In-Reply-To: <a665dead67bf4f3432cf1bddf29d2c573ab71673.camel@redhat.com>
References: <20250623080326.48714-1-hch@lst.de>
	 <a665dead67bf4f3432cf1bddf29d2c573ab71673.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-06-24 at 10:21 -0400, Laurence Oberman wrote:
> On Mon, 2025-06-23 at 10:02 +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series fixes a corruption when drivers using
> > virt_boundary_mask
> > set
> > a limited max_segment_size by accident, which Red Hat reported as
> > causing
> > data corruption with storvsc.  I did audit the tree and also found
> > that
> > this can affect SRP and iSER as well.
> > 
> > Note that I've dropped the Tested-by from Laurence because the
> > patch
> > changed very slightly from the last version.
> > 
> > Diffstat:
> >  infiniband/ulp/srp/ib_srp.c |    5 +++--
> >  scsi/hosts.c                |   20 +++++++++++++-------
> >  2 files changed, 16 insertions(+), 9 deletions(-)
> > 
> Grabbing latest and will test tomorrow and reply
> 
For the series looks good.
Same testing shows no corruptions on storvsc for the REDO so passed.
For SRP initiators generic testing done with fio and passed, unable to
test SRP LUNS with Oracle REDO at this time.

Here it is, enough reviewers already so just the testing
Patches were applied to a 9.6 kernel because I needed such a kernel for
Oracle compatiility.

tested-by: Laurence Oberman <oberman@redhat.com>



