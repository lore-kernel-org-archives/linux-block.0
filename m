Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C114431;
	Tue, 27 Aug 2024 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724932; cv=none; b=qw7iCVZuCaNw3pYqm623b1mFDSziOf+pmeLrDFNKR7T32AHL4H5DzwFvY2QJK4VsJAYzEO3zNj21ggSicWHQIQ1jaueWBFEdVNaL9Y+rA6HangLxV7ZCNhxXkC+eA48aM15j3a48/WInAajtjEJOMz9rUKTPrUPJvXfAfrLRLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724932; c=relaxed/simple;
	bh=PIhouyhegn2zrq/MVa0D+bMzMmeYnsdDcOkd42SUs2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etzCSuN7GiShJOQDbQheCPxTvJUdfF7FcUeAKJzdSHhor1EIsTMUkUSbpCtrSsmpRChmXxI5FDmlzaHb1AQoiepfaNxOU5YBhk3oKny6uR37xRt05Oiy6n7fJYxlFpioqp3pm7DBfGdAqLwh01E0G67giOFjbJtsV/xZrS8D6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRKu1pGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRKu1pGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50840C4E678;
	Tue, 27 Aug 2024 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724724932;
	bh=PIhouyhegn2zrq/MVa0D+bMzMmeYnsdDcOkd42SUs2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mRKu1pGUywVE9UvJ2voZPxQvjrlXNkLjBBszYFnItEo8bAodGmxv9xs5nq+NRqcfF
	 Pnlm/J99yyN7OwucLLZh50/RqyvCVcESEl/J/bJOQmiSX7gG3DCL7BFwEkvQCacg6s
	 j+BA7jo/GqPNqGo9ME7XaVKo6gioOivgR3pofPgVTQpdnASof2wYws2GAVfk+UCCNN
	 QHN0T0k8DTASjnx8N4muxPEyzF0jdgsAtRt23NlmCURU/EgHwNAsAaowfDEW0i45dT
	 F8d/JqfVHddJKRKYI9FtUWN4zwpmnLqa+mh9UmWbZQQrzIJ5LY2we/BjElhMDbzClJ
	 SZMyUjIDcSPsg==
Message-ID: <2bb2e9bb-08b4-47ed-8102-24b60071d7e4@kernel.org>
Date: Tue, 27 Aug 2024 10:15:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blktrace: Add 'P' identifier to mark I/O with REQ_POLLED
 flag
To: Yongpeng Yang <yangyongpeng1@oppo.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-trace-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20240823072529.438548-1-yangyongpeng1@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240823072529.438548-1-yangyongpeng1@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/23 15:25, Yongpeng Yang wrote:
> blk_fill_rwbs function currently does not recognize REQ_POLLED I/O,
> it's not convenient to trace the I/O handling process on the
> HCTX_TYPE_POLL type hardware queue. Add a 'P' identifier to 'rwbs'
> to mark such I/O for tracing.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> ---
>   kernel/trace/blktrace.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8fd292d34d89..69b7857d0189 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1908,6 +1908,8 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
>   		rwbs[i++] = 'S';
>   	if (opf & REQ_META)
>   		rwbs[i++] = 'M';
> +	if (opf & REQ_POLLED)
> +		rwbs[i++] = 'P';

DECLARE_EVENT_CLASS(bio,
	TP_PROTO(struct bio *bio),
	TP_ARGS(bio),

	TP_STRUCT__entry(
		__field(dev_t,		dev			)
		__field(sector_t,	sector			)
		__field(unsigned int,	nr_sector		)
		__array(char,		rwbs,	6		)
	),

Not sure, maybe we need to expand one more byte for rwbs array, if
REQ_POLLED flag can be Ored w/ other flags.

Thanks,

>   
>   	rwbs[i] = '\0';
>   }

