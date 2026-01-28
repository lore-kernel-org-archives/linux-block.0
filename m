Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CDE1F9ECB
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602641; cv=none; b=pdYLtx0EfGcCwgWilR+BcD2nYHazFCv66kmRheBu9Ln40A1we+IIFx9pWyzH7lcXTUox9ZWtTeTBloyy+jXdGDBJLQgxJtYRKle2lSpYmI20uNkqpN64eVlvACrNf/yqGYpwhio7ChgCYrFig4uTrULdS4BTa9/PD7mOstighOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602641; c=relaxed/simple;
	bh=q1LfGJLfj0t67N7eES2ufEiE2zV74V/T2xEqbVszGB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hdP4P0P6A5iex13dpVcYVjwsy3fJz1mhTfxz1Wnoz7pAp8P9mHuSyjl4y19J/XSrrhhA1+iZk3ZdMb6a5hB65v2iIFWgTHr1yyRrNpg9Q4+ewviUJj5q/cLxU92DxEZMOTVbvwdzZLeU0ilgSJAK9Eh/udPW6fXMws1yBWYB5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X77jzPJ7; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X77jzPJ7"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-501469b598fso50953791cf.3
        for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 04:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769602638; x=1770207438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=531E7R9O3QUmfoXL+CI6MBQYUo1YtfcUHdGksWrkRss=;
        b=X77jzPJ7MVa7DwqRMb82LOAK8jOQA/C7AMVD5lKWnyhB+w4RAEVNt8T+5EBELVoy7f
         gqOmv+Y5GCbnWHpZ0PNlpwh2favhDGahDHMSiqGaUeviZ55GoofNP1lu3tcgmlEZdekx
         Ay45rLwMi0X/MiE+F7JOcJX9L29yRrMTCkvXYrsHa3PlmgFhLSJ4uSpuYoTf+vzUAOOP
         +MZ88ZhHAkyr2PlnGZxaWiKCbzsjhb5Qw2JdHxZKHkRuDgfDzxpTjvAe7atpq5umhJSP
         OGzQj+ivDcywGE25NOLPr7Ou025APkEoRbOHzpEZvjczNn5cYDPK88ppD78sGZx8DqOz
         RHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769602638; x=1770207438;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=531E7R9O3QUmfoXL+CI6MBQYUo1YtfcUHdGksWrkRss=;
        b=MH95yeplgrt6dHaex0x6qhRskarC8TE8PC9otWnpHrYZexCHsxUwpQItuo/TkXAnk3
         B7kMKE9PCkqmyoROjuj+tBYhcVnOYZHIb5wDg9lkAyKw3pz7Lspb1XQIIf/O8HohDTMB
         8et/uZu5X/BqXoFH0Fd39WRLQ1OkFEBpFDkqgbUSmvzVVQadnTfMJvGEHQ1UeVZ890iv
         sRL+yrMqhlHqv+2HJbALIoOSRasoAccwTe6az5nOrdNDRsLzkgO3JxhQAE/XJ7bp8xxE
         Jlb0Q6dr3lIZU4+NtlHJc6WB+XtI+kQ+4t/dpZv4tZAZ0JnCgzaWgwZBZ0rhJ/tm89Tq
         VidA==
X-Forwarded-Encrypted: i=1; AJvYcCWjBck0nyNrF8JimMV9JF4kMNCuIQTZuqH28ZbxMZPmO5/Spj1drWHiFXIlazV0XTEfmCRl5E9RHGrMQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUTttlqWZADEli2HhY1MhN74cTj8RyI2KO4qh/vHt/skPaS/IT
	1cMIYqg4ukM3rnScM7b1NsolR3RzaU8bjFcO9mHQfKArlfxOaloYrQO5H+RpScHQvm4=
X-Gm-Gg: AZuq6aLJYbNFJsEUFi+kbNEjwUIZPojRC1HRGziNllVcpQsHwnSk5XL9gV08D69hDcW
	nJ+bV3EH8t0faHNm0To0JfyTSVZ4fhejhkgUjAuXDaMfTlfYorP3Az/kptY6RMuedAiu64ir9UF
	tehBrY7GY9tX22QFNRFqXbeuymH6DNUB/xvgNrywzXoEvQFbWSofLQutO9ac3uQ8Y1maU+SVOSC
	HyD6X/5gsMFwamhsP2KFlXod1qw/pHY/tRLcXY4k/C5s2pnIGEDr171h/oYNMzi2exPx2TosHuz
	LkchSrO2uZEP7cTOwGZEWLIU/Zl3LmbMRFVawmRCgmOGYl8awSOk+3yHphCxupLWASAsmTB7P7Q
	hvQt7eY6yzXgmlA3rWg58SZsnpezOJvP8ks4XEBXWjIuoZiYaqEW851iWIlBlEaDpMHDHQ2Qcfl
	rcx32jVpwyW/lzv607C5Bldrd8m/vpMCeVO+cnoFSBzuU3DDtgAZmrQxkdzmtyIi3M
X-Received: by 2002:a05:622a:1311:b0:4f1:abf2:54cb with SMTP id d75a77b69052e-5032f9f2353mr56335131cf.43.1769602637809;
        Wed, 28 Jan 2026 04:17:17 -0800 (PST)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4e3sm14742421cf.6.2026.01.28.04.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:17:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
References: <20260126055406.1421026-1-hch@lst.de>
Subject: Re: bounce buffer direct I/O when stable pages are required v3
Message-Id: <176960263627.190300.12577338500573611923.b4-ty@kernel.dk>
Date: Wed, 28 Jan 2026 05:17:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 26 Jan 2026 06:53:31 +0100, Christoph Hellwig wrote:
> [note to maintainers:  we're ready to merge I think, and Christian
> already said he'd do on Friday.  If acceptable to everyone I'd like
> to merge it through the block tree, or topic branch in it due to
> pending work on top of this]
> 
> this series tries to address the problem that under I/O pages can be
> modified during direct I/O, even when the device or file system require
> stable pages during I/O to calculate checksums, parity or data
> operations.  It does so by adding block layer helpers to bounce buffer
> an iov_iter into a bio, then wires that up in iomap and ultimately
> XFS.
> 
> [...]

Applied, thanks!

[01/15] block: add a BIO_MAX_SIZE constant and use it
        commit: fa0bdd45d7e3703826ea75f5fe3359865d75c319
[02/15] block: refactor get_contig_folio_len
        commit: 4d77007d42fd4f44c2f5a1555603df53e16a1362
[03/15] block: open code bio_add_page and fix handling of mismatching P2P ranges
        commit: 12da89e8844ae16e86b75a32b34a4f0b0525f453
[04/15] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
        commit: 91b73c458182801a8c9cf6135335e064567d1013
[05/15] block: remove bio_release_page
        commit: 301f5356521ed90f72a67797156d75093aac786f
[06/15] block: add helpers to bounce buffer an iov_iter into bios
        commit: 8dd5e7c75d7bb2635c7efd219ff20693fc24096a
[07/15] iomap: fix submission side handling of completion side errors
        commit: 4ad357e39b2ecd5da7bcc7e840ee24d179593cd5
[08/15] iomap: simplify iomap_dio_bio_iter
        commit: 6e7a6c80198ead08b11aa6cdc92e60a42fc5895f
[09/15] iomap: split out the per-bio logic from iomap_dio_bio_iter
        commit: 2631c94602297090febd8f93d6f96d9d2045466d
[10/15] iomap: share code between iomap_dio_bio_end_io and iomap_finish_ioend_direct
        commit: e2fcff5bb4c48bf602082e5a1428ff7328f7558f
[11/15] iomap: free the bio before completing the dio
        commit: 45cec0de6c8973660da279e44b24d37af49daeb6
[12/15] iomap: rename IOMAP_DIO_DIRTY to IOMAP_DIO_USER_BACKED
        commit: c96b8b220271024c04289d6d9779dc2ccbd12be2
[13/15] iomap: support ioends for direct reads
        commit: d969bd72cf6835a4c915b326feb92c7597a46d98
[14/15] iomap: add a flag to bounce buffer direct I/O
        commit: c9d114846b380fec1093b7bca91ee5a8cd7b575d
[15/15] xfs: use bounce buffering direct I/O when the device requires stable pages
        commit: 3373503df025ab6c9a8ad2ce6b7febd2eb3c99dc

Best regards,
-- 
Jens Axboe



