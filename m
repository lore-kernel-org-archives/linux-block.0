Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408091AA792;
	Tue,  3 Dec 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226089; cv=none; b=bE7TpBwRjyo4fyiBNffx4YUB28C5qnoCoA5QVnsYtFc3Imno2cfeUYHzWtssnpSa09JbN8raF48UWNBtugrTMgab2mt+esP8rI6DYSCoCURsssBcQ4mRBI4FnBLNCmPFBkjFEM4OEIUK67xpBg1HnEEwPSj74jVwO1bC4eY5hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226089; c=relaxed/simple;
	bh=B9NyZcAaR4dHU+SFxKhpBXk/nUrfP0ctbNkEv4HqWK0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SUPIVIqVDm2tzDRO1RIwQhdYgPoorkDOS59ks4bFY22DeTQmiZuS1qhiCqVRQ5w0kypN/A1A/opTffvgOvTkQhEdbCUhZdGpN7LLyVwtPUz6KxQgGzuII4FLMn0s8m9yJLGdbkTlii6GzmxdAXxvYA6O3qekGxnX3xl84MQEpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMjmq0ri; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMjmq0ri"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-723f37dd76cso4810483b3a.0;
        Tue, 03 Dec 2024 03:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733226087; x=1733830887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JmCZyJxo1oZx8BP1akGMDqMWLT87OYERFkBVgJHnAw=;
        b=ZMjmq0riqCRlZGC+4E4jPltWs5poIvud4lDsq7dOJOhgWPc/KKusHd/gKuVw2RFKgb
         rgnDctKY9VT0IPcEXGg21X/DK8AZ789X5+gk/VJVuWn29D+XvxNRkWuphIiJZ94Kd2ux
         y4cDG+9KNIcHP9vAot06pL+DCDHan0ITpEGgzJDanJRzr8DgJWIBPhH9P0zD3tsDvmPt
         rjK/ICT4zlls9IkQqGvQVLt05hvPFcQ97Nxi4jInL6qEHbpHl4tGJ5f8B47zxoTCNBUd
         urCQd7F33E6nlZW6qRcTEyVyQog6+JDzIA0Yuqfot0lVo+k1odch6CJ/gRTyqeRP6xSR
         TmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226087; x=1733830887;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JmCZyJxo1oZx8BP1akGMDqMWLT87OYERFkBVgJHnAw=;
        b=vHgkGl00VPKP4TWFgAvmogFELLV9b0UVkgawl5q90ubbQohfH8/+5xgmKf7qkyV9cO
         2FBLmMp3a/ZkXmFthNPoLorMkYacKIyuBOUFnMMJc4vGVdcJYesd8oEJDKnzj1TZnNEx
         tnrxgTRqsrGYXhvEO8cDnywpxVIIL7K6+2AfwNxtFab8IRKytVvE0SZq1CCnW6T3D+vp
         eMD6R6vpPq6UxMP6wNYHLLTGkeuudUQeZPA95bPWOlREqgK5Jy8bXxJAJP2uFK+nnVv2
         +ZyUmq9pMIwraeH5Cee2QXnu7Kp7fY7PR+KXIoO9caQsKy+SjHErCYSJqiQbmfZZB7tk
         eHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb1kSC2tUnWl+xW/ndsjS2v3ELgwBXoFXg2BDUJv88A7MwqDBTRWVyiVqiMybmQYcZk6n8wHeVDIM4Iw==@vger.kernel.org, AJvYcCViDRdrkS+ArYWUZfFYjYfIsymEGfmH9EpFPdnKH2WGp7BFwlHz2wDzz5iKfFO17HQMb3kp7pKJx6Wn9U8SUIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiFEGv8+MFrCBS6O5xtNAnF4LCikXaa7YhUssCcjtxgufNrDE
	JpL6d145N4dxME6yFvXlXVWHkRsHvHVHzwspoHvzeSsvFJdCzCT5nQDnyQ==
X-Gm-Gg: ASbGncuJqx1857Xyu8xLJSXXW6blXIURp86rlxu0mm/6tL7xe+EqrobU0fTw0ItzB/O
	LqPjgediKu9snMUvz/H5YeLhkfDX05tSCbXv5X2JWhrTmPu+q6RnpzGGyZgIX54m0oT7CGpqcLP
	ncPxKptAvm0WxM2/H5ndU4U3MxslQHODuB3bChQ72/DL9NzITjqd/FLPuuIuFL5gUysfopyt85N
	FF5Si8dQvpuzt97KrYM7JRkZBGbzt7pvxhJThedrSUshntDKvN7mmP6fhf3BWfyAGaCsMd7f3C6
	glsdyiBEInQm5ye4J9gk+Fz5M5VGUw==
X-Google-Smtp-Source: AGHT+IFISRLho6NzL9PASWk92b6pc9qbusCNbuSmHTfEMDbRY7HUidBn4oTRBF1wcsz6L7L6Mb8cBw==
X-Received: by 2002:a05:6a00:98d:b0:725:418b:90e6 with SMTP id d2e1a72fcca58-7257fa59b72mr2983008b3a.2.1733226087440;
        Tue, 03 Dec 2024 03:41:27 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72544269fedsm9943301b3a.82.2024.12.03.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:41:27 -0800 (PST)
Date: Tue, 03 Dec 2024 20:41:13 +0900 (JST)
Message-Id: <20241203.204113.1049111619349862214.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, linux-block@vger.kernel.org,
 boqun.feng@gmail.com, axboe@kernel.dk, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] block: rnull: add missing MODULE_DESCRIPTION
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87plm9f362.fsf@kernel.org>
References: <nxIB6ABobvhiDA2z5gk5pNpCwflPD7Faqf6s4WWaJseb8VIkFsYa2Vl3aeMLZyC0G2HecJ0D1_GPf3FczGjCww==@protonmail.internalid>
	<20241130094521.193924-1-fujita.tomonori@gmail.com>
	<87plm9f362.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 03 Dec 2024 11:53:41 +0100
Andreas Hindborg <a.hindborg@kernel.org> wrote:

>> Add the missing description to fix the following warning:
>>
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/rnull_mod.o
>>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> 
> Thanks for adding the description string. I am curious about the
> warning, since I don't get it. Do I need to enable anything special to
> get this warning?

You just need to enable extra warnings, e.g., `make W=1`.
