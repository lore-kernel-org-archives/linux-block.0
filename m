Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A922689C
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786849415; cv=none; b=cgv34gyXHSOKFtGW6lCGmTSQud4t4zE5Z6tU2H/Q78Tg3Dy7qMv0tRx3KOaKY02lM1KOOGg7MemQgkPLxAKDI51+eMOkQqeDs1owhhbquRhUSN8fOloI5hq1X/bVEMRaBQYZ3begOh4mCEFktS9eYkNVeHJks6cs9nmOn7F2ACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786849415; c=relaxed/simple;
	bh=9Zr3oCqKsjfKHvPkErESJvY3JHuOxioptcAeMnpZfJA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IX8qMT7TZSnl9gM63EuUzbxdT2Nxw4Luh2enjI8F17X8/QZ3zt/vAxbNPgdU4+rJqq5SL9NdOOnvlvq0gVTGsVbG48QcKn5EqQws9KyB6EmXsrCmt5PypSdo//+3XZcAuX/yei7TMu9LC0K/ry+csrlrBzQikgyJvuIK7AIRpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=AGuWaK9H; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="AGuWaK9H"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-6ac83a09781so2104684eaf.1
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 20:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786849412; x=1787454212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qvILHGTq6ALuiBcDr7I3qpZrjxscKNG6kSv9PiqDWtE=;
        b=AGuWaK9HEOggywe6RnhZJgyw+n6uhaETUtup3DOWJC8zB3Vfjod4JDLpvrgNWw9XPZ
         4qhlFIncGRLuFAEH/uLhBCr2AsdH2YlE9d8lW0//8fwgSrlG6C7crWq0RR5W/qSQ1TCv
         yXDyg4eFeNmw/p8lzVCE/17c9GFTeRQRo5KAHy12vv6+XuYKU5m3jQQ5XMnQwhaYjM1X
         dornVb/qw2nxQ3b7CpWaobk8ge31zNXA/hqYwpxjHJnaCN4vfLTLaWlOD52LRrW6FLbq
         vApLThApCa9rM65hJC+J5/oeLAiLWgn2MY2X4lYcxvHnnV4bkdO/c8W5vkeFDJPhCE52
         wWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786849412; x=1787454212;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvILHGTq6ALuiBcDr7I3qpZrjxscKNG6kSv9PiqDWtE=;
        b=ohPU4LbFx3Hs8uIOEZa33qbkg9GnSRQs5qowocMJ3AIrK71TYYASzZLygNBO0G87rf
         /x9SpFZxzq4Tduu58HYwmDBeNXa/cVtlRbvP+CaQ/2o99BYLlHM08pGmEBK2xkdV/lhu
         JC7/OT0DLBZrdfcIGVWya6Sj0o1/hfuKKCKuMNvfBcNpeWaWIlq4Uvkl2TQPx+a/jaRu
         XdiCBMNvptiJTb92IZGgYgTBS4fF1FW9XMb5C233MB3Fylc6UG9xX4isaaIgCJfpa08N
         OIcD5MvWpG+coIBu4D3JHa5SDFlBPjLjmuX+P5o44IS4hx4f9YquZOuPvi+Oz24vzggN
         uvqA==
X-Gm-Message-State: AOJu0Yyl3uzkEFF3CnUFxj6/298Pc8HAOGDmcst7AniKdVgWOwlQynkD
	8KX5I04awbvDhzoIHOD6/zaTEGe0eaKuuqB+1pZo0+hzvHT174Lbsc1b9tfmKVBcRp5D5wyJk2E
	72is5+sEjTgq6
X-Gm-Gg: AR+sD10SH7uBRbNVQzBKqJZ3JEVHUAm6oKwn349tul5L4AC0akDbaRfevuHUn924m03
	NnlzUsqTFD0wNoi2Gu00PK7UiRhVxbktPjmT9+dsrzH5Mu5iusm3IWTOQhNNeBAWVe19/DOPXyI
	cjvYukJwGAJjyqlXGATyWk/Qw+xOc8Z0hms3ZYRWWJWqTpoPvpUzip6SosiyEImpQZdLNEO5ewf
	6tcJQl6H6bT3x84yfTNCRYsV9Ton0esuHd9igIAqynul0UU6mcVv1ew72YYq75ApexhsV9H2Xlz
	W9vPsZkYTFLH74AFNm/c23zLoLHcQkoHHL4CbZfG7jJAVd7G5x8n5UbOldiTv3u2lRqXSivlfy6
	L7z+IfaZmFSvQ/dpfGOVhQ4eK16IuWccOTpHQueeTNEdSEWnypNhjLt0IqiZwrza0UuwqzRSlsV
	65nGMYuAq7RNhFqtDEAgb4DG3W/hlXk1ZEKEtMs3BkxpZ9nyGcoivkl1j4jLrg4/dLaFC3vaQcp
	P/2J18/nt6cLTunPH2gmr4iWai+OZx0q3aV95sa2nIFfjY0oBgom1jMgw==
X-Received: by 2002:a05:6820:f02d:b0:6b0:594c:32a7 with SMTP id 006d021491bc7-6b0c5cc53b3mr14893741eaf.20.1786849411751;
        Sat, 15 Aug 2026 20:03:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e8f9594d7sm5920240fac.5.2026.08.15.20.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 20:03:30 -0700 (PDT)
Message-ID: <503e7149-b7d0-45db-b1cf-258c02898518@kernel.dk>
Date: Sat, 15 Aug 2026 21:03:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 7.2-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

A single fix for a regression in this cycle, where drbd would leak
shared secrets over netlink. This restores the behavior to match what we
had before.

Please pull!


The following changes since commit 7f40b346462f563a0d6e841a77b5163d2a882a04:

  s390/dasd: Fix undersized format-check buffer (2026-07-31 08:28:08 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260815

for you to fetch changes up to c71bf113dfdf426bdaf106636f573ef87b6613a0:

  drbd: don't leak the shared secret to unprivileged netlink dumps (2026-08-15 20:00:10 -0600)

----------------------------------------------------------------
block-7.2-20260815

----------------------------------------------------------------
Christoph Böhmwalder (1):
      drbd: don't leak the shared secret to unprivileged netlink dumps

 drivers/block/drbd/drbd_nl.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

-- 
Jens Axboe

