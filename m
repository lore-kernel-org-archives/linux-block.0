Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769335;
	b=tZc0DXA/Ji7mmu4QRxTmmkTPwx/8DdOewgOFXk2z2HSeAK5y+nGBRJgxbispYc3h436H
	 9GKoo+r6zHdmLgQuwo9/3iJFtnOEjXoqA5SHgJU0xJogUQl4/qMnffGSADsAZORduf+Dm
	 jKnwkX4Ie/EcltjOz3zo3XOvpLuhfn+WT8I7VrDtA0Q6zb4xcFsYN4uR6yXkh5uxCbCxk
	 cE5R1Fbu2LQfYWZUJyxDFOWwRMrEe2C4AbQewWsmi2IlIBbyDAoU5f6IYVh+2LNVy9+tn
	 qldAoGkEyhU5OnuAKlC3/EcDAzHBe2WzHyt8txqfx3dDyBssFJuEVhJo3fHYWkTB1zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=;
	b=0c81MWnQzPHUMJvbE+ClKBaVpaA50KXYatm2sg9gVdk6T9o0DFJej3+V+t3mPuMiYtf6
	 0Llci/FJd95eqJ6Lrs2s7zNWd3L1nCKsIx9/KjVv+81qBUKxxbX4AjVpAjr070gDP6Bu5
	 zNKwHkQ7SHnYA7PFXUnfmlatDqA/1Z5rioA6+RcrGLocgcv9gdVc+yeGFkvHEUY2N0WjV
	 w/fpkNC2QDkq3m9Z1n5WYtEuqvO/UAvdQu99TxQFoR383skWFEFw3V+kDgVS+66BoFKVA
	 y1knyO2+wAvHvTEANrE++3SvLKWzVVLekmQ8TTLteMJQB3pEHalSmlk7UpmUzDZa3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rv1OPzlL;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347B606A323
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 08:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F347B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rv1OPzlL
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b51a9606e8so921769a91.3
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769334; x=1796374134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=;
        b=rv1OPzlLkeMojQwNzlK+naiity0+ZhuvitsfuYoiZykqG7hyKze1YUcsQxa5pVh7pB
         ClC8NqEi2LoX9Gu5KsdHslyQwBffNItV2Phv1HQuYFabj0PurZIHGu8upGbDJQQ3gafV
         6/FGJ83mkeV+P7Te5KQuDrIt2OupsaKqUeuqEibGamitTgM4lnwh34YE5mrTNvAriFpn
         4yfPfS/jmW++py4tRKwH/wMfr7FMbNCfo8nkn4VF9BTYeTH56WUpJ/3F2mXsZ14xUY1L
         k8jyhUVgICEsnwAaJhL3pKJlPsGSQvwC+W4u3dZiXGqzcpnPpVGtCVio4chZikqXbDbH
         e/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769334; x=1796374134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=;
        b=VaYSGpDdjlvkZSMiRPpPtA/onuUnJKIPegr/4ONM7zxqARw9B8+ZjHQqT6oqeG+hOM
         ZBc2Kjn50F9mSQGLtDQODc43y6eRP8g751GJzp0TQs7S4HovK5U8m63qKFVGxDVf3UTE
         vbWv5MumEwEwTyFKe9CgRY3FmcwVhR6A5JI2BfvY+PO2LzPU9xvnS5Bb2KuUy9y+c5uK
         QAJDVToqdZMLEqVC/u8kGb/UpgBdqJZUuE8rT/Dvi+SOOZI4eBG3z6shFg5WRyo+j6LI
         mSajf9Sy6oNeolPycOu2lA5uuVheUFX4Egq08K1P8JsCgyWXm2MO1Lm1rB065WMcmycf
         Brig==
X-Forwarded-Encrypted: i=1; AL+hErE2q7c013zCdmnfwOYxsVkW5yMGSpBqHqpulvQRInKuhlkqFRvoFWHq5KxFJTIgo5N0IeLsAQsiA1s5QQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/J7v0S0kahHQGDrVg9SC8VrmKvlbi64jYWnNpyNns3nQW0BcZp
	ubFeA2buvq8PIdh4NCMeMGEv93ep72e/j18GOmnsXJWSRFSOXj96Qtq2
X-Gm-Gg: AZFdTZcLyJ/nZdq9zoAcPZFcSDrYoJvYgQDzo4UQjKkD4Zyahua96juRRwpv+SlUECr
	Fv9m7LDqLhTwh3njjScnOUgTHxZwbi26vJxoSvE44eBwoezFcKNtsrNBfAv0smQcAjD+iGwO7nI
	Owhw2dmjRDt4j9C83UYTV3gCuftbOfKrLKHjKHaVHIFVFbOGQxhUMTCh/nsArwCiL8t1dEwxfSZ
	WYuxTH+ZumXLBwMXeC5X9/lBD+m9OzELPiCpZr0JGJKfSRPyIaUzXdCO2In1IkTqZJW7dQE96Dl
	INNMmR56gj0SBndEsfoQKiHbpKSbbO2vBI6Djevu0WbTDcU7rzulJPo934qwEm6ktTJT6//h+uf
	XSo3QcCzidy8LvjpCOVpz2P6pDspSBn2otO2gGd2LYkQ8yzF1h8Vd7RQq0mHSNkpD2NUObr9kqP
	RowJJkop7dNGAKS6BXPlzJZfzMEJJOMPVs94rPRV7wD0SfDSzZG2hFzc7l5S9di74KfwIf7WQXO
	yb+tgQipg3x4EztrpAb4AcAMxbC8enyxLRz1bLRrEf4uBSGWaEMXfgVZtc/J20+EidlmfV51NBE
	6BjDSiQ3iCOpVawGR0r3o46f/zQQoEWY+XN2FKPm55HCJ4GIuplIkBZncbTEqHIMarAMFarNsnR
	r+Ba/MRSPybo=
X-Received: by 2002:a17:90b:390e:b0:3b4:fcba:8f7d with SMTP id 98e67ed59e1d1-3b4fcba9627mr7869895a91.29.1795769334244;
        Fri, 27 Nov 2026 00:48:54 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:48:53 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v6 0/2] f2fs: enable buffered RWF_DONTCACHE
Date: Fri, 27 Nov 2026 16:48:43 +0800
Message-ID: <cover.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables buffered RWF_DONTCACHE on F2FS for one-pass streaming
I/O, where retaining the transferred data can displace more useful cache.

Patch 1 marks dropbehind write bios with BIO_COMPLETE_IN_TASK. Normal and
dropbehind folios may share otherwise mergeable IPU and OPU bios; the flag
is set when a dropbehind folio joins a bio. The block layer handles
deferral from unsafe completion contexts.

Patch 2 passes FGP_DONTCACHE to the buffered write folio lookup and
advertises FOP_DONTCACHE, enabling buffered reads and writes. Internal
write_begin callers that pass a NULL kiocb remain supported.

Tests used x86-64 QEMU/KVM with two vCPUs, 2 GiB RAM, and an NVMe-backed
F2FS image. Each attempt transferred a 1-GiB file sequentially in a fresh
guest, with memory.max=255852544 (244 MiB) and memory.swap.max=0. Normal
and dontcache each ran ten counterbalanced rounds. Values below are
arithmetic means of the ten runs per mode. Write throughput excludes the
final fdatasync().

Throughput was:

 Operation  I/O       Normal MiB/s  Dontcache MiB/s  Change
 Read       1 MiB         4137.96          5869.38  +41.84%
 Write      8 KiB          686.09          1752.24 +155.39%
 Write      1 MiB          714.91          2161.02 +202.28%

Average memory.current was:

 Operation  I/O       Normal MiB  Dontcache MiB  Change
 Read       1 MiB         197.26          13.70 -93.06%
 Write      8 KiB         214.22          13.15 -93.86%
 Write      1 MiB         215.20          19.52 -90.93%

Mean reclaim counters per run were:

 Operation  I/O       pgscan normal/DC   pgsteal normal/DC
 Read       1 MiB          200999.7/0          200888.4/0
 Write      8 KiB          201136.8/0          201120.8/0
 Write      1 MiB          200899.3/0          200883.3/0

Scan counts pages examined by reclaim; steal counts pages reclaimed.
memory.current includes all memory charged to the workload, not only
file-cache pages.

Dontcache left zero target pages resident after reads and one 4-KiB page
after write synchronization.

Changes since v5:

- Rebase onto the F2FS dev branch, adapting the bio tagging to the
  sub-folio merge paths and excluding metadata-cache I/O.
- Drop the Android 6.12 backport results, as its dropbehind implementation
  differs substantially from that in the current dev branch.
- Add memory-limited read results and update the write results,
  reporting arithmetic means of ten runs per mode.

Wenjie Qi (2):
  f2fs: complete dropbehind write bios in task context
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 10 ++++++++++
 fs/f2fs/file.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: b61a029304bb5531312ebc133b2a895d14dc3fee
-- 
2.43.0

