Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCB44C506
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514953; cv=none; b=nSKn/Z8z4dV1/+rXKvp2C7V5ooySLrL4kfWde9quuhNxC0+Ue9Hpm8PtP2EB5eBVBAUMtyNZMLkT4aZFW9Y4+QqSvjzJvyoa2HKw/aUsjm83eHqGfET+fLlqlw5JvQufKMQx1DY8IT3ObY1hSN5QSS8mbVnVdnRSiFs4xpBi1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514953; c=relaxed/simple;
	bh=uNKTF7hi3kI77VnvWxpZyQTTpKFABnwfUPdYfzflGAg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=NpXfNRrA448JBB5a7+Fs9CSDsJlxe/KbRm+Ucwi/s4ctXCRVD4fM3tg5CiFrBooWH2UXzgn4kbJUrwzynpycaR3fhjnsgPyadt0bKhNRWvFEFSFDF0f8hMt4BkUpt8NCFTkDkoccxxAkWTZbB71EdZYyzXV/SYIMekHc7DH6zd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QP/qrNYp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QP/qrNYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788514950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EncRi7CACWzcZDUm6dP9BConJ0TmURWfz/UICDWBfdY=;
	b=QP/qrNYpMj+9dCzvqDFg/gbpFmLat4R4c4lmMTB+twtz+Wh7z8yXml1St9oLrq4rT8T1d8
	3bYOvUacvTqJt8iQV4tJc9PI9cLVGeglheGsVcZK1KH/zeiAWQrapamskxpjSzaD+diwdR
	8JaXhDimSiONbh1Sdo5GviqC/NeazqU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-fgX3DpTwPvS16Bzt7YAhvA-1; Fri,
 04 Sep 2026 05:42:25 -0400
X-MC-Unique: fgX3DpTwPvS16Bzt7YAhvA-1
X-Mimecast-MFC-AGG-ID: fgX3DpTwPvS16Bzt7YAhvA_1788514944
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6128D18CD29A;
	Fri,  4 Sep 2026 09:42:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44A1A362;
	Fri,  4 Sep 2026 09:42:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260902112743.GA11999@lst.de>
References: <20260902112743.GA11999@lst.de> <1819786.1787768317@warthog.procyon.org.uk> <1895550.1787777192@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
    Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix start and length check added to iov_iter_extract_bvecs()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <350211.1788514937.1@warthog.procyon.org.uk>
Date: Fri, 04 Sep 2026 10:42:17 +0100
Message-ID: <350212.1788514937@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Christoph Hellwig <hch@lst.de> wrote:

> Should this grow a comment explaining why for non-iov/kvec/ubuf
> we check the alignment of every sector instead of just the
> start alignment?

There should possibly be a comment explaining the need for an address
alignment at all.  Is it mandatory for all devices?  Or are we being a bit
over restrictive?  I don't think NICs capable of RDMA are so restricted, for
example.

Note that iov_iter_alignment() for ITER_XARRAY and ITER_FOLIOQ basically just
check iov_offset and count anyway as they refer to whole pages/folios only,
with just the start and end reduced.

David

