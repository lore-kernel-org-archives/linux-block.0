Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716295;
	b=Q3EXOiNGJbe0yNobaXmwk+5Njy0+vC1Zv9D/xi1SlfMRw8KwEe5eo/jON/Sfe1zZrhyH
	 SKm8AptY8TjJMj41k39P4Z6Yul0ZADr5imal04Ar06GFcuYVSl40RCXQ2Lv/LzS2GGvVW
	 93jOqYwrRo+J5bO/9fxO2edizsXkIDX47C5y1jz0NeU3GZgXCyUftZjqW+QomGugyP6DQ
	 dRRgMWG+ZSzIwGedtC+BjnAWGiAIuYrz8XtLudLmorWshGQNd9UuGQCD5EJCWzQ0WSRwn
	 tEkMmEI/eMzXjqkUi/vAx5sJTXOnGWG6V6AwEmVm0GjdEohS4M4Q1Idg1CTqr7WETXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=KXzabl41ZeEnGrVAYqexhOU2oRggUUYi90hmQPge7Yw=;
	b=WtQyHyUOSl8mfMPEqxopIKkFwQDGQeFJV0w9ZGp9UVJ6ygc/NXJBrMSgWkiDZaI+x7ZK
	 M90ynmF6MOaeOUjLZYNmgBxGyTGasNbDcpC9Ja7KAO7u1T2W61SE4X++JD6bB1yAST7Xo
	 RZPRp349ERZSF6kJ2BRGHVxY7mJJYC7irWM+ZNfUXgYWSlZxQ5r/bH0+IO/fELgTLap2u
	 z1UNIiiJUH5memBUSNkv2VczkApGg+/oRDqS4BknIfjSCT8zY5Qv03NchncmV8mkLDu1V
	 0y1FYYLB87ooC7q1z4wnXEnKpGXNvFbRFGsTFUdv/pM6g/xcFTe66JDtjukb5J5mKzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gCUl3iG4;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55660850A8
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E55660850A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gCUl3iG4
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a8cc11ac42so4165691c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716294; x=1794321094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXzabl41ZeEnGrVAYqexhOU2oRggUUYi90hmQPge7Yw=;
        b=gCUl3iG4R2jpywA1QQ9kJt+qOfE9h0zR8pM3mDaJcggKmtXx55bVra4P/CXDOGGj+/
         imZ08kKIS3RRKi4i1kr6kpejvmVS50Y3yR7/XTpaS5JuhBBEOCyp9/9i1kYWs6MdYrQl
         yLtTf3MHm9JQIo5zKXozqctrL9NL0pQ0pByG+gszIzL96BPuMiiHKfpG4l1yVo3qHknC
         ivAQ90QDSnWP+Xtrq1eQL0PFOdlXaogQ4drK57lZtwum7/hFDE05T7pd4xyEf/U46DKW
         LFl6oY2hd54Rfff9+G6Poc53Z5yB7GGzRMUmBl8axg/ufh8NqvuvLVva++p1tJA/A3o0
         obPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716294; x=1794321094;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KXzabl41ZeEnGrVAYqexhOU2oRggUUYi90hmQPge7Yw=;
        b=upfSTsO98gycCCFfKUKR8/1vspGSvue2y48CIjnY5i33vRHQVU2wiVfEkcuC/mRRlM
         5CZJuWq9VS6USzmF7Ogo/1gKnZG28bZWchsL4Igmk7cao3WI09pXsFBsPjAZ4aNSjleN
         Dh66Lszwz462Nvh772jbgYm6vcIFcHO5itN+T3iigpCA/VzdHEepZiqyqvsR/YeBuO8B
         S51J9uYcofNirttH8/oO2bakLFwun/VKCVariU5xSup8yT575JI/McW4/4ijl54Xxm83
         +Ae59HBEB8ZmWIlhljzGu3fY5IZcYiwMfk9MMemFGpDwTdj0e8YRF8xVUEiC4FHFtiEY
         0d1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzdJXh+BmaUe6kl6MOb5ig5/r+E8IUvIO0fEMtve3IlBlnENU8s+7BC3Zp2M9jK2ly6QD5DhTRKFPKExg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QdfKCcoMUGuhtnJmQb/QBEc0jEdLYJUzRd7tXhsJdEMuz7Osd
	mjXL+bohvSJzW1moFM54PezngLge01E8DDB/zPxiZs/H1xhm9lsg6MqMvI9b/QC5+sk=
X-Gm-Gg: AYBFou3AnNYQjwGK7iuXw2Kci1s9BmHvCK0yEshMosaMVMrPC1Nl3aCtlRnJ5gDLvq2
	zmbNHh5wvoiaWcpOrZrbXKDgbB+EkVdo6GvFeRhtMss1dXgqIKikH2PbpyqcAmcOnNf/FUkldlx
	qZnxGnXAzkHN2+5lqFnOPJmTA/C0MejlQy48hW0DgWCxFL4EMb5mEbI03bd62jy1Idi1FhdaWY6
	scR+CE0xQElX+tZ6liZribUrWukZ6ozRQ7wYtYAsxSJ6ImRE71bZPy16CZQwHlzhgzTqNx5AF4k
	USgsw/XhppHzyWMbHNNcIOGQ90B37bnsY95D4kxm5JQj9Qj8e3i/YCvzo/+IyWWMzyiaFpL88Cv
	vhIRV2FWNt1JnaWD55X6I320AKBxiGPSIne/WB9b9k/we0uVc18JEn4NagK9yKAULjeHtT/wt29
	9HhwGadhiUbmLMYutO3rgvSinwl/BiF0J/NmB7qHW7LjLIjZwJBA00jbMq2+mQBQPjeNbIHuKOi
	WPN7LqXkTg/kQQgjTwFV2CdzP9e3Ow1NqKJH6rkMztjK8sB45FXTHyX6VeWmW5vw79zleIxr6g0
	CoQciGRyCG/fgPQnFtTOqJvkmPI30ggcGOewzRM88Nw/pdAB8mp5HHzEcKPu/FpTn2XWp7eSZY0
	/WNnJJ6CcIKgl
X-Received: by 2002:a05:7022:eb44:10b0:186:5b49:90d8 with SMTP id a92af1059eb24-1ac5782fd31mr21082249c88.4.1793716294128;
        Tue, 03 Nov 2026 06:31:34 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, Zhe Liu <liuzhe1@kylinos.cn>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261102061802.408173-1-liuzhe1@kylinos.cn>
References: <20261102061802.408173-1-liuzhe1@kylinos.cn>
Subject: Re: [PATCH v2] blk-iocost: account flush sequence latency only
 once
Message-Id: <179371629271.3691261.11171025306527479565.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:32 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 02 Nov 2026 14:18:02 +0800, Zhe Liu wrote:
> A flush sequence with a DATA phase can complete its original request
> twice. Both completions invoke ioc_rqos_done(), causing the request to
> contribute two latency samples and adding the same queue wait time
> twice. This gives such requests disproportionate weight compared to
> ordinary writes, distorting the device-wide latency and queue wait
> feedback used to adjust iocost's virtual time rate.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: account flush sequence latency only once
      commit: e9804489e27dd6e33aec5511fe3780ff3009f57f

Best regards,
-- 
Jens Axboe



