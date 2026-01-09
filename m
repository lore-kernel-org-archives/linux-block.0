Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87032ABCD
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967078; cv=none; b=Hm2LslDJ+U4I2PGq6Vl9kWrXvBS4zJu9Iuu/3VjRriUIFrLw5hzQSV5U91cTYP63USaSMKIS+rMInb9a0YpKAr1/Be+D1AjnshnzPbt51ZVkV6wWPAZSpqYl4QK4+V6I7mta6ImphXkYTNvUswS1fVOM2+DsWAzhKOgfAnY6OeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967078; c=relaxed/simple;
	bh=4HtB0jh+7nB+B6C96V1W6l8uDFsOoQfvX1At7pJSzZY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JEFgJ//lRJFJzeMjUV+p4+21bPwRk2YjLXu5FG0Y9u2GIDhJh1tafYLlYumm/uBMqUKUvCzfgwrLCV7rh5KjUJMZgJhF6mpgI+/PTlWDY9XzrK8AaKQPtILdtUm89H+1i2EDMNZ74k52AumSTspG0cMpcW781Y64sEYFI0h3e5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fD/FoOmW; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fD/FoOmW"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-450b2715b6cso2552784b6e.0
        for <linux-block@vger.kernel.org>; Fri, 09 Jan 2026 05:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767967076; x=1768571876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cv8BWti6uYOXfSnsKsykd+RpRdPA26SkQqGy6H0DRQ=;
        b=fD/FoOmW4r/jUMbGBIb/93BoJnvIhc7tZohzVi4JKglK2QY+9NW37rbr1MjP84iPEq
         8ViRR08B6AmPMU2bsyLEUGPZwkN+NRedOncTvzl6uM51m0f2m/E/hnwxqCkoO+rP6fX3
         /bKsMybOihjGSSbzBSU5vewXG38Ca9CiKO6sUTBXHhkS3nAEAlB1KpdnZtCYZY4QPtdA
         BIU7a+TfRt52/EWA0kqJ78ZpekcU5TBHHAPg+xaS0Ib4zBhJgGkfJoU+dYeFCJh9KcBz
         mxq7f6+Cxaax8KPR1llHzriZbLWX5ucQ8mGik2wW0lBnLS9cRIzUJOQFc39wF+jOkvSv
         lxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767967076; x=1768571876;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Cv8BWti6uYOXfSnsKsykd+RpRdPA26SkQqGy6H0DRQ=;
        b=YcnOqTVWo+WUn2/TTXFC3rULdKUbbBOXzheUYZ6X4Z+3cIgOH6jkqKUKVNxQWbjfEx
         +sE01Pb0SolrVJs20aGOiIaicXjfLprt7AVXAZclVzvAN/D6Dc7v2HD2+x47wPBPBGWq
         RbZqBrkJczLXtxKFr6BIsk53p55GXYSW3rXTu/ZlpJRg1sYy08FjeG07CiY1cpp/DlUG
         3zThZnO1ap0KBKtJtQewe7Y6VkWWoMjUG3vI3h5rC+0QfAqg2s82UwQoF28qfBpfnQue
         wJ9NvaMnG3NXw7eqvBh/SsjlbAB26mLVZYQ1BxNlzJQywTjlfi8bZc6IqRE+ck2lt8IQ
         3SKg==
X-Gm-Message-State: AOJu0Yy16M03rCzq2uLSLbum+C3a53B8EdxEQour0mKjuhynCBrSBf0V
	mS+T5YGkeO+xHxMjQxeotj7i54xKHb1AsOY0WIhWJsoKujAm4H5p+SpIDoS24kUxZWE=
X-Gm-Gg: AY/fxX4z/1KAL+Xe8sqMG+QtHbD3Z1CW+33oQpm9QGcj6sDg1yHHtXVrWi5VXxRx8o8
	NcpCapYEy2FlBG2MZ8gf42iFmc1dS9PjD5kQTydgkPNRi3Cc+xn2oRtjkeGhadE5BkhzEo7Omi5
	iAhFVcdj50Ls9aQrTQDC3LJcM8DDJhAUjs7YKU3OfCyPPiDMioNLpgy3NBUNGZKGO8IGG8gDohm
	z3NXcNGAzv3J3bGohXd8zENgpq9a2XCvNiCegACkNs3Z0dYSptXLBYGsjd2uftcWl9LlXfI3xh8
	GxgITekVBpETucHrbHTj3W6c618U9o0pQiBhj4dvuRSbvEwAPlh0hP4akA9q4SxIllGkPcl8lJX
	oCPkZU8e1e7M004jcNDBME7Wf2mtaFye0rwkdzq1xPWGN8K7gAhvkJIcqsYgdJJsrz2SaD709c6
	V+Zvo=
X-Google-Smtp-Source: AGHT+IFglhabSi3D8l+iNxOToGURelM0HR+wMNQv0iqaJ0j0Aurx777iB6gMQhbq/HdCWb4/y/9C7A==
X-Received: by 2002:a05:6808:4f50:b0:45a:5584:b8ec with SMTP id 5614622812f47-45a6bedfb12mr5399887b6e.32.1767967076117;
        Fri, 09 Jan 2026 05:57:56 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2894e0sm4793950b6e.13.2026.01.09.05.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:57:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20260108172212.1402119-1-csander@purestorage.com>
References: <20260108172212.1402119-1-csander@purestorage.com>
Subject: Re: [PATCH v2 0/3] block: zero non-PI portion of auto integrity
 buffer
Message-Id: <176796707483.352942.3630670392140403614.b4-ty@kernel.dk>
Date: Fri, 09 Jan 2026 06:57:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 08 Jan 2026 10:22:09 -0700, Caleb Sander Mateos wrote:
> For block devices capable of storing "opaque" metadata in addition to
> protection information, ensure the opaque bytes are initialized by the
> block layer's auto integrity generation. Otherwise, the contents of
> kernel memory can be leaked via the storage device.
> Two follow-on patches simplify the bio_integrity_prep() code a bit.
> 
> v2:
> - Clarify commit message (Christoph)
> - Split gfp_t cleanup into separate patch (Christoph)
> - Add patch simplifying bi_offload_capable()
> - Add Reviewed-by tag
> 
> [...]

Applied, thanks!

[1/3] block: zero non-PI portion of auto integrity buffer
      commit: eaa33937d509197cd53bfbcd14247d46492297a3
[2/3] block: replace gfp_t with bool in bio_integrity_prep()
      commit: fd902c117e49eabbbbe70b1bde8978763c6d3fc0
[3/3] block: use pi_tuple_size in bi_offload_capable()
      commit: 0357a764b5f8f2f503c1bb1f100d74feb67a599a

Best regards,
-- 
Jens Axboe



