Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834144;
	b=qyvqt+IJuRvHc7/w9ZFf6BWsVlJWkabb+oImQyNH3c0MJsm85g95nOLxspu/4rwWRx8V
	 TBqg4aIwlUKZXHYeIQJ+tVerxm9w9ouqSCMh38rv482CM4/LykZRSTwKXXFaYe99USaar
	 ksDxXwX2CeWgJ2IwU5CSYyev+KKZeQ5eUvPtn3zSW90mSrTtJvPYq26Zyjyf0HHmOGDdp
	 zyvOAdhD0thbI7ZqJ9yHQWba7JK0N2hMh0hedBPl+13fCRKzzXuchP3zb66U9+U0Bcj7a
	 QnrwmRQ/2qg6cLvG8BgNDeyT29QyioIXSoObn3yHJIScutsd6LzOQIhQ6sLhX9FYJUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=epHX4+IRmuNiGKc20qQXYTxzY88O7Spqzl8rwSurgAM=;
	b=gjn1LgoFs4mcIut8n9bsRSH4KsIKj0pLY8Hf3EyA5r2lHIUsMDDRF+EZxnKvIDBPVTTU
	 YNz/oVJ3LPn1V5zEFYYEsmV9Gsr1yOR12e0Wy9B/s2tx0RZ80uTSgFzvijaKnhUnqkDqV
	 8yM49UWtqbalBRojmMfe8LdYkXSB1J7m3XIWWmLaCfAz7X/1s48qpka91OEjKl8moX207
	 vQug48tjt+anxuR5u+FuLhC+lgNUuNlOw7vF0G5+03Nac+086oSGqWOtJNMl/PAff9f2J
	 JMRk894tkwcOu1Tl63yH+7AHLAc8AwtvcqHniCHHVvR84hKRtYQoduWnwH/slVIJ/ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b="LV/h0dgw";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284A606A323
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 02:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2284A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=LV/h0dgw
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38699cf08dfso11183841eec.1
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 18:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795834143; x=1796438943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=epHX4+IRmuNiGKc20qQXYTxzY88O7Spqzl8rwSurgAM=;
        b=LV/h0dgwgnVLBXCfc3PU4g/VVkNz6uYCMB8wCp/Cvospu89xjwxpoDvuklb+t5KBQo
         OFoGjPTP1IdC+2gxK/4sVmxArHSoQgbSn68seK+Vq3x+JHBPnHxYRtG/WAuf8uRdUFdz
         krnh6ZRBsbDoBtx4jg64PpYYQWeBGiiQGPq1RA+6wS1bgd2ZDAvWfzllC+QLRdx21/jc
         w8MPeIUuK8TKvZ1joWojIURXG2xoXRRDZcKPrjvNLTunlEhVkrqTQwhDGelXSr9c0Wg1
         b+9EFRK0YjL/o0LpQPQgbGPUm9Idw0qbX0tfOR4nM2M/MP93oJoGMuzoR7rX6nem+6ff
         215Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834143; x=1796438943;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=epHX4+IRmuNiGKc20qQXYTxzY88O7Spqzl8rwSurgAM=;
        b=NOlra9Yv4hvMnFov4krEypRoqQWSGLo0lEg4a0khqvsMEE2p2U+cW6VMP0jAOzwTMN
         E72kIRtx0JIl4aNledv99woW3qioHx+KzbzFpQT+RG3rB94Dyw2XNYBvFjsRFVUfpxbF
         7a9tocNuMlhZZim1VRZcnox0Hlqd6yGrtIrtp9V5YxTIdVshDSEdEJbF82nJo1aH2+6n
         JnuGyGLBzLt3tzlMPqUJmQozyJnUUDxyN7NIgcC2TVIG3tWy7VyCDodIRU/5eLAyx3L7
         d9+M410EqALnAHp/CCAA1A2Y8Xnokg5fwlQFyG2l8Xkna/mDhceiIjeq7SZRMAWxtORX
         cvPA==
X-Forwarded-Encrypted: i=1; AL+hErHMEYArzF+F2Tlh3fpwd7hlCbDtPiCvPO7fT6+vhO4eCMG/pc8rbyOsPqEwvB4WOj1tvkxy6EH6TWsT3w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/10Z/K6n2EfqQLiJXKAGaMREwDYTl/vpN/a2CDQHA7m0JUP9gZ
	WkrBz6Qq/bDqz360TBP+Ua05nUZsupC4hHIUDP0aDgmV5LYG9hwLd45essBGnp3NcTzdBljkgxI
	Vgv8VLZw=
X-Gm-Gg: AZFdTZd+ERzaiqfPHDJHXxnJF1+DmyT5xlWT0zSx/kJiNH5A14z+ewIWZfcZT5/i4j9
	EoANoVwXAXzeIeThaQ0SMN5oRE+VGQSnhv4d7RFBudHhYWej6ytTNROL7/QpfJetWzrnKmSKbq3
	REiofiRFBQccBLgEqkCaUBKD1xbDtYVzX0ocvNyVXL1W42m9OZJzqeyOWYU+0CYXwuGIbdxymzx
	bxdpZnhqhQtafvVHAIWxwBZkIALsF2IVg/b6SrG+ff70RJO9OlRxlGblX/QPGml4fSugXQ/LNga
	wp/Oxab3bIBr1s8FVVGauv1cg2+4mK6YhDz/LI0GsKItYrADPPVEhzhN5EmrwxbiA/Y50gDzQ5n
	P+BT3VSmrICrniY3gbW6L6XWBFAGtro+LCtkD7ALk8N9ZsU7i+gsZMh0sJo/bxEPZ421/aiyG17
	ax1f1exoF1TeZlCdkr6lSZl9lvEXxkGmq157BPdizQvv08pA8rS6PSHy/beVDTQ+aWbjKysQROr
	9ISHcEN9E4T4uMLPpURXIqVUDE6OnbYu3Y8u9sD1iOYY11Ql2iKiavcQiCg/22sgZmGJJGh3FJf
	PVJjSN6LAp42HiRHuv91nDfDO6Eq220JZrDIsYy9TwvBkj8/e3c35ed70kqeM1NtoW3GmdF8zr4
	Bp8IKcDRxbYtkyAWi+DhtDpLNMWM2dUJ3LLHViAOqhszroweH
X-Received: by 2002:a05:7300:d083:b0:380:f112:3cc9 with SMTP id 5a478bee46e88-3857093f06cmr25201689eec.38.1795834143147;
        Fri, 27 Nov 2026 18:49:03 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm72691991eec.16.2026.11.27.18.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:49:02 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: bvanassche@acm.org, hch@lst.de, yukuai@fygo.io, 
 linux-block@vger.kernel.org, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com, 
 chengzhihao1@huawei.com, wozizhi@huawei.com
In-Reply-To: <20261102080420.3774409-1-wozizhi@huaweicloud.com>
References: <20261102080420.3774409-1-wozizhi@huaweicloud.com>
Subject: Re: [PATCH RESEND V2] block: fix BLKSECDISCARD zero-length range
 causing page cache invalidation
Message-Id: <179583414229.87894.14203257367547275323.b4-ty@b4>
Date: Fri, 27 Nov 2026 19:49:02 -0700
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


On Mon, 02 Nov 2026 16:04:20 +0800, Zizhi Wo wrote:
> Commit 697ba0b6ec4a ("block: fix integer overflow in BLKSECDISCARD") fixed
> the start+len overflow via check_add_overflow() but did not handle the
> start=0, len=0 case. There, start + len = 0, so end = 0 passes all checks,
> and truncate_bdev_range()->truncate_inode_pages_range() is then called with
> lend=UINT64_MAX, whitch is the "truncate to the end of file" sentinel, so
> the entire page cache is invalidated.
> 
> [...]

Applied, thanks!

[1/1] block: fix BLKSECDISCARD zero-length range causing page cache invalidation
      commit: aea1c2ec03b399434ff1bafbb2f0d5076f74ce03

Best regards,
-- 
Jens Axboe



