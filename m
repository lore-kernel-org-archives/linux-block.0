Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC07D071;
	Wed, 22 May 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399511; cv=none; b=oplqnyrOQ0IH555e/7P7bodlrh516tKHQjNhMXZRxcXJ30igA2tw7P6c2oxOClMy+xKjA4xD6bZ2ssFBYAsGNxJBHtidMqcOmzwZobNXCIuIa5TYrXmqcDNVTSCN2FyvUIa78EMxxx8KkXEBrVMzwV8QUamZdHvhyG4qrO7uGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399511; c=relaxed/simple;
	bh=utZwExZsy+bbzeGxO3QSi4GkAIS9asuvSNjQM7MzDJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQDbB2NSNkWjerF1HPX8uP44f5YVTb/4HqiWn6/PcVCAyJ/G/30sqZ3VQOiQLpUG+l8QTPf44V4ctmnpOE6gQA7f+Aaenfcw4M73PS2SSNKcysbN+rT+3G/VVCLCzCV3iClNEtQSiuMVqAZFL/ghgeVqQzO1/JHL1EzIMHnc8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YqQFU1gj; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YqQFU1gj"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vkz6s4NcTzlgMVN;
	Wed, 22 May 2024 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716399507; x=1718991508; bh=hYMzJ6ZktlWrLhJIonyk1Rju
	qO/QWvieXSfFyw4bnCs=; b=YqQFU1gjjShdbKHUuEsWdQ2Hw/e7MTj1Rqjd4nUL
	xuLqxx/Zru75ZuUC1JUFioXsH/Sp5lm9GM8/wyMhvSMYhwck6uweksfj4p+UcEci
	31x3WJ6uXSjEg/vdViamuS/PwEfV6Di0yattALWBKftaS3WSZB68NdkN6ydFJVA6
	GR7Zo7bqKWJ0TvO23SUFxGBShqWmNsJ95hequA/Ni0zkY5bcITVo9iTtpj3uRB6g
	qS4SfQBKgscaUIZHmerlhsO5AINOexgVHMjtUBl+WtNWEYs6SkTrFKnFgIwgqK39
	HUcTn34ZW/gDZmpDi1d6S7V70L9cnoGedvYPMUrlYFXwEw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Bvzryhrrd1zB; Wed, 22 May 2024 17:38:27 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vkz6p70p2zlgMVL;
	Wed, 22 May 2024 17:38:26 +0000 (UTC)
Message-ID: <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
Date: Wed, 22 May 2024 10:38:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Yunlong Xing <yunlong.xing@unisoc.com>, axboe@kernel.dk,
 yunlongxing23@gmail.com, niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 00:48, Yunlong Xing wrote:
> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>   		set_active_memcg(old_memcg);
>   		css_put(cmd_memcg_css);
>   	}
> +
> +	if (ori_ioprio != cmd_ioprio)
> +		set_task_ioprio(current, ori_ioprio);
> +
>    failed:
>   	/* complete non-aio request */
>   	if (!use_aio || ret) {

Does adding this call in the hot path have a measurable performance impact?

Thanks,

Bart.
