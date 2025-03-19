Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859B20A5D5
	for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405762; cv=none; b=LIn5uqlN/jFhSOGxII0FovLnhTl56yIZR8OoA1Xl5YUnI/BodTOU0+j5DoXO0npNVC78zTBnn4mqC40xXOwMgvYJizVlet4QxuYoGlQUjFjMENesIayffAc9abwxrZkEsmi+UC9fIorKZZGbdp56A9ek+xLEBwu3bVUvgcah8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405762; c=relaxed/simple;
	bh=DcDE+MRTu6kEhaYNT5m8P6VQjWGqHKsVLZMTLd/6IUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ci7K1F0mPEvFpuUDncEKgYeWt1u1Ge/5rIoddHFm0kHxFrXrbeKKwoxb9T+MrI2yI7pxWhVVzNkDRI2w5ccvSWXpURTDK3h+gD2PWK+hUlNYX9fg0VNaky9R1dBP89VjVV/OQu3MY/tflVd0Ew4a36GcJOOIRrKH6IyhwRRFsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kR8ICfbi; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kR8ICfbi"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85dac9728cdso194924639f.0
        for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742405759; x=1743010559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrZFIfvp8oAO0Ubzp//Y7qhv70w3dwVAU93bLRb8Kfs=;
        b=kR8ICfbikoK+qgVBEmEUiC1M+J97IEFnHIUjuHzgB3lYvZrAFQlVJJAtytspDH9d2f
         W75JYUtbbTxPIWJGLk5wUaYEhJK0X+2ZFOzuo1vzV+hEHjbhacGNkk4VsPC373j/p2IC
         o+MueDAtyEtjQl5LitpUZwjTFUByKXbAL7F6wxO/4CluHwX/5IdqgB7vjhDZbZst4igv
         VIQgHMI8WoweGl1bLNO6VstmUQm6uhtOiKQGRl30/GrQIG4dvevQ9XPpaRGtABMXOCz8
         zFHt9WO2QL5JIbxp4u7jsrGpUUMOIuva/DXfQL20RL8PPw3AR9wXdfhlnol/t+k2PhOl
         Q6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405759; x=1743010559;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrZFIfvp8oAO0Ubzp//Y7qhv70w3dwVAU93bLRb8Kfs=;
        b=OPgKjD75A/cReU8cMI/7Xzo6QX5AqKRtOedpJcy8cshnxbGkQ542taiDOYPspbPi7T
         ltyb76SiYV8iWHOqPhUnV4AFAdIO6Loqol/a3x/fEN1C6lGpD+d4YoVNPGyRoOHRKqeX
         BSZPAZ4zYWUkqlCBZRbkpGmrhXjcKntY2O8X1KiS2njKjxqVfjyuZLboPMOAeKGy6NZZ
         8lxFLO647goCBBgauZ7su2XTLYBC8BmZGPL8JbhlKiMJTzJLt9BQhHyDjpMNSFeInJqy
         yoBkLOXDGHQNxmYksOtJJTPL8amty5TNCfIxNVFzJfmZpSJO80PPyXMVnQg28/SRlbTa
         i9ew==
X-Gm-Message-State: AOJu0YxPFlh4EAqAXfjS+aSbVHa+7blHy5QhWZ+j7B7UUyOVnAmQdSv+
	wJI2lVhxrg1IblMqeGjn7rPQeB3AkgmehV3Tn2KZq9kSesQJ4ASFbJMPNets/MjWvfPkPua/e8y
	4
X-Gm-Gg: ASbGncuL8D6Dd8w8YQn0p4pclmsukTpQrsvFeKqs0J9t8YvIVhRVHaaoITP2bYgLPYd
	XvVcuV38efeFQMqjUM4x3amL9Rcfvnp6mVPtfEuCNoV0SjWxLAVcM1V/4ggdAoFaZX5oppm4MG1
	Uu+thBH3nZ2hfExBksBgsvx/K7mZLQPCR63GKSqZZlbj3AtBdWYYp8/IojuzWZj3QAOtSZQNmjB
	ylo0NefX5psjmKAPMWdlqX4oe+EuMLovugQh/2P9sC3P4Z/7p6CPPRJYbhn37/TWOlrPwittr8H
	hL+ZWOqiMyU1mAwKbYONUFdCKWqg/Ca8B44=
X-Google-Smtp-Source: AGHT+IGxIyPSKaGDDYnGXRkqb2ki9jF8MrBdNwNmODau3eoFPZFGsXbw6tVGRnc5ueu0X3NGoxTG4g==
X-Received: by 2002:a05:6e02:1aac:b0:3d5:8908:c388 with SMTP id e9e14a558f8ab-3d58ea973c8mr2843215ab.0.1742405758834;
        Wed, 19 Mar 2025 10:35:58 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a646ef8sm38572345ab.9.2025.03.19.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:35:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org, 
 tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com, lkp@intel.com, 
 oliver.sang@intel.com
In-Reply-To: <20250319105518.468941-1-nilay@linux.ibm.com>
References: <20250319105518.468941-1-nilay@linux.ibm.com>
Subject: Re: [PATCH 0/2] fix locking issues with blk-wbt parameters update
Message-Id: <174240575789.107020.18022154030332779642.b4-ty@kernel.dk>
Date: Wed, 19 Mar 2025 11:35:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 19 Mar 2025 16:23:44 +0530, Nilay Shroff wrote:
> This patchset contains two patches.
> 
> The first patch fixes a missed release of q->elevator_lock which was
> mistakenly omitted in one of the return code path of ioc_qos_write.
> 
> The second patch fixes the locdep splat reported due to the incorrect
> locking order between q->elevator_lock and q->rq_qos_mutex. The commit
> 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
> introduced q->elevator_lock to protect updates to blk-wbt parameters
> when writing to the sysfs attribute wbt_lat_usec and the cgroup attribute
> io.cost.qos. However, writes to these attributes also acquire q->rq_qos_
> mutex, creating a potential circular dependency if the locking order is
> not correctly followed. This patch ensures the correct locking sequence
> to prevent such issues. Unfortunately, blktests currently lacks a test
> case for writes to these attributes, which might have caught this issue
> earlier. I plan to submit a blktest to cover these cases.
> 
> [...]

Applied, thanks!

[1/2] block: release q->elevator_lock in ioc_qos_write
      commit: 89ed5fa3b5419f04452051fbcb6d3e5b801cdb1b
[2/2] block: correct locking order for protecting blk-wbt parameters
      commit: 9730763f4756e32520cb86778331465e8d063a8f

Best regards,
-- 
Jens Axboe



