Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4451A121
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167749; cv=none; b=ragVP9yIaI/gVCRZFIDe/4JpfUlJ2M3ht6bv4KoEuB1Bc9kIgA2+5kFbkilwhYYTMwyfJBNZ4yl5B0QCDcOAgaGYJ61Ued6DOfsYKOcdz0CJ/7QQdLUb8Vgfl4pw2XNIDExMwaNXTIVZFnB56+hrj4419adWxhAv4bWvNXQrsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167749; c=relaxed/simple;
	bh=UYDMdqSUplZE5D+txNJRU4CPQP3hEwMC4gHkUXth6y4=;
	h=Date:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc; b=cVuvcsmSPTmvn+3U3zWrXXxdUpKryYhaHJQgqy6aczd8JJWTiqPK5TzquGrgzf0255ZwctmCX7+pXGEBWiYE+nMVKQBMVXk7Rd8EyQKioFCI3nIDVZvKQWW3G6s2z2yjJ6Dj8nVAT4pBi29JVEeeO2vtMEBFawxmtkghliFTsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A4RPWCzI; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A4RPWCzI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792167752; x=1823703752;
  h=date:mime-version:message-id:in-reply-to:references:
   subject:from:to:cc;
  bh=UYDMdqSUplZE5D+txNJRU4CPQP3hEwMC4gHkUXth6y4=;
  b=A4RPWCzIsXMtnJ50ZJGDg5fW7S73UMDRIQQnrvMH0S4fivEmqLrrGCbZ
   +fsioBPCTydhEWHWdLkTPRV/vU+hzlgOzRvk2OOQ1mnb/O9z/mAT3R1LU
   ib9GfjnOT5amK//dT/P/0Em4BMppSuBuQfkGpGTw5qHhTm1o7p0UddTph
   pqn9/vEFIK8Qnx+iNZWkQShw125HNCbz1tKzmz+qO10eBmdPCLCmmu7qn
   WZ+ME8e6W2v8Fcq8o4PWOc0JxmeLEf+vZEplyAMozH7beq4yx+cXHQ5/S
   HLzfPuJ0enFGYSx+VL4vNkD+x5weKdnBMasZUFOZXdoyDUrZmCyw3CFCN
   Q==;
X-CSE-ConnectionGUID: W6UcaiOCRIy0EkyJt4+JlQ==
X-CSE-MsgGUID: yCy/scuYQ9qEHGruJtLQdg==
X-IronPort-AV: E=Sophos;i="6.27,162,1786982400"; 
   d="scan'208";a="158170347"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2026 00:22:31 +0800
X-CSE-ConnectionGUID: TlGCXPbXRZ2b+wv9Ydi9uQ==
X-CSE-MsgGUID: 07H9SmpERzSagKNJytTb7Q==
IronPort-SDR: 6ad24f41_zeAv0dk6LPDSmx8ZHxQMlKQO8+w8074vWPrVYFwFnVNDtt7
 Z+Aw5B2EhYr8czOnoxGOBX+U+FUxk9lXUP6ivjQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 09:22:25 -0700
X-CSE-ConnectionGUID: WlnhT3epSyq63LAsS21qhQ==
X-CSE-MsgGUID: D8iswixiSg6KJcB3MGZ2LA==
Date: 16 Oct 2026 09:22:25 -0700
WDCIronportException: Internal
Received: from unknown (HELO kpd-linux-block-557bf6c7f7-td27w) ([10.149.64.6])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Oct 2026 09:22:25 -0700
Content-Type: multipart/mixed; boundary="===============8934074163686485219=="
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <52bd3c015dd078eb947ffea0c9a3e6b0fd8c20593b5796cf30bcb8a4fed51a44@mailrelay.wdc.com>
In-Reply-To: <20261016073253.520971-1-szwyb123@gmail.com>
References: <20261016073253.520971-1-szwyb123@gmail.com>
Subject: Re: [PATCH v2] lib/sbitmap: add KUnit test suite
From: shinichiro.kawasaki@wdc.com
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org

--===============8934074163686485219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

Blktests CI has tested the following submission:
Status:     FAILURE
Name:       [v2] lib/sbitmap: add KUnit test suite
Patchwork:  https://patchwork.kernel.org/series/1187055/&state=*
Run record: https://github.com/linux-blktests/linux-block/actions/runs/38868812396


Failed test cases: block/017



--===============8934074163686485219==--
