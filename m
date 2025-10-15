Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E212305042
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555708; cv=none; b=SqEXMO79qGB3V8uH4CKgqtHU+1CAXsW3xiz3ePbmaHHfJt/vzMUI+jRkg8ZFKtkIUpLhttVYpPln8AG/8OYcdNgdLzTj8Gj1c3ITddFKI3z5QeP6ZsIC1RHLDVL7MHb0mRkoXi34QZw7uqb9QIArVjf1whuQLvy/BYQ/e0VUcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555708; c=relaxed/simple;
	bh=4g+VrAgjmyuRBWOxx4agSFjkPAiOci6QHvAGDqCcK4E=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=ZcTSbsorPPnhgxOtagHY0/nUAB5rvPfEuHty1sKvuKvO+yvh85ZVZ/Am78Pzrzv9t9q5GUHXojl+xl9lwG5k9jZnlO8QFMZ+TBkdTvOtw9QuOh/WzmEpQXStNy0DUx1hKREAH8fnS39MwMr959wMA7OsJg6QixwwZ8hovd/1RGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H13rEzYh; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H13rEzYh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760555707; x=1792091707;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=4g+VrAgjmyuRBWOxx4agSFjkPAiOci6QHvAGDqCcK4E=;
  b=H13rEzYhj/Il5dS7k6j4jBFbRyPCI8EdDO4LfG8+qwnFK50TgqEVJK72
   SyiciV8Ci+Qu+mLzFHkxojm4jjGgDJ9We9UB1/m+5CVlZtxjAy+mYKj/v
   d4ujd6BYGZzUMxNoF4yQoSuCrdFwnIucmMj+OXxdiGdu7BLx/ZSxkf+/U
   S1Jdv1jsds39lm8lYbIzFNM0cD/OK0nNZE6ogtkQ7VegmfBtkU5gSkneh
   iI5v6S/cU+J/P+Qoeb56QZHUeyWIEbX+lEoCXn3Nak4k5CN8VYG1iSu7H
   0PMamhRfqp8+BO5XcLYXAdP0exbj1WLwK+CzNvnLMrKEQFGkUhuSyqVTr
   w==;
X-CSE-ConnectionGUID: 28uulbmYRcWSAgm7UWzAOg==
X-CSE-MsgGUID: s2lAMEVhTceMBLJAEU0Wwg==
X-IronPort-AV: E=Sophos;i="6.19,232,1754928000"; 
   d="scan'208";a="134231035"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 03:15:04 +0800
IronPort-SDR: 68eff2b8_TTbXKdimszXSzRmV9CPh7dhbQcY0up9NKkgcOL5vaxEn8IU
 g8KAxns2XjolfnVm5tlD6h2XNlHCaXnqEUmSeHw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 12:15:04 -0700
Date: 15 Oct 2025 12:15:03 -0700
WDCIronportException: Internal
Received: from unknown (HELO redsun45) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Oct 2025 12:15:03 -0700
Content-Type: multipart/mixed; boundary="===============4188629793210510028=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c13a5e3f257ceccb70e3d63869d8a9b6d963f6242b23690cff9d9ca7b9dbdf8@mailrelay.wdc.com>
In-Reply-To: <20251015014827.2997591-1-yukuai3@huawei.com>
References: <20251015014827.2997591-1-yukuai3@huawei.com>
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,dennis.maisenbacher@wdc.com

--===============4188629793210510028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       blk-mq: fix stale tag depth for shared sched tags in blk_mq_update_nr_requests()
Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=1011590&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/18524669753


Failed test cases: nvme/057



--===============4188629793210510028==--
