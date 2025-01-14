Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C923242D
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864198; cv=none; b=ZiuDAvkv9jFjV4Jf0sh9JlRHHbJtB5W2Z0MWCF3lDYMz0DSYhsOXUM0b94wkdjS/8MywMPehH17eyNFOfIwdbq7QXEQz+ll9qmIdE9EJ0Sc88UM8OMg6Nqi6B9jGU6BYsY+Re9CuGW7qWYTISm6rXhoyE53yFXPVL6jhfNh77W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864198; c=relaxed/simple;
	bh=zLYV/p4NbWucnZdMWOxClcKApUEICGzHbrP82gUQFUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFEgOYwUb/WgNimbwHpmdZ0u45MapKH9yQmPVKgK4+eGl9XOUYoOrl+qQKKlUQm254DBQuWpL1oQrTDmIC+togAPtEt5DZciHB9iPH2MbnZvgJreure/59BErmytOkBPgYZ/bcOHUQFl5Djnw2dsQDL+M1nAkT4lBy3cbRHm8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z3S+/wBB; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z3S+/wBB"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a8160382d4so14658485ab.0
        for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 06:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736864194; x=1737468994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piueM2ZbjRCE6konTEuQoeTyqo98eT09jJWpTOuRcvQ=;
        b=Z3S+/wBBK0Tg4ecsdBYYEyl5yg/PJ2nKQH5AwefO3sYQR13Wc6wvTX22CEDWvGC2Nw
         ZCvCS8Ux6bVnPXL4iYAZjCj7ZFSbn2Jp/0GzGc0fUy/Kl8WaHFLCMi/8LzsrfCRvO/Iu
         R3ogJwXKCI0TM53+EgH4FUFHBBhBXqX/COeiSImI/jUTLwQw1KohOUZJSjH0Nx5Gtgd/
         3ise4IlqMRzlDGOI/wEKULo+icgn4qU6iOwJ0smYazRvyMFo7avFbauBWzeOoWYG54Co
         aFzZYqeXkIQRqzp7CbnXYPM9bduGBCKF7P+Fti1rVlDkm+afRSzhSD1OedEzeGxqJpcG
         6HPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864194; x=1737468994;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piueM2ZbjRCE6konTEuQoeTyqo98eT09jJWpTOuRcvQ=;
        b=rL6zFpDwPVikF57COraVEQR3Bip/FbU8zxK2tkUZmAYtWYBI1wwbi9LriaB8E040a0
         fsX6V+dc6Kz1UXU27Qh5kpTUPOl0Yiw4YFFLc603D3w+SbIJAkL6GmXq+jEW0Az4UiIK
         pf8TyXVGNyoK3ygrkL5UikBgOhVfAIL4RBlIp4pkNJoYkm2q2bEYtPMHgxQRbjs8dKCV
         Uxn7gbVCwi3vNRh3VKdxNGZq6inTYJNYBR2QJtqvq2ADHXtp4c0tK8PWq0nIBSsjmBnW
         c7b2JTIONPGRVt8GdnhPnW0Pmuhu62yPXtPRI8dzSs4q+DuHh4Pe+eHuiEpDoM+8xiC0
         tsPg==
X-Gm-Message-State: AOJu0YziZsoL2bWh8SqY/gzv7/+f/ZlJDQXPgnel01DqakSkFIrg4dnW
	TI1OkAeHRE36e6iCljQ64Rphz4oHzaQHAFig1bWRHfG6JZ3HmUmpV15VEdd1rQc=
X-Gm-Gg: ASbGnct/fU6dHYXwhq6IIqg9k/frbNhdf/RlhIGbn9CMd+EY5dny+jy33l8kAiDgWo/
	tTjudZfLvpmWhpJflL7xQufSxUXZFzzJDhMS+SGHmMTXbiZETO1runYKZKfYKrAHvhliElo0DV2
	btXRPUpWjJv3Dwi+jgoJprAov/Fz1GbLovoVcHC5jQpws1HJvar46I+0IOf/mgvwZn2oY/l62US
	kElUFbsn2vL0271g+sjiBWSXXKaiMtu2GHmG5CZ6iGahVjHMRM3
X-Google-Smtp-Source: AGHT+IFvZTCl3oJ+SK73bM2PFw5HmarmpttrBz6f2pmfBDtURiNZ/JAdwv8cVfDxUiql3uvfEok/vA==
X-Received: by 2002:a05:6e02:1789:b0:3a7:8040:595b with SMTP id e9e14a558f8ab-3ce3a9b8fd6mr148487455ab.9.1736864193723;
        Tue, 14 Jan 2025 06:16:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce6387bee8sm23453545ab.72.2025.01.14.06.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 06:16:33 -0800 (PST)
Message-ID: <d384b565-0be8-461d-ba8c-0185842c9d9c@kernel.dk>
Date: Tue, 14 Jan 2025 07:16:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] block: no show partitions if partno corrupted
To: Edward Adam Davis <eadavis@qq.com>, hare@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <abd5921f-a37f-4736-b1b4-920a5c108f71@suse.de>
 <tencent_9E78266DF82CB96C549658EA5AED66CD240A@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <tencent_9E78266DF82CB96C549658EA5AED66CD240A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 1:51 AM, Edward Adam Davis wrote:
> diff --git a/block/genhd.c b/block/genhd.c
> index 9130e163e191..8d539a4a3b37 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -890,7 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
>  
>  	rcu_read_lock();
>  	xa_for_each(&sgp->part_tbl, idx, part) {
> -		if (!bdev_nr_sectors(part))
> +		int partno = bdev_partno(part);
> +
> +		if (!bdev_nr_sectors(part) || WARN_ON(partno >= DISK_MAX_PARTS))
>  			continue;
>  		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
>  			   MAJOR(part->bd_dev), MINOR(part->bd_dev),

This should be a WARN_ON_ONCE(), and please put warn-on's on a separate
line.

-- 
Jens Axboe
