Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5012433CB
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994015; cv=none; b=D7BcN+e1i+Mz/cXQxoFDDBXTuRYD/OXT6I3/1TeYann8XM86lE9NWbXhl0PHBBsRGYV2zOT8VuYfz3MsSKRGSi7tz1eHSSUYwNxRhlcfBKwu+gHXrid6M6UoCJrQaF/FoM6ymac1WX62mcdS0+X9YTJiUO7hW6RGvvS6f3W8+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994015; c=relaxed/simple;
	bh=ffZrL93oJTsYMKxnQ7eYUCisSmpEMzVujTTbvm3KV9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QIYLFO/zgjIw7joyy5Gk/qjaE8TtulfmhMMMqzyfsolev3d5qvFvOSTEMXexCofbcPEyMXuCIiCGywoNQOmleHyhYUwZxns9ZLkvLdtWtP1tz5Ag6TAVjioxGj/wuiuEh1kzmacpuEjenWDGT9FrXfuJNHmekvZjywC8XyJQJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dcgw3/Rw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dcgw3/Rw"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cfdf301fa4so5224235ab.0
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737994010; x=1738598810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScX37g4UMB22SFk1EjpDaEV/7JxbN0UVWumVF2788q4=;
        b=dcgw3/Rwr28qYxSLxqNMrCOdgYuZIOgQ6ykNCu2K/P0MYsDGR2ZlMRXXwpqOHpB22S
         ByVawiYI6EUO85O/OZg6FUkNRvG4WEcRlIYTOhALr+pMV08jiVWujJ/YeEK3iCuIBs1z
         TWc9KQ1w0/A4E35JCe7lOT/U8WnMk3NpL7Va1pwUqcZoxZtRYLLfUNNVPFlJk6p9BFRK
         cmrR66GFeWthCBLbk6ZjtxHvnH1F7n6AZTknyf+Oe51BbiIg1n7Mw8aNNU/Vn3CIpAGa
         7ab3K21G7EacwGJsxPG85+jqSPiKvT+uqA4Ut1shThYsq2EnTbKEiWZ/yl0XYrVFy8e6
         zC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994010; x=1738598810;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScX37g4UMB22SFk1EjpDaEV/7JxbN0UVWumVF2788q4=;
        b=Px10yU+P/+jVuEEVQ3gwPM0LBfKtgJj0Lf6IsvqZh5PzUAKvOeTZ0OIP2KvjeCYJN9
         yPVA/uPLgAq+5+GyKllIv+XvE67QzBTpDaVk+/QKqQh46kkNIn7JIvHrH2VKYDc3/wHt
         PRGdGF0xRgAKGFWN+ngMWgR1Xkg8TgVnk4g4z4+G6xJV1MdGs/dFlOXnCbH/19hYATTe
         qUeJvxzyvgInvsC+TVBh66NRFcFOcfNLvCdLYEIi/NQHbbYs/Bykv12ekzyCfAg9ek+n
         1yi5LY769qWJJ5IoxLoy2w4VryApj5iz6SOwfAXLUs28hVfXpvkc0Ie82IVkyC6UZY+Y
         Dkpw==
X-Gm-Message-State: AOJu0YyGn9hMUvfEap1rW5l1MZ9nxTB3BQu2A51S8m6ml4/3CBdw3NGQ
	krVd0SVRDRLvRp60bjFGQN3NnQdjRYkqxe/5KBrmlMSW52sZubaXbyITacVyH1A=
X-Gm-Gg: ASbGncvVpj/J40Gso+29DlUxnzThE9RdfrFU2us5YqtfFw0ZKVE04jWprAVNldjpwK8
	2lOqr3ajWw5pEWogXqc5WqqLopHE4gPrNCe3wpQzAAZwM8M7uLMeY+X/BWcZZ70Qw+ob9YR8wuC
	PeC4AAxaB+lDlPj+pGSc8PDKshLV7CcZp4csNBNPDkTbPZCfCNgIVeCka9BgCKz2IgLNFWkEg76
	xQkUq87QaMDfKz7X+PB9BJCVl4I38oY75lgs/RgF6nrMNv779HY15BSVyD+3Qjsi4mowusq
X-Google-Smtp-Source: AGHT+IFyc0j4t8ajzUK1HT+Jyvmkuwy//NtZsEhXSmWVJzkQmAnGiXgyId2pgsF6DKLA4JQtAKhmkA==
X-Received: by 2002:a05:6e02:1a67:b0:3a7:87f2:b010 with SMTP id e9e14a558f8ab-3cf743ab4fcmr308375515ab.5.1737994010624;
        Mon, 27 Jan 2025 08:06:50 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1db82486sm2621641173.104.2025.01.27.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:06:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
In-Reply-To: <20250127143045.538279-1-hch@lst.de>
References: <20250127143045.538279-1-hch@lst.de>
Subject: Re: [PATCH] loop: don't clear LO_FLAGS_PARTSCAN on
 LOOP_SET_STATUS{,64}
Message-Id: <173799400974.9350.16981827021602955933.b4-ty@kernel.dk>
Date: Mon, 27 Jan 2025 09:06:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 27 Jan 2025 15:30:44 +0100, Christoph Hellwig wrote:
> LOOP_SET_STATUS{,64} can set a lot more flags than it is supposed to
> clear (the LOOP_SET_STATUS_CLEARABLE_FLAGS vs
> LOOP_SET_STATUS_SETTABLE_FLAGS defines should have been a hint..).
> 
> Fix this by only clearing the bits in LOOP_SET_STATUS_CLEARABLE_FLAGS.
> 
> 
> [...]

Applied, thanks!

[1/1] loop: don't clear LO_FLAGS_PARTSCAN on LOOP_SET_STATUS{,64}
      commit: 5aa21b0495df1fac6d39f45011c1572bb431c44c

Best regards,
-- 
Jens Axboe



