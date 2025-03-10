Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DC22A1CD
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614642; cv=none; b=UrF6DdjyLBSq6cGKrHt7a5oOUwLKhwWXP6Wmk5hRCSkQgoYaalnL/NIjjyzL/qdRoq3nb/6qi8huyDuiMadE1kJ7HiPP7J+plgKw+jKInY/BYCuIxKhvY/4K4h7D4OmQSc33YwZez5/zSh7+BDW4+61I+2lIp+zNTHflSimRwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614642; c=relaxed/simple;
	bh=Oo4XMyHNnFCpPaGJrtfZzFvxvkgJYIwWSf2K/zdtKh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SeCWMy0PgaDrLX1i9oruzJB8XJQlorLmRgJUZwnTUq0wqG0iCUwsvQ7I9HQ/VKgu4aWV9HWP+v09PiJy6Oqyr+Mc0P+1NF21n8gwijY+4z25lUbTuf/Qb43ky9WyUUSgKKeEdLu+OCo2MCkAlNdKWMRx8nVmTfuicmLwNBpL4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ur//gJ0H; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ur//gJ0H"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d439dc0548so10858825ab.3
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741614639; x=1742219439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYiouYwXSvSsOdkCUe2MYcJkhYJ7Kn7FVnC0T+FCLJs=;
        b=Ur//gJ0HlI3j5w2Ow3J3zYhHvAGvT0ExyNniVGJz9QJrAEnH9PXHtgPs0m7cpt2ZCe
         aXYzJcW/Yb1mFk8yPOnp6oIaum7wjA0Weti9wBAnUcbH1H0PB8SRo+9lP5tfZ7iVPkdH
         hilHMtZ8kmnSij2b2rqF20kKQpp+RY+p9vWgVh4yUamCyeGpz8AY3U7wYLOhncjIkHc3
         z9wTpi1xVu52oRxihWE3RSN12gNAuC6HEuIN07SVtP3Y+cflY+23LsgolOXFZ9vkcV3m
         21bk1ycJ3BTmU3FW98rBsqW3WtVnGKSfvUXoo23Gm5iRSw6HlKahVQjVV+YliHMyEf1s
         0Pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741614639; x=1742219439;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYiouYwXSvSsOdkCUe2MYcJkhYJ7Kn7FVnC0T+FCLJs=;
        b=nImnzzmflh3rdUqYqH/pLgA5DSI7alx0HDR0JhMDgj5H8eAd/CJ5Yp8D4MRYYB19MZ
         b2DDpRIPNjOeIaOPJHfcskJhhBG2iluyNZ82OVTBeEa+3hlCpIoVVPumNFPvpRDMd76a
         rLnUeZgBXs+VNb5uZhSWWuGv55HK3q4CnNwZzXe/v7qbysurB8NxttahV7vlWUdgY3RZ
         IM87ZSfdpt0cuorZkvTVHBbq8KRHHAZVrEPnzC5w526eDKVbE30e9q5MKqwYBhHiUQBB
         PLyXuKNIfwzpz6wEd17fmMzn9T5bGLqu7fcRcp4ceZQnmatY6Rae+mzH/6kFILEjnmQf
         8pgg==
X-Gm-Message-State: AOJu0YyJ707t8pGY2AvqwLxrrou8O+wWgVfXOL2rjy/KyxfJ/iRGoHBf
	cECl/zgdRz4u/yYrQhg/LRapIsGxNAZ7ukExfPUwUQvINtfjS/1OYjlZCsu5EGY=
X-Gm-Gg: ASbGncsn+OK8Re6vnrt+BOzRtUKYtbiC8L69JE1Oqz0e/iREkgdfk6ERd5dakb5oEqR
	s//RantSAjqqhoMeRy5xRJhBhraZ5xikPt3cC7zXatN1lkPvbRYBXZdydefW62c991/Kc/8wGzZ
	8ZVIlXrca6LfXHq5s7wS1cFqpBuCMm0MBTs+ppMOBFjKZGMhtBv9PKEMxqRwZiTCF50s4PeTrgN
	cx9z7vE6l91GOS1dNrWyu1MQYfnPmEEF1VAXDS23QXBVwMgM7mB7Q4OJU18kLxpp1MtNXhNmp1N
	T/CgzFjno+rR64mlflIZi0HkCrz+uiF0zmA=
X-Google-Smtp-Source: AGHT+IGZInywWAOYG7RL1nr6xC/tRGyiSg5tMcDbvA8lpiL9sPMhgdabo1op/sVDHkM/RLMy8uwhDg==
X-Received: by 2002:a05:6e02:741:b0:3cf:bac5:d90c with SMTP id e9e14a558f8ab-3d441a06f4dmr182574565ab.18.1741614639489;
        Mon, 10 Mar 2025 06:50:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b511091sm21350915ab.42.2025.03.10.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:50:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de, 
 lkp@intel.com, gjoyce@ibm.com
In-Reply-To: <20250304102551.2533767-1-nilay@linux.ibm.com>
References: <20250304102551.2533767-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv6 0/7] block: fix lock order and remove redundant
 locking
Message-Id: <174161463850.178937.1803605035075071365.b4-ty@kernel.dk>
Date: Mon, 10 Mar 2025 07:50:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 04 Mar 2025 15:52:29 +0530, Nilay Shroff wrote:
> After we modeled the freeze & enter queue as lock for supporting lockdep
> under commit f1be1788a32e ("block: model freeze & enter queue as lock
> for supporting lockdep"), we received numerous lockdep splats. And one
> of those splats[1] reported the potential deadlock due to incorrect lock
> ordering issue between q->sysfs-lock and q->q_usage_counter. So some of
> the patches in this series are aimed to cut the dependency between q->
> sysfs-lock and q->q_usage_counter.
> 
> [...]

Applied, thanks!

[1/7] block: acquire q->limits_lock while reading sysfs attributes
      commit: 6e51a1279cd60cb93e3379ff140d8fa6c39ecf20
[2/7] block: move q->sysfs_lock and queue-freeze under show/store method
      commit: b07a889e833555735ce72ca4a6d39f4c2ca725ba
[3/7] block: remove q->sysfs_lock for attributes which don't need it
      commit: d23977fee1ee838316fb1b00945064a146460843
[4/7] block: introduce a dedicated lock for protecting queue elevator updates
      commit: 1bf70d08cc3b55abd1763e6dff5855cb8dd8318b
[5/7] block: protect nr_requests update using q->elevator_lock
      commit: 3efe7571c3ae2b6481253a2616c2bb3fbadd503b
[6/7] block: protect wbt_lat_usec using q->elevator_lock
      commit: 245618f8e45ff4f79327627b474b563da71c2c75
[7/7] block: protect read_ahead_kb using q->limits_lock
      commit: 5e40f4452dc9a3fb44d13bb6bc7032f3911a2675

Best regards,
-- 
Jens Axboe



