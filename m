Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716294;
	b=yBhhG9+rVNE6IyA3r0QumTq+KrNIOsPpY+0ZGiMO2sDJVkHW4Oq8+VZHuZVY9EGJL3GD
	 A2JG4YmRg/MI3MzeyNCn3Cn5ziJhJQUYlSzERxoRa033gZEtWnGHa5F4JlrKd8nOsDj0S
	 QRCl5M7mRMfQNq4eYB/3/GP5v5RVdtyb6XqpGVhznkbsQd15Z82KOpqYpFsx1XDQGNg11
	 8U8Gu1z+KRZiSBdXDHwq6Br2ePRHG0P++onABN1cxMp3jfakgY5Fsq52yvzbL7xtMK+QH
	 WoAeXcjsGU7V+aPeiWoyo5uAW6cHDCdqlVBmS7AAspUAdbIyyj6Uy2ZFA0DMFUkMcFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=EKlM9iD6F1gyXy04opeEG9+C51VAWggNyeLVBX+b5pY=;
	b=b/EKEchI/Wf6RiS8cgUcPmSV76FCaFdH5x7syPTk+XfYVdSAZYYvlRcTmCPErHeLl+wu
	 vJjtvdF4Spjcz0mVzpTRd9wO2ePRLzve/HxUuygABVHlfLouhsgIUwTNik/suMzsVrioe
	 CnJ1+bIOeIgC//CNkaDadn4oUEhP2dFQ5hXJJo3uZcCfTrrVRTBaFbJW8yHtNHXGCyRSL
	 wd8eVnmhN5PBvVuB32vHUp03sc6edlzH1woRCwbtKRbGwBgzm/C5TfxBv/XydNjUVDkoW
	 Es1iavPLialk3Cm6HduxMbXc86SfUoHWEz6Qo4uuMpOo2G8b05UiJomKEPiqqNfIFZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jEkLpkXm;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7E608508E
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF7E608508E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jEkLpkXm
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b1ce85287aso2176360c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716293; x=1794321093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EKlM9iD6F1gyXy04opeEG9+C51VAWggNyeLVBX+b5pY=;
        b=jEkLpkXmCf5QOuqb5v1ryNkU59Z9axc6y+LPgVXqn75nefdxLvnI9LYBuxgEX+k3OK
         jWlTB0CljoZs3Ju/7VGouL6n/qkT/jOywJyk6r/MlSMaVM814/g3O1ET9E9GE8qWAPwV
         gtbkIQmr13hZ3v/R5R4zpEj9VMl+G9u6RLr9Duc3r7A5kWKYhEju/qOAlbj1PmrLUHwq
         fo8eBvCYLJo0RVGlgBqvYWnuigdY5halbWMjPePLQ6X7UBF9W5dZHWyA80Z/vcWXsuh+
         p4FMnYC2Wa2yI1mFI3KFPPoBL0IzJKv9jxBzuYMHSDOY5rtJJZ3ZvkPs0PrssDALyez5
         gPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716293; x=1794321093;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKlM9iD6F1gyXy04opeEG9+C51VAWggNyeLVBX+b5pY=;
        b=xdnCoH9aopyQZPt3K1znoTCAbCSUnq5Kr4PbeEpqAG4bmTwHyCefXKwktbkHIJO63l
         EOXeKNJ79YoLy9Uw90IUfG0QX0Vfn75XXSntnjTezxH5pSEouLMKcEauhnH+0anOFFc+
         SReQUoTvFY83W+sCG1S+tqWh6kLdCzSWJnbpK2GFFL5LYKKfwcIdgVlST5nxhFkDTv6b
         dMdlItGIyImkUeDyoQ+5TTA6ZMkRFEJSGAx4vQv87qWHftrIrPi+wZz3ISy+t4floXRK
         Z7IvOxwvRbFveEVUPC2xxsIowh1TwGREahruiXiN3WBlnXC/nFCXc0n19jD8qyH+SPh+
         9Vjg==
X-Forwarded-Encrypted: i=1; AKwUvBymrWX4eWZzkhr8YqDvFdGZhBQyQZ4eWppM5hLL7F1ADZe3+6Kw0ftr3rWI4ITDjRkYnqudqjp59+XubA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9U8NRcbwV1V5Gcy2ElHFgZr+5OxtsTSMYyfBDropNPedwzJV53
	PMlXGa6frzuL6ORYsvqXIz4/RN7/JOKiYl6SQvGSffmlmffK9Z0vSj5fVa2YXOfbd3I=
X-Gm-Gg: AYBFou3zFNkRMz/WrfXqqcHbhjTUj5y2BPAYhR486tMkLBJunS3YDpAoDPJhO1tSNrb
	/+ThlJw9eU0D+ALRNnsNWuxyox0R4a3ISlV0vFzPhTky689jx2DMq58lCDRZxE4d2r8pLSWh0rZ
	+nGUasCPhgQaa9B+z2DNrbCZzQj/svulnthejj4hlI5dFKHCrLnX47gcOzuxoNJifM5WUEGZ568
	yshVa8Qkyom1lSSAGYE5WqKISOFYPvY3IWNtax0fmlWxs9j5TGh0qq50l+oW/9fVu6CRItv4CDX
	kvFAa94TVPRuB5Dz48NzJDiyhExeKTwtVD21OZXQj5/Zfu7xiD9hHgOf+9D5RLW/H7+9T6bdEtH
	hrMyzS3WKffn8V7htuyh9Z7xq2NnuwLZgVCXD4uncoOKcC2Q8u2DjbsZMHONhD7q+8pn54ljd28
	m85w7IYMM2OLiEqAaJfSqLNdRm9R9RCWwPuOdI73kBFBMj5inm7/lyha/yEhbWCQcJGO0cpE8FU
	L9KNGk+LM+JNoZFLhnNSsIWOmSxzvhnuZo02h7++9UK2yyqQJt0FPyOlug8RrIlRZtIZJ5fs8Gp
	vb9+ePEYUGI1mNpdbh19wCzXUk53fsW7LmM6VMTvAieO+AmsWPoxNWjlSjO16+aXRoeY+gEGvn3
	zT0LT9qr+fgbA
X-Received: by 2002:a05:7022:1706:b0:1ac:7044:2bad with SMTP id a92af1059eb24-1ac70442d69mr16914729c88.36.1793716292497;
        Tue, 03 Nov 2026 06:31:32 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: mst@redhat.com, stefanha@redhat.com, hch@lst.de, 
 Sergii Ushakov <sergiiushakov@google.com>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, pbonzini@redhat.com, Jason Wang <jasowangio@gmail.com>
In-Reply-To: <20260918135120.1261150-1-sergiiushakov@google.com>
References: <20260918135120.1261150-1-sergiiushakov@google.com>
Subject: Re: [PATCH v4] virtio-blk: clamp max_segments to virtqueue ring
 size
Message-Id: <179371629139.3691261.5658135029894981037.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:31 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 18 Sep 2026 15:51:20 +0200, Sergii Ushakov wrote:
> In virtblk_add_req(), each request consumes 2 extra descriptors (out_hdr
> and in_hdr) in addition to the data scatter-gather segments.
> 
> When a hypervisor (e.g. QNX Hypervisor) advertises VIRTIO_BLK_F_SEG_MAX
> with seg_max = 1024 alongside a 1024-entry split ring (vring.num = 1024)
> and VIRTIO_RING_F_INDIRECT_DESC disabled, lim->max_segments is set to
> 1024. When the block layer submits requests with 1023 or 1024 data
> segments, total_sg reaches 1025 or 1026. This exceeds vring.num (1024),
> causing virtqueue_add_split() to return -ENOSPC and permanently wedge
> the blk-mq queue.
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: clamp max_segments to virtqueue ring size
      commit: 603e66e8dd6adf2bad54bb27f4b690eacba3745e

Best regards,
-- 
Jens Axboe



