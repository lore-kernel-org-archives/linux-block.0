Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A42306B12
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234950; cv=none; b=jdYmcZFjvnlKMrMsxsK5DiXbRs8GCQ1ql+6kC7T/ACnLH8BblAX3Z5XCoP9nuZ1CFZ1v9hsN4pz5GY6h5WLn4PFAkm4+3weIxdp8lT0/kNzfzPz1G87/I0PVV3YDRkC2RT7f/sFL5EwD0ErvmrJ7z4mWZXI2IjC7swastXt6oFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234950; c=relaxed/simple;
	bh=FLgtzcpG1iiD7UDgyCo70RW6wUFAmUsGCPCRHSdaaNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E8Q8SHxbxA/EPrmkZ2fZTymsqXaaYV38lfjxiOOVCCFhef0w6ZElonJrRCQH579ZzXw8XVnjF6FhdHOGZ2CZtN+IZ58b7StDL8384RqCMReZruML0QR4119L9jIL24cmTiJ72oRMtV2vfQx1s7iYHf7dPgSBLiV9tgRKoMragQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qlz2Fw2W; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qlz2Fw2W"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c750b10e14so2805002a34.2
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768234948; x=1768839748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqKDWc0zO+poInuUEZ+pw1nMtUtFun4J9dQM9RVo0mQ=;
        b=qlz2Fw2WPeC/SIaNKSCmKjaaEazqORmR/3oCmtPJ9KjQ0DBBNmjaqoZr50ayqahG0R
         4ZEE54AgmqhdfjvIe7HETQpqegXKQ0sCCzLcSPthPvmDusHPTXkAccMTGf+YLzhrpxk/
         rqbOoTimBRZouWIXiQwGW+u2W3nM/uJseBfs4ILPUvm6qLizCkr8Vtc+l3hLSYkziUU6
         lZsABrNE29oyiYzHDrSkj0laJvsZWw5BjfHfMfMayoTdYS4420i/V6HnA5Q2/SnN2v8Y
         XeX1h95GPuMNs0DL2GQjBDRq37jiqGyXoF6M3CIyDq8dFg1eTWMkXxqVjzrwWvOjHjqw
         wEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768234948; x=1768839748;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QqKDWc0zO+poInuUEZ+pw1nMtUtFun4J9dQM9RVo0mQ=;
        b=NeJk9Z5oOYxg+m516nUhIgUQHkE+6cGwlbRPOPWqi4IuV2cXdxzhO1llpto60sj/2F
         +YYoRMLEfS5fe5RVWxkNeMnwl6Tdm9zQ9SLRZhckLPHEMUYJqM+IorGlgjp9cJmkrcuI
         MGceLlGVuM3FKX8/oszSO85i+48Copd1Cd7iRk+FQFPWS7zTyTk2bhy2q+be56sImV3b
         UR3yjw95LcFPw+kqmYi7A4Iu0inyEgbEyvWUsxM/oaQDzm0bSY5AEIp4gBXCy4pgtxRR
         w6rzAIR520H1d0kxIKhJ9aN49AYdzaiSsm+SiJjfJkLnMh5KAV3Fkp+WLnFfZP7ZYzgJ
         nP0A==
X-Gm-Message-State: AOJu0YxElY4Nbz8h+LYFZMMJbdhg1o1XJeyMvwL3glYauLOiiqKn2Aa/
	/GWhrWH3eX6K1SN0BbwTpLG88co9kqyZkOrEd58IFqB/Iqcsq05qRQXOmtfd2y6XcTcOKe3MJ2I
	voyHZ
X-Gm-Gg: AY/fxX74vwrMIfS5m1s71QErLzj+0PNvnnagbNACZvNQsLZjUTzsl5LwUOP5vuD2R/f
	qO2hd5V/fJF3HyOX7n/Oj+S18Sc5KeS+4oL7I8366SX/JMkJf4G9RF/Mts7tL3xjKk79+8TqsnJ
	2MkBcl44ZQkF8JQj8ZFwuGBXew5HHhJxj1YrVIOYUGsDJprue1S11k0jzncvk6/gsV6pASQFqys
	MZWp/Gsm7NU9is52bArC6ruJERXnt8mwPVtdF0sFGAPp0Q+o/myDdVtKXkg2jrjgjHCnOfCFtbG
	WXJcnKagH45eskePHkFKf775I9NFaPHf5H+ODzphE7sEnSEY5oHOo+rnjVEDXQFY/Y/gIbXzot7
	04aPhxiSJRY08ByOGwJCFML6egRlIhonV1S3n/Vg8FjE2ajni8VdLsvZrkrjVK6KmUEOEmgVic7
	wQoGkWcxHDI8Ucgw==
X-Google-Smtp-Source: AGHT+IFAzIV1m+B1G30yMWJdu+ySU6/GH2D/OwobTwcSvQNalzbvhDanBSGkpMMxYxWdVoITAmFAzg==
X-Received: by 2002:a05:6830:374b:b0:7b8:f2a2:46b8 with SMTP id 46e09a7af769-7ce50bcba05mr11117561a34.17.1768234947913;
        Mon, 12 Jan 2026 08:22:27 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm13223209a34.12.2026.01.12.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:22:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stanley Zhang <stazhang@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Subject: Re: [PATCH v4 00/19] ublk: add support for integrity data
Message-Id: <176823494699.210978.11786417520987003965.b4-ty@kernel.dk>
Date: Mon, 12 Jan 2026 09:22:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 08 Jan 2026 02:19:28 -0700, Caleb Sander Mateos wrote:
> Much work has recently gone into supporting block device integrity data
> (sometimes called "metadata") in Linux. Many NVMe devices these days
> support metadata transfers and/or automatic protection information
> generation and verification. However, ublk devices can't yet advertise
> integrity data capabilities. This patch series wires up support for
> integrity data in ublk. The ublk feature is referred to as "integrity"
> rather than "metadata" to match the block layer's name for it and to
> avoid confusion with the existing and unrelated UBLK_IO_F_META.
> 
> [...]

Applied, thanks!

[01/19] blk-integrity: take const pointer in blk_integrity_rq()
        commit: 835042fb1971b1cc6acb46d53b8862643fd7d0a8
[02/19] ublk: move ublk flag check functions earlier
        commit: e859e7c26a5c4689083f161a52d039b9b454e403
[03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
        commit: 98bf2256855eb682433a33e6a7c4bce35191ca99
[04/19] ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
        commit: f82f0a16a8270b17211254beeb123d11a0f279cd
[05/19] ublk: split out ublk_copy_user_bvec() helper
        commit: fc652d415cd8b45e9a534d1c019da175cca4c95a
[06/19] ublk: split out ublk_user_copy() helper
        commit: 5bfbbc9938f5dee7f252ef05f47b9a26f05f281a
[07/19] ublk: inline ublk_check_and_get_req() into ublk_user_copy()
        commit: ca80afd8708fa22f6d3a1e0306ae12a64e5291b5
[08/19] ublk: move offset check out of __ublk_check_and_get_req()
        commit: fd5a005fa6a261762292a2d89ef8d0174b66f541
[09/19] ublk: implement integrity user copy
        commit: be82a89066d595da334f6e153ababcedc3f92ad6
[10/19] ublk: support UBLK_F_INTEGRITY
        commit: b2503e936b598b993cb09005194dc77d2fa3f082
[11/19] ublk: optimize ublk_user_copy() on daemon task
        commit: bfe1255712a3b1c1f7418c5504a1bf53735d3848
[12/19] selftests: ublk: display UBLK_F_INTEGRITY support
        commit: c1d7c0f9cdf6690eff4518f1c17a37d5ee647cd1
[13/19] selftests: ublk: add utility to get block device metadata size
        commit: 261b67f4e34716e793b0b95d2722b2fe780ed5f4
[14/19] selftests: ublk: add kublk support for integrity params
        commit: 6ed6476c4aefa9ee3ba90f39bcc002dd034f6e03
[15/19] selftests: ublk: implement integrity user copy in kublk
        commit: 24f8a44b797f03dfadb455138930523599d3c22a
[16/19] selftests: ublk: support non-O_DIRECT backing files
        commit: a1805442674b85ff9d626965f828e4fd71a82b28
[17/19] selftests: ublk: add integrity data support to loop target
        commit: f48250dc5ba8368ccb587093eb20d1c7baecaacf
[18/19] selftests: ublk: add integrity params test
        commit: 9e9f635525b12f055558a7cfe2e54d109839d030
[19/19] selftests: ublk: add end-to-end integrity test
        commit: 78796b6bae8684b753b658f431b5b1ee24300d64

Best regards,
-- 
Jens Axboe



