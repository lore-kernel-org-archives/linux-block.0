Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.71.153.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794130736;
	b=hFKw5ROtdNrui55/K6PzN+NFImAxVkJwy2siI4lSX/RMrtMnbJd5XkbYhZilhJwx5/eK
	 zYjTUNLOBCIodIPx7LnFdQG/ScAYsz2jweWy6la2DYbnBbF3Z273pZdUw1y4Tkwz1QIhp
	 SgstIIvaEipy2YuU9InVdOxifvTy+4vEANReYVp0IqYr8c7JQX1XZA9J1patiILzsij5k
	 Qs6uCcQ+xwBDHm0xSFiKp1nI+z4y/KcGYaOamXY0LVe5ce0cY1kc4pZ9hq7DjmgXj4P15
	 RWmpksNXkzG/nrmF8kChBUQYq++zrpDwOixL+K7WXRl6NqUeKHhQJuLKUXUwRSQ3s4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794130736;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 IronPort-SDR:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:Date:
	 WDCIronportException:Received:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc;
	bh=qv6RjPuwW3UNAhTTOhmHJNFdE4XLm39J+K9roHB3Wng=;
	b=5sCbq23H+2hWJCCBvbVX2pwNwuiflLF3Hmsw9NwI2xauW0Ysiw2d9znG9oUVi2tcSE+z
	 5eFnlG/ppWrviMwpxkL1uCBQfY3yeg3CzZXN7ZI3DDH/Pf3VlxZXI0XjTqKWW4Qb1sdr0
	 +JtRa9A1W1jqxcy32twx3QPnGooLNpKIL1KQwIezHAQo+//Rr7lJL4OUIH/tMoys4zjzb
	 f+Z6dhA7im0ErxQ0DYTzEIY6QRb+fDKoAaqs0iIWQXzW9lv41H46/omzCtmQIQMntWNCB
	 PuavcHTiQWZ3pWnb5UtgB2HiCnn5g9zKslf6Rwhdzg0ojvwqb+lmIXWTcAeQDuIGffg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b="INy/+0pQ";
	arc=none smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317F606A31C
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 09:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7317F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=INy/+0pQ
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794130735; x=1825666735;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=iWXyEL8cZ3iUSO2tJv9QwHQtEz7B9UbkNaS4ayQGsUY=;
  b=INy/+0pQOa1go4kjd2efk96UegsSHyCh26Vijq8Mh0y7C19DjOPONXH7
   nuFpx08aW1qI6IABgz4LZHOtKaw98MuBCXw5QqwCKPT299GVfq7LuU6p3
   GlRFrgZyb1Y+ozQJzW3TKfMJrCYGn6L7XCyq2wkzY5kYRQgM/P7nlK4vS
   WEIpzDMrpSsWK6nA5PCyoGGzWzH+SPo4zqeJImY1K3Um9CPd9TRe0kgDN
   8grxu3oInWV7fFlXE0xYRmV8MHf9mhd7sY2i9AYNqAzp58Z/woptTIx3L
   e5C2hj8zVatfXCfDs2OQm6OkJqqWwgCZ0dvtpCUTjQ/4hjRF+U0H4gltd
   w==;
X-CSE-ConnectionGUID: Rgz3LVGVTOibVkiSCJrutA==
X-CSE-MsgGUID: UX8PkWl4Qk+lAxXgFUFtQw==
X-IronPort-AV: E=Sophos;i="6.27,200,1786982400"; 
   d="scan'208";a="160229531"
Received: from h199-255-45-15.hgst.com (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2026 17:38:50 +0800
X-CSE-ConnectionGUID: xTgoqJBJT8O2YiypjuFHjA==
X-CSE-MsgGUID: +d/Kv6YgSRq2T05yDjnxTg==
IronPort-SDR: 6af04329_m8SkZSYtQynxAK59Kubq7YM92CRIm7Ce/Kn4AbGUSGAq8+u
 Mf4SDAZlmwIZg4WaBTqpXIQX5t669Fb8rCqaOrQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2026 01:38:49 -0800
X-CSE-ConnectionGUID: /XG+ZSvXREaWEA6YR3cfcw==
X-CSE-MsgGUID: ejF0gbv0QPG4xYpZ/WiGsA==
Date: 08 Nov 2026 01:38:50 -0800
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai1-o.wdc.com with ESMTP; 08 Nov 2026 01:38:50 -0800
Content-Type: multipart/mixed; boundary="===============6858274793268776436=="
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <de8e07cab4eeb9861e92cd2b14477d7c02c3ca5f4dacedf8abf6e9a4be6cd271@mailrelay.wdc.com>
In-Reply-To: <20261010111525.1337458-1-efremov@linux.com>
References: <20261010111525.1337458-1-efremov@linux.com>
Subject: Re: [PATCH] floppy: fix the message printed by floppy_set_flags()
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============6858274793268776436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       floppy: fix the message printed by floppy_set_flags()
Patchwork:  https://patchwork.kernel.org/series/1182942/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/42335906443


All test cases passed



--===============6858274793268776436==--
