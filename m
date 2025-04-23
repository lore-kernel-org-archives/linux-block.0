Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477D263F45
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745374172; cv=none; b=FOHcUfc6hmAtO6bAcBV2WI4+iREwBeODaNOxfqVz5JeuCtlKC7+UEOAmyzsN42g8rSyabYP/VFJVAHUhCPBAHk80uxnZLQPkdSp/29OEi4Ny+EcoAua2yzGwYOhYwq+CvNF4WD0+zyRCflGth7LS5N25Gsry9TFANzEewcTGano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745374172; c=relaxed/simple;
	bh=/NMem5ifgNES89PzacLrSaCky+MNKn14k07t4KV28GM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QAVA1pZchwFr5pNKII4gzk+YOWJRYzt0hHggLHPIDCe/aMypgte/KayUh0GxvIETpcecMeGqaDqyGxDECEEWpfEBmbmT1qP1DRTC4oNYjrsq3+LTkLPMv9S2J7gF2qtNwKN40zsGzN7jamZD338s8VyTWPAZTeuviT9F5uxFlYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HmpxRr9X; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HmpxRr9X"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86135d11760so134931739f.2
        for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 19:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745374168; x=1745978968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDncI1nPVws6EBYZHfi3/MSZu0PJAZs4upykCL1QGVY=;
        b=HmpxRr9XLvbg9aiOvT5GTRaVODwGD7ofjXEmI0NwV4mXDTX9c9xT18WKlMiNLLzLhe
         xrij/9gDLXH5y3jEZZp+vLbhb7n/F0CC3QeLEGCnDMKzNWQ8L1y1AQNZ+Ta1qm18l9z2
         wE07bVYvVwuek2g3oLKugarlNElfoB5gQ4Xzw0hSGK1A4m/IaRqmWM3Teb8fwU2h4sTi
         jiH3ukql4dSeqmrFEPft6vrv+cUKY4DfHEHGXF/NK6ux0GkmlmQ65lUI3TcDy6izoMQU
         X71XS1GRKJj2c/L/7J8meH0hOz9bXh5EEtQ8+TNpVIYwcpvc6MuAwuz4P9jow5t4l00t
         suiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745374168; x=1745978968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDncI1nPVws6EBYZHfi3/MSZu0PJAZs4upykCL1QGVY=;
        b=wQK8STfCmBz6AHGOms83tYRqiKDar9TJN2sI/tc8OrPcd9DrskO0zGCkYsINBwqmk1
         aKQkXTjCZYw2TEacfkQa+yDYlqLDskwix4VDt8/1reNidEMStpeYU+PgR7pT/MzG9l1q
         J8ycXdrgxWQZc7p+p2KG+mjhUKRAl3/RnbpEuzYezL3ctv8CJ1I7Tc9iWbLMhhbqiok7
         +WhY1bGjWBHPQl8zzMsTpgmgug0XarbvmZmZ9gmXIKSEH0gYSOO6s4LJ0qcefnj4vgaM
         v7JxOdXmhrXPuRrzn27NBTFAQTteTfFtjwAGkCWtaKZx3pSbubb0aJpyrixxWsu8BJ6I
         eGzw==
X-Gm-Message-State: AOJu0YyFZER/gwzOMuFzlgt2zie/8eimC2nA6V+eyFUEWxAzzIjUCHml
	AlBHG3IUmHexsYRq15pnWztIwle3/JABFkBu0O8wNc2ugDUn3P0sjp5INbtYVlE=
X-Gm-Gg: ASbGnctuXzm/tlu6exWwOsdulXtz+ZM4AXkxTXLRyq6PR79uiVWMbILlcuhgEZ5bFTP
	Pi3Uw6rGz2ytp4FSHaufSZBqKEYEbyL+mTL6oEtR7SpUiUv7pKmxiHZQkKVGyVvdVSN/XpCfzvR
	5Y+atVRW0z203i/Ktp1ONHTIjrswTH0lzTcVGNo9FVPBhTKv4n+nbTxV1auFRFnwIw6pJRDisEV
	tdZzCa1l7v1AdTv+aKVmGwxnE4g1GjirruFgXEJ8n48nGurMao9V0v4zsvl/TVmeX/jywmpNLjj
	qULM26Wr/IU614Q3Xoi47kPAjQDro7Bc
X-Google-Smtp-Source: AGHT+IEgm4a1sBAZfV84Lo+Jj62woBUyaarGSN3fVcO/fQpfQe7SP2Yo0ZBKUHqWAvQ1YYJuA9QRsQ==
X-Received: by 2002:a05:6602:7506:b0:861:722e:2cbc with SMTP id ca18e2360f4ac-861dbedeb19mr2091941839f.12.1745374168145;
        Tue, 22 Apr 2025 19:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3933d27sm2593769173.90.2025.04.22.19.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 19:09:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416170154.3621609-1-csander@purestorage.com>
References: <20250416170154.3621609-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: remove unnecessary ubq checks
Message-Id: <174537416718.373753.18092056116763739728.b4-ty@kernel.dk>
Date: Tue, 22 Apr 2025 20:09:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 16 Apr 2025 11:01:53 -0600, Caleb Sander Mateos wrote:
> ublk_init_queues() ensures that all nr_hw_queues queues are initialized,
> with each ublk_queue's q_id set to its index. And ublk_init_queues() is
> called before ublk_add_chdev(), which creates the cdev. Is is therefore
> impossible for the !ubq || ub_cmd->q_id != ubq->q_id condition to hit in
> __ublk_ch_uring_cmd(). Remove it to avoids some branches in the I/O path.
> 
> 
> [...]

Applied, thanks!

[1/1] ublk: remove unnecessary ubq checks
      commit: 4c7d3c88c77bf227c12ef13e8461a0c940f775e8

Best regards,
-- 
Jens Axboe



