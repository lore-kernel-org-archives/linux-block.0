Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99794403E9B
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005968; cv=pass; b=h8MrPephcjpD/ac5QFGx7J8hsDOYdWETlRmjtvImBn9a48gCXQ3g1CR3+bCPrm4J+Zhz9r2JCc5WNj1Ua1DNts4MadsAPlwF3IW5+/rbyyD1pzjTLBWoBgafLZCB+C2Pm7K81+E3Jqjnx6BFRrrwRXsc4YSnWKJblx8OGtgcEM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005968; c=relaxed/simple;
	bh=szXxqX3RAAZ9twzChIwrUOCmf/KTUJ5WUMl++gjgLA8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YN38xAs+6uCxkyVDao/m6jmb2FFzdbyf65Rauw75ArnW1Z4NyXFSGXPJsdBGE7ObbjjCUdFI4R4N+c7a5CCYpbsblUIvhLHcp3YQGlEVg4KS2Q7S7SLbFSW45BgpaCBVwf0sFYUqFKOsRV/b09zVGJNwNv+uwHLBOX/T+VWcXkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGF6tH+A; arc=pass smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGF6tH+A"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-517a5cafc3dso33987651cf.3
        for <linux-block@vger.kernel.org>; Tue, 09 Jun 2026 04:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781005966; cv=none;
        d=google.com; s=arc-20240605;
        b=DdlqEDiC4i065x9Er+9OLbM1tB+OZQD+ukCCC4/D274nkLXDZxQMPXAKB6xprCmKN8
         Wve9iuuzZNm+uQmqQkchS+8roHDEawt+eZGmcYMikJsRaONswYDtOLsdJXCWGKwL9OV1
         UzMmAQGVEzYoKvrrnsCFIMk3yPPdy2oTDHZezl5jsMpl/HKr3sEgKbLP99tYzrjtL9bt
         JXMh/hlDPYVwZx346DT2nG4xD6BS4PmCuEiRTIMeNXeOd+bADervo09N/ye+CYRiJ7uO
         VgXZN8Q6v2poecOS/ExVQbdwCkWf7qeCFwKu9Pjc+qOVvrCqt+DhEMP24DphMHDrwUOK
         e5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Ep0QPgbSVmGsKPweMHtjyUcQxI3xv6n949KrMtksT6k=;
        fh=xKzLbEdlFfYJKlT0+xFEQaEOOS/ht1eUwSSFw/f3x/A=;
        b=cGNhDYwwI2l+g025jNZDZDZgbjX2GTvQe/Oe/yC2y80tRvD/RbbgpmpjL+DBsk51k8
         eIz5yptfYO8grsmm2yu1F/k1zsCIp/aHq7gerr0G562dtUt0kzW9v9ZfmjnFqzLbOCza
         Nbmtckwt60JPe/vWPd5YbwYIpCA45ZO/xuhx6F9zu5qLPAkQS3tRmRkpEIHLaRO0y9dJ
         rJ0k9zBT7mYkNDBWX+GuA1ObGd+Zr35eqay4Lfiui+nCvtADXUwnkkMPEmMf06SsbFLR
         vHkPR2AjbEHQlqa2V68DK68quwnsbD20bXgS3LWDpBLh3NpuCx/krYJJBSSC3DC1BsQ2
         TJnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781005966; x=1781610766; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ep0QPgbSVmGsKPweMHtjyUcQxI3xv6n949KrMtksT6k=;
        b=hGF6tH+A0I7CY67EO6VrA+eny3jRKKUT0GiMg7UxMJxYod80cFoJXp4laQqYLvz9o0
         9KLFx5fCNbUTazTcUgJk7Fa2ahtf7bLbDVUvFCc5MHSCbNngbgLrOndLJu/d2OtOcDIk
         YlMtsq6lLZT70t8Ucl1nPh+nyIjKwq/8y1CaxYvUK/unYWqqJY1UgTUZFhAp0ge/44b4
         IHBhUCB3odlisyLouUcEJAK/DxZP0bUpeGVuLKywsBTUPqkxA0matTXHIAVe48ajfold
         fLsg6EYMme+eNtQcEc9ihhHgYTMRs9h7om0GqquU2wiD9iSG8LMYH4jP69A4LMHsRWbK
         he5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781005966; x=1781610766;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep0QPgbSVmGsKPweMHtjyUcQxI3xv6n949KrMtksT6k=;
        b=T6pW4sjS94B4b0aZvADO45r6C362CYxciegZ8cLgY0DnenlVPXa+qRjUIhpgEAEdPB
         xYLLkrXItmE0CnNsjRS5CUIDKqksBTJM9vLMezE7dz/7yezXGYwoHeBjhGkL2S/QlAnx
         rQF1zwz5iZPc47Ea7sW78r0EAT70E1ABJEewDtIbahxFObC7kYrXupZlME8DFVHvhQeB
         lAHeuuDnEZR7Cyx35ZxOZnUGQdeBIh0s+AL7byyiI1rJcUgRGqE5Wi/6JKzlHm/i01Kf
         qMd8c/iRRnPG6DrEglycKoKuf08g7U2ge5TdMr1V0TCHp7qi1lZG1z+JYsVKEDDb4SzB
         DdCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Sji5VaKcfQdhtTXOvyBtj3zUQJJnT9xpMys0RZ1ivUSg4zaTidRJvDSaISZKSvl8aY5KfpeGNH6ndWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXAxpX0KzGPNdd8r8ywdvEBbBQDE0dIYUMWONSBWXPb9snzHeb
	lnCDgjJcKSCggMjJoQTB89F5INsQITeyBiHUb0nq+r/q4I8xQu5a4W0uqItrAJohV8LBItnPTv7
	v6PnQWFqvgoUf6mrov7MQpRdW5scKIhuiHSEJo4ZYjg==
X-Gm-Gg: Acq92OHDi9lDmNQyjU+0B8B8zVjrrDsz0fSrWpAy+d96AIv5qk95h5uA/h3Aq2Y2Pbm
	0Ju0o1SbAooY6gWVcMK3rbaQUyWzppKHCVy1fFwWisz5vhdDlxGXTMXBI5li1UI74pbc+NPp/wo
	kpU69Mh8vH3muEJ+1TJ4+/t1aHW3CG5l4ByLCLJdjJ0IaS9wTNBBtj4rqPemFVdLbRbGAgqy68r
	RqbG9Dwje+CFCInB8MU+ZOkemlN1l4EqjxvOY5E7Zv+AhMPEcMgXHxc8clrWTWASsGAP8l8nuqh
	gZGAj0B86tqyem1Py62ESClqrYvP
X-Received: by 2002:ac8:4289:0:b0:517:8242:489d with SMTP id
 d75a77b69052e-51795bbf6d1mr193804401cf.28.1781005966411; Tue, 09 Jun 2026
 04:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Longxing Li <coregee2000@gmail.com>
Date: Tue, 9 Jun 2026 19:52:35 +0800
X-Gm-Features: AVVi8CdiFkCvVDI8UquK6hvOuAW820YswX37IZnUQCdN_QiLp2DdYDVKLmMhGd0
Message-ID: <CAHPqNmzE6bcNb3T+nJavn-mg=w2B0F1YCv47qv-Tsbn4xOrGmw@mail.gmail.com>
Subject: [Kernel Bug] INFO: rcu detected stall in disk_check_events
To: syzkaller@googlegroups.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. INFO: rcu
detected stall in disk_check_events. Details are as follows.

Kernel commit: v7.0.6
Kernel config: see attachment
report: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

==================================================================
https://drive.google.com/file/d/1Bx2unEf-QntjVi8g6Zw7QNO6OP4cjGO_/view?usp=drive_link

https://drive.google.com/file/d/1t8TOOI_sDqLxje1iolIJqeIxa-N6GUeI/view?usp=drive_link
