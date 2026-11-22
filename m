Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795343618;
	b=5aE+m0j6TgiUftRsLkosM8J1a2vT8gt+V2x8z00Yx75AndL2eb8x04VU7QHUCec2vCYj
	 8z10BznOdvth6dfhbwhSY9ppE1DWdR3zrKc/KzQ1cwO09V331IVTw8Rs0nZq+Mo2QW8+b
	 UMvZRe4a6O1ZdvBM2XSPoj/wAtEbNKneq3CyJ0SETY7OSQJ31o+7tfq2zJ+GbdkFXSlj6
	 KqJx6l/zzoM8lYrCgTViUw2nLt9YKUuRViLcb0U55S6HBBBaAMKHNEivH+viO3wLxRFUj
	 hfvb8VixmXue/xMCuIIUgwOxHVXuqKRJQC3SlxPU+mLmyfSOEHsNNjqQZPEGZ0uYDvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CulNdxDlkl+Npn2nZi3nvTZ1THmtrMUTp3GyBn2Qbxw=;
	b=X68ptKs/iCBLi9eEv7Bf6wX06NHAQwUhMvobWagFKK1Vq8d7Of7jK9r+Yb9vV7MfvymG
	 1OHVUKgkxfevgvuDqPugNWdlSAs0FCuGdBGDxEveD+1Q+HYLShYvwdvrlOQszhcZoJrCW
	 /3OfiJiJSx50w+V5azSkbIH7paTlnkjgojDCnXkTrqVsPyv1bW4xri/gFBCE9ajddXHO7
	 Hv90Sk2rTcx9TCHKsIo5pBo6l4gusV+jf2GGg5W6rEv/f0Rvw9DXhQfH2Gat/2qaUlT+f
	 f6PfREndeh0ALkudEOj+JtDs4cdAJA82lgyOfVjXluj2nho1cv2txP9L//ETK6eRQrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dmnsz0m2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B8606A320
	for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 10:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F11B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dmnsz0m2
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3acec6677so3328764c88.1
        for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 02:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795343617; cv=none;
        d=google.com; s=arc-20260327;
        b=k+JPG+NovY/SfHUoMrmvDiUZRT0AnzkwRTvU9v41NLtxyQOdTCWsy9FpnQMrGVh4vv
         OxVHluTXOYAkzP0ZHVm3KRD30FOASXw/rJtJG7fQhOYE3Y7n9LhCwbRjsosqJ/K1Seen
         0dJakXvwVIQ94V+1HcfkBrn9u5rlh7pqg+GMIHHWRAqqNcl4X4xyXQPBO6W0ZPMh4QdR
         yHK4pObZRhfFvnGMWeKf49AAOmSnof27BIwEG4zE44gGss+rkZz0lREd2JkXhMnsQiUx
         LKoVi6FS9r2Dc5rRF4ydbNCguj2MJyknwczQUyDzdDI+o7g1UhAOq7cV8O9sm1TRESLS
         pEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CulNdxDlkl+Npn2nZi3nvTZ1THmtrMUTp3GyBn2Qbxw=;
        fh=TaoqpsDqOewZ+k1uBQQVTLx1kDmKTbVOj7lomQIxnz8=;
        b=grvnyc/xBnEzDLx9NjI9qDD+6HZNRxemcJpM8eg+5QFedapZh8EaLJ3I3vvBnob9rE
         wkoLHCXOT3fxQuea8gfxwa6a7D9B2s2x6Y+fGNtHaAJuGGA51CIm0+O7comrMjlxouhD
         KOLsSxRu3ejKt8jj+PHRkYQMgxp4VKCsmVWNMftaSqJuEHy9u1cjy7h40KPBt3vZeNqZ
         NJ4a6dgwMpdwxQ0GvRCPvtRP3W9hztiZ3+Kf/uwIAcx1KFJP+iQaPBdDCBaQQg1jB5ay
         fK36V7s9OyTGbG8ws/p2RyaWhH/FNgwpMx3naMLqU31h1e+oFSrGXArW0YgPAH9Nxzl0
         njNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795343617; x=1795948417; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CulNdxDlkl+Npn2nZi3nvTZ1THmtrMUTp3GyBn2Qbxw=;
        b=dmnsz0m2P81EbaAv3ZbcfDHUeug3L48SE/TSsl89jT2YIjTAtSO0KvBeRop76tk4kO
         1GJwIpKxj7BiewXfM8/bWlMkp6GOE1NNojNQ8XMU/KuN5htcEK6kZ7N5hbA6ZsiqdP0F
         sslShoK6Wgj8hdLSy/ryyRgHqxqafbpoUBMuY7mQh4snBBnyHVIzob6luvmM276iQdrd
         solTdq3QhIyDiSmQiCIudiHhcm/kwtRYd2RsG78VrD3wj7VHJjw/Lfj273InZOrh2gGA
         3nhO2MKNBsNpQQ0HmSnqH0i1IfjUCeUq0t+nL0rlGV03kxxlLLEbLv5Og39z2GR14dCl
         4s5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343617; x=1795948417;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CulNdxDlkl+Npn2nZi3nvTZ1THmtrMUTp3GyBn2Qbxw=;
        b=rL3kl+hlQ5f8Ap/0KQMqNMA3gByaoXgaWNUyTcuZjR7U7jTZrFn3erdLsfGTbHxRxv
         b4aQT5V0CQOcnHfWz5vUhdnmCkJk2nIeeBxt90K7M81/MRFBmdVs28GUl+Aa/9lV+KH6
         DAfeLgRUQ3jwbMed3jhYfGmO000IbLnVwA93oObBjXCVk/E6c8V6VgvFJOfIVn8eSM4C
         A9CS9tfKs8HZfM4QylTVTx57F/sfVyM5rhk4Y9fTyErCf85yhuHiIJOqm2S12BFF+MFD
         brYQacQciMdhvmYKwk+CVSS/I7v/IAV4kQ1HIrbljOaz98Q1Xr+fdQ8p/9a8F2TQIdXy
         y4nA==
X-Forwarded-Encrypted: i=1; AL+hErEgKWBszTXaBouQKW3u36dDkIXyKwXhAO/qA2iYMpippK2Y+LSdwTU0LzcWmQhC/cvrFd1lb89krHkJXg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Yo1zcUn3GSX4t/bhwxsyrQPQYZSuN+I5Omfo6OtH0WbTZfYoy
	qLJwkDOKwbMNmtLZY0aMeJyhDx5sD6bi/eyxps4o7SfBI1L0ZjbLOjFxcQaXKhC4mzolSeYaQFh
	Icun3TPkYCFOzTdMZO4v9HEyNaAHW77ivWawrEurBj/nOueNNZUs5l+jb1lg=
X-Gm-Gg: AZFdTZfOll4UZHX414QHZVBZV7qNb3o0bvhsNYSngdwaEYPsOHBqUh75GvwUWofzZI9
	1GraPAUblSy1kIuK1P110VpPfkC1GHSmCAHgpX/cPEXyM9iNtqAioGYpiYGyR56CZgjYlrKK6BF
	jUxIL5lQIdBztPjYMNQGJpTxooSvnVd9fQt4572O5LYQbfYVrb8DC8trL02F/dBLR9xaHT7DlUW
	OAncjaoJKTMUH2S82N0AIDA0vs173fFqwXrgb/4hLPjg2RaxvDKiSqdL24DPNxtKARsM+FlW2R2
	Sr4mxIeO7hCN+5wgdd175QZreINRl4JLVsT6bhP2eLLSaUSaCcWFykGlwUxjy5/Z5EBojhWh4R/
	u9UbXkFVMWrqfP8IB8Vr4J0G89WpITQvSx97zawZS1sswwEUs6WoLa5jHQf+Fxxvh+nlh
X-Received: by 2002:a05:7022:f509:b0:1b2:41af:c21c with SMTP id
 a92af1059eb24-1b55694689amr7182140c88.39.1795343616145; Sun, 22 Nov 2026
 02:33:36 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20191105182746.217864-1-elver@google.com> <20261122093626.205973-1-mail@jregg.de>
In-Reply-To: <20261122093626.205973-1-mail@jregg.de>
From: Marco Elver <elver@google.com>
Date: Sun, 22 Nov 2026 11:32:59 +0100
X-Gm-Features: Aa3M54pWRpZOziNx0XZevcGRIZfg4AdbVWAwJV7K3bXLfNj9_ykaSPPwuk0TrM4
Message-ID: <CANpmjNM9n+nCb46nEAUcrU6kecC5LOyYSxKWN0So0pZwYZ34GQ@mail.gmail.com>
Subject: Re: [PATCH] blk-wbt: Fix data race and avoid possible false sharing
To: Jenson Johnathon Reggentin <mail@jregg.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Nov 2026 at 10:37, Jenson Johnathon Reggentin <mail@jregg.de> wrote:
>
>
> While looking at Bugzilla reports I noticed that the fix I would have
> written for https://bugzilla.kernel.org/show_bug.cgi?id=220759, is the
> same as the fix Marco Elver proposed,
> https://lore.kernel.org/all/20191105182746.217864-1-elver@google.com/
> long before the bugzilla report. I could not find public comments or an
> accepted patch.
>
> I tested the patch applied to Axboe's Tree with KCSAN and a mixed
> read/write workload on null_blk. The patch fixed the KCSAN reports, in
> my test runs.
>
> Was there a reason this did not get applied?

Probably was just forgotten or it wasn't serious enough.

> If there needs to be testing done or something else I would be happy to
> do it.

While data races can cause all sorts of problems, or are the symptom
of a deeper problem, the kernel has historically been more lax in
tolerating "benign" data races; the C language says they cause UB, the
kernel's own memory model (LKMM) is more relaxed about data races:
https://docs.kernel.org/dev-tools/lkmm/docs/access-marking.html [1]

While we should be marking these accesses per [1] all over the kernel,
doing so blindly would paper over more serious race-condition bugs, or
cases where we need proper *ONCE/atomic_t use. In many cases, nobody
has had the time to investigate.

For the "wbt_wait / wbt_wait" case, I think marking with
READ_ONCE/WRITE_ONCE is appropriate, otherwise the compiler may
optimize away the load-compare.

Thanks,
-- Marco
