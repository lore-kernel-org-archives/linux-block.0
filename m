Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D3346E54;
	Mon, 16 Mar 2026 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644031; cv=none; b=sUVLDCXzCM/H0k0wVFvH3Fh0lKs/CyoXEunHbiqDOHS2aL0uP87dBBX2tNFgabzmnOR8MyWA/bddJQefyuKBxwrEkJfapWz9dn+AObQ40Vo6e6ld00+AJlGDYD1ixYdsOD+SAVrhTke70uo509rS85aV4SfvCmfyf2BDCXAK1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644031; c=relaxed/simple;
	bh=rJf6Wag6top7ddfXWkudtd2/wCEtMJWUIyS83d15JYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0oOdejyuoO/9LZX7FIvHnkaG/6Urv/Bg8GTmGJ0OmxQSAx8e52/SrISrNBnDi2Ho187ZYtBg4HVxc+TlF80B1ArVhEwoAvK7lOo7fMexoU07rb7DIDwIkZ8RzkawGS68sDE2rYJSulbrPymfoliJbY7OFXz0u9IZMhD+O70YU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dXwFveEV; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="dXwFveEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773644030; x=1805180030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NDgrda0PArO9FXJA6xekuXZsyo6sYula1ULpMPfEyGM=;
  b=dXwFveEV+0TlznNqzTBOlHBKFuseOdkr9ot/YO2jAni03kB03t394O2X
   PbwQ2yD2jfWuhoYUm319iUAcLchRTAbhC9yZEFtUGDrSDk4ra/y6bu9t0
   +BeP8z+0/GIimwgP1TAT/OneLrpsbMe3MfNyc1DJNBgP8qjRpeYW11KSt
   zyJUU2ucteP1+kIeE2bUu/y2ffBmgbmzwm87ZzKca2qCrb/ynb8ExRisI
   BOueW5Hk1fd2dDadLlf5soY4u4heDSFfvDQ4a96XGopEulXidDDxNxHL+
   tsM8qHm+Oqk4t9EqZbTmZ+Hfgo89k3dzQcdcfOo4fb5xdkaNfmCRmGo0g
   A==;
X-CSE-ConnectionGUID: BCwT7ftySkiZTzpI5u/hZQ==
X-CSE-MsgGUID: w8N8Vc+pTbK6B56skVzqDA==
X-IronPort-AV: E=Sophos;i="6.23,123,1770595200"; 
   d="scan'208";a="15102142"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 06:53:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:24880]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.23:2525] with esmtp (Farcaster)
 id 5efce3db-7e6a-4c6b-a215-daed90ab2c3f; Mon, 16 Mar 2026 06:53:47 +0000 (UTC)
X-Farcaster-Flow-ID: 5efce3db-7e6a-4c6b-a215-daed90ab2c3f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 16 Mar 2026 06:53:47 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.26) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 16 Mar 2026 06:53:45 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: <yukuai@fnnas.com>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
	<syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>,
	<ytohnuki@amazon.com>
Subject: Re: [PATCH] blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default()
Date: Mon, 16 Mar 2026 06:53:38 +0000
Message-ID: <20260316065337.60071-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cd42b95b-58de-4d47-9895-f1b5ac7d499e@fnnas.com>
References: <cd42b95b-58de-4d47-9895-f1b5ac7d499e@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 16, 2026 at 01:03:17AM +0800, Yu Kuai wrote:
> Can you also add a warning message that disk failed to enable wbt?
> 
> Otherwise this patch looks good to me.

Hi Kuai,

Thanks for the review. That makes sense, and I'll add a pr_warn()
for the wbt_init() failure path.

For wbt_alloc(), I kept it silent since its failure can be caused
by e.g. memory pressure, which doesn't require diagnostic
information.

If I'm missing your point, please let me know.

I'll send a v2. Thanks again.

Yuto



Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705



