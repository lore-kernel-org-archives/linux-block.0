Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B583AFD05
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305626; cv=none; b=e6Fyo8tqebXjUVDj12t+sWG86Mag1Q3upNea1enhoqVdq3pwlndqYYir7IrJOhiU12PbBQCTidyFWf/kOpQUYvFBC2VWqnUpdetu0kT2O71jNSSfDzSMFq/D3wlV9n167NPCA/LybPU9Dwo6fY3QL5QyDzoBRQu2sfW6pLeRCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305626; c=relaxed/simple;
	bh=PD5G12xOLAzov5JHtwUfORhnpKpMIKv8xa6F4df83q4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n9UpMTxJbNWGWbN1tkLJMCWWwo5JymtXc0Qc7AoxxOQbjCUPEsdisAwq+26bcsCCLOxfFLs/BQZoy6oAp1X+m6YVoViZT2BqrjoR4K1GQP5ivb4Y0WVI0pMu4TxTdKxcFJnh3U01Jw/bXBuEXjai3mBVA0LHlV+rT24oL4J5Mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=iKR9o3Qw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="iKR9o3Qw"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e93e0a3364so722783a34.3
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 05:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782305624; x=1782910424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyUeAUZQ6VzVD4aBIbLL3a1KL2Cf5FHGMKxIglpvK8o=;
        b=iKR9o3QwbepTq/2a2Wp5FqxlB6hzT5IufFFzkhh+DcF7ep3phwz+eGSmNbSIIBMVhX
         9kPvG5ntkzZqWL2AZk3Ft6zHIhd8Unk8SMtM3noB6aL1SjZOuT6+/+Oq8N3f6eZHfsPk
         2xPZJ9b4IPcR56Gv+LK5/73JLPdaL31MIm9JwYeDw3nGELuyTV51Gay0HTDTvGjwyNMq
         JFIQDSMhUgJJZMKRFTviNYIenQnQ5AwVJa0t71HjxXuWokZjwm5gePgRxQdyYOJByXkY
         NC9HbJNXhFiGo4H8OHHhbJurhKF+kNNUrMvMiNhPZ4tNz6Ws1LmzTseJSnjNLs9W0pn+
         nGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305624; x=1782910424;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yyUeAUZQ6VzVD4aBIbLL3a1KL2Cf5FHGMKxIglpvK8o=;
        b=A2GuZsqFxGY68ly9A6l2nBiC4k8BbDPX6ftKTVGXStZKuWYPWki4HBV+e6KpZihKap
         PMRx584s5TnrjaFwEHdsu3ad3bnBNEjcNkpXx3iU42l/vXjcijbyxVqQxZfSyriOy1v1
         GGp4EhiUFmKDr+R/L1C/JJLL9vtmaUppgx3/nCn546918f8UF87gU/CUkRdUL7BzF41A
         hkO4O5m1XHiS+cexqbWbaXm9uXOhBPflE9kP8yNSRrN7gbmz+NuMmDa/DxyC0zmJX2I/
         M3lwt66OSN6DSpdmPWeUvFEIE1+zHgkHIJo1//BMeP/JCik3It0sHYD8oN54eT0V7ryY
         aITQ==
X-Forwarded-Encrypted: i=1; AFNElJ/EAIQCjGWMbS5JZ6lLN7wSm/fn+MStlfK/7eSta7J39h+ZEe1oWOXNBDQRQwM6hntGDKZu5NoIfSv9ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQrjIjTSn8Fe9ygSm0+G9bBPESJLve4VdUYVAl7gwsSQWSa56
	eulav1GLYQ6IN6vpPAkxF/wRGWpBCgq3+t86EmVyuk8K6U3/4kEGXFb9rbj8jzctAAc=
X-Gm-Gg: AfdE7cnti2tpX+a+I9PItbPVZuXxxqjEkX1Ijxb3My4yTNSNLVcoM36kHJw2qWrh2OU
	UMIbJ5jcOxYF4QvroK9LCfzqgvDEzVhUKVXiP56AspU71t8ODY4m7IXGTGmvylFwGSoMIimpyLm
	AW0sQrvOtwYTj9G6EGGTsaLmxQMSreZzhKlvPkxxU4YtQ14Q5Et3zkwWJIqUW8h7ENVsLOMJNgp
	jceyzL95l8rSzmkjpIpH+hS0Nk8fRR5nCa5CwQFN9IoLVFTU3CZzudeFkJtSf7qFY8XgmE0HylE
	yIQRpdLS3gdwDPlhiO1sUNf+9+9AhEg4AEklAWxn4aW8y/Kg10N8qGyI17nIFRDvbTDq82wPAR+
	Nut6Ov/EsyA1n7m746XSiKsQFyAld7DiqZ+l2eb5UrEhZ2saGu8ZnbceG+QfVGRPdtdpbnor0p9
	bOYwoIGBjMLRfu3DQmofLOx5Bu4MS+suZvdeZ8QueGF0kFqIzeXPGtyV0X94jZxDwFgA==
X-Received: by 2002:a05:6820:2222:b0:69e:9c80:2fa0 with SMTP id 006d021491bc7-6a1230575c0mr1922407eaf.17.1782305624088;
        Wed, 24 Jun 2026 05:53:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9faf29asm9264161eaf.8.2026.06.24.05.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:53:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, tom.leiming@gmail.com, bvanassche@acm.org, 
 tj@kernel.org, josef@toxicpanda.com, yukuai@fygo.io, 
 Yu Kuai <yukuai@kernel.org>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
 shikemeng@huaweicloud.com, nphamcs@gmail.com, baohua@kernel.org, 
 youngjun.park@lge.com, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Baoquan He <baoquan.he@linux.dev>
In-Reply-To: <cover.1780621988.git.yukuai@fygo.io>
References: <cover.1780621988.git.yukuai@fygo.io>
Subject: Re: [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg
 paths
Message-Id: <178230562124.29628.5186654393991521598.b4-ty@b4>
Date: Wed, 24 Jun 2026 06:53:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 08 Jun 2026 11:42:41 +0800, Yu Kuai wrote:
> This series is the follow-up blk-cgroup locking cleanup on top of the
> earlier blkg-list protection fixes, and prepares blk-cgroup to stop using
> q->queue_lock as the global blkg lifetime/iteration lock.
> 
> The current queue_lock based protection is hard to maintain because
> queue_lock is used from hardirq and softirq completion paths, while some
> blkcg cgroup file paths also need to iterate blkgs, print policy data, or
> create blkgs from RCU-protected contexts.  This series first tightens the
> blkcg-side lifetime rules:
> 
> [...]

Applied, thanks!

[1/8] blk-cgroup: protect iterating blkgs with blkcg->lock in blkcg_print_stat()
      commit: 25656304dabd26198ec69460c594a19d086ef099
[2/8] blk-cgroup: delay freeing policy data after rcu grace period
      commit: 0af3fedb8c8ed3c07b4f76927bd7fc88f6f82efb
[3/8] blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()
      commit: 56cc24f59c145ce6938959f792df04b8a4f5a4d8
[4/8] blk-cgroup: don't nest queue_lock under rcu in blkg_lookup_create()
      commit: 9327a865e395a53f67dffac4710beb1d4730495e
[5/8] blk-cgroup: don't nest queue_lock under rcu in bio_associate_blkg()
      commit: 457d3c4f0fdd6cf8a4bd8115bf470809984a9f02
[6/8] blk-cgroup: don't nest queue_lock under blkcg->lock in blkcg_destroy_blkgs()
      commit: 4cfd7c1cff8f4c863b99d420cdbe0563802a9e80
[7/8] mm/page_io: don't nest queue_lock under rcu in bio_associate_blkg_from_page()
      commit: f928145cbcb52544203808f159461d0a25543df7
[8/8] block, bfq: don't grab queue_lock to initialize bfq
      commit: 3ca4f4e3ae811d414076a491cbf0dfcdae0dc01e

Best regards,
-- 
Jens Axboe



