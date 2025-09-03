Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0B253944;
	Wed,  3 Sep 2025 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868198; cv=none; b=RHrrHfsPIDiKIZRFdEs/A3oK3yjAxi3tSrreWnGq2naI28LYbRuhCD1bxvwlnxPi9+0ia92PiNZRooVcXS185yZLNKeJjRC6rOeExgQvDdgHBIDQDlaC4f0q5oStWQZbE4oqdlHrygWd3ouhvOQoyppeo1PGcyHcm6Fl9VoEXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868198; c=relaxed/simple;
	bh=3S0O5j09jByTVKpKUxhX/L770aYSwCNoU8tbKyOPim0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dcxmJwsDFgySNJuE1+vAI6hCdOeItFfknawE8fpOSboJUIgI5LVmoTi5lVcq6I86JVDmJp9Wylj2O8JTW3Yu0xWPkKjjogcL2W4vsMDz0Kj1hx8TesXcprSImFe2TZJFuaK4xNCz0rf2aeb634ErRAAcBesPQ1NpfMRiFpP8OHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=nbnKhG+Q; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="nbnKhG+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756868174;
	bh=3sg0BqN482BG4zMESM20Xi2WG/XC5mgF+as+5lnUqXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nbnKhG+Q99WkAkyCiu26zqPF45mjyOZR58PdtMp+pGXcDLEp/WEHydvRXEAXSC/cX
	 ITV+WIuZ80Yvd2ZFicDo1/rGhU8JBx137ajZ45EsNwkWZUwubMOSEtPydoPGmeJi8T
	 hRIJR8F3IA1mo5WwwPiQgw4gkV8klBZ8e3ZRb6x0=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id DF7246ED; Wed, 03 Sep 2025 10:55:55 +0800
X-QQ-mid: xmsmtpt1756868155t9obqy343
Message-ID: <tencent_9DE422078550681A63BE8AC4C6DE7CB29809@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOLuX2YDs1H2GJIsdzgPRQeROhzzfEUa0iWkERuy4R4lH5cErN31
	 WgMVfS/nFAIf+ImufX4hLYQf6cvPbvdYfi3Mzd+mx8DX/txPNROxnRZq0bm6S+ojKCcYZa4UuZZl
	 X4TIZsvVdfY1Jh9n0DcyrDWb8L7BOoTP/rHtrDJFJLjxll+Q/3D9P/pjavfvdyeeRCsDAodyRS8N
	 5bkIMUe6Pnj/C41WF1FSB4Lk4QL/o68VgZAoN2xtlJtCtc09jzPmDCghbERvGNMa1yB65rsxdlJm
	 NhHy+Q+FjFdY9ZGB/5st0bq7escYVTw0EyG6Pv4ycs83EmHGAjrKG2mQu5xY/k2VpYLA65SNqiUs
	 fhvq8pNT4VhFXCCI+UvSERRDL0jp7UoLuGH6lE4YCCsOROATCew/0jkLQe9vBbDLJSr4gmnr0QTx
	 o1KAn/a1q1WaH8uY9/ws2rsdO2ZfSAU3xMEY23+H1SThmEMro9Kjet4qzzT6lqhOx8ngUOYciouV
	 rCGu3CIVkQ7opAG94csgHbs2A3AzQHvqQ4Upg98hXSkCVJTnNtnlaIERt23IaTzqpZ2X246nyPq2
	 49rg633uAN+8rBPnj0D7gzYLsdaMdPEoVyN1GU5rHrNt2NI8ImKtsAX2tx8bb2S09APP9YJ64hEi
	 hLvc7tYpn9p9hDK14phxN4sC39FkilmeLkp5pVbCVNpIxWUKiGsGOP7rJzp5y1S3zBYkSn4g7+T9
	 xnzMvytjM4mnnxrx1j8FKSLuRm35JmeJawIrS2GRlolCMa6ty85JHZixvfeXi2MFcoTh69QRw81p
	 W2y3CG8MbZMfoQ/oeEVPQ6/26VknD+onqgadzYobjHUIrYc99vrCLuw8H19IbmXOBXogHmwP7HeY
	 MEIffhWZOmU7iwhy/CYJiuu1Ck89SCD1Hdswi956EV2RIY4viIhlvLlWyxXKYZUSLEf/anbVSvLA
	 u0OxU8g0u5V/6iJxt04QpcjeK2mgGt+slky6MopybAVYMo2wj4JNybAJrI6DFotdWKg/AzAh2Uq4
	 uqcOxxdbhiOgLSfi1qExBC2B+Fv3EU8oxaH7BmYW2TDkx4AzOY/bt0a95Qh9kOHgzh0LWHHA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Han Guangjiang <gj.han@foxmail.com>
To: hailan@yukuai.org.cn
Cc: axboe@kernel.dk,
	fanggeng@lixiang.com,
	gj.han@foxmail.com,
	hanguangjiang@lixiang.com,
	liangjie@lixiang.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangchen11@lixiang.com
Subject: Re: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
Date: Wed,  3 Sep 2025 10:55:55 +0800
X-OQ-MSGID: <20250903025555.949316-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
References: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kuai,

> Instead of add checking from hot path, do you consider delaying setting q->td
> until policy is activated from the slow path? I think this is better solution.

Thank you for your review. You're absolutely right that performance 
considerations in the hot path are important.

We actually considered delaying the setting of q->td until after policy 
activation, but we found that q->td is needed by blkcg_activate_policy() 
during its execution, so it has to be set before calling 
blkcg_activate_policy().

We explored several alternative approaches:

1) Adding a dedicated flag like 'throttle_ready' to struct request_queue: 
   - Set this flag at the end of blk_throtl_init()
   - Check this flag in blk_throtl_activated() to determine if policy 
     loading is complete
   - However, this requires adding a new bool variable to the struct

2) Reusing the q->td pointer with low-order bit flags:
   - Use pointer low-order bits to mark initialization completion status
   - This would avoid adding new fields but requires careful handling 
     and additional processing

Given these constraints, we chose the current approach of checking the 
policy bit in blk_throtl_activated() as it:
- Doesn't require struct changes
- Provides a clean, atomic check
- Aligns with the existing policy activation mechanism

We would appreciate your suggestions on how to better handle this 
initialization race condition.

Thanks,
Han Guangjiang

