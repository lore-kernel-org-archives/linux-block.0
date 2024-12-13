Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E818DF7C
	for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734076827; cv=none; b=AokBcoRYIzcRy7DIuFs8DABpTBzWqBGutQmwIVgWg1gur0sbuwmP5KlBp4pYhW2rT92MV8c1OqazVSyeBAva2j4TtDK6RVIgwdwfBdzMiQQXUaOZF6wvex4p3wou12jwfFmCEg+lZH40w6TOlK5c6T4UOU9jAUCuU02YBANOjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734076827; c=relaxed/simple;
	bh=De+XKUlxdDAtzt4S9WN2Ib9SR9euZ6C9SeLMwL3zAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzQxXMtpiAvxuSzGP3k5Huh/SMMHCfrC7EXUtsgq6uP50x78LUFJpBM2fqrtu6U4T1FHGFKIfgW8oCBSg1AmMZY3KiT35T0m33klb/BETOt8I7QwSK3ayFWFsjzD1447ENKVqmzeNpZ1TFd45e1LdK/SWIOa5sIWkNxQKnt+zbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VgkXP/nL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgkXP/nL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so1266028a91.1
        for <linux-block@vger.kernel.org>; Fri, 13 Dec 2024 00:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734076825; x=1734681625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+VcW/gT5gahGNm/Yx5OtnhIWsW1Q4wxzsxZW8CFyCo=;
        b=VgkXP/nLdEA6wgw/NvGoRuAJeAEpUjcdfMp4a5fRrfAWYR0JrMRaJ9G+KXZXZT8vjy
         sP4/8vt8amw5LQJ69+aa53IVMzVACCrL5lwVr5Ie0BYtYfcd0QDn2JdxMyrBQQjRnv8I
         lHccFaybScCGD3AIhDw8Vd8mqx2R4z7ZNOgtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734076825; x=1734681625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+VcW/gT5gahGNm/Yx5OtnhIWsW1Q4wxzsxZW8CFyCo=;
        b=ZJgPuGtfxJOGdMBbJ8TyA5AaknwkgceJ8485qsgDzvvCgxlhGZwnflqDTMF7Mhta+v
         Dl8Ba0AhXHMMR2Ew9UpVc07o2zNIcxqDCW5S19Sujpa/VJE1EiKE8tROBzPPg0s9qvYG
         0zBZP3Du1g39yZ2rwiRl7D0BGM7jpujbrHkt75QQpsx476BIIsAlVG4RsI1nfM8KEPq+
         aYjK7+rnye6Inu9gwkJxeGOQ4kX5dREVTTAGvaQ0Tywq8x3g7A7u31gtR9Tsw7/ocBeg
         VYaz9aKlTPJKWMmv6fy+XNbL2aGk4R8Xjg7L+nkWmCfDZ5UJ9m//hA6toMjtGcoJOAlp
         XTlg==
X-Forwarded-Encrypted: i=1; AJvYcCVdsCjlCCVOuEqqzf4Iy5704fgbB0n0pMt/NEzl7Xv1EUW0ufY45Av1bipeJxgj5BEs4Afa65gBu23x3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNF2+gcEoL3VO5VgaHV/anTascYv0IInyWTL8KuKUsbwJXuEJZ
	8vjwLgepIRMw+fZ3qAcHpGAp+tooztTU7iSwkj/CSHGU/QPFb6eWD0HvYy9YBA==
X-Gm-Gg: ASbGncsKHaoAExuR52M0XChp7Mg8hoH4ej40fTEPLAZNBhPKxccg6Q0Q7BnxcDx8XGV
	b09rsK1c8YN1iTxo6py2LeHVkjLqhUGQfrfzQRGpEuzxhfA8UK5WGvWC39f2DU/GAcsPdrjPDdw
	juTPVdR3g2KE+m2N22Ev2RKtp4ukxqa4XK59JvGIYmJgmX73WStl33vXoqpmtZ4/Zwf9RnDu+rj
	tdhUxf9GJk0p5ilpybcyD5fZnP5MLZn0rrqXne8d/sMSxngce+GVwIeTjRs
X-Google-Smtp-Source: AGHT+IGAG3di1prCf2zZpmnUtKcuvJ11czBwkHzRleM6YVn0pT7NTaRRJDPHKzAHCHVn3u7r0aeXMQ==
X-Received: by 2002:a17:90b:38c5:b0:2ea:8aac:6aa9 with SMTP id 98e67ed59e1d1-2f28fd77f87mr2308613a91.21.1734076825081;
        Fri, 13 Dec 2024 00:00:25 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2d7e:d20a:98ca:2039])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f12cd09293sm2245435a91.1.2024.12.13.00.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 00:00:24 -0800 (PST)
Date: Fri, 13 Dec 2024 17:00:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Clarification on last_comp_len logic in zram_write_page
Message-ID: <zod7krcdvew5ntmcpbpgzpan2yph6jz7tfao2xowh7c2wmbckm@vc3bsf4fsoyf>
References: <Z1vf/ladGMjeGpfi@HOME-PC>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1vf/ladGMjeGpfi@HOME-PC>

On (24/12/13 12:49), Dheeraj Reddy Jonnalagadda wrote:
> I am writing to seek clarification regarding the use of last_comp_len
> variable in zram_write_page function. Specifically, Coverity has flagged 
> the issue (CID 1602439) in zram/zram_drv.c
> 
> Currently, last_comp_len is initialized to 0 but never updated within the
> function. This renders the conditional block shown below as dead code.
> 
> 	if (last_comp_len && (last_comp_len != comp_len)) {
>     		zs_free(zram->mem_pool, handle);
>     		handle = -ENOMEM;
> 	}

That's a "known issue" [1], I deleted one extra line during rebase.
However, I expect last_comp_len patch do get withdrawn soon [2].

[1] https://lore.kernel.org/linux-kernel/20241211100638.GA2228457@google.com
[2] https://lore.kernel.org/mm-commits/3awo2svbnsv2mvozhaqspwztgxhifphj7ffpmykc35py6wp6ol@xlt2q5qgv6c3
