Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB63F99F4
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809837; cv=none; b=pcuCmbQE4PIf4+z7cR6i0UTW8Qrkb7tHlKhA1489ndMYUuNz6sjfjFP6Wvwn1VRejENDYZ+9pQ35i7LcHHeF6LFzVYXPlDmUiVX4fN7+x7T0ylRPQtYkhdtPmsH7x4E5vwyjVTsxFegqY1XMQPOYy/RfARxHeSgBk8EoGUUXVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809837; c=relaxed/simple;
	bh=ugd4ls8P5Ob2mAtM9nqRZHiYdUNlnITlBsPv5xzpvGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gE/+M/E4I/rNGUsUT2vyFmgcfWPMl9id7MbWmuC/C33Gti7oPShrlOZaZbNkO1McPu78Vqq4ZXXLanrEBfeDdzDphUxxA2cmLhP+y9n3MKvQkJ33Zy5yBy0HTd4fyotXqgUFqOXx1hNzjWmteSsBCOD0o9aln4UI540HXkmuUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=zhJGm9dP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="zhJGm9dP"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso490694a34.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 19:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785809834; x=1786414634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9x4qFGP3981GI72cVLYj63qdKZK9LaH4l5mhfg8vJwI=;
        b=zhJGm9dPx5WjuPfyMia4b+7ZIOFP8Ochr3tnOvbz2oG7s7d93bjJyxkO8yjSgUVxIF
         7IdyKatN3l4QEx4bvnn/+YS/6Bpr9V7DoIOTGvtZjPnXi0EedeODLelEmiJ8w0As0tKK
         obqFfr6SSBMqALIe+qqM44G9ZE66lAjV6eStgoeuVAUtctbta45qsL/FFCdYBbSSJy/8
         7cUdJs51NQaL0IJZPsmEWHCEKRynZ/42vCmmx7EXazeMCpB0Sq2b+3JdMb4Nz/tqd2k6
         m/x19SbRhPzoIGv3mRQMjj9WkJ1DE9L7ofZ/Rsi9mBCy/nueJAoVFpEaw/5/rtlOL4h0
         TAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785809834; x=1786414634;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9x4qFGP3981GI72cVLYj63qdKZK9LaH4l5mhfg8vJwI=;
        b=Snu2T6aYuoEVo3c9BadAVNumWH17vu6KslhGARpgrD+cxyKsgu6xuNqk1t96sojuHD
         MmPfDi4l3vaZ2znur3REy3GHPVBpSzN/W4r2dal/TEpK5dQuv297zRJD5P4lDRx9K3nq
         4oQo5hQpHLEA13r7P+UDpQm18qBl3oI3QTgVvCopOpNX+9xATztUjh+ap0DBHHv3i+5C
         vnhpXgFW/rZvQnYmXLOA8VDCzslu73fkgR9m1i3JRzFn+fdCt1rDOfh8ZnInr5gIlkyF
         E129hQ8s7Ay5rg7nfj8FGcrE14TC48rNA3pKf/G6V8laFfJlDpKR9PYW5hhIUcRXocMP
         RvVA==
X-Gm-Message-State: AOJu0Yzzn1r5W2pf9qwu5ruIkFT1Fpp2jA629dEaUL39RYref8aCc/Cl
	+TcT0UY4JiGzw4bNFFmR7HXlJm1yBThGMFzDXzE6/KLA2elKg/dhpgv+5lCuqyn7Fmo=
X-Gm-Gg: AR+sD10cp52IPIiaO19DmN/5vkkzS0gdjWMb5BgD4zXy7IjmCh8pyXyT+ELmq6o2fiU
	KonAaoHch2NxT9rQmdMpc80o6sKkwqX1dky0RzLtHRcadzSn5O0fd6fP07/ErEo3t5VdU+kQM2y
	9F/BcHMKlshBWASV4fFk274LhP+nAP1tl5KiPO6RpgPFbKEbpBkcjcslhFzNUUWZT5vILS0CN61
	4PztPQmPdjZ6L49Bjc8SdwMORgI3XbrlbEqOMjQowP0aWWhHF+ioGReqyKqMaCH18b/bxvJ0385
	VJWVVJ48NXQjTpDt73hspJF+tdnSeOQxHMyXinWnSoOQ8Ylgl7Bizczs15a89Uf/oj+WbgiZXQw
	dUI7ABzxgUhwqOxH07C0pjVNcLzEuYR5/NYAI+VqQUiH5epYtSwxyQorpJaou5HQzJQNsR2iKLq
	lSImr8vWt2U8xzYcE8e0QRPKNw54xYwOs7RvTpbXGWXemT0bQugIppzjFrWaJ8rQK8N8BHFJoWa
	maaX998trnjFb0EVJuVqz4gE2VIDvexTYdkY+UEX0Opjn1DumCLJQ==
X-Received: by 2002:a05:6830:a15b:10b0:7e6:d7b3:76f4 with SMTP id 46e09a7af769-7f1d1f48765mr1019984a34.0.1785809833793;
        Mon, 03 Aug 2026 19:17:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a55asm8914812a34.13.2026.08.03.19.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:17:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, josef@toxicpanda.com, yukuai3@huawei.com, 
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260717054855.2018578-1-cui.tao@linux.dev>
References: <20260717054855.2018578-1-cui.tao@linux.dev>
Subject: Re: [PATCH] blk-throttle: remove dead field last_check_time from
 throtl_grp
Message-Id: <178580983269.518281.12242691821732111063.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:17:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 17 Jul 2026 13:48:55 +0800, Tao Cui wrote:
> The last_check_time field in throtl_grp was used by the
> CONFIG_BLK_DEV_THROTTLING_LOW mechanism (in throtl_upgrade_check() and
> the downgrade logic) to timestamp the last upgrade/downgrade check.
> 
> Commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
> removed all five of its uses in blk-throttle.c and the surrounding LOW
> fields (latency_target, last_finish_time, checked_last_finish_time,
> avg_idletime, idletime_threshold, bio_cnt, bad_bio_cnt,
> bio_cnt_reset_time), but missed the field definition itself.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: remove dead field last_check_time from throtl_grp
      (no commit info)

Best regards,
-- 
Jens Axboe



