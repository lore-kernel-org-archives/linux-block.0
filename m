Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8417E0
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219766; cv=none; b=We+T68OVNtzMz5gSwRaY0gNu+0EYmDTVJ5/MBU7O6/Gi6B0yhiaUKH+glgzOATJo/+n7UvuFvmwu7aaYeW7TBpjguOHXXJRbBWm7ff4EaeTPpyFB8GXD8Hyb8rGW+XBrIrUXX8a0mvJcjEyeNP1RlyR6L89KzxfiBfq3lpAKAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219766; c=relaxed/simple;
	bh=kQGIgreekxtmU8CWKNTHVIY3eTXijSsKKGybEECMRFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm0Pr0qjRmv6t8PsUGpRTezloGD8axrAdnk3eEVHJRtB84Kz6x2LYRs+hFInZUwvBAM1DBVWPZJCUPneblakrIniZ5Xa1lN+gwY3gwZUeJBzYZQ0L5lJ0jLVnLRXulfTnH3sY4qRYo0OOk5lWRVUHi5vmF+r00QvTSqwbWZV/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frcsbHVr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frcsbHVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TcDUP+ps63/jrGgAjCJp4o8llbkXnQ4nl0SzsfkEYiU=;
	b=frcsbHVrPvR8BoLlOE14Ju/Pg8YHbn1EU84LcFDZYLDHDVEDrtS+slqjDcDsN7kH3EfD1s
	foi/0dMPXpm7xW7ipbAYybHYb4+hrU//N49WAJlW/83keF5hi/z4g+tiDR4qttolEtPN36
	TB1N8DpFcltbrAqfVrOPupA9ZtSFlYk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-q2KcS3WcN--6jbbez6fBkA-1; Tue,
 26 Aug 2025 10:49:19 -0400
X-MC-Unique: q2KcS3WcN--6jbbez6fBkA-1
X-Mimecast-MFC-AGG-ID: q2KcS3WcN--6jbbez6fBkA_1756219758
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30CD019560AD;
	Tue, 26 Aug 2025 14:49:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEB65180028A;
	Tue, 26 Aug 2025 14:49:13 +0000 (UTC)
Date: Tue, 26 Aug 2025 22:49:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [blktest/nvme/058] Kernel OOPs while running nvme/058 tests
Message-ID: <aK3JYzj21O5Qcah3@fedora>
References: <3a07b752-06a4-4eee-b302-f4669feb859d@linux.ibm.com>
 <aK15dbUiEyr0O2Ka@fedora>
 <b877e779-5395-4162-ba87-2a0e07932eb4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b877e779-5395-4162-ba87-2a0e07932eb4@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Aug 26, 2025 at 03:26:02PM +0530, Nilay Shroff wrote:
> 
> 
> On 8/26/25 2:38 PM, Ming Lei wrote:
> > On Tue, Aug 26, 2025 at 02:00:56PM +0530, Venkat Rao Bagalkote wrote:
> >> Greetings!!!
> >>
> >>
> >> IBM CI has reported a kernel OOPs, while running blktest suite(nvme/058
> >> test).
> >>
> >>
> >> Kernel Repo:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>
> >>
> >> Traces:
> >>
> >>
> >> [37496.800225] BUG: Kernel NULL pointer dereference at 0x00000000
> >> [37496.800230] Faulting instruction address: 0xc0000000008a34b0
> >> [37496.800235] Oops: Kernel access of bad area, sig: 11 [#1]
> > 
> > ...
> > 
> >> [37496.800365] GPR28: 0000000000000001 0000000000000001 c0000000b005c400
> >> 0000000000000000
> >> [37496.800424] NIP [c0000000008a34b0] __rq_qos_done_bio+0x3c/0x88
> > 
> > It looks regression from 370ac285f23a ("block: avoid cpu_hotplug_lock depedency on freeze_lock"),
> > For nvme mpath, same bio crosses two drivers, so QUEUE_FLAG_QOS_ENABLED & q->rq_qos check can't
> > be skipped.
> > 
> Thanks Ming for looking at it. And yes you were correct, we can't skip
> QUEUE_FLAG_QOS_ENABLED & q->rq_qos for NVMe, However this issue only
> manifests with NVMe multipath enabled, as that would create the stacked
> NVMe devices. So shall I send the fix or are you going to send the patch
> with fix?

Yeah, please go ahead and prepare the fix.


Thanks,
Ming

