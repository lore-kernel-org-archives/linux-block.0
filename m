Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247D147C82
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138854; cv=none; b=GVfEMOPcPnr83Cq9PKIxZiv+N1pyqXQMNmoVddot1HH7hvPe3K7bvtZTGVHRwHkk0MvZmVxEB4zrCjOL/shQH0zF1mMNym3CoyvedJjZnbZXO8dpDi2vR94vSZBKZcZ1SVM9Oe+zg+rho1Eam0sjRSsA/SZyb45KoJYrD+6GGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138854; c=relaxed/simple;
	bh=qSR9KdDtou4elM0dFMdXIBi+jhpmshH2TEdB7PPNUzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X/ETkDB5i1MCJmFW4zQF+lw+aIA6q1JMjFEP0EmUxowt77xC1+AI+7G8kT4eg1EssgqqQEbgo1B4LtLJ/etOzfIIKrljuR1NOcY2uozBig0MzKdkMgzU2dhg4B1QzXbLCKlGSXBBE85LbLJRJgZi0jTtt6YREnmXj5XuA4KGgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=edkAi9YZ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="edkAi9YZ"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d9ef422859so17225539f.0
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714138852; x=1714743652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xyNmLTuWEvR72GEYCrL1zsIHBKSa0ehqFFEtMyryas=;
        b=edkAi9YZffOLOLGTJY1+vu0uEJ6hu+Ubudm0SeI8FWgRiYb0H7QBxEkNOe87Tz+NYI
         nOLI3UTrmKxU2sYPnU4tYzoA32axjVZPsb5HsMUre5n3cYPA6JlzQlSGKMfNxkSaC+q/
         ZSt8uKUAFS8P/dWB+3NSCvz+HFIRD1eHAE7A1RQC3dddoYJwLmhQx/kiW0qiez7tCdLE
         Tx8SHF4t82W81E3Yppw0fdkHLggugAcILU8o8OhLJJvQQltjVe5TKPZjtSzxvWbkoK7u
         vADQg8opR2CwDHD+dhS02w8mv2L2uI1STlVfK1noTn8TY2f2AMS8YiPcUjBLEkHVclBp
         u8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138852; x=1714743652;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xyNmLTuWEvR72GEYCrL1zsIHBKSa0ehqFFEtMyryas=;
        b=dDIhLkl/Pb57y7822+PN1C5wFdeOB9gciJH+Z4/lFjPYs7tgSNdKr4kLIkLHwhZcS/
         Gp79L1UcHSMX5gXaknrrArvjArot0K3WNU4/0LS2oo6/eSi6+L17HrmCMAW/8tG3GyY7
         w7k1RlvUfo8cUaq4ZfDCwoTSl54bUKkmHmSIwjktzyZp1CDaa8qJwb/qLzhJoxNzEo3E
         p5bx+6Fd8Shwj+SpGK0LTloSErvQvR1BSTHRHKBKtM52voqCamFKjARgq9Ll0wwgsibz
         F5Xlqpt3qFC/ms0hm1f/rN6ft9Hfl0a8uRiAC9npS+DR8hgCzaLB4DyNsDA0TiiXXxv/
         O11g==
X-Forwarded-Encrypted: i=1; AJvYcCW6LSZOunOue8MSmus1Cg//L90zRsjynEMbjgWv6u5/NGpAWOSanq7XNE1eA873AQ0ZBTT4pk8sTMxPCrDlZWt9iGSiWviW5sTOr5Y=
X-Gm-Message-State: AOJu0YysYw9RdkVK+nOb0uDWt1MgACpQ5A/r6isWylPHbBLD8cn1kCeB
	7mDRQnyI+KlsUaGMkNNKqIMBFXAEH4o5l18OiGLeBrzTF1My3/tpsnsOxLT/7VLiLe4YI1F2tAk
	p
X-Google-Smtp-Source: AGHT+IF3mQB5HbulQg2CkJsEpbjz+y2/5fbhgBJ11VqFeOjJoS9ZZYtH/6hDcxbjMNxULlO5LHj3bw==
X-Received: by 2002:a5d:8ac8:0:b0:7da:8d35:8a5e with SMTP id e8-20020a5d8ac8000000b007da8d358a5emr3331600iot.2.1714138852673;
        Fri, 26 Apr 2024 06:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j13-20020a0566022ccd00b007dead4fd0efsm255275iow.18.2024.04.26.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:40:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Andrew Morton <akpm@linux-foundation.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_0B517C25E519D3D002194E8445E86C04AD0A@qq.com>
References: <tencent_0B517C25E519D3D002194E8445E86C04AD0A@qq.com>
Subject: Re: [PATCH] sbitmap: use READ_ONCE to access map->word
Message-Id: <171413885096.211722.564458609126458139.b4-ty@kernel.dk>
Date: Fri, 26 Apr 2024 07:40:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 26 Apr 2024 18:34:44 +0800, linke li wrote:
> In __sbitmap_queue_get_batch(), map->word is read several times, and
> update atomically using atomic_long_try_cmpxchg(). But the first two read
> of map->word is not protected.
> 
> This patch moves the statement val = READ_ONCE(map->word) forward,
> eliminating unprotected accesses to map->word within the function.
> It is aimed at reducing the number of benign races reported by KCSAN in
> order to focus future debugging effort on harmful races.
> 
> [...]

Applied, thanks!

[1/1] sbitmap: use READ_ONCE to access map->word
      commit: 6ad0d7e0f4b68f87a98ea2b239123b7d865df86b

Best regards,
-- 
Jens Axboe



