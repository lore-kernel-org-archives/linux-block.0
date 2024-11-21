Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678871D2715
	for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185913; cv=none; b=PMynlUGp3jPh8AKQgJHfMTlZAJH+6GEdHb0mZrKtObuYY7QAG53vsqMhHcPq/OBUnDYHnKvWAskVx0nqZGnrV4JQIy22Bdes6mojDCUogo7mQxHLTcdxRq5lB+2RyMfMt3Mi31tMtZuW44YRJVSKCtJHHlNntrV/2YGw7jUgmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185913; c=relaxed/simple;
	bh=kD5zvuLefd3mbRLAvjOOucqZAP10SWFoaFRpV12DL2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oH0uSYab04d3sf2Evg4FP9WDoSbQf9DymOPFgiNPjiU11EhpccVyD8m8Rhy+rYbFrBAkP687Swm7HQ8K3gplE4yPgcJ51OdSh8qgypjMnQp0GEyHhcel5RugnK4h9gCyQ5IlzAblsy5oOUMBuVcht0pmqGsdCFglBqifkt797Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnsOuSQs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnsOuSQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732185910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kD5zvuLefd3mbRLAvjOOucqZAP10SWFoaFRpV12DL2U=;
	b=KnsOuSQs+fEB+3eGmGTrufH328Wv2HBfCLmHkSe0g8mLgqSJM0Cncgl/D29N10poUp4Y7x
	qhKGdtxRdEIZGEufJ+7VfMKGUARACRhwKbFx+ZUQUZvBHVvWpjLlGt4I+xXuALeldM8pls
	Zv9hOThoMjmteiqzojqhMw1DmuFQ0i0=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-kNeFlG2iPOO22LB4oTHKDg-1; Thu, 21 Nov 2024 05:45:06 -0500
X-MC-Unique: kNeFlG2iPOO22LB4oTHKDg-1
X-Mimecast-MFC-AGG-ID: kNeFlG2iPOO22LB4oTHKDg
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-50d45b97422so316491e0c.3
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 02:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732185906; x=1732790706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD5zvuLefd3mbRLAvjOOucqZAP10SWFoaFRpV12DL2U=;
        b=L/Xin5Vb0sEX9EjmxVnhSAtQ7Kngn6ucjAxRn91EgOg4qjWNAQbRoHzJXScL/fgfJT
         wmJTSLefmjyEY9jmVeByWvWDwRdu/RyoE6+NwqWKbEA632acIJyo3Jy21pgRc/9qy3HE
         DMr512uLX1d9nxF+cX0MBnp74A8ZDEAciRVrmnzdTyuuVlYPDK2GGjrNt3aqDoErxPoO
         MUfu9dqi5jtobi1CdAz5uHAxZDxYy/HdGyoGG1f9uP/BIp0tny/nHYojlKhGYWhe7cLz
         cLWrvzIlk66k1CPYtQmbKxNi5FZoK5vbM720w47hAOpu+WqcivTYDycLN28rBQ5pEEah
         4l5w==
X-Forwarded-Encrypted: i=1; AJvYcCVaUATFePGidB/p/28ZNUzVoqACUYlZL1sxwQKWcGVBxt7xVn3ON+mRVl86N/Yf2//b6UWLAucoEpiJSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+WuyjMToRLHqLTPltmc9fu8tZSbcrOUZwZDjITu5YEtO3Uwp
	EBhfALYt41sftYyIzFRpe0jGsJ258cUlFi7R/lvmBtcQrG9oJspkvPD+lV9f3BWuT3OKnrfbEE1
	jU/0XrFN1LUpHyBNWR+hhhzQ/fBmy9ArqIufVOG9+SO+M0Qfvy1jjSUYt+weXGhlKEXGsGzZKvM
	C5WQQehsT0OUmTn0a6+VIurSTblxbhQ3qzwaw=
X-Received: by 2002:a05:6122:2a47:b0:50d:b561:33bd with SMTP id 71dfb90a1353d-514cfbaa493mr5697529e0c.12.1732185906382;
        Thu, 21 Nov 2024 02:45:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn0BsreCrPn+9IUh35v76rFMQrjLPHM8n7vR0PiFx0ktfglmIu9KLQ/0cENaUSSwkiuOaizEit/XYibqMyIro=
X-Received: by 2002:a05:6122:2a47:b0:50d:b561:33bd with SMTP id
 71dfb90a1353d-514cfbaa493mr5697502e0c.12.1732185906135; Thu, 21 Nov 2024
 02:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com> <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
 <CAFL455=-5a34TYdwva912prQd93p84Lq1YSebTCUUsuLjZ5pag@mail.gmail.com>
In-Reply-To: <CAFL455=-5a34TYdwva912prQd93p84Lq1YSebTCUUsuLjZ5pag@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 21 Nov 2024 11:44:55 +0100
Message-ID: <CAFL455=V+YrmZZhWX=Quv_6BDH5SD17KuUKvMw1A9+VfNw2=Tw@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 11. 2024 v 10:02 odes=C3=ADlatel Maurizio Lombardi
<mlombard@redhat.com> napsal:
>
> > 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set
>
> I am not 100% sure this implementation follows the NVMe Base
> specification correctly.
>

Additionally, the nvmet target doesn't support the Namespace
Management capability (the OACS bit 3 is set to 0),
therefore if nsid has a value equal to NVME_NSID_ALL the command
should be aborted with an invalid namespace error.

Maurizio

