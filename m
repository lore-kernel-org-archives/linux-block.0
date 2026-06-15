Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F8846A
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510036; cv=pass; b=roIDvf5WpM2r4VSPpLi6Au3WD6YE4Wdp/m8PdsGYITzahSmkOxs9yWb+T93pcig4YgUIdrWUgqZLVrokerxgurWDi6rtz74QVzgCLGkOBlzVYYS/rETGa8/MWLEl1zgdpiNYBr5CCjUIkhPaW8KYkJsSf0xi1ZgHcb/j1JqY8Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510036; c=relaxed/simple;
	bh=iqFN/tpX3q6tjB+xBeLewyCE5xHFkLdK34oVqtX0Nhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAoP6iUqujXvUYODXlcsUxKtnZKW+kAVwlov/RAkl1/y9VvFbf5XLziVrVmN2RvGhQE0hqzDC/WTewkiQ/Fo+Gpu8R1hz9jUVflDTqeO+coU/2e6Gy34WPhOcMsJOsxIiy28b9F9LOd1ggWXrvIbyk2Olku0sFSFdTcMlSEzuPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9YKQTdG; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9YKQTdG"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51761d27612so37821281cf.3
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 00:53:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781510034; cv=none;
        d=google.com; s=arc-20240605;
        b=KdClZ/iwtn83AYthced/+3XfwAmT1vzXorcRqJeVxAS4XXqeKhWP1nIYLQV3JsTA4E
         TH8QYBLCPqj09Ocb8TINm9mMxHt6dY2lHlkV7/E2UdnTVWxI9dxO2FjkGoA5umG58O5S
         JX5LVd1//6vKJ6rQWIT16ReA/TY5ORlVmQchu7cL4rChOxqTqSxMnNF3En6Sl0nVTtn8
         5wn7iNS/ZGy7gm1BFamfPkEBp+axyFvCOIDszLlBSSAjG77Y2TVC2iot/a+EBaYWgKmD
         6KwjBo/mE6U2nkvNb7Jh1st59Oy7oZVUloZbj6/2VLZ5u+H83gQ4vIxUR/X3W0dqswhU
         4L7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iqFN/tpX3q6tjB+xBeLewyCE5xHFkLdK34oVqtX0Nhc=;
        fh=n15BLvJG3TvHdaAETR9v18cjygjzaQHol8xhChsk60Y=;
        b=gLKH94okF5lhVZSDe2wJd6aRdncSgw9OfUBBup7w0FQalZTErs9tSrW3aDvFJExeUX
         wePTjBol98vw0ec3V6807QRdVHqAsKQn/JTDq50QkgCDR3tWk/JGs4IlxIR34SwuGxLl
         PQM//acxkoxDCJqBQT+sVagAYgKbTtuDxSyfuU5ZE5YzSsXvaZneW16cQ4JZdvMWMu7E
         Ri+49nVDZAwAcCqiggMSWcHzKndp4s3EkgoT9cStot0tMxRGp7uENZajevZr16sQkizw
         kbMzeBMhaCjfr6lU12VhDtXPS8MRCneoOcnXTWaRMdlvNl5VIlOXH1hQ+UX779TvzmmS
         UpGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781510034; x=1782114834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqFN/tpX3q6tjB+xBeLewyCE5xHFkLdK34oVqtX0Nhc=;
        b=l9YKQTdG3x1smj6vp/0l5hkxo3XPeQMAdQVGZLvjynH9W6E/U9d7Sau5FTKakNndZw
         odZxtXovROUwNQf3lpl4Av4+XWOVNoTxpWs1BYpQ0jN6LTcIBqyWulzjRUNUrovuVWoa
         rL0blNbJ3yG1iJkN8SUC5v6pujfbCxK21EGqcfQerBfCn9paZo495fWCHtojZMrBTWDB
         3aY1t36Rnb1H+D84pXGJUKfIYY4gN7x3h+yyni4eEuqqXWOhbsPXQ7Sl/YaEdzhtX8Ix
         zFiEDVphVLc10KFCiRKFbki048K14Uaa6o3dCocknAejF+iqOkwGfQGQ50tNAiQktrd/
         8p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781510034; x=1782114834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iqFN/tpX3q6tjB+xBeLewyCE5xHFkLdK34oVqtX0Nhc=;
        b=j5ctqe5XkvSI4zY4/MkiQcLrRRek8us+c7DAoQA0cka1CiKxrv6r3cZJvMydcN6kqo
         8QyDu4BQfzVMJn/aKKQZ+0DiPguPeHuMKhFRqLguaWMlpd+jGX35ngGpKHJ03klrFzQ+
         b3a7LhJMyNqU/FmGfqLSCD3IbP6lnjYG58YKd2TqEgUZWHFHPOEpvGvhx5GoIxNM91wM
         y/Fe2HCqXF8ga2kl8ibziRVi7EhEtvCiu8LrXb6jvcNvcoajCunLvE9OmB7/r/njNo5z
         kPxqAzvuVnRHUw0Lit6NXsmMu4l46DHcFBStb5cIp1f6xyBOa3U121juNNaEc4wSKUaE
         jTkw==
X-Forwarded-Encrypted: i=1; AFNElJ8kvHmZgFAzq+wGU0FfY2ezuru+zMVlOiK5Sj54j29nEdfrQwVXU9Q61kaZpm3vY2HEUp8RTMuHVncVLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLlSxwKhQg4pOFAmId+46adPwKwkSJ4Tsmvxe7R2zyA3Qxr3C
	VBW7JiZLQC2Xig/rB18yV4egLX7n9DYMyuZ9JaXyLsNmk9wO8/GDRRkvuySo5wGhm9bsVDtSz9S
	S8Ahs6taycNz+LoXmToY2WoF8ykyXY/KRVEbEVXfE
X-Gm-Gg: Acq92OHFgHMy4VTdYtIxTngol5TxcKgg+F80bsfPAd74pyj8t9J2WXIGcI33OH+YjnA
	sTONsOIYS0vdal3Zc68kUGAUQLjSgkVGIR45xWIXOQf1cG4IRG0m328MMApkXA2geOzrfuotUa0
	ZkEAYdcJiy6W/IpowUikTkdzmMOOzhaibvxWqEo18IoONp4DMQwCohQ1gtZZZ0g0IX+H801Tnej
	dOrKclhsF1tdsriYbaSRsjxKJWlGzoOSY0LyzpSSIcTAheW1YQL+jQGsCGaCkBQhDQaTyrzETBY
	NXMhI8gj7G7kUIG8HSQyQ9azUDpEzqw+HrapB1tNbcZEuuNJaFViLRW3lU7tjpNLvqmJHrAbqIY
	nqBZO9l6m9ahlLYDKa9C7TOLFq6YJXA==
X-Received: by 2002:a05:622a:4245:b0:519:75f9:e874 with SMTP id
 d75a77b69052e-51976ed6934mr28436331cf.10.1781510034038; Mon, 15 Jun 2026
 00:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613042619.1108126-1-edumazet@google.com> <20260613101214.1771-1-hdanton@sina.com>
In-Reply-To: <20260613101214.1771-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 00:53:42 -0700
X-Gm-Features: AVVi8Cf6uGM8M8DJH4c64JCDlR5PdeR2re5zLcOyooPl5X-inb2su2lIUzphgfc
Message-ID: <CANn89iJq89KWm3eyfKTqjXhdKFy6raRLgfsRX8vXYgBpmBnDiA@mail.gmail.com>
Subject: Re: [PATCH] nbd: Reclassify sockets to avoid lockdep circular dependency
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, nbd@other.debian.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 3:12=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Sat, 13 Jun 2026 04:26:19 +0000 Eric Dumazet wrote:
> > syzbot reported a possible circular locking dependency in udp_sendmsg()
> > where fs_reclaim can be triggered while holding sk_lock, and fs_reclaim
> > can eventually depend on another sk_lock (e.g., if NBD is used for swap
> > or writeback and NBD uses TLS/TCP which acquires sk_lock).
> >
> > Since the UDP socket and the NBD TCP/TLS socket are different, this is =
a
> > false positive. Fix this by reclassifying NBD sockets to a separate loc=
k
> > class when they are added to the NBD device.
> >
> > This is similar to what nvme-tcp and other network block devices do.
> >
> > Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up =
earlier")
>
> Given the Fixes tag, can you specify anything wrong that commit added?

Nothing 'wrong'.

This (good) commit allowed LOCKDEP to throw a warning and eventually
panic the box.

A Fixes: tag does not imply the patch was wrong.
