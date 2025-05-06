Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D47208CA
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539309; cv=none; b=aSYqZwA8mf5hS02dgKjXvXFuRx7bYSAIZpIiPZSaMRa4pLSZ7pUcj9ozbxXI4vYHuPQ0izhQbLUj8Lr2G+AXnuv4J4aF+H+vFy1GIBQElPhRKKyMC3ATuhmgInc9gmgUmw8XdFoMts424mTCmIT5cWdIG3Nv1YyxU61rdQCPM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539309; c=relaxed/simple;
	bh=0sCrJwF/p5zC9nd8ieON1sj24FAamlhRgGj2fKUgdAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cxMUzmXQM5r1XiTJlBXB4u6yiIdLpZ7JZlLyWOK0OAG8OyB5pIBors5Zc/m3s7+I/eJiqVsF70BBEiZgUpFjDyDHc2GAolcLoE4+z9dQjjD5oqD9ONZr3UQSp2x3QO/P1hVJDJiO6X6Op4c9OJk0OAY9BvfygPWwZCMhOFATya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BGlZjfpF; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BGlZjfpF"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85e751cffbeso461956539f.0
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746539305; x=1747144105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVAA0vmooW4PrL8hTCHIASn3ke2wAXZ91chlrtSDfdM=;
        b=BGlZjfpFe0wn2Jmv38VWG2nyBBpuW91YZKllm2RCVANaIlgm6pCNOPJ5lcfLZaBFrL
         IBrr460AbgCyjPaZJ5O3Fk7IkSGSsqXqbF07mxz5Zl3udi5c4hbvHWwhpAo5T7oIr2jK
         dXsL6cWSV6QbWVZQlb7qe1Wyri8mVmzG8OCEAoxaL3kjP/CkeCtqpkFIWZ+r8FKNfeok
         adoJME4EmdBRwXud0D7PZSNsjyE63ZOEKs8Cysj5x6MabW/03ldgUO6paqrlhIBqBYdL
         tPd0frJuPPAZ7H4foM/LYAcShn6LYOXUIjJKbA/ZehTfi828YQKPUxhFSUps8yQp8UBe
         y/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539305; x=1747144105;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVAA0vmooW4PrL8hTCHIASn3ke2wAXZ91chlrtSDfdM=;
        b=s6guCeul6sNgkeNlVgdabZeCaL1eXraxR6gZ2DCd4u7J7yRfMyta/nuDjtW9ixseyM
         LLveXMRklJ+KNdruzpsC/JaulmPVY+MeaMjiA3J6BbL4SoZtffze7QuWgG0Po/RZm0lD
         rLOh9uzJg90Cm77aktPOXptbu98iGUUwT3slb3epfyrYxTJ6LEuhb2L+oBRJ4FD41Z53
         WojYlua1zTs07mKY5WXPefKDccywXIBc4q8wbf2HzKYSmuSy5yAyxTHaaafqZ652zJwT
         M1q3vlAMrA2PbjKy+7sZMIEjD4NGqMXGVQJR4TukarMAHTpZB1vY6Pabt66emeaKB0Az
         sOwQ==
X-Gm-Message-State: AOJu0YwkmNQiM0NMIqSel+J5p3IDgAvNWU3kfDFvPzC4AOjfVkoMPOyG
	ASe2aQ7HsvwJtqsVlDcXI0pIdb0m+Q8+BX/Hjz6wgLu/BNyrZyVwCrSkrEyFDWg=
X-Gm-Gg: ASbGncvj+gPb/PxDsHHZqmbFe5ivJED6DZhDcfrnr/zYiHpj9gjs5tTVVKQ9cRgca6K
	zq+VcYV4U8d0eobpD5w3xBupvnJAG0hGot99MPKPTCJqtVNeH/pmwzdJd0Y0SZDp/vP4COnpz8r
	c3AaRKpoX+VaDHpXLoBy2eIoI/tBTGMIvQHyKn2iHd2ok2EVZJgms2Y9PithdAdbe3X3l/bkEiC
	pDpp+EXmF6KuKSWoX8n6RA5+H76S9NDwRbR1MwftBFYd9tsK8TzwWwyY5M0e9S5WrFIxPtj3w42
	ZnInsLiW+Nw8XQkrE67UXGbnjRHeAM8=
X-Google-Smtp-Source: AGHT+IHlgZr9j7rIqGzn9fM256sGLzOt+AOLttsWJ6G2DH+U5erWdHnBA5zxuh+srnEZx8/jn/Qwlw==
X-Received: by 2002:a05:6e02:1685:b0:3d0:1fc4:edf0 with SMTP id e9e14a558f8ab-3da6ce07179mr39550715ab.15.1746539305697;
        Tue, 06 May 2025 06:48:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f58be3sm25930915ab.58.2025.05.06.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:48:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250505172624.1121839-1-csander@purestorage.com>
References: <20250505172624.1121839-1-csander@purestorage.com>
Subject: Re: [PATCH v2] ublk: consolidate UBLK_IO_FLAG_OWNED_BY_SRV checks
Message-Id: <174653930494.1466231.13050848343304630692.b4-ty@kernel.dk>
Date: Tue, 06 May 2025 07:48:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 05 May 2025 11:26:23 -0600, Caleb Sander Mateos wrote:
> Every ublk I/O command except UBLK_IO_FETCH_REQ checks that the ublk_io
> has UBLK_IO_FLAG_OWNED_BY_SRV set. Consolidate the separate checks into
> a single one in __ublk_ch_uring_cmd(), analogous to those for
> UBLK_IO_FLAG_ACTIVE and UBLK_IO_FLAG_NEED_GET_DATA.
> 
> 

Applied, thanks!

[1/1] ublk: consolidate UBLK_IO_FLAG_OWNED_BY_SRV checks
      commit: e96ee7e1deaa74c5cc80ab03b51943ece5809984

Best regards,
-- 
Jens Axboe



