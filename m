Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C06CA52
	for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728733; cv=pass; b=DxI4P7j9dkE0BatHmBsB71UbKYcTpJfni+gRHuJolzWVLUlseKOKNXwx5pnERNWWja1GmVULdxzcod08n1/bTWJqKK0dfQ1IqhW3n+Opg/twLyk8BP+kSfaTALjtk1dYW+vNBZlbiLzAxrLK7IXlY0y2p2/RKlzIp0urzdH4opU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728733; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQBWhJkdQs2MtoQLHoYADZ7TGufoF6VDysiM4rNiBKpXS2QB1cKWBB4++hEAOqA6TyOel4FBfY9hMIK0C4+BNyIejQOuPvRXIFvomVU2RCpzclbWX/0ys5cFY2NLDfLwtaF1vUAB6r50VKM86ACMqXoRvep7RnomgFRc3akDgpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4L4nbhK; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4L4nbhK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f360851aso1411893366b.2
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2026 06:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784728730; cv=none;
        d=google.com; s=arc-20260327;
        b=dge1uIUU7deYzBJbzNA0naem+vtVgnLmr81eBvQR8Wj/Xw0C0l+yCfCX7f0aRZ2VRk
         QrFPxJg1z6PVH1Fhm8IFMX/meP2Z5aihdasPjBrGzsWKBQjtGRN3Vn1IeR8rlCi78mc7
         hXjp3IafmrpXrdm3LOx/ka7evmhhD7zrf1vxAu4IPck4KeQqybZra+GRt2HK7aNKTzlo
         4UZlhmkRhw1G7EisuKPXrHoAvymUuyX6Ox6KXm0FCUkKFsHOrnNBzaAmukfc+VWUSd6k
         0BnBA4/r3gzx9JwqG4f6IKU15FWX1/I89u5PZGdX8v2FtAsDpN30n0b27Th/0nAf1Ei7
         XABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=mtXaK7GrisVkaK5b2yecADw31fnxyNizBlahX0ZyWvk=;
        b=k3MBNdAvGabNIxDz/nteYlBeaEy3czGBFLxorT7f17kyzzLRSqHHsh3Lm/Yd+TBFQw
         eINFaYWhfC68suzQ9zE6GDRKcR6jeeupTNJhXIndWkhZ3f6tgpCrfRvJVp+JlfFymFT2
         iMYpK795aT2h1ZdZu8biieFiotLWPi2ToEAri+tMjv22qx/0l9hcU7GRvg4vg9bkv5Kp
         6Gf++H1cKynQ2Hx+p1iEI0nVgzWlGtZ1uWs4VvVT3c60xBVPwgQAM2xvYj/JGcmOq5Yd
         /7R006RLTpmzAGCZ76Uyqtw+Z+3IlBoevsl8wUir5O4D1ayCJN9aSPEVfiCDZLEHbPzW
         Xnsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784728730; x=1785333530; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=q4L4nbhKN2f+6641dzvVGgX+bpzXasoKcwf36OdT6ebFXjghbxWrqFewnhFrhCmPfs
         C4dfPYFCu5FLIp05bnJcs2GIQPixc6FhjL7/hOKROTPN5QLDnjzs70yQxOdJxDH+xFjY
         nVdIypJzN+eOr5wRAbhVFYenHYXdnaYtIfjMDzV7XRe0zh/1x1BpoyJhXECGo4tuMqop
         Xb7ELdcVSfC8fC7tqPNtbthm0WXUjUnSyNAsAs1cCvXPCz9pzkXLBd83oD84AOyeJ0oj
         COOnTcHl+ChAolS/T/CapRtHCBvMcq9rOQ2p3diUosK3uJy0SkIJ7K61jNkiOhTxQLOQ
         ZWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728730; x=1785333530;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=dCEHaWri6IfA22dmgH2a1GxlA9VA3S5hondQR0RiGgFeiOhaaryWuO+SG9Bd5WKOsM
         yxFlOW9+HBoalwbngEqUpAAtBklMkggGODww2T9rMh8YSruRiwCQE1jXmXpukxGhpgpD
         Qx43nG0HOxcvw196M5ZspSPbVU04yNkG/wYyfyLSeKsWycvqtt8gLiif4MuPeJB/YQeG
         UAol9n4BSnJHoEtgsPtLJXc+8Q1AKdaJUCKc9QlQL9msFBtImBDWgshrtpySzMGtb8UG
         J2mhUwyUweXMEse9fNe+JHsc7nHvELy3JyN6MmFRcISAYOE/wu24DJPRqLx7WUGuNQL4
         PjaA==
X-Forwarded-Encrypted: i=1; AHgh+RoTQDYe4RlVocG/SSy7IeVCTIR0IU1GS+6HAyqdxnDS/YKkRVzBGjNj720K0eaFvyqjIXD+IdKtmArBAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbgk0BQUfTioL8t9ZgJ37S5/3qNUGdxMk7607Xq69rqU+Y19s
	rra7FP9WaojysYeGzeNkMsq9WMrJWjEP6zascRgnmam00llucLH4L5xYe7MR879eqW9gse2/uwB
	K+f1rCEg/HQbLzxbnzEmpy6xhlP+nuosUCqc=
X-Gm-Gg: AR+sD11q/jgMskXu0vFhHILGpAmKfeoMRKwpH8vF235hAflm9MdKGZCrvbTpkrqaabc
	HIT7wjNsF9nVaz9GSOwkhLEW9J2QGUUVPhq8sgGUJkjbHUlVdG4SJVQ8wtOMMdkibT3yaEtZB2V
	NMWRXSE82drIMwf4TulUXVZVsS02RsFujSuWxxqY4c/0SZM5djb9JwZ8eh4USO2imRn7d9zX7SC
	uYAzZ5NnzwFD3oCW4Iq9HJ82uFew808lEZyBRsELAj422g+2putMiHBwa2jJoMysDO6+ZmjbzWw
	d0ltmoPAJX2qYpUBeZVvw7Y74R6ntAW1UnIB1A0CVtU=
X-Received: by 2002:a17:907:707:b0:c16:5dbd:820c with SMTP id
 a640c23a62f3a-c16b47807e7mr1050374666b.33.1784728730138; Wed, 22 Jul 2026
 06:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721071739.2514228-1-hch@lst.de> <20260721071739.2514228-3-hch@lst.de>
In-Reply-To: <20260721071739.2514228-3-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 22 Jul 2026 19:28:12 +0530
X-Gm-Features: AUfX_mxu-R6BpFqqVbuG4e70DCX8NkkJcoSwCDuCuqMX4bN0cFv9Fn1mA4030ww
Message-ID: <CACzX3AthE7vXoj4jb0-=3tURx+yG3Ans7Q=vYGOK6KUX7dixqw@mail.gmail.com>
Subject: Re: [PATCH 2/4] block: lift BIP_CHECK_FLAGS to include/linux/bio-integrity.h
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
