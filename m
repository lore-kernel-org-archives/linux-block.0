Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A942069
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308706; cv=none; b=epXQo2gyN1lQ81ulCQR95owgUq14YOwftb+5mq1Ue1uwWBH/niRgDK/m7aVCeiHJG9gz1AGoifIzl3gz6qal8QZclh7eNx0blC84xzisYU+BzpvlzBLVIsFWHRSZ/uv1aNeL0bqY9+38HTdx+8PSUVoUAKVdcFsP5MAEW2wUI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308706; c=relaxed/simple;
	bh=kXCduX4hE36U/CoaPyXGNbVZJMBuWofHOZzlZuTpgTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iam/Ci3pPRzs+0XztS8ZojwN2JGD5+76+YMFfuEzn5LQEDwJX32j+nHVSJkHOfXMRvWaz5tN8cgZKmPamxQeS7bmktgWio41XnZ6mtYEo06IzvqeewYp0gdqeQ+RDKjvJEP5eYAAsAgeAfycz5DE0M+Wi2crBbonYVUNMWcFwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lMDKqoV3; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lMDKqoV3"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso4254955ab.1
        for <linux-block@vger.kernel.org>; Thu, 06 Mar 2025 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741308703; x=1741913503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qVyADKTsqTkTvG/3k9p/YQJZnQ6SccIWFfvUDbm2Rs=;
        b=lMDKqoV3Ho6NylRs+ZSwzivh46jge6AxuYpjjTt9Z6pZAwxYsRCYjQMUuiESBeXiV5
         g/zSYHeyPy/d6LBAlLbEjxNw/hucEUC4yd+VX+8PsT/5EGAVZNOpFw5mnGyAatLfANb+
         x2RVfxaooWafhVnxILuL5wdueUzqap0XEnFAei/0CTPhuqKm2oqA0M1h7iAiG9e3KS1k
         cZsfKi0rjgaPWZ22UVZlf0PpwYXMOU5tVIZ5jbvgyPWULw9VA6jXSEd9TXWieqHhNPqP
         4AKqBYEcMHv4GupJc1ADBwcBPUqGg5vFQ+cZFImymtS/UBLPEeSgWYa4pPVaEvo+WQdQ
         SANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741308703; x=1741913503;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qVyADKTsqTkTvG/3k9p/YQJZnQ6SccIWFfvUDbm2Rs=;
        b=VzlBxuTT3VOxzmx0q5/3zhZ/dBA+pTkHQD3km7mV0y9P9QLqCIg64+3Ni1SQ/PakFm
         HMXPrKpLC2BVKW2H1BXUtcvqEbSy1HSVSbeEq2QtfYGLEPu3OZsaaVulDHPnUXIps2UO
         Yk0vWhfdgmcNrSsCbXjZ6Atk8e1rEz6+hTBWTlTf1dsAi6I5gKsAUhLrvzSnFw9jF7Ws
         uz5oVTEPGDZmUanyYLvPGfVHrPN5MTrm1YC6DzEAkTpgcfn+QR3Jl+zRLch8m8zI69N1
         4nE0QGIkpetP3unnhWQYMj0Cwbz1lt7xjlmJD1mhXm/90QhNcKnmUqZrlIa6POqbNtjq
         Me5w==
X-Gm-Message-State: AOJu0YxIfOXn4F3WkyOgL0KMDvAOucwt8DSEWG2145x8G6UalQYOPKOX
	vBHEiu/Vwm1pfZ3vRpmmUBZTmiI/c23qs8u8bwG+5wfEcMIcJHekmMsLjFqdEvc=
X-Gm-Gg: ASbGncvWpGlbBmsyw9dPud9sSU4tBGosDKy/8vhVvpjfXZIIqZ10gdB9d6p/+d3/2Ei
	RHqc4jblNkk40jMNkaXkVOEPMVqX9YycKSHRMrgnxxZZG0NdXx8O1UiIyhZCOWqVYuH+Fv2xRQq
	XRfz26paJ7VYEeXA+/FQZCLJzXlvK7bF5H/ZDYbx5UIR3dbo5Tr5YcpQ2ypoSjehYmopyjY9KNA
	8ZccwMOjmLUFRJEHgp9SivDrmup3o5jtNw0pP6lxrqpgFloWcrO4e8uMNIf8dpD4Hf523m7MpF5
	VD4aeGpvkqMbOEIY4w0J4svn4Ou6XpQ7ymNk
X-Google-Smtp-Source: AGHT+IFvMFyVJzq0CGa/q6ARLt4ujQOSTJjZd+XWOlBRoiADhUQftyPtRq86dsu188a1/xZu5uDMzA==
X-Received: by 2002:a05:6e02:1d03:b0:3d0:4e57:bbda with SMTP id e9e14a558f8ab-3d441933046mr21325595ab.1.1741308702832;
        Thu, 06 Mar 2025 16:51:42 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b599842sm5459815ab.64.2025.03.06.16.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 16:51:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Breno Leitao <leitao@debian.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, kernel-team@meta.com, 
 Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250306-rqf_flags-v1-1-bbd64918b406@debian.org>
References: <20250306-rqf_flags-v1-1-bbd64918b406@debian.org>
Subject: Re: [PATCH] block: Name the RQF flags enum
Message-Id: <174130870132.334915.1531694322372614000.b4-ty@kernel.dk>
Date: Thu, 06 Mar 2025 17:51:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 06 Mar 2025 08:27:51 -0800, Breno Leitao wrote:
> Commit 5f89154e8e9e3445f9b59 ("block: Use enum to define RQF_x bit
> indexes") converted the RQF flags to an anonymous enum, which was
> a beneficial change. This patch goes one step further by naming the enum
> as "rqf_flags".
> 
> This naming enables exporting these flags to BPF clients, eliminating
> the need to duplicate these flags in BPF code. Instead, BPF clients can
> now access the same kernel-side values through CO:RE (Compile Once, Run
> Everywhere), as shown in this example:
> 
> [...]

Applied, thanks!

[1/1] block: Name the RQF flags enum
      commit: e7112524e5e885181cc5ae4d258f33b9dbe0b907

Best regards,
-- 
Jens Axboe



