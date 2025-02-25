Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B726A1AA
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496028; cv=none; b=gk/8z8TpPooViRUsFkUg0a5ZwOvXlRujYv/FOygnXkApQ/Fxvi/UeQzQRe6+9mkd3MMIzxuVgCzAHL9QOP4KPdPYNBrowcMwA+l8L72hYia4wKGvPkYlqtFjK+c6cwqxQxNOqNEbOXHgBEFcOeoWiVNr2VexwLEHQXcYxSsS9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496028; c=relaxed/simple;
	bh=B009efDPZygZyxJVOw4K+czmRA9Exrb2Qa97Ni5jlPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UJfFxstXV3te/rtR//DBV4TJugAno2EThlpXoJTr2IvGZldJE8XHP2VoCy+2/yapDY4zPznZFYmy4wsEEdIyVcwSI0ibzVifAYWDpcUABuHcvfiYQr5yW6IbnM9Y65l9oEeSXmj37ODBtH9yUlFoW3yBKJzXtak0D/t6a4x8u34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y7IFYxzS; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y7IFYxzS"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-855a8c1ffe9so169819639f.1
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740496025; x=1741100825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deTsz6vaPYf3sDSf//6kgc+SRaxAQgKuaPfuRfkDB18=;
        b=y7IFYxzSTypHDo2++RL122sfZX8W8McCZPf8eMux7eEf8BtimuHioIQYZGtN0br4E+
         mukWZs4ST1XkyZ2WJVy6et4QW67y8LHBuQjTjaeJ+nIu48t9yextxr47JnPU5NaiAmn2
         5lXMBEcMJo29fuzitVNt3ZxUsVN0UfQDytDepk3uR/P0+XiNibrVKhCGhcw74Pg10syy
         LuVb8GtSujYKnAFDrCuxrCHFGxSYnRy/AJGCZPbDriwoGNUvY/HYUqRJlppmroYICfpB
         54Wj1a8//SFqBEVt3hSynvNBPQAvK7IkbnOAW1zrFlhJxlAu+QpYcqlur1byHVcFWgT/
         wdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740496025; x=1741100825;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deTsz6vaPYf3sDSf//6kgc+SRaxAQgKuaPfuRfkDB18=;
        b=h5dUpij9tXng4cacbWm1YpCL1PPoq1YtHlQcc5Uz1jyWHy5DXDm0Jdp0Qc/u7fsmXn
         CSPsDCleBpy4anuJZn/45BN8ll+IlqB92xhj5pgOTF5/lBgT0rQBAhKvh+SxLenHRQCb
         dShlY1NRzkCqd0QFxu40jJWLEFM/DWjpZmidoh7EXKL4ZyEWJHYy0wXT4oj44AunYWQ4
         VMLHnk3GnhH/kpvUexkj3xc4ko3KQqbPVwA776VRLzY68HcQ17i/evMZ0d9QcZ8vfk5w
         eEwXua5f9mtFIQItBWQQyL0rzk6tn8HOT0R4oyPhofio0+7MoKWblVFi3WkW/V9sPAIT
         2HCg==
X-Forwarded-Encrypted: i=1; AJvYcCUX1XXm7aoaudWXhh/oP8bRUBO6mMX07JcI5Yv+usWtwxSHRzLW46AFoFpS9p60ZjDvWqA9KMmH77Ro3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFEMZSbkMpLexs7yy9dqf6b2RDa/eMmG37b0wkUdxSQiU47a3
	YsAKjzn0ENdqNeRELSIezduWwWlGfogdIv3sWFkEShVCFqxMy6yFlo3Z3qUX4Xg=
X-Gm-Gg: ASbGnctZtQfB5a1z7Bm7OQIa3605Vsp3jLHyEEaezbJgIVKYAVUQPe8/FpKkyxv/y+9
	hw7e3fgpeKh9GqRPVkiW/pcYDHtXSMRdfpIKKJHFF736RD4NPqZyByb071bC1JH+MxAsD/hTomF
	7YH6dUFDVwbxmt+y/GSc57Qd1Xzl05ezIM5umvqHt/gXNdYCydOi9Caly1fwoXc+15yyFYK+a3u
	3087cu1LuPAvkCpB0LWNUk2zOrTMhiK5BEQ2TXpAzHDhhoHKgrDR7068pkCzMc3BtpvUzkVjSzI
	/ewbWBk9yJgrSR8d
X-Google-Smtp-Source: AGHT+IEljIBkpApQgkYcq8zFrUakPE3hYS5jFm3Tnmq5CM5VHY6XZWLhxEu6NYet7gZ7xOt6Xk2Rfw==
X-Received: by 2002:a05:6e02:b2a:b0:3ce:78e5:d36d with SMTP id e9e14a558f8ab-3d2fc0ea5camr39683735ab.12.1740496024806;
        Tue, 25 Feb 2025 07:07:04 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04750fcd6sm435827173.94.2025.02.25.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:07:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, asml.silence@gmail.com, 
 linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: bernd@bsbernd.com, csander@purestorage.com, 
 Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250224213116.3509093-1-kbusch@meta.com>
References: <20250224213116.3509093-1-kbusch@meta.com>
Subject: Re: (subset) [PATCHv5 00/11] ublk zero copy support
Message-Id: <174049602370.2137789.11659945725792344397.b4-ty@kernel.dk>
Date: Tue, 25 Feb 2025 08:07:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Mon, 24 Feb 2025 13:31:05 -0800, Keith Busch wrote:
> Changes from v4:
> 
>   A few cleanup prep patches from me and Pavel are at the beginning of
>   this series.
> 
>   Uses Pavel's combined buffer lookup and import. This simplifies
>   utilizing fixed buffers a bit later in the series, and obviates any
>   need to generically handle fixed buffers. This also fixes up the net
>   zero-copy notif assignemnet that Ming pointed out.
> 
> [...]

Applied, thanks!

[01/11] io_uring/rsrc: remove redundant check for valid imu
        commit: 559d80da74a0d61a92fffa085db165eea6431ee8
[02/11] io_uring/nop: reuse req->buf_index
        commit: ee993fe7a5f6641d0e02fbc5d6378d77b2f39d08
[03/11] io_uring/net: reuse req->buf_index for sendzc
        commit: 1a917a2d5c7ea5ea1640b260c280c2f805c94854
[04/11] io_uring/nvme: pass issue_flags to io_uring_cmd_import_fixed()
        commit: 7323341f44c17b27e5622d66460fa9726e44321a
[05/11] io_uring: combine buffer lookup and import
        commit: 82cbf420496cffbb8e228ebd065851155978bab6

Best regards,
-- 
Jens Axboe



