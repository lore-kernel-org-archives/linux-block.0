Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DD22AE5D
	for <linux-block@vger.kernel.org>; Fri, 21 Mar 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573665; cv=none; b=shBy52mb8CLeShfaNozNNZmNrlmFcHVSLFdafmULoxJMQPINlGTKKjpaGp2WAMFPv6wUYTtek+oaxxMxa5QkVE7JX6sKYHPc1GXSgxra94e84h1XqxybQp9ZOqwOjxwai84OARPPy7kAcajZL0VeDpdxlS5+ZM1S1b6M69MMflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573665; c=relaxed/simple;
	bh=E5flJCcw4QgcMHbG2/ZcWDVulabStm+nbnS5uKJa5d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4wgVZcz9WxehlF80Ixqbmi3SMvHrypbMS8tRBMtDaNrnynW4XS2WPFHHFDZsexUNYCqQoh6bF5HHKoQ+qdacYR30NGEYClGUdMk7F9OHopBj0cTIt4L/xp9i58A/BiUeHrDFQOBFpTkwdpCcrBya4EzdmdazKdJrTHhl/b+h8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxgipFuo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxgipFuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742573662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r/FYjqrm1cAaAJapi0Y0E/iGdoYerOobI/I6FmFCbNM=;
	b=FxgipFuoqgfj9HjyvRaNie2430mnDWBdasnx8yqmLT3yEJzycuCnUVv/Ty1FVzL8OSsJK3
	HeJKL0V0Kt+OELmjqnL/2nk1xNXi2FVsv1DwIaU/dWZHZAgIax/5hAMK8DZdudeDmMc2rk
	aS5XLNqpzfQ+/DlaTFqpJZb97kZ4TkY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-ZVfXcCV0Pz25ASpylU61oA-1; Fri,
 21 Mar 2025 12:14:17 -0400
X-MC-Unique: ZVfXcCV0Pz25ASpylU61oA-1
X-Mimecast-MFC-AGG-ID: ZVfXcCV0Pz25ASpylU61oA_1742573655
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CF751800259;
	Fri, 21 Mar 2025 16:14:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9D7F1801752;
	Fri, 21 Mar 2025 16:14:10 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Steve French <smfrench@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] iov_iter: Add composite, scatterlist and skbuff iterator types
Date: Fri, 21 Mar 2025 16:14:00 +0000
Message-ID: <20250321161407.3333724-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Leon,

Here are some patches that illustrate some of what I'm thinking of doing to
iov iterators.  Note that they are incomplete as I won't have time to
finish or test them before LSF, but I thought I'd post them for use as a
discussion point.

So the first thing I want to do is to move certain iterators out of line
from the main inline iteration multiplexor.  This code gets relentlessly
duplicated and adding further iterator types expands a whole load of
places.  So the DISCARD iterator (which is just a simple short circuit) and
the XARRAY iterator (which is obsolete) move out of line.

Then I want to add three more types, for now:

 (1) ITER_ITERLIST.  A compound iterator that takes an array of iterators
     of disparate types.  The aim here is to make it possible to fabricate
     an network message in one go (say an RPC call) and pass it to a socket
     without the need for corking.

 (2) ITER_SCATTERLIST.  An iterator that takes a scatterlist.  This can be
     used to act as a bridge in converting interfaces that currently take a
     scatterlist (e.g. crypto).  It requires extra fields adding to the
     iov_iter struct because chained scatterlists do not have have a rewind
     capability and so iov_iter_revert() must go back to the beginning and
     fast-forward.

 (3) ITER_SKBUFF.  An iterator that takes a network buffer.  The aim here
     is to render skb_to_sgvec() unnecessary for doing crypto operations.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-experimental

David

David Howells (4):
  iov_iter: Move ITER_DISCARD and ITER_XARRAY iteration out-of-line
  iov_iter: Add an iterator-of-iterators
  iov_iter: Add a scatterlist iterator type
  iov_iter: Add a scatterlist iterator type [INCOMPLETE]

 include/linux/iov_iter.h |  77 +----
 include/linux/uio.h      |  37 +++
 lib/iov_iter.c           | 675 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 710 insertions(+), 79 deletions(-)

