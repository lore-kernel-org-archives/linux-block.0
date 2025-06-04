Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE92171A1;
	Wed,  4 Jun 2025 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005966; cv=none; b=EOtcN0HEHJngiBr0x3lkPAGdA41YvemLRjVQlLlVBz0diY1+yzi4KBFzli5s1rQnoPp34YU0SQ4SKbKl47SiVe/3uHB3/ZRFPIbUPVYPqxSZNTogb1J61+IagME9vQll4xD4Qv/tb04efRRyvWfTMFblLfMDn4kHB0Q/3gJKF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005966; c=relaxed/simple;
	bh=TzIfJSQiYccDaSYxU14uxVmwdxaEmC/dXhnVn6Nzsp4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=V+jqy59rQeMHw2lfditLd1EtNRfILM+OBZWLMlHJC/7PjINzDrEgjuRGTWYsRaE20k4StEQcDnWiQZ74Z1FfhGBk3qNK4REQ3F5Vt0e1dl6zGbs6AMJol2XxrFsnw7ERmTxmbidleJzTSEqlEBOCoXG3VwWOFVXhn0JoUT+3p0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfVfYm+K; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfVfYm+K"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32925727810so55703061fa.0;
        Tue, 03 Jun 2025 19:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749005963; x=1749610763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rt+D3Uf3eUUD4HW5vfHTNtXXx2j8DsAepkcRUcCnZqM=;
        b=RfVfYm+KQyOu7kVFxgwTYXRanrRAp836XE07K6k8r8gy86XBSQTkfZljPJbQYcplR7
         7/swiIDqY9yLl+kr+W3MKyfm2LOFM1TzsTaIN25ZiQX4RXvC4H69FskffeM5v96CkaFk
         6MOoustvJNLiDr4lYpIfKKE2rUtE41SMi/sSZWk7aQYNvM8TtKh46lx7DZeMJHGKLbPF
         T2TT6Xn9/Kff4o/7RExFrF0Knatt/0LWUh0/vpNsvQo8W/nNm1HeQgTjLJ/H+17mDFil
         N62EidjBo8osHqU/90gFnSM7zCbewIbqBumOZoz0FTRd1Wi+ZyEog2guD4JhwC+q4MQn
         tLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749005963; x=1749610763;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rt+D3Uf3eUUD4HW5vfHTNtXXx2j8DsAepkcRUcCnZqM=;
        b=a3PFRRWfNJgAnnMic9vPr32MFqMpy0HmBAXzW5ez8Y5pFZW6nZ7a87hOD8283uG6bi
         ZbOnDKF89g62bSZ4D0fEALCqjNMAztzurDqsxVj02aI+w79bVcS4dnjnKzZ0Ci+m7jn9
         WTk0V1ilaMmijQV4Elum62aW5ANDllqQg4Aj6bwDdBzo28gNBqSDkM9vrOuBR/J/9Kio
         CG++F8wt+9JYm/Ehx0CY8qq6VAb/U4xNdBslqjHcK/cozrNW2LoA49q6aGHrMYFHMqb9
         UGL4dzw8G3jbkQOnUizCf7uGgXIow6ZCEXF7HHmlstpYqy81JcbeFSOeYJhL4GESsJ7d
         iPVg==
X-Forwarded-Encrypted: i=1; AJvYcCWil84wrJODySdXRC2klcZa0j6UsoEBW49zpe6p5aGzx5mRQHWiPh/jYI6u3HvOwHBWmCc/2eHPdAdu19A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxpkR0/zStfH8oEYMD4r0VuDZsPaEgAg3tNaT3eyLi3PZ9Rx6E
	PGtzpU8dzvQCBv0EyNTJOp7Z1u77OhRI90IUPHqh1lkP/Q1nPcu3dR0TsvHuzW6i8SDqiR0Fy5O
	qY0KeqxkHqsZuc3OChiQ7Xl1DvGJatfU4ubgi
X-Gm-Gg: ASbGncupaoF8t8rbVRdNOM+ErAZZxgIVyAs3ofc5Pa8JTj+7ehp3d98gU7djBOtvGIr
	MyhLGEeg9Gy/ZO5H2XG6EsdIzFqMs8DUir+IQ2zaRoCcbBYP0XSkXD5FBHYMDLpPhDoYGs6ITvp
	ZD+x4x4THIYH/QfkWGrBsPhZN0aWuerHN2bvt1n4q7JFBwHw==
X-Google-Smtp-Source: AGHT+IGpADhxpISd06wLlevlEELZzMgnCLmJDRqqFzQ5oL0RY4VTWQo9W0dhgghHlRtrb6AuTYX9Hap9KM2OapJnhvA=
X-Received: by 2002:a2e:8a87:0:b0:32a:6ccf:a48b with SMTP id
 38308e7fff4ca-32ac7258d5bmr2066341fa.38.1749005962528; Tue, 03 Jun 2025
 19:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 10:59:10 +0800
X-Gm-Features: AX0GCFtnwCBZSk-d3y4Qa__7ovIgMlNq_oO-1gBs3-9Di2fZqeckIHPco1_CooE
Message-ID: <CALm_T+1JyGaNwvZGfue7hDt7q4pk1wdgC6R47GyCZ3exLBSqwg@mail.gmail.com>
Subject: [Bug] soft lockup in blk_rq_timed_out_timer in Linux v6.12
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Kernel Maintainers,

I am writing to report a potential vulnerability identified in the
upstream Linux Kernel version v6.12, corresponding to the following
commit in the mainline repository:

Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

This issue was discovered during the testing of the Android 16 AOSP
kernel, which is based on Linux kernel version 6.12, specifically from
the AOSP kernel branch:

AOSP kernel branch: android16-6.12
Manifest path: kernel/common.git
Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12

Although this kernel branch is used in Android 16 development, its
base is aligned with the upstream Linux v6.12 release. I observed this
issue while conducting stability and fuzzing tests on the Android 16
platform and identified that the root cause lies in the upstream
codebase.

Bug Location:  blk_rq_timed_out_timer+0x40/0x58 block/blk-core.c:392

Bug Report: https://hastebin.com/share/luqeturafo.bash

Entire Log: https://hastebin.com/share/oxihuwisek.perl

Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka
