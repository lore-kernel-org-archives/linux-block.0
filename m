Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F753365;
	Thu, 15 Aug 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735900; cv=none; b=SWE6X6VjrHZXpSrrGXAcdDaQuMXa9SxbDcUqiX5ni413FVZmXZ0emChXm6KX8kIrU1OTXfV/WpcS3QgLirMTP59tqlAr67zxKsYbwh3C1zjPW+qucBIXI26l3mvvlHO7VRYrxMfzjYZAHpa7mzliiCfs0hkH8RH745/27c7uQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735900; c=relaxed/simple;
	bh=zO8i28esgOwM2IKZTj6QVpLHk2hrVfYuXE8+Db5XxMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zr5VibnqVFTkEAwm1y5BvtwwWO0Z4DkcxhfEPmepoqbHaosHYPP7W5igKWqbeXWEgPWR+TzLM48ZO5OtWHDUd57iKyhJq0SDYId7lE39RWkGEqailRG+vMbF7hLZIV0+xXw2ajmSwddDof5rOnqXp4L6S+ZG6Qt1gbRvY5NtXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+A6v2+y; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+A6v2+y"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so752546a91.2;
        Thu, 15 Aug 2024 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723735898; x=1724340698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+LqYglqDDwweyHeY9WF0lHIc3M24FlH5C4AoMCNycQ=;
        b=W+A6v2+yq5xuQmVedigaKEVz1rdhyJlY9PX7OTBxlxals+vTLUJqdZ6AlpDKV+ypY0
         lERmMmY1y08waEvHzjpGcAGrt24RT/rzaS2+UvZ2Edtze7oePQyLwY8rsCIWgrMChstH
         Q3oy/D85P8k9Fwp2KtdHuIz6GMyqcwBqo1oy8iyriOVqNhu+AaYX4qVa8wtFHgXM3A0f
         jAe3Eafb+6FmP0MLrpV/OPeSHXO+sZZRfbmU5G39mRUYrWPPRzw4o8HHmwrXoQ6Zso+3
         zr3CA2BXW2WfBBi4kqLKPvNw9/qDzPIyiVqEuqdjVapVusCvQNaE+47m60RQ3rm7mQC+
         rILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735898; x=1724340698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+LqYglqDDwweyHeY9WF0lHIc3M24FlH5C4AoMCNycQ=;
        b=w2ENHZg/JpzMXrMtIASEmprvIYU9xCkh5wmi1UkzKKwBoPMYL+sCOBEvdQlC6K/QMv
         o0aAq3r3Y3EHL+FdTPTsuIAp7DfBg1TFDGW65FcdyNYyn242RrAplrIYydAv/KJ1BT9A
         9nU5moUrvyW0/dy+zzx1j5FHfVQfSuZOpybguBYkj6G9/5H+ML2Ybva34ZSs/nFgXUTT
         /AzOtg3jI8O9YR2ziF+nOd+qWrXbaeX9jtzd4+4ItBl0f0ZZNRPWJA8o2NSkk30QdTmj
         bArVW/u5rks05nVExqDvaQX/SrJQGPmCbZjD9gThXgDHHU2AryjEY9fRHJtgHJqdW2F9
         A9iw==
X-Forwarded-Encrypted: i=1; AJvYcCVyCLJ+LRcPhAe71ik+r/vUuex2Uo58l6EIXZAOdvh9YivAwnqR5XCgeIAhTkuYR5VaYtJ5Qpqr/Xzi1fDxc2qeX2u7Ymi50JmmQSi2icVbq8EP2G5T3SjQ7cYFC6qDP/eAomPFE4rLFOJ9rNX8VlKfB7o75JrwKyC+YMek9jDbwOOnKLQ7n40lLA==
X-Gm-Message-State: AOJu0YzjNwch3Ci12dnfrKXrIzidcoWjIIRzPfUI6QPRODaEYr0lm1AR
	pV6vCNht0zFyIBAJhIgDoF+66O/45y3ybsQ767vt7h+XnQKg0aTcpPGiWuawIGG9S2H+M7xRCcZ
	zlHjPqD+9QaaXmMnPllKOGEVmt/0=
X-Google-Smtp-Source: AGHT+IFZKfJDyUVUlLPZnL5SSp2gdP0C0YyAdgL1sqDAM9BZcm3HcihDUZEP+nsUhxy6U1bt7PVprEEKbniigIEBU5s=
X-Received: by 2002:a17:90a:ca89:b0:2c9:754d:2cba with SMTP id
 98e67ed59e1d1-2d3dfc2aa3amr18264a91.3.1723735898110; Thu, 15 Aug 2024
 08:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815074519.2684107-1-nmi@metaspace.dk> <172373175849.6989.2668092199011403509.b4-ty@kernel.dk>
In-Reply-To: <172373175849.6989.2668092199011403509.b4-ty@kernel.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Aug 2024 17:31:25 +0200
Message-ID: <CANiq72kFXihVGDGmRyuc0LkODYOv2jX3shP-dEHjV3k1sqFEKg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: fix erranous use of lock class key in rust
 block device bindings
To: Jens Axboe <axboe@kernel.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <nmi@metaspace.dk>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	"Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Thu, Aug 15, 2024 at 4:22=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Applied, thanks!
>
> [2/2] rust: block: fix wrong usage of lockdep API
>       commit: d28b514ea3ae15274a4d70422ecc873bf6258e77

If you picked 2/2 only, it requires the former as far as I understand.

If you want to pick both:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I am happy to take them too.

Thanks!

Cheers,
Miguel
