Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217466;
	b=QUVFu40m0WfcNFOsmVTwRsPlpr4vjyTKYxXkWZXaJmQ7QWoCN/K+CfkAFeFqniVb0qzi
	 4m0D/hRkD/AsC2jXCYsf17e/VVVco8Aob1rziYhRnZ42elx2lZkyD4H4KVTmgVhEYMsfN
	 /rgfjrZ+43UDC5ZDCEmMrWYRPYALWb7PehJJJv314Bt+8dsmGp5is5n0itcaSgQHYSQFS
	 rpbYHvLkHsPVujxfTu1xUvGqMFp6Q4urcjvXQd+Bi1rFnfh6b/54Fu7yiLCRw+AprcpEk
	 KXIK3E2kszs2XN1vmnSBxgVI6PxhzdiuWVVt6leKQZCYygm5eql4w/eVqQmek+69vLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2lRW0xK/AUpn0ALt+7BUc9uK2Pq7DhkUa2q9nwbV0js=;
	b=vOiA3Nn95yy7u8fDIRrLNHXsXnx8ILJVoqSbF4hvEZ+Z7KV5/bXmrb5viC9TSQfJ8wZi
	 AEZVZJ+1FiihDdUDR0+NMMuMsbNjiUhpjOuV9moHeYnN/fEy9sRuvMBgrpZ4nWuNqpdcD
	 HIB5OMCUvcSUzNlpjq4JUrofi35AzVmafM7HKX3/I/d3NFUwLr/wM4lDZaP/9u7sAFtFJ
	 SUAAo+yADMt0GDoQ6rUZSdXUdPAgcxrZ84hpWxAjYRFofAyuHV4AZltyu55sdkFg6Vc/2
	 K6O+Gbg6L9tlpJxKGmbGEu+ZIMD/733DTwKDrI0BQyr+dcjHK1EWOgEYHPxV2K9OUCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ElYGs8Jm;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1D606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD1D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ElYGs8Jm
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7F670Sz1XM30r;
	Wed, 28 Oct 2026 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217463; x=1795809464; bh=2lRW0
	xK/AUpn0ALt+7BUc9uK2Pq7DhkUa2q9nwbV0js=; b=ElYGs8JmUXWQy14ccyj8z
	o04ysOui3DgP8WkGWUgHWUHRNmBy/cGr0EWxGvnmtW3huXdDTD6EhAmhfdMQVdzS
	Mx98vUamX+X3Cy4Ra1eogbdzYompv2VgnorMPvzv72ff4C0ITKv2JJjZ+mwMG56O
	V6vdM2uz4UDDzaAYyl0vaBHhXW/NUauLAjdkqTFzXTVpuZbr7T72rOxnfUC6zBA2
	jDjZvOwRdExkuerGe5F+V4s9bOfYWqcNQmcHggJBh7mIB9yGmlFzQyus3uWn3UU5
	OS2yiM0cjJgHEFmQl1XFyOKVmtCmIohjDWlPL9TTCmM5kiVmtvZnCQLC1ohvk8hY
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2saLAwwRHIqv; Wed, 28 Oct 2026 19:57:43 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ795nwFz1XM5kD;
	Wed, 28 Oct 2026 19:57:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 22/98] mtip32xx: abort commands in flight on surprise removal
Date: Wed, 28 Oct 2026 12:57:15 -0700
Message-ID: <20261028195731.1591331-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-23-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-23-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/28/26 09:41, Jens Axboe wrote:
> +	/*
> +	 * Nobody will complete the commands a removed device has been given,
> +	 * and del_gendisk() waits for them.
> +	 */
> +	if (dd->sr) {
> +		mtip_stop_service_thread(dd);
> +		blk_mq_quiesce_queue(dd->queue);
> +		blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd);
> +		blk_mq_unquiesce_queue(dd->queue);
> +	}
> +
>  	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
>  		del_gendisk(dd->disk);

Two issues with this ordering:

1. Calling mtip_stop_service_thread(dd) (kthread_stop()) before aborting
   in-flight commands can deadlock with patch 20/98 if
   mtip_service_thread() is blocked inside blk_mark_disk_dead() ->
   fs_bdev_mark_dead() waiting for sb->s_umount while the s_umount
   holder is waiting on those uncompleted NCQ commands.
2. If PCIe link loss occurs after mtip_pci_remove() has already checked
   if (dd->sr) (false) and entered del_gendisk(dd->disk),
   MTIP_DDF_REMOVE_PENDING_BIT is already set. mtip_service_thread()
   then exits immediately upon seeing MTIP_DDF_REMOVE_PENDING_BIT
   without handling MTIP_PF_SR_BIT or MTIP_PF_TO_ACTIVE_BIT, leaving
   in-flight commands uncompleted until the request timer fires.

If mtip_service_thread() aborts in-flight commands when handling
MTIP_PF_SR_BIT (before blk_mark_disk_dead()) and does not exit early on
MTIP_DDF_REMOVE_PENDING_BIT while surprise-removal/timeout work is
pending, mtip_stop_service_thread() can stay after del_gendisk() and
both races are closed.
