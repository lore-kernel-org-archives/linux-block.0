Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46E2BFC60
	for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102632; cv=none; b=TTaS/JSWvtKD9H3A294MPsqecQc8VzBOAY2/pCs42lAYY1mXpL88GuU9gf5VszaUjWfaCs3JTYZtbpEmRMJqW8sNnj5sBnqFr4DJW7v2TFNzMLHssvCM+9fxkFzv2EH2T4qSTV2BBnxQdrAziJjb3667IJYcZgduDry7KcQAqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102632; c=relaxed/simple;
	bh=jIjVWHD4K3Z76E0xRL2wHaV+Q1FXvL8BMhJYLB8JpjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHRjF2e4JFSMCWaNb9WpDd1kOZpnclmFDefdhFVv3pWskayEBy/wpNPu08dSSdQAeKZyvZiZQd/xn39FMUxFLwEoBkNS1kBNoTSd2D0TfGpR/a+VtK2on7rp3HgLv8xCKs1HDEpZ0VYdmOoAnt7UdbH9aJpdD46fYkhnoceEo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ayjnIJum; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ayjnIJum"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-417400afaeeso2810750fac.1
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774102629; x=1774707429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zN8h/8PEssBPso2SBRlWLVHgaakG3DP1RYR9BO+q+dM=;
        b=ayjnIJum2Jd26qMIq5mWuBdAA2xwCjAWlZ6k05CB1/PSG6C5EkEgDXpLY9at183phD
         2IDgabUi9tINxoP0qqtZDYOzZ8RHx+tOBBZXjY0ArHaFJBncS+H1MS+YThfxUvXL1Umd
         QKu23YB3INscYPhV7OwnXPRPpI3CA+YDL8RvTWLxGtCKw4E4KI0Mc1wnRrwzRHjOzHyD
         4YmdHry7MyYm+oE7FInZXdDUx7nj0s0b5TorYxUbyG4VYHyC5Z+31nKzge+kK5HgkQuC
         4I9mA46yE52aLO02nzSk77kb1DKErqtUah1vow2PWq8o01C9s8NC6e5kFKp1u5HBXvsE
         bbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102629; x=1774707429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN8h/8PEssBPso2SBRlWLVHgaakG3DP1RYR9BO+q+dM=;
        b=kQzbYEp3OFS8ttfMuYHhRyfZ15jAQjbvIG1Z9o1rE67lGp/iE7nuG5AQJko1hDi0GC
         zNnDgSfwhl8oCIcvo17UvOTlopNJf0UF9elYeFh2FSYKLPCOeqBNA79FaYRDZx+8l2p0
         XHLlrEopcWetSVvJGQxs85m+G0CAZSmk9u4TG21117y5RJl+HkFXi9/y19UGJq1D3CAd
         I/POUyunb4KFSyKtYr03DOJJZ/MQDw5N+KSjZKdASHdIo9yxuRttAvFZ3Nx8xH3quW2B
         gASv9uV8L1kzYuGoK1x58R3ecuUCEhy2Mql5xQAQ2jsezshQhkloqL7Rc3zbq/nSVWa5
         MFFw==
X-Gm-Message-State: AOJu0YxVNmQ6KrJCfxKDJ0SmY2M/NeSqQL4JOQebsXwMaVc6CRo0YDPi
	Tt4UvV6Bz9nW+fX+zyTgesugQHcoSdGVidbcR5QVVQgaFlTbWTVGcZiSmIUVe0uhVWc=
X-Gm-Gg: ATEYQzyjEzmmUhzOfckW/nADaP1aKcvKfRVZ/+7R4G3Cdtqo8y9GcNAAUiBsB8pJCgt
	cdttJzHB0qyKOg5N/GJO6TSFp+sZ5GX54B2HPEw3ayN3kQF1OLXxi2HUjvzvIsw/nh02kpzHs9+
	3vrfjCTXHx15KI8npDhujnqc+ksk6iZIklAiOIPWtv5DDOBe4diI8iIDOKUWUm5Kw5kwPDjQbZ7
	vx8wEdVn/D3lDEuK3vKcfNApUCRyozlqDYUekLcw8I4wmkhvGqXWnau3flCwkxzOblmNgWS+6/z
	kaQB3JKvXWkjsq6kFryGUYPeZGdTZZIaWKnzo1AzCL7yg7q+Yj5cDvCvanlRP0PDXPcFIXJRDec
	BJn8YKGLnK7al5pfgVLTdd/9TDIaWpc9NaHz7lAjck72yoPpat0Ivv72dvEcjjsYC6ocvUbH/vx
	58j5dvMfd6qlD5jOGP7nwjtqvkL3oKZ4IcIsmb9Avs8Y5SzrVgy3bHIbottwl+zxLTII+cHZYF5
	3YKis3JXAFwFrzonrVW
X-Received: by 2002:a05:6820:138e:b0:67b:ba86:2dce with SMTP id 006d021491bc7-67c23668bfdmr3637888eaf.36.1774102629055;
        Sat, 21 Mar 2026 07:17:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252dbd05sm2925294eaf.6.2026.03.21.07.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 07:17:08 -0700 (PDT)
Message-ID: <ca49c74d-7192-4189-8afb-96ea86054f50@kernel.dk>
Date: Sat, 21 Mar 2026 08:17:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] block: mempool alloc fail due to insufficient memory
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com>
 <tencent_B483B24447B77B776C66D11362A37BE96505@qq.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_B483B24447B77B776C66D11362A37BE96505@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/26 2:36 AM, Edward Adam Davis wrote:
> Add a failure check for mempool_alloc() in the slowpath.
> 
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> Workqueue: writeback wb_workfn (flush-8:0)
> RIP: 0010:bio_init block/bio.c:214 [inline]
> RIP: 0010:bio_init_inline include/linux/bio.h:435 [inline]
> RIP: 0010:bio_alloc_bioset+0x664/0xc10 block/bio.c:593
> Call Trace:
>  bio_alloc include/linux/bio.h:373 [inline]
>  submit_bh_wbc+0x22d/0x650 fs/buffer.c:2816
> 
> Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
> Reported-by: syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=09ddb593eea76a158f42
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  block/bio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 5057047194c4..0a870979bd41 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -582,6 +582,9 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
>  		opf &= ~REQ_ALLOC_CACHE;
>  
>  		p = mempool_alloc(&bs->bio_pool, gfp);
> +		if (unlikely(!p))
> +			return NULL;
> +

Doesn't look right at all. You dropped the backtrace, which shows this is
off __block_write_full_folio() -> submit_bh_wbc() which allocates a bio
from the mempool with GFP_NOIO. That should allow blocking, and hence
mempool_alloc() should NEVER return NULL for that case. If it does,
it's broken, and your change is just papering around that issue.

-- 
Jens Axboe

