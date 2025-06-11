Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078611C84D5
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657445; cv=none; b=NoICsImK7WS01JfRaFlpO72Af6bkWwPB3cgW9aDWgAloQVIzfxG0apkNAYPyaO4xu1C8aQMJL0HUEBOPDJ3S/3cWL5fRi2E0HeI0vuD0H28WS44xs5KrwK2LPGnEgOzEgqCqx9Se6PLyG7sldUpdRlIvb3mJV0FA0i0x0iszM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657445; c=relaxed/simple;
	bh=RJWJyu+0qj/yXkybl49ji3SKEFZSYL4lvsFBjSPUC+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Edc38alwlNYqbiOJuoHWJN4EJLRiEM4W6f/ecXyEvHXEeQ2ju9wbzlih1gfvtRh/67/w1Az1YhhlC+uBXGwPepwrnDoVHCumMSLc2qkLEIKLjRcU2dut+S5WU5FXGIGFS4d5nqU0H867JeJez0Qslh3Adb8PaIik7ClzXdHgFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K/ushnW6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K/ushnW6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234d3103237so1098215ad.0
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749657443; x=1750262243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJWJyu+0qj/yXkybl49ji3SKEFZSYL4lvsFBjSPUC+8=;
        b=K/ushnW6QaTGYrA7tuvomFwQO3Cp063ezy2c6gIV7o2OGGWWEKtJGdXy3Kp25eMB4j
         LMBNpF9mYkd4zbChGsCSgL8ixsVKmQqiPxSETBr6I6DHfYAqCOBAfAgCMPBCzwBdKyn6
         7ofuWOOE/XY4hE35TPASUUineD7ueb2ze2RNzU79wQ6pKprCKqwhoxAsh08aKu3Uve+k
         7doVzzOuuh0Gx2ynF9Xr+LyF6FErxmjc8HpHGRwqnnlBNvzkwSG1B129hympeJ8q/TKZ
         yp17tdWWPU1+adS7rJh0fR+ACeePzAtyWNgf0+mVXwnkkjLyTPajNZNNkFwLXTJp4Krs
         QMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657443; x=1750262243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJWJyu+0qj/yXkybl49ji3SKEFZSYL4lvsFBjSPUC+8=;
        b=XS52B/mTqT2yXOmv7fzOKbxH6PL+aKTz39pUNUOCKKveIkUyPIMU8DX/z3cEg8RZxo
         4DhjOsLhxEvFPXCVfMVY2exEenflzG+d7eZuvdw8q4wZVV9CzoZ4KNC6jcABbpA+WxEp
         tG6p709e+2NGepXHDH2ZRjHRqUXyLkfKSInX/wJ4RP6qnaNR1ZtWVyQn21AfbE2jDDkG
         NY4ngxlEndSyoT4mXbfFWNTpbxg55z/W4f6HrlrRLfiatmBy2O3vNfOC4V6W9h7x9ATb
         MedSuGdhbGm8xu4rjIybhYzpBtw5qjKHYfV8j9nObblmAm4LsyZ8f+ZCayBcY1Oukree
         Cgpw==
X-Forwarded-Encrypted: i=1; AJvYcCXPA4dSJIcwoXrq8ByiJOPF5CTvaCTkrurAXiaMCZmV3t4+Xz7NjKebVtrYB1rV54lreV5SjNUDS6odng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxggAo2dsWXWlXeEkEKnKfbfAyjl3bAoderL6t1D2vE94bdZc1Q
	jVRYrCzlf70psdSFq4eBAXpK/sD2oZ21bN26guHsp+WnjtsnnM3C9UzX4A0l67hzbT+rRctVXeQ
	Zh7yNWdJJ6cDoDsLWDObN7zinr4c9Br+oe6Xm71ljeQ==
X-Gm-Gg: ASbGnctalgeJvnqtqRIH/2LacxKwL2JdYQO1JLxaRCsUX25Ed/ZSzTLx78CCW11lemg
	OFCPveDXn/+r1GoIDT+FUGv4JFztBgvS46O8W8Y8blYbJutzIBtOII3YVxRWDARTOFMGBo5SJtw
	QzLpTxsAgBjFFj0i457dXs7n8Ax9hEXc3mIpSOZ4ua4u4=
X-Google-Smtp-Source: AGHT+IGX6Gpn74Oumq7JovSVFrWMrcrIVOQJDvoht7U/Y07fmTs5kHS470mfMOcoM1IdykqyPFou7tgvh83g9p9hgF0=
X-Received: by 2002:a17:902:ea0d:b0:235:f18b:a07c with SMTP id
 d9443c01a7336-23641ab7145mr21480945ad.5.1749657443192; Wed, 11 Jun 2025
 08:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611085632.109719-1-ming.lei@redhat.com>
In-Reply-To: <20250611085632.109719-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 11 Jun 2025 08:57:11 -0700
X-Gm-Features: AX0GCFsm6xVotLxAcHSPY4YSdIjCjXfIqz01LrPT7wG6NPajcG4a4PafdQvyjkA
Message-ID: <CADUfDZpmCNgMP_AtrhyX5mPOh6V67oRBuUP9HpzfUEAk-iO7Tw@mail.gmail.com>
Subject: Re: [PATCH V2] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 1:56=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Document recently merged feature auto buffer registration(UBLK_F_AUTO_BUF=
_REG).
>
> Cc: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Sorry I'm a little late, but

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
