Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEB332919
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458367; cv=none; b=bZeMewLv2Z3b6oEjvGEOqj78KF+XY1+cIl9vb23w7daR40bUF4RtSL7q8p8pOVpyNzhuDoS9Res9GiC31vXf1v5N9DQeQCcyiASRQAR1sRc8EtFfcU6UME3E4nMbIYYQXknnsQSBGn+2hk/JkfaCGx/Nmo1vu3NFsYGVL2W49HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458367; c=relaxed/simple;
	bh=ua6VJB5tyDKsmnYyv9rVJWdF3bpgeoaiBBktsJKkBuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gwHEyJoErQeOtpPkdjdolafxeuVnPh1IyPsQW/HhJNwOefN7uFXozt3IRt31NhZzEKBJ1Hd0Il7223barTtFemayXdYPHA8irNfPwxtDtlWvL/LmXqmFgrfK45Z/sPfgaVUZr9cAFBy2w4YeusErPUzBl0OZEHPmBjEMXxqUT/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=uPz/cWEN; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="uPz/cWEN"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dc3d28e2f3so1128246a34.0
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 13:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776458364; x=1777063164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDT8bT8MSQ4cYf6Thy1IrfgoCkqk5Jh1zEEj7NI5M1Q=;
        b=uPz/cWENaVSZOWZGzgTN+AChEeft178epOtPOeFrKi9NPL+vnV7Lg80wAkmSAZayS0
         ts/hlt5zwMkq8AuajEdWZXrz6boeItAh/h+D/9KqKYTS8hjrvE50haMODv+HH831ORdB
         tQvqKTQ35Kj3QYFBciRHh3+cvPAWuFkR3EGTycEApCw25kSR+xiWdlTVdha2k6i3w0NU
         ZvMow7U1xIYVsvd3QlwKvvjVI63HJtQJ0mLzGjA1ZJNV5T98IupZLqTE6fJfqrTuPdnp
         UZQTaLONo6tAgD9CMOogaZ9FQQ7pqC9HmhY4ErQFxFokOfc//TSiPlXYHN1+0D7wz97K
         MURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458364; x=1777063164;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JDT8bT8MSQ4cYf6Thy1IrfgoCkqk5Jh1zEEj7NI5M1Q=;
        b=o2V7XL8lZvuxJc9WmIgrN8WmCVJLxfl1GYD+lJRi0xLdNjRLehf6mL6fy23Q0Z+1R3
         KMzijyW91zOY1ltfdDeB8l9L/3XXlGubnJQ2vIXt6JqR+LyJvw1lp9BB4JSHbifmvst4
         7sWiJCkbrbljXctZCfos3nnzy6OiYgxtcdCyUQZu2A7B4919I5yO6PM0PKwtIYNK2uAl
         sHzj22pMr6v+8oqk19GRxi3kAZF7lwiyqzUb9L2ImTehRNLGaQldiM6obNho4do4UAcL
         YdA9RKEejER0GhGgzdqPbCjo0aIjqtKwXo7y0BjW0h6jg9oN1l040PRYb48av085ZFoF
         2Qpg==
X-Gm-Message-State: AOJu0YxFOpwCkuSQFREOzJqfPt58cnvNIbZq2C8uZiADzud8LICsIz7a
	G6Y4AyF8uyL2PV1gI1c8wd89vQrAPxd3dvMfXfnKnmMySTcN/5WqcqcahFzT2WaF1vI=
X-Gm-Gg: AeBDies1AqxIuaN+sCNHxTg0J1OCeuaOyiOwhSUZ9BUpSf2kyj9Rneo9sycD8hHx83m
	5giemQamE2vz5ixMn6jh6VCcm0QnYUzT+AKngETm+yEqV8YycA6AIJbiS2cE0xichdOydkRy37E
	vSHKRjoJeI9/bhERGrOrnOZPDpUEdz+4Kccl8wt5NixMBCGmWmObAcZUX+daW8e6/jMCTqHW9ZU
	na1/MtDcCFXJiqf7fTofDClZkuw3CwUjBqs4i2r5DZ/4nzPcIyYrWlNAFt7BkFes8oL5ZBxCFHl
	rYLP9hH5qlIPRsLk+ODAEaMvS6yUKxMUjdOgdthlkcgoUacVRqJiHROH7+GIBRzNKbPVmH9UfTa
	MPJ2MQ/f6AsNmq0BFWrwRYUYAXEeBD+KakhlcBDWO849Lzhiea3vuPMuqya+DN73P0bRdyULW61
	PZcoMSo1L0X4zEprGSlNCN4CmWksBpUCemfK+bideMS+5nQiNF9sHEgMxKq/0FMpOjNjQIt5P9I
	zdpFl/EkJOVwKg=
X-Received: by 2002:a05:6830:82ac:b0:7d7:ed69:81b2 with SMTP id 46e09a7af769-7dc94f95d2dmr2636765a34.5.1776458364707;
        Fri, 17 Apr 2026 13:39:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9759bfa3sm1926469a34.13.2026.04.17.13.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:39:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@infradead.org>, Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <20260415210847.1730016-1-csander@purestorage.com>
References: <20260415210847.1730016-1-csander@purestorage.com>
Subject: Re: [PATCH v2] t10-pi: reduce ref tag code duplication
Message-Id: <177645836379.906013.10998033895096140690.b4-ty@b4>
Date: Fri, 17 Apr 2026 14:39:23 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 15 Apr 2026 15:08:47 -0600, Caleb Sander Mateos wrote:
> t10_pi_ref_tag() and ext_pi_ref_tag() are identical except for the final
> truncation of the ref tag to 32 or 48 bits. Factor out a helper
> full_pi_ref_tag() to return the untruncated ref tag and use it in
> t10_pi_ref_tag() and ext_pi_ref_tag().

Applied, thanks!

[1/1] t10-pi: reduce ref tag code duplication
      commit: 2f5015461984caa8ebf265a60b22f38c94d9c70a

Best regards,
-- 
Jens Axboe



