Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29E3E1718
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354093; cv=none; b=gw8m4pkzl/Wpr02zE4Fz/QRWFQvdcRCzgHMmO0uafSCe+RiNEala/JDrEkRyxHzBZNx2ybEb0vfGNE0Lpd//RNhneYQcFR2XiQJgTpvITBm7FqgBDKGWXexuyMFdj9Lp30UQd3xYlH962KLJAgUhO5O0hTXYXjsT5UeWve9MKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354093; c=relaxed/simple;
	bh=RKzgdwxgKthaxdR3OVgCKwO7zeM/hLE3c9ApZM6vJMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FdB+qeItwdvfTAIVlzIYfOBp5aQl5z4EIWF0UJ1D0k1cdytofPF2d005mTP6cMRlgxpkqr951F+yLXrSm1K7DOj7uxDMn1cDmBVbXMBaNig4CU8gDTZspUhkuYEesnX/rqP/d/K4hP+T4dk9KgfQRo2px8fhrdQ9CT1FrRWTF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Kw80x6R3; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Kw80x6R3"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6cfdc8382so1465898a34.2
        for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781354091; x=1781958891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7swAtj3G/hGrSza2n1NGxMHxco6j6Vf20RGZiSvZ58c=;
        b=Kw80x6R3pjpGp8sdTlOsJz7YvGc7PuQp9haUNVqjwdTjNQ2jlU3pmeSC+84sx1DeIF
         B9ZZq+yeB8I1uIGrL1GMcbVylvW2eXT/Zl3m6lCFQtHbaLuib4agxwNuJY90LkxduC5n
         Df1Wj5IeHB2m2pyh7qEN1psFc9uwoLgBKphYDVe4njEj/vnv+OXQV3ME2HR6CVnTW2Mc
         /jauRr8JJy7yMgcSffVjaPjPRyqIK46k0UP/8suMzXjVkvyaUuTvxo39S5AD8OMgaYwH
         Ge7lHxIXh1mKJVdChtq8NztEL+Xt5Js3u+3tXkiqkKS0WLznDQ9kguRB3xwP8wNhar71
         Rkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781354091; x=1781958891;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7swAtj3G/hGrSza2n1NGxMHxco6j6Vf20RGZiSvZ58c=;
        b=OxOPEkyD8Z/OD6xgvo+fE0MIeZ0KZeepnnbiruP1VTWeBsNEilEbVvs5zXs4zmVnHc
         TojzTBysLSr3PwNLvnS8dKiJM7TeA9c5ywbLRsvZTv4LIFXqecIbo2RXVkE1BlfqspwL
         c015tDrkcVp0Rbo1r++1DgOwdZspMjx5lAFXfdEV6hueCjZZB+9i40/COYB8dlFb2Yoc
         XpnrVy8/5TDKB0rIg3i4VFJhLfMQiD7aF9EWFIwLHdhpWPmp5CrVIHgG4XgH9HZbO6dl
         fmB7XD9xSE9FiNU41zJ1CdrE7lgsyYHljok7GEAjdDfAbSKxv1S59ZAkoT95k/aMCJmp
         ja5g==
X-Forwarded-Encrypted: i=1; AFNElJ8OqLu96/0lnSFsBe+ZUPqNiHNZecXybwU7yAnWXhx1+qC1XnTCnBYBdJ0jYz2XgA3vrCnsO422w7lXxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRLtZU87bNI3GdeKl4X8rdBG/d7y4zU33XfDeapFa2yix1wOP
	xSFSWIu13+8o17bT6aZDxa/iJNl5s5hWr4VaM9w5hmdEVn8QS1TdlKoQFC+l5n4oD+g=
X-Gm-Gg: Acq92OFvgnYkLRdpPuJge94umsKqsKnCEv0W9nlz163elGWj4tMpdgExPYa3SxK6CeH
	HqSlrKcD4jpi4ZR23ZCfuvwdmFW+9akD7Eeza+4D/mcYj0xW0wmviG1LKLUvdKnwFxtAxCiDz3J
	FZdWmnB+QCxMx2z3NS5+VcHmCDA9jjQkbW2yjs/jfQSu/EXNTZDX3S7qKu9TbQ6TnNNUV2c5oHm
	KbvNhF+s3XMdI9XF5Jb/aRxuHsQCvJrcIhCfq7yKwJjVpWxDFZabIxAoptHx5lXYJRVi3JBd3yP
	8Mp3wL3GBGnsuZwX1RHfm4oelLSfzrbAkaaKG1NelvV+yUJ3VDsHSdALuAOaBXC6JR67wUdGnV/
	7b6gAr8nlcTC24KCY1YXjV/dpptxSKx38tigKNia8NOjq4+0zGrj1br0tXmn4YWtXkgIAusn5p+
	nYlMmEt0hpMVH5pD4r05h7GOun9wvV4tiXo3N4YkgKppVTOw7GAeITrx1s0WKkhKATXr0Ft2gx9
	Uki
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id 46e09a7af769-7e7848a9e26mr5033267a34.24.1781354090874;
        Sat, 13 Jun 2026 05:34:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e781740de4sm3960977a34.23.2026.06.13.05.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 05:34:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
 linux-block@vger.kernel.org, nbd@other.debian.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
In-Reply-To: <20260613042619.1108126-1-edumazet@google.com>
References: <20260613042619.1108126-1-edumazet@google.com>
Subject: Re: [PATCH] nbd: Reclassify sockets to avoid lockdep circular
 dependency
Message-Id: <178135408918.1902132.15354673921815927532.b4-ty@b4>
Date: Sat, 13 Jun 2026 06:34:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 13 Jun 2026 04:26:19 +0000, Eric Dumazet wrote:
> syzbot reported a possible circular locking dependency in udp_sendmsg()
> where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
> can eventually depend on another sk_lock (e.g., if NBD is used for swap
> or writeback and NBD uses TLS/TCP which acquires sk_lock).
> 
> Since the UDP socket and the NBD TCP/TLS socket are different, this is a
> false positive. Fix this by reclassifying NBD sockets to a separate lock
> class when they are added to the NBD device.
> 
> [...]

Applied, thanks!

[1/1] nbd: Reclassify sockets to avoid lockdep circular dependency
      commit: d532cddb6c6049ced414d64d83c6ce7149a6421a

Best regards,
-- 
Jens Axboe



