Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755194;
	b=vq59UF9xvzctjJUWAy36+rLz8oOk9qOOuGHiFC/E2rdzf2+mWLR55XNNRZTKgVgTTSsK
	 pD9K2QMYSXfMk6PBSWzhbgrbKvas++Qo6StHbssNPwvI4REXg/uqUUgVxa5oR8GQar/og
	 Hv1hUwKQjQ/vKgfJo71BfTlPpf+U3PQQDR97UfJk8e9OUF+0UvKUxqqmR4yxe+9XRznQ2
	 ZBNrjQfCQB0VLtV29yOpR2F7JWKR5/R0a5cbx1h4yvJ0caje162Sev6pAptPFPvybpfJB
	 1Ps7L7Bn3UGHAN3wz9uENVQktPETnEV85jxjHahTKref5/sqbrQ6akia73Wa7o0dk5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=K9BqnHlCXjZok/ucFEH1v9EKCrkNusRBhmgnC0ZQ8/M=;
	b=GMXF5az4g8LfN9qnZbd6fMCPm9ck/vx2Plm6juwMJEjnn6mj640E2C89A4GjGmpYUIHf
	 ySeHGqm/Ghrjr0n9ADBBtRVyofZVRYtdVX7jMwR38CTMgY266eM2aCNANCIC7HjVxwFBF
	 pMCtNbpL5btwVoflRK6jjeoWDfxFbRl6aWL1xUt22VqOKvmuCv1P7PsiBDdZShnsoID61
	 c3ZJ/Iuw/sgPbcpdBLlezrZNFnG7QB3LMvyztQ34Ab+AzQq9X818oFVMuxzPJcHCgn0Ce
	 YfIaJHYRWCtHcnIVoqBaCRQHYvL18wOAMux0TeTmU8EURa46vHvJcbRTv8DseC7/1AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=W6+cHY57;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9CB606A31D
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 15:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B9CB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=W6+cHY57
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jSDpx5cN2zlpHx8;
	Sun, 15 Nov 2026 15:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794755191; x=1797347192; bh=K9BqnHlCXjZok/ucFEH1v9EK
	CrkNusRBhmgnC0ZQ8/M=; b=W6+cHY578n34fbg1s7KrYAyvOxIvEcYPNNn7DbPG
	ENf9cAfYt7SomGzV7OfNPAraJqhXk3ygqJJLFLoxkKnoBBQTk6Xv/nCelHou4zr/
	bPXwszFBy453F4+GKQGZHmHk3C6V2zGTUpKaFsp6Ol/SzEDkSTsua5ITTdU6JzgU
	OIIQI5qG6c4L2yUn1vph+mSf1Zy8zi0m84Xc+EK10rhtzadUZ+oDZule8u7DO4EF
	QSl+Xyk4+HJjXJlpQbBCsJVd9EE8bx4CJDc+lQq3VDzDfCmy0k1KjObQgiZ5taeO
	/LMTWtB6HzTPjNmNMvKGPOIsqMuLutDHWf0lFA1emfMTjA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PLzPAMf0n7FW; Sun, 15 Nov 2026 15:06:31 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jSDpv1H6lzlfcm6;
	Sun, 15 Nov 2026 15:06:31 +0000 (UTC)
Message-ID: <1ea4f9b3-4ff3-4d0e-b284-a086a033516e@acm.org>
Date: Sun, 15 Nov 2026 07:06:29 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-flush: fix possible deadlock when process
 nvme_timeout()
To: Ye Bin <yebin@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
References: <20261112135019.3290131-1-yebin@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261112135019.3290131-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 5:50 AM, Ye Bin wrote:
 > The root cause is that the flush-rq is moved to MQ_RQ_IDLE only when its
 > reference count drops to zero, which was introduced by commit 
9f16a66733c9
 > ("block: mark flush request as IDLE when it is really finished"). When
 > the last reference is held by a request iterator - here
 > blk_mq_timeout_work() iterating tags and running nvme_timeout()
 > - flush_end_io() returns early and leaves the request in MQ_RQ_COMPLETE,
 > so the very same timeout flow spins forever in
 > blk_mq_tagset_wait_completed_request().

This analysis looks correct to me.

 > Fix this by marking the flush request as IDLE as soon as flush_end_io()
 > is invoked, i.e. restore the behavior introduced by commit 65ff5cd04551
 > ("blk-mq: mark flush request as IDLE in flush_end_io()"), which aligns
 > flush requests with normal requests: blk_mq_free_request() also sets
 > MQ_RQ_IDLE before the last reference is put.

flush_end_io() is not only called from the completion path.
blk_mq_put_rq_ref() calls flush_rq->end_io() whenever a tag iterator
drops its reference, e.g. from blk_mq_timeout_work(),
blk_mq_queue_inflight() and blk_mq_tagset_busy_iter(). This also
happens for flush requests that are still in flight. With this patch
applied, such an iterator changes the state of an in-flight flush
request into MQ_RQ_IDLE. As a result:
- The timeout handler no longer detects that the flush request timed
   out because blk_mq_req_expired() requires MQ_RQ_IN_FLIGHT.
- nvme_cancel_tagset() skips the flush request because bt_tags_iter()
   only visits started requests if BT_TAG_ITER_STARTED has been set.
- blk_mq_queue_inflight() ignores the in-flight flush request.

In other words, this patch reintroduces the bug that was fixed by
commit 9f16a66733c9.

 > - The use-after-free that the above commit wanted to avoid predates
 >   the per-request reference counting model, under which a request that
 >   is still referenced can no longer be reallocated beneath its holder.

This is not correct. Flush request reference counting and calling
.end_io() from the timeout path were introduced by commit 8d6996630c03
("block: fix null pointer dereference in blk_mq_rq_timed_out()") in
2019, before commits 65ff5cd04551 and 9f16a66733c9 were merged.

A few additional comments:
- Please improve the patch description. "There's when process
   nvme_timeout()" is not a proper English sentence, several paragraphs
   have a leading space and the call trace is much longer than needed
   to explain the race.
- Please include a changelog below the "---" line when posting a new
   version of a patch.
- The new source code comment duplicates the patch description. Please
   make it shorter.

Thanks,

Bart.
