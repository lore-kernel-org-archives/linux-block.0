Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FFC3CCFD8
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809832; cv=none; b=a+S3JEDI1C1cO+CJXIaQE1NJzGME/XK9JBVuFKo8uLOTW3aCQ1qKJOB9gM53VYuWfNylUC5XPtc0ziqOxZutK/XwUUH4/1eaLu/qHWABf3HryDOZvCn9kx373RQdjZGyiC0MKmK0qGILGGR38+Ji4ioa622L1TF5BW8d0W64Noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809832; c=relaxed/simple;
	bh=kO7/CU1/RtwrDy8O6WI0itaSN6z2CSqn0cb6n8MGyQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BaADJ74tWHVZD3ETfaNA0+sqjEn0o1tqA029sruQbljwoIIdPRUj6tm9LEQMtGnP6Yza4RJ1QpP9A7lQdIXaCYJ96cgzICzM/p0E4NS7j38wF4mm5QKZd+RzDfup6ZDEtHF15C3UbY4VEd9EvUNzdNOTcx490ElJK4wNGY2H6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=xFI1kUYG; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="xFI1kUYG"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ec49608332so1974199a34.3
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 19:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785809829; x=1786414629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zO4To4ruNthAnXc9BweyqU2kP7hjI3Ya2Rj1EPxSfNg=;
        b=xFI1kUYGfN5IozVtFnQ2111eZCSeGCT01naaiDsD8oXZskYN78anbjNUUcJUiWrwU+
         v92Kz+53b3n+jlcpxFJUCGP8mRedHcIorAmT+JVbQ9ZavIz3N85YbMFl7qGIbKp+RT2L
         ZzpCY5XzQN2M9n5sVbHZz76emmeHQDMty1OkgjDSL+1DHptTGl83eq4i+IpI4QIIJWEa
         heg14pEh2StHDhD2WgSC7Y3euXYyNMGnGd9YCFIZfmLBvGslGdGHWiMC3jK29K07+zEL
         eNJehkL9eL+anzNoQqOjM0//v212YV/taLw+pv0ashqE+RuTgRzPu7QQ4fABepb1it9A
         cdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785809829; x=1786414629;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zO4To4ruNthAnXc9BweyqU2kP7hjI3Ya2Rj1EPxSfNg=;
        b=TWBQpVWciNSgjql3yGJIiM5saE6ft4mGB6yR8vhplJw9MZgmORtYvzTKp+TRTGOplv
         CqOFP6EF7yoaqb4X/AJRyObwMO21HJOQwtzJtq6wzeiePdneKs6z7LlfQ76w6oUONMJX
         UiI8wZVZ6iCpgRKJmcG/PIaVEbtJNdgp31E2JUkHppvYP3hYbjK4dB9DRMYgS3l5KDo+
         M0CuvRYhSltDrytkWipZSRfnhrDVHBlgVJKU/5DtJ+bVNajmAGjlAyNvHhsCz5toov9v
         8WzmFntu6bAJg6M0WkwnCV5vihkY98e5T4QBpDY8HbLXlJY4ssSQIgZs0YjQPHu24CBI
         nVyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmpAT3Ccr8/zxpeneZ1EcsiYva1Hwd5DEfWC9jycgEiWJMcdTLui7tun/2DG3EmnnIDXYkj/sQzzaU5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaqycL6s0uISVVgHKeatqtshfHAkkgjo8I9elNExYDFnIxXzS
	Qg8OPs4zSFVxsFR+GNzw1SHCxM1km/cDxPb+nJEO+2wr3fXRSYgpoK0ZXZqTrtZkxFE=
X-Gm-Gg: AR+sD11rOclou4uxvgu0p63hyJM9fgEK7+fQTa32IK5rHM/atJmDNZDJhmCiD2CCb85
	xcxBttWi7OGGXTYdxUo1KuY8IoigXuvB7+ne02F6jL55Jytihd+Wor48jVnB0lumLD9rUGrDDJE
	yw9EYjR/90Z1VZcwykFQJvJhOY/HTLTjjDpQQyvmc6aXzhyrs/UPn7CrKauLkoSIT7M8bkADgHS
	8LnFKNXUM3urivQX+8mank3at41Qf7rngjn27f+E/mBBH1u1wXvXJxxAqai5WL9OFpDoAKjLxYf
	9q6M9Vii5DMsUoMXy+0oQEOUrp56BFX1yu+bLn/njF1unLvTE2hQSYVScuV7pxcE/1+pbyv5udx
	keM1XTV8CVf/j/TwmcMLMEahX2si1TOhL5HvPh+XEgVpWmJK7c2lEchj5guBFjaVtgvJOMQwp0e
	YhR9WiBWmUz1f1o5710iVRyUYV9wWmoIFDtGHaLfUvu+almI/s17J8HWD6L/MPQVlNYsq7gvK8l
	1XNR3crGzTfVdMBUY2x+TbJNANQ9gdM4VsOwo+mFA==
X-Received: by 2002:a05:6830:440f:b0:7eb:3af8:8c03 with SMTP id 46e09a7af769-7f196f0d6ccmr20363818a34.11.1785809829046;
        Mon, 03 Aug 2026 19:17:09 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a55asm8914812a34.13.2026.08.03.19.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:17:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, josef@toxicpanda.com, yukuai@fygo.io, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260803133400.137906-1-cui.tao@linux.dev>
References: <20260803133400.137906-1-cui.tao@linux.dev>
Subject: Re: [PATCH v2] block/blk-cgroup-rwstat: use data_race() for online
 test
Message-Id: <178580982757.518281.5036620938854770535.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:17:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 03 Aug 2026 21:34:00 +0800, Tao Cui wrote:
> blkg_rwstat_recursive_sum() reads pos_blkg->online without the queue
> lock that its doc comment requires, since blkcg_print_blkgs() stopped
> holding it in 56cc24f59c14.  Concurrent blkg_create/destroy flips
> ->online, tripping KCSAN.  The race is harmless (RCU-protected, stale
> online only causes minor stat noise).  Use data_race() to annotate
> the intentional lockless read.
> 
> [...]

Applied, thanks!

[1/1] block/blk-cgroup-rwstat: use data_race() for online test
      (no commit info)

Best regards,
-- 
Jens Axboe



