Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957663C13F1
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942379; cv=none; b=NDfugUTt25ybQVW0wTQ6tYG4cRsC70662o8UZ8RYVUfCnBrLPPwrbyTH4qBbBI0wpiJM8nJmjfUNfuacJm1KY7lSbs3xxpk/NKyVEU2k+JM9cIKbhr9ch1ilwcYwDhxUU29el11PEOTzScSlG9xTNXUuCFzCGP3eiIIxp2hg22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942379; c=relaxed/simple;
	bh=XeA3fbJu/lFwPmVbddMANrGfDJ04a7P+GxK7MSLg/+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itHlx+6pwDkL7NwwNw8U4XNolJeWo7LH6GzyvxD7+pLqzsC4trV9QPFhWcbT9y18JyEXjbssk7slyQ9/sUl9AJ2dEpOd+enGLueDELlYYkFgpiAjy6uP5Wd63tCrokyZ4+tpmTUGBUdkq36JOh63VuaHPUZWZ1xaXc5KRvtRilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SwPdL209; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SwPdL209"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-487012ce896so32822515e9.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774942376; x=1775547176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqg9/VRYKsGs0VxPUmWgIB7KUuouu96VXwQtxp13sng=;
        b=SwPdL209LxOLOocsRV1ykJWSLvdsZGFdb5o3NVnXNvJRUTujlPQM8yNM3p6KODwI6d
         ooa466atuCK5CZJU/8YxEuopU7fs176KwwAETpNHvHRVghfI9BDfInadPkAFH4wA0Agp
         VAEz0uNU+zYM1QWuGffZAj1LPPnFrFqahvLHpPmrO3gA8yUwks8Syqd/es0Ps+9rzLwC
         oCmDoYcaWuE0D/fRlmkeCo6vmH/8LOQ9Dc8ltzSAE28AaUKUDBTLHE54f8Cm841J72qy
         WdzF6nLSKuLG5DwJpZ/MIBzZsQKCNJSrB4Dxfzt0WID0T5TZpZ6HEAlFCQENos9JNrpF
         oudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942376; x=1775547176;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqg9/VRYKsGs0VxPUmWgIB7KUuouu96VXwQtxp13sng=;
        b=YRQOuaZTMmuL+YxoNV34rk6ecCKWByg6IeTH0PwOI4Npc6MABdi6wiz95qM3tHeR39
         wFu6hkCssCwOyNKLCL9RymW6QgWxjy05YQIHRbXteDOoxz2xffeFLhUb8AE46KVjzf8C
         tDheinD+Sw4WoL9jaDN7b8Hsa640F4RREggJBO3/gNFBk187MkxkZlhxiyq3NzVdPa8N
         lmHoR9Cdz58mnj+1hP4kPnQqznvpS4eQTDeWvXP2iLicsxtxEpr9pmOhM4B6pKiBgfPI
         RF7OPh6fmDCPenOWHury3wVfaz4dbp+cFRbt4YMY/peW/aLPX+HR5HP9utXaafQ+2Nrh
         cyAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX/AvlUPc0NGLIoGcIf7jFyIoH2b+tqjsafLa591ir/u75GVq1RqPB+Maa5z9Y+A1op3CEsyxUilRMfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfjDawvCsDFhkRDhUy/wuJzZrOPLOxi0lqnALd8oSythe6B6Yv
	9VUttKaL6/70QnhUuUyH+xfux3SGrv7KevYtO1q1VVnIkL7IysC+1GeekIR8X3iqZw0=
X-Gm-Gg: ATEYQzy3TcpTmfOQyu7GnU4wTDZN3wTFSDkSrxeRIHiXp1UWqDUdt9MokmR5LoBzlQ9
	VhfXn44OR7q75PrW+UqiJatxxX61Culs8SJvpOQa4XZEYCVfDGzLGR77J8fVnzqfyxR3R0DCUNI
	qLjXegyFhJWZPkyW1MkvvypiXmq5MdILGLQhWUCZTaKhlJve9WppTOYYGARqkgDWt0LpbtJlHDa
	zju8C39VzbMU2rc4amavd+cTDsJNLj885Fs5emUCDbBAkzBh+WMQI7Z5yDCasNFnIS6AM4k/IFa
	yuBfMcVhOLjSKuBYwj2Q00wCFpsFZvODzr+c/sq0sA8IuCSKTql9gkQibEIcNFKTtXexoZuZp3g
	CPy3/fXzQD+JDZMAhh0vp8Gz/M0eW3C/So6wQu6EQursqFMkLzYjYBPEoiuuJZV0Ns5EwNGbBqJ
	fTOCTsKWRBcVTo2oJGpygM5D2MjFxyIMligNVOXqmlg2DjuppmrNx92EFKpvWKlQ==
X-Received: by 2002:a05:600c:4f91:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48727eda62emr245323725e9.20.1774942375743;
        Tue, 31 Mar 2026 00:32:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc735sm9245251b3a.40.2026.03.31.00.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 00:32:54 -0700 (PDT)
Message-ID: <a6b566e8-5808-4244-bcda-5612760bde3b@suse.com>
Date: Tue, 31 Mar 2026 18:02:47 +1030
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: do not forget to endio for partial discard requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>
References: <20260331071537.706139-1-senozhatsky@chromium.org>
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
In-Reply-To: <20260331071537.706139-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/31 17:45, Sergey Senozhatsky 写道:
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
> Cc: Christoph Hellwig <hch@lst.de>

Test-by: Qu Wenruo <wqu@suse.com>

Now all discard related works like mkfs.btrfs and mounting btrfs with 
async discard on zram devices works fine.

Thanks a lot for such a quick debugging and fix!


Although I'm still seeing not ideal performance if a btrfs with 4K block 
size on that zram device.

On a regular block device (LVM):

  # mkfs.btrfs -f /dev/test/scratch1
  # mount /dev/test/scratch1 /mnt/btrfs
  # time sudo ./xfstests-dev/ltp/fsstress -d /mnt/btrfs/ -n 10000 \
                                          -s 1774231493 -w

  real	0m3.435s
  user	0m0.005s
  sys	0m0.009s

On a zram block device: (mkfs.btrfs defaults to 4K block size)

  # mkfs.btrfs -f /dev/zram0
  # mount /dev/test/scratch1 /mnt/btrfs
  # time sudo ./xfstests-dev/ltp/fsstress -d /mnt/btrfs/ -n 10000 \
                                          -s 1774231493 -w

  real	0m10.726s
  user	0m0.005s
  sys	0m0.009s

Which is 3 times slower than regular block devices.

And after that short fsstress run:

  NAME       ALGORITHM DISKSIZE   DATA COMPR TOTAL STREAMS MOUNTPOINT
  /dev/zram0 zstd            1G 271.2M   10M 20.4M

I guess this time the overhead is just in the compression so that's 
something expected?

Thanks,
Qu

> ---
>   drivers/block/zram/zram_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index dcea703a6766..b0637423953b 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2683,8 +2683,10 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
>   	 * skipping this logical block is appropriate here.
>   	 */
>   	if (offset) {
> -		if (n <= (PAGE_SIZE - offset))
> +		if (n <= (PAGE_SIZE - offset)) {
> +			bio_endio(bio);
>   			return;
> +		}
>   
>   		n -= (PAGE_SIZE - offset);
>   		index++;

