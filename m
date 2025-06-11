Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE7253F07
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645801; cv=none; b=CLL3ha1qQI3JotZX9Q8FnAcMprrqpm3gwYi8P3QegVK8SSUZ+cOmMUV7wafJQFaH7Qn9ZKr5kEV32o+2qPAqKA2X3l7Er5Rd4ocTEevySezH+oCc53BOvjkeAYJLogCbrH1BkxjvWyp80yZFR9kDgMnCJx/I3R8tD3MYXdZ4nAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645801; c=relaxed/simple;
	bh=Qb49olggyQSGwe+gfR2s9cZz3PYjlRj1zSFaElICUVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rZxo7J62+/IkBbWzYdOMw9vyBILLnOESmOO3S4Fl2Nyi6sd7CdwPrjMnmB6D4BpSkuf9ntIh0ba6HWBz3+EtCA5oURlIOc83gdKh4uhm3//8wxGWJw0tedBEZ+axZIHotaMPBxzZ5NleCpaVmaD/Vi7TZDWax4xh8J+us/ATHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vhA1rSs6; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vhA1rSs6"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86a464849c2so32663539f.1
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749645798; x=1750250598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKST6mGBSX61d2XIjdEN2F4ir22rk8694pIyQhw5jhY=;
        b=vhA1rSs6WW5t1Q2pO1TExUApce15s08fGJl6lDS8ufbpCMthO3NbIJoOOV8Hkyk6fr
         jsEfOpywpa8y9/UYoj5PSlUh7ir/Uct1ITiRMHNFeMXlC7xqyWCiVzlPFFPxo6usqi8g
         1Y4gJV0i6xsv8wECfRE5Uq9X3MPTB3MUGqqwtyMtlLiO8LXqu6dZCweuWJXYTiBkwuwM
         16hQR+LRAw6h8pnQJLAQkfm6tu9Y8IEfhkCqi8OFME7YiEXvX9BCUNVWqEA5nBnmLLDc
         P0F+nkTn+O6VL6FAYB8zR47Qh/Ca7dHr1f+2s0iTsRva9Dq5VZrIZ2XCHnyIg7XMe0P4
         L4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749645798; x=1750250598;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKST6mGBSX61d2XIjdEN2F4ir22rk8694pIyQhw5jhY=;
        b=FSDCqeegWi57uQ+EFldNpYqdxUDlaLmzFKm6hE950Cw2LTDk5VB7lsBCrPii52Ok32
         cHHhxmxUO3GkwjaxLW8jbxkz0XP0eE5+w1s17yt4eqRSIyBrzAWUH4KJuyKEA8Dbxbhe
         qRxnJGil2AsSdv8I+AmuTHXkcsXixAurTefJylwa2XYEK/ZNfrFRTKSYPh3kF6dPMN5t
         nE2tucj9WdSS1nS7sgiKQ0MO2CfrN5pVoqtbhB4/AZfXTFRyBD9TxwTPkLfW8XlYEPaa
         3fd4wKhBqbVmc/vGRwIojnJ0D8DN6jzSoZcbNWTSrAtLr1KRYJw17gWtH7BcB8tY6bv3
         wRtQ==
X-Gm-Message-State: AOJu0YzghOK4IggdZHnrEFvd8kJR2keDZZV1P951fhTx3TCJ139DjNrS
	Zwu/A4DiL2XfZcAS+c67bHaYjRlU4hmKaQFk/Uqvxwoo7jRE3sqEWg58IjrN3brb2og=
X-Gm-Gg: ASbGnctMpTeROrr85IvvmghRI/mStE5AHMQEBmx3EmPdRQEp7I08FTaSSOsWv6U7xbX
	N893JmGM+GOed6lTOw0lhqReCmvZteF4TIs9Hk7ynGOBIMeeLaJxpaBzta/IconPSxT5rATlgxj
	37YNAbv1QZC0pKfdysMUx2gpxuD1SBF1URgy1SSJ4AYCCei7e2zZvw5HsgoY9zqPIfTeFqRD43t
	qRPk8gt9WCKQX5CvDdr4YiRAW/CXBphgZZACs53+6WkYLzrfzSAGrMBNwWCPpc1bSBIfWbNM/JY
	7y0YTslUqZyb8zvWPB2+Yr49x0JTOYCKtmJY+EdSojd8WBrYvwVv9zZZWUFoKRrd
X-Google-Smtp-Source: AGHT+IGEFFIZZB2SjW05LCL4UJbP4iW0o3uz/hn/jRd7eS7kJdbkZcCkbCKCmRXG0OWfRquLli+wgw==
X-Received: by 2002:a05:6602:3e81:b0:867:16f4:5254 with SMTP id ca18e2360f4ac-875bc117836mr448738739f.6.1749645797858;
        Wed, 11 Jun 2025 05:43:17 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875bc585b5asm39495339f.9.2025.06.11.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:43:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250611085632.109719-1-ming.lei@redhat.com>
References: <20250611085632.109719-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] ublk: document auto buffer
 registration(UBLK_F_AUTO_BUF_REG)
Message-Id: <174964579654.357731.17455696249327428608.b4-ty@kernel.dk>
Date: Wed, 11 Jun 2025 06:43:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 11 Jun 2025 16:56:32 +0800, Ming Lei wrote:
> Document recently merged feature auto buffer registration(UBLK_F_AUTO_BUF_REG).
> 
> 

Applied, thanks!

[1/1] ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)
      commit: ff20c516485efbeb5c32bcb6aa5a24f73774185b

Best regards,
-- 
Jens Axboe



