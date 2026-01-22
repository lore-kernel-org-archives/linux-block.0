Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151D28751D
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053703; cv=none; b=sTgZOfBSRJ/7mbcwI+xvUqF8W0JUeZAKsmQ9TN1/9xt4cArjPR4+dhSmPNZdsb4VjRSZ0NF4Nz6xF+9Hwa1TBngNkRN/YfET6rxK2/vfMo9pPJqSYMZ1qjiJrBqRnTCOGQM9Xg36HjdFcXCvYl4RPtq5jvYGfT0QWqaEQwNN0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053703; c=relaxed/simple;
	bh=n3kJZZIMXVdNaYgyQQRikD/9cVz4nm+ZBRmt04BQc5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9IBf0IPWbDs635VQITuSjWKka69//ESrx2hoKtZ7ByyLdD5QnCK0bMpcgd+88AzAFEibxtI1LPJc+8cI3WWoaLZGKBeBqTnXI0baPA0T/XIQrkc6FnJZum+yy2s8Id4yMXoCcHFGZFGEJSH79Z+ZsrFgF9bpN8n8PiTgZgZlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rkms7KgB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rkms7KgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769053700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY1UDeMx6rM0zMCWaEjEeBzqhjFrDAC2J3qUJXIR/AA=;
	b=Rkms7KgBz8hjVoRPTB1R05b3YDsGXIHa9441ynvP8tZN6BM5lWY3i9uMUtyObwZ5WIUh2N
	ErLIqcv/5dox5q0k4UskIUXyrqME0KkQuKYe06+a62bU4crD0QYE0TwtRyB4LfWDPgB5Wy
	S6xSgzI+4PTAA79UFohu+Pu1lBC6XIY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-zI3l2cyPMYKAhP2VbJoC5A-1; Wed,
 21 Jan 2026 22:48:19 -0500
X-MC-Unique: zI3l2cyPMYKAhP2VbJoC5A-1
X-Mimecast-MFC-AGG-ID: zI3l2cyPMYKAhP2VbJoC5A_1769053697
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3087E1956096;
	Thu, 22 Jan 2026 03:48:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56AA71800577;
	Thu, 22 Jan 2026 03:48:10 +0000 (UTC)
Date: Thu, 22 Jan 2026 11:48:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, fengnanchang@gmail.com
Subject: Re: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU
 in nvme_tcp_poll() on the latest linux-block/for-next
Message-ID: <aXGd9vPeFOBgyrrG@fedora>
References: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
 <aXCT9sFChMdhwNYw@fedora>
 <CAHj4cs-VK+W6UXeiiTdarw+MoFtn4xe9diU3CtHXaRy7kGQxgQ@mail.gmail.com>
 <CAHj4cs_BWMOsn7MwNc=YNsmN=TM_r8WK_o2qa3DedqA4rtHefw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs_BWMOsn7MwNc=YNsmN=TM_r8WK_o2qa3DedqA4rtHefw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jan 21, 2026 at 10:15:56PM +0800, Yi Zhang wrote:
> On Wed, Jan 21, 2026 at 5:03 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > On Wed, Jan 21, 2026 at 4:53 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Wed, Jan 21, 2026 at 10:50:00AM +0800, Yi Zhang wrote:
> > > > Hi
> > > >
> > > > This issue was observed on the latest linux-block/for-next during CKI
> > > > test, where enabling the poll queues leads to a tight busy polling
> > > > loop and 100% CPU usage during "nvme connect".
> > > > It seems was introduced from v6.19-rc1 and cannot reproduced on v6.18.
> > > > I will try to bisect it.
> > >
> > > It may be related with f22ecf9c14c1 ("blk-mq: delete task running check
> > > in blk_hctx_poll()").
> >
> > This commit merged to v6.19-rc1, I will revert it and retest.
> >
> 
> Hi Ming/Christoph
> 
> Confirmed the issue was introduced by this commit.
> 
> f22ecf9c14c1 blk-mq: delete task running check in blk_hctx_poll()

I guess the need_resched() in blk_hctx_poll() is still not enough, and it
may burns CPU too aggressively, especially for this in-kernel special sync
polling from passthrough request in nvmf_connect_io_queue().

Please try the following patch:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a29d8ac9d3e3..968699277c3d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1480,7 +1480,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		blk_hctx_poll(rq->q, rq->mq_hctx, NULL, 0);
+		blk_hctx_poll(rq->q, rq->mq_hctx, NULL, BLK_POLL_ONESHOT);
 		cond_resched();
 	} while (!completion_done(wait));
 }
-- 
2.47.1



Thanks,
Ming

