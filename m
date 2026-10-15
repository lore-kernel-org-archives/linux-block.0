Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162E13B27D4
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030310; cv=none; b=ZXqNp1mvfs25T2mjVNIqxryLoc3T/HPrmKKLfuwbmngJvWr9C/t3LBHTqcWPm7DB6vdxl/L+V3Z9Sb2F7EdFItrLk+brnoIg2PcCf43UId1MaM2yXozaQNkpenR2KhAefHcRUE+nPNxfGuh0Asr1MRsKmLskl84fbAl4tNdtF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030310; c=relaxed/simple;
	bh=Do0iA8uNsiwH96pQFdYvdEdXnoS+GP1Eort9RjA8HUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+gPR3N83Hzt+B5nzQX5woRYkNeb3FFLknuNve0ineDswDOntN3BFHJ++xuDrts5tVnoMXlB8jT20OopKCFCvwJnFLRD2aUe3OOoS0Fhyq+0HqVMjO2WG5XXENLYohsbqVYVVlMEXMQQxWnLskSfuH4oqLJ5v17kJDbDgK412yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k/antPzB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k/antPzB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso686754a91.3
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792030307; x=1792635107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LvIiWBHgt9RJ8Lp49q+d6DWrLq7WNl23wUdd8hsh/fk=;
        b=k/antPzBLeg485CCGqKBqHAUS2UL6GXz3uUQgsiwaj3tiJhn+Hhl59X3NpX7mYIBcV
         ENBHJCi7xe6nZGtLgVaPiyaWjWqBUrrXfs1pjZAD5NqUdH26TpWtFW8Ku5OVnoT2jKX+
         N8HbKOaQsZGbOvdRIvqr9/4dgcpSMDQjy912w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792030307; x=1792635107;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvIiWBHgt9RJ8Lp49q+d6DWrLq7WNl23wUdd8hsh/fk=;
        b=aeKjmnrsN1ZoBjINJDq6igR9PYUSJ58xH2sFx4dMxkCUkVkmazQUgkpxqtcRQsxfwR
         lmLiDUs4m/fOeL4yoKAcCdB4WVZ7i2AQDVloWHbd+WVaF1rI9pQu6gT2Nq0kR4namiYn
         I86SktDlhhRu8bBns5ntg0xLkeMdNqNt8dArMuB06YiiCzaYcpd1flldK6kAKXZEy9Sv
         FauvQs79gXfc2DnqPyzsI5U8pl6BpmXRWbftyp7P7txVZes2Ed0u5uMrfRcB2DKDyeFi
         r8eLDJlQNQFnXI83quANQd4ZFPIeHrnd62NdErVadOk9Klre/f7fDTUC9G718Ycmfqlj
         tSRA==
X-Forwarded-Encrypted: i=1; AKwUvBy/iFTx4o9uiB2C5GgzsKlSuVsb7fDwIabruM0cNNLrzbs0V4ih1YFUezwJQ9EK20SufHB7gS2pwEjJKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYINmzPbfuWL3lXSQEy+cbgoZ8H3s0GSPKG9fydE5dGreag60NtJ
	puEZUi/jx2jANpncPIlxccQq0JqDX2NUOtKE6i9C8LWUjxy7aVP7CRK7y7E/apYwzA==
X-Gm-Gg: AYBFou2bdQ4gPtv599XKDCzUrTsRsr+RrYWLDE8Xnaxh+dT429MPeoJ+abmUY7k5OEj
	5USysnqTezAS22SdZSHAcy4kgedZf2qQQ05ZRxM88hMTTcnmjwR7Q5f+K3FuPrhvIXkYacL3te9
	J32MtKwU6t45KVy5GDf4Y6sPMhR1iB8neTQ3pTU9A6+pvb28i568kpmgCDF1uHNwdsM1w2B1rrW
	NIX0fxN3sps7xCup+xp3WjtsLyh8hLR0VVb0FTsx2Y//TeQBRw9+f6NPEV3gh0owXaASNvVphaC
	ZRVSiZYaeGLKQxGpG5Fsh/W5gsv23NnadScWt4CBpN+wTOHqn7fjzw6XGm9+R3VeZZpeeygn1SS
	NHo2S6xuxURSmemOnjWWDCutqWH6EorJQw7+fl4SS6Ha5/dytewG0/H5AQ8oDty/O9745jATE90
	+yqulgNHrNv0PHR3HOrEwi4TpkEvN+pV3dPZESbyyxQV1aqcrjKQnOhAPFPieJ52Ih0OXhHHU1/
	UiOBRz8l16teyIhMflveyGdEnadMVcTUPJM33E=
X-Received: by 2002:a17:90a:e7ca:b0:3ab:36c4:b500 with SMTP id 98e67ed59e1d1-3ab3a39f232mr15295954a91.5.1792030307388;
        Wed, 14 Oct 2026 19:11:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8455:7899:5a2e:26f8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac937f2d3bsm1227191a91.4.2026.10.14.19.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:11:46 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:11:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Bo Zhang <zhangbo0325@gmail.com>, akpm@linux-foundation.org, 
	bgeffon@google.com, minchan@kernel.org, richardycc@google.com, baohua@kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atA2JznFm8zLIMIb@google.com>
References: <20261013035201.2809924-11-senozhatsky@chromium.org>
 <20261014153603.1365617-1-zhangbo56@xiaomi.com>
 <atAj9o5IgrAeiGiW@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atAj9o5IgrAeiGiW@google.com>

On (26/10/15 10:41), Sergey Senozhatsky wrote:
[..]
> +	if (zcomp_shared_decomp(comp)) {
> +		struct page *pages[2];
> +		unsigned int flags;
> +
> +		pages[0] = sg_page(sg);
> +		pages[1] = sg_page(sg_next(sg));
> +
> +		flags = memalloc_noreclaim_save();
			^^^
			memalloc noio

> +		src = vm_map_ram(pages, 2, NUMA_NO_NODE);
> +		memalloc_noreclaim_restore(flags);
		^^^
		memalloc noio
