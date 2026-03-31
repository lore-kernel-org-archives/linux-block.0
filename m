Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A83CEB90
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942819; cv=none; b=GunRaiRBtPgCWt2rndYFthsM1SgKOAvIXlqsB5FMD0SfxlSz9NQj6t5KQQUkmOXZzQXZrQo2yUzzGlu0oW15QL38YZpHtXAJ+xmfKsol8YMywPcFgFCVPXlYn6aFMXR3pijEumB6l2VhUFdRpZ7QppFVs9Z+0cEyfoI8xaA39pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942819; c=relaxed/simple;
	bh=hsu/QWm/80+hRBPmuIDTM+kGYWH2RduEUX0cvfmB0GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4ccPOhcXDDGhkPQblHUKKSdsI8E4ihD4pLTAzH31b7ffR3Y4o0TBb6eJ7+HYT+eEDwUKwEHfCr5gyVp7Y3r6zOmrPrgUyhUnBf02VsGDK1GpWgEfhqDqnw7eYig2qJYfubtfCzfNlzzag10VxG/WWHAHjZcxgWIOj0w8pVnU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y8YP+afv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y8YP+afv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so42460465e9.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774942814; x=1775547614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cdbMiOJBq6EGLnq0dV1kr70t1bjbBhqLXzxcoZ1AKHA=;
        b=Y8YP+afvWL35j7mZnIqjx88v3W0TBV507CP0jskc4lqhTYpdyjV1zqtQKZ8BTzlbGH
         HcuV98mcvLssW5iI6TCaxPUCd9ibYplfyJrmp1PzBq2kYXJu+JghkGNbiWpH2tpt6cUQ
         Mbi9kqbVPGuTN06K4Vk3INlbBB6cU7uTECyZ/Ax6AE1G1M6/lbjizfnJpwz7q22gS+yG
         tM1CxQgbNNvJu2duhStacvEs7urZuw2dn6Ibh1un7dDxytRRG3SlE8S4CwWq8YfUSzC9
         leW6mtsAVXCvfhjpHQDbcJSb0cBAj7f5dEnXcbxrfJYtObW5rem4/qhmM16HGxeq4Mud
         RLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942814; x=1775547614;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdbMiOJBq6EGLnq0dV1kr70t1bjbBhqLXzxcoZ1AKHA=;
        b=q3Dhwy0FVRTsR3nGTneagFSR0rNd7G/hXGPlB5RFdWeKhogoyvyJiAQbERGfcsm9zA
         7uRgdczrVDxAEcX7X5H24Uq9tHyNXf77YgtrqVHQfa663Yls8D8gBN03/zUmZ+3jJRMi
         5/n+08N6HhtRgZ5+uYw2zbcDwDAVs29aPgqV+oMmZwiXCfcJVztQJ7hFLJgi0lsJQqLR
         Dx6poOowc11JqVTYCBinB3Y+ax3/gQMjiAvwYy+QvuQxkM88UdzcBizRMqM6j2O0GzC0
         lXne1gm3+YvYA0T99IO9A97TuJ7LFfNcXjSY79G+ux8quWsRppYor65Z5EbuOGMsdViH
         2KZg==
X-Forwarded-Encrypted: i=1; AJvYcCUrVozS42YFeEsC8JB/CI6Faq+uYr2FcIrA0ZHfGOBv5ZzbItf7WjIH64haXBmSz9yLwPXsAKmL6eQPfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7ChkJmphF7lP0wNiKzJUc8VeMXBpI4T/1h6f8eqBdH9ZVhWk
	/Sr0pGkqpWVeUTaSY6YPAyZeArpENtXzBMW6HpfJh4zAAwPnI/n1Q9q8RxRagSP46Cs=
X-Gm-Gg: ATEYQzxpSbYPLNw8d0GcrzWGAtCivZV9GSmGkCdx/vi3q2Pffgpv78RJMVxuh2bKFbv
	Jvvwgc7bVyUmxMoh6XDFP2iz9Ab9fAXjtUFDl/6wqJu6FaKFWapM43E3VZYKrbzu8uMcW88InTq
	uYqr2uZcqvJTFOjIGZnPd8RgOcGlMIw3bmlVmYxljgzvrqF4+3EMfQL8hUk0NvWfOPTO7OBnw28
	dZf916bQNJSpppWLU0mve+NFG6BzCuZZTxP0fcOTeFHSgVRAda6nXOWvqZUlSZU4z5UCfCI7RUY
	D9saIcPs6QlikHnli/FvxeMG+xQ+y/o8SQ6JpQzvHSS2NJIOIz0xAQpD/CE/kPy0e+/d3jk+f+E
	MaHyq+0lV+Xk139ry1FX+LgwH9FLmcbkaXyHovYcHMvobkkeifH2Q8omNRcPNMHl9h0d6+KaOSj
	hzlZWqtYtJmE8ZJpEDEsb0IGQuIWDYgXKNZ/H6a4WChrOkTSLGofA=
X-Received: by 2002:a05:600c:a11a:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48727ee5405mr178833865e9.29.1774942813574;
        Tue, 31 Mar 2026 00:40:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cda5f7cf0sm1192924b3a.3.2026.03.31.00.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 00:40:12 -0700 (PDT)
Message-ID: <c2a593e1-cbde-46bb-a32a-c9db38c62801@suse.com>
Date: Tue, 31 Mar 2026 18:10:08 +1030
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zram: do not forget to endio for partial discard
 requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>
References: <20260331073737.774503-1-senozhatsky@chromium.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260331073737.774503-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/31 18:05, Sergey Senozhatsky 写道:
> As reported by Qu Wenruo, the following
> 
>   getconf PAGESIZE
>   65536
>   blkdiscard -p 4k /dev/zram0
> 
> takes literally forever to complete.  zram doesn't support
> partial discards and just returns immediately w/o doing any
> discard work in such cases.  The problem is that we forget
> to endio on our way out, so blkdiscard sleeps forever in
> submit_bio_wait().  Fix this by adding a missing bio_endio()
> call.
> 
> Fixes: 0120dd6e4e202 ("zram: make zram_bio_discard more self-contained")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reported-by: Qu Wenruo <wqu@suse.com>
> Closes: https://lore.kernel.org/linux-block/92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com
> Test-by: Qu Wenruo <wqu@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>


And forgot to mention, I'm just a messenger who also did the triage.

The original reporter is Avinesh Kumar <avinesh.kumar@suse.com>, who 
noticed a test failure from LTP runs.

The detailed public bugzilla can be found here:

https://bugzilla.suse.com/show_bug.cgi?id=1256530

Thanks,
Qu

> ---
> 
> v1->v2:
> - use goto end_bio (Christoph)
> 
>   drivers/block/zram/zram_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index dcea703a6766..aca67d7144e4 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2684,7 +2684,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
>   	 */
>   	if (offset) {
>   		if (n <= (PAGE_SIZE - offset))
> -			return;
> +			goto end_bio;
>   
>   		n -= (PAGE_SIZE - offset);
>   		index++;
> @@ -2699,6 +2699,7 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
>   		n -= PAGE_SIZE;
>   	}
>   
> +end_bio:
>   	bio_endio(bio);
>   }
>   

