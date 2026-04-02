Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1683E557D
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135374; cv=none; b=CmUEmX0t7DaMJg0lkXEFb0kl5lyIdZygkY+XPhPfyduNJvQKfv64sqg05WTU9nFqY3ybC2RYf0cXBhLDlHpscWGo8Q7J1EeIVHOYlwU1Zv77G+HEM31w/4sRNJKffdwo7YAiFudO7DLj384uPVOuAhKtCp4ilNGQ7LhzULBzhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135374; c=relaxed/simple;
	bh=4iFix6D8C00qseOI7VMpapSZqyIO0esNsEJTNbeO85k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mpyk9xSbBHKwddebmTnON6BTGbcvBFcK/tItzHdTUUN9IHmcZvb8UtWgEkFcEsOUwmC4iJ0EYkP8+Vwj/OBcB7jnjdFc69Bui7ZbCVPaRFp0P9cb0ztfTbIYblz6oGzlmEit1VrOwrTyHsyYS6lNBZOzOMtaajzOJ4dCjbAn6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y3vCxsGP; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y3vCxsGP"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4670bcc40d7so267967b6e.2
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1775135369; x=1775740169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISZns7dWr0dgAWVKs0UiAOopA0bjHEqzp3XZWkBpXyQ=;
        b=y3vCxsGP4smeoc7THiwr2rZHVjV+9CZpgwMshTK7MxojWrM22f0xMTG/NjeAq6TSuY
         bp2e28EZBz2qKWdcLhFVNkjSoLVYDOZPn1E7DPNnCAWq6zNOafm/4OteHUZ8CDh/iV6i
         ca5GSe8HX3dSQ6htVGaJ457VT0i7PdifisR/c+f/US1z9IDvrbcWC6W+pin+7D9bGoat
         HlV3TInGd2Thi3xK9mK0oHM8HHDrfgqVd1Xe2amvLI0D4NEuUzMP9QR7wTIwbmun4ZAs
         +phEwwrIP//eoNHCyhJo4NEeqSxeL70CXGxWGhN5YxFyrK7/4OpkcX2wHN2X7ePyXeYX
         2u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135369; x=1775740169;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISZns7dWr0dgAWVKs0UiAOopA0bjHEqzp3XZWkBpXyQ=;
        b=e8mrdgO98CjPQ87nDvZI6v0rKYLngV94DPPV9VDh0OPv8l+0pQkr97KymmQ97xB7YR
         Crx6JLCXJ5Xe7N/BDuS7fbDzwiSogqUXvrEK6PnG5ZWkeXSPjoZP5COP3Egkc1lfSZql
         pdf5qxtDtXZwUk7cHNwfdC1/MfRU5FF2+C7aV2/+9q0/VX+QTCy4NKj9ta7rjHjcV9gP
         go0CRH2i3IEx7NUDMQhnQRFVEBObnlfI10Xkuo2U4rxLRMPWx27MMEYvefeSbgNJsqIM
         ZN++fuByjG81GvS/rv7dfRYsEl181AMnXspj9eerON42Le2huZyE1Aq6dthpyTfH40FV
         35BQ==
X-Gm-Message-State: AOJu0YyxaxJuMrmFYMkQX2H6Gsc/4zUMO+e9RvvWE5H9nw3Bmc2jj6jy
	GyYbKBYw5c3mb6AzTrw/jh5x2HY6g4VD7oXo2gLdAk8FBeRRanfpr51gWeQnjAi7y4Y=
X-Gm-Gg: ATEYQzzyahxZkeh23bLTvQGJ9XD2UlHwyP9lJGdroN6Cn/nSLWbhZ+4aOFjFQh/GlMD
	bab09/+c+S77zRTeKaS/lVm480U/Q4omyzs5WD2dKMt4eDw9YmyJ1dALoSV36EmDK5EzBhrxYpB
	E/BJUfrwhhaeMdXj0jd9IUMFJSVGWH+AAoPOe28RY0NIsYv5+rYy5tzgPpnlQMK0DxhIgcXvbFG
	RGcxyFwM1BQGhoTYoYbknkqMhGsQgIBtbc0qDOYHNDMje9dbTLWI1aJy94WVK+aMeDK4GhjRTCv
	1D3gpjyrnW20NvCuB+qnMG/1cWTzyBjErCi+xOniQscUKUl3twZ5LL/Tm4rgbJR4p5qFAvQtgt/
	o9sPh44EZ5Eu0bEiqMG3mqTUVVeajsfBM9U2d0g1w6lfY8OU0AVzCrE1Pt1cGRYu9RXUQM97aeV
	CsVHmZnVt6/TuzspCcmFa6TZTPq60XyeELdWPNu94VLA5lHqBfE7bt3oix5iTwFgOpA1cFCzt7e
	GMsoq3Zs7VYFeU=
X-Received: by 2002:a05:6808:3a05:b0:46c:cdf4:1bd9 with SMTP id 5614622812f47-46d87f35d56mr1758950b6e.10.1775135368717;
        Thu, 02 Apr 2026 06:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d9387a763sm1593841b6e.18.2026.04.02.06.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:09:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
In-Reply-To: <20260326144058.2392319-1-ming.lei@redhat.com>
References: <20260326144058.2392319-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] bio: fix kmemleak false positives from percpu bio
 alloc cache
Message-Id: <177513536759.175771.5675283254051100252.b4-ty@b4>
Date: Thu, 02 Apr 2026 07:09:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Thu, 26 Mar 2026 22:40:58 +0800, Ming Lei wrote:
> When a bio is allocated from the mempool with REQ_ALLOC_CACHE set and
> later completed, bio_put() places it into the per-cpu bio_alloc_cache
> via bio_put_percpu_cache() instead of freeing it back to the
> mempool/slab. The slab allocation remains tracked by kmemleak, but the
> only reference to the bio is through the percpu cache's free_list,
> which kmemleak fails to trace through percpu memory. This causes
> kmemleak to report the cached bios as unreferenced objects.
> 
> [...]

Applied, thanks!

[1/1] bio: fix kmemleak false positives from percpu bio alloc cache
      commit: c691e4b0d80be423f0a7443b53898eafe9c8754b

Best regards,
-- 
Jens Axboe



