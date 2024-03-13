Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59756777
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366989; cv=none; b=qk5QltKIaMsBiB+lWIegKojIBfIzkQ7yw8GA6JGXH6Kppd/OAgB6XLzYCsh3Z5Te0kykcEUuydWE4BUsjGE7d7O+nJeYZzdCUHTPqlkvQiNWQ25bdW4qxcBb4RpiBGaoEGolfn7+p/ExBxkQG/0ykQsHbaBoLXonl1o1LELx/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366989; c=relaxed/simple;
	bh=pidpON54GW2OoE9CebhOz2WDcDEEEN6krgz/X36cGXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bRtGFE6gq1qAHTD8BEhxmDlJxxoGpRiTs3/vEH4xCb0kHBGpe3L2e0ENZoPgl5UpAqXlYlAmWJ2WQzQf/R2WFt9t455dHE0KKdK6pVgwXiM+ku/ieCrQdh89CFaMWwpAcDTmltQlnmQ6lc7+2yY532qV4BRAvwZX6VVEuNM+zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UIArm7EV; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UIArm7EV"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36649b5bee6so538885ab.1
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710366986; x=1710971786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iWZ6WN+sGJpmwLxRnmW8Nu23rbrdVhJvGirE7oMTKI=;
        b=UIArm7EVJMWBwjZ8dpgqgQfQSKzQRX51ZhOElGut0kRT0FctTsnKEXCEIZG9hzqDhc
         tCTyFeHLo7+0cf19eyCazT66TCFZXtueaCjFpSjNZDybvFQx81KR4I4jm7zqICxzOy36
         MRWgmRJwO3FalqxN6cGbkM3vMlQcIp5JIYxlTwHqCq0ZYukdGsoSnFJMX20Pz3vKvEII
         7npW2DFlyjA87XFMsh1oElsDb67oc3y88dku+6TxM1kNjNgniyVcOBRsQZESdvhDNX0w
         OXAdgrGWo7tzgrmu4IMYXQvIDq66pdPSbc9vNFFmRPqLxjS9ausonWy3SvlNH7ltRpbO
         Rd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366986; x=1710971786;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iWZ6WN+sGJpmwLxRnmW8Nu23rbrdVhJvGirE7oMTKI=;
        b=wUMf/GMeST/uh+KgQ52kq8+a42Os62rbe9Zhz353HoUTZvBopB8s8RNP+prK9y6eiC
         NHQEVIjkhh/fNndT4ko89qpxkfbzH8Zl4I1SshIqRr5yqdYUqFz1fMZ0lhUSlv/7G3P8
         3IYQW5scUL7WYnV4R2s0oyxE0oQt3oPRMrybMqKMqXS7ypgpPMAs9jwxehAzkdiSAC9o
         DOvNsOBHAMiuVP57FEm+DXiLIeQKJ70tqIa4m0xKcHw8vTDr+88CCYoLOt9MALxGX3F3
         oBKJNQPEo8RDmvOO1Cqq81H/2MzVl8lJESUli/ty7UGDBzXtQfqzdiCpovzo76RR4Avs
         3Wbw==
X-Gm-Message-State: AOJu0YwEpZzIgp5AmdNk9wYCk5Ij/UGnenk3zWJWTRGFy6VUTWgfwEz3
	tp3RfljQXu1l7OveDiXPNrw07nkwOC0Etl+V1QJxjKGXHx3pOfFJa3hYA2H2JdvPX0r/Bm34UUD
	w
X-Google-Smtp-Source: AGHT+IE/xLkfGNFymYNc+g5qKiot5aXuVHBXHPVH0zz8MpJV0hR9J89BmuxJq1ImY2nHQCiwbu7duw==
X-Received: by 2002:a92:c548:0:b0:365:224b:e5f7 with SMTP id a8-20020a92c548000000b00365224be5f7mr14176282ilj.1.1710366986625;
        Wed, 13 Mar 2024 14:56:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q3-20020a056e02096300b0036426373792sm56959ilt.87.2024.03.13.14.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:56:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 Zhiguo Niu <Zhiguo.Niu@unisoc.com>
In-Reply-To: <20240313214218.1736147-1-bvanassche@acm.org>
References: <20240313214218.1736147-1-bvanassche@acm.org>
Subject: Re: [PATCH] Revert "block/mq-deadline: use correct way to
 throttling write requests"
Message-Id: <171036698538.360413.6777553266929994961.b4-ty@kernel.dk>
Date: Wed, 13 Mar 2024 15:56:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 13 Mar 2024 14:42:18 -0700, Bart Van Assche wrote:
> The code "max(1U, 3 * (1U << shift)  / 4)" comes from the Kyber I/O
> scheduler. The Kyber I/O scheduler maintains one internal queue per hwq
> and hence derives its async_depth from the number of hwq tags. Using
> this approach for the mq-deadline scheduler is wrong since the
> mq-deadline scheduler maintains one internal queue for all hwqs
> combined. Hence this revert.
> 
> [...]

Applied, thanks!

[1/1] Revert "block/mq-deadline: use correct way to throttling write requests"
      commit: 256aab46e31683d76d45ccbedc287b4d3f3e322b

Best regards,
-- 
Jens Axboe



