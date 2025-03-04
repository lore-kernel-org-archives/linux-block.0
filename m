Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236092D1F44
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103513; cv=none; b=UTKaLCLwwkGDpUyFMQVyA8HlsgfgbPILXXC9N1na4pGJVoMjK6hFx9egFi+ufrRap2euFvNhHkjWTljm54PIdo+21yIeQ5JT7uLrCVvHZdq3Qfq5C/1wxUSnnej4k614bvElzz2AyQfj4TyUBFtdpGzkVkjSw4Y592+eq3ob4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103513; c=relaxed/simple;
	bh=X+XCBeSIDHPIeicCGaDtCadLLD6HqOF9CTWAmKROFnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CDQ4tQKhj4KJ2SHJLY0aqKWOz6WTORFco6yI8LR+t0BEVx3exGDGdu7zLoc55L7DMwIjDGwZMO9a/DuIgdaZg/56DcnqeOrQXKMwL0pZctd1oi8+XfG9thOgkeuS316XpZyMbrn0467DxN62NQ8OJCtoEO0OzWiBQdiGjIG6X+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=THG01Q3O; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="THG01Q3O"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-855183fdcafso191990539f.1
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741103510; x=1741708310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m539ACqsgOp6qLGqhafeXxINycqUDx01HHcbsWWCpN0=;
        b=THG01Q3O1MS3xmQRbZgGtkdRKbEQ7075B0MCG+FKT7J1kaszb0RpZa/QcU63oEDzs2
         VzOp/fDoXqcJzD9HFS7Yghe8ebyHrsvg4YL4SV3Rm0kbcjSjK5pDMGAq19W5Qf49/2Vo
         SjO+IGseiHHavuS58L56M1aIc5XMFMr6wYECWfd7KBQ87oOfRFwZz3TBbDhKrMQJ6wG3
         bs/wOENeTZoXCpasL3Vep50Cpk8UxBHdxVCFvNkCbQlIhB0W2c0s1MbihQjOvWd3R69L
         Gw436LKmZ94ywT18tHbCEA1VNOHL5anI9QENS67desOF9UI+1aOkCDIwNDoN8Kb3T4vX
         Tl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103510; x=1741708310;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m539ACqsgOp6qLGqhafeXxINycqUDx01HHcbsWWCpN0=;
        b=vBJnVjyCzhtpYFMWS2DeCw2OpAs+G9FCb3xUQbFX+rI1z17bq5YMaJABbyb2xNrZWu
         vizQZ0N2B8qJF7QPdMMXR3j41Ws6rb9/RbaLyGjvAENOM3VdgiTGNy3N/wxcurrkkVew
         mYaHSvxNM3iMLdgfnDCgsAjjJ9MzU8XgysTiHT9JSADqOn9e9LPH65wYm/vzQk+neQPz
         O7WiGUdR4mghI2vupnlTaFGYvOu5qL4RRomSXzrKnV49AusriC/HUgvQzClDzZmOWpUG
         B4z2il4wz5liw5Yq75jqDeDcYBi6on0Z0A5hCOmndJXgVnhOkNvS77sRWDH1s/FzKSXw
         OTZw==
X-Gm-Message-State: AOJu0YxEVs62NkI6bDZj0GIP/Ee9ZqJiokz7M6QlzrfZSysspjltIUqO
	VFl0pt2hHMrJt+6Yo7cg6F8r9jsikXzMp2Os0I4GxnQMAdneSU5LI4tPHZ9aXQ4=
X-Gm-Gg: ASbGncuZ2A6TsTzqKpqzvmhpLLnQSWVVwunrqz5mlCZ83U8TJ0jNi3S/O5Nyn6WmLxc
	T6xnPpsAVi16IHjARi07bcj4ow+HPuX1RA93HVjMob0Ya0gxVcpbLdr4o4ZZglMkGhyiA3sdE5l
	E+kb/BPGIz9WqcZs8nf8YObU7aQ7nlVj19lb9NEIDN2Tyafwsan14nUiU0qi6EI13YOfz+iL69D
	Gu4tbDEhdXeft2RXDZgrVZNLyERHzQbKShWr1I4DiCQaY59dYm/tPtV0NlRwof5t03YBX+dLgEB
	JW17mSWoEChenNuX08zXkce4aJP1jbWsEeQ=
X-Google-Smtp-Source: AGHT+IF0wWLBbAxhxKj5bLP1IjjSMX3uWB02Y7KWw6UiFsAcBjCRxSZLldeqUX5fjfa29Md2LX0dyg==
X-Received: by 2002:a92:ca85:0:b0:3d2:ed3c:67a8 with SMTP id e9e14a558f8ab-3d41dbcd8f7mr27282025ab.4.1741103510181;
        Tue, 04 Mar 2025 07:51:50 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f0828fd7e3sm2010684173.1.2025.03.04.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:51:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Mike Christie <michael.christie@oracle.com>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228-ublks_max-v1-1-04b7379190c0@purestorage.com>
References: <20250228-ublks_max-v1-1-04b7379190c0@purestorage.com>
Subject: Re: [PATCH] ublk: enforce ublks_max only for unprivileged devices
Message-Id: <174110350954.2748539.4977974596669256506.b4-ty@kernel.dk>
Date: Tue, 04 Mar 2025 08:51:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 21:31:48 -0700, Uday Shankar wrote:
> Commit 403ebc877832 ("ublk_drv: add module parameter of ublks_max for
> limiting max allowed ublk dev"), claimed ublks_max was added to prevent
> a DoS situation with an untrusted user creating too many ublk devices.
> If that's the case, ublks_max should only restrict the number of
> unprivileged ublk devices in the system. Enforce the limit only for
> unprivileged ublk devices, and rename variables accordingly. Leave the
> external-facing parameter name unchanged, since changing it may break
> systems which use it (but still update its documentation to reflect its
> new meaning).
> 
> [...]

Applied, thanks!

[1/1] ublk: enforce ublks_max only for unprivileged devices
      commit: 80bdfbb3545b6f16680a72c825063d08a6b44c7a

Best regards,
-- 
Jens Axboe



