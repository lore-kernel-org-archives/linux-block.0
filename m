Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99D20D4FC
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306272; cv=none; b=SN6d3uc84/KLGQXQ0ad9uzOKJJBsO+wqH6kTQDZ6MElYcXFhzvZ0neIAWz1IgrA6HTzhbjrHYcU7nuxj7RM4XCo05zUxX4yGMPUhpakEWBv7VCVWrMCWv3Uab74n2WwAV9g88T09NDRUQLV+UyfdwGEhFZyFp7kJwjmDJURew7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306272; c=relaxed/simple;
	bh=xb9WdjxEexZgfM3k9ipu2MTXGp6eGcSVjAkjuBZVpDs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WocRKlhfSpopWDwNz50dql3SN+YKPSKxDdRRRQZgSS64AyTbCs8S2mabjsjV29RefnIv+hhsBD6uVDvQxm4nEW8GUC/iDKMMP72OMZjjGn9bGtumO/ExBhtUTy05+pPA6GKnXMKN1SplRwHIKpUUcaD2sXvxmvQZOUbEbh8bmms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Dh4QxxHI; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Dh4QxxHI"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d44369e87aso18133765ab.1
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 06:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742306269; x=1742911069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvOvbmR6NQGDjpnSfgt+13JThVeAb9e7iy1G9pfLmLg=;
        b=Dh4QxxHI90PZmq3mqp1LNPe1F/TjnZyFMsOPKlUGfHl5YkXCWkytWN1GIxq/5az46T
         yhLuvnqC+D+UfXEvHmP9jegLIVESPWs6xVRb4dyedPagQUViZhX5izUHn8UiYBANkMCZ
         jvqYM4tL8IVefYwMdH+if4xxjRDpiJ3mr8pHhICOvZ3Hm5Bpg4KoOBIK4zg0sLtjC54B
         8NP0AKZ7OS9cpEdHkYF4uHu+3Ijk8k8GJFUWvIGEzI5Tg6+W/wwjlhtMcAONDG+miw+x
         YqdaznaZydvctcrQAWZy+Q8siR6iSeNHlOvqD9VCtlq6PxCgObspDNcinjD0FxejXS6H
         qAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306269; x=1742911069;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvOvbmR6NQGDjpnSfgt+13JThVeAb9e7iy1G9pfLmLg=;
        b=AfvmlPXphsQ67uYGLJNUK3q7KZU8S9PUhLUpArv1VuDodjmKz+5bFjWQn1BD8fyv5m
         UCkJxHKJHRUbQu+K9jManYCQ5UxEMyJByRHDCyvBTwLdBSos5WHZKmwVIgUJqOqbJ8S4
         ypJKUyKOnyZeO7rIJIPls1JGMOYAHN8M7mEvgvlrVYgGC3ar7oemzcvBo+QDZj/OEr9B
         c0UMMFImwLEA9p7PcXlv3+gmpR8l38Hdrspk0+V3q498Mkp60SGPCbdlUTYkbIo+/P3d
         gHQQb9nJOZMItthxo1J7s7+mzrQ8kX7fFzc/kLL8KDMQA4zFjsCVaTrcYERNd7UdnSSg
         T23w==
X-Gm-Message-State: AOJu0YzvmblxAmBroXFKXG88W6cmdMXRKhFScYOMP5nepN2UWD2RneC/
	JeQ23MP9a/noiWe+MHH3GuLtM3AnoLoYrGEA7zHHOavHbO1cf4XgLgmA9sKk/2ImFnnWCNqRo6G
	X
X-Gm-Gg: ASbGnctEQ+JFKuKtw0ZVDfr6+oYQovHtJXIWCYqOCQmeDsnBMsp4c+UXozvy1pb8cqT
	5WyGovXBQXqqJrWI30CiJ6iCuJejwR4QIyviM+nJ7TpAGsfgL7uNLKjxrbXZhxvKHFBOUg1i6R5
	ZG30fqvlY88SUlxKItItL+/UgkIwk7j7G6LcJ/TSwiWxpxRUn9iHn6Q3vzZd2kGFXH1v/9gXHaO
	XCt7OPbPpLrXrefE+UEBUndiWOeeo3Z3LZ1Wi1FoJcCNIashOoC7l5pZARoK2UH1W5eBF1wtYa0
	7aWgYqLKiGFLYNOgyMSnnq6PGri31XGyqE9q
X-Google-Smtp-Source: AGHT+IHSTo4Yxz6Emmj8UDXdqlLkVwyU5EQE7l7BjFEzrVx83+66mTGmPpOgNmV8CQE+A9DapoJXMw==
X-Received: by 2002:a92:d14d:0:b0:3d1:9bca:cf28 with SMTP id e9e14a558f8ab-3d57c4330femr28485225ab.8.1742306269307;
        Tue, 18 Mar 2025 06:57:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2638147e4sm2747321173.115.2025.03.18.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:57:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20250318095548.5187-1-thomas.hellstrom@linux.intel.com>
References: <20250318095548.5187-1-thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v2] block: Make request_queue lockdep splats show up
 earlier
Message-Id: <174230626857.125116.10538016841387488371.b4-ty@kernel.dk>
Date: Tue, 18 Mar 2025 07:57:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 18 Mar 2025 10:55:48 +0100, Thomas Hellström wrote:
> In recent kernels, there are lockdep splats around the
> struct request_queue::io_lockdep_map, similar to [1], but they
> typically don't show up until reclaim with writeback happens.
> 
> Having multiple kernel versions released with a known risc of kernel
> deadlock during reclaim writeback should IMHO be addressed and
> backported to -stable with the highest priority.
> 
> [...]

Applied, thanks!

[1/1] block: Make request_queue lockdep splats show up earlier
      commit: ffa1e7ada456087c2402b37cd6b2863ced29aff0

Best regards,
-- 
Jens Axboe



