Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBD353A72
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930699; cv=none; b=f8m1rYRUXu7SxU0Upsz0W16jMnWdgAuMLkF2RSvz91Qtq6W6VivN0Zuw40E0iBXIQS8LPas6WBH2QVdEzG18fCYWXDz5H+g0J3EWNW28QRY53ZUFh3D4hBFhE0WV/QxrupP30DTKgmTMFaYHO7q/e0WNksbiQAMLolNNG3E3ucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930699; c=relaxed/simple;
	bh=tpyZvgdIuReJeSrdOPCyYr8fsLpfLCii8h1S1BKcev0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvwY2xT7yRr6H24aRqVz0UfwjCJs4NvGdEqShArSnfwmLYXWp12Qtzs93aBwGC0DZliIe7nVxoTWPVKs5D/fnrXmxsdJw8vEz+kN7bzzelYhNOPQ5uVXYr1OxjWQADHKx+deZQe6NoOEQB1W9Ms7/rx2MnJS1DQGkwIyyFjP/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWTVVlBb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWTVVlBb"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39652a6e963so2163357a91.0
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787930697; x=1788535497; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y9a+pZojUOO4HpL0ROFDlkkfxxX7L9GiDlhrWObpWAw=;
        b=OWTVVlBbRUCkbMVkRasQwwDxPWox/hkiL5iu7d9S25HY2zJqkrIxjPXkQ8V6EKsGkA
         iJYENLOmUiE7+LwNJ+TNrlxyeViCzC4yb5e8I+wfHtrMDrE2EKU69+DUrseyp4rd24Er
         GFMavUJY+7oX28ge4JG1rZjcFy69hoTZQFUWKdSsHdw/3pmQZDqdaqb1fXRFQa7tz5s0
         q91km5mJ/ag9TgRTJsYqZpK1aNRhvBqsEbRTtMmj5nnyjvoUNskLRiPY4VHTKS09w6pU
         Jt34/k4A3EyUpMj8c9rWdiA+KYQdcp2Yt+4rEYgA091/eVQJAXufEp72Wg0vhyaNmJcc
         8qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787930697; x=1788535497;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y9a+pZojUOO4HpL0ROFDlkkfxxX7L9GiDlhrWObpWAw=;
        b=OSASFC6W506eSilifY89H8cTL3t7XxuND3TM1GGy2qhLclO5Iu3rrtshszQ0eG9mKp
         W6fxzYn+4ArChecRX0dSR3SjPJS+kNK6bOZoymURrif7Peu8jVXZ39qQPKw7z74Ajpv7
         JciQN/Ek/OR1Qz9TcSCk8VaPDdbGX3mX5iNb9fEr2IodwbepAyz2V8rBbcKUm8Tinxg7
         UfEjwX2Dyuqtkf6nHA0054FgMXNKxtjjZcg763CCUtHYv8DZ7U8yZC0LxLGBtcuyN4XI
         ve9SKBYR02fwJM1coyW60rYEM//XLMw/WrfzvWw+Vv6s1AsZdWLWHo3ZOKc9Rd6uIeww
         n8rA==
X-Forwarded-Encrypted: i=1; AHgh+RqcAHuKf1JLIA7Yy5+GcE4lX2B53CfOcYL1b/5RF0IYh8GcXFWn50e8LRPAKe6c30SKKyywFOaqx63Law==@vger.kernel.org
X-Gm-Message-State: AFuF++k/Wno7jyVUZ1lu285luj34L3N6ZXZotc0NKhF3TIFxFA/8Z/cB
	uTOwV3EXZd/9jHEC9dmMG1bydyZVHIzcWKzzcJ8PaSqq2xHGUZ0zO6wI
X-Gm-Gg: AR+sD11F+5f6iMSG34W7pCj/iOyPzRybLGaui05ACFC4Zsh3FksRS0pHrBppDqIsZAz
	N4RcsUtAJGCxPzoTS5qZsKdvznqXwrn7hB4d62a/5DLdD1uB0AOrm5M5xwjd4ImhiLXGYPhkn/d
	OxAwGhNKBaRsxR1yFwDb3Ai4WvnB0tqDQQ3qFZO+GgQDOxcu9LwpgtmpOkc6Y3gem1oC3HGodk0
	yo3suH93zX6/2kJ9UjYhUSASJmj98pAWKEYQW1tuj2B3WbHlnphesf277uOpKGh8BAXHDImiz1B
	yxTncctt/ME7PWNNfupt2jPKu+UfR3RnEtvX1VQtW7BrMgCIszRWO0/O3d2eq5CDeK+rkdJnLLz
	9GRDgR6danJQJvaw2NlUd0lMptABVNW7ujRBd/b+jjNJMzGD0fTYEhKSEwBG9z4IkJwkVG9zdb0
	S9xcjb3QQmE/T1Q0iLnoCENqnZDotz6dnMNhI/QS+RZeuBBKvdZrQjPvzZk2axCvoAP5Ulhkb69
	SU2N1AW/CzeI6rz8l5y1Hq2vUy75YFuHxrBt0kCfV3b9sEaabm5QG/O6KPL+LLvW2Ka
X-Received: by 2002:a17:90a:f088:b0:398:9beb:a2bd with SMTP id 98e67ed59e1d1-3989beba8bdmr429233a91.31.1787930696923;
        Fri, 28 Aug 2026 08:24:56 -0700 (PDT)
Received: from [127.0.1.1] (ppp-124-121-113-94.revip2.asianet.co.th. [124.121.113.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b0451sm7412788eec.16.2026.08.28.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:24:56 -0700 (PDT)
From: Mikael Etienne <mikael1022bzh@gmail.com>
To: Mario.Limonciello@amd.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
 linux-ide@vger.kernel.org, linux-block@vger.kernel.org
Cc:
 regressions@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [REGRESSION] Silent SATA read corruption with dma-iommu on AMD
 600-series AHCI (6.19 good, 7.0+ bad)
Date: Fri, 28 Aug 2026 22:24:51 +0700
Message-ID: <178793069172.1699234.13635367891277204598@gmail.com>
In-Reply-To: <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
References:
 <CAHEgv3TiJUvS=Hustyem0ts8jkbFVAdzBazmPhCbv2sNnTsZkg@mail.gmail.com>
 <c5c2b503-e273-4aa5-ad9f-f7afee02ab9e@amd.com>
 <178791494900.1152725.12728124457005560389@gmail.com>
 <fb875f14-3b47-4d43-ae3a-0d0b17e1c64a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 8/28/2026 6:22 PM, Limonciello, Mario wrote:
> BUT the issue internally does show the issue is specificially once the
> 32-bit IOVA space is exhausted.
>
> Unfortunately; the solution is currently a BIOS change in how the type
> bytes of the IOVA is handled.

Hi Mario,

Thanks -- the 32-bit IOVA exhaustion detail is the first thing that explains
the timing I see. My failure takes 3h25m of sustained reads to appear, and a
reboot clears it completely with the same kernel and the same on-disk data.
"Low IOVA space works, high IOVA space does not, and a reboot starts from an
empty low space again" fits that exactly.

The ASM1166 write-up you linked is also a very close match: a controller that
advertises CAP.S64A but cannot actually reach above 4 GB. My SATA controller is
the AMD 600-series chipset one (1022:43f6), which is Promontory/ASMedia silicon,
and it likewise advertises 64bit in its AHCI flags.

Firmware, since you mention a BIOS fix: I am already on the latest available for
this board.

  Gigabyte X870I AORUS PRO ICE
  BIOS FB1c, 2026-07-21, AMI, platform firmware revision 5.41
  AGESA!V9 ComboAm5PI 1.3.0.1c
  CPU microcode 0x0a70520a

So whatever BIOS-side change you have internally is either not in AGESA
1.3.0.1c, or not sufficient on this board.

On the bisection: before committing to two weeks, I would like to try making the
reproducer fast. If the trigger really is 32-bit IOVA exhaustion, then booting
with iommu.forcedac=1 alone should hand out high IOVAs immediately and fail in
minutes rather than after 3h25m. If that works, a v6.19..v7.0 bisection becomes
an evening rather than a fortnight, and you would also have a reproducer that is
practical to run in a lab.

I will try that tonight, with all services stopped, then the
amd_iommu=pgtbl_v2 iommu.forcedac=1 combination Vasant asked for. I will report
bytes re-read, wall time and workload rather than a verdict.

If you already know that forcedac alone will not behave that way, please tell me
and I will not waste the evening on it.

And to be straight about the rest: this is a production home server, so a
two-week bisection is a real cost for me. The reproducer is three lines of fio.
If you can run it on comparable hardware in your lab, that would very likely be
faster than me doing it here -- and I am happy to run any specific kernel or
debug patch you want in the meantime.

Thanks,
Mikael Etienne
