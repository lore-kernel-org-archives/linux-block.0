Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792652144;
	b=xcB9VlJ5u/ceVNBdeKAM9rZ32PAgcaEc/k0Dm1pnIWAgTqGlD3y0RqLYw4fGA/QrUJx1
	 wZqf5jDun6aJmMpa5hpw9rzhKExJ62ETqclkAOhJXyosBpQmcdlF0U1B5BEg0AAt9PYuc
	 BtUge/V10aeLMPgqlYfmmM7za1OEb16QZHOuGncv7SwYTZeOujYTkS6qh1095vUnDCVEI
	 q7Xs9AgDejJr+sMkexHHx4boMcNdIR7AuFZ0ramHN2TQuDMPynVB0nivz9ppU7d2bN/Ye
	 OeC5mB2D1j9OCbPciR9EHvlBFCy0htkgElrIlAsspymtINyalZgcg8SmFgflttt0EXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+qOAfSouOX0t5YZwWU2eSWaqspMZR2wrvfeU+oUpg14=;
	b=AA7soq5h5J65bAPGqJv1YRdAYYSGzFtmfzTawbrOf1b7Zosu4aXUv/ZitEIxIAndNeAA
	 qT9kk+EP+LEuOgbJ7rjstkv9hLZWiip9UoDQh81cLaH4w+knMrJSILjSwmgZcE7OaQbAi
	 BPlVyP7tI9BvAThLyuxJYp2jzgmsMHpHm4zj+gffkSZ71vSKsVYb3BfxFdwhQmod64d+q
	 ODlBrpv+VwL8AUC/+TFYtLp2UtWn1hKF0VFPjgQEuhZnEzCZD+y1nE893bvmaVPmPQizO
	 UASjzqxnpcPRWXRMy43d88yXpAaW0OvezT/U04s36EJ/eFI/tKvZ0jnpRJfwJ+6n2cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R0Kg3uFH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6118606A31F
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 06:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6118606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R0Kg3uFH
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4d198f1a591so788146b6e.2
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 23:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792652143; cv=none;
        d=google.com; s=arc-20260327;
        b=NGnUdwrzWTLG5xaYWGOo4v447JbVIfrn4iYMxlJyQY0JwdC6kADyrya2U2FCogrIUc
         kNiGFncaRJjTt6QkkhzbrVB70tAlr+okGjTdK8xzjdIY1EKH77O54p77XXQ1sWavYzkL
         6jSfyTE6SDedbZyZuN0LgllZpzR5ivLApTZgTNwRxWvG8hg7WvH0NXoKEN1UiWAa0gEZ
         qyAImEXgVeVWPy8ZNtB3Au1vWXZYvxHjjVM7e0rT35cWi/apKqMlzGI7p54yFz/zqO+9
         mwqH6rA64zqbhEzk5fFCuWsOEflmy1dYGGLrvFPwFqejyRNJuFyRAmwbINeAIswRWrXz
         3ltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+qOAfSouOX0t5YZwWU2eSWaqspMZR2wrvfeU+oUpg14=;
        fh=KIc0SlPJECrqTrcdHnQRuYUhPgCzttE4u2laMH39rBw=;
        b=bSdtsdMqug2dndeSKkH0nevPKGBcRLtaBA5TvAFJaryHKlfppChERal8PVR/PffVwL
         Q+LjR7PkQTuNppkaWVs8lgvP9iEZIPF1sPzKYyhMRpOEVDaQK3OBVMXs9/d9hvcVW70V
         c2rei+DkRA8OmpVcfl8IKxurQd7+u/z/eC1YlwoJnfLasYZf6EIjQ60FrpwckMXV0r3Y
         hXlZPwiaJBJfpIzw2N+PiX3UFDYSyOiVtCYEzZey5RMphl5WnfoxchFSXaPGXlpjLDYL
         oRvclnZRh5e6oW8k6zYIesxhLLLslzfKP6A35/U69TS6PgagjC+F965ZMPxhnJIBjIuZ
         tpfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652143; x=1793256943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+qOAfSouOX0t5YZwWU2eSWaqspMZR2wrvfeU+oUpg14=;
        b=R0Kg3uFHbTkdHKNM5sIOn1KZNzNYzlXfSvO3YRZQOMJ4JZAsfCJJKhA1RUp74ivT0s
         qZUV1TEi3nFuRs00KqWUo36FyoC5C+HwbottBSlUOjXjODGafSkrANkHxuEsG7aS/1uk
         WkIRteItJy2W6dfvysFvVlTBayq8PqtWevnJXgZijReXMHeyUC26T5dzylMSErfKB1LS
         T9ZdteSijLwTqyCDEHA2sCpi3jnyQAtU8XkA65kdYqh3YQ6g2f74m7tVdwwFBZHPYi4c
         Odg8dEG3+ImnFbx0w3TwvL3k/Z9yVYHR43uWEZkzIhZf9yOtq5dWpsbpHFJeNLG1n8fu
         sIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652143; x=1793256943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+qOAfSouOX0t5YZwWU2eSWaqspMZR2wrvfeU+oUpg14=;
        b=vZHicdTutCvxCMRTISYn8ohpnkGeiC25KzE96B1ASnPRdkv7c+x6Ta/6KM1Pvg+U0B
         OOk15TydsC+jSyOkEJXpWPCMNUSVRbvAKWWHePidaXJl3gNctP0DvarvvUsS21cO9Z6i
         6YI/KBD+e1j6MLM+zcRGHx1mxm1oqe/SlW6CxAKGkU0GBZoQvOtUwzZXe1xrnddcVqJv
         NT1d8mPlYFmlSqVspbaAG4H3ZHDZlhqEE8oB8mK5crPXu+gUvS4bOHPM4n3aXMBkZbYi
         wK9omzWljzPt2SRU1qcsjiHiusnfSUcUObvF7EQYKTFqF7pF9TyGn642mdSqBLkklVaq
         p1lw==
X-Forwarded-Encrypted: i=1; AKwUvByN+U/Yo4cglUtujo1/uCehvslnKE7DBk7X7FWpaD5lny6V74H1gridzHjt6mjIr6mBLJ4P5uA94CLI/Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKiEnDwcC7VkOpYgHff5CN73yq98R8c1++GLkI0MBs4FYzV/9dB
	Jq3hTA/RWM0Bg6PsVKEXpEosRa/kde5DwLCjYODp8huTG9HxgrgZ+pdnJciPj6vemMB+X/Y4xbb
	Bx9aXX2qyAkPj+ddHDaPfPgldHKbQJRI=
X-Gm-Gg: AYBFou3BxLJHicKEL1WKtDEYvNPvwSOiflKX9DRZDqA1cA18eyF3NpX3R4QzTP6x2u0
	HmoyP/AEZ0ZHFf9jfsmbWmUGA/fuRaIF+YzZzpm/CZzGec5ljaZVhkWklyaDW0z88LT2ij/PA8v
	aMTTc7clbVrhD16TcjbYfGKROdqlSdaN0/MzXClt5VRrH+J/ST+dYKFpDt73lm9oLVzE/a53Swa
	qrKHX96mlf2hc0fJ0HLw7mdLFvMfcCof7dDrntaDHPyJ+vwdbQbBSD+zbAcKzhjy1AobQ4mwAEU
	o206fQ9cEQZhnaFx2gL7R6dq7sSRbHT3TIrrKrnnqzDaRjtio24xYyEebdSBfns53Rpcb/DYjBZ
	PnaK8Ec8oJYTTgk2D5TlQrG3cYCvI6BbhmQZE4/Vg4uA15IoiLnUFmejViSEDsu/Vq9HKByXE8E
	eAiVH0RU+OebgHSQ==
X-Received: by 2002:a05:6808:d4c:b0:4f5:e13:95e2 with SMTP id
 5614622812f47-5534f511f07mr3092508b6e.9.1792652142362; Wed, 21 Oct 2026
 23:55:42 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261002152821.410591-1-yupeng0921@gmail.com> <CAG3TDc1Ydhjx1GD7-ZCqmzYbZv5+DM0O7wPnzKLWJ1ycK9C2sQ@mail.gmail.com>
 <66f87058e7e811af340d920e654117eb@kernel.org>
In-Reply-To: <66f87058e7e811af340d920e654117eb@kernel.org>
From: peng yu <yupeng0921@gmail.com>
Date: Wed, 21 Oct 2026 23:55:30 -0700
X-Gm-Features: AclHuK8Sypv-7xRYs_lPJ7h3Nm6lMdPqTsjMnjk1hM_VRIlE-PXSuRDM8lifbow
Message-ID: <CAG3TDc1BgQNuCD75NTCcpmP_d4aLummSP6AN6JuxoAgeEBfmFw@mail.gmail.com>
Subject: Re: [PATCH v8] nvmet: add cgroup_id to charge namespace I/O to a cgroup
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:57=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Peng.
>
> On Tue, Oct 20, 2026 at 06:01:12PM -0700, peng yu wrote:
> > Hi Tejun, does this patch look good from the cgroup perspective?
>
> From the cgroup core side, this looks okay to me. However, the current
> implementation will block the shared submitter when throttled, and it
> would probably need more work to behave well.

Currently the io.max won't block the shared submitters but io.cost and
io.latency will. If a nvmet subsystem has two namespaces, one namespace is
blocked by the io.cost or io.latency, the IOs of another namesapce will be
blocked too. I plan to create a v9 patch, if a namespace has a cgroup, it
will submit the IOs via the nvmet_wq, then this namespaces won't impact eac=
h
other. If it is not the correct way, please let me know.


> Thanks.
>
> --
> tejun
