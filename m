Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.71.154.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794132726;
	b=oHnhmMTFyjm6+DAfz62rgAkl3FXf6X8KpE9Ao56plhOxSlMC5KFYIg7Q8ToP1PaTqXxT
	 X2odPgRFu4lgEWvNlCw7Q7n1cTnVRFbePIest5vCfxxyUV50KYBoZQn6Z4JOV9df6DRZN
	 Eg5qPxmqOJ8vugCRA5qsL1n5C3/AHhvgqTJ09OetvQrQjymsh+BtMuoCs6NT4vXDuijxH
	 lxMw5hrsU9RKq3pzyxhjLQLMb5koaaUo4TTDMaMxkcSjBHIUaM6WFEzQgTSy5Y3JLpscA
	 cslUEprz30C7WF7Oz8HchLJK4GQPryoEnDrVEg4+pttaI7CoPs/+pDp5j+Yg0P5maRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794132726;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 IronPort-SDR:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:Date:
	 WDCIronportException:Received:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc;
	bh=/NdeVAIj6W9kWL0G14oD71KrYnFFm/wDE3WP4OMctKw=;
	b=ghh0xKTXR5nuL/f1TnVokTn3wZvCeDAtNyBq9PVE2CLF/zbpErq9FvfZVSajA10hskhJ
	 1zCsnLAFnZpZGqhrpzg1xWkj613OECVHjMkaDFDlPz15kOGxDO4SUfVlWcv3/2Rl47HRa
	 r7KSlhNSWIkKYcTqNQoLHWiDZUD7PnS7RJveWtXbXaDLxDHJjrfTFK4ONO2Bzgwmfadi3
	 +21CNbjuDjM7knlCI+a3Jk0I+BTD7q3JaP7SaHAAiGdmtURsp3jQpdp/kW5IzesncmwOT
	 DNv2IEYQtAELyAlPMqrDe9Ihz9apDLG9c09IcAT66oUXNzvN0LWjWRFmU9lPVP9LFsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Q6pQlHXJ;
	arc=none smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF34606A31C
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 10:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBF34606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Q6pQlHXJ
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794132725; x=1825668725;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=Gh7wCjsI3rEq9SLKDejf/Dz0fkpjBkHmAwahucGN5UM=;
  b=Q6pQlHXJG5CPkr9Mtx+LHgPVBYyQNjIO+Y9GSXT1a8Gw5K8pQBWmXUQf
   rz9vyNqxEO80+BILDiIC4+Jmltz+KWc4RC43jaTVwswzgpJgIyZoY77fp
   RtURevB1ObHBB+CncqCAnuZZbj86KLFViPuio/kHzOg03BA8hlM4xcaMq
   MaMWreLrXFF/KESKWGbCHjY2WcD0yS0rtldq1Tl75tCkEFdcSM2FtH0cU
   zKnjvA5mluha36qYWDHqX6wRO5tIubUBXeMOs/SsLBpCbRxU4j7H415Af
   CDU9NbJNZ9FIvpxmhxs8wP/LPd9kAVBg00Hl4TIpRn2NBVa5zu9GGxuwZ
   g==;
X-CSE-ConnectionGUID: B7kMfQ02Ru299rti2PD4dg==
X-CSE-MsgGUID: 8Fmp+TISRuGU5TW0FMX1MQ==
X-IronPort-AV: E=Sophos;i="6.27,200,1786982400"; 
   d="scan'208";a="158622144"
Received: from h199-255-45-14.hgst.com (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2026 18:11:59 +0800
X-CSE-ConnectionGUID: U5PNipNdQlehAVlM+GKb/A==
X-CSE-MsgGUID: OO8Lb5XuQiqd3SsRffbSPQ==
IronPort-SDR: 6af04aef_sI4iHlj8v0c+mG6kOB4wongSnifwGDfHIUcqeHk3gOISxxl
 yELALmoDx0101s/s/rr/J457VpveOEJfO+znR5w==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2026 02:11:59 -0800
X-CSE-ConnectionGUID: Xcf+KzGHQhy6uvNvWCJnFg==
X-CSE-MsgGUID: i8/YUkgxTv+M48RToMhZ7g==
Date: 08 Nov 2026 02:11:59 -0800
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai1-o.wdc.com with ESMTP; 08 Nov 2026 02:11:59 -0800
Content-Type: multipart/mixed; boundary="===============2085698874300141093=="
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e8553327f2610f51d7800c1bbb1544201cead9fe05828d82975a7f4e9245d30e@mailrelay.wdc.com>
In-Reply-To: <20261104112744.1630864-1-stanleyjhu@google.com>
References: <20261104112744.1630864-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when already active
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============2085698874300141093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when already active
Patchwork:  https://patchwork.kernel.org/series/1201669/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/42332857390


All test cases passed



--===============2085698874300141093==--
