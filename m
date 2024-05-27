Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E61BC59
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839936; cv=none; b=PT4q/HPvCgcBTte1RVEdH5qEAogt01o61oWb1rn9J/Jf3WSWqO8nppwYvi11/jvb470kb2YewyrOpncAM79LNKAA57oXOYipr2vUOhpbRMNINEPBseOFB6+X75SGHR+RolMoaWzIIf12Vn+IeSh4GqhlFgl/ew/b789/Qu+HMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839936; c=relaxed/simple;
	bh=ks7Mff04vGsMnYvo++ZgpbVUC58K1Rpct1dh+KIWgFY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mcKwGFsyoTWn3ZSlZ563TnISdBnLDbPzP5G0zgX21cxkfWDKbZ3O7NC/VK8xyLPrmUHJyau7tBrllwSObw7zWTbiqvv2acAUl/AMEtLlgkWo5tjch2ihXDWtPYwPVNbyG9GvdfdsOScrHctfsZdU2TxALToBlJHjpGmzhPh9c9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EbnoTdId; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EbnoTdId"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bdd6b73a3aso10162a91.3
        for <linux-block@vger.kernel.org>; Mon, 27 May 2024 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716839934; x=1717444734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCtCHMcHGMsYabdcrTqMbv7AnaT2U5qGwPVOFGULJ1o=;
        b=EbnoTdId3NxJG0KlUC7WP2Oo15uqEUL6PYNOytUppr4vz+EfdjnXAIClxpE2yYa6V/
         K0GFMFuoU5Oh9pCBej9q1mAemfKiVU1s1BXQIimnVIvbmfA58TvFUcjduM6dNZsP6wyH
         OUSCVQwudDowCk5GeTqilB6C6Sa3Sj45KV5EeoRLA1sgg08QyiDNpa4qKhMlv1wutC52
         VG2XPsXmCmWNop7HcujFGHcU91+ZSeYAMftkcmIE9jnIDSPJk2W73ClwxXXvEkefmwoo
         Xo6/Han2y7bo3zlh3QLpNblGWyHPfA2xECfZ2X8qv7fSqOXonbvMcOFIP52HiSWomR0j
         QNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716839934; x=1717444734;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCtCHMcHGMsYabdcrTqMbv7AnaT2U5qGwPVOFGULJ1o=;
        b=JzLcYVhU4bvm0oc/3cj4U8q37aEMDxdyjztotp0jGN7o9cpg8irtlmHxtbEeq7rmyI
         U1JgzHQwO+2r/0ARDlYebZPPEri8g2bkEY3oryOje5SwnMdkwUvalSKzQ2zrICAFKeDP
         3axemL7BPEXqOaa9YmeIYAvSmoxPwSQBjOGtF8IL+tdjkxd4aKJLSW8zxaEKqLqG6hqt
         KSnRY3BLTEtqOp2NeFb17YLJNnlXP7/1St2BiPp9gq3Xly3AcO5VTq4r7gkoiSL1B5Gh
         PvQsK1wwsmV6OFejEAxQcXU6UeWw6FqhwKiTJ3RLP46sASD3BouGmv6ANRlnhwZCEaxl
         FptQ==
X-Gm-Message-State: AOJu0YzwjcEAUVUaLrfLDNuWy1lSjSze/Tw2mWlpoEe/P5yLpZnTdoSB
	FXxZGTRXyWExGSbG0wR3HvIYj3RzwQmq5RbZdyqleUODF0urKAEyBYH3SIg3rf+5PFu/Hja0KBw
	n
X-Google-Smtp-Source: AGHT+IHwIZPGluEus19FHdXWfCpeZrfreP+zIjtoh4A1gbN0wdglgFYVjd7Dn3/nbJj/bXdL8h7oAQ==
X-Received: by 2002:a17:90a:df13:b0:2bd:7e73:6628 with SMTP id 98e67ed59e1d1-2bf5e0c1bc4mr9801465a91.0.1716839934416;
        Mon, 27 May 2024 12:58:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5e13b6acsm6218409a91.0.2024.05.27.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:58:53 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hexue <xue01.he@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240527084533.1485210-1-xue01.he@samsung.com>
References: <CGME20240527084541epcas5p17fa0a6ee3f53148ff0896703c58146b6@epcas5p1.samsung.com>
 <20240527084533.1485210-1-xue01.he@samsung.com>
Subject: Re: [PATCH v2] block: delete redundant function declarations
Message-Id: <171683993340.262308.9239565153961135856.b4-ty@kernel.dk>
Date: Mon, 27 May 2024 13:58:53 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 27 May 2024 16:45:33 +0800, hexue wrote:
> blk_stats_alloc_enable is used in block hybrid poll, the related function
> definitions have been removed by patch:
> commit 54bdd67d0f88 ("blk-mq: remove hybrid polling")
> but the function declaration was not deleted.
> 
> 

Applied, thanks!

[1/1] block: delete redundant function declarations
      commit: 30a0e3135f9aa14ba745f767375183b3112d7440

Best regards,
-- 
Jens Axboe



