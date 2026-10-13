Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F4538D62
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922833; cv=none; b=F3wvA+L2Y+uRJ5echQAE23rlwFHLq3kq9OTTHEfheULG5MHNgRtoHTv/KDR8g2w2NHb8SDbJa9tWIG5XBH+TkzPMinzPhhB6QjFFiVTo+/Jkh2OlHt1cJ++P2hMOPt8TnTz86mm230IovNxuUfQuk0yBQw/4Qr4QY1XTILEGzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922833; c=relaxed/simple;
	bh=52S8eIGd/kdNc5YUeahu1cnDerc/gG8vGqhjAz+A1V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0q4+2DRslegnG3eyCGxTEUOUacNWawoKZQGXeSYXWhXOjP8CjrTHauBT52zqVcneV6AsXIJ0Hp31nuFYGLBXvE/21ig1sTFpYiqaQgX2ywbZ2HTlM7lWDeVHb22gLigSJ1mlkg9ng4+EaFzYDzpSufsQd2FKx9DKZbjF2kCRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT5OjOJz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT5OjOJz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so27445435e9.3
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922829; x=1792527629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=;
        b=UT5OjOJzidLKFj05iK9BuOurmL8Uy7CUWIVuguxc1JgXSg2hNlDZMtKm9doKnw6oO3
         kNbLvL4Qq8q88Gqnb/+spB0G6J6pBDp0TQDv2ePCHeXCo89++B5/nWWFBLB0ROyYsz+n
         SjMCdmZwi6AVTjJGBZr2ovMgkciMxK6/5L8uxL7691rIZ7Ru9pXBx5JDvcA4ZktJKwT1
         0c0wbUI8DbdmOvZfzCL8fQD8zIivnfBNbg9vKCtVljI9d4l2VzIv2SoFefvb99VsUrb/
         5MU+3aW9OrjhgiUZkULiycdJdAsQKRajaCALEXwleSDsZCtNM9+dHOS76uxMzmpad8d/
         725Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922829; x=1792527629;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=;
        b=S+7Y2ycFHuidsQZJ0Qwl+eFuwxxzuYuuo3exFbW3KcpnlK/4W1RA/2QcFDq2JAeUCu
         PO9cyktzkxPqO7fN6FPPtAhtoa0BCPqQHtMQ4Ar4VrXcoCCNO/MePk20tUW1sEp7CqH7
         cgbh/0KCoBH0FZTooyvIaDCnEoaMhOcC67TF1CRAYl5Lc+I71tPoozKfQR3TgR7EtKW5
         JwiRk+p/UL1XJNTR5UOwRW+E7Vy862P6YFnIPedkPtNgOZ7DzPAKdPphmpgewzwl2rzD
         sDqbHi0PswC8w5SnKSs+pKuldj2POL5irb4GLsg9lXwYovqq0zgpUJuwCjyp9T7yTeeI
         YY4g==
X-Gm-Message-State: AFq9FYKG82PuXBvLYI16jq/3Lbi6iPXRtm43vGNvvS9ND1yGR4WoS4eq
	aVQKQFNstxt0+FjqGIvGoJsNt0zx4x75RSlymnaiz3iQa32QlDlmMD07
X-Gm-Gg: AYBFou06tb/YQ9WRe7d6OTMCDtqHh7fMjSuvdoBBlDijgrS/hw2wQe31gaBNhgFKtw+
	auD/GbmBSiXze/NchTvi6/bTEvcnEG7dXKHE5d1QnwXiQh08ol/XfvppAXOBHAmGaBSLeEHkrNS
	3sw1OHRXcscd4lOpfrfXRevEgSJAa3o22ObemvRH1/coEX2mE4HQ+/iB/yXEpp0XpSLBgdR0+3A
	MK79NQ7/do21HjKZdWibUaX6BmVCethHtUfrYKISvintx5PEROmvqYWeG752B+BWIZHXyylm9iZ
	tawKGabNxv6F5GYDL4WrjxXzFzRN/zJNkfdMOOZ3iKuks8cuToXFLmaSwDIVcu55hV3Q8RXe5zY
	Ywiw03d3IbpM9OqjUoZopHHmrJuCRUAJvl2XofWjYfPyWcv02Y2AaGBrhH+XW5W9dzg+3nHJ1z2
	SO/gyA2hI4pcEGd80V7J4BWF66sVMxEL8stU5UpO9xpqhK2u0awFyB2ocjDTdhMPPQ43YQgRZ6c
	GtrrSU8XUimct8RogUomktC+pORUibAqztXDOD8g6ddVqQonvtgMZPw6sGxzvCgJKCgDXEAntC1
	VQMq+JIPgW6YUD+UzVFFQIqQtbsywBn2rHHqFBxUyi2+TEsq
X-Received: by 2002:a05:600c:4594:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a18e4d6ac3mr267044135e9.26.1791922829049;
        Tue, 13 Oct 2026 13:20:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm426025355e9.10.2026.10.13.13.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:20:28 -0700 (PDT)
Message-ID: <32a70bda-de28-416c-84d8-a56c261063dc@gmail.com>
Date: Tue, 13 Oct 2026 21:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261013141046.GA12680@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/26 15:10, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>> I've queued this series up for some testing, in a separate branch. JFYI.
> 
> More testing it obviously good.  I've been waiting for addressing
> of the Sashiko comments on the nvme patches before doing more ACKs,

The nvme array out-of-bounds one is sashiko getting confused, we
check all sg chunks on alignment, and seems like sashiko ignores
it.

> and while I can't really judge the code those in the dma-buf code
> also look somewhat serious.

Should be false positives as well.

   So it would be useful to get them addressed
> and the series reposted.  Same for folding in the PI vs dmabuf fix

I was going to repost, I guess Jens staged it before. I'll send
v10 anyway, should be less confusing this way.

> from Anuj, although making the combination work would of course be
> even better.

-- 
Pavel Begunkov

