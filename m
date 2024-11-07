Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867D192B73
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731018969; cv=none; b=huMqfibJbJXdnYVtb7Dg3CicCpcUu0/3y0Y8Y34IyBkUf/F5k+FDU8PNkq2LidlbVJwf5N0WK5lwxZSRJ+rWCIAbxkixiVUk51NBdxhft7S8ajQ2MDdJ02umlLh0MN0ncZ73i3n+OU7Q3lKg/gjUywhh+0KeVIw2ooqQBdBgavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731018969; c=relaxed/simple;
	bh=bCL4mPl+uKiO5OLaD6a26tnCZQrNfn7ckvad7so5gY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rmTuqBoiLljhTYmQrbO7XKmmkpfk8UYf/FloS+jGsqg67QtGGPfQPa5MS9+Nm67BYRDO8osB4jBhpaqcByH6Db5wiQeCDYDrbk7oDPFViBYrBnZ6CA719VbHejH3eK23nmD36HonU/jTCecaYElmfcknBbIgR/eeDA4V+OmP7ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UxrT6Ut+; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UxrT6Ut+"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5f968230bso855231b6e.3
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 14:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731018967; x=1731623767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTqplkmd1oO+cDQ02FzVSJQIEeacVX2zBVF1DfowAhY=;
        b=UxrT6Ut+rmFmb0zhoQRNv6AVbLA8UUo/iVnr2ZleVa2yPZFKhhSheLIp0I0QfaDP/d
         bTdzrMec2xuLbSfwFS6OyNIozd6HlmC8FtB8HyK1CU13AuvqDN1Ug7ArwesFm4qbcEa5
         gPLkW/Qm5qeHPSCsWoguWdiSN1N2NFs/JztzYYjCRbneN5MjzXh0rUSi/KFxs1Y0xZx1
         WBOz5/fotQFJgT4V2Ti2lpOlBXRAAxAZMfT5LN51lhv0aF2J5GnrWjjl9gPvwrQkEhGr
         DeHVXw0NMtutXKmLKOyXADt75RqSXBfFgenqUB2OltFdGCl6ZoYP+KZ2JaZF2+/vf0Jm
         OcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731018967; x=1731623767;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTqplkmd1oO+cDQ02FzVSJQIEeacVX2zBVF1DfowAhY=;
        b=N7IdN7aF984NzIJeJKOWHyBCKLcKAa8GSNNE1RVeFmKsyMRmE8VIfjK5gZzcN5Xfbt
         zOnr524cup684Gc05vgAMh3OMufQiXDBtJMs7jz0YEUeGuA3/F/HNS6nqHdZIGCJAr3/
         pkLLTK9vrOvseSNtQeFyiEJipVcPY4zBp+PUSWM9RuQaejX0b9JjwdnVk9F6m336c5Bq
         aOLC6msamrivmOj9m0qvCkyVlETnZFYG4XXysbEtJ0KAxIx92tw8Zc1Fnpoy0MPf0NVn
         oYYrVMiusjaVi/EOxmIK5Ys+uIOhhu78Nahyjk39i6saBPnUFvPLQSH2zb8s+iFxMQLL
         D9Tw==
X-Gm-Message-State: AOJu0YxNextfDAN1wlgemFdjVXkhGKslsHMtRCLeLjuhdNc/Tv92WjiG
	kmStv7eTBEoePohlNHhPNQaqg8Qu1qnfWm/zCmXpj4Z3mvkQj6boF45TPu4jR2c=
X-Google-Smtp-Source: AGHT+IGk7/iCDuk7k11o8jqdaJjFfjiiCG/HkKL3ykX33IYYarQ6sNKSrJTzYjDQNIvyDfW43TEcTg==
X-Received: by 2002:a05:6808:15a0:b0:3e6:1ea5:6b30 with SMTP id 5614622812f47-3e7946aec3fmr1081232b6e.24.1731018966766;
        Thu, 07 Nov 2024 14:36:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cca4fbfsm457821b6e.24.2024.11.07.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:36:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, zhangguopeng <zhangguopeng@kylinos.cn>
Cc: hch@lst.de, ming.lei@redhat.com, yukuai3@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241107104258.29742-1-zhangguopeng@kylinos.cn>
References: <20241107104258.29742-1-zhangguopeng@kylinos.cn>
Subject: Re: [PATCH v2] block: Replace sprintf() with sysfs_emit()
Message-Id: <173101896555.1015163.9216450575734590168.b4-ty@kernel.dk>
Date: Thu, 07 Nov 2024 15:36:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 07 Nov 2024 18:42:58 +0800, zhangguopeng wrote:
> Per Documentation/filesystems/sysfs.rst, show() should only use
> sysfs_emit() or sysfs_emit_at() when formatting the value to be
> returned to user space.
> 
> No functional change intended.
> 
> 
> [...]

Applied, thanks!

[1/1] block: Replace sprintf() with sysfs_emit()
      commit: 8e71afb94d6ed59055b67dadbc423c70104f21a9

Best regards,
-- 
Jens Axboe



