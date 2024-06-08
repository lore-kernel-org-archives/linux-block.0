Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702017997A
	for <linux-block@vger.kernel.org>; Sat,  8 Jun 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856190; cv=none; b=q6EdxduNjTvUqjeZzFFw9ul924/t0w/tcF0AZq/swUZh8jYuK5hsH4o8fDwpyw9+dbp5eno99ztFKTR6ZO8BoUpW5hP1+ogQDEEXRpJJpur2/uyPAOWZaZGpZmJRLRk0OPf0KentrLCZ3omo6fBsa2WOB0hCbHmS3tIW84xuF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856190; c=relaxed/simple;
	bh=y1/pdGFNQ4bmBupNSPXczZk3gfpVzHE5/xtJhhxuZEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7lerdvkl7UuufDRct3lbYM7stERtVSKWvmfsujTdfwjvZ+AZ9OrlPhIu426pESVee5ArndH400onnaXv3gHMEJgf2OgD2vIh6cjAkQN+bE5Yd/WUCWbl2QBmnQ5+/AfJwQnlw18w71bOopBpN0AUTDBbQKMjXQigy2UMv7ttyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+nN1YsL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+nN1YsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717856187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4i3eRJmBmN+iQA9CJ+0NHv/UewJVWHJgwRHQO6ZQpM=;
	b=Q+nN1YsLiZCbwChVEY5xZOLuo8k0AbirDQUR0pMUFVc2a5hEBpOOBk9O63wnjryGXfsx2P
	KtOUDE9tSOoxrL8XIvq8enL4Z8lLN3pQDk52nBiGqCYdz4W3caspS3cfo6ygpsX3S+CkyF
	1GOWUmQv6Kg5kDirV4zeLs6h9fdqfbo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ESfm0zbmO4CqmPNoso-9zA-1; Sat, 08 Jun 2024 10:16:21 -0400
X-MC-Unique: ESfm0zbmO4CqmPNoso-9zA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41D21185A780;
	Sat,  8 Jun 2024 14:16:21 +0000 (UTC)
Received: from fedora (unknown [10.72.112.37])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 117253C23;
	Sat,  8 Jun 2024 14:16:14 +0000 (UTC)
Date: Sat, 8 Jun 2024 22:16:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Li Nan <linan666@huaweicloud.com>
Cc: Changhui Zhong <czhong@redhat.com>, axboe@kernel.dk,
	ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
	ming.lei@redhat.com
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
Message-ID: <ZmRnqmiNGW5Y+452@fedora>
References: <Zl0QpCbYVHIkKa/H@fedora>
 <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
 <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
 <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com>
 <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
 <ZmA0Se+t/LZihBKp@fedora>
 <CAGVVp+WoBochfQvLgAVbpWFv6JVAfQVkPwWDG8mBxqgGK-NDbg@mail.gmail.com>
 <2c46587e-0621-b21e-fbc1-fd69e87def03@huaweicloud.com>
 <ZmGGzNLLC6WpM9tb@fedora>
 <dd486a95-b7e8-5760-9ff1-7e9c1cfc9873@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd486a95-b7e8-5760-9ff1-7e9c1cfc9873@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Sat, Jun 08, 2024 at 02:34:47PM +0800, Li Nan wrote:
> 
> 
> 在 2024/6/6 17:52, Ming Lei 写道:
> > On Thu, Jun 06, 2024 at 04:05:33PM +0800, Li Nan wrote:
> > > 
> > > 
> > > 在 2024/6/6 12:48, Changhui Zhong 写道:
> > > 
> > > [...]
> > > 
> > > > > 
> > > > > Hi Changhui,
> > > > > 
> > > > > The hang is actually expected because recovery fails.
> > > > > 
> > > > > Please pull the latest ublksrv and check if the issue can still be
> > > > > reproduced:
> > > > > 
> > > > > https://github.com/ublk-org/ublksrv
> > > > > 
> > > > > BTW, one ublksrv segfault and two test cleanup issues are fixed.
> > > > > 
> > > > > Thanks,
> > > > > Ming
> > > > > 
> > > > 
> > > > Hi,Ming and Nan
> > > > 
> > > > after applying the new patch and pulling the latest ublksrv,
> > > > I ran the test for 4 hours and did not observe any task hang.
> > > > the test results looks good！
> > > > 
> > > > Thanks，
> > > > Changhui
> > > > 
> > > > 
> > > > .
> > > 
> > > Thanks for you test!
> > > 
> > > However, I got a NULL pointer dereference bug with ublksrv. It is not
> > 
> > BTW, your patch isn't related with generic/004 which won't touch
> > recovery code path.
> > 
> > > introduced by this patch. It seems io was issued after deleting disk. And
> > > it can be reproduced by:
> > > 
> > >    while true; do make test T=generic/004; done
> > 
> > We didn't see that when running such test with linus tree, and usually
> > Changhui run generic test for hours.
> > 
> > > 
> > > [ 1524.286485] running generic/004
> > > [ 1529.110875] blk_print_req_error: 109 callbacks suppressed
> > ...
> > > [ 1541.171010] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > [ 1541.171734] #PF: supervisor write access in kernel mode
> > > [ 1541.172271] #PF: error_code(0x0002) - not-present page
> > > [ 1541.172798] PGD 0 P4D 0
> > > [ 1541.173065] Oops: Oops: 0002 [#1] PREEMPT SMP
> > > [ 1541.173515] CPU: 0 PID: 43707 Comm: ublk Not tainted
> > > 6.9.0-next-20240523-00004-g9bc7e95c7323 #454
> > > [ 1541.174417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > 1.16.1-2.fc37 04/01/2014
> > > [ 1541.175311] RIP: 0010:io_fallback_tw+0x252/0x300
> > 
> > This one looks one io_uring issue.
> > 
> > Care to provide which line of source code points to by 'io_fallback_tw+0x252'?
> > 
> > gdb> l *(io_fallback_tw+0x252)
> > 
> (gdb) list * io_fallback_tw+0x252
> 0xffffffff81d79dc2 is in io_fallback_tw
> (./arch/x86/include/asm/atomic64_64.h:25).
> 20              __WRITE_ONCE(v->counter, i);
> 21      }
> 22
> 23      static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
> 24      {
> 25              asm volatile(LOCK_PREFIX "addq %1,%0"
> 26                           : "=m" (v->counter)
> 27                           : "er" (i), "m" (v->counter) : "memory");
> 28      }
> 
> The corresponding code is:
> io_fallback_tw
>   percpu_ref_get(&last_ctx->refs);

[ 1541.171010] BUG: kernel NULL pointer dereference, address: 0000000000000000
...
[ 1541.175311] RIP: 0010:io_fallback_tw+0x252/0x300

So looks the 'struct io_ring_ctx' instance is freed and ctx->refs.data
becomes NULL when calling percpu_ref_get(&last_ctx->refs), not clear how
it can happen since request grabs one ctx reference.

Maybe you can try kasan and see if more useful info can be dumped.

> 
> I have the vmcore of this issue. If you have any other needs, please let me
> know.

Not try remote vmcore debug yet, will think further if any useful hint
is needed.

> The space of the root path has been filled up by
> ublksrv(tests/tmpublk_loop_data_xxx), which may the issue be related to this?

It isn't supposed to be related, since the backing loop image is created by dd
and it isn't sparse image, and the test runs fio over ublk block
device only.

Thanks,
Ming

