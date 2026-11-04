Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806053;
	b=tpNo1bQjSnbaoCGaiFIULF/FH7yHiNHeZSKt2lbC5SdVZRaJHFc0Vj4DlzIOA5dMKllp
	 iv8sNSrd2itXuCa65A5M8oart4I42/pOMXGyjmLkKkY0k1luoMQp1X6XLKErkKZQFEsP3
	 KFeTRj6tdCX+C1I7Hb5ZfKM3PDGAHgsEuwzmgueXCjSTAn8SRZrxTOzMCOjE4Jm2nNO0P
	 E+AyXQyR3IF+q8yNGUsuYRhxDxE6f54zkjqYkiOS4G6g9C2fgyyH4yrt6H2ZzhYumgHtt
	 E8QVYSYspvEESB/7ZG6mIMI45Ap8zRFVe13m/1wAo3Z9AmQYVvy+AvvGR3XIrZSt4vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=CIpKMto3juCBWIXYogyz/kuSz8z9yPBH98tdVVEJ+Nw=;
	b=dHfsqa1O2bReIlNGlzPcLiufQ+iRebZWp6a5I58vmW5yhOxFeMtfY6gIzNHtNcMqIgCj
	 Ntvlk5xJHA85WGHfnaHvTEqf8djol6SgP0f/zSoDhrcviKSr6pzXJ2whDC5J6SEIGKL/O
	 Yhmv6TJpiu9WWl9x6xW0spAc9luU+eoB598joYxfQat15W9T9DEAIW1v2/cJQomv72tIB
	 pjoCSTwxVM+WjVxrEFzTwva5w3UgyZhmhzcJ079nvky+ntuAx6XkcaFb7YXGu3+dZANRR
	 Y3GnPQ26zTw3Slj23cKu2R2bM81ZbCWlLJ05vJ/nEd2loHAyPCBaiJ8Q5qRgtJh4u5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LJl5RNQ5;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A845606D816
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 15:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A845606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LJl5RNQ5
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1527096eec.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793806053; x=1794410853; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIpKMto3juCBWIXYogyz/kuSz8z9yPBH98tdVVEJ+Nw=;
        b=LJl5RNQ5b7c50OYJXgxlRs5H5LxDFdVXsRyml3D92U9/ULyM26t4vzd5tEZjDmhgN5
         S9P9RQ/lPI5015Q+QPS8ja7fGIy7ddh53e4tPbW0ZXa+b6Xqj50UufcjriYjVxqgwgYZ
         ybQy95yMR4ZKpTLszyt+tjRYf0FsDqFXqDLqKj2nUN/lmiFQSrP0EfTaPf0TGrwURsg/
         qtFgzOyC+9pQ+GP3bcLTSKy2RogBXRzXCn7lOK7BrNmsuIUSmR8cmjeitjasVBLNSkWs
         y041Uuls6bE+MJII7SrNxXR7rStb/j9x7o+jlyQJqHkOBOj5+q5qvHsxvCQoJ5z/bdS/
         L1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806053; x=1794410853;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CIpKMto3juCBWIXYogyz/kuSz8z9yPBH98tdVVEJ+Nw=;
        b=eUPxPiumJwt78e8vclUOki6keLqq3B7S5uZut5cGKyWkAe7W/huSvZutbvn24E1vl0
         uuCPecrWbIQ14iAjcLd0naVG6PzqbxwBt5xTpcMqQH/oxSIblygCQ8zoRcV0NKmtn6no
         xfCWAtxwdlYUmoEPMP4n7JkfJ0uEIBC8HsB81iGnvwX0ePmsY3l+28UIbi17aI00ubB5
         5UoZdF30/Qz1DKMCknHbd5fJmmIhQZfn8UDfhuGJafTu160haknnZQDQm2VdSQsIH/4h
         JVvIpijfox2/a9ZzDmt7UnGEqs+cG9ALwyblpgFg2J4NGB4vnUHp8vepSXOC7LceDKUa
         xuEw==
X-Forwarded-Encrypted: i=1; AKwUvBya3/8mhhkmTJVi+eX2PVZEr0MRglGwWcRN9K4XbhOxdXWPyF98C9EGoxtAnWxc6cUNRlF3L7wQ4Bo/cg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/UgvptXzUFfRoIms+m+N382rKrc20GC5StyIjhvKEAnzyjSLrr
	16fA5Nt1N5Aj6aVwNUT6XP2SJJC3xpawbQk7aumptauwOaYUp755BCknXIoqV0Yec9bCNVOQfe7
	fQDxsOZ7+9FD7Kv1ujlV2eg==
X-Received: from dyjm35.prod.google.com ([2002:a05:7300:16a3:b0:358:f250:485f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:88d2:20b0:36a:6d52:e16c with SMTP id 5a478bee46e88-36a6d52e261mr13279550eec.12.1793806051988;
 Wed, 04 Nov 2026 07:27:31 -0800 (PST)
Date: Wed,  4 Nov 2026 23:27:30 +0800
In-Reply-To: <auo6bvjDtwAMKOid@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029040005.2100005-1-stanleyjhu@google.com> <auo6bvjDtwAMKOid@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104152730.3102376-1-stanleyjhu@google.com>
Subject: Re: [PATCH] PM: runtime: Update runtime_pm.rst for non-fatal resume errors
From: Stanley Jhu <stanleyjhu@google.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Brown <broonie@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 03, 2026 at 11:47:58AM -0800, Brian Norris wrote:
> Those need a close eye, as the code involved is a bit subtle. I tried to
> review, but I'm not really an expert in those subsystems. (I'm also not
> quite sure the second one was 100% a regression, vs further exposing an
> existing underlying problem.)

Agreed on the UFS clock-gating hold release. Keeping the hold until
resume succeeds was cleaner regardless of retry behavior. That fix has
been applied to 7.4/scsi-fixes. I have also sent v2 of the block-layer
q->pm_only fix.

> I think it would be better to flip the comparison to the other
> direction, and deemphasize power.runtime_error. For example:
>
>   "Unlike with the suspend callback, failures in the resume callback are
>   never considered fatal, [...]"

I have sent v2 using that comparison, without mentioning -EBUSY,
-EAGAIN, or power.runtime_error, and added Fixes for commit
aedc51762a0d covering the ->runtime_idle() paragraph.
