Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884226;
	b=Z3OTCjs03MFJpM+YiJt/tiUCu1WpRzUAquUeVAsZsYByapCqbXhiLHhdJY4XKkg6bPJb
	 rJPzASZ99EUmNypS3qGWdE4xbvZfsEhtsntOKtcaKZ1/nZiDpJYOzMUACxI3lD1Uq1oqi
	 QBGc1zdk3EiVHcJfVIwv38bHwpDTGwLFKwjZabrCbGb2H1VU22vA+YI0SNKOaZvek3i1z
	 LrBQRQqpxmxedAh3r4jqkkPX6Mani5Y/cpK8iKXku//P/L7ScglCv4MaUWGtI2BM1mxVM
	 IvU7sbljvxu0ypK/KbBOJOP8eYHCnB0Oq5Pv6UQnbm3sT6tCvtHbFtXqLDRUKMDAQFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884226;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer;
	bh=H+W8VLD35JYBchsjwLqIneI/2/pBJGvyqvo7Y3mgx4s=;
	b=Gx13V421UHSkXxhc9r88y/zGGJznjh9Wjkz1CwWAvufDpbGoz5K4aPW3JK/K/RtNe5Mr
	 EADD6CoXi4JWfpGweh+3xRjDzVVrjfXxaWWOAuNvyBWw496MMIi8tn+/pG1h3G4hHC9L9
	 dSUfhHcPflLdaK/IlYlVFuGRxow07Q1/9sz0NtGPmtmsiQenHkYLO12ooYjY0rf1KqvRR
	 dwptHM/3tqvF858D/6hqObXClDAuUr6HnW+C06NmVCeRWCDUYINFkznrVIdfHEkPALQpy
	 BAZQYCowzJ1TPA18EzJI9v6oeLMCF5tbXJXsUu0l5Gt7lFIQGeLGMTXIqqJohmsyYow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sWb7tFVu;
	arc=none smtp.remote-ip=95.215.58.39
Received: from mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6320606A323
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 02:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6320606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sWb7tFVu
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pjmw2DXdHjzYOG43hIsqQG79giXui/V+G7YocSUZJKg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794884224; v=1; x=1795489024;
 b=sWb7tFVuz8BCB2MYqCSJLHg41ub5xhTloj6/GO7jTCUtIVYzMW/Zd7qrVNO7EovXFtfcnj3q
 bbbrKhOlBODDOVJZ26RphplCxRXTV/vdTOa4PtVqFY67wXFmvXH/EfNufsIJ3ojr5DsWmr7pPVj
 d9K8ktUwPpopuJ4u2pp4CL4Q=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3c523f9f826b9f15;
	Tue, 17 Nov 2026 02:57:03 +0000
X-Mizu-Trace-ID: 3c523f9f826b9f15
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v3 0/2] block: make changing to the current I/O scheduler
 cheap again
Date: Mon, 16 Nov 2026 21:56:53 -0500
Message-Id: <20261116-bug-block-elevator-unchanged-v3-0-cb4dda2dadf4@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbC+2oC/43NwQ6CMAwG4FchO1vDCgJ68j2Mh0ELLJLNbLJgC
 O/uwAs37e1v/n6dhWen2YtLMgvHQXttTQzZIRFNr0zHoClmgSkWMg7UYwf1YJsH8MBBvayD0Xy
 rBKpoCKksJGWViMTTcaunjb/dY+61jwfv7VuQ6/ZPOEhI4VRl8lzVlDPK66DNOB2Jg1jhgHss/
 4HhiinZckkltirdY8uyfAC4d341FQEAAA==
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.13.0

Writing the scheduler a queue already uses to queue/scheduler takes
about 10 ms and freezes the queue, which stalls I/O on live disks every
time a udev rule or tuning tool sets the scheduler unconditionally.

Patch 1 stops requesting a "none-iosched" module on every write of
"none". Patch 2 returns before freezing the queue when the elevator
wouldn't change.

On a null_blk disk (median of 20 writes, all kernels measured in the
same run):

  operation                   base (ms)  patch 1 (ms)  patch 1+2 (ms)
  none -> none                    13.10          9.11            0.08
  mq-deadline -> mq-deadline      10.95          9.05            0.08
  mq-deadline -> none             13.00          7.97            6.03

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V2 -> V3:
- Point Fixes in patch 2 at the commit that added the freeze, as
  Christoph pointed out
- Add Christoph's Reviewed-by to patch 2
- Rebase onto v7.4-rc2-1025-g666539eecdf4

V1 -> V2:
- Keep the elevator check under the freeze and note the race in the
  comment, as Christoph suggested
- Say "change" instead of "rewrite" in the cover letter subject
- Rebase onto v7.4-rc2-470-g7e1392a42ea2 and update the numbers from a
  new run

v2: https://lore.kernel.org/r/20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev
v1: https://lore.kernel.org/r/20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev

---
Qiliang Yuan (2):
      block: don't request a module for the none elevator
      block: return early when the elevator doesn't change

 block/elevator.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261111-bug-block-elevator-unchanged-a6cd2d761d38

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

