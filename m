Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08E1FCFF3
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908949; cv=none; b=ehdK4Gd87PVAUWeXQ+Ps/SMH0B9Ys9+2+Gxwzw7XaN18Qab3lGj3+i0TD2fQAlZv7AAGxhh86ntKLKaUpAXJsvdRH/NXUCTR89MIM5lsOYeffgYIDsHnz0PQfAypUkB4ZvVgqiAmxVZKxJo0Xoc8LIx+rogoOirajolALapJJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908949; c=relaxed/simple;
	bh=uny3v++/iPmenzGDz3NHnhj0MBwuYiajQoqDAzVy0pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkiE/lqFk+LfwW6AjzDcJ1796otutIOvj0A+toYybII1AWLAUFnOVjAey8CQLf3H/a6W4oZLRdYsmib1mCq9JB0MurjPwk51o8vmy715SKowCNOqoc4GM0g7Y1pCEUpi019e1To7heEMnatwjJZrJJSAhtWlv7Ov+KhqhyN556M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgSNdS9B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgSNdS9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cCZDwnJsjHU0vEGdI7THy8y1XEAMyhcYhOuUJ0O6NiA=;
	b=JgSNdS9BCEu2dumhwWrO7mXS4cwVTirE01mKWFdTXFpfxFHSNepA1l30YLnwORUEtXJTqV
	731v2SGxhfQL/8+iAbK4AHBBgfFA19Oz3g/k/X1lKDGK0qSJk4Sbx31QoHX90qLsv0BqVN
	RfFzkMnQStemPwpVwjZ1J2NfGFmk1dI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-EjBfogNUNre6JggkmeyI-w-1; Thu,
 13 Mar 2025 19:35:42 -0400
X-MC-Unique: EjBfogNUNre6JggkmeyI-w-1
X-Mimecast-MFC-AGG-ID: EjBfogNUNre6JggkmeyI-w_1741908941
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35D461955E90;
	Thu, 13 Mar 2025 23:35:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFE501955BCB;
	Thu, 13 Mar 2025 23:35:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 30/35] netfs: Make netfs_page_mkwrite() use folio_mkwrite_check_truncate()
Date: Thu, 13 Mar 2025 23:33:22 +0000
Message-ID: <20250313233341.1675324-31-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Make netfs_page_mkwrite() use folio_mkwrite_check_truncate() rather than
doing the checks itself (and it doesn't currently do all the checks).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 12ddbe9bc78b..64a0f0620399 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -506,7 +506,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	if (folio_lock_killable(folio) < 0)
 		goto out;
-	if (folio->mapping != mapping)
+	if (folio_mkwrite_check_truncate(folio, inode) < 0)
 		goto unlock;
 	if (folio_wait_writeback_killable(folio) < 0)
 		goto unlock;

