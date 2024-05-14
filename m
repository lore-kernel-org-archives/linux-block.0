Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702818131E
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716833; cv=none; b=TMEGdlpQKgbK+ty3J9ckjBmO2CQTLzPG4B6k5hvzlb93sD0cYsfptqGZa9idkjoxlZe32eEeO0OQmopwHCKLhSE5jGLLQaIzGE3zP9424ap3N1fLJRvEQOHnJPQzDzFe+6KOYY6tAgfLuvEF9DOdG2JmGIKe/2QBqWI6FoljAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716833; c=relaxed/simple;
	bh=F1BCusWVnox0inKiwWulDDxeUYd5ETJQa5nYC/mUo7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YL5Mj5lMOVNpsUgaaOAFpsQTHfnZ2LEp2ywgBUfqefy5/KVx3gfudpwnb47JdvIJnmbJI2J1pfS+4RGtnY0/CepWH7Q2CBqL3MZ18cxKa8OjNnvVvMFcWfOeAp224kmRebe8yY234ki1NKT8RGI4GOf38n3lTmZaCVkz26ftf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uZQHp6bg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uZQHp6bg"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b8efd5ee5dso703235a91.3
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715716830; x=1716321630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ll8ePMooaLJ++vSB+9syazdtLkK7b8/0TCj36hEfQbQ=;
        b=uZQHp6bgXhVNv4WSPqVQvAiYLV3mF+NBc0Eiac6OZ/inaPjDmRqjOVmAbgvGCcbWSP
         wTuX6JI/oeiW4Cgx5TrwyzkEEJwM962DpZ6X0Cwvxr0gzzTtPJeBStI754dEytgUv3BC
         H5mvPBBnrmdkXJkr0XDJAyB23Xe1bAl1Ki6nc2kIziDDpmjsD2xvKnU9xYKD6XgjuHg9
         WgKIkzJlskrafMzooda8nvLhVk3zOlFZinKclt/cjSO8fjjrVlIDtI+rpi5BkvInw/hw
         I0KM7xMLpzbgS+ddFCk8X0zxdrlMD8S4jes6PhYm1lCIUueR2dK++Uncmmj3REjvKKPU
         Vgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716830; x=1716321630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ll8ePMooaLJ++vSB+9syazdtLkK7b8/0TCj36hEfQbQ=;
        b=Sm61T5MrUio/G31rbfu/edrW7mESQ+i4UiCC/acmwi26W2lHtfSQaww2LAgWm32/l8
         KfQ2KSMsBt1ZEF5UAIOokeYsMbCXpP3nUpcxYf9bhXbZ89D7afBWh8Y1yC/zfyTaGbZo
         nv5vEqlnE8QbeSSojZrh93N9RNHXad6KmJvFPSeQNbqzcyLwAbfy0MIbUTKqzMgSHX04
         WBa2CV143z0tI7uMt6EBj00u+Nt97si8L/SgqxrJdPV2lK5y1q7h4t/dSP7zY7tpNfM4
         reeDYk/QeopQp741Fm03vTRgh2vmKwlKCZ3dBg6dScppwDUD4t2j1ssoBJbeDR3u6AMC
         otvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjeOYNgyjIShC+vE5fToU2ByDtap0LjH6HBfuVJH0ZBMRF+rbmXFWeGUh35V4Q55OZHXcgDnwtFmAXFhhAaAaxT87d/DAVW3fz2TA=
X-Gm-Message-State: AOJu0YwZpXDUCD1ICRvhuCG10L+uvuB0BkStW8/bWx3BUA3usrFuqISL
	A5W1bfxz5lNcwwf59qzi11mo2lbdB/L4JKY/O6J8iG2ftzl82g7C0dpk/u3NPcA=
X-Google-Smtp-Source: AGHT+IFnBHUUmMWtiYG9e/YiHxcQJT/qNVtzttvhR+ZqrEmfm+gaRsCol3BlyeJlD0TCv2qEnJ75gA==
X-Received: by 2002:a05:6a00:8986:b0:6ec:ee44:17bb with SMTP id d2e1a72fcca58-6f4e0343824mr14250305b3a.2.1715716829950;
        Tue, 14 May 2024 13:00:29 -0700 (PDT)
Received: from [172.21.2.105] ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a819e7sm9572850b3a.56.2024.05.14.13.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 13:00:29 -0700 (PDT)
Message-ID: <593a98c9-baaa-496b-a9a7-c886463722e1@kernel.dk>
Date: Tue, 14 May 2024 14:00:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Rust block device driver API and null block driver
To: Andreas Hindborg <nmi@metaspace.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
 Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>,
 =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 Joel Granados <j.granados@samsung.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>,
 open list <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
References: <20240512183950.1982353-1-nmi@metaspace.dk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240512183950.1982353-1-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/24 12:39 PM, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Hi All!
> 
> I am happy to finally send the first _non_ RFC patches for the Rust
> block device API.
> 
> This series provides an initial Rust block layer device driver API,
> and a very minimal null block driver to exercise the API. The driver
> has only one mode of operation and cannot be configured.
> 
> These patches are an updated and trimmed down version of the v2 RFC
> [1]. One of the requests for the v2 RFC was to split the abstractions
> into smaller pieces that are easier to review. This is the first part
> of the split patches.
> 
> A notable change in this patch set is that they no longer use the
> `ref` field of the C `struct request` to manage lifetime of the
> request structure.
> 
> The removed features will be sent later, as their dependencies land
> upstream.
> 
> As mentioned before, I will gladly maintain this code if required.

With the following stipulations (and the kernel test bot issues sorted),
I think we should give this a go. We already covered this today at
LSFMM, but for the sake of others, here's how I see the rust support for
the block side of things:

I see rust support for the block layer as a two stage kind of thing.
Stage 1 would be including this patchset. In stage 1, all fallout from
block layer changes fall upon Andreas and group to fix. Under no
circumstance will changes from other contributors be held up, or
contributors be held accountable, for breakages of the block rust code.
Should contributors wish to sort out these issues themselves, then they
are of course free to do so, but it won't be something that gatekeeps
other changes.

This leaves existing contributors free to go about their usual business.
Kernels that don't enable rust (which won't happen unless you're setup
for it anyway) won't even see build breakages. We will see some noise
from the kernel test bot on the list, which does worry me a little bit.
Not because it'll mark the rust side as being broken, but because it'll
cause more noise which may make us miss breakages that are ultimately
more important. I don't think this is a big risk, just highlighting that
it is indeed a risk and will cause some potential annoyances.

In stage 1, block rust is just there to enable people to experiment and
play with it, and continue to develop it. Right now Andreas has a very
(VERY) basic null_blk driver, I think we should move towards a fully
fledged implementation of that so we at least have _something_ to test.
We really need to full API to be used and exposed, this is generic
kernel requirement - we just don't merge code that has no users, ever.
Since a more complete rust null blk driver does exist out of tree,
perhaps we can get something more complete for v2 of this patchset? I
would highly recommend that.

We may never exit stage 1, and I think during this particular stage, if
things don't work out for whatever reason, the code can be removed
again. As we have no critical drivers being rust exclusive at that
point, it won't cause any issues yanking the code again. Moving into a
stage 2 for block rust would mean that the rest of the kernel has fully
adopted rust anyway, and being able (and willing) to write rust is just
another part of the developer arsenal.

I'd love to see the rust code moved to eg block/rust/, as I would
greatly prefer to have it closer to the actual block code rather than
sitting off in rust/kernel/block instead. I see this as a similar
problem to having documentation away fro the actual code, it inevitably
causes a drift between them. I understand from Andreas that this is
actually something that is being worked on, and we can probably expect
to see that in a cycle or two.

tldr - as long as this doesn't encumer existing contributors, then I see
absolutely no reason not to enable a rust playground for block drivers.

-- 
Jens Axboe

