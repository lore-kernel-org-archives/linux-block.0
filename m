Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED3185924
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112331; cv=none; b=F0sYYF3iJkVq/SBiGTqfgSdwDGJs9uz9x2cYLvHo7xMk5KbE58+cwuJTtnxyHoaK8jh6JUf28VS/dKdQZOAIG/UgO+jNP4weF0csbLH+RZMQ4mbDgC+jeYjVdYt0tA+Q0/6E65AH0hEfJ1wptzqhvTXoew3dK0z/0+mGTY0qja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112331; c=relaxed/simple;
	bh=8SKEJ9QRi66ueTOOkIoXLPWHACOF5+YjeuwyZYeDoIk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RvI8q4GIQG+sE307TAvpC9YpagSPSN4RyvaPSnY5wSpB+pW2AKsCgV7PHRnkyU0YZ7xmYrufOMmc2lhaW8dpKkJcOXo/vzy2dp5TJgPeGGrNuxtr9qdM1AKgPYYcmnRrBgAX+su1VXsIJjdMolqyaPkcoxKvLARSBJeCVugXBlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2UkS0Djy; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2UkS0Djy"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so15423215ab.0
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734112327; x=1734717127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ocN+VGiHpHt3RChhxHvge+X3iY/5en2QJj3s0eetao=;
        b=2UkS0DjyP5l7vfJjL4uYoY1c1YPsA9IugtCXtkkIYfIvmej16uLM9n+zOZDHUtnK/g
         8j9NB83B1TMoHmO8Kb051/OJdDMHw+knHW7d3PnpY4gUce48dzIt7RP7ZPEUruPd8s1T
         iuCOuWo03YTNO+cUX373rtRpbdv0k218UE4jB4yVs/TePpjvKQ05ItDYYhBviWPtRZ9r
         ZLwnJGRWkPLdEpxrwpBeSvCu/B1WeLiisQ4lCY+H55CXGtWcC/eNVeN/iAFIw25upc++
         WWR8MUAhVWBieSHdLMZL9DbRcEywSz35Maq4KIMwg9B00N/wLrChQULdDPnZO+VDBBYq
         DdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112327; x=1734717127;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ocN+VGiHpHt3RChhxHvge+X3iY/5en2QJj3s0eetao=;
        b=B2y9caHCSpz4KbJbGx4DCs8vZ6uRyg7ZhZTIPbvUXj0bI1pEi2VREsvzkkyjqT7KBJ
         5HwnzV4kDcoWqaDjBtEJkEhc6veNd273QCV0Ppun2Nkqs3goNGYRf9VSIvvfdRIHC4Wm
         WMBE1+8XhBbVrLVxHq9fLMz+YjPUYd7Xsmmd3u5WDnn0Hp5HRm1Lvu+bYDmx7M1peQER
         G0EkTz7loUhq9l51f8b47vOCCj72KPeTzG4ggcsbElvm7i1siHzkHnRZcfNag/IH8G+i
         E6FijK0GzCLYG+q3hMLP0M4a4s6wFfDwPwB8tZYAART5sq9M45T4uQFp6+k8NcovuWPR
         Ud5A==
X-Gm-Message-State: AOJu0YyhfqwygSEjMitMQuvE/YN2gTAQYtDo4QTvhqhdv0IIMNSHs3z1
	ZBlGH2PE5l7uqZPcBFWW/ug2aC62xw323kgNY5chRbSWPGHdu2XnuOADFmRN7lzUK7Bv/jKGBy6
	K
X-Gm-Gg: ASbGncs14ylgl6lrzNgQ5HWH9CmDkezyLqdYadA+5s5zjp85IQAaUgZFLRP803Ou5UP
	9EYxkZGI2wbSgr2mlM5BCUZKeTMjjf2us4yDA/sAP9LrpuwdZ1P0ZFHt1DeLGQEvtKWO5l2zusT
	OXBACDhTo9pubmscz7P4cPOuOoWEQI2iUKKQyKd6av7JzH0IZzzv1crvL4/zNLFHuuOkRCAu9If
	UUzHS//kwV8/datIy4xlZU9m69AYfFLQxrZYDNf4wtfA3E=
X-Google-Smtp-Source: AGHT+IHAC3KZI9bp2TQhg0SIaxphZxK0jazWUsttNjBmIjpuNgR9//03nCDxC0YTAVFSTA1zs5Uj8Q==
X-Received: by 2002:a05:6e02:1d81:b0:3a7:7ec0:a3dc with SMTP id e9e14a558f8ab-3afeee79d4emr30279185ab.14.1734112327204;
        Fri, 13 Dec 2024 09:52:07 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2ec356807sm874558173.34.2024.12.13.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:52:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: kjain@linux.ibm.com, hch@lst.de, ritesh.list@gmail.com, 
 ming.lei@redhat.com, gjoyce@linux.ibm.com
In-Reply-To: <20241210144222.1066229-1-nilay@linux.ibm.com>
References: <20241210144222.1066229-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv2] block: Fix potential deadlock while freezing queue
 and acquiring sysfs_lock
Message-Id: <173411232591.124733.11260571979796173193.b4-ty@kernel.dk>
Date: Fri, 13 Dec 2024 10:52:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 10 Dec 2024 20:11:43 +0530, Nilay Shroff wrote:
> For storing a value to a queue attribute, the queue_attr_store function
> first freezes the queue (->q_usage_counter(io)) and then acquire
> ->sysfs_lock. This seems not correct as the usual ordering should be to
> acquire ->sysfs_lock before freezing the queue. This incorrect ordering
> causes the following lockdep splat which we are able to reproduce always
> simply by accessing /sys/kernel/debug file using ls command:
> 
> [...]

Applied, thanks!

[1/1] block: Fix potential deadlock while freezing queue and acquiring sysfs_lock
      commit: be26ba96421ab0a8fa2055ccf7db7832a13c44d2

Best regards,
-- 
Jens Axboe



