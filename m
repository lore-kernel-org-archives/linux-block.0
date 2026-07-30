Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E03CB2DA
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440955; cv=pass; b=E4atd7t4IOguIlt+S6HqXG0WJ02YskF+y8IoASGX344xEssB37XsJuqDKd6meP/vPVRciA3TDnh2gwVSCQgA1spNDuKWzMXDZ9UJIPdREV3Zh2sOLmEeQjkv9QPqGAnfMEeH96exembnlvW2kL7Z9MgF5cCiheebO6PMk4owrJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440955; c=relaxed/simple;
	bh=IfLhSjG7Oi8HUcJ/zf4Zyf4nbV97n6T2JwE1KzDUjds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQ8ba+bzuHITk3MZLGJ4e0Nh6pESH8eilQEY/cp0EX3jI+p0/VySCwOGkH2YVqo2qvo6WOQzKu7i/lpJRUDIERSUOTf2PBDtwG9R+DzkChVP89B3TOkRwVwyjNWrZhlmBJkig+PCUIZfa/4ec2W36QiPEiUyBms7iBi6hYGhBjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6/FW92t; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6/FW92t"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so376935a12.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 12:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785440942; cv=none;
        d=google.com; s=arc-20260327;
        b=UPvP8DhXuu8QNkhuG6Y0QEZMQ7kFz2wng7IIIpf61/f5lJdUXv8Po/u8XlLFM6ej6d
         54fP1LFXWxWOmHrLLGd786/2I5+NT0EkOfEhn+gGWqSZdhUmnHT2ehpCnEYrdu1QWC1Z
         aaTOkKANvOg/euFwqgTYVvq6+m2XBcbSgQVdKdXFcrHwNOqW4TRFvU0UG9mSLZX99odW
         g2JCzeyjKPcbwYuMPQ3GPQQPHxCVU2YqjlRX7jHOAJsDFGK0ukxLoigzbHIbjc4yrujg
         4v3l1z4DlTBd/1X67VDrwwNMWHXbXOozgOR0mK/X1wRhSy5Q/LU1dQbFmgqpKqVgWVl2
         gqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ixWJgT8hMudFvQmf9xO+ue0lQJczsuaDtkS4pNl60os=;
        fh=hZi5nGioBIh/+z1cKl4DXenxH0QrDyY4eN8HgdE1QKs=;
        b=lwRmgmi37YvBzCH63qWCQ+HLfSNv2YYsbbKOurTrNHvR/wlogv/upfYWaD3QFRcyk4
         4APkpTTXvJYZ7gPVZx8RE4YWVPyHS/ZrPDMP9txiPR5xpqzbB3dTF1YRY44t1aASXjXQ
         HpIJ5xnRCucb8ajfwkac64qDVacUihozQaoOE+JDouHpmJFLG4CmXQdnyC2imrMGt2Ru
         LjW3Z6QRABE79+/LIn8zW9j9BEIagWPKr7YBPQSand2ujYKzg6DVweBVk96BvN85lqCl
         p0qiZB1oK8PDAppDC7GMbQh19XnngCO6ICRNVdnbaKwjXgbDxhVS8omeJK3fCT/DHjRI
         /ncg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785440942; x=1786045742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ixWJgT8hMudFvQmf9xO+ue0lQJczsuaDtkS4pNl60os=;
        b=D6/FW92t/v/fGIdVMTFPPrQIuiURO5xI11XfmG7Vip7H0CUD0U/rpUIi8gcn48/mYS
         wgrpzlb/kn+49Wobk9uAyZSFCPrto02c0QfSYvH71lpFS/bHLZWXs7wYuqhvxFBNqjzl
         NmGv79FWbp88jn5SLxtjqzh9+ibipjPrp/NUW/iG+cvjKcnjQ2TDH77FfAYBqd344K9w
         wNrsOel6KoF04sDwIlUJQvgoSrcrWxeBaBlNZk+zVVRpruFZ35ReT+gqYLl1bEKrw2PL
         LfJ6ZFOdZCgGeqD+elv0jvbWQvv/eD4ar2M5bWsCoxbRE6dgpDzr1WJzjde640mfG/q+
         eQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440942; x=1786045742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixWJgT8hMudFvQmf9xO+ue0lQJczsuaDtkS4pNl60os=;
        b=fVa4KJ6OyhANfgzE3pjVBWzHU/1EmN6h84MzQAKTzSPn2UEAhLto3wfk8Q3bYWSSLM
         1oz3h7D+mu+GgQYUu7BvxJc2YvQcLhJR6oG66TsTummPseHcVStzgxkP2sQqjQXP8Ot7
         mYgQpKQCy7mrNkBmtMgGK6wGgVJjGfbnzbgul2dm82x2w/qIcsOvrJH4HcIuLQ/Jh9at
         irZHeNth5AhjIRnMZUjTeagfuv/5M/rH+T4zCkMAEw6Um+yBegLQEMNoaniDsQ8GVUz5
         q6U9fz9sFTz3Fs0IuEklg4+OnB9eg9U6/jL+IMVr66EqR3c6w3jk/IIUGKlv2qaG5kIX
         Mc9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrN4axWF/l068xeJDf2xxxjrcfKMfIrtRqLNUEcd5cKoTNitiCBJ14buEqc2Auwri36MPbU1pwSiVJ8vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWV2a/tirB++6iK35zprUpLGH1PvMGHSfF/DJ8AyltSPLaOAuC
	sEZaKMflDPp/Wm3ponR1YS43jn0LwEZSwNuAsSik70OKtNYLqNRV5AKJguD4EfKb1x95MHHiF28
	EFOm7k/XNwuYBrJNp9RaP2/N3y9iTkYc=
X-Gm-Gg: AR+sD13Qcscpmh0JBwLQVVp4et4XaXKoRiSZHjNww/VaS5t171W+Z/iuH/i60hdLOo/
	orQvI6ScpL2cl2TLmp96ToC6aerSgtLPbL6eLuPOkWZdtlgIiFjbOpXIKeRCXlEQHl3soG32dTg
	9osXvkQZisyk4hnJOJZMErSXpNTVHDVx6NnkTd1FcZXhssSy44IbxhmlcUvPV8FxJhU1Sh/PSRc
	2FUo81nRmj5Iw8YUrxYmCzt1L0jKA0Tv5opySUtljjlhr2/z3cp4bLrYYEqQ2GoMegfkYQD+s09
	3k6axaGqg+JN2BZNt0JGXgX4HSlKT/P8thphX2UE7K4U
X-Received: by 2002:a05:6402:3784:b0:69f:e3cd:5ae0 with SMTP id
 4fb4d7f45d1cf-6a07b7e2a4amr2228183a12.18.1785440942100; Thu, 30 Jul 2026
 12:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727201257.211635-1-coshi036@gmail.com> <178532422849.2568853.3142469605707392497.b4-ty@b4>
In-Reply-To: <178532422849.2568853.3142469605707392497.b4-ty@b4>
From: Chris S <coshi036@gmail.com>
Date: Thu, 30 Jul 2026 15:48:50 -0400
X-Gm-Features: AUfX_mzw_brm-7pVnzrWVTk1rf99jQRwch2Ue0uN3fj_yO5c3bAG7uT9FU3XI0Q
Message-ID: <CACd_6n372enkmZuXJnxXaDe-PA8o-t3Nmj86s_zCgGkdYTcanw@mail.gmail.com>
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the mistake, I think I replied to the wrong emails.

Best,
Chao

On Wed, Jul 29, 2026 at 7:23=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Mon, 27 Jul 2026 16:12:57 -0400, Chao Shi wrote:
> > disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
> > probe failed before add_disk(), but it only calls blk_mq_exit_queue().
> > Nothing there stops q->timeout, and that timer rolls forward: it stays
> > pending until it next expires, not until the last request completes.
> > So if the driver issued any I/O before adding the disk, the
> > request_queue is freed while still linked into a timer wheel bucket.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] block: stop the timeout timer when releasing a never added disk
>       commit: 26cb8ebbfaf713c82e142d08828d4d765057633b
>
> Best regards,
> --
> Jens Axboe
>
>
>
