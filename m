Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD73E51EF
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527778; cv=pass; b=gUk/+gRxARyJLjCa26RWPNeeW82Y+v3q3DF+Kkj+3uYYTcU2KoBRo+mOAHtnu3wuU4RReulcky6CuLDCEjhkjwbrBt4VBi+6O2ER/e876OCklJkfkbW1PaIDxIkdntdId1ZMXf3nQNQRiMfdtXjEsoeSRq900r2A726juLCYHJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527778; c=relaxed/simple;
	bh=EuT5lYOMkkdhbh36n3EuIDGIwufLokD6nYk5Kx0YNCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dzk3Pt/K03oQipIikyQglcwbpGA22RtscqpB+fYY/uaAZKaAA3k55FvZO97i8n4ZpjUSSQiZjulnP2bUlA9TMIziTKobt3qi/OpMy9za0AdnJz/B4qGVNfCHHzddhaE1tVt4p/Dosj8TxU0oBCs2h3MZgPH3g695vof7SBHkW28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKOd6BOv; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKOd6BOv"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa7a7ad4d3so2851748e87.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 05:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781527775; cv=none;
        d=google.com; s=arc-20240605;
        b=iheR8DXEn5RyUwtEX0GAG+08ZHNbuwp6Ks1aZZeefIxAd4O0b/ie8iqp0XdHE0rGl4
         mcIHiRz6N+5OIpTiJ8O2uFQNXo7OMpi+Y8XR2Ig/USjsOnFxf7Y22PmyTAi8VEPd0Ztg
         LlI1/ROU9pe2gawV3ez5GigRJaJa/uXmdAEHBhEkG/SQXaG0o7GB2g6aOlAUz2cRMTmu
         21mPi43JVSQ9QUW8SpusgFwNF2aVChA3OZMOblG26RZn9vTmYvJlf5R098Tgf3Z7QZnv
         kvbUBEFqBNIucwYj5WZ8XVmWQu6eGwAj6MZAEBHr0Q/LQmmwWL8ZR1NrXvPvQUaOOEOF
         Aukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EuT5lYOMkkdhbh36n3EuIDGIwufLokD6nYk5Kx0YNCs=;
        fh=T/7swcw3lanR1a2cA6y5zH0eP6d/CFBYa5uHrEP3UR8=;
        b=OAo6wtY8cktuDgl30yDYG+k1v/0fieoqyF+WcJru4zI2ZngRdwbo3n373cscuCskJl
         SLCDQKA+B7HMOds3XFovcwOTc2NUkTCLNDzJTYk+v/b4QIBd9fR9J8hzBKKBj7WQXHQG
         TZF2OMGEb7cudMcnfoPqOYJut1vDK3kNrMV/wK8N3fdMAKZDWwxHlR2KUW+2Sc+anCF2
         glBZApD5chA77ZLKby7cEt35E8/caDqa4HwIg5HUCV3ep/m2kRTeJKm20m/rJP2pQ08I
         lRROA+o1NfreV++8tqmNZ4I9h8OdxnFRXVW+MvkxklutN+pJKNfGrQ+f63keJrCHuDIh
         Kz/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781527775; x=1782132575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EuT5lYOMkkdhbh36n3EuIDGIwufLokD6nYk5Kx0YNCs=;
        b=sKOd6BOv13rS48sKumGSN98WjIjmsrT1KB2CVI3OlskLoqYiDYt3H+NMuI6KkIekIw
         tXFqxAa/tXdsNaHRisGNWz1stQBOMoN+gxX0VLzJUJWdw43l9x4DsWY+Tsc7/yErRp1a
         PgvKNVIBHkvtuyM9jdaHVFRNN/A5B2CNEeod4/9U/pbJKPxcAOhWk1AmcvWIbC1l7qgx
         SaOJDxYJVeAcZ62WRIxg4NeN1xwTJhz2EfshZ3KRAgc72S+cCSGkveuZ34z1QicotMj2
         B2Zg7Zeoi+naH5a5XSc5tKS1mxRo9Z2liW2iqc/py3DpTRiwjzOFAI3vOXP6li6jg1bO
         dFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527775; x=1782132575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuT5lYOMkkdhbh36n3EuIDGIwufLokD6nYk5Kx0YNCs=;
        b=aoUF9rcmCn3F0e2rkUaRid1ROq6y3YPS9/NbC7/bc6NLMNxQlTH97EqDstRdRL3lpV
         jH+LNBaBe+uTIBEZBWcJ9wh/0vhwIRNH+Ct2wG+cTZF/L9/3DsP0B+Yg9Vqg4N38m1Gi
         oSa6YUz3TJFW3KObdRhYfWN1gI6On7fOS8aVbnMInjhb5ZaoF2qykGGJsU+303qTUM0H
         iaGUU4GALTDljZ6dY6hKLCI65yX650uYbOk1jZ3juUwqs7D9jEzgTXBNHMo4xFvebzUq
         +4rXjb+RL1qwBN1fBmfQbGBfwvbwFUNZaU7qJqildjA1NqXKTEo1ht4JRrJ9k0jgvGlx
         Hitg==
X-Forwarded-Encrypted: i=1; AFNElJ+j5vN51nYoxYfwzbmSJ/hkvDK0+ZZIH2LZYMwPdincCtA8yaTUwFYT+2H2zrxcFwRbR2ciI6I36JhrXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4XKDMIbxf8Uel1w92HcK6+khq0WM4BxZrGZ+zExkSD7omWwm
	bIabWGS4hu7Itdpz0Sz76kCLxT8ou4stwZ45Vh5DCts1cVsyluqb6SwmySOY8BaWWEjmInX7ljm
	IePxc5UB7tWLTf4PnLurDMd7N5Fh52LA=
X-Gm-Gg: Acq92OE5veI2aDlqgHHmwBoyPBvim0eRWtBTo1p23i2SnaZxxcZ68tZu8DsorxEMLgA
	hPYsr70LAa58U4sANeKMFSBKgYkdPK10Y9atiSPUVVmbGBqt2/MJPJZWME6BP1qWs5B2/EpOiPe
	wG/mFY/fatiGRIStw7HFsA7qm5HLX/hSFTa7weTTbITEAovDX/2uTzpCt1RGvM08UsqUU9+Jk53
	gVHyBRpBIkvnEgv6QVNwrZWCWELevzgtCLY6zfJoV7FuLMh1yezp50vVEJA0WcnkXQDorPDlXgN
	ekdhLw1pok5FyTdtsLeNY6SzpxO/xlH69zgsvpEl7Z+nfQg=
X-Received: by 2002:ac2:5293:0:b0:5ad:abf:1d36 with SMTP id
 2adb3069b0e04-5ad2db5937dmr2832285e87.27.1781527775047; Mon, 15 Jun 2026
 05:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
 <20260614-zram-swap-ops-block-register-v1-1-6c1a6639c222@gmail.com> <ai9abo7GwMl+g43G@yjaykim-PowerEdge-T330>
In-Reply-To: <ai9abo7GwMl+g43G@yjaykim-PowerEdge-T330>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Mon, 15 Jun 2026 20:49:22 +0800
X-Gm-Features: AVVi8Cfn_viuMbTTWIMGNjjYhf-WEwtj1PicfDVhhngZ6JvZ_KcLvfvomcBcjRY
Message-ID: <CAJxJ_jh=q+Jh772w-hsJoCLTE82-btBj20R+zKL0Vn1fdccnqg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/page_io: let block drivers register custom swap
 I/O ops
To: YoungJun Park <youngjun.park@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 6/15/2026 9:50 AM, YoungJun Park wrote:
> On Sun, Jun 14, 2026 at 11:35:29PM +0800, Jianyue Wu wrote:
>
> ...
>
> Hello Jianyue.
>
> Currently, the patch commit log indicates only a single custom swap
> registration is supported. Shouldn't we allow multiple block drivers to
> register their custom ops simultaneously from the beginning?
>
>> int shmem_writeout(struct swap_io_ctx *ctx, struct folio *folio,
>> struct list_head *folio_list);
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 284eebc40a70..ebdc96092961 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -2849,6 +2849,10 @@ static int setup_swap_extents(struct swap_info_struct *sis,
>> sis->ops = &swap_bdev_ops;
>>
>> if (S_ISBLK(inode->i_mode)) {
>> + const struct swap_ops *block_ops = lookup_swap_block_ops(sis);
>
> Also, just a personal thought on this part.
>
> Instead of using `block_device_fops` as a lookup key, what if we handle
> this similarly to how filesystems use the `a_ops->swap_activate` callback?
>
> We could add a `swap_activate` callback directly into
> struct block_device_operations (zram's zram_devops). This way, the
> block device itself can set up and replace the swap `ops` directly without
> needing a separate registration/lookup mechanism.
>
> What are your thoughts on this approach?
>
> Thanks,
> Youngjun Park
>

Hello Youngjun,

On multiple registrations:
Previously I was also a bit hesitate about this. Exactly, better to
support multiple block driver directly, I'll update it.

On swap_activate:
That's a very good idea, to use swap_activate callback, it is much
cleaner, I like this approach:) setup_swap_extents() would call it for
S_ISBLK swap targets, and the driver would install sis->ops at swapon
time. When the callback is NULL, the core can fall back to
swap_bdev_activate() and swap_bdev_ops. That removes the separate global
registration/lookup mechanism entirely, and multiple block drivers are
supported naturally because each device carries its own ops table.

Thanks,
Jianyue
