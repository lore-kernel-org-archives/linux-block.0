Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795835782;
	b=ic225zPmsMz7sh5q+svONIEyKgjdsCSXuVdk9askBF6HiX4afUWywF2lSZkNurVShHjA
	 4A40Gv+5gnp9IijjM8mg/+KZgTLOHCSwkOc8Jz9V/8+GA+lreNvt8kY/VYFvf/HynNdNP
	 +TaH08NC40G+VSdME7gHpGUEovHXfH5RGcvX6rowhJXCLw6BDKVw7ODPd0tWYKE7DWWNH
	 U/7HSobqjfrjfPXnbatr9krlw2nsU8cOtOh67RV0HsVRAnzxJ/mB/jTAV6a8olVfrvQ9w
	 EsPTfuvCMqQ3lYRYpsKtqSL/1F8o47DypljODhpdvWFPje3rhHqYYJW4cAosn0H35DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795835782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=yvCt1gdskx/Y0jOYT6LmJ91002gzEPa4iXQSvGo7T/w=;
	b=I578Qe7XHw5xqC5vYbRSD9ep5ZhQsHxdQSy36yIk72ktSW9MS83XcZzyM3AMGh1xcjf2
	 g0E4jSxZdQWOFmxNzjskkublyIYkBsPJBBtZVFH3DsBapZu3DCUaJweOOVXrFyfU4E8WG
	 8WcW3cXvS/qGWSRTZguuY3ILl4nwJRB55be2lmDSWTZ0sakYeuiH/Xqdj4+igqCW+3GoE
	 8RZ//wnxwhOf3JAFCsjDsmYGzRL6L8O4SA0oczQMfbCllvOlkcTKU7+T/L66tCNToVdRK
	 Zla5FsVMlPamzxOQz1EDbLaut4cry+K1vAFmpNLQyh1XKm1RUzkp2LauyvAzUvH5Qjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=nDu9lVQt;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22C606A31E
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 03:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A22C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=nDu9lVQt
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-38431138772so11441550eec.1
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 19:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795835780; x=1796440580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yvCt1gdskx/Y0jOYT6LmJ91002gzEPa4iXQSvGo7T/w=;
        b=nDu9lVQtkryVMSZeb0kvkG3170q+2QAclKnT7mGciWVBndJFoBkISt5ECqvVgW73f+
         B/vFwxyyKwhlV/gQgdeagWaouoK+N4XfZ3HG8dQKeH8wd1YMEO0Rzhse4hHitkp1akBY
         QJhW2MEUGaOntTblnwaQfAyXjLSN+xCyLcIUCkbjCjTxnZT7kAoPlYaPNJ+zfoE5DNI3
         xyCeQm9M8YzfUWZ2yvdZ6D0o2vD3AMrSk2xswASGN36o28s3OR9bAqFAF4UIk3diU3FB
         xRCpKv7cmR6Xgp7A+UhcjpweZ0ycwJ2kTP9cO2OqeNaG6yxXfwsw0tl63k6cxFVyHplD
         FWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795835780; x=1796440580;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvCt1gdskx/Y0jOYT6LmJ91002gzEPa4iXQSvGo7T/w=;
        b=flBsf6HP3wa9cCfec7OuKXnD6bjlBkuwB5Fk5vHQrJW6oybIiXe8ekwY/Q77tujKdH
         8Zb1IW7bQa1fN/4yjKXXdw5Q5WHyYRCArtt+uz2mWbVXkKKbCCmrY2RcY8a4EKjtGItt
         OZ67b2bvINdNN6q8f+Y/z+f6Gso1cyApt7FMrmC0jJ6LFzZD2oXRhIb5cOP/nn37J93w
         4oOLvMqR02sZP44fS6kZ01O/5TDUv7Au/EbijxiMnFZj7ciBEcmjJFTR5/Mxky+rI96P
         jpb4Xs8lM4CN398QXTHil1qXllHv6qVz5BqkbyX6sh/VOeuIK3PW/cTnPGme2tlBjlls
         /Faw==
X-Gm-Message-State: APuU4Z/NqwvxEQaKB9Lv9kr16XUSgn7n5R4aPMIKKFSSLgwNEbL5o8ap
	kvVT5XQ49S5DBlKWyark4mkG00r8xywbVcAaD99CeOooNa5RYB+zaDhq3+Ejr0gxQDugOqIsHCM
	2JmsP/aw=
X-Gm-Gg: AZFdTZcjYgXDvCElxP1MaA+W7nk01R2Sa27JS3xYpWVcwEv6KpUE3kQfjH/cpuchoy0
	iIJUpRgUZ2P6dGVKXLDb6NwIBg/0zLSdfs+U5JWjsIaquzqhsydF/wqtBI4OXJLPDZJ4b4/Kc+K
	JJzqaIVeLlN/iaNRZffWchuIq43HVFS1a7iFHebeVPQLogjzUKe7KxaB3IsHYhnuzylEMc+8ZyM
	OQaReqRlxr5sSM5OtZaKobgxJZR79qPdFTMIGk1N+uujaRC+C2Iq1+dPpItNvFeodUZoMrUt878
	JZ5GXSNKsuLk69ih/J1PO/+oJiQQIOe4Sl5mToZEybKW5zYaq+A54hl6qeMxSzmO4qSAVOV6qKM
	7AORvqI5K+YAnadnTW3mds88G0jy+raAlxaWzNJ40nP3l8CaXujO3Qv5CUH6SCCO5+wO6N2VtqS
	X1mAkpqB9spWNqxKu1Tw4EwLTaG7X1qlnLgqTbqR/mf8kHe7+GDLfBVI77/sep6hSAUD5c7f6PE
	Z4iTUMoViJ7aJJXo+Uyr0m0CpPDPI/oRqEYR+hl6ETTlamEDzCBJzmKQrAazudmCL8I+SurwB1f
	NMXFPxUo0xvz1V13YAAZyscMEWbkXjhVmwBDC8kafpVOkwpbDh0sy1NQ3+g9RK8QRbtb5BEGOJz
	MnRTNU2PG7GP0NwSgR1sTTUJOBG13e6bdRVkHHYzGBdLqLx2ZZoDfGSqGh0ku7P5qzDA+RQ==
X-Received: by 2002:a05:7301:e103:b0:385:496e:80ac with SMTP id 5a478bee46e88-3856fe59334mr29203520eec.8.1795835780240;
        Fri, 27 Nov 2026 19:16:20 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm36623124eec.17.2026.11.27.19.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 19:16:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 linux-scsi@vger.kernel.org, "Martin K. Petersen" <mkp@kernel.org>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20261120210651.580511-1-dlemoal@kernel.org>
References: <20261120210651.580511-1-dlemoal@kernel.org>
Subject: Re: [PATCH v13 00/13] Add support for storage element depopulation
Message-Id: <179583577931.94675.15322542567681929533.b4-ty@b4>
Date: Fri, 27 Nov 2026 20:16:19 -0700
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
X-Mailer: b4 0.15.2


On Sat, 21 Nov 2026 06:06:38 +0900, Damien Le Moal wrote:
> Jens,
> 
> These patches define a new set of block device operations for generically
> using from the block layer the storage element depopulation feature of
> zoned block devices. Support for this feature is added to the SCSI disk
> driver and an emulation of this feature added to the zloop driver.
> 
> [...]

Applied, thanks!

[01/13] block: introduce disk_zone_is_offline()
        commit: 0f485d3ca937c4ee689cbe8ed91820baf3e2a87c
[02/13] block: refactor blk_revalidate_disk_zones()
        commit: 66c66cedc2cea679210879a30c4b79c760fc3884
[03/13] block: allow dropping all zone write plugs on revalidation
        commit: 0de926d244f23fa9fc88dc93874fc9366be291cd
[04/13] block: introduce storage element management
        commit: 5848abdc4e80e4690ded2dbfc0d1ec4b24513c87
[05/13] block: add storage element management ioctls
        commit: a2333b0f548a23bdc63b440311344da3caf4064e
[06/13] zloop: fix ordered zone append handling
        commit: 506dba8f5cd91b9cb8a113f0ef18cc8f27616ac2
[07/13] zloop: fix zone reporting consistency
        commit: c61ee1e7f15161a1a4a870c2d417685bed77db14
[08/13] zloop: add storage element emulation
        commit: fbff47f53afd4c9b2697f3e92f5c73cbd7538872
[09/13] zloop: add degrade_element control command
        commit: e0ec1629c269bad515d88398f4b2a474d4416402
[10/13] scsi: scsi_proto: refine the definition of storage element health
        commit: 9bb8df1a44f6c52d4360bd93f9e3076d422058cf
[11/13] scsi: sd_zbc: always revalidate zones for disks supporting head depopulation
        commit: 926c932a9e1483b4d5a1a058c147e4d18ff14be0
[12/13] scsi: sd_zbc: define storage element management operations
        commit: 4745c9c7b359dd27e5a256da81b69a4a42bd673f
[13/13] scsi: sd: fail read commands to offline zones early
        commit: efe346b1854e230970e2aebf734d916bdd28ea57

Best regards,
-- 
Jens Axboe



