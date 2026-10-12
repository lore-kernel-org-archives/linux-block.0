Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2F38B122
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771237; cv=none; b=PhYdcugnT9k3lMmJm9dGCeSGvbmvT9VRMhk5pLaHYeqZEdvIXfyNZf/6QL+xxlu8fzWq0pptNILAgsfqVYRWOu6i/0z9S1UEtyaKcEtFCssCrLRjK8eD0PDAg/v5LPj9bDaRnqUXPaCFm0oKjsgA2N0MrMQvIdWie7RLiY4RgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771237; c=relaxed/simple;
	bh=j01GDBmR1TIM6DVgkFqGpR4ryULyVXSnsoFXKqh9EYQ=;
	h=Mime-Version:Content-Type:In-Reply-To:Subject:Message-Id:
	 References:To:From:Date; b=Xt6sfMxTahsrHqmYWiraCeNdcPBwu2yTHY4tTu0BYtXyHw9eveDy0ndDz56EvLHXAskDbcbh1z+tl57nGePCwsuZoRczUUDHPPjjCyUry6+akuLJ7bGWL2z2s3vTSR5qg+azf1Ma2wL3xhpD8CMEcG8N2s9CrZoF1SEZAH2yTyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=hbk6jLiJ; arc=none smtp.client-ip=209.127.231.58
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="hbk6jLiJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1791771224;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=lu7XLhYj/wAdPd451zS/VZFck9tcvSV4+oZcODROWk0=;
 b=hbk6jLiJ5RZq64562fv4z84w/p9+Uck+WiRs3Hhmw0fLc6lRlohD276YdDh0SzN2p5BC25
 mkSj6nZFbFtkmLCPEcVrTP2Ke2N1hpvlz9SfwKC8Rc7aYbf97oj45vy11kVUNZ+KD/UGB7
 KC+RaUBYIYGzXlFn9Ts6z5d9GRgTb7wQVmVoqLMeDEsZBBu2duJOyVI0rz2iS7LLGMaPEC
 Q2rqf5X8IlnFF6I5GjTwIJvRwqSFI0JS8mEr5a5v/ApnpUWavs7a/HivZlSaRQgrobaHiP
 EHRkTGY+5UBNeBQungEy0LHf5Hn87qawPGxswge3sYVz7qTudadKV6kZd8a3jQ==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20261005104142.1871-1-lirongqing@baidu.com>
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fygo.io
Subject: Re: [PATCH] block, bfq: initialize active lists for all actuators
Message-Id: <9980eae7-e9d4-43e8-91d4-ff38e32121f2@fygo.io>
Received: from [192.168.1.104] ([39.182.0.63]) by smtp.larksuite.com with ESMTPS; Mon, 12 Oct 2026 02:13:43 +0000
References: <20261005104142.1871-1-lirongqing@baidu.com>
To: "lirongqing" <lirongqing@baidu.com>, "Jens Axboe" <axboe@kernel.dk>, 
	"Damien Le Moal" <damien.lemoal@opensource.wdc.com>, 
	"Davide Zini" <davidezini2@gmail.com>, 
	"Paolo Valente" <paolo.valente@linaro.org>, 
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26acc4258+bb5548+vger.kernel.org+yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Date: Mon, 12 Oct 2026 10:13:39 +0800

=E5=9C=A8 2026/10/5 18:41, lirongqing =E5=86=99=E9=81=93:

> From: Li RongQing<lirongqing@baidu.com>
>
> Commit 2d31c684a053 ("block, bfq: inject I/O to underutilized
> actuators") extended bfqd->active_list from a single list_head to an
> array indexed by actuator, but bfq_init_queue() still only initialized
> the first two entries:
>
>          INIT_LIST_HEAD(&bfqd->active_list[0]);
>          INIT_LIST_HEAD(&bfqd->active_list[1]);
>
> For devices with more than two independent access ranges, the remaining
> list heads stay zeroed by kzalloc() and are never set up as empty lists.
> When BFQ later adds a bfq_queue to one of those lists, list_add() writes
> through head->next, which is NULL, corrupting the list or crashing the
> kernel.
>
> Initialize every actuator's active list using bfqd->num_actuators,
> which is already set up earlier in bfq_init_queue().
>
> Fixes: 2d31c684a053 ("block, bfq: inject I/O to underutilized actuators")
> Signed-off-by: Li RongQing<lirongqing@baidu.com>
> ---
>   block/bfq-iosched.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Yu Kuai <yukuai@fygo.io>

--=20
Thanks,
Kuai
