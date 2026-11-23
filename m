Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465911;
	b=ciZtxX4NLbuiQAudn7cOrvYArMf+l2Ui+G03F+1RxLCZOvFv4/U/mdTvy5nXb9UWz/ol
	 vFn+ZUZT9TpFgu+ZDjORX9bYZqiZHg65L9Y4+l6RLQxbG+BmpYSHlqJZQIfg0bulykDOz
	 kDpqeTdOuJEWTtkklFcGHInweEQOcYdYQLLEXpacoaKvAZqKPnFxv4G+MdIHYk9gO4GQA
	 te+Iyo//l5qE+4lFv1Yt6U5ZUBmYQOA4R8S1JY7X3aAJrMe41/kBxKZ7oNYQKHcrmr7V0
	 lXGEYWV6dY0SHouI0UxaNuukdUbKzulUIblx7sMCccI1TzjPeRlWvKBAY+1ugoKM6bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465911;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sQ0FWTFeQrG6RUMpDQbCLQltxqCADv7gp0oxnC4p/b4=;
	b=U5Sv1K59adlx4hSKaEfPZDCHK5gLHKyUYKRIJNNenP9r5WuP8qURyHjj5lCunD3tALY5
	 C6nBoT1DVY3AoWK98Di3E2msJN7fljV3AD/RZzfKSoymkjnB8rUY1Z9ST+fOYlfP6NTtf
	 fvLMGyz2mJO2ShdsHsj91oM82ZEZcnONAtUltmZAGazWfHKy/5djZ8mhiChwqHKuoHeGK
	 DApRaAMJerYYYPnaIX9osYGVrxcsUBhTnygOaJ2jeuLrHFej8zSrIsoMMNMLLIfiQYbkd
	 Hj3X56PxEd6I2XAdnXaTnIyaUHt/slwfcI8vUUZP7IBk94jhVoI08aDhJ0Ee1drxZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30B606A321
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 20:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C30B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-491846221ffso3179831f8f.3
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 12:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465909; x=1796070709;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sQ0FWTFeQrG6RUMpDQbCLQltxqCADv7gp0oxnC4p/b4=;
        b=EP4EqlT/uNoF/vf8Iiu1gOkZqWjU0iePbzo0EQgwDgB2FhGzEMBuoTzq2rEwjfcUD7
         2ObqcGhB9UzBsgrlfEPDlTAoo42K2Vi/IVzcPesGkHIY2einK9EQ7dung+Pfp6bwTebm
         hdeHEfCs9PV4v75JZUW0R1PxRdM5ydTvwZYEfWTTk3RRDAtMxRUmL8ROX/imjtYCTcnY
         zduQG0VezufTZaFCkDIPzvgX1Egd/XD2Hve7Bt3FufBvOA4qlLoSou54M+sq7SCvauBe
         sK+zpy9cg2x5CnqAVZ8gp3rVrSbcSmNrXP6Q1A+WBBVYPazFoN2QCsZwf44mFzWsFJob
         V29g==
X-Forwarded-Encrypted: i=1; AL+hErE72x+jgUd0yIng+aZ6W8Sgt3jPPMp0nSwr/74hy4Qzm9F7Kxk8JV7OLTDW8RaoYrCR9VfHfyyiWXgXvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9pB5wnHoWi0P34gY9tB6PvgyM888mb1QAAC6m8EJ9+51cD2IXh
	My2itGQwcX/n3giYrcM6IiBevj8HcFw5b9S6wDDkIPmnWsAeQRi11ExluR1prQ==
X-Gm-Gg: AZFdTZfxPXV+7+ev0H1ty8aUpV7pDH7FFB+MP+WyO/3wmPY148ur0cY27/KG0xoqN/O
	g9IeJU3qRe5HOHPX6ATIQUA7nSHFcqZs6mEVW3lMJCIxET0KpZZy/3QcOVnF1WBNIh/cf39M7YF
	r7ASeRBiEXQmBM4Cj75WMXpN7yuPL4hHiZ1yjizZpbf6ERwKq3kaXG7TZ+FwoQdmMbWxpGxDdKL
	Lu27jRArmJSBjFJtwLAVmWaj9UxSDK5PfGcNPJ63Gn6aQ2+8H6oMMjVs1WPCPt8+6GagzEe1SWq
	DDK+m+aTvqf8iy8P8AeLtLeUa7ZHrU+gnh0yqcgBVMLTa9em5XBCx+5iiTlIMC4sPwmy9DNC1Er
	4sKIb9qM5Dzaqh+KTbDOoNZCifhSas46J/Iyijxxi5TGDmhMgEwCJA9fOS6iE0WHzJVjzFssaFi
	Wm7n4hQVEzW1bTtOv7aa/YAN8od7lpsKAH5rkz+EJ32fg4WO8NspYpT8iL2ml0qjlopjSW0HCLG
	uCFJoQZVJXUPFNK0y8bROKosk89zp+yZhkI/UoENk+wcQ86VQqWlJTYIYFA73Z9V8kmsXtT6KDI
	UMmk270mxRPnhIeaVwJTf7IOc0u5
X-Received: by 2002:a05:6000:4304:b0:4a3:1e75:16c9 with SMTP id ffacd0b85a97d-4abb4c7bb49mr23773054f8f.40.1795465908646;
        Mon, 23 Nov 2026 12:31:48 -0800 (PST)
Received: from [10.68.32.41] ([5.194.175.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm23601389f8f.47.2026.11.23.12.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 12:31:47 -0800 (PST)
Message-ID: <06ed8001-24fd-46e9-9481-b0862dca90a3@linux.com>
Date: Tue, 24 Nov 2026 00:31:40 +0400
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
Subject: Re: [PATCH] floppy: fix copy_buffer() OOB access due to ignored
 clamped size
To: "Kanishka De Silva (HEXER)" <kpskanna1915@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, stable@vger.kernel.org
References: <179514990028.24686.6400570561985206166@hexer.is-a.dev>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <179514990028.24686.6400570561985206166@hexer.is-a.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Thank you for the patch and the report.
Applied,
https://github.com/evdenis/linux-floppy/commit/d4f804348d99f6b79066f593a67d585ac0fc4fd2

Please, use plain text git send-email next time.

Thanks,
Denis

On 20/11/2026 08:45, Kanishka De Silva (HEXER) wrote:
> Hi Denis,
> 
> As discussed, here is the formal mainline patch for the copy_buffer()
> clamp/copy mismatch.
> 
> Root cause
> ----------
> 
> copy_buffer() correctly clamps the per-segment transfer length:
> 
>     size = bv.bv_len;
>     SUPBOUND(size, remaining);
>     if (dma_buffer + size > floppy_track_buffer + (max_buffer_sectors << 10) ||
>         dma_buffer < floppy_track_buffer)
>         break;
> 
>     if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
>         memcpy_to_bvec(&bv, dma_buffer);
>     else
>         memcpy_from_bvec(dma_buffer, &bv);
> 
> But memcpy_to_bvec() / memcpy_from_bvec() (include/linux/bvec.h) ignore
> `size` and always copy bvec->bv_len:
> 
>     static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
>     {
>         memcpy_from_page(to, bvec->bv_page, bvec->bv_offset, bvec->bv_len);
>     }
> 
> When remaining < bv.bv_len (track / current_count_sectors clip), the
> bounds check validates dma_buffer + size only, while the copy uses
> bv.bv_len. If room to the end of the validated region is in
> [remaining, bv_len), the check passes and the copy overruns.
> 
> Impact (corrected from my earlier private note)
> -----------------------------------------------
> 
> The overrun is on the floppy_track_buffer / DMA side, not the bio page:
> 
>   FD_READ:  heap OOB read  from floppy_track_buffer past the validated
>             DMA region / allocation end
>   FD_WRITE: heap OOB write into floppy_track_buffer past the validated
>             DMA region / allocation end
> 
> The bio page is allocated for bv_len and stays in-bounds on both
> directions. One bug, two directions — please do not split into separate
> FD_READ / FD_WRITE issues without coordinator input.
> 
> Affected
> --------
> 
> Introduced by:
> 
>   13d4ef0f66b7 ("floppy: use memcpy_{to,from}_bvec", 2022-03-03)
> 
> Still present at:
> 
>   aebb7274476403040d582c61478df8f4a7bf9cd3 (Linux 7.4-rc3)
> 
> Verification
> ------------
> 
> 1) Proposed patch applies clean on the revision above and builds with
>    CONFIG_BLK_DEV_FD=y (floppy.o hashes differ unpatched vs patched).
> 
> 2) AddressSanitizer userspace model of the copy_buffer() inner loop
>    (faithful clamp + bounds check + memcpy_*_bvec helpers):
> 
>    Scenario: 16 KiB track buffer, dma_off=15360, remaining=1024,
>    bv_len=4096 → size=1024 passes the bounds check; helpers copy 4096.
> 
>    FD_READ  UNPATCHED:
>      ERROR: AddressSanitizer: heap-buffer-overflow
>      READ of size 4096 at 0 bytes after 16384-byte region
>      in memcpy_to_bvec
> 
>    FD_WRITE UNPATCHED:
>      ERROR: AddressSanitizer: heap-buffer-overflow
>      WRITE of size 4096 at 0 bytes after 16384-byte region
>      in memcpy_from_bvec
> 
>    Patched (both directions): clean, exit 0.
> 
> 3) floppy.o with CONFIG_KASAN_GENERIC builds without warnings. A QEMU
>    guest with CONFIG_BLK_DEV_FD=y + KASAN ran I/O against a 2.88M ED
>    floppy but did not produce a KASAN report: ED uses a 64 KiB track
>    buffer, so room stays >= 4096 for standard geometries. Live kernel
>    reachability of remaining < bv_len with room < bv_len is therefore
>    not yet demonstrated end-to-end; the clamp/copy bug itself is
>    confirmed by source + ASan model.
> 
> Conditions for the overrun
> --------------------------
> 
> CONFIG_BLK_DEV_FD=y and a floppy request whose transfer is clipped so
> that remaining < bv_len while dma + size still passes the track-buffer
> bounds check (short current_count_sectors near the validated end).
> Requires local floppy (or equivalent) access to submit such I/O.
> 
> Fix
> ---
> 
> Open-code the copy with memcpy_to_page() / memcpy_from_page(..., size)
> so the already-clamped length is used. Restores pre-13d4ef0f66b7
> semantics for these two call sites only.
> 
> Patch is attached (also applies as a plain git am of the body below).
> 
> ---
> HEXER (Kanishka De Silva)
> HEXERLAB
> contact@hexer.is-a.dev
> https://hexer.is-a.dev
> 
> -----BEGIN PATCH-----
> From 67606424cf8dc4bd1baa690494a2644095beddb7 Mon Sep 17 00:00:00 2001
> From: Kanishka De Silva <contact@hexer.is-a.dev>
> Date: Fri, 20 Nov 2026 06:45:35 +0530
> Subject: [PATCH] floppy: fix copy_buffer() OOB access due to ignored clamped
>  size
> 
> In copy_buffer(), when iterating over bio segments, the transfer size
> is correctly clamped:
> 
>     size = bv.bv_len;
>     SUPBOUND(size, remaining);
> 
> However the subsequent memcpy_to_bvec() / memcpy_from_bvec() helpers
> both ignore `size` and always copy bv.bv_len bytes:
> 
>     static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
>     {
>         memcpy_from_page(to, bvec->bv_page, bvec->bv_offset, bvec->bv_len);
>     }
> 
> When a transfer is clipped so that remaining < bv.bv_len, the clamped
> value is discarded and the full bvec length is used for the
> floppy_track_buffer memcpy.  The bounds check above only validates
> dma_buffer + size, so dma_buffer + bv.bv_len may pass the check while
> still overrunning the validated DMA region / allocation:
> 
>   FD_READ:  out-of-bounds read from floppy_track_buffer (source side)
>   FD_WRITE: out-of-bounds write into floppy_track_buffer (dest side)
> 
> The bio page itself is sized for bv_len and is in-bounds; the overrun
> is on the track-buffer side.
> 
> Fix by open-coding the page copy with the already-clamped `size` via
> memcpy_to_page() / memcpy_from_page(), which accept an explicit length.
> 
> Fixes: 13d4ef0f66b7 ("floppy: use memcpy_{to,from}_bvec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kanishka De Silva <contact@hexer.is-a.dev>
> ---
>  drivers/block/floppy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c677d7838..b492e35ca 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -2488,9 +2488,9 @@ static void copy_buffer(int ssize, int max_sector, int max_sector_2)
>  		}
> 
>  		if (CT(raw_cmd->cmd[COMMAND]) == FD_READ)
> -			memcpy_to_bvec(&bv, dma_buffer);
> +			memcpy_to_page(bv.bv_page, bv.bv_offset, dma_buffer, size);
>  		else
> -			memcpy_from_bvec(dma_buffer, &bv);
> +			memcpy_from_page(dma_buffer, bv.bv_page, bv.bv_offset, size);
> 
>  		remaining -= size;
>  		dma_buffer += size;
> --
> 2.43.0
> -----END PATCH-----

