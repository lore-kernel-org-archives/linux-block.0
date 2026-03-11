Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D640DFAF
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239455; cv=none; b=uqw7ftbX7/sFQPS/RuHOC2nG3Kualh3Ozo4fkF+zDh9PbRZ+9s1GYQg17/IhkUERv3sh76XIJZ34LJR4597jvmDj07usbCcMVEJAVWOGzCiiR3HbQPuerRAgjO+KDNlJ6eeXHJ4WlDCV2hhMFvjfhqT/40qXUq7eSgF82gbsX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239455; c=relaxed/simple;
	bh=oGFJVrw5MPryM38Hc+hepiTZFx+TepespPPKdJPjAp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QCAl+RDs9XTir8ojN4gE6/LcT0MP/b+px12kc7u8StnzpH4eFiXQX2G7XGDU5knzAksKpDaYu5x5NwN6FVURy1ZgWET66VCv+fhzSf5bbGKO+iEREUyWyNrJ1Pq2nGbGkngXv8JRvk5bvH3VZ4JAATL9CwiQFfqRkVoTnglzxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B6jbbNja; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B6jbbNja"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-662f30d3f1fso626915eaf.1
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773239452; x=1773844252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM6lCoflebWUbf3iwIkh9GT6oyd1KsXTjtUHxgqxqWU=;
        b=B6jbbNjaVa60r4cSdbcQqheOOZ+WnhPceLqH6hdSlEEIPFXblOJPorRllNxALr3n2f
         VRPyxISO8fObmTNYt9eW4qP9qHWMcyT16m6bXwjlMI9OnETFClq5nATcwg2IFjDkQOOA
         8J8sAS2t13LZZUd3CiY2HQTbSMR1ZLiSY+ZDDnXMTSME1wfrQ7eFLVw1VELa9xBaaih5
         TSdptSEoAp5XZ+MHH8UXSRE12+wHaNNsbVjimtDsLpWpnqJebEMzJjnPR8J59I3J/tMf
         5fIkwX9Ve4Cq/HNxbZoKKr2kxFz7qVyNO8JuXPSuN7TEr+1Ci+c6QBr2FI7F4bTpAUCn
         s3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239452; x=1773844252;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oM6lCoflebWUbf3iwIkh9GT6oyd1KsXTjtUHxgqxqWU=;
        b=A2+EnTql04BmoarhgcycRklhk6lRm59iuwn9r/cY35YCrYQD/dwU5ft/rhHEs9CyTp
         Jwi37B0txge8ECzDErZgk15djAVGlM5S77xgoSuwSx/Z40FUsPOxB0ST1IdboPZZCxrR
         ifJ4BLF2fZG3vhAYk3drPcg9cgm8klYT1kRPEq6aB5A7xZH1ZHcNzv1rDBVK1uimy990
         dTglWUT4FVXWk7r7cVr1OUlaGx7bxq5mYCS9XHMox4PJN10FtGnGy4Ubq9M7QoGWNc4A
         EBIaHcQQEo4MsT7AwT59wJ9lBjKeiF/4Oo7qoolOzMEVRDEXNo1xE0e46ZJLIlXhLM5M
         PaPw==
X-Gm-Message-State: AOJu0YxNdjK3wZS98QTxMmZ2fmgOudBPt45bLEOuQXUn3G0x/3hBu9NK
	pdiicm42wlo3Ryeo8ZqWFFfmpCe0VGk9FhBP9ghvVshtCSMQpNpWHO5Yt3/S8mMLf6Lj5jWIMTZ
	kMxEWFXg=
X-Gm-Gg: ATEYQzyEB5UGafkOV9TZSN7pylj6NnGh64OUV7b5gGx6Eg59dkQSAUhi5b4yEEcGJ0I
	4ARgb1Lob72/LB66hnna35PDpQOHxN1UClnjat7o8Zuu8AhAdjZ6IKkrWeb3gRiIN+8eZp6VdD8
	wy6liaERTDW15wZGUQkRK1gpXaXvFnjqi0OkVppQTQ+PWZy4OvuvUSPVe1mGVKGB0VqXHg8idHg
	iKC4alwAxdnSlYsnqIJ/jXAb1ZVByrz0mox7h8NkW93CKUN7x7N6JYuazd0v/KYut4fzXk7eT9L
	BhuTGQ6mT9up6hEcRkYLYG8PjbEvk2+tDCQSIqnZ/znILpMoI3AuabZHRO3FwlpZvj5LcsiKfY6
	+CftIN3tVMHBVzo1DmywRQjuLv0YAEnTEclmdW4RTRAERFqS8EwDWpq+qHRpRvUYnHVINCOZmhp
	Ms+OzBBvJq0raisw3E2cXmrL8WOtdMnRy3PcqY3ihhoMGPPp7+puM21oppWuEWi+rsN/nfD36ZF
	y1w
X-Received: by 2002:a05:6820:1786:b0:675:99c9:cf7f with SMTP id 006d021491bc7-67bc9151c93mr1425052eaf.38.1773239452329;
        Wed, 11 Mar 2026 07:30:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e9f53sm2524812fac.13.2026.03.11.07.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:30:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
In-Reply-To: <20260311032837.2368714-1-ming.lei@redhat.com>
References: <20260311032837.2368714-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] blk-cgroup: wait for blkcg cleanup before
 initializing new disk
Message-Id: <177323945100.213870.2430768479850715913.b4-ty@kernel.dk>
Date: Wed, 11 Mar 2026 08:30:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 11 Mar 2026 11:28:37 +0800, Ming Lei wrote:
> When a queue is shared across disk rebind (e.g., SCSI unbind/bind), the
> previous disk's blkcg state is cleaned up asynchronously via
> disk_release() -> blkcg_exit_disk(). If the new disk's blkcg_init_disk()
> runs before that cleanup finishes, we may overwrite q->root_blkg while
> the old one is still alive, and radix_tree_insert() in blkg_create()
> fails with -EEXIST because the old blkg entries still occupy the same
> queue id slot in blkcg->blkg_tree. This causes the sd probe to fail
> with -ENOMEM.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: wait for blkcg cleanup before initializing new disk
      commit: 3dbaacf6ab68f81e3375fe769a2ecdbd3ce386fd

Best regards,
-- 
Jens Axboe



