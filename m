Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24420F081
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839209; cv=none; b=HN4xQzW2e/T86EdhHL+9+NJOtiUk/lpAMxD2UoKF5oSyU1LZAgznpj4jEfV18WomjZyVjH+e0SPLR1DixD9Q6rXOMQ3tEwNgEXHp8COyUhvWu67MNjzcjby13JlGmSPE+msWW0aKlJ88DHVnvtL1oWDRVm9kTIBmh8FcErmBL8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839209; c=relaxed/simple;
	bh=7mP+gFQRMsj6qgVjfZaqJfNqJdAeHds+P/B5/2eN/dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGdyt5HFxykNRktiItOQJE1+yAAJxwGE8byAUPmnNlnidNi//CTkxwyhXsUHNhaaUgGmYFmxUniFy9UJp8MLc382s2rL6fxG3iLQWXyB1CB3F6J5E70pONe2vNkW6DNIhYV+Dyqp+v12iv7+liIeM5LdFvWqDGWTAj8UI/rsJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OOvTlXxx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OOvTlXxx"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26fabda6d9so727182a12.1
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747839207; x=1748444007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mP+gFQRMsj6qgVjfZaqJfNqJdAeHds+P/B5/2eN/dM=;
        b=OOvTlXxx6YnQ00EwY3dFw5UFniYiXxEJzlVwO8AnR+1SD08R5jSBXGoxEG2jy70GdB
         lT+Hxb7sBHCc8CXlKJ/c/O7YQsLpTIRmX5JNPNGBavIPMt5M/3kceHSNOKW91oCoEoF1
         4uJQzukw1h6TZ4oee3Zz8qEjhybBQVaLbyQsQnH7HHMe99bDM6jRclu73n4HCRtgQup8
         08ABtItH1CB1UhvC9EbsaPGC2ERyHnHWWY7qT1NPmLn1uba3QYzA0/7TvOU18IKx6lOO
         uGCEa9cp2OlB7MstFPGA/272nOi2tuacErcIP6+zHYCFVVnm577r4/WyoJRMPFdXvR45
         9ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839207; x=1748444007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mP+gFQRMsj6qgVjfZaqJfNqJdAeHds+P/B5/2eN/dM=;
        b=dwJRjtpA9jd6QeZefCz8JT3n3qNZWpRH8pfKl+HGL9cpjBjcunDjwAKVO0FLuStwTu
         VQl0KsZ1JzPkzm7fVwom3c3agRu+VXtD9lVJspfhFcb5KlxXL0OABCXhJRu2iWRXo6Lk
         uB93rPh4bTkv2sdXy+WxhycMz78vcjHpKtmZP6VLdO3xCk/l5cKWGxiwwQl86FIxsIZo
         eGAZQsQSSCItUjwhCZ6RzY/KmtCJalcEAP86B8ZgFiFGewMduQgx2ozhDE1wThTjJtUQ
         CYGGL2nT+QHbhFWFwIM6VExy4LPNEVT1lnb7SR3BSyR5e75i2KsJvm1ke+pIsNQp4wkN
         yDDw==
X-Forwarded-Encrypted: i=1; AJvYcCVdIjSBVwJjZln8Mx3gW2nlWSvlU/U67seTUYGqJg0w5IxlocqUebnjp9n1HTRoU8hPTrppc814PPkmCg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqlhi0DyMF1k41TQTlwGGx78A6g+j0TXJ9Uc/vsr5yARgcuCvE
	qn41gcp4w3zgejYJWEaaxeKDvLOfMeFIsTd3vUQ8UI8ZBxmHWVvZgXZ8EaegGhqHlypphiue6Zh
	vdUUCm0qYGP685mnM71zcGkp54A5bCRI5zK8mBZrUsQ==
X-Gm-Gg: ASbGncuNqTZKegk1a4HNIK8whdsYapn9dKPwWjyibdMJvZKdzTPWwG0FiB+w1oCL7cH
	XY4n9HK4u4oiIaDdHfNWKPw67wzlBAFco54m//KeqiWmrnA8gYAIyERV33Ya6BO4cA34by+HGOY
	cXSiZNVABjjU3dlLj/13UoRbdaaH5uV1c=
X-Google-Smtp-Source: AGHT+IE9Kh7474R7xasVle0Xyq5ZI52e4pZ3DRoWy3IeCXbqO/Ck85T7eNlwrRpK/IqejO0a4fBjY18kr3jIx2kp2ts=
X-Received: by 2002:a17:903:187:b0:223:5124:ee7f with SMTP id
 d9443c01a7336-231d45341e7mr124785975ad.12.1747839206789; Wed, 21 May 2025
 07:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521025502.71041-1-ming.lei@redhat.com> <20250521025502.71041-2-ming.lei@redhat.com>
In-Reply-To: <20250521025502.71041-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 07:53:14 -0700
X-Gm-Features: AX0GCFsEmpt5l2dgKCYn84MZzmE99ODsZf6zbFsaQOoJNXZ7AnZPmjQvr6sD8cw
Message-ID: <CADUfDZpefsRu1wbv2Hgi8D+ptScBz8=FQyu0YgR_MGtvcG_Wpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: handle ublk_set_auto_buf_reg() failure
 correctly in ublk_fetch()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> If ublk_set_auto_buf_reg() fails, we need to unlock and return,
> otherwise `ub->mutex` is leaked.
>
> Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provid=
ed buf index via UBLK_F_AUTO_BUF_REG")
> Reported-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
