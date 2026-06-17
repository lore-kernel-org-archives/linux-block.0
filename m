Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B1480349
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711881; cv=pass; b=stAO33kc+A5tzFs9bQ89KgYeMBIs3FijuxEH6Ahd3pASmZpV+IvkBtNrBYEJ3mGn0lMhgeb8BOgo551x6J844BWBWe/tW/6lLTHhvVZkRkOwqWLqppcHORCnHOErLidfDaBbqzU2dkpUyWvvHf9t1uZWx3MYOvFNTM9x+4hm1Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711881; c=relaxed/simple;
	bh=QiwAds49DU+4LXgwUcphlL5t22z30gUm3S1fIhW0r8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoqHWSXg2RQMZpgYmKzg+Rkr9c9PMSOw6Ghx9QBq6KiU2S9zQsXPPb7gRmp8nvP8DQ/5NreYVEVS/SWGG3cZS7gzrXA+l0sYZojMsucBQSTBmL8mwvM9e9nNwFSIvQr6L/o0lhXoi/fQoLCQGdxy/KxFgzrzCJa6bTDJHXjQ44I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBvc6sj5; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBvc6sj5"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6957b74472dso1549600a12.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 08:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781711868; cv=none;
        d=google.com; s=arc-20240605;
        b=hZT8it/O+7iOaGEKvayvnprul7CwV4YT6oNCWbet/TxDi+hNSPj5n0Zf0OE4DfGocy
         8CxGis6kF7bF1KZO1mcTG4g1gAxtQmdASMgfwv8v15pp+jBs3TTJBaiSqCMVtNzJiK2u
         fNROxkl8gJGbwwfbAjoD9zg1Q+JbJ/qK5Jjh/7HwZOhIsmHLaKouywD2RMFNY/wBZtG9
         F2r6TtQrsgPn9vVU7lzzddSLFhqYdc/CYLjRPi3ZeL3O1XxBZV44h468nWACA6tLrTQI
         LhJuHcGdhRwkqbuGoCG2SHcPO+9ATthOeIZoiLKl92qcRAzTCJi+06HjQvvcaHzbxm0s
         /zSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QiwAds49DU+4LXgwUcphlL5t22z30gUm3S1fIhW0r8c=;
        fh=rwdENOBoM+IraeH3xq7+WhUQU1YlQRIjcOhRQRkM0qM=;
        b=Qk6w7r4JA7buX5QHzLKBMKN7wOMeoQJ/lZv1AzZTbYjNLG4i6vhEAYWKgJ7SaK4Ld9
         wJuSie0Vvb4/Nk3UgGkvgg4tKJ+DJnnCT5/lnMVfAZ6QyPLSn5zHmgVQ62KMpwewaK1a
         4zHN/9H1DlWZctUDLFrbdz3ZW/y3Np6CXqGsk9Mt1pigUD1gMnIroLREBpK0V1IbSZvK
         3KXG+oP8hkGzXGIK0/vcsgntIkN52Mg7ke+xv9hzIAMGBNai+GrwqKNFTpcGmfiizPdT
         dWGdT9FbM0nF+aTAPOyQcDvIck0CMylscAr0rq3JgTzHs2FXdP67v38U/aCnsEJOtUws
         KAKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781711868; x=1782316668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QiwAds49DU+4LXgwUcphlL5t22z30gUm3S1fIhW0r8c=;
        b=VBvc6sj5TscWCSJMmREosisy4oj1Cfj2+Ev3pUFMw+p4Ejr+fmVxFjJqSYweqIM5/q
         zG+d4cJUTnevK1o0TX+Kif9E6sl+16B4qQKPWPgHhfJ6yomHpdimu4fJMReBJPiEi78g
         qk/gHwjohp+F3i4FlMw5ng4kiXya/nM88dflx4436PsyTa5JMWrUo0u1H/IPaKCqfqau
         i1Gj3W4gGlX+uD9HkEtKiC9J7zjdDionNNB2+WdAiBoOLSB3u0yeFEB+iLFWxqF0Ez7Y
         8hGpY9k/zjEUFZ0zk6xvOM8f2N6S0CIA+qTL4oDFoL7Uu+SJJyQgIIfPxT1BYanzxFei
         JFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711868; x=1782316668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiwAds49DU+4LXgwUcphlL5t22z30gUm3S1fIhW0r8c=;
        b=Bkzxl5jOAJ/5ic8LFFkDWn5+AIwNbtmByh+pc6oZWbcW4HCnAPg2wD/jYVZNmbsnD2
         P6NUKVWwEiY1lWNEYAvJu1aJ1N/uDnOEl6ArpMwGX+Jsh22G8Iv/0zObN+EzOq/PTIYR
         xfo1nhJkUcCVolKL543OP6QvXoVECHiNAh4AB2KG14Hrk2D/1bqiBMhf3Ux6Pk2PnC1p
         DOoxHY3L3nXg3IuW+2hu9iaCPSAnyUwjSXH1LCr0J62MxTYcWiu50QjVO/9pL1Gvcntj
         Ak+DAzaTGeDJ9WXCNwbaCoU6BrKxofdiKMB3nQKWk0aoqjPEm8Z6ZRqOsETcR645W2s2
         BoRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BVPYQ0fA6wS5yJkF+Slpal7e18aMNGb0CNXQus37uKrCdk6wIR/aPrHf3GfvbWAhiQ5AMsk3jgps+9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYGzsFooOFxjg8QAP3FL4H5rxSFWhOsunlsQi0VSBog4sEG+C
	xyer4XrM92UV7i6aIj4u+xY1jBWhuIx9ypMIjdcao7wXuXr6zR9W+9nDViiES0TmyVrQb+MmHmC
	Ej2xxEIra4LuCoPQpgqyEbBSmjum6jQ==
X-Gm-Gg: AfdE7cnINanFKZXNLEbhUxWolU0ybYiKm6HhNNsF18g6vNjUmbv46gfAEbXBwDFVaw/
	dIU2wh/piGvpaSUjJ42KLJiPOpqsYtGbSMXSH0Edn66QL6ou9qb54EfZxU01oSEMR8MLrjuFOv2
	/LmwOAJ2DkKMHzzhZ27b+Kej3KOTTJDLyWqzC+9aIawQqufgaw6tXNGPE41eV2gbqCti0fhlJEU
	MCmO1YhyVcP53pFykHrxNdsdw5p13tWoFpBvyz4MNNR6vGdHp5LgmUKgDeuq7cAMdofRk5Wboax
	5xctcrmJFIdD5EOoScnOetIF/ZlJw7xi6g6zcUejd7s=
X-Received: by 2002:a05:6402:5007:b0:68c:627d:fc2b with SMTP id
 4fb4d7f45d1cf-6954744bafcmr2478562a12.16.1781711867843; Wed, 17 Jun 2026
 08:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260617061531epcas5p26e62bfdf2e91b646611191e4451d9843@epcas5p2.samsung.com>
 <20260617060850.1244788-1-anuj20.g@samsung.com> <d71f62d7-f1f1-4169-bc05-1b354b94ef78@kernel.dk>
In-Reply-To: <d71f62d7-f1f1-4169-bc05-1b354b94ef78@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 17 Jun 2026 21:27:08 +0530
X-Gm-Features: AVVi8Cefy8fW1Qt0duLNRn6mp0S5eoBMqYrZwzCbXKJkDlKSm8MMkxjKl6y30b4
Message-ID: <CACzX3AuwAdMv4Fw4piMDBrXNcvff6P2A+R=qb4c2_UiojSC=Mg@mail.gmail.com>
Subject: Re: [PATCH v2] blk-mq: bound blk_hctx_poll() to one jiffy
To: Jens Axboe <axboe@kernel.dk>
Cc: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org, 
	lidiangang@bytedance.com, changfengnan@bytedance.com, tom.leiming@gmail.com, 
	nj.shetty@samsung.com, joshi.k@samsung.com, linux-block@vger.kernel.org, 
	Alok Rathore <alok.rathore@samsung.com>
Content-Type: text/plain; charset="UTF-8"

> I wonder if it'd be better to set this to jiffies + 2, just to avoid
> skipping after a single loop if jiffies changes right after this.
> Probably not a big deal, on average it should be fine. But also should
> not really matter if this is potentially spinning uselessly 10ms or 20ms
> at most, if HZ == 100. Similarly, this is also a misuse/misconfiguration
> if you end up having multiple pollers on the same queue. Yes it'll work,
> but it's a terrible idea for obvious reasons. Hence the patch is mostly
> about ensuring that bad case isn't TOO terrible. But you'd really want
> to sort out the app/config side of things in any case.

Thanks Jens, will use jiffies + 2 in v3.

On the config side: we first hit this with just 2 jobs on one poll queue
on the dmabuf-rw path[1], not upstream yet. The 32-job io-uring read
repro was only to confirm it's generic, not dmabuf-specific. Agreed the
multiple-pollers-per-queue setup is not a good idea in the first place.
[1] https://lore.kernel.org/linux-block/cover.1777475843.git.asml.silence@gmail.com/

>
> --
> Jens Axboe
