Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C131A55F
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786966; cv=none; b=SaOtLwTAFrTOx0tOddlrbTNMjNftIyICf6fxxHQpjWTwl6S+PUPiwahLRhGGVUUpk+sB4jin3dtrCS1qt3aa9biTW79616n2WdAEkS73ftXhkEB75rQR6WdSpXEpE7CaXqEscNMVN2wqxAJbl9bUGMHBR5DqsdxUncKCI31Hjkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786966; c=relaxed/simple;
	bh=dRqVPcaZS29sd/em7Max0dkckXOqsZz270ytXfMTsNA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=A9Xx24SG1jxXPs4qrkDVN71jsQireeTCRfmfnKuk/yB5vD2bE38MMfjjGzeWtzhoxWVDMTSpD9mFu8xBk2FWK3+zmfaPgA0kvsfMeBav36D9ND4kAMa3HoTX3fIflpCHXV0kUdJJbTzlWYoEgKJevDEFMOb8Ax6BcFfvmgRekYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IZfXNbg0; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IZfXNbg0"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-663064bcb53so956059eaf.3
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769786962; x=1770391762; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeKy6M7r7gfxKyuYFmxJhxfTnzsc5fIY0z5kqhndfrA=;
        b=IZfXNbg0ocV+ZZWW4O0pr7c2W2/wkmTKHsX3hak++xxkgACviDonTDWQNUzK2jZyZ7
         7arO9GH1MhIqiPvljaYL1HxD6D5Vww1cVeurOaRPpzTnJs+zUJiecIN4LI1OQh78KJEW
         IrzcC/VPahmrka6N/0hk7iieMTnInUrsg8O7kc8EINUlgvqDekmk37NZz0/KRMZJ0ys+
         6BlzAef912pS9BfRFm5yjfwyuH7jyc6Tj/yW6RKfJaH18KBa6z3iu5GZmkOv1Lb+LyRX
         lP1n55yQQKU1oI+GGKEIx1b0cKZqs0Wj8bXVbwo7/2l7B0vZpVGqxHdhzR4LVzq4OvnI
         h9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786962; x=1770391762;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeKy6M7r7gfxKyuYFmxJhxfTnzsc5fIY0z5kqhndfrA=;
        b=jGTgJZiB4nBMSoadHXcViGVpse47PznJa9y+eLpjTtCP2evXUfAcGysMyK995AFgHt
         pvc78A5aAQhN7UEtmjjo+8BbC2VUBxO/Nzr3cgySHz8aKLvwsPmDokpj6s2dsLIMlnSi
         SdH2TCpk+zLyzQFj3rayK42LvskFYRVc8KAy0ph1YM9beuUPfQ3y4syJ7RqT9W8BRrrS
         5g6Kl5WO5LdSe7HI5S6yoodDJuLExwWM/sCcjrYWSZ4tmJGq7PdxiAyhFWAMQYlJeoB4
         /OCmb4yoBaPn+EcEFemDYBtpYAmuMQFEulyZLo3NcVVkh4iCEbN22zFZ6DFnL4ND6r+a
         Y5GQ==
X-Gm-Message-State: AOJu0Yy3f8gPjhnO6K2BBYRCj8QVLyRLUvw7WrvTULpdq8yIFluw1BXe
	NJFL6+KyFOxQKSoNNs9GCNxyrB7/HlvS+IW7G4XjgrA5FqlFrl1tE3wT1d34eSqGpWNK2NW8Hx9
	UXrl+oM0=
X-Gm-Gg: AZuq6aKzg6/N3zzHA/fr+I9JLC1YNX/vLTbTtSnhH7JokeQOwUNT2ZmqaRGaylvbGdv
	yiOA/Jt/dFcHvbzRBECmoc9FGhYIdN5jKRN6ms8U4GhPQ4uBU99irrCx7LB4EdfcjVEIjFgIErC
	bnv2l4StJrpx6FjfnM1dHehv5DFaomqk5b+tDrHFOb3kwojrFqNVAFAN946Z+rATwMh//MTGDsi
	zhRS+cJerga8sGp8xNoA49e/p7PRB8V6YrvBZf/5TU90op4UTrOz19ic88CiE2aaVB+LnOPKizk
	kbLrvTpfAB3IXPy/xJxGnqCER82VmttDevzHMi9Hk4JKSTFRAcS+MCjz96bW1GNie0Ds8EdjbP3
	SlUCM6qz1q3HvssMZolMKAsv8QPav++DxYu+vXOJQdCqdMo5IEDOBHY7cZ4HfMlqpkR49RtnmOs
	VrXwKCd4DSjME9gq/Ut7FO6cGYNs0d49guW/OdNbOteY9FIMdM/jhuTd6qK+lB0Uv4e9wT
X-Received: by 2002:a05:6820:205:b0:662:bf9b:1638 with SMTP id 006d021491bc7-6630f3f1bf5mr1752775eaf.62.1769786962334;
        Fri, 30 Jan 2026 07:29:22 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662f99655fdsm4941706eaf.8.2026.01.30.07.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 07:29:21 -0800 (PST)
Message-ID: <33de2c33-8142-4909-afdd-dccc8981b3c8@kernel.dk>
Date: Fri, 30 Jan 2026 08:29:20 -0700
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
Subject: [GIT PULL] Block fixes for 6.19-rc8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a few minor fixes that should go into this release:

- Fix for an accounting leak in bcache that's been there forever, and a
  related dead code removal.

- Revert of a fix for rnbd that went into this series, but depends on
  other changes that are staged for 7.0.

- NVMe pull request via Keith
	- TCP target completion race condition fix (Ming)
	- DMA descriptor cleanup fix (Roger)

Please pull!


The following changes since commit 3ef825dfd4e487d6f92b23ee2df2455814583ef4:

  bcache: use bio cloning for detached device requests (2026-01-22 07:24:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260130

for you to fetch changes up to 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:

  bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)

----------------------------------------------------------------
block-6.19-20260130

----------------------------------------------------------------
Jens Axboe (2):
      Revert "rnbd-clt: fix refcount underflow in device unmap path"
      Merge tag 'nvme-6.19-2026-01-28' of git://git.infradead.org/nvme into block-6.19

Ming Lei (1):
      nvmet: fix race in nvmet_bio_done() leading to NULL pointer dereference

Roger Pau Monne (1):
      nvme-pci: DMA unmap the correct regions in nvme_free_sgls

Shida Zhang (2):
      bcache: remove dead code in detached_dev_do_request
      bcache: fix I/O accounting leak in detached_dev_do_request

 drivers/block/rnbd/rnbd-clt.c     | 1 +
 drivers/md/bcache/request.c       | 6 +-----
 drivers/nvme/host/pci.c           | 4 ++--
 drivers/nvme/target/io-cmd-bdev.c | 3 ++-
 4 files changed, 6 insertions(+), 8 deletions(-)

-- 
Jens Axboe

