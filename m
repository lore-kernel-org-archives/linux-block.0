Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7CA2877DE;
	Wed,  7 Oct 2026 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357061; cv=none; b=odj3y+fXz8d7PzDBQ4jxbcaOkGfL+vfTF2gBkEqjCgbMY3V0QArGOiEoJs2ZH6av/O6+s9cH4SBwuzQeSiFXFZVQm4vor55jkWxjumbJEr0zz48pRs1nJb5GJDfRGlmEUbWyzYArohC+JFtnxT7jVPwd/xiGlAB/kPOWvjNFLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357061; c=relaxed/simple;
	bh=VM1/kN9VXk1whu/Msrn5b6n/Hj8Q5zYCsazpWrPUnNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cCH4GIQgaO/hmFEjYzTxlZeOiwvgnFiGyY2cUboNIsRSM2AK9T5vL/63uW08c0rwkSDowEeq0cHWxFi0XsE2AlIgxZSAnCjUfcwjeEN6/iQmMh8Ti1G1UhnBPEcC5xw7fxzt1RHzviACngyM7/JqxPypIW37a5kE1OhR8r+KhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB4eHWqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB4eHWqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262741F0089B;
	Wed,  7 Oct 2026 07:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791357060;
	bh=PdIU0/domO4U5iY5UWa038RZa6S6qXu5bcb/MSV9oYM=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=TB4eHWqyCRlBO5uF9KuTncb3B3NVcffQQo/SDf767eWBSZYA8XCJ5nXHPuFQAyhSq
	 QxdkvdwKZRQ+7L8THAX1D3SKLE1wsn8m5IjCf36qav8EOFzXvRIRzvfRdywE/AdnXO
	 5GJ9V4Ts0sY67qEr5YFHjvDucn3u5QGrGGuZdbNRDHianPYKuu9Ea6IPg5QS5eTnHM
	 RBfwbX0yqbyqjAdyjld1VUmzclnsKyqrvRhcsYjBXhgrHMkdi2qdpEnmpCMUcB9O3b
	 9VHnXomLo/BOuyt+/WYlpDpC4x/SaFEE1h/mWF1HgBiNXQpraKPnxu3Gikfz/W/o8k
	 fE40fhNWb3Dfg==
Message-ID: <7372b086-df99-445e-b387-d33681335f5d@kernel.org>
Date: Wed, 7 Oct 2026 09:10:55 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block, bfq: initialize active lists for all actuators
To: lirongqing <lirongqing@baidu.com>, Yu Kuai <yukuai@fygo.io>,
 Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Davide Zini <davidezini2@gmail.com>, Paolo Valente
 <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005104142.1871-1-lirongqing@baidu.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261005104142.1871-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/05 12:41, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Commit 2d31c684a053 ("block, bfq: inject I/O to underutilized
> actuators") extended bfqd->active_list from a single list_head to an
> array indexed by actuator, but bfq_init_queue() still only initialized
> the first two entries:
> 
>         INIT_LIST_HEAD(&bfqd->active_list[0]);
>         INIT_LIST_HEAD(&bfqd->active_list[1]);
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
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
