Received: from mail-oo2-f18.google.com (mail-oo2-f18.google.com [74.125.231.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6995514777
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865805; cv=none; b=t9sWKXGNfIUp3L8JOXt2NSfAeCMSpgCDtK1pdF/vg4TmDprVw9cUeu2mzNVvVBh+YJQGgBdiJMtOZCyCzbgHXtK5kMLsY8JrzV5/oATPUVZQvOssPCopicCQD87kuPZRM6X9xheSdEXE5No7GV7IcBmPTqODBTJmmfgDv+oa6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865805; c=relaxed/simple;
	bh=imrVUawR1eKtd8GNE/AxSxjOpRarsJnPM0QXhNPZMvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eE3qDrq7/XVcdQWNIc30v6UhdCUOjOMpSNCWL+SOC9g0sYBa83HrWH3ScEyeOwQTqUwmUHCF+CG5pBDRDuXmjaSAUoxwmnKfCnwc3hfe66qs8JnjEg5LsCfqQcUUffYIiiGauUBDUIhk8b89zuvKePA8n8o0vS2pSiiRkHkV6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=pVhsNiZ6; arc=none smtp.client-ip=74.125.231.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="pVhsNiZ6"
Received: by mail-oo2-f18.google.com with SMTP id 006d021491bc7-6dd4ce68e4cso839057eaf.2
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790865800; x=1791470600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+sbPL55wTIqO8bNPiIrPwwY9E0RZDu93hDz3n1r/ZQE=;
        b=pVhsNiZ6lKbo/vOJF7rZKHqa5huYuprJ4SMya0U2WZbJkqFWmLCP5Z4PJ4zLP0nxlN
         m1Fq56HYHKTP75RewElbBQbd8Sl1kHfRDUzIxltcsoEyGFS4DZ4WIpzoY+wVWiVMn0qx
         Jg0vUQ4jvbUV6NQBW6Dq48haGGdrhhMrd0U3bwrkQuhY7Ap37gHkoR2Qs/JGxnosCUox
         OrJNwqMM8o7B/mHTBHQdi4D5Iwk4CQRvYYux7RKDrsUWu7LE4VMuabsdZXzVf3KcVPXf
         N3+LGulJSeE5pU5FsLHSMP3lC4PiwztO7ztkvwRs5Phhn8wHbGddIZ6nqqCydMZC469Y
         KybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865800; x=1791470600;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sbPL55wTIqO8bNPiIrPwwY9E0RZDu93hDz3n1r/ZQE=;
        b=V55Jz9z5diSwVZYCC+g7xHHA6UadgFqUKltdJ3dwPCR6WnH1nnnA83sHT77qVzPXWc
         M55CzmlXws7JbPU2jC/xC0r7tsv93UktrgZdG0/NI9XD7YqNBl8DFH5QdsQLnul5J4bq
         MU4AvHNVkhKNI/dqCks7CffIbomJTQuphHGl6jks9Dgww4tm4VzzkIs15007ST/Ccvy1
         U48KQvvAuNodmf3+YnMA3aTIGeUQreAzcvH3KupX+b0FjmkCpasAev7cZQU/U79YOP4T
         QTo6rLh5dmZzSZgGygqD0Dd0kcZvJFLXXsn6V1F6j5h8pDBOWQ/J73KXqkV/DyhfvYu3
         /GIQ==
X-Gm-Message-State: AFuF++nyt+wxD3NwkiFKNICRj/WMsX/JK/z/nUNTa1FwrwqH8i26+hrn
	9RkEmz1qY2tF4B4n2mReSqVG7yy/zooKEf5lHfOCdyXYxYKr4MVMaQvZKGdCTKwOjDPv55/LJug
	HFw2y2wU=
X-Gm-Gg: AYBFou2fysjWIQxRj3uIen2434Ncs55ryKXn4t7wwuhOQYkZd6AakNywjMv+xC7tzwJ
	CvoNYFuSSS7RXsB34f7b4WYObWtyElQ6UBp7YOhTAxFrgzoX5r1Zr1F9To7/jlMAw6NdQwP67+P
	0H/5H6qgoR2GJ9D3UQ332YnDHihf+CRSuYDofU9AcxObuSWqa3b0TNQ3Rzlw/6c56roaT1odC8U
	vVhIRkQ/3RG70vOZSqPTiO7UmZqPwOHXsvXqG+eIGRvjYvP0VY+tiDo3blwhEnsEj4RDzgVoOr7
	wAtxTtTsVkkgZ+CDNrQNvJq69FGHtMLD/mvSDPnGU9DIgSVWMnrdI5mTtDXmhSRxJ3Op0kxARnZ
	9CT/l8cpFPlgpW5+A9UfIpmN6x24ncY7+gVnF6v/ECuT4si1CPNy7mFbEpFQ5S1wnFDjU4ZN9dC
	tFfATPJmhlQQhVpQOBEB9Z2h2rysGKnxxSqxxlicEZZqUGMBdJt6fh8qIkJX+kguTPecb5J0uM7
	wBkrrKfIySHPq6xVZn9wzyVuWWOc1NCQHDSDit6bFEndjMKizRAR8Y/
X-Received: by 2002:a05:6820:160b:b0:6cd:3fbd:1d6f with SMTP id 006d021491bc7-6dcf6a1e65amr5051551eaf.89.1790865799651;
        Thu, 01 Oct 2026 07:43:19 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49ded14d8a0sm2638009fac.5.2026.10.01.07.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:43:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261001-bug-ublk-no-sched-by-default-v1-1-0bc91b6f075e@gmail.com>
References: <20261001-bug-ublk-no-sched-by-default-v1-1-0bc91b6f075e@gmail.com>
Subject: Re: [PATCH] ublk: don't use an I/O scheduler by default
Message-Id: <179086579879.1687323.14512869819818088081.b4-ty@b4>
Date: Thu, 01 Oct 2026 08:43:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 01 Oct 2026 11:10:40 +0800, Qiliang Yuan wrote:
> Requests of a ublk device are handed to the ublk server through
> io_uring, and the server does its own queueing and ordering, so an I/O
> scheduler in front of the device only adds overhead. A single-queue
> ublk device still gets mq-deadline by default, which costs throughput
> on every I/O and an elevator setup on every START_DEV.
> 
> Set BLK_MQ_F_NO_SCHED_BY_DEFAULT so that add_disk() selects "none", as
> loop does since commit 2112f5c1330a ("loop: Select I/O scheduler 'none'
> from inside add_disk()"). Doing it in the kernel also avoids switching
> the scheduler from user space after the device has been added, which
> waits for RCU grace periods. A scheduler can still be selected through
> sysfs. Zoned ublk devices don't need mq-deadline either, zone write
> plugging serializes writes per zone in the block layer since
> commit fde02699c242 ("block: mq-deadline: Remove support for zone write
> locking").
> 
> [...]

Applied, thanks!

[1/1] ublk: don't use an I/O scheduler by default
      commit: 2b8ee88f18d410cfcda0380ad45a0b67b11dec03

Best regards,
-- 
Jens Axboe



