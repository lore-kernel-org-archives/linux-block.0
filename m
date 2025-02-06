Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73400236452
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856652; cv=none; b=oqqwAwKuJd4z8wzMGc+Zc3S0odhBqfOyItw5o7shIDplfFY0hZSWHnvaLiORita02TK7ZwEBWmI9L3hBKetwk3i4zQYvoy7pU/9Qwgl2S4iK6XQ/D5+ienxeMUMmx+MFbzT4iCjfdUPRG4AVyFW0YqDMH54CsgcG1b6MpDY5s6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856652; c=relaxed/simple;
	bh=5h5K8XT8H5Juu61qlwiMuSiMIZaPuU7UdDQB9tlkx3c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YieUTgxCbgSRoXXaTNfYy9MdNUvwqSY9qsEq79FCC9iKleUsoSYmBY0PghxEpXKupMaUwtkDRHX9KELSp7NLLVAbZnHLCFf2qo5GYmr/sagtdMkffQDhK/bz5cStYOcGgnaqL3MEi8f0Kj7pWonBcTs0lVpSJZMxOF2z/AZDDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKy5dtOz; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKy5dtOz"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51f2a445df3so153821e0c.1
        for <linux-block@vger.kernel.org>; Thu, 06 Feb 2025 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738856650; x=1739461450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LckZVIRxbiTwuLuLBkUgutD16hJuoMfzjaNItFXltSI=;
        b=XKy5dtOz+KlNC+1sp7Pa/MwaOUVWn2ABeX8dGqGO4FVnOjkCMreu0m7kI3X+bDlrVg
         kK60ZH33wpx80wVs8eLd9vkuBcWJdJN0x9KPBpmyZIm0YqjrT9eeHZiwArhHeuc6J486
         x+KZl74W8h09AU0VgAoEqRVDoCA6ZvHr0yQNPxpLd+9VcyPyZFKuLVc4PN56xxsRusMr
         UDxE9SFRhJeC2UOhK1H4QM3JXrMirus1wKsUcml5h/ApgOc38SHGiGmiMGtqzMZ7s4bn
         rqLxLpbPeZVGvrW4UJsqTKmlb0yrLyY2VtJ0YFGPOc5RTBwzGH3TUHErfNMUxsP9uDq7
         rdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738856650; x=1739461450;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LckZVIRxbiTwuLuLBkUgutD16hJuoMfzjaNItFXltSI=;
        b=s1a4a77zwHOYxSnd/0oki43Iw6qun2efN5STtFWC7KH8FHWZm2iEy/U2fW+HKV4N3h
         LLusaFzP+4FF/j+e0XoO5SRrhKu9M2tilCDNjzNtpcw7msuEPkjMmak0RuY089QtCGnx
         KSUxAAUQSTou5sDnL0Dp27NwC//al84wvIqoZXT8A2PbKe5oBmqPYhSD/xkCOFlY0D9x
         WqYJYkenONgmPOgFItcjBwkS+7WJFz4Fn9ZlY2/xPuhMwA66hKfDOPwGAhFGqIb3mTwA
         xPs23z7YzPISE2RFFrWcXUYO8m5zw48G8+IUL8CO90t4wJWnEnyFiNy5KcR3EO9Xc387
         WN8g==
X-Gm-Message-State: AOJu0YwEOdTGgdo9xsqFBtb+gsDXuhSW9eh9vUsFBSIHr2+geews9oSR
	uvAlnoMDHlV4OLDx21v7M/IfKGtraDZc9WLXSo/73wmLw4HL8IG88mLxxmKA5xLiLLJHCim9k3+
	6HTxvv/OXYKKtshgAjUVeVgRr3q8Xv0uN
X-Gm-Gg: ASbGncv+PGgmvM54YJJa/zk7ZbVgJWiGqtfw8SneYeQ7gvFvkNOrv80xmzgQCtNRJC7
	j9T1Emn6e757fiYtIUGfBCLhfSyJBrmbIPQD624Cucev/jLEdUp3fIRRYmsB9A/mmJ9lSw2c=
X-Google-Smtp-Source: AGHT+IGQPi0zheb1EX+ik7M3MOcadNIHMNyQex/xJDgM7OD1lFMwtsJVAD+QtlozWQOziQmMLpQR5fdcwQ81PXNb0iE=
X-Received: by 2002:a05:6122:401c:b0:518:773b:39f with SMTP id
 71dfb90a1353d-51f0c38b5b6mr4549751e0c.4.1738856650033; Thu, 06 Feb 2025
 07:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Koch <mr.rickkoch@gmail.com>
Date: Thu, 6 Feb 2025 10:43:59 -0500
X-Gm-Features: AWEUYZkc1zpc86vVy2bZ2bzlD4kNcCn3mKgPy5zAwDDWWKci2O7BURdKGSg6hRw
Message-ID: <CANa58ecufBuySoAUSEO1ZgBSSvFgV5LSqOABwE0xGUOi=C3j_g@mail.gmail.com>
Subject: Kernel Oops in __blk_mq_all_tag_iter() using Raxda CM5
To: linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hello linux-block,

I am seeing a kernel Oops in early booting up of a Radxa CM5 board
running Armbian
on a 6.12.7 kernel.

I had reported a very similar Oops back on 2024-10-11 (Oct 11, 2024)
 https://lore.kernel.org/all/CANa58ee6EeT9V7Q=epoZdqYw3sLh1CZGNWqJ0UcKMp6eRfcd+Q@mail.gmail.com/T/

Which you had provided me with a patch that fixed the issue and has
not occurred again.

Here is the current Oops I am experiencing, maybe 1 out of every 10 boots.
It does lockup after this, requiring me to re-power/boot the board.

Starting kernel ...

[    1.582430] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    1.582984] Modules linked in:
[    1.583256] CPU: 6 UID: 0 PID: 46 Comm: cpuhp/6 Not tainted
6.12.7-edge-rockchip64 #7
[    1.583942] Hardware name: Saturn SDR, Radxa CM5, 8inch LCD/Touch panel (DT)
[    1.584557] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.585167] pc : __blk_mq_all_tag_iter+0x3c/0x274
[    1.585584] lr : blk_mq_all_tag_iter+0x14/0x20
[    1.585977] sp : ffff800082563c90
[    1.586268] x29: ffff800082563cc0 x28: ffff800081dd9c28 x27: 0000000000000000
[    1.586896] x26: 0000000000000092 x25: 0000000000000000 x24: ffff8000807ee3bc
[    1.587522] x23: ffff800082563d38 x22: 0000000000000004 x21: ffff800081dd9e70
[    1.588148] x20: ffff000101541400 x19: ffff8000807ee3bc x18: ffffffffffffffff
[    1.588775] x17: ffff80027d4f4000 x16: ffff8000821c8000 x15: 0000000000000000
[    1.589402] x14: ffff00010086e980 x13: 00000000000003e8 x12: 0000000000000001
[    1.590028] x11: 071c71c71c71c71c x10: 0000000000000ae0 x9 : ffff800082563a00
[    1.590655] x8 : ffff00010086f440 x7 : ffff0002feeecfc0 x6 : ffff800081df5558
[    1.591281] x5 : ffff800081ddd000 x4 : ffff00010086e900 x3 : 0000000000000004
[    1.591907] x2 : ffff800082563d38 x1 : ffff8000807ee3bc x0 : 0000000000000000
[    1.592534] Call trace:
[    1.592751]  __blk_mq_all_tag_iter+0x3c/0x274
[    1.593136]  blk_mq_all_tag_iter+0x14/0x20
[    1.593497]  blk_mq_hctx_notify_offline+0x164/0x230
[    1.593925]  cpuhp_invoke_callback+0x3ac/0x6a8
[    1.594320]  cpuhp_thread_fun+0xc4/0x1b0
[    1.594669]  smpboot_thread_fn+0x200/0x224
[    1.595032]  kthread+0x110/0x114
[    1.595320]  ret_from_fork+0x10/0x20
[    1.595639] Code: aa0203f7 f9427480 f90017e0 d2800000 (b9400724)
[    1.596172] ---[ end trace 0000000000000000 ]---
