Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C4356A08
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984119; cv=none; b=snfyzhq/smMOUXHXBPWMLXENFIMxwsiO2sua6kBzMculIiW2w9eO93l0PjN56VPtNWsgUD2elDUvi3zbqU4prglOX2xnOGeK4s1RK3Db8txyn1gz4JenogXbP0PTVi3DbuoOATlQjM3iMUPL3In0SPxFGQePq106VO7Lkl+BdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984119; c=relaxed/simple;
	bh=24HytnqXY2IQ2pdZhMjqMPeei8eSC1wSFaCSqZdU8kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BONiSBO5UJbc+jdTYCQiawxgK4+YuCuQGjyoIG/4hnk/BgavZD7DpFPKOaorm9tccEu1GjubIPj5SsvDyf2QMsK5MndrTDk2cMlfDNALVZB63RN/aRJ5U/joFistCYqyOWkwOjdwkum0dePV6h4OYxs0L0V7Y0FiL5DeSZ7K7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px0oKfRD; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px0oKfRD"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8230c839409so810407b3a.3
        for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 04:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770984118; x=1771588918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3QccyLBzZLEl0LwWVPZnt4xrcGiKN2vu1maCig+39c=;
        b=Px0oKfRD/9R08gocex+A9C7rK1xDsjqZqV1ACf0x+LsR10iuw5357qNZAWsrFjTQBk
         vsk6MwUMXPo7KUsBhwmBWl9TF8lH62EiBGTHLN7/NWuR6kN1hwUdG9e1dNSApq9itaFV
         /D6uSZZaHlA+U9BeYipTNxxh1KYxHWhb+vcCb3K+pDWfWZxRNn8rJYGYQyJXUNH6WlPN
         MsFN8sroslIyXYPIFWwkyE2c5AXAqLEIKovRz0vRj6XVSe/QepBwy5UvNkB/gZofjKty
         1RPo1mrv3LDvgDglhMnDMAvDIzVC08UjYZPys7Vql8HAuLU1Jp2lRM588Kah2VBb/6YP
         636g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770984118; x=1771588918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3QccyLBzZLEl0LwWVPZnt4xrcGiKN2vu1maCig+39c=;
        b=eFdsOVbWxxPsIG1bOL88/W74kRFmm5kUK2BkHWwXmJhx9jcuizE7eaeVCOwdkfEw/4
         zm7Wkevc52g/RSqtoKNH0TUEq3BfOyurUNU67Y7OkZ0ZPAiE7k14NHsScOHtf4B2i6Me
         yjc17+lrMT/2JTZly0dagSCBrm3wLHzAFV3WHqcIMvQItgy2Rn7ZdyidOr9+/kKKlunW
         tb5LnrFn7HRVKuLuJhrBpVhUi65IZ34iJqvcyFj1ii2WwFAIiTUiVQu9gOvacO8QLK+U
         l7ELNoDFNe3d4jq3d5OLzRkAdyi+6ZY4PMqlTGXhteInHoqAP0/82Rn1kyzLmP8Er+Oh
         0x5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtqMpoo5wHPd/2We9j3GiekEMeeuH9/kE7t8amaExZxRBZskRPZmMepVZigwgJWpjyB69cJzCybpFgqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjBF8/9jmlbev5g/oysf86ezNLgdvFa83ANfZZj2uIhGl8HMR7
	lGNNbpnfpRaCH/jUSqxoGrRjh/nZE+GUCURPpW89VgYVnQWkoQcONKJS
X-Gm-Gg: AZuq6aIv8l8r9VTo0hLdYBX4zEtF3GWUMcqYV/GLxO8nSm7CMLuIDJFShu4rHojz4Xh
	GwQABv4FmWsxGvWcchYtQCiisaXl8yW8WtVeKLvAgEb9eB9SGFri5MMpmwyR5kZSAAuauXaCz3M
	FTXBnHAjWdLNOK4iLAMFbC6e+pgVDVp0ENqYga7Xvm8yydmRSapOSi6FuM1QUrrBACm9uG4ha20
	56PtvsmAp32UyGJZ1r7+PHi4LiF+6cdyZuoE7SJ4QYDQg4g8pxJKqsWo+Miya5mR/EQpySfJo+w
	R79qEdsUlSb5QqZgF1Sap3o8ua8a8TPW3OlXwNXBq0r3nm4YJPT+ky8X5OQDVGzfToFQo30eM+2
	Cok7xNvRV73qGFSDkQUlTn4MtHzE8W2g+dIbdIRCPvIb3gHOu7sU+9bzLm3Kr+VzmaCtfWxE4Ik
	WGKISlspqiZLKeano5EuKhnTfAc2GSh3k2PQ==
X-Received: by 2002:a05:6a00:4f87:b0:823:9c6:1985 with SMTP id d2e1a72fcca58-824c948163bmr1706633b3a.16.1770984117386;
        Fri, 13 Feb 2026 04:01:57 -0800 (PST)
Received: from archwsl.localdomain ([223.166.78.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a4316fsm3180723b3a.23.2026.02.13.04.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 04:01:56 -0800 (PST)
From: Jialin Wang <wjl.linux@gmail.com>
To: wjl.linux@gmail.com
Cc: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	josef@toxicpanda.com,
	lianux.mm@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org
Subject: Re: [RFC PATCH] blk-iocost: introduce 'linear-max' cost model for cloud disk
Date: Fri, 13 Feb 2026 20:01:47 +0800
Message-ID: <20260213120147.322797-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213094218.253536-1-wjl.linux@gmail.com>
References: <20260213094218.253536-1-wjl.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Feb 13, 2026 at 5:42 PM Jialin Wang <wjl.linux@gmail.com> wrote:
> > This formula correctly models the dual-bucket behavior of cloud disks.
> > It ensures that for any block size, the calculated cost aligns with the
> > actual bottleneck (IOPS or BPS). This allows the system to reach close
> > to the provisioned BPS/IOPS limits without premature throttling, while
> > still maintaining the latency protection benefits of iocost.
> 
> This model still has some limitations. Under workloads with mixed IO sizes and
> vrate max at 100%, it fail to fully saturate the hardware performance.
> However, it still demonstrates a clear improvement over the linear model.
> 
> The following fio benchmarks were conducted with two cgroups assigned equal weights:
> 
> Cgroup A: fio --bs=32k ...
> Cgroup B: fio --bs=1M  ...
> 
> Results:
> 
> Model       | Cgroup A (32k)         | Cgroup B (1M)        | Total
> ------------+------------------------+----------------------|----------------------
> linear      | 1137 IOPS (35.5 MiB/s) | 79 IOPS (79.5 MiB/s) | 1216 IOPS 115.0 MiB/s
> linear-max  | 1781 IOPS (55.7 MiB/s) | 83 IOPS (83.9 MiB/s) | 1864 IOPS 139.6 MiB/s

One potential long-term solution might be to separate the accounting for IOPS
and BPS. By tracking two independent vtime counters (vtime_ios and vtime_bytes)
with their own weights, we could apply throttling based on the specific
resource being consumed. This would avoid cases where high-bandwidth requests
unnecessarily eat up the IOPS budget, and vice versa. I would love to hear your
thoughts on this idea. Is this a direction worth exploring, or would the added
complexity be a concern?

Thanks,
Jialin Wang
