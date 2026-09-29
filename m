Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB43E9C1A
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 04:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790656123; cv=none; b=AlHU8j5dDKZuevFKbZvuzwNSjrWeAjl6eCxjQwBczPGHhq8YGuA/oWsWaqZXZoOgd2rkmtgB2LVCAzpCXkv4ZqxNd4pgEwUeT/ZilVKfO1/vZHS0LiSLNhyuPVYxQevx8julKvqe7JRYxIiGe4FVjUL0tcepn/T0lvUUxPhyqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790656123; c=relaxed/simple;
	bh=XCJXy8mpTEA/nG0GkAEF0C7KhBtyatIGu3/yvND7nKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6qAYK2nNHebMlLCMRpt4r94JOOzEVOtHdOIyzTfB6D/hKzYMozp1kca4kkRTLxSvEPSxapuWpW+vKu8vQLEABIAoeoptgLefVDjGK4uShvZEYFEPnPvDLrNoLVFc9cCfIDHU79xJ7T+6/yK0YlYvG0Nw4A83npfINkoUAxO+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hKducV2A; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hKducV2A"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1726083a91.1
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 21:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790656121; x=1791260921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G1J+Crm13KpKHhtBJ6lWWXDuL/HrcWdM9aqmpruQeUk=;
        b=hKducV2AmWnS9w5G2FwLROE7fBIJ0umcUd3H6r19cZi+O4QFIMMoA8x42iQU8SWz/S
         92Mwt3BI6uWDuzNKqj0/MZoLMgkAFhMLBI8iJfmdjn70gz5J3LBfTco5nOXLCJ4fvQzC
         Ip32pSMDIcU5uWZ2qHanGzw5CbLYvCRs2N7yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790656121; x=1791260921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1J+Crm13KpKHhtBJ6lWWXDuL/HrcWdM9aqmpruQeUk=;
        b=QEYPtay1zRq1DViIeDivvRBI1oG7Ak5kZttmYhf3YuAjVd1jfV5RYJoiptohRS7eT3
         aFVaKzwcetnu2zkkObwoEL9Bqv8t6DlTXHChjEaKLMIFaxF08Mr4tapPbO1JC8FPD3+S
         a5xXvdX/6fPf6CG/hHHC8QKpVDi+APGUZ7lrXAs/zJuqDOV7PCbDk/mUxtbgY/CtApOm
         Vvegbjj2Qt3fmqe+AMRxa7+E6wTZLsrtcYCPSa0mFabWgqT+Bf2Kw4lw8dgCQZU/Z/rO
         Sdyp2NN6UpvfXzBnwuS+8zVXr99QYj5IRNYgF0mOKP6Lm4qNM/QnpciDsRwhVjKcEQC5
         lJ0w==
X-Forwarded-Encrypted: i=1; AKwUvByH/g5Jqzo/eKicoo83cNsgtRpipTllQKk73gUJLp9VyvaaXA8P1HtKZzdfCAYOSSdA090km44OfZo2ag==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4qhrSX2nkl14NrswgXPFWtMK0MTn1XJKjfMmt4/VnTPei2f8G
	mNS2wv+7IGqNA3774yIe2Nx5OZHWlBY2ARST6rDOJDgnOP7xG+VcqVPfoy5uWkTvNg==
X-Gm-Gg: AYBFou1fBPfLOzwvq9UKykcoHpdSIDvX9RRy9JE7jSL2DpcOAqLCR6s32hcKnKmibx8
	xrFQRkv575qxP20Pr+0E7LHLnRbnT0WNycTl2YetLfXP94XHVIbJEjVsD5qO/DIBD1QcKfprBdb
	ZiLds2UNrtVMGNPD9zoOFLeFDke4FKK7Z3KgEtk0HBzjGgbpIyDZt4/LH7l6ETv+JrL1T0pota5
	iO4CYSWUAS9uBMLxjUpXckofuzUvgFfNcP2V2QNfR2X26MEDvJSrb65/ZkRS3J+Nu+v4zGduieS
	7rUXTvtliTbDSvBjA6VumivA8OvEEiyBrvUMnAk1NLCFh3g4JoLpMbh+VddfOWPH48g7Vy3XgZd
	2dKP/nsYWme0FxDI3GgjVMY4Kky7gVpNOflawb4xOowe7NPRSglxrtUZDLTw17z8OjApnOaxhAh
	WHTN5h7KW0EV5AKUwbYT1u6x4O+E83sNJBcXLfpgJXmH5UucQi5dc8xaPLT48KA9QDUfb6z9Ive
	CEikT+ahJlFPu3WLNNpCHI2oD/5iPXj+tKerhk=
X-Received: by 2002:a17:90b:2749:b0:39e:5b3c:4633 with SMTP id 98e67ed59e1d1-3a0985be307mr11615607a91.21.1790656121490;
        Mon, 28 Sep 2026 21:28:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5d05:485f:348c:a48b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49867a4b1sm2852928a91.11.2026.09.28.21.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:28:40 -0700 (PDT)
Date: Tue, 29 Sep 2026 13:28:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: zram: block_state returns premature EOF with short read buffers
Message-ID: <ars-NNUnD1dc-CTR@google.com>
References: <CANC3H+LdtoydSp+o2ecErAw7k6R2+gRf9LyxcaoHv_mGhJmyQQ@mail.gmail.com>
 <ars5x7UjjU10KOjE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ars5x7UjjU10KOjE@google.com>

On (26/09/29 13:13), Sergey Senozhatsky wrote:
> > However, reading the same file with a one-byte buffer returns zero
> > bytes:
> > 
> >         # python3 - <<'PY'
> >         import os
> > 
> >         path = "/sys/kernel/debug/zram/zram0/block_state"
> >         fd = os.open(path, os.O_RDONLY)
> > 
> >         try:
> >             for attempt in range(3):
> >                 data = os.read(fd, 1)
> >                 offset = os.lseek(fd, 0, os.SEEK_CUR)
> >                 print(
> >                     f"read {attempt}: bytes={len(data)}, "
> >                     f"data={data!r}, offset={offset}"
> >                 )
> >         finally:
> >             os.close(fd)
> >         PY
> > 
> >         read 0: bytes=0, data=b'', offset=0
> >         read 1: bytes=0, data=b'', offset=0
> >         read 2: bytes=0, data=b'', offset=0
> > 
> > The file contains a valid record, but the short-buffer reads return zero
> > bytes repeatedly and the file position remains unchanged.
> > 
> > This does not appear to be a memory-safety or security issue. The
> > observed impact is that userspace readers using a short buffer receive
> > zero bytes and cannot make progress through this debugfs file.
> > 
> > Could you please confirm whether this short-read behavior is expected
> > for block_state?
> 
> I don't think I tend to see this as a problem.  Why would anyone do
> a 1-byte (or any other tiny buffer) read in a loop?  block_state holds
> a lot of data, just pass a huge buffer maybe?

If we can find a real-world library/tool (rust, go, etc.) that does those
short reads then I guess we might want to fix this.
