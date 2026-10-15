Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1B4C67F9
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068077; cv=none; b=g07GJmWSwAlQKHEr7wbuBCv6eh65lC211V2OjFdCXSXQLeKrA/+kdo2Odxk4cWtKeCZRoc5xgaVNt/zMKXjwOzd0gPSpjpVdJo569D5qe1yN3i5dEXjmGiUEaH8whhobSsaXrfPA8VekO1EKm8iajBSorMP9DZyVQ2ULet/IBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068077; c=relaxed/simple;
	bh=0VkRb5EyS8A2bFkpkhk8wGvwDnW+nQDGlAudEbx1lUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mKlXLtbO2Qlf+3fYQZCMMoupCy+GsH+eZfKIYx9sE3u5wk/EBmRM5+TRK5CVXwbB6ZEx6b4pfgiOK8Y692AkPqZjCsObw90v+Mftk1/w5rl5hMGpEhp/s18T3VvrfqpWu3K+5kASwJTR9YMJ1HP9vTTkbQ9v4TChobcV+mVvHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=nMiEL6qw; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="nMiEL6qw"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b1afdf5196so1760291eaf.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792068073; x=1792672873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rVT56IK98h4jI9P5ye9fE3iPJfDwMGiMmvMYw20b5GQ=;
        b=nMiEL6qwiE/acaL3W+hCvEYQm9nToW2YVPYKPNVedM7fo3mN/exyrI/BXfTBeyizxh
         Gt1+0FcfE935qQ7+fCXs5AliM4Xe5bes3P1jphtL/YLEwbF3q35Hpw58fLYuSLm36cL0
         ePM1T04PipE07xY3966o8S6I0RomBtzqOe4b0XSRXx0LHLAVf4XOLqJnak8GkRMWVzuL
         KrFSXhD+nDsyvd+lNOXB9mzNB5Gzcy53CS+hEh86HgPbSybD2evcRsW4KJENHZDPSxJ5
         AtPMpshK7OJ3G0yWDdMYv3Bi/zEP+fWdCifPBBaglsBfkTpEFA7488fHYl3B54M33fbs
         pH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068073; x=1792672873;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVT56IK98h4jI9P5ye9fE3iPJfDwMGiMmvMYw20b5GQ=;
        b=lp+awMLSYqdcZbIJprJaoDmt0ml+8DpwRP3Vxhc4fVjbUMXcSeMFR0cQGfv8OkkIjR
         OWX9gmgUSlf4qnbh+HtyZFKQ5GQrMmlq4dwsrMQVGXQuY2J3uAAayUFtnCFDWAzanH17
         YfCK0zlsCsPkTpqnLP7Yk23xYjWi1brSJi+nDATCVypf4Zva67wYueN+j2luld5Tfm9l
         SO/v2oH1/aMsB7zSujzmRnpPBlPrj+eNR2scyMTXdLhIuiYzHfr4UUhrajGOk0iQ2RXg
         z+hzVOTXn9pujPlBWn2Ti0bepKpfJYtQaxgwDfjrxIGmaDMSO2IMd/c/iSVQSkmtrzM5
         ovKw==
X-Gm-Message-State: AFq9FYIMCuMDJYRjJ6iScaLVHte/Svo0qKgt71QBfi3VkNeVrKAbixvp
	wB0svJod37NynSNbZIC9gMqcmSHLHjfvPWazVNEfNSlPwzA/iqk/QiMDhmcznQ4NlO3B2HrEiuZ
	wY19zbPU=
X-Gm-Gg: AYBFou2RABs83mycA84fFG4W1fo6AfYbtET5lZsJx9VPbF1t/elPBgLkuHUgRzDa5aF
	vCshl5gzweZxlWkmPZiNc/HgwJU3c/7lc4ZV5pm6S/h51YskepvKC2X35Lfz9FLwXMnTsR1BWRM
	d7JH0DKw2uUPUOVF6CSE+IV4wY26lQs4kDKEZAIB1fM8t9zfWpcvl49GennqdRsm1x4QoV0TH3Z
	5h89ntIhxNWD02dIY3xtPosiDOrIrAy2QDDy0Gk9XtilLhz0k9c/YKpr0GpteVtGpv+DxhWGyYG
	MHxqYHx+WkvBUX20X2MidqwtwRTvU1PkABTYvcLMfyIh2svqpAJr5pZLYKifbYNaKtqtOdXkBNL
	lfWxQzXvjsgQsOr51BhcpOoWoZNegq9tGdNEDbeyxcUi6XaTKi2QiN/fQChQJgCerUrsH5+ISj3
	nj0DIQae5TD84FO5ZUDmebr7c843w3e3TJjOy0HLQ/inBkWcmINkqbvhkej7hPyCZBmjLuwWZut
	DqfAr9LZf5/BaTQKXhabvmUqXoN4bsC4L4FDMrWpoObrar6j5cBYHteA3FVqyhWc3Hw
X-Received: by 2002:a05:6820:3503:10b0:6e4:116f:1cc9 with SMTP id 006d021491bc7-6f3cc9723cfmr7213248eaf.85.1792068073329;
        Thu, 15 Oct 2026 05:41:13 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef03e39840sm16000474eaf.15.2026.10.15.05.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Julian Sun <sunjunchao@bytedance.com>
Cc: jack@suse.cz, viro@zeniv.linux.org.uk, mcgrof@kernel.org, 
 djwong@kernel.org
In-Reply-To: <20261015091105.1315605-1-sunjunchao@bytedance.com>
References: <20261015091105.1315605-1-sunjunchao@bytedance.com>
Subject: Re: [PATCH 0/2] block: fix NOWAIT handling and locking in buffered
 write fallback
Message-Id: <179206807043.1369049.6734759519195457019.b4-ty@b4>
Date: Thu, 15 Oct 2026 06:41:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 15 Oct 2026 17:11:03 +0800, Julian Sun wrote:
> This series fixes two issues in buffered fallback for direct writes to
> block devices.
> 
> 1. NOWAIT requests can fall back to buffered I/O and wait for writeback.
> 2. The fallback path lacks shared inode locking against set_blocksize().
> 
> Julian Sun (2):
>   block: reject NOWAIT buffered write fallback
>   block: take the inode lock for buffered write fallback
> 
> [...]

Applied, thanks!

[1/2] block: reject NOWAIT buffered write fallback
      commit: a08bf4b9f87898628e70882430b8dd4260730dba
[2/2] block: take the inode lock for buffered write fallback
      commit: 1b1be9ea4e34ccede1e7cf9ff2b6317328a5b6ad

Best regards,
-- 
Jens Axboe



