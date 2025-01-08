Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D741A0730
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354026; cv=none; b=ra6HwRm80Sed6SJ126Dh7HhQPhPHVbMoUavEKNUiz4FqJfmmSl2tEQPnQmiadUCt6Bk2ZzbDm49hsvxxb2GRWvjJn0ecV7rqwL1egkcgS8OYyhfqkMQ6eZelkTNffpb25OAZEML9zBXjLD9xrrqJ3cp6YjiaLJKek8H/U5DjOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354026; c=relaxed/simple;
	bh=JuNFFq+4427zrEDjPFfzKLJaCDIxfV3MbqrZZxVP60Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jyTyOrANjctMHxkOD6aMpIBLpuSfZorEn37wXTZmRmOGyDSyz4bUmtFBEN5O0mEzvW6ZNuSSUHY7RPHNFjMcFqviE/ICevod9yhsGDE2eE2QLsGXCYUAXj4xMsTrwr5h54msahjbbnpnAt2f58mFw+DDlR7YH+APApNravcp7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNdd9sm3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNdd9sm3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso20350465a91.1
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2025 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736354024; x=1736958824; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JuNFFq+4427zrEDjPFfzKLJaCDIxfV3MbqrZZxVP60Y=;
        b=KNdd9sm3WWZRzzny/cyu0on6hED7MJExZanpEfucMWIfoxotBvUIP1uM4Q9zTb9I+a
         vYask53p9/j1bHR6Eu+iinXVB7Mhe2bYcFrhPBGs+9m38tBXEvTP3cxavv79d6ReMkYr
         ELHku4Ay4sX4ptIX4GhGcGvTK8It+BojCk3yXfMwtrhZrE7MjKdGGBbaKFGD6ds/mvQj
         Veo6oXCM9+ZKYf3nhm6CHqc0Rd6637fYS5uWx3I9qmf2RSa22GjoEqQ9mAq1b/FxQBz9
         ix0ZvdGC3DeN7CgjghsYvPchSMG4eHsJz08dweFIo5/rwZr/RyLoQQOyLDM/J+gWcmm3
         uYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354024; x=1736958824;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuNFFq+4427zrEDjPFfzKLJaCDIxfV3MbqrZZxVP60Y=;
        b=m4fAWAqUMkYffDL7owapN5OSC0+lbZbOQLMyk+Vvr2iEBmRMcIp8fnarS68yxorZrs
         EHNacgOglbI6CNb0I3j5gL1ii0KDEJgWaKhuPnVopX8RX8HUTyLs3t8uT5S3RAsP4VYD
         p7tfywlI6FA4S5Zy04DItfkakUNmcWtJW9yKX09/bQVNAIyb6nVFpoIMpRAJL+CPY+kv
         zVF0xNv2ki9XG+itt8EgV6RccD7awH9rD2vOye57e7K1yHEk2WLfvfTIGtDmrGxJrqNV
         hBEzU1aektngjzMxNVivc0gN5CmB164fcobpUOd81W9u1jCS56nl0Kv4UkqQGpjU3Hvg
         DKXg==
X-Gm-Message-State: AOJu0YzbASKlR2zp0YQF1iTU1FpOTPuzzuMpv/UzcS9e9pKYRbutPxjQ
	YvJtYjKlIXa7xVGplJB8GdQDQIQYeewkAQZzF97LwWtJj7twvjqBxFQKCcndwxpUWDKGSgQBGhN
	tXfdtmHVSNXk0+QkggHJ2n8+92gTgNQ==
X-Gm-Gg: ASbGnctwH9+x4pz1Hk7F1Rp0Tjb1ObjLL6zh5kcFEw/PZn534KzjgJNWSEOGq41R6Fd
	btSDW+7iu2xauwLE7+HJoYcTyrYegp5smgFkwUAU=
X-Google-Smtp-Source: AGHT+IEvAAlEWRhWzFbbw1qqf74p4N3VOFnruwa2WNtFp1WfS+M7lkicYmiPofLb/KB3ANAyLIFlj1r4bssr5VZTj1w=
X-Received: by 2002:a17:90a:c88f:b0:2ea:63e8:f24 with SMTP id
 98e67ed59e1d1-2f5490ee6efmr4211714a91.36.1736354023645; Wed, 08 Jan 2025
 08:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Travis Downs <travis.downs@gmail.com>
Date: Wed, 8 Jan 2025 13:33:07 -0300
X-Gm-Features: AbW1kvaSIq7Fw-BU0f8JdJHv8kZ_3nSpc3zE4FPh_XjF9J5bTb-KzKOGl41PvZ4
Message-ID: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
Subject: Semantics of racy O_DIRECT writes
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello linux-block,

We are experiencing data corruption in our storage intensive server
application and are wondering about the semantics of "racy" O_DIRECT
writes.

Normally we target XFS, but the question is a general one.

Specifically, imagine that we are writing a single 4K aligned page,
with contents AB00 (each char being 1K bytes). We only care about
the first 2048 bytes (the AB part). We are using libaio writes
(io_submit) with O_DIRECT semantics. While the write is in flight,
i.e.,
after we have submitted it and before we reap it in io_getevents, the
userspace application writes into second half of the page,
changing it to ABCD (let's say via memcpy). The first half is not changed.

The question then is: is this safe in the sense that would result in
ABxx being written where xx "is don't care"? Or could it do something
crazier, like cause later writes to be ignored (e.g. if something in
the kernel storage layer hashes the page for some purpose and
this hash is out of sync with the page at the time it was captured, or
something like that).

Of course, the easy answer is "don't do that", but I still want to
know what happens if we do.

Travis
