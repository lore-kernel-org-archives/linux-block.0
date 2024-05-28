Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B013E3F6
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901049; cv=none; b=QFDKLBqUDtY4mdodwEj2q1WX1yoZCOaQ6d62WUCTJaG4J4bHyHOZh5merbtc6/MCHigQkVzuXcu8DSwCwrIq5mBwWWt2Lg6HUQL4yg4QeTcWfe8ArnIGtvQoyasu0VqiAJFQpJCU5vA8uVzAnB13tg9ugijxhZ/4M5ZRcM/uOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901049; c=relaxed/simple;
	bh=xckvGxOTg/lK5cif/dlUPP7K75rJd5o/fYmUcMKFews=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ckt/9P8cqGvg4bMiPqx4fvjQiRTpcPTnVhsPBKYbwzPeNSSSoe7dc6gQB3IngEbGZh+SQeiVVpCKhFqCEPGZdRpngKpQbcC4t+ESpNQhXyES48yOIZrpbubzKiWDWqSgczj5JBraVcQCuZSsIBe6ZvGxtGubCh9Ivzots11B470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iMpW2Gen; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iMpW2Gen"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f34d742ff8so383145ad.2
        for <linux-block@vger.kernel.org>; Tue, 28 May 2024 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716901046; x=1717505846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYN+y0FKjMiFfxNxeNcv+kisab5C54aEhDjwsKNvTjI=;
        b=iMpW2Gen0gHodQ7rui4bO9NiUyi4lixuOCHjIRMXBfAXcm49XBC2iUhJYpt/tBQV+8
         jLt4Dc1Ga1wu6FnvaEd89kVQwotiVafgINMeq/uciA2mKq+PBJS6aMLekXbU29wV2sr1
         Mw8XPvFdnpOo8FDVTdefj/i5WgqUZ1S8RZlUlIczPd6aIG75zz7KZa/O6RwK9S0GbZAc
         Hv9h2Abr2x+7Q9IogG5er9iL9ZVa6bkrL5+SWG45/CLCMvVeeb0B9PPXBTiv08dWHJzt
         A/xk9eVjOR2IeZ0/74ygyfxoQekLku23jHLDpQJocAdWd/ZSk37xQbbLyoNcYwzbF+A3
         QFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901046; x=1717505846;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYN+y0FKjMiFfxNxeNcv+kisab5C54aEhDjwsKNvTjI=;
        b=E/QsKK0c9mPTpwT1Qbl88uBKUxP3SS3AMjjnYQgapBsR/bOWL4y/DtR8AksWkxVGKb
         CdPcmYjqPUxCQITTE3ocIsd+KfUCpKtVkfJo+BW+HMNjMfqmVwtY1/PCM59QBW3JTOsx
         f8FnQihHtcD7nOQRn7wBd6Ktz425rWMXU7CXnNIXK0Tp4lC4fY7NWb6YriDdjOECL3qx
         ExIYd4xXmgPBosxALmpJzMPSqc6/x84/fm+FCpFB+qNaPh3QlOFQD+IUsCZdpGR1eCeH
         gF/3A1XnIEQQP2XOpklpKvVzycDt6ld8zITo0pEV4PiQGeGJU7sozOkUy3TfIZWkCFyi
         yXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcl0qdsPXq0jXhZEbxYqkRlJxfr5PF5GXVLUBUWfHp6i+XjqG4Pi/AHEBkaZy2H7nchtdmdJc0zI4XzZI/bQHKoZrjt2pu5Ltv5Uo=
X-Gm-Message-State: AOJu0YywDuNJGX0iMZIVMACrjWwB76+x6IL7LzsAlGJoLr7gBuDdBhWW
	7yMG0/a7UixY+CwcM1yl3jo89CuZ+tyQ8khyFWL3fgM2kfbRdC9SAn8pZt7s3XoLcX+zu76FOR5
	b
X-Google-Smtp-Source: AGHT+IHfg7PaOLjhcyBQZnYo0OBle297wmr0EK1KJxoXRsP4bx7sQyTPNGJnYx5ffb4QKpYXTHjyxw==
X-Received: by 2002:a17:903:2347:b0:1f2:ff65:d2e6 with SMTP id d9443c01a7336-1f4483e93e8mr136790545ad.0.1716901046335;
        Tue, 28 May 2024 05:57:26 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967ac0sm79255505ad.180.2024.05.28.05.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:57:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org, 
 linux-scsi@vger.kernel.org
In-Reply-To: <20240523182618.602003-1-hch@lst.de>
References: <20240523182618.602003-1-hch@lst.de>
Subject: Re: fix stacking of sd-imposed max_sectors
Message-Id: <171690104393.274292.7885096310356049183.b4-ty@kernel.dk>
Date: Tue, 28 May 2024 06:57:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 23 May 2024 20:26:12 +0200, Christoph Hellwig wrote:
> this series fixes a regression in 6.10-rc report by Mike when using
> device mapper multipath on top of SCSI disks.  It is due the sd
> driver not only setting the hard max_dev_sectors limit but also
> pre-setting a potentially lower max_sectors value.
> 
> Diffstat:
>  block/blk-settings.c |    2 ++
>  drivers/scsi/sd.c    |    4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> [...]

Applied, thanks!

[1/2] sd: also set max_user_sectors when setting max_sectors
      commit: bafea1c58b24be594d97841ced1b7ae0347bf6e3
[2/2] block: stack max_user_sectors
      commit: e528bede6f4e6822afdf0fa80be46ea9199f0911

Best regards,
-- 
Jens Axboe



