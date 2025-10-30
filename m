Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98BB27CB35
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836010; cv=none; b=jFTxBpKOK1hPUGCe5nmU7Yx1ZNor6nPA2T++stI5fcVagLYOYYXxHzbrZ47HFcFZhfhOGoZCAI26cAFWvpjtZm/J63ZsBPos4hQmuiCJvXANFI0Iic1n+p6xn4ghkzouI+8mcm8nWYrpKtvGisDFl25dBY2R/i9xmoS36BnQJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836010; c=relaxed/simple;
	bh=8t7GM5tM+1DuMZsn4o+XNbjnRhGNosioKoCdQWVqFxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TaT+69haOVMQPtvCvnQlZFy3db3LM328nkPewp+Vds6m4A/XhRF4/l052YnSLCnhCVO+j1wug/xBc8uxh1a10ZBPIiLySDqEYMXKtN/pco4xcH1VS2VcBodIicBDPmX+g0fgIaLsxpPxmEA9UiZ9QPdOwgLKRYOir5psWQF1hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UYpe+p0y; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UYpe+p0y"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-945a4bfd8c6so110469939f.0
        for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761836007; x=1762440807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhFqOAu+SptPiMypMtMUC7gxnfIXkWmUDgfnsfiJeSo=;
        b=UYpe+p0ylvNG+Zx636OTZaqc8wwZ54gKyozmaiporS2ndMwP1LKBhQ954CC9BW0Ue/
         XgTBbZkjsRMvuJzDbotcMrZTQqCsAOv9bMV8YFSLqaat9bNnBz0lA0DaxMF6e25Y9esR
         pgZgzrDXRNJ8Ab0D0EsozzISxnjhjjSfTr8zQdq2u1HbUrkiEGJPH+wci1gMdjdGQB6i
         3atsjxA3vxTLxywzrJa55ErsBN6sFgNlVZksNEfyu6itXGNC8EZHVN3lQ5jnfPTyisPC
         +jdti6uW+tmgIUVn9EhY7hdyl0aXmOwYYeR0oodMFOnVxTJlE3VXxu42whCQIBsLax1H
         1HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761836007; x=1762440807;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhFqOAu+SptPiMypMtMUC7gxnfIXkWmUDgfnsfiJeSo=;
        b=u3kFCwUsns0RA5QIzmn+DA2tbQqYcZdzrbqKZALSChKmygYNTEVUaowKGbbwyf88cH
         TkYDCSt84hLihhttKQd0noBDBY314BpateP8lB1zU2sS1+/7r730ntY0PZuhYClHXcKM
         QdYsXR4oPHB7HI3uccprmfjMFpGM9ag9sUMCDaZcLSTcebBJHBe/4UVOQ2J2cEmXFOTk
         v+gfKv2f1AFCfu0a1UUitobTjJsjZU6GbcfPprSTX38iWcucC9djK6uktK6w21ZidT1G
         L7nz/ABy1GXCerEY74P+pmFRgeKu+udV39SeDIPxsX9bZtbuBcUWh6+kWFCLrr5LCJU7
         HUDA==
X-Forwarded-Encrypted: i=1; AJvYcCUAA0EzhciP82h/p/gvLp8NZhzMwqCsMMU1GsGaUXGsUEAtDua7FrVaThlyiFdW1OU4hpVYQLkf8M1djQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyThpbZTDa+a5nFV8F9fa7NEoTlACTjhnbns0BwoqIK6bDme/DA
	SVpMqu4mKlruXy7sZX4fQUoiWyJphXiDkXs5Ae9iURiRjqW22pVUDKEd4GO2s9CuIHE=
X-Gm-Gg: ASbGnctAWKAMpI5bq76cBLWPOkOmgrEcphqqHZYIG9bcUXaYgRAb44hFhwSYRXaO9VU
	u8AQhB1tvgup6iMHfc1YqSC39XLJp20rXzNYmrdl88dukhAKgi2fKoI9wmbetkVlKJ7lw+Mjg4x
	8Lw/2H+Zz3x9WP/fh9CWODSgvitRZqlXyuYSvXQZ+TGTFSwL5c/Eyc5DEWzM91AZB5I9EEJaFOp
	aHzO+c+ogmllQ64Jz3YVAZpOeMIwdd+nfnAj8ICsQ4dG3lGYYwC3oFO2QkTO6ZWn8tJS1QqbNtQ
	cu9gJEEmg0K2cmXJdkjDliLGFW4ekv04D+5+BK0pYrE8EQUm4JwwViKdhvuN9SafSmxXnqRq5mX
	l7q0SBqNs8YcMbxEDwutXJzHPL8d2yBW02syERls3hcuVDh7TXJ5ahF7KbhLLBbjV20Q=
X-Google-Smtp-Source: AGHT+IHNlKNMhCpyTtQzUmP3QP/dmhwiVONok4m+6Q2KyoJswy7Kr43AbKYD7+R+w2StW/PfKdt63A==
X-Received: by 2002:a05:6602:6b81:b0:887:6bcd:7471 with SMTP id ca18e2360f4ac-948229f0c6amr10820539f.11.1761836006910;
        Thu, 30 Oct 2025 07:53:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea946dcefsm6758554173.33.2025.10.30.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:53:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
 Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
In-Reply-To: <20251030043919.2787231-1-cmllamas@google.com>
References: <20251030043919.2787231-1-cmllamas@google.com>
Subject: Re: [PATCH] blk-crypto: use BLK_STS_INVAL for alignment errors
Message-Id: <176183600614.453980.5145160114396578208.b4-ty@kernel.dk>
Date: Thu, 30 Oct 2025 08:53:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 30 Oct 2025 04:39:18 +0000, Carlos Llamas wrote:
> Make __blk_crypto_bio_prep() propagate BLK_STS_INVAL when IO segments
> fail the data unit alignment check.
> 
> This was flagged by an LTP test that expects EINVAL when performing an
> O_DIRECT read with a misaligned buffer [1].
> 
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: use BLK_STS_INVAL for alignment errors
      commit: 0b39ca457241aeca07a613002512573e8804f93a

Best regards,
-- 
Jens Axboe



