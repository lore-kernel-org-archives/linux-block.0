Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TE8jrV7z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D619D
	for <linux-block@vger.kernel.org>; Wed, 22 Nov 2023 18:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700705983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2aZzryTXfwVm4bHgxcYkBHTBkYi7Y8xjXsoz4m2WKU=;
	b=TE8jrV7z8BBzHMyf7v5sLEbf3PneAzCvrLT8rTaouGbzkTKOuTv2rtQMvhbYb/g9JSa/i1
	D09+S9W9WDn0xbsPNRjB0KS6vys++0wY/13rZXnqRgZxAw3s7sFd8QKV5VsnNo5mt6Gw44
	qw8LBCeKKcGtRCScDOuZDt3YdIb3uxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-_OvJFeQrOSu_YCCI76BTjg-1; Wed, 22 Nov 2023 21:19:40 -0500
X-MC-Unique: _OvJFeQrOSu_YCCI76BTjg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47A3E80D722;
	Thu, 23 Nov 2023 02:19:40 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D79A492BFA;
	Thu, 23 Nov 2023 02:19:34 +0000 (UTC)
Date: Thu, 23 Nov 2023 10:19:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV62svvu5MSUGoPD@fedora>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <ZV2tuLCH2cPXxQ30@infradead.org>
 <ZV2xlDgkLpPeUhHN@fedora>
 <ZV2zbTPTZ0qC2F1U@infradead.org>
 <ZV25nGGMYQuyclK6@fedora>
 <ZV34d/hI12pKFUzj@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV34d/hI12pKFUzj@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Nov 22, 2023 at 04:47:51AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 04:19:40PM +0800, Ming Lei wrote:
> > On Tue, Nov 21, 2023 at 11:53:17PM -0800, Christoph Hellwig wrote:
> > > On Wed, Nov 22, 2023 at 03:45:24PM +0800, Ming Lei wrote:
> > > > All the existed 'bool' flags are not atomic RW, so I think it isn't
> > > > necessary to define 'bd_flags' as 'unsigned long' for replacing them.
> > > 
> > > So because the old code wasn't correct we'll never bother?  The new
> > > flag and the new placement certainly make this more critical as well.
> > 
> > Can you explain why the old code was wrong?
> > 
> > 1) ->bd_read_only and ->bd_make_it_fail
> > 
> > - set from userspace interface(ioctl or sysfs)
> > - check in IO code path
> > 
> > so changing it into atomic bit doesn't make difference from user
> > viewpoint.
> 
> > 
> > 2) ->bd_write_holder
> > 
> > disk->open_mutex is held for read & write this flag
> > 
> > 3) ->bd_has_submit_bio
> > 
> > This flag is setup as oneshot before adding disk, and check in FS io code
> > path.
> 
> On architectures that can't do byte-level atomics all three can corrupt
> each other

Yeah, C/C++ doesn't provide such guarantee, but many modern ARCHs [1]
guarantees that RW on naturally aligned type is atomic.

I verified the point on x86/arm64/ppc64le by the following code, and
all three STOREs are done in single instruction.

	struct data {
		int b;
		char a;
		char a2;
		char a3;
		char a4;
	} __attribute__((aligned(8)));
	
	void atomic_test()
	{
		struct data d;
	
		d.b = 1;
		d.a = 2;
		d.a3 = 3;
	
		printf("%d %d %d\n", d.b, d.a, d.a3);
	}

[1] https://preshing.com/20130618/atomic-vs-non-atomic-operations/

> and even worse bd_partno.  Granted that is only alpha these
> days IIRC, but it's still buggy.

bd_has_submit_bio and bd_partno can be thought as read only, and the
two can be corrupted?

bd_dev may have similar trouble with bd_partno for ARCHs which don't
provide atomic RW on naturally aligned int.


Thanks,
Ming

