Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175100;
	b=aTxFivYIPrzz3HpUG3I+YIL0HwG9YjFG3Ej82gCQTru/nXdQOXoQ5bj6pJeTe0g5afSj
	 yX0OhO/59iSGFRjkOEWOZLVdrh51oZiU2jjev56ZeKijlgfO31DvP/bD772n2+AKw+OWh
	 q6xGfW9TrxNtx4dE16RCjmIOEUdHgBSKVmr8J6qPpJmVFhuquDKQZBd9nFw/MQGtfYDag
	 IhveCmtLxHon4AkQUAIb0DqinTaYN2aAg4OHW5BXZEk36Ieh0U+9DHk3XUPNeVxnzEKZk
	 EKcPHMZ4oDKzgorFDjr9hKYP3GGWnbxs0By7dZYxhyn/X32hYK4v5y3X5PGqsH/hI3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sdsG+eThRvcI9HCYyGBK10hDw1tWFZFbpCUEL03/hJY=;
	b=5thfLw9OL/28Jqjvi6sOSCUuS+CIGEljFENk0UC/M9r/325tFLcyMvypAQmDVM6SvgkV
	 50hRik5XZUxm9u8U5gaJCSwH2YUvd91oqw/aTMqt2d1TnSvGmqJyJATMPMPpAaBgGKqSK
	 BDsdbeRyeDHm2eNsd6MtVldY33zEkdPptbrYSchTRDhuVSylbPKniBoDBVFij4v8jC2w+
	 ldYIkNq1sUusi5dCfLjHsl9uuh8Ctr+o1uLmrd3j37xXgOzK3AEbOGfkE1szBJUGuazEm
	 Iuljdvng7mKiVWCz8ytXefUetqEchfANp65WGI16ResNoDFOT/ZAmCXVBb9y4nk4SrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=im1KH4Kq;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125A606A331
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 11:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F125A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=im1KH4Kq
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f00fc215f9so5220445ad.0
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 03:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795175099; x=1795779899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sdsG+eThRvcI9HCYyGBK10hDw1tWFZFbpCUEL03/hJY=;
        b=im1KH4KqZiJaysW3dWK10GcRAinqUSQWHxbR85k6cC0mj3lcv2mtEiC3gdJ8jaaG8Z
         eh+O+AvHyg5IR8WYSZTTs1HTYQ2q8jEeFrN5fPdI6bh5W9vWiWhjdyUBdFm1chdkqfru
         SUY2icAe1+EC1gwEj+xDzx5+Q9uz0PN+d6yLNvA7uC+6igBdUqJSsOtaueXax3ELXlw4
         iZEblI0dv2FaMA9f6xqfeplsmQfLQfPuBvUYzefFOEitm7bqhJ/BhPmFOi+qa0+TleFX
         soxdYGWwnyCS27S0/0H90XJvD2i+JXPmLIe7/ArA84YAQSfEEz++tcI1q+hRnegXV7RK
         9E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795175099; x=1795779899;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdsG+eThRvcI9HCYyGBK10hDw1tWFZFbpCUEL03/hJY=;
        b=BKWTPcB4etwbSu70VpdLKlhgVXE0wgISVF8zedCzQyun6Ef6MuFzlp9A89VKNJIms1
         0IiDmkrrgqQmZZ1kKsBfVRJvJp0omvsjqiFlLowTEMUr/kh7MFpwMlBID26I+kb9pwn1
         Nov7PIBn/vzneajasqa9jYDv26BdUbF29Pxkg9AUtQpbDmvtOph19fQcYmQcFXAkYsZt
         O/b9jJAsBT4ckJSJiK7WgMYdzAorYEX67pTMwbG/dx974Uz0xs5aLxdvd/YWgDnFgFjr
         Br/LgRLDZvABDkVavM1GVs2oevNtDh5ZlQVV8hrBWaDHopfdFY7utS3F2ko6HhvOCoXi
         y+Sg==
X-Forwarded-Encrypted: i=1; AL+hErFMaCNp/yncZJZhTuPuOPSW+FVJmqSPvnXMyK82Waz8dnOJ7jXNdN/j3Vl6KV9GWw9gwp82fED5hLKf9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z++F1L5UbT+tzi4u/CNBaM0alXhUygUzzmh2JEv/H3++w3vZQ9s
	GNtOWSv/84qLaXf4bbSSadQ/Sx0f47QBaTr90AvfavTsdl1y5diatqCC/25FIOHn282SnvsY+3l
	EDqnc8F8=
X-Gm-Gg: AZFdTZeA2PaotFP3znyUyueBTd9JBz8Z2tEDR6V8QpQEZHzED/zkHhMMQahzpNvUmYY
	wBDI4krqLa/gYX3BpDR/hwKGJemPM/hZlmE2rPaM6/PTlmcXYuxIDkVznps78MFPGgobhprLv2u
	aIanV6ZSKBELi2OUZI4v0ImsKcxuxYRPO/H/YONy07VzqcaJCk2WxWcyOZuHjq7/SukH5GDy8pM
	+9WTcZrh8s/3Ldx+/x82tK7C80TrMxTOuyPovLy7FGHfIO8HqU3pVdPIowDUh+k05HGX5cTml2f
	Mj9i8vI1NCIBRaGbSCwLxf8CAaqa9Cs1jBLQWGhRNEVUG1S6sKxg1Ou2QDsKwRI/lFk5xjaCp/1
	B46cHxkgHFYipL1B5AZ626GZOHAguJD1ljkD6kkuSYv+kAz+YXS8M73gH3H8U9bIZk6fuBn7vpM
	d0ER2AYidB94/d4em22DhGZTth9JWJU70RDzq6ojh8xm4uIC7hKvc082mg20fAsMNiiRgKtd9fc
	GM12fdmHajnIyJ35KJsE1G8ctETIqHFa8Hm1sRRSm1nkoazzbUtQyPdnW6HfW1vw1f733O4lFX1
	IAEHh8d1ElGo12QcA1oKspKh6hWie4dtgI5VqsNl+0phLZzn1OntdoRIktbXLi88WpceflWsH9p
	oBNFMcFVgo3/BLl/AtMVuvkQr/s14Rkrg3zkW
X-Received: by 2002:a17:903:2c50:b0:2e9:64b9:a330 with SMTP id d9443c01a7336-2f03f17d2ccmr29212195ad.11.1795175099419;
        Fri, 20 Nov 2026 03:44:59 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:8b25:951:ad8d:5cc1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1215e2sm13289485ad.63.2026.11.20.03.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 03:44:58 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: philipp.reisner@linbit.com
Cc: lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: reject an out-of-range offset when decoding a compressed bitmap
Date: Fri, 20 Nov 2026 20:44:54 +0900
Message-ID: <20261120114454.3072690-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
References: <20261006035715.354417-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is superseded by v2:
  https://lore.kernel.org/all/20261006141509.521128-1-yhlee@isslab.korea.ac.kr/

Best regards,
Yehyeong Lee
