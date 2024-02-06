Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E31EA6E
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218060; cv=none; b=ilA64yUHhJf22kEZpr+chnF1zp6cf2VQNeTJhI09sDMee+BASJEWcFfd1aTLMrucvwT0o/apGg4Z4O2Nxg4aG1NOZsHo7vmH4hMfO3BqsgydTcB30eIw9jYIezyXypLigcF2hj6/sWyfXg9colJ+dIER/V9kLZZBme5Qj5At2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218060; c=relaxed/simple;
	bh=y6F0YZtvx+4ZqKYpfCHwiZ4vBkwy8kELU1jZ2jjQgvU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=DnYWXOM4IZIW2gUtVLDStHs4l7CExLfnexM0oJMSfdQsTGkB+Ih/K8Bvz8y8Bcxt0dRFI5yGpUI1jYq6ei9WL/h/v3utTNBLKHRqylB4DyPJwNAFJULumwZrg41+FLSAai6BmLz+xUXN2Cn2WEuZmWnwajmFmJCilkxaj5ZuVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtuMpZuT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtuMpZuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707218057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/ntzNpz+6Sgq7AVWsy2aHZ0gba7Y0+eYt9MHdhSDVMs=;
	b=gtuMpZuTsyRz2pdKFG74K9yVvF8onQZFRjCUb68T+Ng7fJdeWS5Ge937pALZtIQ5lLAd3u
	JoBtoRjHZl44Nbi68RbbngJYW6qTm7v1/Yzazkpuk+WdKWA60QCfG+UVODW3fPEfwLw/WM
	yh0+yI0xtxDvviflR6J4JyrwbTMbSiA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-nT3IX-KJNZ-FglI_WAgiAw-1; Tue,
 06 Feb 2024 06:14:16 -0500
X-MC-Unique: nT3IX-KJNZ-FglI_WAgiAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CEFA1C068D6;
	Tue,  6 Feb 2024 11:14:15 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B5B94AC18;
	Tue,  6 Feb 2024 11:14:14 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 9437530C1B8F; Tue,  6 Feb 2024 11:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 901703FB4E;
	Tue,  6 Feb 2024 12:14:14 +0100 (CET)
Date: Tue, 6 Feb 2024 12:14:14 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
    Christoph Hellwig <hch@lst.de>
cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
    Mark Wunderlich <mark.wunderlich@intel.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    Helge Deller <deller@gmx.de>, John David Anglin <dave.anglin@bell.net>, 
    linux-block@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH] block: use the __packed attribute only on architectures
 where it is efficient
Message-ID: <78172b8-74bc-1177-6ac7-7a7e7a44d18@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

The __packed macro (expanding to __attribute__((__packed__))) specifies
that the structure has an alignment of 1. Therefore, it may be arbitrarily
misaligned. On architectures that don't have hardware support for
unaligned accesses, gcc generates very inefficient code that accesses the
structure fields byte-by-byte and assembles the result using shifts and
ors.

For example, on PA-RISC, this function is compiled to 23 instructions with
the __packed attribute and only 2 instructions without the __packed
attribute.

This commit changes the definition of 'struct bvec_iter', so that it only
uses the __packed attribute on architectures where unaligned access is
efficient.

sector_t get_sector(struct bvec_iter *iter)
{
        return iter->bi_sector;
}

with __packed:

0000000000000000 <get_sector>:
   0:   0f 40 10 1f     ldb 0(r26),r31
   4:   0f 42 10 1c     ldb 1(r26),ret0
   8:   f3 ff 0b 18     depd,z,* r31,7,8,r31
   c:   f3 9c 0a 10     depd,z,* ret0,15,16,ret0
  10:   0b fc 02 5c     or ret0,r31,ret0
  14:   0f 44 10 15     ldb 2(r26),r21
  18:   0f 46 10 14     ldb 3(r26),r20
  1c:   f2 b5 09 08     depd,z,* r21,23,24,r21
  20:   0f 48 10 13     ldb 4(r26),r19
  24:   0b 95 02 55     or r21,ret0,r21
  28:   0f 4a 10 1f     ldb 5(r26),r31
  2c:   f2 94 08 00     depd,z,* r20,31,32,r20
  30:   0f 4c 10 1c     ldb 6(r26),ret0
  34:   0f 4e 10 16     ldb 7(r26),r22
  38:   0a b4 02 54     or r20,r21,r20
  3c:   f2 73 13 18     depd,z,* r19,39,40,r19
  40:   f3 ff 12 10     depd,z,* r31,47,48,r31
  44:   0a 93 02 53     or r19,r20,r19
  48:   f3 9c 11 08     depd,z,* ret0,55,56,ret0
  4c:   0a 7f 02 5f     or r31,r19,r31
  50:   0b fc 02 5c     or ret0,r31,ret0
  54:   e8 40 d0 00     bve (rp)
  58:   0b 96 02 5c     or r22,ret0,ret0
  5c:   00 00 00 00     break 0,0

without __packed:

0000000000000000 <get_sector>:
   0:   e8 40 d0 00     bve (rp)
   4:   0f 40 10 dc     ldd 0(r26),ret0

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 19416123ab3e ("block: define 'struct bvec_iter' as packed")
Cc: stable@vger.kernel.org	# v5.16+

---
 include/linux/bvec.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/bvec.h
===================================================================
--- linux-2.6.orig/include/linux/bvec.h	2023-09-05 14:46:02.000000000 +0200
+++ linux-2.6/include/linux/bvec.h	2024-02-06 11:49:56.000000000 +0100
@@ -83,7 +83,11 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-} __packed;
+}
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+__packed
+#endif
+;
 
 struct bvec_iter_all {
 	struct bio_vec	bv;

