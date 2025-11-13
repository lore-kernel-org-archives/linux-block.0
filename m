Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C5314D14
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014132; cv=none; b=hfngynMepMWGs01mRdfOVDpNEZVFW1xikRR6iwKRiS8UYxe70CuFMilDsq+5qzpacvJfozp0Mtxc2v2f2D1h2ouxAjzmSl1B0zaIXOOnMjLP0RtNGeZlEJ5QGXHs6K858Q6QiKvLD0Mxjl3+zmwWar6T1ASC3fa361ClRi1+3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014132; c=relaxed/simple;
	bh=deLgONR1W7cbFg3Z0GUolTT/I3CXisjAflanAAnCAF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMZdZcos+LVBCTYpcT2HX+gcp3BsHv980J4w1GkuoqUQK5mOQNVE3yMuaey/RZuN6PYsdnwTQTdr77mrDBkHgald1yMQvH/4a2y7Q/MyDpxcjdfp9oMpYcgzU/0JyCiPgZjHPZCEnVijC5/u95zaThB3OCAEav/twJbjUJEhwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BlMOjLhH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BlMOjLhH"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so247707b3a.2
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 22:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763014130; x=1763618930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gw80Q3rADiMFZJQ1jC3X078+JYTq1Rdist1GKyxgI/A=;
        b=BlMOjLhHJ09veowAjajEZSwhdj5+KdOugbuAOJ0o0Uf8KdU6W62jMwfY7X405TPDJd
         wLI8UlZDt2EyMaEwkOV94dPd7D5Wu4W4k0nD55VKqhA7dCfcQm5aT7V1qs1LKLTRGe0U
         DywSO6u2hFp24frfz/YZ30vLTIxFW0glqjZNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763014130; x=1763618930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw80Q3rADiMFZJQ1jC3X078+JYTq1Rdist1GKyxgI/A=;
        b=VKQpk/3B5yyCwPROXL5c0gyR9ngg0CrwXOyIYstYMQ+obgGiVmY5rJZ8RVBH/um0rM
         /7P8UMA7gvFofdJcxlA1Jj3LWvEjCXuCgPTLGiy1KyV1F+28laN7ecQ8qQ0ulNkJp4h5
         HeNmcyhrGphifgdMNj4CG9XcDn162BSetrx+s14CICVWtSkXjLqrvflM6UnK8hh7GZ3R
         k0UVHCuskeA2v1G05FiBS7Md7S3mJEkeSG0XjLnu04gIvi7Eoh5JPwpEvmMjdBbCABip
         MIS4m4LnplOaJnofwJK1pg/pRZyeIfH3eKvYiRidQC7hEbdBQUduI2xpX9U1z+1jKe4A
         +X8w==
X-Forwarded-Encrypted: i=1; AJvYcCX0Ouf1sr/u3mzS5pZI1/7GR8soCXoQodudxxcOLA61pW20yXC26/h8ffKOhdnW65EBl0k/iNUqyraysw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57DBd2iW11vmJ9ivcs1CXfTFDXZiCJmArqvO5hj4yM8bdPFsx
	0Iw+OHGL0v/+V1WhlpkR6Y2h0hFfoYaq7ztKOfyP9SBzX55qz14V/1K8qx3704NbgQ==
X-Gm-Gg: ASbGncsyTmimFUTt38Q5f/tbmptnp5ReCvaLHcbvQerecWOrkA1ieLGwmMo8lazrtRr
	hlrXiprMeeI14G5aLLKCG7p1V9dAIQQnZcjO0yOfoAMRtjG2TgiWd0pRzk1Wbrdu03dTDcivK7D
	KY6EEx0S9pxAq/JIiBCXyQxpG3v2DEeZfvSmYWOYUmvma279deVAq+lz9tS7+hGux9ch3L5n1bR
	wy7gySvwSdU2re5PQTeVLNxQZ15YLXNpfjxxTGEsOHfNaAOy+qsYGnD08StiFysTTLTHnaYi6Kk
	H6X6PIUkdImev1Qu4ISo0TUNcUZVXjSZX2ZnhnxPmfs7EcdUO+wDlaCUVh9HgH0DcS7UxXN0rqk
	ek2CpKTo8iQpufboNnxQKwkgsIedd5ywvJAYOSCzGL+/23tt1rN0lpp66Zj/Uy2Q0K/m9W/S4mK
	KUArFV
X-Google-Smtp-Source: AGHT+IGowM4k2KBhCbph1UBTZNDjTuE4Z+T0S2CNV/KUAFRo/MaW4AiJx6RQgvWm445j+0v0k5/emw==
X-Received: by 2002:a05:6a20:3c8e:b0:340:aead:3c with SMTP id adf61e73a8af0-3590b02ae4fmr7840094637.37.1763014129699;
        Wed, 12 Nov 2025 22:08:49 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aea0f8sm1003329b3a.5.2025.11.12.22.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:08:49 -0800 (PST)
Date: Thu, 13 Nov 2025 15:08:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: introduce bio batching support for faster
 writeback
Message-ID: <azppxi725gcsjgbmcy6c2zvjwgevzt2ci6ri2bwsdc7x3zrk2r@w5yiry3cy2kc>
References: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>

On (25/11/13 14:59), Sergey Senozhatsky wrote:
[..]
>  		if (!blk_idx) {
>  			blk_idx = alloc_block_bdev(zram);
> -			if (!blk_idx) {
> +			if (blk_idx) {
>  				ret = -ENOSPC;
>  				break;

This really was not supposed to happen.  Will fix in the next iteration.
