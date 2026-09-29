Received: from mail-pz2-f32.google.com (mail-pz2-f32.google.com [74.125.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2D2931DF
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790657582; cv=none; b=Ehb2OYSalcMvYAaAkdzpBZRjw+X98q44IByhR3FvzeZEkFiBmZjqCX2v5p2zA/GcnJP7rsyfvxKg5o4Ez2PL8apj980ub3J1GfsizVIs71M7dwEfVC5+sgI4RqOhNHM8kICPgTyyImm2ii75tp006/9067LBXo+rZuBWMcs9S+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790657582; c=relaxed/simple;
	bh=o539DLIWyqO/sfBi2fiRqwS9Yb47Tj3vo/VA1D2HkO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk5mqDtJNu0wR5YqqnL6bsCAO30Icq6ZW9zKfz/cyH/UOSDCNyRBToPAwBC5vModaGegi1LXGm61jb3XYGa77KKU/3LG3D9t1MCNXZ6lwe3baFRapZfXKXRMQi6Sfh0DLRIRjI/AVc+ZREWokQKXKdNL2pncoGhH4RE8iL5N1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ArsEW9R2; arc=none smtp.client-ip=74.125.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ArsEW9R2"
Received: by mail-pz2-f32.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so1418278a12.1
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790657580; x=1791262380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w/gMauj1wMCFkJAvjOeOaee1hM6WQfyxkgyFTZYH3bE=;
        b=ArsEW9R23xri0/RiwnWh172La+Eyk8MrUtfv3MA1O6k2sNMzF3vYyy2WRbqzEYYO9v
         TfsV8ZBHrrsxZ7v9oeF00xd8/TctCTymXj/5ya+wsW9j+DC2g+Bcco3Ft6ZkvKA1Taev
         kw75gRTWiQ1jW1JNvwgnMJ3fIVuKumypM+GsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790657580; x=1791262380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/gMauj1wMCFkJAvjOeOaee1hM6WQfyxkgyFTZYH3bE=;
        b=mMKenTnujIXEeH88Ft/tnY3S8rBasJ2I/PNsNCpkA1LECjCzxPXnziX3YIMw97Kiqx
         Ty/+Ld6ulRJwUzHh5iH5Z6lXa4to53fuPat269BoT5pQ/BAAUepaLdkVHK54InWPvuKW
         D/LYM24GWCRtPHkiU40KS3qOkV6UYqGyoSBLQzhHnzHbis34zM0G009PIQWPX9SSLhQg
         RKeHDTa9/7chXRdH1/BvR+UKNTv9HbZLVsFLqACgiLyH88EPYd6VxhzRrEJ3dx/rkJ7p
         A36T2IEVUgPXioRKXqdhego6J6uWzxbpFcHiT4aExp6vjKb9cAo2e+dTeMw5+0q6TDun
         dDkA==
X-Forwarded-Encrypted: i=1; AKwUvBxQZF7sP8viS8uCHbdwb9rko6DRy2Ru1WOWjV0yKPjPzkx66O9rZALosutlHZZt5fN87AsXIR5+Ar9rlA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJsY1R7RqIeykSZTA6mvpYubu2JPVJhtY+6l2iaCVtS5Rd2sR6J
	+2cZJSy1PW1dJZg07nSL63MVRS2oj2rTah9L8gGyCzysuRc3SlsmrHy/hsq9zIJRLVkNLTEKuFR
	8PSc=
X-Gm-Gg: AYBFou2/VdbyDROUocaacZY95m4T2qwnM1wpAbFm7+6mbciqs2eSRfmKw3fQFVquR3i
	GnqqKl2t3NnGrHtVWqP5GmaEiWx87un7qc7CA8nnDnO/O1pnaLilwVebDbCj/GbLXQM9OE6oNDQ
	TAsnAR1HTeCz7Wy/DtDJlC6omXgfyuEWmiUxz4+iz1WFH2KrZorKnLVCMNTdeyhgly8HfBPve5F
	RtUM5h6I3fqfwwyif9Bc+61aV6UTanxgJTYO+3kV2J8ETTkmbr0nDssO+/DlXjHPTDICSYeeHIw
	lHswN3nXonhpxmfAcY/MqrwpzlVWYZJMtx9jBrHT2dloG8lvBg+QVquE681KbDgkrfKwdImIlV1
	qJXWB/bjR8wdsFfIqftxfD7ZOt04QyMdSnmXD9UvTPD+VeJ8SD7AdLAUq9at2bE09d7aM+Ssep9
	hgNakikPp3R8BgnLDzs5Y0QIkqxesy9ZNOstedzqKu9Lv68ZUPTdnhboTe3D2EJrRHYiCv7vRjW
	cw1tR8nYBMuPOpaJY9MxWgCnSVy3KTEDxrKYdm21/aNMYP+TWc=
X-Received: by 2002:a17:90a:e7c4:b0:3a0:809b:1972 with SMTP id 98e67ed59e1d1-3a098ce5e08mr13570346a91.26.1790657580465;
        Mon, 28 Sep 2026 21:53:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5d05:485f:348c:a48b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858c123sm3423177a91.3.2026.09.28.21.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:52:59 -0700 (PDT)
Date: Tue, 29 Sep 2026 13:52:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Pooyan Azad <pooyan.azadparvar@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: fix short reads from block_state
Message-ID: <artCq0JFqBNcZkzY@google.com>
References: <CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com>
 <20260928164826.24858-1-pooyan.azadparvar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928164826.24858-1-pooyan.azadparvar@gmail.com>

On (26/09/28 18:48), Pooyan Azad wrote:
> read_block_state() formats each entry directly into the buffer supplied
> by read(). If the remaining buffer is too small for one complete record,
> snprintf() returns the full record length and the function stops without
> copying data or advancing the file position. A read smaller than a record
> therefore returns zero at a non-EOF position and cannot make progress.
> 
> Convert block_state to seq_file so formatted records are buffered
> independently of the userspace read size. Keep dev_lock held across each
> seq_file iteration and continue to protect individual entries with their
> slot locks.
> 
> Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
> Closes: https://lore.kernel.org/r/CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com/
> Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>

Overall looks good, some comments below.

[..]
> No runtime testing of the patched kernel was performed.

I would prefer some testing, especially given that you have a repro script.

[..]
> +static void *zram_block_state_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct zram *zram = seq->private;
> +	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
>  
> -		copied = snprintf(kbuf + written, count,
> -			"%12lu %12u.%06d %c%c%c%c%c%c\n",
> -			index, zram->table[index].attr.ac_time, 0,
> -			test_slot_flag(zram, index, ZRAM_SAME) ? 's' : '.',
> -			test_slot_flag(zram, index, ZRAM_WB) ? 'w' : '.',
> -			test_slot_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
> -			test_slot_flag(zram, index, ZRAM_IDLE) ? 'i' : '.',
> -			get_slot_comp_priority(zram, index) ? 'r' : '.',
> -			test_slot_flag(zram, index,
> -				       ZRAM_INCOMPRESSIBLE) ? 'n' : '.');
> -
> -		if (count <= copied) {
> -			slot_unlock(zram, index);
> -			break;
> -		}
> -		written += copied;
> -		count -= copied;
> -next:
> +	++*pos;
> +	if (*pos >= nr_pages)
> +		return NULL;
> +
> +	return &zram->table[*pos];
> +}

Can you return pos instead?  (and handle v as a pointer to offset in
other functions.)

[..]
> +static int zram_block_state_show(struct seq_file *seq, void *v)
> +{
> +	struct zram *zram = seq->private;
> +	struct zram_table_entry *entry = v;
> +	unsigned long index = entry - zram->table;
> +
> +	slot_lock(zram, index);
> +	if (!slot_allocated(zram, index)) {
>  		slot_unlock(zram, index);
> -		*ppos += 1;
> +		return SEQ_SKIP;
>  	}

I guess we can just do

    +static int block_state_show(struct seq_file *s, void *v)
    +{
    +    struct zram *zram = s->private;
    +    unsigned long index = *(loff_t *)v;
    +
    +    slot_lock(zram, index);
    +    if (slot_allocated(zram, index)) {
    +        seq_printf(s, "%12lu %12u.%06d %c%c%c%c%c%c\n",
    +               index, zram->table[index].attr.ac_time, 0,
    +               test_slot_flag(zram, index, ZRAM_SAME) ? 's' : '.',
    +               test_slot_flag(zram, index, ZRAM_WB) ? 'w' : '.',
    +               test_slot_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
    +               test_slot_flag(zram, index, ZRAM_IDLE) ? 'i' : '.',
    +               get_slot_comp_priority(zram, index) ? 'r' : '.',
    +               test_slot_flag(zram, index,
    +                      ZRAM_INCOMPRESSIBLE) ? 'n' : '.');
         }
    +    slot_unlock(zram, index);

    -    if (copy_to_user(buf, kbuf, written))
    -        written = -EFAULT;
    -    kvfree(kbuf);
    -
    -    return written;
    +    return 0;
     }

The SEQ_SKIP branch is probably not needed.  We don't advance s->count
for un-allocated entries, which should be enough, I guess.
