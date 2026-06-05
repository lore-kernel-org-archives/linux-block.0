Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88E4C954D
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657395; cv=pass; b=k+4szVnW8YBL7MQ+YiBvT+FJtSE59/MybpbxFFyPB2WSi+wIkAonlv1fThteJBZpPA3lt4TzcCf8+BNqky9o/jGyISU+BMYwdOZWbfozcVW40HDalhCTipazu0g1jJCd5cvByPfsiOQpxrXxmgc+UXxZzzc5/6fJHvsyIHfqGtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657395; c=relaxed/simple;
	bh=f1MUM6D03lZH8m9sJMdZV49CHTFZPYYABFO8u2/04d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTT8s/ggidr2lRm4xtZxNcytlC0ydPXnE/QEfwr0Y1PfhtyjOn/JmAHYzSSJxyJAjfDOq+Fogj+979gveghb9zcC8Qe3hR7Y2KTfnaZu72okWcAzHTM8oqeTA4r2RIvW1XwVkrxiScaYGKGzQInDo9lyiuntydBpDhbpR2du628=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdT7gPSd; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdT7gPSd"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304da3b4508so172290eec.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jun 2026 04:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780657393; cv=none;
        d=google.com; s=arc-20240605;
        b=Ly2q9WLUCH/b8idCtPZ7PiIoESiGfkD3NORLMIgvklXDuZBaj4VqgqjmCthrljUROF
         eaDRon3ZUflmokL0HUoSq2Lru0+c8a/XmurYOXnaIfggisGuF2sAn1gxdqXkyY+22+sV
         wband2Sf+zf2ZeNOShr8TKjhmczyJJHjM6MtxYGbdFSEHDKnte0vNl3camf0amcxtpmq
         HrtRnXACjrBiS3BgRE/3G3tEIo5Suhjz1M7m24afyoAjQaCIpx0NAV+cnsynd2APM0Il
         hP2NmJlYBEOHUwBvb073mDEW0qTN3GfgrfI8MkXN1+hLIliIJQGtWWmjD1RD4lPq2jc7
         TQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f1MUM6D03lZH8m9sJMdZV49CHTFZPYYABFO8u2/04d0=;
        fh=cefFYAILPYXTC6MYjlZC//5grmUvz7UFO8AIvKFEFhM=;
        b=NpJ2T37UgWmP6lTzTSZ9S3UjEW1/g7tT3wcOkS6i6Y2zZdMnr39Nze/1txMgWLc8NC
         k9Z4VpMc7K+cbwAsVK6DRihtlnRj3jyDpxEyquArp3sgeT77QWkucQF/gRnqzTO9AWnS
         JduM6NI91YijM1AMCBwmrGJCcRaE7Puyr/Z78pU9I7ash3zGMsFfaCCY3J+WH8pL9ort
         HZRAed7sPRMd9QagaOTfjLwvydhc5c7D8FPK8ZIbNg0jlbQxJr1B9w9MIeSWCxJI1Uiy
         hvD1oW4gtd/iPnI5WKJhfEsyAfLR/1an7MG2PnUdyxFD1Qv9GDY/jwb/AKmJXVJUQOCE
         U2TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780657393; x=1781262193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1MUM6D03lZH8m9sJMdZV49CHTFZPYYABFO8u2/04d0=;
        b=JdT7gPSdXdxzb8+YuwFowHuC/lI1Sm3/kGh9Xj8BdBRBWSJHgplpb1IlCqMeHXbMx3
         8hf9C29D6on+4K98IIe9PUfMYYY5lJ+fO98lUNVu0YcDsBICMvhken6eSgFpqzIjvjzx
         Geud/Fu9jWWrpoCtWYAtRC9NrQJUtuMAxB1Ientqi+acYVHnPK9DDcuX0hi1Q8zsUtlh
         H2coFNgFwhM7EPiyO3IDpKYX4wJM8UMzeYT0fSkMcuf8y+T57Yv30olxxiuIsGB178b1
         iP8WxWhGyGYgTq/kKaB74/rFlY1Bx2LlEyOeDus+dnNcduTpfS7tjamnqiViGrZFcCMw
         xYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780657393; x=1781262193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1MUM6D03lZH8m9sJMdZV49CHTFZPYYABFO8u2/04d0=;
        b=AWj8sx+W8ILRo0NYjlITewhQVyVCgrnC6/rQgYh5H/ClGbXIwh3pl+C58jEPpWBQrx
         dOuJrRgM/SMnL8BFCz+Rh2qlxadeomnARvfRF2zAJpQYDyWnpzSgdxZ/Ffz4xG/ZEpMM
         okFlbe5gNLuz+rVeG33/iLhDgdmW94zPJiVCCI/W2LvPw/Ic+f4GqoWforfcfkw5B+8Z
         KhXHxfws060RgT5GutbqRtlRrofZ1s0YU3VPMgAFbDnRIreW5C/JGfVxK3qJuMS5hmfL
         uvB3x9q2CEefZUo63oz20tL7As/FFbuzjetWaMlU4KDUtrqIKm/NRQ2AQkMHjnHtHCzv
         CeiQ==
X-Forwarded-Encrypted: i=1; AFNElJ8sisJ0QHWxAqtlRoQf6kwn0DEIPVFA8nf2GsGMUBgKEOgbHm3qr7EJbqEM7j+md/8rXYolo30hBVUkAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmIrBNC7GLzz78q5RW+QOUd9RtJ6c8q7Wx6+rb5yiIkCjnk+H
	9XrF38I+8a6HR8GXP2I6hFi4AzrKkUufF03p1ilH60NgBn0xvXGUOYmwDGZi3zYbhmj/XT+ew4/
	ZOvDAU9KviTR9OzAdQ6pNm8G7HwzErQQ=
X-Gm-Gg: Acq92OG+o9rMCtVjRul1zYg+8nQKChknPgs4+M04guyXUn5i2uSAkuoWQkZvtsKw645
	NvuV5VFs4XbqvjLl6FQWdIjKgrwuefQ4HUYBeruS+D7g0bj3vzD/a2XIOyZtkBSWOsEYThE86YW
	DWvYauTNsPsJq3bDKOrVJnnL7L/+YoEPKTThoiyfDYcNf0AbtbH29cqUY35Bor1k+0t3KM3pY8Y
	1xoF/5JqeEdZ+332SJtLbF5m76k6X/mYxgNDQoNCgXQwCe0Gl5IdDpyT6ZTD7KcrezWlLbWZAf4
	Cj7YBokYJEeQZ8jAmLHR+JF43k+EzOYfWiegTSBM8Xorw6kamZ7TuAcVEz4Vlc5DXrVl68ECjkW
	JBx5IdGXrOAXETAsOMhbzN/RJiP/HMk9Hzg==
X-Received: by 2002:a05:7300:bc0c:b0:304:8860:74dd with SMTP id
 5a478bee46e88-3077b57ff09mr582723eec.8.1780657393363; Fri, 05 Jun 2026
 04:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <20260604210704.41751-1-ojeda@kernel.org> <89f0f308-2ee7-4c68-b811-8132e5d88530@I-love.SAKURA.ne.jp>
In-Reply-To: <89f0f308-2ee7-4c68-b811-8132e5d88530@I-love.SAKURA.ne.jp>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jun 2026 13:02:59 +0200
X-Gm-Features: AVVi8CdqkuEhPtbDH0s4twQIZkrvVriRAJrVBmrFnoy9Lj0_mQmQbpOfQv8yYl4
Message-ID: <CANiq72nGo=F5D7b7Hx8A1jfAJw_72Np+UpRWBRQoPLAE+RAPpA@mail.gmail.com>
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to disk->open_mutex
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Miguel Ojeda <ojeda@kernel.org>, akpm@linux-foundation.org, axboe@kernel.dk, 
	bvanassche@acm.org, dlemoal@kernel.org, hch@lst.de, hdanton@sina.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tom.leiming@gmail.com, wqu@suse.com, Andreas Hindborg <a.hindborg@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, rust-for-linux@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:15=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Oops, it seems that I overlooked the rust-for-linux@vger.kernel.org line.

I am not sure what you mean -- it is not just the mailing list, the
maintainers and the reviewers of both entries were not Cc'd either.

So like 9 Ccs are missing...

> I am using my tree for allowing syzbot to test debug/experimental patches=
 in linux-next tree

linux-next is only meant for patches that are already reviewed, tested
and destined for the merge window.

It is not meant for experimental patches, and adding those, especially
this late in the kernel cycle, can break other people's CIs and
systems at the worst possible time. If every maintainers put random
patches in linux-next, then it would be unusable...

(There are exceptions, of course, but only if people is aware and in
agreement...)

> Do you see any technical problems except comment style problem?

The above errors are already a technical problem -- they break the
Clippy and docs build!

I assume Andreas or Boqun will eventually take a look at the patch now
that they know about its existence (is there a particular reason to
rush?).

> Nothing bad is going on. The final patch will be sent to linux-next tree =
via
> appropriate tree after getting acks from maintainers, and the current pat=
ch
> in my tree will be dropped when maintainers accepted the final patch.

No, please drop it now -- the patch shouldn't have been applied to
linux-next yet, since the maintainers didn't ack it (they just
realized it exists...), it is not reviewed (apart from Sashiko), it is
not tested enough (given the errors above) and not destined for the
next merge window (for all the reasons before).

Thanks!

Cheers,
Miguel
