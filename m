Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62532938D
	for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019130; cv=pass; b=DnfZ3rHPoswji8/denDQnW6Y9e81tjd+WUF/kEL5zAzLCUkB4+AbzKDsRW5QADqCokOECG/BIZE6O87IkmjlJpgK2mpcp7FUOJ1cUwrmiwRaAz+bBBlYEU35H5FZM3oWJ7pspCqOJG0hSbo9z6/hxRkSmuzWNK7cGaVOQm6XCow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019130; c=relaxed/simple;
	bh=GzoRo/+d4BRIcGg24566JkSkG3yHlU8Q/eJTPAd51Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KH69pJK4TtnXrxxX3JrtPEK2eQnkKpIavCDeU3r4uF65F9xgRKDkjK/NX91J6P+GVXe1DFbzGi0lon5STCDnyZns4jVor0H60yRwWibBDuGIOw0VOoh9eDMhpXTBsrUw/RJPazBaOYWkyWb/6W8o+FuCb/DBtybVRIgL3n4Jk74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o03DdAZG; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o03DdAZG"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba699316b42so906269966b.3
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 01:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777019128; cv=none;
        d=google.com; s=arc-20240605;
        b=G2RL/JACQ3KdoZI0XBZyvek2TBYbhmdSCH3RwOhnw5YTdou7KVon9m2FPn1emYFZT5
         /DTynElY7tOfScGSph6wg06QkYSMly5x3jNGQrb8VMbeg67d39W8jS8LbmCoZp6Iwgpt
         XNwsZp8ZhY/C+4fqVH0yRqb+54AeN0Rbyu+fyyjUcCUn62iOQI4NlbrxJXzo78JRl2ZE
         m+/kXwGtOh5+miIVH5HrqvDGWUqis6BBA8F5ro3XFegnRa64IOT62slIRTa3gZ2D+bv/
         IiiCDc1boEgvPz9Ce4i8LFr00kSTXrer6jgeiDoBEJPt32HW3lnuH1MhVHyR3NP++O4W
         BkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GzoRo/+d4BRIcGg24566JkSkG3yHlU8Q/eJTPAd51Eg=;
        fh=Z9Z1FPv8/+GleSgkxo/YIQtV1aNyADaXDpvUmR5aupg=;
        b=fWxmG/U0CK7C9vsgByAmiOjNvxzL5e+vorZvgywV3Onmyl5xtrkKH6xK/Gw+BrsOKY
         pbMtryzU0vb+0wQGHu03u/5Edrjb7gEOqQrMjitQgAU+idJx9Ytk9i5XB+1ToslR3msj
         8VDlYZmU9mtNStLBHF1uDZ5HhMud0esG4jL/GKclpevS+EmWaQTt6K5xs4CLMjLFQNi4
         ztxnEqrRRYUryb1lJ9Du9/c/nhwGjy+p6ETo9c+W4ByYp1ZPA1gvLleTOj4+eMGBozP3
         VfLY0jsPX7cUGM3m2TzD9lrmQA/dUAEqpObk/Upn75crQyWEkNygADSzuZe671XZPQ1Y
         Vsog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777019128; x=1777623928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GzoRo/+d4BRIcGg24566JkSkG3yHlU8Q/eJTPAd51Eg=;
        b=o03DdAZGGRDJDdfX/VtQ0EDH1O8FAJbOnQk//lg0z9jkB3mZlVfXo5uhCYYqv+Mh23
         j9uvyY50m28LteeEf4Ti073PZ5VPPNc3LBSOAn/A6TbGzb3v8mIXt6YzPRAbHmZCn8oQ
         3WMDP7d+zt7PbyOdFFW36AuhuoSI10aLjp33aAHkuy20X01w5VnC1HB9q1bwd0er594W
         mXhfh8k2qfHjqbnUvwxNGleiF8MnV1Jh6I31uni1FV9zq70LvX+ZDqyEtS2vVsHFbgkW
         zi+l92j/10tguK4VEaSCSPqaN07jpiwUUAhn0aufsMQQSAxxxb9NyRqgLzSw8nFjrvmM
         BE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019128; x=1777623928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzoRo/+d4BRIcGg24566JkSkG3yHlU8Q/eJTPAd51Eg=;
        b=d125MbSF71UhkC/h5pbKktMuYEtG/OorZTnVoGUts97UsUfQS3jDQuvxf7eVGXOOMs
         xESSKYEwlLufDXOfn8g5zTbo7y75YBi6mCqXLcoTqWkSwT8V/0PeeYHBkBi8S8grogbs
         OQrAOOTKuLQ2SIlqaOJKIKoczkkh62BvGXQSaarICmtnse9NMySEfRPKOg4h/c2hl8MM
         fFOsbN0PsIaJg8vb9NDo+QLdbyReLE/DA2xIsDZBJAiKCw7bz5qzcWutp/8NIao1VGmB
         wP8dajM2sdnPz7g03schBTpPX1uiCm9wD3lqg8eJpCzDjYnReSHHmJ6VMnOoFvqVFIxj
         uhWg==
X-Forwarded-Encrypted: i=1; AFNElJ/HSiHwcvD7xdzg54X5nE89N7smPtdgR8GLumW9luNolXZZnlDu2k64ul9JZ3eFPrFL5hWKpP3llQ1aOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzszuwD+fB59VAhz+69PcUSJel9cTaSMkUAsoi18ROfBVNKN3zb
	/NFuwFqkYFV0/Vm/kIk5iNVg07KISu8S/rj+4RUTElBsliv3LzbOjQfixFG1bqh8SaVauZA4IIu
	NXwYtJcsJkuVCdBZ6NjV35gU6N90/Vw==
X-Gm-Gg: AeBDievhaz/u8MiD+9lm9EJ1fSx2E5MydC1Il34o1rQAKnxuNHwd8LGKqu2Hy+jrc7P
	5sbL5/ArF/UhFD1M26FvLTt2HkANTCz6C3RS7xeCVvxubdjNrl0qaGD5ovZbvkqlwG2aEDgnST3
	53X4+SGyVl4CjLjdjYhzm3yS9QvDaOthmsO1sCGUgImajUT/o4TLT03Uv+7bzLfOyIGa0um49EC
	1Nte+EVFdw60eKAOdg/yz0PiiHKvYa3rR7ulxXLg8Hx4DCxyqX64O35TSTpibsBmXrMUcKMytBO
	J3Gr7sCiA7A0MHbmLY08WZx/xzHEZ6hzwpQ47oJKzQdEjg0AuhWP1rv2iKyhTyUrbA6oCXsh5a5
	esPU=
X-Received: by 2002:a17:906:fe4c:b0:ba8:c717:7fdf with SMTP id
 a640c23a62f3a-ba8c7178133mr985190966b.30.1777019127488; Fri, 24 Apr 2026
 01:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420020327.1667156-3-iam@sung-woo.kim>
In-Reply-To: <20260420020327.1667156-3-iam@sung-woo.kim>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 24 Apr 2026 13:54:48 +0530
X-Gm-Features: AQROBzAcCHnLuc7hMd-95Nl3-_oZEl3SfjpKR0OnquhaETZkJEOlONuX3VtVbrE
Message-ID: <CACzX3AuAB7uf_UyReTHV9V8nqxjBe607UT7HQd4M4PhXdicjxg@mail.gmail.com>
Subject: Re: [PATCH v3] Fix null-ptr-deref in bio_integrity_map_user()
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Nit: the subject use the usual block prefix
