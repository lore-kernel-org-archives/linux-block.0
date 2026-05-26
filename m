Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF43C584B
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832357; cv=none; b=hjGoIc3LL8kL+i6zttsItxPZBxJZ54Ih7JLZsmHOV8ABlIpOHIey68Jrld+W46cyRBab0uwBeZl20AdANO/EomXpw/OHy+PB5qXf4zHzY3Mb/NmJiONbGHWq0vNF6Mb0A+SVb/JUK51olfavFAOzlWwoVM/8JoUNzpfwvUolVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832357; c=relaxed/simple;
	bh=4NrTmsYwJJmQ5/ng8nsl+5S2O34t8HzC26mJd+ruPNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pSNexRtgS8Rtg/xq8gyt/lkF4Yqz3NaQBoRSueEzIzCucmTIvu8uUXH6/o5Uu7nREaDrb+B5MmZ+YmtoGuGNUCh7kxpEfCQvlRR7OP5RPQLO0UvTHrwbU8S8rAix6EJERnA6KI7QARaL3K61ru3lvvY9MTdfpOwmUZg+jtuHvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=w9IdnVFl; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="w9IdnVFl"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43acf1694daso6293238fac.3
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779832349; x=1780437149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygleTelCqI5oqapwk6Og8dhDrlXNgz7gDtcSwArrBbE=;
        b=w9IdnVFlWMtWJOQvUeXQp8ZP69zopJWnlfVQz5qR5vF2OVlPyXk222oWHWzxPBEtVN
         g02xQQr1PzMGpEcvaSAvW1fxbf5S/f7gUiMjEo3bfIStgyT73uFTtWeIuHvpvW0UovSm
         4AdLAME3Wo1H3vFDOY6dTnapYdASLFN/MmSOX7wt0fH5ZB+gey7DpJjBotICiDcSWLUB
         /UaoW5+GU9aNv1T02Ktml72uh28ET053FbcaH7IFQCjOW6fFRC47NSC9HlO3qrmNHmmg
         Z367Q5NAT5vUmUhHwqvezl0tlvlmtmRJGh4bXtYk6ZEW1DgDFqU0KpaV1z1grEaKLmJu
         4T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779832349; x=1780437149;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygleTelCqI5oqapwk6Og8dhDrlXNgz7gDtcSwArrBbE=;
        b=LdBUeF90BH2jJ1jymmgx8fw69mo0Hstrt22r56RuOiDWSbxrh6Mq1Q2N6v2n108UM5
         Y8CNLv/uDd7973/uKreL7sx95CpMkow/BXWgJp2C99b0G+vKWUvNRp6GTh+JjGkkqYsd
         ztgbHZKP5rYOtNjzJI6UlxxB7ExxelZKjEWlrDk/91OZmcdQAoxi8UkVwd+SPT+J9u6s
         nA1zDAhuqlMOOufg7n1krcNAY7Zl3+HOtELJOnv6G2VplFp0Qgg6gUHGU0N1nyQOohVS
         cLprZ+NhBhvEuA4nypJGxGd4XWuuHFzpif0ke+XFM/TKe96iuNNEc4LZ+QS4rXmy2HcM
         QIrQ==
X-Gm-Message-State: AOJu0Yw2Ox/6n6pWbtVK724O8gkaGii3d+8pf+7gBwWbqWsQ5EeSxqtG
	0mImeBEs7mXK2d4fha+biAAtfRexgCWZYchZnsCkk95R1JbORvhI8PM6N12mJ7kWugo=
X-Gm-Gg: Acq92OFn0HwzVPDcOClD1qmR2hukYpOvB0A0S2QC4R+hI+QbMEhN42tbtzZFOFnTc7a
	iX7b1pMORlLgzDFgJq+bnFw34TzW5S8ZOXjZDiE9eSavb1tZvRfJwmShrDp226w1eF6FNWble5l
	FXWsqn6BAGjiBpd4CnqrAGUw0cPQpJBv/IkaCiK77fwpb1ECHzcoJEJu7gDzZmsNXNg+pUsVdny
	wSSJ81CTk4iaAGiBQ3iwMnMy/rC4X2LF/yEl1CFnZ8aT/w/gvRvwCAd//3y2eq5TpgdjArdwb0/
	BJSOLPAmQvMKJLXFNcLgWBLN8KTc8P2SLfeX+lRkWGXJWzpg4ygh7O9fXZEjJTEaBqkAxu/HjX7
	RE/iiFXKp5FaaDKmdeO0Oc+fx/gjSwskkkizsw+1PF+EPrcibJvgxp7d5MHFENmaS1AFN7UuSS3
	7sE57MqUc60+vQ3Jjy36xFYZYVV+jVqWC4qceuyk87dQBlhptjJaVTo8uNFD8DuzdQ5mV7/VoIK
	rNlKbLwKrOrZg==
X-Received: by 2002:a05:6870:88a0:b0:42f:c1ea:f19d with SMTP id 586e51a60fabf-43b5aacfaefmr11826864fac.10.1779832349406;
        Tue, 26 May 2026 14:52:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639725a5sm14453746fac.10.2026.05.26.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:52:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com, 
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-nvme@lists.infradead.org, kmodukuri@nvidia.com
In-Reply-To: <20260513185153.95552-1-kch@nvidia.com>
References: <20260513185153.95552-1-kch@nvidia.com>
Subject: Re: [PATCH V4 0/3] md/nvme: Enable PCI P2PDMA support for RAID0
 and NVMe Multipath
Message-Id: <177983234828.663325.17778666619930426072.b4-ty@b4>
Date: Tue, 26 May 2026 15:52:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 13 May 2026 11:51:50 -0700, Chaitanya Kulkarni wrote:
> This patch series extends PCI peer-to-peer DMA (P2PDMA) support to enable
> direct data transfers between PCIe devices through RAID and NVMe multipath
> block layers.
> 
> Current Linux kernel P2PDMA infrastructure supports direct peer-to-peer
> transfers, but this support is not propagated through certain storage
> stacks like MD RAID and NVMe multipath. This adds two patches for
> MD RAID 0/1/10 and NVMe to propogate P2PDMA support through the
> storage stack.
> 
> [...]

Applied, thanks!

[1/3] block: clear BLK_FEAT_PCI_P2PDMA in blk_stack_limits() for non-supporting devices
      commit: 7882834048f110931275357db60dccff906dc96a
[2/3] md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device
      commit: 02666132403aec8fc5de315002894f713ef17dbc
[3/3] nvme-multipath: enable PCI P2PDMA for multipath devices
      commit: fb0eeeed91f3236133383445fee5cc8f20330e6e

Best regards,
-- 
Jens Axboe



