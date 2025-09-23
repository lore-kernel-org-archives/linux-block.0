Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECF208AD
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599451; cv=none; b=EvjiE+Sdvhc9/z7tSQBvQYOU0spDBEBf+CC6SmLoSJ4Yg6CjR+fBHanMGtFx47gQkeq/yTVTzjZyXkaS4Mvyc4CHPo8pTdpRW5i0FwW1pTfZiQ21FMlpQOCmvx2JUFEpzwWtQumbsmRD0xVo+P7/6h/9SwjomqusRmrbQO32lmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599451; c=relaxed/simple;
	bh=z9rIm2Qr+sxmWg43C3LjSRMHytvWzDOz0PNv61PwIN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8Vd8Bgd6Z8Ug7PPsdXoHYB7n0kELEX1wiQ2ARUg5R2OszJCYCUE1XnLrVgNWyzdeKZooxAuSqkNPkV6KApOlOwg9bHxoiXKkk/beZpxPFt9ql8mPxwClEnd+iWJXdzUqwtM+HEjxNL/fnOGJdpGOPJkmegfxfTLEUZ+UTSK/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C74ecbyB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C74ecbyB"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-361f9d329c9so6635231fa.0
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 20:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758599447; x=1759204247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9rIm2Qr+sxmWg43C3LjSRMHytvWzDOz0PNv61PwIN0=;
        b=C74ecbyBk52CjvXX7Z8+CsaKJJEX5t1LX6dvZqkAPyap+Srb2QPTQj8kyeakOc/+TQ
         LYnWqLn8MxUVVYmAJWIAiG4YC2GhRvERAOBUUUj0QpEBg2B8Tj4a44iUsxTNLy2Au9wK
         /VVUL8v8HYSK9Z63ocNqLIcL02sCqEcysl1ct+PPfeM8PC1ifHUQ49Kiqnecde+qXGL1
         goZ5MVlM65E8IufXVJbNJI/7TPnsG/61UWooXcraxtc9CFX4+fC/htUYroT5dWT75x1T
         tnPFImbGZZxAH3QBbAFbQgoRZE4bnM4TF9nHvmXHi5WyeoUus0t4agzGK416/tScsN6I
         3orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758599447; x=1759204247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9rIm2Qr+sxmWg43C3LjSRMHytvWzDOz0PNv61PwIN0=;
        b=Nljg+pRtJA2yiG40U3TNH+KF3toyzLreRPMOC4btrR4TXVVzQloQwTq0r91HTsDZfQ
         O9aj4ml16uQDVgMb8c38qZ+By6GhsA/7wV6vbIga3bYfuI7WoEwVwT+fqcc0FAzk8/8L
         XY36b+eHib7YpRc8WeQaRNP/CTxyRpXfG8wtbpqFCbcByOIfT26qzByJdBNfnt+gi5kR
         3q/25+BPatIOu+zsRO9kqehcq4QAJ51v9orPt82y1JbBOkMHIwVcFRu04wumlEM2XW8h
         gm5cb0IOq9PzXntim7COsTR9QPDp7RB/9l9g9z0A2ah+TnP1A4lmHp72b91PEss3nCk5
         YYXA==
X-Forwarded-Encrypted: i=1; AJvYcCXNW8jAM/CsCWrz25sDVLn66tHZ+8TZE5T8iYTb4GyoI6EzBO+kGYKItnNz6k1r+gStB7cbRYDtcv+ZZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqfalRjircz1UT/816T+EwAp0r60rXMEBHgvR4HspmgVermvTG
	WejpJJltja/fhY1PLkog26hXUdPLErEPq+STKSZ7lUbwsOuZJhxDVczRCxr2lRCKZ3ykv6+9tR6
	ze+bvPgmoJ4oAci3eR1xqBXbYs+DbmmI=
X-Gm-Gg: ASbGncsF5YmD3NW+ZxSAjwI8LrmMyqhur2mniuZW01CWP8gWx52INPvFgrNWDIgKlXp
	X8ag3zlg4cKKdz3HXcPaHF/U42xPFsS32fz+UXhC97BRa25S3okRouM1IXZdjIkK0wUnJSTsmbX
	Aa5/8W6mlutB9cUx58i3EL1PVtDgTnzYZWm4VSXSDQihJ/XI5D0ep7eHX+A8z1PP0ydo+jaV0nZ
	GgaUIkh
X-Google-Smtp-Source: AGHT+IFPR/ojxUbcunSqFj95BptI/0qdsAjMPxxte1rg/TtRftlIXBiGgzI+t0qpAtOcsZydxPV/Sc/0QBJ8p57foMo=
X-Received: by 2002:a2e:a587:0:b0:338:1a1f:1152 with SMTP id
 38308e7fff4ca-36d176d9e37mr1511201fa.8.1758599447268; Mon, 22 Sep 2025
 20:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com> <aNGQ66CD9F82BFP-@infradead.org>
In-Reply-To: <aNGQ66CD9F82BFP-@infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 23 Sep 2025 11:50:35 +0800
X-Gm-Features: AS18NWDFEH5uLKDpswEZriajtkKtRdC-YZKxVLp-mDKwLqx69RhYurkjBEuTo54
Message-ID: <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop driver
To: Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:09=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 22, 2025 at 11:29:15AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > For now, my android system with per pid memcgv2 setup are suffering
> > high block_rq_issue to block_rq_complete latency which is actually
> > introduced by schedule latency of too many kworker threads. By further
> > investigation, we found that the EAS scheduler which will pack small
> > load tasks into one CPU core will make this scenario worse. This commit
> > would like to introduce a way of synchronized read to be helpful on
> > this scenario. The I2C of loop device's request reduced from 14ms to
> > 2.1ms under fio test.
>
> So fix the scheduler, or create less helper threads, but this work
> around really look like fixing the symptoms instead of even trying
> to aim for the root cause.
Yes, we have tried to solve this case from the above perspective. As
to the scheduler, packing small tasks to one core(Big core in ARM)
instead of spreading them is desired for power-saving reasons. To the
number of kworker threads, it is upon current design which will create
new work for each blkcg. According to ANDROID's current approach, each
PID takes one cgroup and correspondingly a kworker thread which
actually induces this scenario.
>
