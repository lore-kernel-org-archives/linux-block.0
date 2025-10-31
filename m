Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462426FD86
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 03:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881357; cv=none; b=F6ebxHk25DgwOQTWlxQjhnheAicnp52+hhVfBVIlp7mk2KMb8+rrriEaxcKzVh7DRHaW6m6+jBOYNkg5c5XVj80qisRN5oo69tEU1YAnGmmls4HSn/JgAFRknIDxa0FW0vV9Xq0QtRNPwmYWKYe38le76sIO8OPsku2G95U2nuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881357; c=relaxed/simple;
	bh=EovJZ3H2L4Q0SNA6DoOp6SOEnC85TeRHfl6iYZQRCfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7hvVoAxQNYrAaedTQbkNVAVqvKMd6Or2svzbOg41lM5h1y5hYDaIjvl6GqV98btBXSR2YbxaHxKeno1ggAIZy9jh22HTK8wbYBX57oAEHgEtt3K0BXnF/wABcnlHOM2TDJaCi6azRNMfiBOZy3m53Xp3RQWrJqTbc7m5rVDd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI9Sxxqy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI9Sxxqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761881355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0SmVh2QuJ5jwDo9MjpHJGaXOOC7TR51f3FQJy7JAfY=;
	b=gI9SxxqyKRNs+5yFHHTOT0dOc+alYJUUhxObCthCiyEAW4xSnCZfjev8DRzC0bLVgYIZAe
	SuIdSqQj+rmfa/zj54sg7igCJOuAGtIde7G5VFh0i93wfwe1b5RkR0P1hiuq2gbm1ba+Op
	BTlYjTe6IvxiyqqEIq/2D32axyIzSgc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-bJhFpt_XOkqs4uMplUCEfQ-1; Thu,
 30 Oct 2025 23:29:11 -0400
X-MC-Unique: bJhFpt_XOkqs4uMplUCEfQ-1
X-Mimecast-MFC-AGG-ID: bJhFpt_XOkqs4uMplUCEfQ_1761881350
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9836E19539BB;
	Fri, 31 Oct 2025 03:29:09 +0000 (UTC)
Received: from fedora (unknown [10.72.120.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92C031800598;
	Fri, 31 Oct 2025 03:29:03 +0000 (UTC)
Date: Fri, 31 Oct 2025 11:28:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	kernel test robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Uday Shankar <ushankar@purestorage.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
Message-ID: <aQQs-S0rYTzwsg-y@fedora>
References: <20251029031035.258766-3-ming.lei@redhat.com>
 <202510301522.i47z9R95-lkp@intel.com>
 <CADUfDZonryeHe1MGTfnUa16VbvEt5C+yu11yh3ZRDbwFqJ_L9w@mail.gmail.com>
 <20251030175631.GB417112@ax162>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030175631.GB417112@ax162>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 30, 2025 at 10:56:31AM -0700, Nathan Chancellor wrote:
> On Thu, Oct 30, 2025 at 07:07:25AM -0700, Caleb Sander Mateos wrote:
> > On Thu, Oct 30, 2025 at 1:01 AM kernel test robot <lkp@intel.com> wrote:
> ...
> > > patch link:    https://lore.kernel.org/r/20251029031035.258766-3-ming.lei%40redhat.com
> > > patch subject: [PATCH V3 2/5] ublk: implement NUMA-aware memory allocation
> > > config: x86_64-randconfig-074-20251030 (https://download.01.org/0day-ci/archive/20251030/202510301522.i47z9R95-lkp@intel.com/config)
> > > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301522.i47z9R95-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202510301522.i47z9R95-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> drivers/block/ublk_drv.c:240:49: error: 'counted_by' argument must be a simple declaration reference
> > >      240 |         struct ublk_queue       *queues[] __counted_by(dev_info.nr_hw_queues);
> > >          |                                                        ^~~~~~~~~~~~~~~~~~~~~
> > 
> > Hmm, guess it doesn't support nested fields?
> 
> Correct. I think this is something that we want to support at some point
> if I remember correctly but I think there was a lot of discussion
> between GCC and clang on how to actually do it but Kees is free to
> correct me if that is wrong.

Thanks for the confirmation.

Will remove this __counted_by() in next version.

Thanks,
Ming

