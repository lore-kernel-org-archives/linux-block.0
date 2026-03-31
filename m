Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFB3E2778
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962449; cv=none; b=sx46FjrZis3lgZTFO9FdNbQ+78Pd8l9tiB9kUmK5jYgA4fxuyuCvhpd4xcSeUGKxkZhbUNLywTRYly3NgmcW/mu6gubQusJxOU/0aKc8xpxPodXOwDoXlOlUD7K7o3kcACXzPoBBeg8F1+Z0XJXzmg5a2v6ddqm2CQKIIR/9kLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962449; c=relaxed/simple;
	bh=0YvO5ePCKfq01pLNRw3F4piPc8duELGD+Ki0RKgDjJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SagSRqqAWrlqM7vTIUkmAi+H3tTKFEaKijjwjICYlX8NyCnD0TBMlew3Qvi0ozlG6TTO7JOKKbp8wvdYz0AmWPprYE76wXpde7BIMfavU3I8KE8aw3meW+jwuqNs8vLhL9x47CTYqRS3IegRF7gScsLvTzm5hrvhuHTqjvVUJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b4yBbEyZ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b4yBbEyZ"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4be94eeacso5348559a34.2
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774962448; x=1775567248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYGyAXDZ3FeMXCQlfTBY4RmUqsZUFbsKlpNst+AMI1Y=;
        b=b4yBbEyZfq5eXFhJwZiGDFxp29BOEtVuJv7f40JcLX4dKlFWQYIQWPeO1EKj6rGSn9
         pCguJIXT/S9H1ywExSeXkWj9WjnwxqwFR9GUSApkLUiq+rLC8uqQI9r5IOkU+9mm9zE/
         yAK8YHFSAVTwvkfcK3WvCEhCJfb8bqtwwXS0hYSI8pKI9FJ92cqfNW5gqlxQ7xgsYts7
         AKdvap1srF5h/o/UGhGHdEjv2Y9atD2dn6jpRvfueK+sOHs2rKbpstzoMYK3sD5HpL9l
         /xcb6c9ho/zpdyepT8/4NvfrO5K8alUjvJJeGpckrcmaiU1W1xk4gy+xqfo87MiKiz4O
         ZMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774962448; x=1775567248;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYGyAXDZ3FeMXCQlfTBY4RmUqsZUFbsKlpNst+AMI1Y=;
        b=DzdGVXojg1E5lX+h1YYKiE/w1GJ6OOcthiDiZ2bqk5ZCAlcd3zU5J0g9OaTMb+/98y
         GcOMB5aRb4fbTshqwY9O66MTGFYqBbyzD9REMKrbxTMy0h1hoICjbvVqNYHfyf/k3toS
         S5vAp2+w6lncz6b6eYlcW+WeDlnXU5YkH/NjEz5KNnGsDtJdmbAj4eyDTUMOsyaSlHs3
         wBE+J+FFU7oAhH4WFtUhTR8Nr3gdp1HJpy5bBmCX/hg2MPK96tUTZ1Li6yR6hUIBMKCr
         sIGYkPQdqWK+J4rZ0AHASSM6maWV6bB1xqmNbraD6nzPOiek6C6AY0Q1Xwefj/Qysl3Z
         A9dQ==
X-Gm-Message-State: AOJu0YwOgqutfae37bhweEkUZC7snCMcixbkeFsVyuqYL91D8HP6E7wh
	cJPAgHNoUjBHq3Yf6Wb41qUsSaTxMYkJod8bbUggYNm2Uy6oVvL5CNwK+RQOAycc94k=
X-Gm-Gg: ATEYQzwj+FMq28Gh1Z7CU2T/cq3IT7aRuyyam8FctE9hfvuCTinPs4l40rXAnz+q9/5
	KA8FEpkf2N2VgS7/jLoPRt608HrolnvOtdluPpdnXvSMAsPsYGZ+xgbFfZ5PRDcJUyWok5bM+kL
	K2hA+oHNwb6GAgVmkBoKRtWjg5Ead5lYRwJ+jFsDYubVXZf6QqQI55LyzSQq0CGgH3IYkqndtzR
	P16MyWSaSSiWGTT8CqBOpgYJggHMCmy3yRoFzqWzZs+F+ZPW/nPtuR+PnUJGczRf9MXQMNgaZqm
	dQSABIEx0S88Mtff3LKvB+q0uQK1agztZ5s2NUjl8thQN/n0ocJp5QsaeH0ZyF4UZTmnDTuRhY+
	Q7DzkwTb0xMYADf59HENQtSCND7YKfdlBiEiAR1T3ehdAtTMP056VRWORhmERUnY+Um+l9u9Z/x
	Ix95YaZu+GfZzuzzViOl2b31XhBehSYxf/monVPDH17kE5S3Lt4L8/nCArbXzDpDI/wCPDOueVd
	n32
X-Received: by 2002:a05:6830:6509:b0:7d7:ef0a:1ce5 with SMTP id 46e09a7af769-7d9fad4ecdemr8800865a34.9.1774962447746;
        Tue, 31 Mar 2026 06:07:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a335414sm7901689a34.6.2026.03.31.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:07:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, Jackie Liu <liu.yun@linux.dev>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260331111216.24242-1-liu.yun@linux.dev>
References: <20260331111216.24242-1-liu.yun@linux.dev>
Subject: Re: [PATCH v3] block: fix zones_cond memory leak on zone
 revalidation error paths
Message-Id: <177496244663.811501.2963132010312539160.b4-ty@b4>
Date: Tue, 31 Mar 2026 07:07:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Tue, 31 Mar 2026 19:12:16 +0800, Jackie Liu wrote:
> When blk_revalidate_disk_zones() fails after disk_revalidate_zone_resources()
> has allocated args.zones_cond, the memory is leaked because no error path
> frees it.

Applied, thanks!

[1/1] block: fix zones_cond memory leak on zone revalidation error paths
      commit: 2a2f520fda824b5a25c93f2249578ea150c24e06

Best regards,
-- 
Jens Axboe



