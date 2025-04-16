Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782B22B587
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744835216; cv=none; b=R4G5H841uWPOgUp1Lb6aQlcpOc2KzrusGastK6NBSh4Tc2vbF7jHNwLXQ4oE++hALIZdy3QQy75NzxDh9kD+5fGyLBJgxWkpYoMPes0SBlrK6Dc5AMT6JGt15NONNRhBaTFM7GxhWaHtUQb09l6iMooFMQQUKELiy3oJFX1IlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744835216; c=relaxed/simple;
	bh=+NVEIDajjOa6S0mwO8uDhLAW9+C2KQqJgF0nDKTn3hM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WETcVSY9Tzdm028iJsRNnCaBAEtaJSn9JAh5rJUJzOAmBV3KlzyApwN49GgLD1GFVpStDLJ4GQk1UChQDK7E4aQnYmtYYQf/+OntvYOB04ROrXlDqM3PxeFSDQvZZFwiOhhU2YDfgs2gkRBOopsElbJZExzGJMz6g3pTki5Cz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLOKKqB9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLOKKqB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744835213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6AVDplNPTi289CSbOZ9ARQJAN0z0vy8/1A9VIws9D4=;
	b=BLOKKqB9MvOZZSCVtKDPvsZrRWRGXdfhMgH5Bydnx4wkkCxAkiWTqWMminG+Jy06xaE7Zr
	No3XiV6cW0XzQn6UaxutMsGpb4Nm1yuLDHkWrlnZ6AwMmXsH/r80wBbB9rXD5PXPfiqyJ8
	o5gynqWtsN2wgAW6Eq8gyEP3Z8PMM98=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-Jkj0lwpGPqWCdWOdTm-3gA-1; Wed, 16 Apr 2025 16:26:50 -0400
X-MC-Unique: Jkj0lwpGPqWCdWOdTm-3gA-1
X-Mimecast-MFC-AGG-ID: Jkj0lwpGPqWCdWOdTm-3gA_1744835210
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b5ea50d28so755939f.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 13:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744835210; x=1745440010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6AVDplNPTi289CSbOZ9ARQJAN0z0vy8/1A9VIws9D4=;
        b=vOwv2WrFg7xyTe8VVJlsZbJe5n80S2wTSNhytKhfIearkDmYESIlJfZod9KCoSNhkg
         kAoSdpEYUZaGCMJq1PbCw6E7FoH5RRoDWV5WhNsM3kpQUafKKEvnfLJckq/eL1glYz1F
         tO0VpQmChiyRy+1xb1opbWFUlQe7PbIfjeXzBe8BUH/1Mi7CqN+QnvR2T9ukTmZu1gql
         bLRcz3raci0dzA0GuT4T8mATj8AWq1YdIYbIst/c6bxtaobBWA2HJei7AcaQ41OoQ6cM
         j2fBTOl2/GH8BBtKaCAPvSEdbaPLVOvA0hbD4G4mABgxxXWrsF6Ugvq8ALSCqntXADD0
         7+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9fnwNaFjlGp5G0sJ1mMoiWT4ZcODiPm2630x1hx57O0HypvUM83VPB1oiGDVu04K6xDKiVqvTfL/OiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCV1Y7ADrw6EwVGjkpMPy2TxFTI/K9hCgZ6qUUPLXucFKjvTb
	UIZU9IH89bWkSm5x87C+WA8Aq6GxX8uBHWfvmcfH9IAHD2k9qMC5msxqmmckl87k/yw0onLZpAj
	6mvUGFbRW+Gt54jsb1zz+ntG/XkEI5yO2b2qLFCycQzJ+4tQyTGmJWNlJrJg9
X-Gm-Gg: ASbGncvW2/HAcB1js6h/yieR3Exb515t0+DSGRHNOMq2uJyQGe27aCFnIvc09hRDILT
	/hbWbnNt3VjFsw8IlTYUwXdvxbdxO9O7reh/u3t5M9p4EPBFDzX6HFPtgv8hC0rDHYs7kSCv7pd
	sB4kiLLQdmRGab26zthSO2MSelsBsJ4uXLy5pza9Emw6AAeYWMi8iGZCLMKpjuB3oykyySCJLSL
	TqeuDOwCd224CgAhBMsCtNplMpFLlQIqhGLvqa8E4G/Ib+iFnGu5gK0YcqNx/kMsIV7WBmORJba
	aVf86q/sJ2c4jbc=
X-Received: by 2002:a05:6602:1583:b0:856:2a52:ea02 with SMTP id ca18e2360f4ac-861cc5cfb48mr34534839f.5.1744835209682;
        Wed, 16 Apr 2025 13:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdbc3yXRCu1SxHof01X2wIaipkMkSkrZJncD3XrTLmdj2ulJ1ktFsxzmI+33GyeGFuM7i9VQ==
X-Received: by 2002:a05:6602:1583:b0:856:2a52:ea02 with SMTP id ca18e2360f4ac-861cc5cfb48mr34532239f.5.1744835209342;
        Wed, 16 Apr 2025 13:26:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8616522d048sm306863539f.1.2025.04.16.13.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 13:26:48 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:26:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig
 <hch@infradead.org>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe
 <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jeff Layton
 <jlayton@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Logan Gunthorpe
 <logang@deltatee.com>, Hillf Danton <hdanton@sina.com>, Christian Brauner
 <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sasha
 Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 regressions@lists.linux.dev, table@vger.kernel.org, Bernd Rinn
 <bb@rinn.ch>, Karri =?UTF-8?B?SMOkbcOkbMOkaW5lbg==?=
 <kh.bugreport@outlook.com>, Milan Broz <gmazyland@gmail.com>, Cameron
 Davidson <bugs@davidsoncj.id.au>, Markus <markus@fritz.box>
Subject: Re: [regression 6.1.y] Regression from 476c1dfefab8 ("mm: Don't pin
 ZERO_PAGE in pin_user_pages()") with pci-passthrough for both KVM VMs and
 booting in xen DomU
Message-ID: <20250416142645.4392a644.alex.williamson@redhat.com>
In-Reply-To: <Z_6sh7Byddqdk1Z-@eldamar.lan>
References: <Z_6sh7Byddqdk1Z-@eldamar.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 20:59:19 +0200
Salvatore Bonaccorso <carnil@debian.org> wrote:

> Hi
> 
> [Apologies if this has been reported already but I have not found an
> already filled corresponding report]
> 
> After updating from the 6.1.129 based version to 6.1.133, various
> users have reported that their VMs do not boot anymore up (both KVM
> and under Xen) if pci-passthrough is involved. The reports are at:
> 
> https://bugs.debian.org/1102889
> https://bugs.debian.org/1102914
> https://bugs.debian.org/1103153
> 
> Milan Broz bisected the issues and found that the commit introducing
> the problems can be tracked down to backport of c8070b787519 ("mm:
> Don't pin ZERO_PAGE in pin_user_pages()") from 6.5-rc1 which got
> backported as 476c1dfefab8 ("mm: Don't pin ZERO_PAGE in
> pin_user_pages()") in 6.1.130. See https://bugs.debian.org/1102914#60
> 
> #regzbot introduced: 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
> 
> 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774 is the first bad commit
> commit 476c1dfefab8b98ae9c3e3ad283c2ac10d30c774
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri May 26 22:41:40 2023 +0100
> 
>     mm: Don't pin ZERO_PAGE in pin_user_pages()
> 
>     [ Upstream commit c8070b78751955e59b42457b974bea4a4fe00187 ]

It's a bad backport, I've debugged and posted the fix for stable here:

https://lore.kernel.org/all/20250416202441.3911142-1-alex.williamson@redhat.com/

Thanks,
Alex

