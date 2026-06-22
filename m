Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702737B012
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165676; cv=none; b=hXBWUAA4ds5MdKh5UYDVcWKbQFzW3rQzEhSeAKRNtBAwwpeN2oWrQu5HhEQ8x2nW8aACy/3xGE427pOPk+LRTL05duEog/bVHxAbaNfTLoqycDBnyqYZlaeQBLjT8+czJUEzl2Ry+RvZTKhJPHtoWamnl0Y6SA/lQzbu3euTkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165676; c=relaxed/simple;
	bh=yFP6vPTIKZFpIVTyukJeuS1iJIwz/CHA4/+ifh84bHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MCz0ouYNko31A7HMbSnFq41KGbA/qj7OJMWgKu7HYds6rITUISjBRt5aXiMz+ibeFC6YiS2jvlB1DV1wsYHjb+t4vrvbtWUv8DuwwJalsAz1OfL5g4fB5zKv/8ogng0VKedxEplHG2Zojwf98Nfn2LuJbrsXgwv/diY8YV6PEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=MhNiM7DS; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="MhNiM7DS"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e8b45dfb3dso54567407b3.3
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782165672; x=1782770472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=porwEAXdPPEg6IzZtdKU9orivYQedDa6+cnPOd+H1g8=;
        b=MhNiM7DSi0XxarxsgxrbaZWRNv3ZBG25xZLeXaTuXmKpMrO/UYUDVGAeo+leXcJawL
         xQFs24yGmtLs2G8TCzlLAblbaBNw+7W38P2nYo14IhBow29GTbvjz9Hy1y/Tb+ZHIcjC
         V7h1O+6cgMikMh9HRgUO1qdxHHq8Buk9wD0YsOR0OWyOvob/TOSY+ouWChxEMsB3HTLy
         FbFe3EFjpWxJNjz0N78CaGhKHWU0eekEuJrTSZu/g6ZlRhBhYC4/GhgINOvwlkcokF1p
         Ti5pQ4OHuNeP088anlsqgtWJfSIVuLVjIxPCBiQhv7Qh8EiZXQHbPOakjLE4BZ9fCb6v
         YqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165672; x=1782770472;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=porwEAXdPPEg6IzZtdKU9orivYQedDa6+cnPOd+H1g8=;
        b=ndrfKiYTlNu1S2/PknbxN4DESR+jdoZfkYfiiRzNDxjGAr7AtS2EQTtdqb+KSVjuTQ
         qvfRjdOdh/Nx++pxQ9cvmpa+xyUZ/8tnFr2atIJ8VJbgIcqvDfhye47I1gscsMRpSJ3d
         MBLXWZvasG1ahH3vDxItYEJ8eVwNJXNz86mILVFq7ekjjtZQY/15pKCdH6ml2nIwR0kY
         OLWSo/T+eGt9YPjahBwNRyBoBozA+36okMrCSegeNYYFJYI9RyhNztrQIIPsbGCJBu/g
         2opHRSNf4OOFlV7ZRpf/pySbdz+ZPDALq6HSU2aIy/wZfUA0dfqaSYDJQpPeq9L6jMZt
         VssQ==
X-Gm-Message-State: AOJu0YzKe4l4oXnt5zLAdzMWoFq/i+Mgv+rZj48LP4qHiNNheqMjc+5Z
	q3uvumWloLIyBXPj/ZdOM0jRRc9zvMEOssmOxIhcALthb37XexurEkjnzqv7+GQExrY=
X-Gm-Gg: AfdE7clEAEk9MjpsdCeQhrE/SGDN6U1cnrjagCwCm6g1cU6QseOapaPDwrL/H4hGWSA
	PHkvL0DsX8KaKlpdepWnmBzwp2a28C5ObarsphHeN+XE/jmoveLYJKN2861Y/r7NL7M9kV3hjv1
	9W/zyORpsuMSM+qEj6hmYmkTurZhdUnEexKz2Zu1Bx34IsUWFG/GeBw3/raL1inguyQaRyO2naP
	9dBuVp83Zjx6+q7AuYBT3jSHgXvXGJgsOt0+45gWyVar0AB09fpjG6FKh16fh+c8OMQ8hfwJzwF
	iTht/Uu4SgsBw9Xmm5v8ujgdu/gG83xcg79yf6GXIPvUmRHK6eYB4xNEzVSy/4/CWWC3UWjd2Z0
	H+y5UeynL64sCHQVQ4LX9j/ehok/zPhIgbfO8z3o4Avlj7d4b1kGYtxwZyKOWxdxZryPUxIaxrY
	gLVQTfFmgrCuHUCoU/MjdgGMD+pdGhC/zbO1c=
X-Received: by 2002:a05:690c:46c6:b0:7b6:cd36:84af with SMTP id 00721157ae682-801335040f1mr192567407b3.32.1782165671695;
        Mon, 22 Jun 2026 15:01:11 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm106932496d6.7.2026.06.22.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:01:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>, 
 coregee2000@gmail.com
In-Reply-To: <20260205155425.342084-1-ming.lei@redhat.com>
References: <20260205155425.342084-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] blk-cgroup: fix UAF in __blkcg_rstat_flush()
Message-Id: <178216566327.110437.11201759901497714686.b4-ty@b4>
Date: Mon, 22 Jun 2026 16:01:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 05 Feb 2026 23:54:23 +0800, Ming Lei wrote:
> When multiple blkgs in the same blkcg are released concurrently,
> a use-after-free can occur. The race happens when one blkg's
> __blkcg_rstat_flush() removes another blkg's iostat entries via
> llist_del_all(). The second blkg sees an empty list and proceeds
> to free itself while the first is still iterating over its entries.
> 
> Move the flush from __blkg_release() (RCU callback) to blkg_release()
> (before call_rcu). This ensures the RCU grace period waits for any
> concurrent flush's rcu_read_lock() section to complete before freeing.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix UAF in __blkcg_rstat_flush()
      commit: 0ab5ee5a1badb58cbb2242617cb01a4972b1f2a2

Best regards,
-- 
Jens Axboe



