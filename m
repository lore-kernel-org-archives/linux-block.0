Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217464;
	b=0O81N+8O4ZTNxWr6eTcI0YMlYfWd/OEsXZmQa702fCTDt948WuNWKhGmL9jVlNr2BuHe
	 6wb6CUl17XNbIqzmIudf/0JTIGbLre8JjF3p7YguliGSJMhhtQ3gDOe6htbLJX/5Ql5z4
	 LMZgmOPoRW7qUJ4M9sfSjXd2KA+0qtmRXbn5lgDScYHP33MmlwyaV32y0EvN7vyeYRgdW
	 vJab62KfgDZQU+D25ouFewfavEOIL/JUoaJwqx/GYyU1TI9n0Hg4tL1V+UcftmNV+rANC
	 FqA2spEf41gEvhZvT7gxqdb99Hg5ONkvs4PR7Dn9quaY8VYpTCVi3EpltU8cue1dVgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=THGERwj4+rvUdJevkF3LGq6iIV4UzU198SJpdF9zEgc=;
	b=oa2ycHa2yVyhiIPR/wBNenvFtlmUpaA4/dFbzETA1eT4cqb7pcVu2DQYWuQ4iU4AQzJX
	 H262erpx0wtxwTNnAttJt1IeO500rkB6EOuQFVTcGprCMhoRBhu6bYjRdy8RfJ4YBn2Gu
	 7o9SPD+2QEqLhLxayoEbi8lpuJn3z/DhpbWW939Lxo9LNrymkHqGS5N2ajPu+df9FKTt5
	 nPvwZRIPO+kLPcCkeWbg+pSqHDm9IgrtJXOIut6QeRxuBS3CTdm/SOo8E1lPfOJqZPbQe
	 UkNl/q5HjlQQqf14DM10tY6dWWh+eboIWDXoX+4/jqxkuC+jUXS/PoE7/2cyhozX97g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Qn87fwqz;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35317606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35317606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Qn87fwqz
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jFJ7C6Gx7z1XM30r;
	Wed, 28 Oct 2026 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1793217461; x=1795809462; bh=THGER
	wj4+rvUdJevkF3LGq6iIV4UzU198SJpdF9zEgc=; b=Qn87fwqzYwP74daneXgxy
	u1egjiXGWVQkG2u0q/yRiYtH7DDDkXtEQ4VKeKkoSGUt14k4KTdVOpHDU5og1ukQ
	80yQ/jXUck4cqst8JnAd1bLujJl+NNN1gH9oj0a/I1vekSI3uzd+9jwrN/TgykU2
	HaIiv+Gm1gmhtv5czt/HCvQ8SRwSnZp3WqpfabrxKizz5JHmyVAVt4bd4OmJwHTq
	TY4cLPpfTYW6s1c0kPI9mCikbE0ja6z/Q8XHWe5CjiXp4SebMgfG7rFxE9lfOaSm
	MEraW6Ojg6jsq6ObCiKHaYT9LCTqiVNhTljIjMfUHBUhdDvlOfi+JfylAWg1Bw8E
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nh3JYeMFhf81; Wed, 28 Oct 2026 19:57:41 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jFJ792P8mz1XM4Tn;
	Wed, 28 Oct 2026 19:57:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 20/98] mtip32xx: don't mark the disk dead in the irq handler
Date: Wed, 28 Oct 2026 12:57:14 -0700
Message-ID: <20261028195731.1591331-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
In-Reply-To: <20261028164415.1262013-21-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-21-axboe@kernel.dk>
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
> @@ -2492,6 +2512,9 @@ static int mtip_service_thread(void *data)
> =20
>  		set_bit(MTIP_PF_SVC_THD_ACTIVE_BIT, &port->flags);
> =20
> +		if (test_and_clear_bit(MTIP_PF_SR_BIT, &port->flags))
> +			mtip_check_surprise_removal(dd);
> +
>  restart_eh:

Deferring blk_mark_disk_dead() out of the hardirq handler is needed, but
calling mtip_check_surprise_removal(dd) -> blk_mark_disk_dead(dd->disk)
in mtip_service_thread() before aborting in-flight NCQ commands can
deadlock when a filesystem is mounted on the device:

1. blk_mark_disk_dead() invokes fs_bdev_mark_dead(), which locks
   sb->s_umount via bdev_super_lock() and calls sync_filesystem(). If
   another task already holds s_umount while waiting for in-flight I/O
   on the dead PCIe device, mtip_service_thread() blocks on s_umount.
2. In patch 22/98, mtip_pci_remove() then calls
   mtip_stop_service_thread(dd) (kthread_stop()) before calling
   blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd), so
   mtip_pci_remove() blocks waiting for mtip_service_thread() before it
   can abort the in-flight commands holding up s_umount.

Quiescing dd->queue and aborting in-flight commands via
blk_mq_tagset_busy_iter(&dd->tags, mtip_abort_cmd, dd) before calling
blk_mark_disk_dead(dd->disk) on surprise removal would avoid that
deadlock.
