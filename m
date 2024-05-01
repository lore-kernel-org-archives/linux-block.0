Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1B50248
	for <linux-block@vger.kernel.org>; Wed,  1 May 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572544; cv=none; b=LBnmclJLircsdSBIN/9V0C8Jg6+gCKZBunNzAd8cMsVuNml1wrFoK9SqLfk57rc147yVq3KCNW86KOHC4oxnEuIC4wCbOSetN/fxRkAhQG1JIX2kpTzSNxKQVS0sjhmk2440nR4+AtZ2oiJ/9lZPBBqug3oL9rvoOFslj8UPWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572544; c=relaxed/simple;
	bh=zfim7CcucR0BdncVSCbvZAeOm8GEIeOfwzAR5umcIkc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M/nVgm6J9q4kgeQBCu3Z7cGIkMo2JtQzJB8TANiDNh9VFtECJVWYCPQDAkuVkwMLxjcU6Lxema417CVdkGj5vVVeFubE0bwm3vmEN/ukgKo+zrN7ak3ZD7a/1KbJJimg0k7Pv5EbcEqQN9kNS5w64gBDT+446gx13v8Pvg4E1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H+2b3Olw; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H+2b3Olw"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7da55194b31so60585439f.3
        for <linux-block@vger.kernel.org>; Wed, 01 May 2024 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714572541; x=1715177341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fs2eFC9t4Ym2eJACriIJKBgSiMCMgOPbsLq77wPhjyU=;
        b=H+2b3OlwhuBRPoe9xGFogDkYbiakERxJ4vN9vsCVYyxPhKjknySMs1PyRXIq2iGyAY
         FF3fDqGcTIqrYX9JpOQfoJEZMKGUT6MdqGwXhfQ5W203Cc3HRt77vTnK2MJkg+W00cQr
         LlHX0dDNQ2klOFpTKnSOm1Oi23iFRamElWLzW7jwqpsx42NTdOc131R1HLNfX4Wy2JSR
         UX2lJSj0cd3wHUTKvA1Lop8VpjN5jmP0oiWPhZyiVrwwoyON/mUqiCOQJfLyw0i3rn5z
         8bC6TP9gyX+4DwI3Ozq2g+pgvh0MM0+Z37E3z7BAasPt5Hcuq8gXxvEo4whJp1sn4bfZ
         zx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714572541; x=1715177341;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs2eFC9t4Ym2eJACriIJKBgSiMCMgOPbsLq77wPhjyU=;
        b=ZXWMECA0tmNJGPaHHZFRBKcTJCrdhPDO4/0o00S5zprfmeD54+tQ3jiKY/oo+6rqil
         4DJVA6J/zQCoE3AoOlggu+YLTNc6VHPwVk8/ij7H9SnJ7dzRzYDpdt34LVm6XqUqOPf3
         KFJ2EeOiUvdq98ShJBIpRECcDB+zky+SCjecqjolmSSl00CC4ltlbmxUsULSNlr/iddU
         5LotZklTkIZX3geLVqEdWeY7zaGKxGw4MCUdbIQJpSCWtSdGv3w2N2pP5m+iSCuKrQSe
         JE7QNl7Am6ua8unufzaYTrCvj6CG6otyfw2y/iRj2LaYRJ0k5htBLajWky6SaRyqt+qq
         gQrA==
X-Gm-Message-State: AOJu0YyREyOMxu5AEHnoCs1MCKAGG13IyGa1EkCpLNXs4/F/4S2Y/AzV
	EfrTYAms9JYdnlUpuUZ2FpfhNKal0q8JIRXbnhQ2ml+qthSE6PzdEmSDOF8f9GM=
X-Google-Smtp-Source: AGHT+IElsxpRhoKMKje29Pm9oGG2g8KnqwtVCGQmpoAL/6gtj2Nhu59IqcMPZOXKkC2+KcYGUCAizQ==
X-Received: by 2002:a6b:3113:0:b0:7dd:88df:b673 with SMTP id j19-20020a6b3113000000b007dd88dfb673mr3481150ioa.0.1714572540629;
        Wed, 01 May 2024 07:09:00 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m12-20020a056638260c00b004881ff30b22sm260901jat.9.2024.05.01.07.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:08:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
 Mike Snitzer <snitzer@redhat.com>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20240501110907.96950-1-dlemoal@kernel.org>
References: <20240501110907.96950-1-dlemoal@kernel.org>
Subject: Re: [PATCH v3 00/14] Zone write plugging fixes and cleanup
Message-Id: <171457253943.85560.5028649665581943834.b4-ty@kernel.dk>
Date: Wed, 01 May 2024 08:08:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 01 May 2024 20:08:53 +0900, Damien Le Moal wrote:
> Jens, Mike,
> 
> With more testing of zone write plugging on more device setups,
> including weird/test setups (with scsi debug and null_blk), several
> issues were identified. This patch series addresses them and cleanup the
> code a little to try to make it more obvious.
> 
> [...]

Applied, thanks!

[01/14] dm: Check that a zoned table leads to a valid mapped device
        commit: 44cccb3027d4719c9229203233250d73d3192bf9
[02/14] block: Exclude conventional zones when faking max open limit
        commit: 6b7593b5fb9eb73be92f78a1abfa502f05ff5e15
[03/14] block: Fix zone write plug initialization from blk_revalidate_zone_cb()
        commit: 74b7ae5f48e6f9518a32f50926619eba54be44de
[04/14] block: Fix reference counting for zone write plugs in error state
        commit: 19aad274c22b96fc4c0113d87cc8a083c87c467e
[05/14] block: Hold a reference on zone write plugs to schedule submission
        commit: 9e78c38ab30b14c1d6a07c61d57ac5e2f12fa568
[06/14] block: Unhash a zone write plug only if needed
        commit: 79ae35a4233df5909f8bea0b64eadbebde870de2
[07/14] block: Do not remove zone write plugs still in use
        commit: 7b295187287e0006dd1b0b95f995f00878e436c5
[08/14] block: Fix flush request sector restore
        commit: af147b740f111730c2e387ee6c0ac3ada7d51117
[09/14] block: Fix handling of non-empty flush write requests to zones
        commit: 096bc7ea335bc5dfbaed1d005ff27f008ec9d710
[10/14] block: Improve blk_zone_write_plug_bio_merged()
        commit: c4c3ffdab2e26780f6f7c9959a473b2c652f4d13
[11/14] block: Improve zone write request completion handling
        commit: 347bde9da10f410b8134a82d6096105cad44e1c1
[12/14] block: Simplify blk_zone_write_plug_bio_endio()
        commit: b5a64ec2ea2be2a7f7eb73c243c2381e9fc1c71b
[13/14] block: Simplify zone write plug BIO abort
        commit: c9c8aea03c4ac2ea902bc7dd5ba14f5d78af8ece
[14/14] block: Cleanup blk_revalidate_zone_cb()
        commit: d7580149efc5c86c4e72f9263b97c062616a84dd

Best regards,
-- 
Jens Axboe



