Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAEF43746C
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654325; cv=pass; b=K5sPP6q8CDtqo9+ynDjRBgIjBAf0UuhBgRFpKVrz+CS28AI1zfYzVs8OdzNtlnz/dUt86Rp+myHCX0zbvXpq+LLUX1v8w49+PxRr7QhS4guengj0yj2ckldC4a9V8EbPdS7n8Gl1hww9VsPNqE5ARg/36mzG/HX5JBGIZFAzMxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654325; c=relaxed/simple;
	bh=SKcIdUVsPmXBigWR3fDEoqD9v2hRGQ9Y+sqraJctfpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MljgbYz62z0MHgDu0dXzrttcvLyZz+OGry7gA0fopDHdS4qpBcZOy66fdvD9lhE+xn6jr493fi21ZdvrxElOGukvgvfi59w+8o5ZC05uscvd02XJPeJOlS1fu16Ah53eQq88MucnIT6/uV6p6heXJj9Z4lvKGIt3NYIdy+jDSQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvZOh2A5; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvZOh2A5"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so451568a12.1
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 13:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786654318; cv=none;
        d=google.com; s=arc-20260327;
        b=UDlzo2Li/PD47c3AUE2lLlZJJvgrQYqLu47uyUya5T2iuxzxKyKERI+h+ea67gaXu5
         TEOiVOhNhErJjq7BTtKDy601n/QWAHedjN1Jj2KGsaH37/VyGo1HGCWc4IGnRacKivI8
         tnHelQbfotchIQauMxVDWQb/ynZjk7xw7KNhvc7tw3nYlFE+6Yebo9pUSkovZspozE7K
         NWvGQkFjdX+E1y6Lm3R/Xkc2wvU+thrQZPJaEeZZFvw0K904X4s5tjeNwG3BbS9yAoL2
         hKLSMttmWl3VsxFQWp7C+R6oY2HNMcZAngX9vHngB6A1wCbe/tBGlss/OTC+R7H0fzqN
         K9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKcIdUVsPmXBigWR3fDEoqD9v2hRGQ9Y+sqraJctfpo=;
        fh=1Fkq15IaqQqQFKoERt7G4TErdxHICIGW5Y2eXKYfjQc=;
        b=mX9xLdz8tI3tyd9LzCur3fX/+/qjoX5GFM+OxSdKPFMvjZ3ss0OMyr6CLCpjX8YJf/
         yHf8m4uWfPfsdrnuzuq6uJdVU5X83kcGGH/Loamq4Jb3DIRMTeK9+DsZy7T9dybAWhiD
         QNZJ1o1J/XCETPkb0jJQ6YcnKUgvBGmo+Tz+gu0coT7Y++VnXDJPPV5diLPwJzkNMtKg
         AlII4lkXmdMvFSeS60Kazip+EsJvdWQk2XtJero6h6j9jiYLQQekBhMHYoYggIbHmW8F
         neZM5Bx4hJ243ZzgSTc2l0/fCux5juE1nW/7Pz9B8Oz9S+C4d05GcyNaXJkqXXlEo7Rv
         pNgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786654318; x=1787259118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SKcIdUVsPmXBigWR3fDEoqD9v2hRGQ9Y+sqraJctfpo=;
        b=ZvZOh2A5H3XvxwROFnL5deJVHEA1K3N6mcPaV8PRZfRteuBpBLgyFy5Iel5JvBUKIU
         ol/aOPu9+0lHgUtqkdG73velw4E+KeeTIMpydnsudOzpUmPDUI75k32HX+pf/+BE1SI8
         ExtDZei/k9EKk8BB0PFHV/yjtjNlNCsnQVMBuQpJ+BNI30+AJQtXPFevoTsN8R0gIFNF
         CqDCCBh4Ti68TXGo7O6e4ltWkzqqLPtHBmt1ObEK3acdERy98PAiP4jkX4y8dIgKQxz9
         bD92JizLSMFLw3W793vkTA9hTXoMLreweSSD2eZWI/yHt2yX/QeaEdWYNo7qsLEMjL3b
         Vz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654318; x=1787259118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKcIdUVsPmXBigWR3fDEoqD9v2hRGQ9Y+sqraJctfpo=;
        b=nhd2QsYyOlwYKjxeuOHhYfLlRDKk8v8dw9ead4jlxziiYG+ffKcD6fHXE8hsGfaovE
         qRDq4aHQJVVa0o7kqZfRFAbqNskCzRD3NGchQGOQdJra1IabR65PtrxixkISmKlh3//g
         tBGyjVCfbBg128pYBnw/jkC70nGBff1377GCyN4ihVzmxJFo/qedhOe5hTbbjm4Tatdk
         Q0uY2qbhj600bCw09wAIKBx+7q4ZTmOAHiYIe+4KT9WobcByYTG/qSHsiYXbjCBfB467
         2bM1G8uSgptHSiJkNSrkL9IZG+lTgvm1xYhN+XxXWQXl7wFcgIZGXRj0GZv3DhN3VPQb
         wENg==
X-Forwarded-Encrypted: i=1; AHgh+RqfhBv3qAWDQzZ3zSgKbYPnboiEPBwUOVMiTzKECE81jkcfWv4XHxy3B1sLEqZBN4yL+M88gSPHfjZOGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Z7ei7NTavtKzYzcbkOMl6CLnU7hPj5jFYxNxB3x/JdF8SKvl
	NGDHnRLU5gsgLj9IySoDsjgZ2OHdtWzjJHRJD0lxoT9WI4QSGJqsOCkFhDRAltVhZmM3CmzBCYA
	JTk0pPiBexZ+WJIxVyaO93Sn2QwPyWtE=
X-Gm-Gg: AR+sD10Ld/8hDSdQoB5HTtSNRukRjCzAKza1NlrO2WZJ4zsOvgc1GOh7bKjzWYBK2K/
	at9E0GyzdCdHrbQ1jMG5V2QNTNMeWV3emPyfumpqfe9qS9NpxnOcwgfI/p/PVQ52OUhDy/CUu9J
	1fAq+d02i6xO12ol9A3X+/r096/QkJovxIAOqH48VODMxuojtdV6HFY3pblVdPgGUhSdAmOoldv
	ecikng6Ihj2i4iCMviAGQRMvbJyEArzBYXLmlbWL1OGXdV0FMXFKvg6mfsrkJvBEvBRYYxBDxKF
	22qeQT9+pV5dY/blfhaSJGAO7OdFjOWFegOqlIw2GOfa
X-Received: by 2002:a05:6402:530c:b0:6a1:23f3:26b7 with SMTP id
 4fb4d7f45d1cf-6a38a97a9d6mr570500a12.14.1786654317500; Thu, 13 Aug 2026
 13:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811192111.2058140-1-coshi036@gmail.com> <ant4bioGLl4B35n_@kbusch-mbp>
 <CACd_6n1=oS_Jdq6s=u2jNmtP9n0Yc13BkKqJHSpsjbWHy=X5cA@mail.gmail.com> <anuJTi4sZiCBuMzb@kbusch-mbp>
In-Reply-To: <anuJTi4sZiCBuMzb@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Thu, 13 Aug 2026 16:51:46 -0400
X-Gm-Features: AUfX_mxij6zSANPAqoiBci6Iv7N_fj7yhY5bl1KY0y2Np-JLxzonVg5z2Jce10g
Message-ID: <CACd_6n0GsFdiz-jQfnRmJx0+2zUoEQQPwswkOQk4gkD5xVC7EQ@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: refuse an unsolicited format change on a
 namespace that is in use
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:42=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> You need a nvme spec level change for this to work. There's nothing we
> can do today to close every race where the driver attempts to use a
> stale LBA shift when the format was changed externally.

Got you. I understand now. Thanks for pointing that out.

>
> What I proposed in the past was that the device has to return a new
> error code for all new IO until the host queries the appropriate
> Namespace identification to acknowledge the new LBA format. Kind of like
> a SCSI "Check Condition Parameters Changed". An enlightend host could
> trigger a queue freeze and namespace rescan after seeing this status,
> clearing the device's latch and resume IO after setting up the new queue
> limits.

I think you are right for this. And I think this is a right solution.
Thanks for sharing your thoughts! Helped much.

Best,
Chao
