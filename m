Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEF1E871
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751339302; cv=none; b=KQn/L6u4jC8RVuB4n4V/2AdwrRLF8pUmvG/95Xv1XioWm7j20egqb/OsrhHQzVCMIdSt/B7ee8Ds9K5gfw1yJW3dW7s9/t7+W7pLxiyZYfVjW0py88gPc3kulR6nrOUIDtbCaooGZlL44oCDpEv17usJd9pN6axCAacMRvtnEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751339302; c=relaxed/simple;
	bh=TG919W3WLbrNAfldQXs79Vi/l7ajdooSPNiPLBL7f1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsmzCVsaLR+Kjqn4P/4nLor3psWSYvbu3VU5AMfDZ2RP6OEFrXTpNFb47HCOEJmtlyNjBElS9iQAwMxPEq/lS7fGQkTazKPspOJgnRVKbUUIazptEBiSLxYcwbp8c8waQWd6kzEniXa+0XxXBxJzeHIJiUTtKbywqt6vlKBQMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KABhFlTk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KABhFlTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751339299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFXBlEVxwZaLC+Deuza/d3yQuAe202fXVNYdYSEYk4g=;
	b=KABhFlTkQtOHZDLekGGeZJjPt+tCFwpxVYXl+TxhS6f6I8me18ixJXYM1TVJFoK2+0CsG4
	j87Nx59hISKI4uYWHkwbZkX9VlQ509Yd0iyX3pdDOtMAAy+GTUTOP59OCo7JToVwkJakL4
	DLbSRvnaO7FK1MAcf4+U/hdT9ZIPS/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-oxPAm6lmPNeOghFl-Mz2gw-1; Mon,
 30 Jun 2025 23:08:16 -0400
X-MC-Unique: oxPAm6lmPNeOghFl-Mz2gw-1
X-Mimecast-MFC-AGG-ID: oxPAm6lmPNeOghFl-Mz2gw_1751339295
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 606741800287
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 03:08:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D0C019560AB;
	Tue,  1 Jul 2025 03:08:10 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:08:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Changhui Zhong <czhong@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address:
 0000000000000060
Message-ID: <aGNRFXWX3JS6GAAy@fedora>
References: <CAGVVp+UZ5VUYvW4ZktoF055Wg=PXO5vico76O3f_iwnfcLb-HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVVp+UZ5VUYvW4ZktoF055Wg=PXO5vico76O3f_iwnfcLb-HA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Changhui,

Thanks for the report!

On Tue, Jul 01, 2025 at 09:55:23AM +0800, Changhui Zhong wrote:
> Hello,
> 
> the following kernel panic was triggered by 'ubdsrv  make test T=generic' tests,
> please help check and let me know if you need any info/test, thanks.
> 
> repo: https://github.com/torvalds/linux.git
> branch: master
> INFO: HEAD of cloned kernel:
> commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Jun 29 13:09:04 2025 -0700
> 
>     Linux 6.16-rc4
> 
> dmesg log:
> [ 3431.347957] BUG: kernel NULL pointer dereference, address: 0000000000000060
> [ 3431.355744] #PF: supervisor read access in kernel mode
> [ 3431.361484] #PF: error_code(0x0000) - not-present page
> [ 3431.367224] PGD 119ffa067 P4D 0
> [ 3431.370830] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 3431.375503] CPU: 22 UID: 0 PID: 397273 Comm: fio Tainted: G S
>            6.16.0-rc4 #1 PREEMPT(voluntary)
> [ 3431.386864] Tainted: [S]=CPU_OUT_OF_SPEC
> [ 3431.391243] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW,
> BIOS AFE118M-1.32 06/29/2022
> [ 3431.400954] RIP: 0010:ublk_queue_rqs+0x7d/0x1c0 [ublk_drv]

It is one regression of commit 524346e9d79f ("ublk: build batch from IOs in same io_ring_ctx and io task").

io->cmd can't be derefered unless the uring cmd is live, and the following patch
should fix the oops:

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c3e3c3b65a6d..99894d712c1f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1442,15 +1442,14 @@ static void ublk_queue_rqs(struct rq_list *rqlist)
 		struct ublk_queue *this_q = req->mq_hctx->driver_data;
 		struct ublk_io *this_io = &this_q->ios[req->tag];
 
-		if (io && !ublk_belong_to_same_batch(io, this_io) &&
-				!rq_list_empty(&submit_list))
-			ublk_queue_cmd_list(io, &submit_list);
-		io = this_io;
-
-		if (ublk_prep_req(this_q, req, true) == BLK_STS_OK)
+		if (ublk_prep_req(this_q, req, true) == BLK_STS_OK) {
+			if (io && !ublk_belong_to_same_batch(io, this_io) &&
+					!rq_list_empty(&submit_list))
+				ublk_queue_cmd_list(io, &submit_list);
 			rq_list_add_tail(&submit_list, req);
-		else
+		} else
 			rq_list_add_tail(&requeue_list, req);
+		io = this_io;
 	}
 
 	if (!rq_list_empty(&submit_list))


Thanks,
Ming

