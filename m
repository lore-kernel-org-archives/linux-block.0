Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427131AA8F
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137591; cv=none; b=lYJ2XOBdhup5ZE63o+Rw7M8+fGWVb1i8Vv67APaoLIS5HRoIds1B6rqoPUGiZCaXWQvoVJTXuHAWKps3BdIdJCc52ILZs2o9satSazyYOvRdSLZDTuCyPdE/Fi87q3zp1+Yjitfx5THRWtnmv68w2+6xjnG3siJDBD1RqkbZA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137591; c=relaxed/simple;
	bh=6qifJRRb2/d7t32KiXBPn4WOt2cCIjEs83EixMwiHHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s7FUiyDxoYkWV5M/RY0msJNk8Rlg4V2b8RsMLOARfHMlN0LGDKuYVKWLxKPm/GRluWZr2Dfvzjb6iUJgWqbs4G+f/V7efz6+FApFmKB7yfabxUqaMBjweAnqqqtQk6lw9CZ1F1aipEucK+ierEYpL8/Px0lQBHkCI4wNKvKrOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aRAsC94h; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aRAsC94h"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c838069e5so1236034b6e.0
        for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 19:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769137584; x=1769742384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tww0drQ4QXMVlHXCFAlAp3A+f2eCHoSVEKQGqj347QQ=;
        b=aRAsC94hECQBzFk6Tdgz86FsW5CnGA4+UxPisCokou7X4TZYSp1CH2EMzvf7PvF0tH
         Wmgit9Im+pHw9Qz5jFj4M8OvTxWeNA+UXCTUKSjk86N2Ru3teMRxSxoReSQK7s2FV42C
         dPBRNXOc1liXQfTPXOcWEwyH/t/Ji6gZpBPeKl4kuD44VW3ft/QVi8oA4NUvtTT8cq6k
         5xls9rSbpJCQ6eull2eC8UrL5HOgfHp6P5NVy3JVWdTQMCDq7bgmQGRpHhLuoxZWWj7v
         AdLG48FcQq8neLZk6MhLBlqYQGfqoCUP2VvFAM2PyhirRXYFlZ+AQsaG5JnRfNnli2CI
         k1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137584; x=1769742384;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tww0drQ4QXMVlHXCFAlAp3A+f2eCHoSVEKQGqj347QQ=;
        b=mks83FxPD6YyeMqU7Kkf0PssxVKB5f09C2pVAjTD29vE+AukWt9LxQ1ZZ8YiR0IZlO
         Bs30SsveeV6X0pieLRHqtGneWRV952hbfNcUCmmZVxioU70eayw9nQ7DoGzk91ubYE8n
         0G2UWz5Dgn9v2yiig7XLOezmdktUtajyZb7pgJhFyiUIHAklT+AhMR/TzzjMoDJmDRJa
         fkBnAOKyYG3bpWFkKDAbSYbZCp7Bix5amjqnKkm3i7y4gBIbXXurh8gwYcLhz1CE7oAt
         tzaBlAkO046MdnP8Z97nORHUc4O1ZyBHJVEbuNh0a2VBzp6shtsDnyqgSS5je4WghUUy
         ZEGg==
X-Gm-Message-State: AOJu0YzWh0reL/YAf9rWJYurjSD4hpJu+HshrXby5dgIW9z+dE24IvoN
	KJY2Gplsv4+ZYdpgPErrwm89DMx3MYlz846jNDcm7TWQ/1Pa4ufk8q9rLMcSBz7PAuLX520mHn6
	EtbuqVjM=
X-Gm-Gg: AZuq6aLwHzJSXxkTzLS3wa/Z2g4eN5qaMFKp1jt7Etku5+0LP/eD+NphyMfBotvjS38
	xTTkvZ7OTxMfO7LAU5PV0fuMAXW4UtNFxfTCt+1caeeiJl/Iw39p0BgC5gKIejifJ+f+QFbjGrr
	oTjkZp9mo9UiN1j9Ax/dpp6/3b0ttKYIJ3LbIeSHIU/bFnDsfJ/njP40TDdP5FFmO/9Ym+f4ktQ
	kYZDCwryBlnmEsy4pqb07FHNGgNcxcjioR/p0QMIyP+W10ZuelYi2sfKqAD4qAlRV8ZzzPZ+AMS
	ZGmUIfhb8q3YTjb/vxPTx0hOq4WUTkz9rhFjQAhXmmYdm/YcAl7fXXXtImkf81cP4Pkw2BbVYB/
	NOuDkVnwaAGxWHPclpqkt9T+HgQy5WkszbMMx8TK6KHQ332IOnwWWViEp94/gJFEM3ipN+iFYGc
	GH1Tm9lCRcB0xkMYpVdUHNLOPxhYWhrrZ3COVVHIxujVzV+DiGXvuBidByB0P1iiQpp7JjhNCd6
	wY=
X-Received: by 2002:a05:6808:1927:b0:44f:775b:729f with SMTP id 5614622812f47-45eb1afe347mr910799b6e.28.1769137578902;
        Thu, 22 Jan 2026 19:06:18 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45eb423262bsm562506b6e.11.2026.01.22.19.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 19:06:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260116141859.719929-1-ming.lei@redhat.com>
References: <20260116141859.719929-1-ming.lei@redhat.com>
Subject: Re: [PATCH V6 00/24] ublk: add UBLK_F_BATCH_IO
Message-Id: <176913757733.565634.9277936164116017084.b4-ty@kernel.dk>
Date: Thu, 22 Jan 2026 20:06:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 16 Jan 2026 22:18:33 +0800, Ming Lei wrote:
> This patchset adds UBLK_F_BATCH_IO feature for communicating between kernel and ublk
> server in batching way:
> 
> - Per-queue vs Per-I/O: Commands operate on queues rather than individual I/Os
> 
> - Batch processing: Multiple I/Os are handled in single operation
> 
> [...]

Applied, thanks!

[01/24] ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
        commit: fb027d569422efcf1b367441f782fb425a4b5569
[02/24] ublk: prepare for not tracking task context for command batch
        commit: 7ba62f5969defbab7df47c0016ffd4dedf30950a
[03/24] ublk: add new batch command UBLK_U_IO_PREP_IO_CMDS & UBLK_U_IO_COMMIT_IO_CMDS
        commit: e86f89ab24f5ec595879a01eebb5df84f5ed6d2b
[04/24] ublk: handle UBLK_U_IO_PREP_IO_CMDS
        commit: b256795b3606e9a67c725dde8eaae91dd9d21de4
[05/24] ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
        commit: 1e500e106d5a82280db59dba06f0108085beba65
[06/24] ublk: add io events fifo structure
        commit: f1f99ddf607a4b54dc19d92fb07f2a30c131ee56
[07/24] ublk: add batch I/O dispatch infrastructure
        commit: 7a1bb41947cee3aa50fa9b276e9aeb6caa87b543
[08/24] ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O processing
        commit: a4d88375539920b7401ead59d2f944ac23c668ea
[09/24] ublk: refactor ublk_queue_rq() and add ublk_batch_queue_rq()
        commit: 3ac4796b888a2574cb982c89076ed717f122289d
[10/24] ublk: abort requests filled in event kfifo
        commit: 29d0a927f9efd5f87ac8a2d291d2782384d1bee2
[11/24] ublk: add new feature UBLK_F_BATCH_IO
        commit: e2723e6ce6025026b6d79d9a00048386a69e00c3
[12/24] ublk: document feature UBLK_F_BATCH_IO
        commit: 4d8fd7c5592acc2cc89b1759fb01171478c9ee5f
[13/24] ublk: implement batch request completion via blk_mq_end_request_batch()
        commit: 7aa78d4a3c9c30d15c0107fb652b22376aaacce6
[14/24] ublk: fix batch I/O recovery -ENODEV error
        commit: 3f3850785594e323c5adc6b19ef5907419d3159f
[15/24] selftests: ublk: fix user_data truncation for tgt_data >= 256
        commit: caf84294ff98bb7455722285f30f46c193ffccdd
[16/24] selftests: ublk: replace assert() with ublk_assert()
        commit: 584709ad5ce359f8b5773eb6af40070412652c51
[17/24] selftests: ublk: add ublk_io_buf_idx() for returning io buffer index
        commit: f1d621b5a04ea41ee90f177db084d00db57e6839
[18/24] selftests: ublk: add batch buffer management infrastructure
        commit: dccbfa9d416424fbcbc83a46e84c604bad1db9d0
[19/24] selftests: ublk: handle UBLK_U_IO_PREP_IO_CMDS
        commit: d468930a019df71951a80fde20f6348136a2175d
[20/24] selftests: ublk: handle UBLK_U_IO_COMMIT_IO_CMDS
        commit: dee7024ffecba291891503e425373d9f2a1d01b6
[21/24] selftests: ublk: handle UBLK_U_IO_FETCH_IO_CMDS
        commit: cb5a6b308700c65c29baccbb6b9b07f306633ad5
[22/24] selftests: ublk: increase timeout to 150 seconds
        commit: 4968fb7cc60676040258c8867f22931c8735126f
[23/24] selftests: ublk: add --batch/-b for enabling F_BATCH_IO
        commit: 20aeab0b08a175d9ceb4ad327f55ba5c29a79888
[24/24] selftests: ublk: support arbitrary threads/queues combination
        commit: e8cd481cc665d5db8e918e84740db22bc213059e

Best regards,
-- 
Jens Axboe



