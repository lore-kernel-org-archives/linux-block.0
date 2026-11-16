Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845798;
	b=ZTe9h7Ufv86lnttBy4X88mOhAbW6CtWG++V5Og4pLoeM5ZrM9pLxaEyEVHGHOxooC6E6
	 5wF9S+nW/nkKVQEksAJFLUs1xXJlejOy1S+0AFnv5ndhlGX+DOcfRfTwjGK8Q6InutsKS
	 2P7tEEnrUF0dUZVHwZYpOiVzVFX6PtWArA2WbHGlma9qZdLMu3qynDU1TdCsknM4tp9WP
	 Jc+kd+0idRyVYN2pPNiv21VC7OWZdCWbqQOCAF/F0UroawE0sCnLmPaszibb6uyvUZz0t
	 Ruc7S+ISU1x27vmIXyPvIkmp6V3/jQgLONEjZrJZQI4HzFttTils04bacVyOfF47Tfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845798;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Reply-To:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yCSzCrkdCOCPlR1zdVahyL9VLjI4SbXe7wRt306JhTo=;
	b=PF5OImTt5UBwmEKVgK2AnYObPMshNIgzpr4RvpQfhc3vJSHjonLIaGDuRkSuOUbarMDX
	 jmvQbT6INfzwfP8qBqiWVFpUfjS2bzkwTkAZ7id13oxK8SwT84fJOsG5cx59aJk+xXy5J
	 XkiMe4jt8coDe+fPghDaXY66kfSvNenFqxp1Mu+b5EfJRjhvgutX8kxGOvZ82QBzW74Cw
	 xgTdgvKGC7JElBY0wo5mdLtkJGfBZtezX2m7KAkf8e4ytcLaG+3jppGG1g/7xYOppJAcA
	 rDU8O83RzSxiwbvOQi4+Gwn8xFwXpEkZ7NOCQ7Jz2t3tZ5luHtyW9XlB/DASmhVPOww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E9606A31C
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 16:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E4E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-71ab5e64742so2968891eaf.3
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 08:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794845796; x=1795450596;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yCSzCrkdCOCPlR1zdVahyL9VLjI4SbXe7wRt306JhTo=;
        b=hN0SeNTUY1BrsLQvjn63NbnZK3U8cczmjCT4mdnctmGdVZr7H6TK+ujwPW2oNlBz9f
         Wjg12LAQNvGBS6JrEXtYvhaSrgDuJBZGf7KUtOegrJt+0ARMPhD6Wc6z9f1jt9BA/U/R
         eZnD1PaGU89+cblK+i0o+AinaCu1WKSwcUM52kgjIMHmtWU4bV3dqMYIxVBlcePgwCQ+
         XjU93MfC0923/e6WFve3F53xcIbVEdOSnc9vKz+XV1FNWsiPpDK8KDwaoQbw17WjMplB
         dGyjlz77Roz4Oe71VQb5ta50WXvoJrvqXAQHWXaIOmEl/aFD14mbAMF3uXo7AToEsRJh
         HTLw==
X-Gm-Message-State: APuU4Z/LA0UMJZ1Kx4+97gi2uYF9jbPgkACDt6jygsRqqDtQuf/XUwgE
	lZctB5F+duF4Jsns6b1Vvvk4fgBjCLDTWJyfkEeRGdcY4Ie3wL2Pdqq7NMGBeQ==
X-Gm-Gg: AYBFou23fvk+bDPs5psqTmoPM1RGRUF7nD8kl+Gb25LCNJ3EBIDNbzz7sy4YVYvWgrk
	1GPMi3avbMLIfMPWcTsirxhmLZHSliKMlVotgrIRRZLodeKs35lt9IpHxvXYvdQqxvtp2ldp+2v
	Oc0x/XWJbuJBudp3GJ72+skcXQFm1bp8MqImUbffl8zjRmRRAX/Y2pFuX4d3PJfFk5BtlHMgxq+
	dIEFZjHnrDbot4sQhzuVbOLSrhZ6Yy03SfsbL1fYbzQpGiipItKEwhQOu34icYF31ea9xAircN+
	gm2Vxv0dPUKlUbEiOueulgFtfwP2bhTIbGZuKauy4OAPGepkxeiUFjeC7X/MPQcTTQWY89xcXAS
	kFpeCOG0DBLCZyt5flotxrtSeYc5YYxHzhbkcfmYXd1t1UfDNkOlsc9eXiLHylqnFOcSQL8oes+
	YjcLQlB5IeoYMjn3UsvnyNraOrve2B52N3x9W7BJJ2PvDr+vBJWAvrXAg4gT1QPqUXyAiqMLdLc
	7roL9NG37JV/QmKweRf0o67gnyi40xgRCK3Row+OpJ5whOBFLaZwgQUAXt0l/GIeFZkIUv6gQvj
	0q3ZWt1/tNOXlP0bO5E5t1WvHwMzLwFV9WFcIdkp/uhCOAUYctV9g0QnA+76Lowz8brk
X-Received: by 2002:a05:6820:570b:10b0:71a:fa49:2f33 with SMTP id 006d021491bc7-71afa49313dmr939115eaf.41.1794845796620;
        Mon, 16 Nov 2026 08:16:36 -0800 (PST)
Received: from [10.68.32.41] (bba-217-164-143-222.alshamil.net.ae. [217.164.143.222])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab42c41e9sm8997106eaf.6.2026.11.16.08.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 08:16:35 -0800 (PST)
Message-ID: <a89b5be6-998a-4f3e-8768-0a64a9b33d61@linux.com>
Date: Mon, 16 Nov 2026 20:16:30 +0400
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
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: Avoid unsequenced accesses to jiffies in
 show_floppy()
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20261114-floppy-wunsequenced-v1-1-a54dba6754c4@kernel.org>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20261114-floppy-wunsequenced-v1-1-a54dba6754c4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Applied, thanks!

c1a8feb71ba8 floppy: Avoid unsequenced accesses to jiffies in show_floppy()

https://github.com/evdenis/linux-floppy branch for-7.5/floppy

Denis

On 15/11/2026 08:41, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in show_floppy(), which can
> break the build with CONFIG_WERROR=y / W=e:
> 
>   drivers/block/floppy.c:1839:30: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>    1839 |                 jiffies, interruptjiffies, jiffies - interruptjiffies,
>         |                 ~~~~~~~                    ^
> 
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
> 
> Add a local variable to hold the value of jiffies before the function
> call so that there are no unsequenced side effects, clearing up the
> warning.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2198
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/block/floppy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c677d783811f..f6339d779be9 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -1830,13 +1830,14 @@ static void reset_fdc(void)
>  
>  static void show_floppy(int fdc)
>  {
> +	unsigned long j = jiffies;
>  	int i;
>  
>  	pr_info("\n");
>  	pr_info("floppy driver state\n");
>  	pr_info("-------------------\n");
>  	pr_info("now=%lu last interrupt=%lu diff=%lu last called handler=%ps\n",
> -		jiffies, interruptjiffies, jiffies - interruptjiffies,
> +		j, interruptjiffies, j - interruptjiffies,
>  		lasthandler);
>  
>  	pr_info("timeout_message=%s\n", timeout_message);
> 
> ---
> base-commit: ab43ec385580b8f8abf72d70fa3acbf4e4f098a5
> change-id: 20261114-floppy-wunsequenced-8b739d08b849
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 

