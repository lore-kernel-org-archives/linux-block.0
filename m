Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6A3C3BF7
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947094; cv=none; b=MLQvsomgEQHr+Yxnbg7cYOLdiel0Gfqjv4jedIiFWJWKktDxP6Ktw6EU/Wf8gCp1QLfTZZ4Ns16OKgTIxyCBEKSCT0kaJNyriqDj+9Y+c79YZ6G5oRHPXBlBeyQmeSakvAlNMfMa8TJONjJKh8kpavfs83D46KhuPqcUOt5IUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947094; c=relaxed/simple;
	bh=ZomsxN/1sP30LU/4cwSMez4Nohh++fOGqcimBYXrO0k=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=dvWurD1x24AP4oXpXzG32bJ1BLil7GwMKi1QwozYm60AydR2ZOSCsx23XWFYPTzTuClPJkUSzcJmF1laRdf0S3felCDu2EiYo8wj9le8aRUgdL2nkGZHwr77ebgzx5n66TRSBzXZxnquzyEPhF3128T/sFIIm8Vy0cYt+4Petvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YqZHujFT; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YqZHujFT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791947091; x=1823483091;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=ZomsxN/1sP30LU/4cwSMez4Nohh++fOGqcimBYXrO0k=;
  b=YqZHujFTWMDOFiq0N+p6XzMgYTUxhf8l7uwv16JFPyqNG3+WheGh72Ca
   +Oz6kazwkGmiXGFFNAYi2A3H97VLzPOfv1C/Am1Y1NKZ2YtLPPdeDkNDK
   mStIsmfbOArdE9/p6SmziaPorRD1XXK7J+xj/i3qVmVUB0AlY8jTZwYPk
   a1SMx/AZR3af7OYsI4pXH3v90uVyh4eWVws/wOegwPSFf9D3c3aBBV0ys
   jjDLwgffu+6qNz97pJ94a3UeH6NgXyHW92yyRdPiShEt4UHFZVmqVmZfx
   k2WCQ3jfILze3sf+0XD9/RwC3HO3qJwsKWsX+QlyPFYVGhl30XUHNPTST
   A==;
X-CSE-ConnectionGUID: YNdr0wdZSpm/QeHmrAUa+Q==
X-CSE-MsgGUID: wRl0QULdRYSzMQJWPojLfQ==
X-IronPort-AV: E=Sophos;i="6.27,156,1786982400"; 
   d="scan'208";a="157927944"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2026 11:04:11 +0800
X-CSE-ConnectionGUID: gOBavG6CTMeMLa3iokDZ9w==
X-CSE-MsgGUID: wMNA9JTjQS6apecFN6MQDA==
IronPort-SDR: 6acef12b_ix4dF6m9eOlsOVkHFww8aTrsSMmzazaxeExQgOYI/rcbsZn
 K9D/NOlNEHeo9z35h78wbuFnSYqWciVG782abdA==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2026 20:04:11 -0700
X-CSE-ConnectionGUID: +2MrpOvYRUOL+6kxNCQVBg==
X-CSE-MsgGUID: IM23SJlfTaSXeqNTHGenYg==
Date: 13 Oct 2026 20:04:10 -0700
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai2-o.wdc.com with ESMTP; 13 Oct 2026 20:04:10 -0700
Content-Type: multipart/mixed; boundary="===============3133196678084092365=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a99313f8e07b8eef09229050598baf914fea410a5b07ccd515822ebd9ad9fc29@mailrelay.wdc.com>
In-Reply-To: <20260928221634.43239-1-haris.iqbal@linux.dev>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
Subject: Re: [v3 for-next 0/3] block: delay support for error injection
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============3133196678084092365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [v3,for-next,0/3] block: delay support for error injection
Patchwork:  https://patchwork.kernel.org/series/1175637/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/38472940769


Failed test cases: loop/006



--===============3133196678084092365==--
