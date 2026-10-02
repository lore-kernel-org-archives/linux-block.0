Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B849AA34
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951143; cv=none; b=txTd6UuBrwRtjfM5eTEGQ6DElngxYl7+Vr9YG35p68488+NNe/QqPSyNTRVDgxb93ChgVrRgakaNruqea+bCj0P+bPrWf2RbkuxjCM3QKjIrbU8nQAjlTtsfSqoA5d8saJrhJq8iLiRZiJZDYl1Uh6n+LhIaQp9n15lbAeGml+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951143; c=relaxed/simple;
	bh=Ohp/QHsDmFh+DylqIS74grqU08piWPEjnIyZ5Wsszn8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g0kfBPH9TJxBrPbnEulf2G0DK7KF9Rnzft0ybqwjVl7/rliiTrBtcAFuN3iV2wJeLgOxIbHlKuQ7gCuoyVEwgSh4qzl56lWtJ3bdxu5+Dn2ofCkOm/443u0x+eExgCYqsax+NvuF5RnirVFPbJpD1J9jYiuibExbMs8TWjk2/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=So3X0h6f; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="So3X0h6f"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fb68so4867427a34.0
        for <linux-block@vger.kernel.org>; Fri, 02 Oct 2026 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790951140; x=1791555940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jw8IU+S0kg+UTErQSW7dh4lYfl8wngrkl9OOAXPXsT0=;
        b=So3X0h6flQfaKKSAZ/X+XEtI4W/Bz3ehOdtBYJvx5eQr86xUgYc9803M0R3ikxFRe5
         WvYtaA3tss4nK/hDbiFXlFUsRBmoQ0Jh/mMs0HdVnONUwNXUaZW2QaycVG/VqcHvJwE5
         36aYFLreyY+Ym96YlgP240b4tzpRUbXRs+MUHKqu0HfYAiXhmJf4jkzW37H81rc5Lr4N
         fFzVgGfak36lxwt9foodHTEoz4GJQTe3jLDSaxv+o/re1OC0JdLa1syeaRaK8lNVZVoL
         ZajoQjb57lNyQa1zEYyfQ834Pnr2cCTR8mNMFdfJnMehZdmagTf9F6SODHO2q5PyWCZB
         adqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951140; x=1791555940;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jw8IU+S0kg+UTErQSW7dh4lYfl8wngrkl9OOAXPXsT0=;
        b=tBDAMgqtPw4YYVVRhk6qX2chRY8r9+iUYf8p6x6zLzywNLk+huRPlFr/l7PceYf62e
         t2n5HVzxkQYVQOfpax3He3ZYb8AC5yvH06WbRzl97BGdeUvRnonMuR7vlLQuyeAsG16e
         8LxiNE/1yIUpGL3JRBaLPTywfOzpmQ9xXPXrLf8Nl4iAOOqts2u2kmGuOzZA78LCgXDS
         gIayYVYvhvMdR9OsN+wTufmUW8+jRBlmegGKJIGEENDeU/ZiHgQbNQtZwwQ5e3/lXXyd
         6gQXjRMEZz1eLjkOPI8BMnY5TfLIYx74/bdNLhmp0RV7HHjzPPy/MgB0OWu0N9psoKOo
         ixNw==
X-Gm-Message-State: AFuF++lLpkwOboz0HxMcukK86L2Z2f+AAvwWPiRaSR4ivA/i11jI1YA5
	zovvqRRQJjmzoc/9ItBX0k4agaVXBspww7Owf89cqFSqMxdDkhFa1mJOJ5WUjylZo5s=
X-Gm-Gg: AYBFou06cWzv5qiVpiQJ5MjHjVLC73L5bilNsj9833PkXxV889dnd0vqGiQBsE1Gk+H
	qlBeg+MeH16l3yabMA+M0hYrdKrhLrOkFXbekeJ86GnJsMyZDrXVnw8nWlGKH0zLmgHG/vtWiPO
	pCxfLGs80+q3bWI4EXTwdub1jb/tNITKJBEGIQf2DqXzf5Yo+5GTQHFi9wZnhsof3hSQ7NTpvVp
	sJNnjbEk1Sufnk7tWodpqE/tx6m6TwqjugEysO6pxEFTV+8MKc1ttrVM4CYvieTHyBqIlho5Gzm
	wMaV06g+/L7uWve38NzE+QrnN4fUgEL8RpTUwymYCkDb8142Hc2fkaZEEWbIqWiPsHgRNquhHBZ
	79znR7xrRMXIgXOtbkqnQ+SM8CoKU1MJAzpx++y3h6FoM1H3YG0R86eE3+pulTG5ncVaw0NZWXR
	WpX1HRM7ICShKW3mKZVZNFXnr3Nqw8nbxV8cJwn7LN1NRY/cdOOxnkOU3gm69tFBzoegBEVYVN8
	BG1av6oAH66Vbe/RciWvpuGLo8BwIgAe26ADjEBSHT5LSS4H5ub7f4=
X-Received: by 2002:a05:6830:270e:b0:815:cdb4:4a7 with SMTP id 46e09a7af769-82281b72cdbmr2695305a34.3.1790951140228;
        Fri, 02 Oct 2026 07:25:40 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-822792a1b6bsm2970566a34.5.2026.10.02.07.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:25:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 linux-btrace@vger.kernel.org
In-Reply-To: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
References: <20260720111417.1658507-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 00/11] blktrace: parse blk_io_trace2 in btt and
 iowatcher
Message-Id: <179095113917.28522.1401186462565976436.b4-ty@b4>
Date: Fri, 02 Oct 2026 08:25:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 20 Jul 2026 13:14:06 +0200, Johannes Thumshirn wrote:
> We had an internal report that the new blktrace format does not work
> with the btt tool.
> 
> This is because I simply forgot to update these tools. Do so now and
> sorry for all the inconvenience it might have brought.
> 
> Johannes Thumshirn (11):
>   btt: use blk_io_trace2 internally
>   btt: natively parse blk_io_trace2
>   blktrace: add option to request a specific trace protocol version
>   blkrawverify: use blk_io_trace2 internally
>   blkrawverify: natively parse blk_io_trace2
>   blkiomon: use blk_io_trace2 internally
>   blkiomon: natively parse blk_io_trace2
>   iowatcher: use blk_io_trace2 internally
>   iowatcher: natively parse blk_io_trace2
>   btreplay: support blk_io_trace2 in btrecord
>   blkparse: add option to emit a specific trace protocol version
> 
> [...]

Applied, thanks!

[01/11] btt: use blk_io_trace2 internally
        commit: 99d239becf12afe328a262ed9473a255a9d517f9
[02/11] btt: natively parse blk_io_trace2
        commit: 30ee0821473d64959a134cfb857248f8e4b8a131
[03/11] blktrace: add option to request a specific trace protocol version
        commit: 950f297e790fac0b85737ed5fba03fcc55df5a91
[04/11] blkrawverify: use blk_io_trace2 internally
        commit: 5d12335aece2c8a207438b1d27071854fd1f5c88
[05/11] blkrawverify: natively parse blk_io_trace2
        commit: 05d921fab95b43c2f3e2f9c4a020d3a72d2c9ca5
[06/11] blkiomon: use blk_io_trace2 internally
        commit: c5d11505bba6f000176485d1d694f7d668618e7e
[07/11] blkiomon: natively parse blk_io_trace2
        commit: 838bc02d9cff5f85ca8453980a7f610799a3c22d
[08/11] iowatcher: use blk_io_trace2 internally
        commit: 65378ab2fe0f3e0130562fad72789c94288c961b
[09/11] iowatcher: natively parse blk_io_trace2
        commit: 4cd8158ed9a8495fc8b5151f3288ed690d36acf5
[10/11] btreplay: support blk_io_trace2 in btrecord
        commit: f7c1738a9a2463d01ec2072a70f0d444228f9144
[11/11] blkparse: add option to emit a specific trace protocol version
        commit: bf32369c515f09aae6cdcc5d9a40fdc3597693d1

Best regards,
-- 
Jens Axboe



