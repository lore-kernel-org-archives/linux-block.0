Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6A1CACE1
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061023; cv=none; b=KU2XFMPVbF3uXHPU2JDXvHmPtUvZ7AiP2uly7ITJaPmrS9udlAzD5xpKhkiojeulJtOW2h9GGUbNTr7r6LBWfdLlBCR/zGImKU6AnWX/Hco+C9VST3X0Vzqi8b+JQBS3sJqQB1bx3wXP+bOY/P6oNFiShFUTgiPEAjRtyM3vOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061023; c=relaxed/simple;
	bh=LC5opBzsfMWT+Woxf6ql+szBwJm4lOK2uFmK2/got7M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=gs+23ipueNX5dwHQhES/HhK9QStJjWXYaZ8zQegmMPpUQ+OwXVUNKkITgbE5VzJn7TKUhx+xLT1LFQf3SFi3fOvtVQ4RvsQWhCkDxaQ/eKJf6rlEkI8iut92vb6JVk3mZvZoHvhj2UX/0+0xhltlukwtEdX5c8ctv9b401HiUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUi85u3A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUi85u3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728061021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpJ30SXry5ywItaI0zm3pCFPe4HCY3tu4N9t4xI5rt8=;
	b=OUi85u3AOibRI+zLvCspJAyfae3KhXEGUtXs//2+E/68OMwhpqpZoeTzKpQA8FTzkZZ9oq
	ZfmZsIP8Fd7S1soAmSs6vecCEgvXL4LD64T1gyFzVklVCc8jyd8KDQIbk8z4LC3KFEJGjs
	/S/CRTaO5Vwrr/tTRCDi51s9x6xrHCY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-QZcaDm-GPOmeyaH_zzULWg-1; Fri,
 04 Oct 2024 12:56:58 -0400
X-MC-Unique: QZcaDm-GPOmeyaH_zzULWg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62DC019560BF;
	Fri,  4 Oct 2024 16:56:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4435B19560AE;
	Fri,  4 Oct 2024 16:56:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241004153025.1867858-1-ming.lei@redhat.com>
References: <20241004153025.1867858-1-ming.lei@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/iov_iter.c: extract virt-contiguous pages in iov_iter_extract_bvec_pages
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3855841.1728061012.1@warthog.procyon.org.uk>
Date: Fri, 04 Oct 2024 17:56:52 +0100
Message-ID: <3855842.1728061012@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Ming Lei <ming.lei@redhat.com> wrote:

> All iov_iter_bvec() users only want to extract virt-contiguous pages from
> iov_iter_extract_pages() instead physical-contiguous pages.

What do you mean by "virt-contiguous"?  Virtual according to what mapping?

The reason for physical contiguity is that you can pass a set of physical
contiguous pages as a single DMA descriptor.  Therefore, at some point, you
might end up screwing up skb_splice_from_iter().  Currently, that's limited to
a PAGE_SIZE per fragment, but hopefully that will be fixed at some point.

David

