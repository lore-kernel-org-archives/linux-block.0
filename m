Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5F2D47F1
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166530; cv=none; b=StBFdpjli4MdEraUtaIorueTrRKnXZx6hxlvCreA8SPNoZtczD0BXGhVp+XA0xrDxn3Lr9+wo1j6Kc6PBM+4wA5uQNlupAUploZa9jQwEoluk4SZR3l4mS+V2QPMx3p6wLPN3iQr/p4ET1+J4UWez7oFwSm4dosjiKsBGK3nCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166530; c=relaxed/simple;
	bh=Emj2orDwq+TLyUpyoqbTeu0kDi+iYHkJ66Z3x2M3kpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf1QC70P+i8XgvrHtbsKeRacuZf9pSIPJmHnyzN5DlOZbDtfo37d5Nju9OOScKHtKS9Zt/gdRTu9v1ykjodzhhe71wSAcsuxwDg9iWx1ybafsA4W4braA3ATbK9DcwkA/z+x8h5balpXt9w3+o39j1xH/liCBIWDo3pFN1WXoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZwicUVnd; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZwicUVnd"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9ab2a135dso104577a12.1
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789166526; x=1789771326; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0IJ+jRiSwpoAInuExu0806wVM7DzlfDcKn5ukHmHWM=;
        b=ZwicUVndg/QzL1/tbUpHHki8gdjw72SE3wD4dETAoNEslZ3NOVMddjJiDw2FnTDg4v
         tkpz/A5mNCmtgmt3yGYoFNJ6SM7PVcVwsNZe7O9zXsX/cxNgPWCcfLqxsZo+hq/segTQ
         z1dC3pgD2swXkl119prr+rlIEC1Kp3b64v1G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789166526; x=1789771326;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C0IJ+jRiSwpoAInuExu0806wVM7DzlfDcKn5ukHmHWM=;
        b=EWF6rX/VZB9AgofbPQ61y4TmWIfn6CHRoMa9moHJZsuHDdsImJlQRKaMvNJm2UpsuV
         BhaCe35J0w2K7iCEcr2QgomtBDLgc3zZ/n9/HeMA2Sy4mLU3VDdLAlXm0RTQI5cMWoca
         riO6ZYKbhBL2dwVapjvAm0tRJaCuvdNpU19GevAkvcjK+AZlu5EnYST9mCfep3IFShvK
         lW00pKiuWybuIGqC0Qog/HTTEhjh9Egu2K/K5VFt6eAAcev+wW/tB0xjOStU5kLz+1Ot
         A1S6CdC5cy0E/UvlL1RzGbbOTLLGz1qRL+OC7kCrsWP5X6xXCOa8pts7hvMMLs7RnGvP
         G5dw==
X-Forwarded-Encrypted: i=1; AKwUvBxOlw2S3RBO+7Zal6FgIdTokGiO1qTKe5ayUkRyoW+OOdCBB/gCch3ch9rmoPD6z6Fb+O/fci8/7WSnTA==@vger.kernel.org
X-Gm-Message-State: AFuF++mue5ug1NpKCtIbKI7GVjIcJXFMQARj4C/pAWmlKLRCez7MH2AH
	a8XLlceCWJAcd3VXdFfHnZSz8tRTOuzfAJly/6BCNwS2qhZg7BGMRTqSJm+r0AjXPAIavik9NO8
	MPuEkqcE=
X-Gm-Gg: AYBFou3Dqj9E75l+KctETIZ3tt6Dx2oMb5Nh+ltIKSsRGd7MxV9fyq0tC/OTQAbyMo7
	uzIzFo39474p38DV709HScW0ZQlgU9Jcbp+qVvCvQNXVbFEmbjZk404Dl4oSURYyFhCWm093+uA
	kokaXjWI9lIRYZzI8Zg67SK8qKtAhWlsA4mFREmoZY/CEbqy9UppDGHpRV/1vV6Q2fXBLRAcJNY
	gZrZ947jPcpyn6BOBTYjGm3J9/kSaMAENo0Da6RCG0b+JIy1AxCN6hTw7UZU4fz+8k1vgkZ7Pg/
	kA5rSf0QpNcT5biOl02veJu8+dGtP5kFedkxWmN8XPk9gCXobmEn73GBzP6/vS+No+fstucs/gR
	ecY8nIKcxJmPC9OrQ6zs3rAVNdqPNojWRc+PjI0XzcddJWx9UCQAw6jsEyGBnpq1FhmNu3O+4Za
	yuizdh0FDr1Y1PpGxX2SA2HGODjxoXwcZaE0v6E1Qf/u8JQ4rSFAMxB3uDIOyoPiDbxACHLc9Z/
	GZkv56xfK/TRt7CQEqLHufl8ltJoJJMVSqZVw6tSAfZRy3YsQ==
X-Received: by 2002:a05:6402:21d8:b0:69f:4c65:86c2 with SMTP id 4fb4d7f45d1cf-6a9cd1c72famr168339a12.2.1789166526064;
        Fri, 11 Sep 2026 15:42:06 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b5912644sm1285373a12.11.2026.09.11.15.42.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 15:42:05 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so9218066b.3
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 15:42:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxnbLFsq0cv6AYNPgFBBwt8b5w8y1pxtFsxuLKxsn1qsyrIXKpOglKT0hs0rOuZdB4cZOx8/lhELbpSqQ==@vger.kernel.org
X-Received: by 2002:a17:907:970f:b0:c29:6136:3df1 with SMTP id
 a640c23a62f3a-c29858e8fa4mr14946366b.34.1789166525306; Fri, 11 Sep 2026
 15:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fb210ac8-b00b-42ff-8fc1-6f9243302b61@kernel.dk>
In-Reply-To: <fb210ac8-b00b-42ff-8fc1-6f9243302b61@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 Sep 2026 15:41:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgscVQOpma5sANWVLEu_VWBbVDz3dxbBcc_JM0CcR7QJw@mail.gmail.com>
X-Gm-Features: AcwNN1UJoSJNO-vhWsZyiYIU_iBpB5lM2_Ass8azxe5zVawINj3xTfiRsZvTpMs
Message-ID: <CAHk-=wgscVQOpma5sANWVLEu_VWBbVDz3dxbBcc_JM0CcR7QJw@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update entry for Jens Axboe
To: Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Sept 2026 at 14:45, Jens Axboe <axboe@kernel.dk> wrote:
>
> Linus, could you pick this one up directly? Thanks!

Done.

          Linus
