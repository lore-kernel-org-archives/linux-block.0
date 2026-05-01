Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34E2C0323
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631656; cv=none; b=sYX8zbEopCdSztXNHFsCf+Gc0wpQNniOnwTv/HTHuTBIVMkDNJgGwfDcHtwbWc1/3etR/GfkWNT1EzqMNFkL+DvZjtnvdbs+UOeE0QOTikxhYQozOQp9okFJw2tY21QJ3BiurMdzMq6SU5iR+uozM06xQacoNjjZA2HVHy3NwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631656; c=relaxed/simple;
	bh=SJJGbq0Lp9abWJpDyYkDz8h6b67iDCtV11DqsSAGxYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojCV9r52kP+F1rRIHadYZVA+eFu47tWMf9ZDoZzOPXl8E0eeJqKjZvL1OH4KyhnqA5fvcAYwNThGx7Sp4jcPIzUhHFLACqpPNxweioWzCE0gjN/onqr7Vkxm+HktL10kRFzIsyW5ze4RzdkFbDPXmxyUZT5cGXFBvd4fTDs9Lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QTEFf2rr; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QTEFf2rr"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-415b23dd6e5so689219fac.3
        for <linux-block@vger.kernel.org>; Fri, 01 May 2026 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777631653; x=1778236453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJ5ReIcRkI2Y4lVKBuR5Yry++OHbmRN9GLdv1yG04S4=;
        b=QTEFf2rr5dDEM23sa6xEI73CVq3Tj8WF2B5KPSNx2ng0hw1Uk0eNz+ejwbwwpfgJOl
         V+BGHs8oQiyyVpHG9ePCo3gvbDlhfna+LVa+jL7QwEMTnO7xgUQLez1/h21RpGMOn3Hx
         iA7oZaUpUFxH70Sv2/w9mvG2+KigLtwuL4oaqv/8vzBD92H4yZ2sxJESMIlQjKjWJfTj
         Bds3CT71njX1UWPK/VG7/sBdvZcKTRDWLT/6o11R/LKp+bREvUNL4NP6zx4ggh51CbBZ
         IGPb4u2GhB3qcO6x4zsBvikntlSEWLtcMg5GEzl/qeEX63SGGmdp+1tZigxE4B4Cl+S4
         zMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777631653; x=1778236453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ5ReIcRkI2Y4lVKBuR5Yry++OHbmRN9GLdv1yG04S4=;
        b=WrjlprkWKo40yasPrJDfAsdRdhSlLHmT1LavtNNcr24oVHP3/xiSMkE921IjyMaNi5
         zRtVIzUfj11zHNhHY3esI8n9lRk5Y1KvBt5K/xu1bvWpBEeOgmU+7uc3TtNTXvvkJtmw
         Ums2bDjZErdI6/HrZaiKc+aun+wdOzpTVRgGv8X8yVBue0YtDOyVH0f/VyqoOTkf97Mk
         WxOl1Ovys4CxpnwPAADJvsPZebFS7j8IF/iLl2QM+D6beg31qrQZ99cmtqKzE9k4ubtY
         ayyOJb4el59F1K7vuerq4oBZrahf21NQMFvZeFU/xAn4VndrF4iSQ5c6NrRiTMwwMVPp
         VarA==
X-Forwarded-Encrypted: i=1; AFNElJ8jluWo6lI9FGyrVCF9TYAx+x5VUwC+VlWQ1Iu2aHJ+rHnmN66/4MlX4AZbO2ZypQgkLn0jGC7/cKNolg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycaOnS0ZrmsWUDNoQn+uFnKZ9VGBjnq7SQP8oDQSTYAALp+xOs
	3RoayLwtvJSg3hnwvV4AOGo3X6EK1l6VtO1apbr35eQx+ZuCj86c/86fIqMgLh0PaJg=
X-Gm-Gg: AeBDievLRBr96sOVhCwq893zcGUBujiNacgjxEuN2Aa3zc1MvsedNQN8y4gKArUrsqy
	ZQk6JnJrrnEU+mWEYq2t2VQfnFClzYQrjVGIarwq8pknOfTRjDFYXIXTqibi81ATZKLWBjJ+Bvo
	SJYleSf0ghTQCcbh4ycfp4Yu3SZWG6DZVlvhauumwPWUjNFXejnQlgL7hfVO5NrI2MErrwOQrj/
	E6tqbSa1bRH2iiTfECAhAWjM7rk7sDbIQiEQ9fcktLZV/zCSm3qfv9sZr96c6tiN77A7aCykVJv
	FFoFoxR2HP79Abw8FqVFHhMPJr2QGyAzBw7YifmKe7+MTKDA1d+eFw9MEUSVzaXgOi5Z+wqM7zl
	aXGQlOS0IztldkpcO0V/4tLoIpkQdh7G7hv/5Y9/5/sAOnZ7jbhx7sY2GwqwK+lLVpaicq3vioz
	UsjleMF2I+JsswkHeHYkcPtcIGpzTazomO4qBdPcs+BY6g1AGmd740in8D3CLuH1YAXKKWixMqy
	b3CSHLbFJSdavrl7+9M
X-Received: by 2002:a05:6870:b523:b0:417:c2d1:fc37 with SMTP id 586e51a60fabf-434340400a9mr3675473fac.30.1777631653291;
        Fri, 01 May 2026 03:34:13 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548c56fcsm2363059fac.4.2026.05.01.03.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 03:34:12 -0700 (PDT)
Message-ID: <9efbd035-b40e-4155-8382-b42acff75a9e@kernel.dk>
Date: Fri, 1 May 2026 04:34:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: reject FETCH from non-userspace context
To: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>
References: <20260501085216.905401-1-tom.leiming@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260501085216.905401-1-tom.leiming@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 2:52 AM, Ming Lei wrote:
> __ublk_fetch() sets io->task to current, which is later checked
> against io_uring_cmd_get_task() in ublk_uring_cmd_cancel_fn().
> With REQ_F_FORCE_ASYNC, the FETCH uring_cmd can be issued from
> task work, which can be run from io_uring's fallback workqueue,
> causing a task mismatch and triggering the WARN in cancel_fn.
> 
> Reject FETCH if current is not a real userspace task, and it is
> reasonable for failing it in case of io_uring fallback.

I think this should be caught in ublk_ch_uring_cmd_cb(), which
should not hit ublk_ch_uring_cmd_local() if tw.cancel is true.
fallback work should just be terminated, not be issued.

-- 
Jens Axboe

