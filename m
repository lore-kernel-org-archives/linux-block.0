Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45463286D60
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908809; cv=none; b=WXFrwpOsCM0+efaB8h5u8gBhU7WLoQNiUY95uIeMFVWren3gTk/RmVIrssZZAM5N6b6nZsefMJUnD17EaZ09scBY3dhybbVNApdhnh2Fm43D148/d/SGXZsfhydGREpGGeZ4ez8HDio4wwk0lOEzwia4nAXtkj++5jq4rU8qXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908809; c=relaxed/simple;
	bh=EGGw3miVGv3g5cGs3Y5Uv6JSfXmW9UFpDJgLxjdqzMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKlDlSC1HPvkCvM6gSt9Qd65HOoax62uB/y3ebv07oLPTiWWn8LGVJgNtfoG6pU9HsrOawQG+PRr+XklNXkaJLP0KrFDDRItODtxNClvIUjt53mQ9KvupY6RCQmJ2NhE0OKC1349oDExGV/tvNvE64Vbd9BiRQytIQNHc5CfQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pux+ojDq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pux+ojDq"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84830c774a0so1047449b3a.1
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787908807; x=1788513607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dn4vRPgsu9ZH/AxJw/yAM2v9xHesMIpX1FxiYpcxLmU=;
        b=Pux+ojDqr4IkTYpL/QaDQYtR8zxovJJRNG43i0Cv03tV+hOm8SMKWWvNJoAdTDYaF4
         MpnrXyWNSuTkL6KL14753V55TdQm0aQsXuiIZE76CUNbGKXrXyKIKch6Q1hpl8Eb8CLq
         TtcURFnt8fDtIRmCIWFPLWSFf1iQaSjWVvTYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908807; x=1788513607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dn4vRPgsu9ZH/AxJw/yAM2v9xHesMIpX1FxiYpcxLmU=;
        b=gw3xdxGdPtp+PTTaiuA9nNXWUPgaS9M4PIQVseukSkozczwP9DW94zN+O07nq3HXXe
         MOEHLLoaKwQx4rfqHvZgqE27tm3FD+TdTJoUZBinRDHXkX9tU58U3wP6LwP5i7p7A9Pn
         lWd/gZW1/6j5QWT3f+5HWSFS0XVFP+VPgZhMeDOOZapX/Ftvq0ngf5xMIXEQUTZyya9Q
         TUxuIqIcHOmhow5WWi1JCjuP5sMtL2TFJKV/5+zLUfNvWYF7cohN08rfbGOnOavnddIJ
         c5xwGHHAmUxdr1dmV5hkmWay+DjBiX2eFh3HrA878d7D677dlxnD7HcoKtfXnNlQmL8C
         dAtg==
X-Forwarded-Encrypted: i=1; AHgh+Rrua3qX+esPg5NfIPy78lxgfbt2VKpuBXNkU0a4vYQCyz9xOsqqbcpjj3qevO52wAApTIPajamPp2JbuA==@vger.kernel.org
X-Gm-Message-State: AFuF++l3sJJzAZXh50DbFB0IfF9Ov8wDd2OY1ZkYlVsOuqdN9jAc7Y3u
	TYIFHOdYSZzTNL7wMjUeWRYuox6I/xyvEbyX9gunyL9Cc3bKum+ZFTng4Ohn7XT47KqT5U3UXGg
	Wc0k=
X-Gm-Gg: AR+sD11S18YaAdJKAqK4cIooy6VC4PuK3fiSXuzG3gNDR/aA8FQpBUDrWYZ+WCT8h3N
	MNcVyuzPr5GPYmfe4MNYc15NzTMJul/qYu917XEatsPcJBhZpViyknhsdNW65JnVNVSs3PCvGdt
	WFfL1AA+p5+irpUaJ66fm7rlS36wDlsJlPYMNaf+KeSoe2SGBcIWYeZNMtM8sgmvW+78XjHwwZB
	ZG2gUPANoezsfwagdagynHROGIBue0y/xaVNcSuBkAnYIcmrHMLe5GUmK5kKGiUtg0E0zXReEbe
	UMvrSInlmPeFflsm37BMmDpbZYQtQatmWXWCR9NoQYvr54YB6q6TcNc5OmKnItcKbRYvEu53iYS
	xJqMgiDxUxEFXTunA8Jpc6BpN07QBX1scpVYeCytp8NlpPnPXG/1ELJUi3t9JuHFRIOjf5Owyq4
	RmPtEnuZWCWWbpG+GWwI8j7XYiVaQ5AmcjWKthz/264tYKHdWeKNYmYyCylhECGGqBxOwVBIuxm
	34lJzqP9qQd3TZZxpXakSMEH0cy
X-Received: by 2002:a05:6a20:4499:b0:3cd:9dea:2be1 with SMTP id adf61e73a8af0-3d263ad82a1mr12426617637.0.1787908807449;
        Fri, 28 Aug 2026 02:20:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a804:e404:4b31:580b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f68bdsm372314a12.3.2026.08.28.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:20:06 -0700 (PDT)
Date: Fri, 28 Aug 2026 18:20:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	akpm@linux-foundation.org, bgeffon@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
Message-ID: <apFSk6cEmfHNGstC@google.com>
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828083149.45760-1-jiahao.kernel@gmail.com>

On (26/08/28 16:31), Hao Jia wrote:
> After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
> idle_store() computes the idle cutoff as:
> 
> 	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);
> 
> Because the left operand is cast to u32, when age_sec exceeds the current
> uptime the subtraction wraps modulo 2^32 and the huge result is
> zero-extended into the s64 cutoff. mark_idle() then marks every entry as
> idle instead of matching nothing. For instance, running
> 
> 	echo 86400 > /sys/block/zramX/idle
> 
> on a machine up for only two minutes marks all newly written pages idle
> and hands them to idle writeback and recompression.
> 
> No slot can have been accessed before the system booted, so an age_sec
> that reaches back past uptime cannot match any slot. Return early in that
> case, without walking the table or taking any slot locks.
> 
> Track the cutoff as time64_t rather than ktime_t. Both cutoff and
> ac_time are boot-time values in seconds, so a plain arithmetic
> comparison against ac_time in mark_idle() is correct and no ktime
> helpers are needed.
> 
> Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")
> Cc: stable@vger.kernel.org
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
