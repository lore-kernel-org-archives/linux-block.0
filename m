Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C549AA4B
	for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277677; cv=none; b=KRFs/JLOeivUnLaFsk3njbufNZaJIzpCcgTmUg9LbdmZG++9gZoJR8RMLQqwRrPbRUaQcgbdEGCSpD69rIKMfUFCFBZGNPYiPOTiRkRgTgCZXxj2YfG1YhkBj9lngY843BhCMEg6P0bWAnzybAOBgrzJdUFEVkgL73S1J1g1vqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277677; c=relaxed/simple;
	bh=J60ML+hXCRy3+rpjiydqaMZkzrkVSLQZuGT89ZF/hSc=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=FMJdHFFRArG6fak3VeMjfl6SiP8h29hn5l9THct8NqHXRbLlpAvD/lvs2AWhkILSszttrRQFbPVjdBqvzeOb4S1udI3IOE+EKIchHlp79xx1byHzsFhLXx7BcdW3J+eEuHCxVDXpQ0pTY89TG/NysP2DAyVfyCRZn0dcRkoC/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GLxfkqWZ; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GLxfkqWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792277675; x=1823813675;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=J60ML+hXCRy3+rpjiydqaMZkzrkVSLQZuGT89ZF/hSc=;
  b=GLxfkqWZnLv1+iFtI8wJ60/1ugC4jImcWIGbr+kR0FQwhnHx4JNovPw+
   tszMds1gpP0HaAVgzhoW5FgL/kDWOccfW6wAy+5/SWfd7+j+wJe1TyLGk
   XbGxJm25M9FJhIyeNYd4vITfI+MjOsCVLiZIqHaTMUbbiiNbMTgYkAM95
   2mmOLb6pzH4682GB+JTIJ/B/QRDASPUZSsW39OHeLzR7V1a8Z3wiUkl4E
   46ck9p97/sIiBohuK612XRubE3u0Z8VYl+QeM01LXvArgebQeujfF7xNk
   haq+EiscjvbciqyemUhszES9RmLrccJCbmy3iOA/Zq9bfw8M9UEs5azVx
   Q==;
X-CSE-ConnectionGUID: SzYMdPgtT1W3aiMgKl2A0A==
X-CSE-MsgGUID: Uq3ZetoDRf6iKFf/TyXKwg==
X-IronPort-AV: E=Sophos;i="6.27,163,1786982400"; 
   d="scan'208";a="159306025"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2026 06:54:28 +0800
X-CSE-ConnectionGUID: BgVRR3z3TameE9CWR1RXwg==
X-CSE-MsgGUID: Dn1r1ngCRBe5tZ/1e3VPPw==
IronPort-SDR: 6ad3fca4_8e2vtcTE98oCgLvpLPOEntKZ6d2MFIXJCe6KUGkIK948HCS
 wCJUuzbkgTqaWTlDOYcoswAhfRtAlQ6eVFNyCfA==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2026 15:54:28 -0700
X-CSE-ConnectionGUID: QkX9q4tvQYqG1qIo30WrJQ==
X-CSE-MsgGUID: o4CVRg2GRWSwHUP6dv9Hmg==
Date: 17 Oct 2026 15:54:29 -0700
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai2-o.wdc.com with ESMTP; 17 Oct 2026 15:54:29 -0700
Content-Type: multipart/mixed; boundary="===============8940060324013029388=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25bc51e2bde7437dc692cd60dad9acb68a6522e6796b9e79d9b73c89eb1607b4@mailrelay.wdc.com>
In-Reply-To: <20261016091919.971295-1-anuj1072538@gmail.com>
References: <20261016091919.971295-1-anuj1072538@gmail.com>
Subject: Re: [RFC 0/4] fs: support dma-buf backed direct I/O
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============8940060324013029388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [RFC,0/4] fs: support dma-buf backed direct I/O
Patchwork:  https://patchwork.kernel.org/series/1187147/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/38999893251


Failed test cases: md/001



--===============8940060324013029388==--
