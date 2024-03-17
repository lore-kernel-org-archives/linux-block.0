Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCCC142
	for <linux-block@vger.kernel.org>; Sun, 17 Mar 2024 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710659406; cv=none; b=PGWqi4jMDbDWD0gacaPMSKMe4Ubwq6Vl7e53NgOmTSHsZ6GePIPnjPsFNN4QmAYAsV77LdFEyBy6EOAHY7sonxdOnDJSgwIXHWXz4h3gVRKvPltBTe+Rjawc0Ek3j7TK93bsowLs9fsHYtpYKN8t1gQ4fHifpGrWRkgpwk38ryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710659406; c=relaxed/simple;
	bh=dAQ9Ys7rOJEtw8RI9uIex68C6AmMXZZy9eJKYxACNKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JSxWfxi13M2rF2SSdlhJr/fowJ7VNr/uD8OaCHA/mD96uYD0/AXFYTOfkD9vDQGxCf3sk6Si2X4kofgSZVWEqlXL1VZrnMoB+U7Wp1+C3U9zXbBSM0zKcTz3iKKgFJ8zWkv+NFDVRY4lq64nmIf7Myicx4Or+p+/ZEfBRa/geH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=xqeF3ZSr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="xqeF3ZSr"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so7593830a12.1
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2024 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710659402; x=1711264202; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LkTu2DdOoIjtFjz1QLN2HyrHjy50grh8crsRFwnCysE=;
        b=xqeF3ZSrljSoXSzUvpZcAvgzAhmWJnZQjOL9oI+kRbLtHUtJMiEglIk7Bl5KYJbuvb
         F29AR1swJD/1p1cpRTniO8wh4/6kP1Ge9P9OLJvJ/nI9O9Hes+F5294Qv4gyOtIyLT00
         7eI6OGwa2jgDSPbq9go4DeL97Y5lKl7ceoHa7mVmRanZa5yiufzZhbe3yt6E2DL02VCv
         RQkneAb79c5RjrNQGe0Hxhl3AjN9/0nq0drtGwRAt0ejQqUJBew2H88fA6OUgD+zBeGB
         TnbGTw08hSfT/qP6pPZbMSdosN8DqUK/JdG7VnqrljE/7WZkGoI5o7qwNlCX2NIlvmGZ
         Lv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710659402; x=1711264202;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkTu2DdOoIjtFjz1QLN2HyrHjy50grh8crsRFwnCysE=;
        b=lQIxNfzri3X5RK44Pr84hIkGWQj5yTnFdTSIFpZYy3vWGCdGVZHIj+Oygx2tbKr2+i
         ZduZRC89am86xyHm0KaIuGGuA5lr9CZ1MRgNTPebTIaA1CPnR6iNN4m1ikQqAnFHhDWd
         N4XNj4NHWYh79ra9Mw/37WGbSBsrPZgCcXGstaqhVwwmRIhh8mghkGrmu0HU3i++4RFW
         fGZc+HUk1kBIU66Q8exgWBS6jnbzQL3MTyav/+ayGlMnWuriDSTGhZl+vrkCbwWn9Ffd
         4tEk951k93Y3LHBbi1yw1wne7Ga3I4p42sLB57/ZIBiqS5Tp+QJY1oKGfqy1P20rwIxH
         WHtA==
X-Forwarded-Encrypted: i=1; AJvYcCW09btwL7KP/nQeti8F9Mc298svgqCxqN9KGyoiAD8oapnJGoy+nURMDmjYNtRDLkfJeN3zDVKLOPOQW9F3armw/RDXUqGzixUO62w=
X-Gm-Message-State: AOJu0YxWlBp1iw8iFNbsdUexr0BewzwJJ5gakBIA41wrAYnkXvngsTXo
	cH4GgI2854PwPWdKNE6mT8YXWa1XSCHs1LAZP4pnKF397Tvc1T30kL1F5A3ipuE=
X-Google-Smtp-Source: AGHT+IF+FesYNXd78NW1aWUCW24eNFXC/7tgT88xR5E77bbR/6D1v1T9UYJRmLhwB5oKfZvCCmzwbg==
X-Received: by 2002:a17:906:6a03:b0:a46:75d3:dd46 with SMTP id qw3-20020a1709066a0300b00a4675d3dd46mr8184725ejc.17.1710659401525;
        Sun, 17 Mar 2024 00:10:01 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709064a1700b00a462e5d8d4asm3462772eju.114.2024.03.17.00.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 00:10:01 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block driver
In-Reply-To: <ZfZajb_vcRwLacfH@casper.infradead.org> (Matthew Wilcox's message
	of "Sun, 17 Mar 2024 02:50:53 +0000")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<ZfZajb_vcRwLacfH@casper.infradead.org>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Sun, 17 Mar 2024 08:09:53 +0100
Message-ID: <874jd5qqpq.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Mar 13, 2024 at 12:05:07PM +0100, Andreas Hindborg wrote:
>>  - Adopted the folio abstraction where applicable
>
> I don't think this was the correct move.  The memory you're managing
> with folios is only used for storing the data being stored in the blkdev.
> It's not mapped to userspace, it doesn't make use of the flags (locked,
> uptodate, writeback, etc), it doesn't need an LRU list, a mapping,
> an index, a refcount or memcg.
>
> I think you should use pages instead of folios to keep a handle on
> this memory.  Apologies for the confusion; we're in the middle of a
> years-long transition from the overly complex and overused struct page
> to splitting it into different data types for different purposes.

Ok, thanks. I'll swap it back.

I was under the impression that using folios also give the advantage
that handles are always head pages. No need to worry about head/tail
pages. If the driver moves to use higher order pages for larger block
sizes, would it then make sense with folios, or are page still
preferred?

> More detail on this here, if you're interested:
> https://kernelnewbies.org/MatthewWilcox/Memdescs

Thanks, that is useful.

Best regards,
Andreas
