Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523234F466
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862944; cv=none; b=RtDY11G4UPfUla+FI2LDmylVFW3jGlTCWu45KC1Eq4j5Fp66lZ5SG+ufVDYIjn+V9RxSglsN8SIG8zEoIgpBH5w70L1P/HPTX91dgiiEgQPHpNQpz9JkjSO1p8oCeueiCczxjmd68OJzlE12tWEYTUj9ZzkHRYEywcSyAzAFUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862944; c=relaxed/simple;
	bh=SbqShAIE3SZM5AqKJRVAvqGq43IpxY2ybj2d3tdXMSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To173M81ARvpDTzczcxpcAYJIKJg5+KIL/+grENa/VbF1hnnbopYSorWGY+Y2uxUdrzQDfyQdkF12jtOPQ4LvrH/HR2vYqZ1JQ8/E3SegD06O5Av79uMjTxpuNHp+prTAOtI9vlDJuarOsPpRs0SB1ikIKnDmuSqiAl8XW5LuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9qsxrK4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9qsxrK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762862942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRHAUY22f4DMZXjGNy9kKErIJtv/qXFs3nnNzhiEiMY=;
	b=Q9qsxrK4/CbuH5Fs9miAUUftbZ2H3ilWwdp78Y6NbM/SjdYtJRmOQcvbBih5gGSoZop1zW
	CDXfV+r4bLnQLIPubKob0WQEg68AIlfV5+fDMMAslBa5sab9u6Io9971CgFQy2m/jDRoPE
	fJ71UTiOxQ66Hu1o73/uOw78NZ/8P+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-v5kAbdCLOKGzNWrqMNMF5A-1; Tue,
 11 Nov 2025 07:08:57 -0500
X-MC-Unique: v5kAbdCLOKGzNWrqMNMF5A-1
X-Mimecast-MFC-AGG-ID: v5kAbdCLOKGzNWrqMNMF5A_1762862935
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA3371955D48;
	Tue, 11 Nov 2025 12:08:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BA411800451;
	Tue, 11 Nov 2025 12:08:44 +0000 (UTC)
Date: Tue, 11 Nov 2025 20:08:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Guo, Wangyang" <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
Message-ID: <aRMnR5DRdsU8lGtU@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora>
 <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
> On 11/11/2025 11:25 AM, Ming Lei wrote:
> > On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
> > > As CPU core counts increase, the number of NVMe IRQs may be smaller than
> > > the total number of CPUs. This forces multiple CPUs to share the same
> > > IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
> > > performance penalty can be observed on some platforms.
> > 
> > Can you add details why/how CPU cluster isn't aligned with IRQ
> > affinity? And how performance penalty is caused?
> 
> Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
> L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
> dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
> remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
> cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
> CPU31, it will have cross L2 memory access.


CPUs sharing L2 usually have small number, and it is common to see one queue
mapping includes CPUs from different L2.

So how much does crossing L2 hurt IO perf?

They still should share same L3 cache, and cpus_share_cache() should be
true when the IO completes on the CPU which belong to different L2 with the
submission CPU, and remote completion via IPI won't be triggered.

From my observation, remote completion does hurt NVMe IO perf very much,
for example, AMD's crossing L3 mapping.


Thanks,
Ming

