Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6063F1045;
	Sun, 30 Aug 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788048976; cv=none; b=Gc13A2qPgx6X68XHiCCbFF4pq4TXqDrXIAokqOzlGJ7q1EqxqkqfU0gIkXzv9Uo/SEVIDq+PtadK/lkpW2L3mB0550uUs9vldxhKWjzmH+lHnzvTIo5yGzbDfpnr0XtVj15loRn25H2CFxxF2l7gXtIkyPsfjS47x291enJssL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788048976; c=relaxed/simple;
	bh=hWPeW2bnlSHWE26VZa4Dkp1Om2W4eiJgpNIkNqvy3DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FUW/Kzs37oLfO+xHDx2fh9h8O6x/iOtYctLM8tWMGasekKyEDNzs5eDTarfqgCZtNy3dJFoKrknBrX7JWYyH1WKKCWl9XCIHuswAUy88X47rrPQvtzyRxW8PS/2x9HzlgEmFNvrqB4l4V6+iTNiqWMRcrLA7kXpzpH/nqLUQZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=k6bNDLmd; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="k6bNDLmd"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hXXj42bxzz1XM6JB;
	Sun, 30 Aug 2026 00:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1788048963; x=1790640964; bh=Wtaf/cIuCZ36ss7taFgx1buy
	K4QIVLCAsKiQ+IlDW54=; b=k6bNDLmdF8PiLDd0KSYU6RGXLC8sm7WKpn2f7exL
	sDSjBCbnRKi//MZZFX8sT6oG4VziYeWfptYUDgdtFAFW+caXcE0ABHezn7Ww8lsi
	PiKgnhCajWcMthWzEj/cc4KNkus/ovFRliLsJdZml5NHGMWLUPu99wDNzCBEobmX
	x70ohLdCgA6EI4i9Efr1/2xRuGgaQqy/fRWFI+B/SlzVa33JNRFRGDWwfJ0X5v+E
	2jszn1Ykhbs/tm4O2IeeRmvg3aQP0KjgXxjwnTHNIHMithzX/AlqNm8DoV7CQPg5
	+TiVmdeTHq6kuFm0SU1WweSOGYwG0TiIxb9RD7DKM2c4gg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LpLhf2E7jO38; Sun, 30 Aug 2026 00:16:03 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hXXhx4XnSz1XM6J6;
	Sun, 30 Aug 2026 00:16:01 +0000 (UTC)
Message-ID: <2cf45e85-176a-4209-86ad-8f389a9a4282@acm.org>
Date: Sat, 29 Aug 2026 17:16:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] BUG: corrupted list in
 blk_mq_request_bypass_insert
To: syzbot <syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <6a926eaf.1d9ded08.62e62.0102.GAE@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6a926eaf.1d9ded08.62e62.0102.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/26 10:31 PM, syzbot wrote:
> kernel BUG at lib/list_debug.c:34!
> Call trace:
>   __list_add_valid_or_report+0x144/0x148 lib/list_debug.c:32 (P)
>   __list_add_valid include/linux/list.h:96 [inline]
>   __list_add include/linux/list.h:158 [inline]
>   list_add_tail include/linux/list.h:191 [inline]
>   blk_mq_request_bypass_insert+0x130/0x1cc block/blk-mq.c:2551
>   blk_mq_requeue_work+0x3a4/0x52c block/blk-mq.c:1560
>   process_one_work kernel/workqueue.c:3322 [inline]
>   process_scheduled_works+0x788/0x10b8 kernel/workqueue.c:3405
>   worker_thread+0x798/0xbd0 kernel/workqueue.c:3486
>   kthread+0x304/0x3d4 kernel/kthread.c:436
>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838

If my AI assistant got it right the root cause of this issue is as
follows (I haven't tried to verify this):
* Concurrent calls of nvme_reset_work() and blk_mq_requeue_work().
* nvme_decide_disposition() does not check NVME_REQ_CANCELLED for
   non-multipath requests and returns RETRY instead of COMPLETE.

The same AI assistant proposes the following patch (again, I have not
verified whether this makes sense):

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e45a2789123..a1b2c3d4e5f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -425,7 +425,8 @@ static inline enum nvme_disposition 
nvme_decide_disposition(struct request *req)
  		if (nvme_is_path_error(nvme_req(req)->status) ||
  		    blk_queue_dying(req->q))
  			return FAILOVER;
  	} else {
-		if (blk_queue_dying(req->q))
+		if (blk_queue_dying(req->q) ||
+		    (nvme_req(req)->flags & NVME_REQ_CANCELLED))
  			return COMPLETE;
  	}

@@ -551,7 +552,7 @@ bool nvme_cancel_request(struct request *req, void 
*data)
  	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
  		return true;

-	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
+	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD | NVME_STATUS_DNR;
  	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
  	blk_mq_complete_request(req);
  	return true;

Bart.
