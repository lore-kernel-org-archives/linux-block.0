Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2F49620
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544256; cv=none; b=fg4VS0QB1bGY35Cw3qQomsQaUsOADoyjbN/GxpU/e/NzledkSJRJ1zqebbO1XAaJ6kNBAf0AaDqsPQVtq52qoFmeTfRY1++4fDyDrnfmjNa0hPulS5rC/H0f+QipKEtCT5eEWxanPvSLzUUZKWmWrPfD/lJaChVFwqdkDSSLonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544256; c=relaxed/simple;
	bh=hH9A4ga/R+X23C4gJ+oGriVYHNeRobhPQRPx1lX/z8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TxwkLkW7w2S1fgt2hvRoVZCVqWJzYOQt+vaxoS9uc6DuBcOkUbW30kk75XpbyjDj2AqNee5JrpRwGyRS57oRJFWuxvbtJZRxfKHe+Um0VmdlUH9eBcqpoFpE6SNdk3XJVd9YCLM9V+hMvUTIbwsi0YTprOpuz77qBNBTUtjK5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ECWbyR/8; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ECWbyR/8"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e57003ee3fso23957825ab.2
        for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755544253; x=1756149053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98s4oxjoCh9JFMdNor4pD8PSiVTI+34Wp/PkZUG9epY=;
        b=ECWbyR/8GEFEjhhelsoRYVb9Qh6gM3j+rROQFNH0RcT9Wg4WB7s/zzguZGi6NVWG4R
         XrGxNFesBBdigVyNHgzmVm6+KunnElc7mCgUwWqbKHXm4YVmD5rCIxswgPzvaGXku55o
         tKIAnHrHBF3ppTWBMMuXtijXFRpQk/tlH0AtHP1XgtoAJ95e8xS4ceYnOTuPBNvmxa3g
         dYpRVCFN8irnPh550e5zRzDcj5WFYqZOfMA8O2+4rMv12SuTthmpAvGBwyOVfx7gZk1+
         VCPneoUZlgNgyPF5x6rS4VZzUjtK9UMRJm0C+dGpeu4IGh8fXA7GTRjSSf+L4g5KMINe
         K5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755544253; x=1756149053;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98s4oxjoCh9JFMdNor4pD8PSiVTI+34Wp/PkZUG9epY=;
        b=Peb+R5T6AsalVgrqFl9KhEcKpSlzJf5ranVqJIvY24wUAKBtKfdwffLMugvR4IOdDm
         Tj0J3xjQbT9Z5njTh3leN7e2qK05350Fwk+aCmXS6qP6DfySGPSrPGdlFFC3rVL7x7t/
         E32Vf/5BmMtRXbaYfNuV+lwB/V3TjJOoBYm2SZ4KlIj1rYumgcMkkFDmJHhTBsEBnXUd
         ifldu/q3TwTsVXFJuZQWPjUOrIBuCYg7fNiQyjAxlbCjDv8MgX/nlFHTR/IeQO5K8B9u
         oY/m4e0BO3yl06prmLI0qmdpf43dgarWFLWN9D8OI5auRnxyog8PxdfLoywFQ78Ugt0B
         b4jQ==
X-Gm-Message-State: AOJu0YyA83qvRfl6zi6GMyaaG60bvjKVUwDlESeOL3gvbPe7+xBWme5N
	U9X2RsI6APDfcWn4O/0RCZL7MbuhsL2JZXc0xxi1QGt86kq/nNOZb5i1BB50gUXch8Z80Kpkfb/
	CSDHs
X-Gm-Gg: ASbGnctqYOB9+X+XMVxNrasTAGhNJYznI0uo9bwhvUxQeRBo/ZWKeCqsgMZE14mYAcG
	rQVTESFnJ3UoDN5RMzk+6/y44AOgfCeeaImE5AlxS1rUO8cklMDYfKYmIq88//7W3KtiTKrHyvz
	F+OZ35fKlcCR8dQhBwdToF3JmuB7RUeaVv/g/VHyThsFTwTFp86LP+oOmhGegl3gEIAShwzypiL
	WOrbeLE8oL0VYvOX3W08fLOaQ2JPC7ycLFlfJje21TSEfgxGI2pBmisr/XAoVok4fX1VWRnv+oK
	UXK9n6F1x4HQz+rUBcVvbXNZVtgaN6crvpukRdGr2tOz0WypUZKCN/NGeoZL3z67zVRvvLvvRC4
	SLnA1fXfUgIXFFEmDGTWAK9tx
X-Google-Smtp-Source: AGHT+IExPQWHNXEp87a6gdTrRalijU8TTfNUlXZ8z/6M63ZuM5HFn5QSpjqem+d6JzrncNeyYbRK+Q==
X-Received: by 2002:a05:6e02:2705:b0:3e5:5937:e54d with SMTP id e9e14a558f8ab-3e57e9c8e73mr229307185ab.15.1755544253574;
        Mon, 18 Aug 2025 12:10:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e667540aa6sm19589805ab.32.2025.08.18.12.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 12:10:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai1@huaweicloud.com, Rajeev Mishra <rajeevm@hpe.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250818184821.115033-1-rajeevm@hpe.com>
References: <20250818184821.115033-1-rajeevm@hpe.com>
Subject: Re: fixed commit message
Message-Id: <175554425273.106072.9130682116879021274.b4-ty@kernel.dk>
Date: Mon, 18 Aug 2025 13:10:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 18 Aug 2025 18:48:19 +0000, Rajeev Mishra wrote:
> fixed the commit message
> Rajeev Mishra (2):
>   loop: Consolidate size calculation logic into lo_calculate_size()
>   loop: use vfs_getattr_nosec for accurate file size
> 
> drivers/block/loop.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] loop: Consolidate size calculation logic into lo_calculate_size()
      commit: 8aa5a3b68ad144da49a3d17f165e6561255e3529
[2/2] loop: use vfs_getattr_nosec for accurate file size
      commit: 47b71abd58461a67cae71d2f2a9d44379e4e2fcf

Best regards,
-- 
Jens Axboe



