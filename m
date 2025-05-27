Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF627B519
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362215; cv=none; b=prpWLdO9eJIPAyFJu+dHw+O7Jdyxm1UYWFNPZ8uo5JY44HBxxOfCiRRt7jPeNj6hdeU5KRx1SFBfhMMaCIrIonLiNx46XwWY/hi48L3Ni68GPW19tcSdh/u5g7ssZACryq/EQLS3+km+MS6jPa4z5dqhH6Pjc0Pmi+89K5FNg2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362215; c=relaxed/simple;
	bh=1+NV2j0DnzkqfP8LkIHD28H2Lqz7sv+4lacmGZBmgkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lXMmxJcxLLoFqtGFj2RFd7vwQ3+X5bEwtreiPI3raQbLLKu5ZAqG4OXJLLtGmRcC+JN7luGs/qV8ZqNe7vjza7wLrezin+dVyAEqk2XQ2SIxHGbVeqrSplrkbqzX9aejmW+GnWLOOxnmjvPyDgG2SV1apDuhNGkFAYhElQacLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LiuMiBSc; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LiuMiBSc"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so9988005ab.0
        for <linux-block@vger.kernel.org>; Tue, 27 May 2025 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748362212; x=1748967012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfL4Xd/KXnPhvKftYAuT8JW1iriXDZQImpEWZ/Rbw60=;
        b=LiuMiBScQKcirLQqpeaPE4icXZ7mjw/d3OSHFyMmoDQ1R29Yk3KhaS9VjvcI3iOA3s
         u0g1DpqclVFFOM7IY8tNaOAUGGkBUk6ZjtUhfju3Dczl5tNI+ndghqCqaroUlWhxuwSy
         LFp0M713VBwd1Q4icXoxu2Z66kg4chsl/k4qfcdWyIg9hj91xHuN36alifestqSuQjKr
         TSbQHLez6bC216cFhop9fo5/JwJd8S2ZYvpX1zzR4IAxIBHj6TMKS/2kgeuVJ+K7b8ku
         d0vgtBKO0xnAmLVwScsU1xj+JEJDoGS/gnqOOT2FV8duZXCjdX8o5SWPyj3anhouVeFU
         USyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362212; x=1748967012;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfL4Xd/KXnPhvKftYAuT8JW1iriXDZQImpEWZ/Rbw60=;
        b=mB5Nyfnt+Ff01WyPxJTMuq910ot5jzqtNfqpqsnZg4tyF48JpM0KItDFe/tP4HIdfd
         GE09PJgLP2lkPSk6ivuXBWVkU4zcsINJWpaYx5YhIWXthzYqwfZvR/U1Qh9jdJfJqZOw
         WF5nT9914Pppy2AfCS6dBNSznsSoU6vYGeToGqaPmDs7uInZXYyGSPacr6e3o8juMOWI
         QOXRnoEAEqRfu1c8B108TgwaStfuW/P3AbFUwrOkuiQXjztr33cw/vkZm39DyYM/l5WB
         tKiPSxERF7LMOi7kTulKoD7hy1981pCLZvHg0eFXRL15W2eT2MHxlmdKvPOaboi7FACD
         YecA==
X-Gm-Message-State: AOJu0Yz+kFau+8EnAhgFys5Up1R5q/VaGs9w/Wl14QMRl/ONZ5ZtyV+a
	DBkgKlZQ8JA1mSAchGLy8to9tcOYuHoVg0NDgTeQm/0I1bLbQu+jEalHL76SaRS6rquWcxSYiou
	TzF+F
X-Gm-Gg: ASbGnctTbMEk821Zz+bj5hbTEljpinyabRHZufa8vngo3wOxIlCpZtVDgbQCIf6qOMI
	iqaUfPbXJ9XswTWeHKOyh5c0B0llFsajRPRmdmQ+xtt0VtOkkiOvOmfrzq4wWgw6b45b9kkV/xt
	h5GwSKz0fQpP66dhtc5sRk3QCDW4ntyvhDz4JTt2OMbylDVFG7CBpe9aEzIxVAOZNrb9UykOh0V
	6HVX0vgie7azrwsnfxmdkynBe0+L5AoLVShzi7Waal3mGixTqUttfnUVGqdMKfxVqLOgX9GS4Hr
	dR40JN5y4bdFzGDgy1o0vfTCA5IeTaIEeKoSPcqxpqdEwLWtTEWs
X-Google-Smtp-Source: AGHT+IF5EG1Bnm9pQ/vQLMxnMRAwcCuLl6mfxtE3yFyIOyMKjNqizAtxEMAVDBZFkPaJPHHDsTgBBA==
X-Received: by 2002:a05:6e02:1c25:b0:3dc:8b57:b76c with SMTP id e9e14a558f8ab-3dc9b68e0c3mr101681695ab.9.1748362211627;
        Tue, 27 May 2025 09:10:11 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc84ceeca7sm36337615ab.57.2025.05.27.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:10:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Jeff Moyer <jmoyer@redhat.com>
In-Reply-To: <20250527153405.837216-1-ming.lei@redhat.com>
References: <20250527153405.837216-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 1/1] loop: add file_start_write() and
 file_end_write()
Message-Id: <174836221080.514522.3194838323394477086.b4-ty@kernel.dk>
Date: Tue, 27 May 2025 10:10:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 27 May 2025 23:34:05 +0800, Ming Lei wrote:
> file_start_write() and file_end_write() should be added around ->write_iter().
> 
> Recently we switch to ->write_iter() from vfs_iter_write(), and the
> implied fs_start_write() and fs_end_write() are lost.
> 
> Also we never add them for dio code path, so add them back for covering
> both.
> 
> [...]

Applied, thanks!

[1/1] loop: add file_start_write() and file_end_write()
      (no commit info)

Best regards,
-- 
Jens Axboe



