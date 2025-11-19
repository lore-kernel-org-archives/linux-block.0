Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF704307AC8
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542269; cv=none; b=rMB5IrX7+5j3wFjJYeOldtY8DrUpmN0/RYWENrkxfFjDw8Ije4m6shZXTnbsOoH+QeoC8afQm/ytwUCHh3M2AcTbkQohaGcm3Us1DExaATHquIG4lHGQkqGvUCPe/ilZkfRGGAh/ykIIQvDn13+Hr2l9tdAXq5KHxlx6poAq5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542269; c=relaxed/simple;
	bh=AQ+2CxvCiM88ZhmPzjJ0Jhx+cilMoeuKk70Qolj25Gg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=m01I8jNZaosrn4waAsnX1DfwPolGo5D3Fv4+btNNTKLhX2yU7Uipqykosw7IPpccvfvGmVGcwUq6ZHVv0A+wzDLL33+NE76hTntoQAbcRXWaBL22EIhJPewXOYnYDzBfq8JsaY3bS48guh34exZ8SNjxxg1dG5ub7rhNPOiEdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=HG5RDAL6; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HG5RDAL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763542261;
	bh=M1IN3WYuyjmzCW1pnmbDsQ2nmNIg6F2DxLfbwYll45c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HG5RDAL6Mm5vG66hpMuTJDVPOgSDNn8tNYBz0F9IMscmUd/CVnvIXDnRPZp2Be5tL
	 Lv1HoUIUhmtIVoGD47KNZ7Ism3vDk+opZtheXK4I+qxjiJQ8B9gcf3P7TlxWNhrhxO
	 hF1Uv03tntCwFmVEpMBuic4YvO5T/qwwwdFt/pNY=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id CBB958BF; Wed, 19 Nov 2025 16:50:59 +0800
X-QQ-mid: xmsmtpt1763542259tbwh2ie8l
Message-ID: <tencent_58CEBDF202BF42BA908A9EB9D5C7FB5C6B09@qq.com>
X-QQ-XMAILINFO: NA8WCMn5GQiMi196/3kq/QNfqwzZAqecL1l1v4viMFGCiip/dH/13xM2EINemo
	 bCBiM0iSZjcqtSuGUZSF/jROyWiTSJhNPZ6wNCr4j1fOV0YpJaElAhaKaVMFvG/2Q7IobAB/fKdx
	 Vd7FwzjM6HWhGXIGWJBPTLBfNJDq+E1YbVZ1RtsVCclWQ6UDGqKdJdoSn7oVzs/I7BSHCDnaSPcq
	 x3nTNPjhfnWgbKinc46QP5omWW4DyiiwVzGEzEPhc2uBG1PmqtO1Vb+Yio9aqwul7fr87uSvWICR
	 eFkVpC/aQ7Q8ki8nSBHuvLjxJdBE70zZqEAUKtQOBfoVXV8VJPa1VbLimtGJ3TdvVdXNsRt8TQ5+
	 jJi82eOlecsXWdGjFQXa9z8bqmx4OMxr1oVD3hDRP0/NkQ3BIjYDnXtIyQwjp2p79dauW0ZytfzH
	 J/zBKgGgtpYtJqsts8uHAB9umSzOcvXk/96ANgVBXkCjZfkZXvAazWILPLzJNAC+cHMLOJa/JIx3
	 keZEbx2Vedky9MzNWXZqwj7p5zE/ekXn/aUxpLKnp72FziIRcg6rXAHfPIvWGpzAeWCIGRlUBoZH
	 4oxYK/aIxgq2b4SvhIoeWBqW98Ge2BP9EG1VLXEWJ2QiWuCNKkXShczpAL3/K43S1Q2QqVYGeQBE
	 MnZuyiDcD0AdgjnvsTChWc6IaKuS0tnLc4VAN5oPKE82eEsQIu1Q4rx5Lub3FIC9EeHlfcB61QXW
	 dDRndmkdzx1aLjUSdsdw1KN3vgMrbLCdioyWknZL04p9owAhbj9Y4Q/INRfGcaAIMYPGQ4U2pS+T
	 D1NOs2i+HuN8IcSVV5WfaVq6zMyqSb2Ed7wwXFoyNB1D6KuxyI8/TRMe4XlRNMWAPtLHhdnn97mU
	 ycaOAI6HFWtxjyOAf2NkSMB1ZeBLZwQ0jA+/SYcGA8go+8TLzsbgSf51OhHneceHnkApOryqWyDQ
	 M9fSTYwOoOszzJQ0VoHaAcpqa95OxpQsFGpfn0DYCPEaOt8pjngLWzkVXbORQPqp6ikqSnkcgGI0
	 iiKwnpLViqMnUY8/aU5xZirlT9dDbZAVrutAIZdcmjLilLLlkX7V4hcAKCm5pNe1o93BdYErNbuT
	 ZXUe3Mnq3OksQHRuuMGDY2PFuzBNv/jbqnZbh7uEsdwuaNbHjCZUbi8M5/Tg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: dan.carpenter@linaro.org,
	linux-block@vger.kernel.org,
	senozhatsky@chromium.org
Subject: [bug report] zram: introduce writeback bio batching support
Date: Wed, 19 Nov 2025 16:50:59 +0800
X-OQ-MSGID: <20251119085059.2935387-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_EF2ECF2226EEB0712DD7EFF3963CE1AF9107@qq.com>
References: <tencent_EF2ECF2226EEB0712DD7EFF3963CE1AF9107@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sergey Senozhatsky:

Regarding this issue, do I need to submit a patch for correction or
resubmit the following series of patches?

https://lore.kernel.org/all/20251118073000.1928107-1-senozhatsky@chromium.org/

Thinks

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fff9e45..30c7636 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -818,6 +818,9 @@ static void release_wb_req(struct zram_wb_req *req)
 
 static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 {
+       if (!wb_ctl)
+               return;
+
        /* We should never have inflight requests at this point */
        WARN_ON(!list_empty(&wb_ctl->inflight_reqs));

