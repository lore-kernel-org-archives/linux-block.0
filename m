Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246036;
	b=whwMpobe9LiJtxE02rezvQTvMDwMAs7oSdaAzbJtcCuhpRNtegKEnKN+i/FBhAsVm17C
	 dmsxrVp9DolLckH7msUvpGZMXlndu6r3plCv8V9wr/yxbmygbVi+bHQgSjiIhurOHVxbS
	 m5wd2/EINiZxAzDmRuRNV6UaIpBY27GUSz2us1GluczwJ4RqcOj6nj1n+FJ/VlRN4K3KI
	 TbJ0y/EKL1WiA5GG9UKF2nFRemb3DcCat7kfB857Nbjw3IVtqr/8hcDJSNp/QrSkLiMHF
	 4CzPmNWBldCg2aGcOvYZmAC12rwHNiS+/5mBSiJbRj9e1XE8fWP0sBgzHjbWajuaaZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+ahcXpVCd20F2a+G4V5LP2pky9vopGhw75vYoQmoXKw=;
	b=ynbNOtIGt0J9TskxKFQaDbjimrhpGhFF23xIhvoDcanb6Vei3bmXS1UVBsInu5g4+zt0
	 W3IA63nLeo1vEAaasinzoybwzsBh89uQH8KXO/BLK0IvXiw20h2A+mT6RXaV6dIEDqE6L
	 uPnAYKeToWOrAHO+TNj4ZBz9vOuyXHgciVsHs5ssctXpzgo+5QD0oW/PB2Dkk3eutXeuN
	 l3vUKqmBAJQ8KpFsY+9MsXe6eDdw/35VZgDGya/P06OKeAMtGH2jE43Y9i4OZLJx+IWsj
	 9kjqA63AqnnWl3zr0lRUEvBDABNZyC2AQlKxJvNAUvm9bkxX7KsCl3j7WsP+m3A0BUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p4dmI1LJ;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDA606A326
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 17:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21EDA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=p4dmI1LJ
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so1109064eec.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 09:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794246034; x=1794850834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ahcXpVCd20F2a+G4V5LP2pky9vopGhw75vYoQmoXKw=;
        b=p4dmI1LJPNk5jQiwEZao3oY2TlPt01k3t0JJ7G8MddtvRCBswZ3PC4M0Gk+pAQoZHc
         dvyLa+pu5Fz/N73NCy1oc+mybufkzHSxUV7uHwKGKBqe7bkzjJCbHyUWib47n0Xr8+yo
         ow0QOtsBA/ZtIe2wAAH3OGN+UiIT5w2oapbGSW+V26MSB8tcYrZR1JgSnL82JF6jIz1c
         p+Ajt7iJhL0bxOvW/yt3fsc11Fi8oXMbXfVwIEZPul11kO9OwtX0Ov2Om0n1GRuY7bdJ
         4AjSD7ydPjCyqfkePqfa15c0apxPxRkOk8oG8e5V1ry20OqPvjbZSwH6K0y1DMjqj9Op
         uprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246034; x=1794850834;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ahcXpVCd20F2a+G4V5LP2pky9vopGhw75vYoQmoXKw=;
        b=xA9SqyCkbw8V+kU2AHMWeDXQktLsoXfRNP8eOPwrlgIre2QTKHKabBR8PbefTHa6UN
         Sv86aC59AsyotdcX50DIuv1dhPkBTbdloHeIVU1CyCmotI+M5gKAl6+9KwQA7rSZzmwQ
         J5kgA3SyetGi1lTr5MPQ/OK6LflkXoeXE+C1ksfL3WFrldJooU36uOvx75YctBvYJO8t
         wcWL5OhzpeFHhYymC41duBuIViXZHButTxsAua2epVQW/Ph3qps6QIMupRCTcbmF+KF8
         elVhysRszIKa/887LDX2HqGADW09hyHpZp+rfB4ag3Zynp6PwdZS0FUGUm3IIu9cpBC3
         XtpQ==
X-Forwarded-Encrypted: i=1; AL+hErHBp0+lQRxvTmNAoDPUQ7K8mfE6XfiB7ogt2lt8nYwwygz84RefgaMAJcPD3Aa9Ojn0lK/kRe8OFMXbXg==@vger.kernel.org
X-Gm-Message-State: APuU4Z++rFwD5/zL1vtrHe8eBWnrXPtpSmsu5V/Ad/61lyKjEkR6xVk5
	p3Q2E2htZN+zTH/TMgf1ku/1a0zQk7sB72CfqEANeHEfO9Uq7+ZO+2lXV7KarypjoB4=
X-Gm-Gg: AYBFou0etdRewgWkeiCpchBYDjuho+7R/QdaDVZDxJJ5CBM+jqSAZ1ghD/r+cM/y258
	NRhXtckxm1TUyWp2UFXlPvcsJspgua9ZTGM5A6HfmRO+BefAIvhyHuF7eaZCiHPdpRs8aDzW47S
	8FRIwJiZHwX1KM9RzXi9hl1xCbFnKYdueAqgST45X7L2P6lecjf5JQ+an0tkYcFeYxO+xz9Xdfp
	fzs/jCw/qhxzD9ewKcBGjWpQF/zCRed7dE37GrRHcsRzf/W8EDKWRS20EVKokr8D+eT53cAVjZR
	AKxO3uzp3cR5dVCBVFvzUW8VXYTrP5snFO/SGOs/hxaRmzG57wGZWXh5bm4KDr7h2HCBYOjQ/ww
	s3fHO0fA8EDe6s5r3Sn5GTOt0wHvKi+UaLC4JfM1v01lVZ/OvUYB+qf4ZE1xyHJz3Rz6gWLW9CL
	7fSuGQJPhCYYpTw7uZjJ+oqHnaRij7OaauqP3xo+Lh/mRnoI4wSPT4SSAaor3kS+VbXXULasWG3
	PeAaGlLy1SBt9bnk4r9ImgSftKrf0EMijHBp6fmeaeWX8lP/fWcObVNHQpg0cOkWDuVGV36T/Dw
	0N5fIg3Fz2h4oH6FxIwmki6tc60r7zUzr3bvTGZlMCl+5UqVB4sNIrfXThAzAWYduGMqpfp0+7P
	5X1ImL1gHcAg=
X-Received: by 2002:a05:7300:87:b0:361:7ab9:479d with SMTP id 5a478bee46e88-3725e34086amr7318366eec.27.1794246034049;
        Mon, 09 Nov 2026 09:40:34 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d48bdsm23580324eec.28.2026.11.09.09.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 09:40:33 -0800 (PST)
Message-ID: <4d67e54e-8076-4c91-9c26-0b79d478f590@kernel.dk>
Date: Mon, 9 Nov 2026 10:40:32 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drbd: preparation for DRBD 9
To: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
 <avIA1j2pX46pzOr0@linbit.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <avIA1j2pX46pzOr0@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/9/26 10:22 AM, Christoph Böhmwalder wrote:
> On Wed, Sep 23, 2026 at 04:06:01PM +0200, Christoph Böhmwalder wrote:
>> This series contains preparatory changes for bringing DRBD 9 upstream.
>> Each patch moves a piece of the in-tree DRBD 8.4 code to the form it
>> has in the out-of-tree DRBD 9 code. Doing these steps separately and
>> up front keeps them out of the much larger rework that follows, so
>> that rework shows only what DRBD 9 actually changes.
>>
>> The patches are a file rename, comment and internal cleanups, and two
>> higher configuration maximums. Defaults are unchanged, all existing
>> configurations remain valid, and apart from those limits only the
>> wording of some log messages is visible to userspace.
>>
>> Christoph Böhmwalder (7):
>>  drbd: rename drbd_worker.c to drbd_sender.c
>>  drbd: modernize the file header comments
>>  drbd: raise the socket buffer size limits to 128 MiB
>>  drbd: raise the maximum resync rate to 8 GiB/s
>>  drbd: replace the drbd_interval bitfields with a type and flags
>>  drbd: move the packet name table to drbd_strings.c
>>  drbd: rate limit log messages per object
>>
>> drivers/block/drbd/Makefile                   |   2 +-
>> drivers/block/drbd/drbd_actlog.c              |  16 +-
>> drivers/block/drbd/drbd_bitmap.c              |  18 +-
>> drivers/block/drbd/drbd_debugfs.c             |   4 +
>> drivers/block/drbd/drbd_debugfs.h             |   4 +
>> drivers/block/drbd/drbd_int.h                 |  59 +++-
>> drivers/block/drbd/drbd_interval.c            |   4 +
>> drivers/block/drbd/drbd_interval.h            |  55 +++-
>> drivers/block/drbd/drbd_main.c                | 106 ++------
>> drivers/block/drbd/drbd_nl.c                  |  15 +-
>> drivers/block/drbd/drbd_polymorph_printk.h    | 256 ++++++++++++------
>> drivers/block/drbd/drbd_proc.c                |  10 +-
>> drivers/block/drbd/drbd_protocol.h            |   4 +
>> drivers/block/drbd/drbd_receiver.c            |  61 +++--
>> drivers/block/drbd/drbd_req.c                 |  40 ++-
>> drivers/block/drbd/drbd_req.h                 |  12 +-
>> .../drbd/{drbd_worker.c => drbd_sender.c}     |  42 ++-
>> drivers/block/drbd/drbd_state.c               |  15 +-
>> drivers/block/drbd/drbd_strings.c             | 138 ++++++++--
>> drivers/block/drbd/drbd_strings.h             |  27 +-
>> drivers/block/drbd/drbd_vli.h                 |  12 +-
>> include/uapi/linux/drbd.h                     |  12 +-
>> include/uapi/linux/drbd_limits.h              |  12 +-
>> 23 files changed, 534 insertions(+), 390 deletions(-)
>> rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (98%)
>>
>>
>> base-commit: 85bffad4d2fea373a72d68bed8012e8cbccb8ee7
>> -- 
>> 2.55.0
>>
> 
> Hi Jens,
> 
> this never got a reply, and neither did the subsequent v2 drbd rework series
> that's based on it [1].
> I think this should still apply to 7.5, would you mind queueing it up?
> 
> Thanks,
> Christoph
> 
> [1] https://lore.kernel.org/linux-block/20261006154607.3936501-1-christoph.boehmwalder@linbit.com/

Queued up now, v2 doesn't apply anymore fwiw.

-- 
Jens Axboe

