Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OM4AtmPh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383B18D
	for <linux-block@vger.kernel.org>; Wed, 22 Nov 2023 00:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700641192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NIoITgQxtiObzPXLhbMbQ4g44rH9YUmiKgRrHrYsxWk=;
	b=OM4AtmPhF7LHRyoMigzeAEW0WLeyCVJsZ01OFeSsXU/NNL5zXK+lT1eLSsZmZfgV+Bou9B
	nhVNPiszVSmUAX+M5CUuLIjz+oYLJ/zl+KPlToaJAj/kYxJbE3u54MXwoTNCCtlsYuNr++
	njqRlKxHY7t0c9C20DFP1+v3M1sPcH4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-Y8eM_pUwMYakn0zSjgAXzg-1; Wed,
 22 Nov 2023 03:19:50 -0500
X-MC-Unique: Y8eM_pUwMYakn0zSjgAXzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B1A93C10146;
	Wed, 22 Nov 2023 08:19:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BBCBC1596F;
	Wed, 22 Nov 2023 08:19:45 +0000 (UTC)
Date: Wed, 22 Nov 2023 16:19:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV25nGGMYQuyclK6@fedora>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <ZV2tuLCH2cPXxQ30@infradead.org>
 <ZV2xlDgkLpPeUhHN@fedora>
 <ZV2zbTPTZ0qC2F1U@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV2zbTPTZ0qC2F1U@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Tue, Nov 21, 2023 at 11:53:17PM -0800, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 03:45:24PM +0800, Ming Lei wrote:
> > All the existed 'bool' flags are not atomic RW, so I think it isn't
> > necessary to define 'bd_flags' as 'unsigned long' for replacing them.
> 
> So because the old code wasn't correct we'll never bother?  The new
> flag and the new placement certainly make this more critical as well.

Can you explain why the old code was wrong?

1) ->bd_read_only and ->bd_make_it_fail

- set from userspace interface(ioctl or sysfs)
- check in IO code path

so changing it into atomic bit doesn't make difference from user
viewpoint.

2) ->bd_write_holder

disk->open_mutex is held for read & write this flag

3) ->bd_has_submit_bio

This flag is setup as oneshot before adding disk, and check in FS io code
path.

Of course, defining it as 'unsigned long' can extend its future usage, but
it depends on the atomic requirement of each flag itself.


Thanks, 
Ming

