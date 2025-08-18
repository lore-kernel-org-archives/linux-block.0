Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F862337682
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532750; cv=none; b=Jk0MGNTyfHHaTqNoayDA2ThV6SZS7k7NqJ8fXgwnmpRDt4L2o+2B/Q4In2TjxTGrDSRzEdYgIaSg4ghgQwNGok4XK8BG+AORugEtqQhkQfYnTckIUaC3C/Aa6aen8uqFMrWSIiBs5p8wS584mqIyMS/9CaMue5NoRzhsnNZMlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532750; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cU8/AKr/suNXyhoz2+FNUn3tosBfvq8MvwNpgPPzeHKixaSeDCsKT9yqhgYGd/TjLkPx9VmpslLG4I5pwpxDInJt2kbcuhdZaHuEfqrQYOksw8niZkxLbOcMIo+/F1c4XQxCIPAxuSqKkgIQcfRC9th6iIyBmmdMESCvfoIoBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6BidVG7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6BidVG7"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b794743so6899948a12.3
        for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755532747; x=1756137547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=J6BidVG7ZP4df9ekVd5oWNfhBpRLEOaxobDnceRWfbqca2kQd4wDC7Y78NxnG11q6f
         Kc1WQI6Qd7Gdcq6oD1/Mgjf/kRvJL/bhqn+XIhYurbgiJ2SkKOQJUxXV/BlZE75QVp1y
         y9weCGhbVIJrodY/Pk6+izQE91h9GoRcqyGXdopNOlTDA7LgNWYoo03eBEPcmr6Qws2K
         eOLHeadtezGvB/ie1gDlfp6vdjzkQUAuqJFUy3XmTTRflxKxdHpoUbj+gnwvNVY2Cx0g
         IFBGxbjuh4Hpg5hg1NTxgSYNIdm6kvpDsgbCQfa+ugD399OYQKHWmHiS0J3Vemuqvaf+
         ZBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755532747; x=1756137547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=Gjk4WHZVfv1oJeQvJfiqqI13dlIbAO/q7FCXwT9dT1Op0nkcPEYhyrK2HpZsyCQvg0
         GgVgLDMPWc7jCfIjDXMP+1Lqh2t8+wbcRoE0cTniHj4mmcRZFpeOqdanhcoxvwHyryJf
         Hr2F6ngzpJl0yEMgJ60rBfasCohRgc7e++eSSJ9CC0lLC2wa2UnnKl+4S4ZereFuB4Aj
         cVNZOmW2rhjgqJLUlr7mOT6tPpYEVG9TDcRpM7i7VR1wLwxNVpzruB3PhjzmPVg5+CLB
         PjRA6t7wHW5si76dueZJr74kzndQqZP8Kxas1exzZfWHePV/kvlK3ldpq3kw1IO2qzkG
         KiRg==
X-Forwarded-Encrypted: i=1; AJvYcCWIdSBMLPoVWpyzSKpMuPF2b4EFEWVOaG/0P4+TVBaqSl9Y57Kq+7JV3xYRBsnrKDO6IG5p6wXCFTbk2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/vta6bRkV1De0ExZYqhJnhb51il6u39gca7mW7xRnHCOO+yo
	T2pmGYuI7SDF6LNxNvYJxDGY1zFeN4fqUHTWxgcHW0qVXzf/LRsiGYZCrigLL7oMPA7hzjbHZNv
	LQxILaUsLMiV2f6RfHd94KuAI+lpqkA==
X-Gm-Gg: ASbGncvFgdqMk1qnDPE3KjTGYRvLubbj93VOpEgfSOGTKHXdnrca6+Xh3Dbg3ffEJQc
	0BhuS3FBnNO0z8ShZ6RasJ0cUzHwOAqG8jfgA6lrYIqF7+Kz/BSgWeSRS5yijqzzVIXJ6xuEdqW
	tc012bLaMIazUT/ZISU2oLKyilIDG645v4lUrFfKGQQPbBjkXCgKx/5u0nApNIb2oR3C2uAskOr
	V7hPfmQ0vzdDoezt8iD8d8q8NMUWiPUrkMh
X-Google-Smtp-Source: AGHT+IHzZOE5sdD7K9ztMHScIKCaV0XfJ9+DTjwm50oU5xB5mXy7a9Qk34UbywuJ63e7g3Daxq8M/8goIiHFO2CUkbA=
X-Received: by 2002:a05:6402:440a:b0:615:979c:e89f with SMTP id
 4fb4d7f45d1cf-618b053a72amr1562247a12.8.1755532747152; Mon, 18 Aug 2025
 08:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818045456.1482889-1-hch@lst.de>
In-Reply-To: <20250818045456.1482889-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 18 Aug 2025 21:28:29 +0530
X-Gm-Features: Ac12FXwNnMBJxNoIlK-xi3COE14cERVinE22gDMc_UxvoqnQvy35l2uIogm-nlY
Message-ID: <CACzX3As8dSi0yWvp95POyAWoOGpGd_a4K62=7SZ-P21f+75DXw@mail.gmail.com>
Subject: Re: fix stacking of PI-capable devices
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
