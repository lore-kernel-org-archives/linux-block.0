Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.71.154.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794133083;
	b=fBcDQn6AXq6w3WWxbTK2ZGvH7PnbNqEDWvQ27S8j2XTpf65QMWbIQVaTM9KxAdA8ezhl
	 k2br0zMYNPWFKzKiz4p8/d6KouourTIp+wfGmRM3lpbsVOYYkNGvwmBFx6ksy8/G+lyLK
	 EuyZblyLA2xXWgoqxJ7jJ1ZZZQIGf7CRyuJlI2CHaWMQit72DGV0vr7ffLfvgMVfxvCpJ
	 7QYPCQsnvvve3hMcb74SovgknTMHQL4e7yE6wufYCFPbHZEgAyiKsmU5vAxBN3it1TKyo
	 ew3CwX3HXe+gs8gnDEufADOjsb3DydWpXjka64xum68cqsMLmfDu5Ug34rYleFCHQ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794133083;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 IronPort-SDR:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:Date:
	 WDCIronportException:Received:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc;
	bh=zS4JF1eTeOngf5kWbJemXBVZgLgl2itQKSCXcQhkB00=;
	b=oh38EU4McEuEIpWYkltUO6fhW512sY+liwNxkwuwLdeZuLt6tHTcKfDHRATDfkxuM7if
	 mqh2aBUmNK0sqT2xBht4dhTSFgRpbfEKHWaYHol2JZvOUZLMyaRN3a2wg6vsnAwTZuTTT
	 zWBKn6WKTscqYDzDnjOmVPBdvsapLxqG1UgsGUgcw6GA403YPqdM6XywWBNsBo2/+rcRI
	 maXn0ffdiTaShJo3igfqtol6R8b6l+J+HPvzP4Z73FwB3mYo32kpQqLx9LYw40OakahyQ
	 QWE1pfzcFeR4+lKPo+bP76gPZdhBXwIwU3bKuwGqv0kpmQ4pcZhc4JUS2+Xcm/92sWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=oHKotyJT;
	arc=none smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE51606A31C
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 10:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEE51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=oHKotyJT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794133082; x=1825669082;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=jARfpf3bKpBYSSaDvi0WWVblHdTxcm5RrFJhWavqHqU=;
  b=oHKotyJTyaYYvGNI3kzEhZXCWp9YH64GcnBHgOUs+CZ3PT4+0dNkkpqF
   p24zMaeXsmHsroh1JOybRd2CkkuyhWaqz+SPD/TDnu6WFNFFKtrVgzky3
   WhDj4W4DNMLp9pwKol2rFVWqS27dlaS75JdHLGOqEYtZAVCSpSAaA7FyE
   ILLq9cGdLSWHya7Gxr6Uy/aW+213+N+iGEm2fiI8kPUfu+kk9v2So9NtF
   G85WiOdIhd8Bx0wp2/YBIeR/wweZ045nz4Hk5vcid6WPgqJTWSKeqfFR3
   ZZG+NepgUwNPajE1v259G8v/ayDkVVcj0gB8bMf7//73EV5MkEWSy5aCK
   w==;
X-CSE-ConnectionGUID: S4rPZHyFQS2MCrIaTcHP/A==
X-CSE-MsgGUID: QBOyRH5URjOajCvjMzv/tw==
X-IronPort-AV: E=Sophos;i="6.27,200,1786982400"; 
   d="scan'208";a="155999016"
Received: from h199-255-45-15.hgst.com (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2026 18:17:56 +0800
X-CSE-ConnectionGUID: sukxLNXjR5ahQlehgYjcMA==
X-CSE-MsgGUID: WzdThV07Rmq9REJ0EHsYEg==
IronPort-SDR: 6af04c54_q+4EEIlNmlXV7saCKmd2bjWSjF6OtjIxzMKSVFnmF4mnF01
 PZmEBrcteBIYmRGhx6sdORaSahshLhlnhi5ABqg==
Received: from uls-op-esai3-o.wdc.com ([10.248.3.41])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2026 02:17:56 -0800
X-CSE-ConnectionGUID: cLxdXyGsToKx5nPNzXPJOA==
X-CSE-MsgGUID: ZZkpsy7RRbW7lwet9Khikw==
Date: 08 Nov 2026 02:17:56 -0800
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai3-o.wdc.com with ESMTP; 08 Nov 2026 02:17:56 -0800
Content-Type: multipart/mixed; boundary="===============6663253625647307065=="
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1206b71f943ac96cc3b00de0fb728fcda31b34a6283f4651da5127ee3b5f1db2@mailrelay.wdc.com>
In-Reply-To: <20261107093531.619041-1-tjdqudcks0424@naver.com>
References: <20261107093531.619041-1-tjdqudcks0424@naver.com>
Subject: Re: [PATCH] ublk: retain server PID generation across timeout
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============6663253625647307065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       ublk: retain server PID generation across timeout
Patchwork:  https://patchwork.kernel.org/series/1204811/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/42362474433


All test cases passed



--===============6663253625647307065==--
