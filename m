Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A703D9DDB
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556670; cv=none; b=mqCpzxefkSdgVHWWz7ly8Pvt3VDAPNYWkvlDAKD7i8GFyCV1SwZsY+foulw1kS3CiKL9KaK0mprBeszqdSzHLz/Yb+Dv2kyKpDEpDa6DZdGf1/a7fHXdlYncwa/P+FzCY5MkK4uKbksq8ec95ne9GcSdov1/rpl8BDyNgaV8Qcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556670; c=relaxed/simple;
	bh=p1F8safINLCSBZ9wkY6CcuBdKpiRtmwSdSx4OkzmuDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GuG3CdBTfdyPHD8NDj0xMaRMl8uskU1Xjua180vTZ20GkYNlgmA6Ls10JVw0K485+etDINdIqfBSbf8o/3klt/4yIs6Zw+Ch8gCOjjalBJoOp0y2O1xfcGCiOhsF8FcmDShG69xpM6SCUk1YWcd1Tb8Shb0OQu2QS8Hm+mXKp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=osYILKjJ; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="osYILKjJ"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso8709641eec.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791556668; x=1792161468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9da5zk0GHj2rwz2lfan29dlM/wk/e0PgyHn2IrcmKk=;
        b=osYILKjJnqtc0TkJ88vYBKZzNr9hTIkvA63C9nZnyMdxiK+zfxashWq0tcUZvasZKY
         kuISinulQXkq+rOjFEk4POY3fAN4MeRQf4ek0ERdJPlbJQepFBlq5nBVd1xYXFW481Mc
         BcNKx0VnuDOWSxjdPJtd64Ggo6eBSwJ28g8JPzny6x9rkuCMF9g0F26QjTlk1VSILKgC
         DxJ1kQ3+9P4f7vlLVYvw3aG15OBhuC4Iovyn7LteW4NZgr1rMW+6Mpm1odD0hI6vAVeo
         0Rc9ZRlFe4PMQbrVNCkIoknQfZyusGKvLRhwZqDMXoUvfxBvTuazkMC+UHc7hHsPWtTy
         dIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556668; x=1792161468;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9da5zk0GHj2rwz2lfan29dlM/wk/e0PgyHn2IrcmKk=;
        b=R0sMKUnfBxvPLCq+MXk7jVspX8E0rxjGVvu5V5y3cbDw8sNs0Yv1xfjDPg42J8iPxv
         mQmm3jFAVB/830/QT6rW/7R5tCPndDR5OATSIxf11fR3YhzkAIcFB7vG0F0srb6BklfA
         IiYwHBXNpGj2PyYkqkQdJZiwkUF07of6tydom9QWBUBFkLbXi0kq0CDctd4Ef9ZY6mm1
         ZrH5ISOFsT+Xf8Uj3mmLjpyWEMjPqEO05O3aRJVzvKG95whM1XzetrLBehdaYqUrhM2U
         YqNAWx2vmS7WDDBL5cnBdgOV8zzDUXMmHavzOryvSkaG8ktz7ye26yymuK6p+xbL8KgZ
         LBqA==
X-Forwarded-Encrypted: i=1; AKwUvBxRb9p/8AMXTbJsyrUHcbk4ZNnbNQLw4VQs3LFZzgtdUz8GqjqqXmiJUZVp3UcwkeRZnEttvPBek5vWqw==@vger.kernel.org
X-Gm-Message-State: AFuF++nVLT4bTacR+XBK8Brj4uxeWNcOhGltHvQGBV9tn8sjXyhHe1H2
	stykl+Yh6yz1re/HAC+TTmSch+a9yN8Ub4xXj8cDg1QNJOiqorlF/NIVaCo+Qtz1EZM=
X-Gm-Gg: AYBFou2kvXjk4HOO5hZzBVTOp7H2GvRsl9/xLMjiQiXBAJUqsARMzNwvxaCrBsUV87D
	SpFTP1nTVl4qftSOShjdjVSHYIoVPakI1CInCuD7sja7UDFow3gBwVwrZvkc7Pw3Eryts7aZ7C6
	cWve0h26OlrlUM7rl+lGMbpMdFbdQFw6F7AxdYXNVsfZ9yVwOM1/xMqcVnmzLw6pp3IUAWFk2tw
	+q9ANyATkA6WWGcKkyPf5MGM1ImAqi6OFf67/o4Q3tORmY0dfBgHnMEv2UQw5RK9TI/BcRzmWd5
	L35uHwLnPuCXFayP6BQzMwyAB66oBZwc9nGUOj71RNhoujvkWjc4u/TGUsKqpuFge2Jtk10O6bV
	mrs71m3oHZ042UrvuWNRtHmrhFL6IGEiwPlgAeRER/C4lSo6zXGsyw5PYeWg3K8xKup6hT3aHDy
	v6UZo2udqKgIa23G5Jf4N0FrylH3ZLRDKv2MY4KPyQkpVPNvO1uETXo2zF/ShFE4BtAxpNgBYu7
	pnSEEx0fMUmSwC3IZBsVAsadBtlMG4mSuj/TwfXfza0bcZmoMMAoWpajaH5VaI7nge2dSO5ZvR+
	9XjhpLbpCQ==
X-Received: by 2002:a05:7022:7f10:b0:143:3c9f:10a6 with SMTP id a92af1059eb24-16a57734472mr2827175c88.4.1791556668232;
        Fri, 09 Oct 2026 07:37:48 -0700 (PDT)
Received: from xps16.local ([155.98.132.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2d2db98sm6603150c88.10.2026.10.09.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:37:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>, Qiliang Yuan <odys.yuan@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261008-bug-ublk-selftest-fault-inject-delay-v1-0-a96af7ead06e@gmail.com>
References: <20261008-bug-ublk-selftest-fault-inject-delay-v1-0-a96af7ead06e@gmail.com>
Subject: Re: [PATCH 0/2] selftests: ublk: fix the fault_inject delay
Message-Id: <179155666606.221695.3172868322177231667.b4-ty@b4>
Date: Fri, 09 Oct 2026 08:37:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 08 Oct 2026 22:45:38 +0800, Qiliang Yuan wrote:
> The delay set by --delay_us on the fault_inject target is lost in two
> ways. Its timespec is read after it has gone out of scope, which makes
> generic_06 fail, and any other completion on the ring ends it early when
> more than one I/O is in flight. Patch 1 keeps the timespec alive until
> the SQE is submitted, and patch 2 makes the delay a pure timeout.
> 
> With both patches, a 1 s delay holds every I/O for 1.000 s at queue
> depth 4.
> 
> [...]

Applied, thanks!

[1/2] selftests: ublk: don't keep the fault_inject timespec on the stack
      commit: 955cba87d9ed334fbe0b669b35b4abcddd7f9929
[2/2] selftests: ublk: make the fault_inject delay a pure timeout
      commit: 69ae59173a5668d015ab2733c8628ed542f00ccc

Best regards,
-- 
Jens Axboe



