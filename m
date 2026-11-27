Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745461;
	b=vbItWGiGHhxo+RYOUE0IadxWlck6NZ8wAODJWp6auVk2e2Xi2WUM4S5QpqHEdqCqBl/n
	 0Bq/BnrL9LOnHAt/IOxxaSaz1r+vK+xyDWJlkISQ1jxCVSoPwt/jqrmh/Sl3dgHsB9brt
	 EWVxMRQao7Wqbcwe1TbP2WH1X4YYYN3sjK8d0Qo2pCOvbTbOAeAAlcE69vAaEe3JtQG1C
	 e1XvCk5+PQoHxaRQuuARucHqkBZ+tTlYm6H//n+GZoe8CABoXWAhhS3CJuRNsIu3leOxk
	 wrAyIUXs2I++3drpR1DnLbwGnTocq+RTDgZr9wB4EyIduF9zATSi5qUMoAYQCHmsMTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=BHCahoKy2PJzUedVB7T1cTYvXickwh+vDtpwXOtC6wA=;
	b=uAF3aY7xnzmqjMJphpM8BGxL5+fXIIccXgkXpcwVMyqR4gs7slbQURcVaT9RVfq+3YXf
	 t/LK09Q7Olzz48Vnn1W+HSQxn4BOfnu+9JK7VVShkZKpuvIZa2JKpRyc50zd5TxtQR1uM
	 dfnIaZRrnXw6RR76EobAw9MVu6uvdaCgJqCvRWm3yhMCXWQxxPeec8dGCduEpWIrQyY55
	 2JkqtTOp+deln4vj4Sf8wLaXznpnnSkDItp7AgJynaUGZfFj2sa8Pfdf7TzgUhLVAWEBL
	 XAaky045tFNliatyDBdjee8WrQPUkpmx0kxQWyBLtKPTay2J9Epy3y9/S020GzKCPXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="E7NhiTW/";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAADA606A321
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 02:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAADA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E7NhiTW/
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f066274caeso35709895ad.2
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 18:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795745460; x=1796350260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BHCahoKy2PJzUedVB7T1cTYvXickwh+vDtpwXOtC6wA=;
        b=E7NhiTW/ePZcJTVjS9gCw0DveB6YX2Lh9H5t3MqtptrNPMx1MvFpK/Ol+p59LcWWGi
         lko2I2G9D30i58Ps5lhPPG7ywL3139h/z7HuMDUoExqJqc/e3aKwi7SBP3G8gGbID/8d
         uj81oS5dBFuC5ctOWpMpoi5QF7/tu8uPq/aNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795745460; x=1796350260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BHCahoKy2PJzUedVB7T1cTYvXickwh+vDtpwXOtC6wA=;
        b=zQgtn+2UkhtQy3ek+efPGe95kkqP3/sdg1ftms59QovC+ce26nFaNE4E0S288q/I1p
         Vv3PzE4LGe6kJCbzJbJGDZVYMyslg6T6Y0rkJhcazhrtDwQIIjD2qdv1Ci7bjVtaV2rp
         pTiACJJVJZSm3AVOPGR31dMe+ZzAmmEiOn+SG7r+MQFD4mc4uoMKCrKIpqNlX9QdN5sD
         zH/UIaPWI0FNlgLUKYGhQxwfri2qo1po32DQVPw9WALRc2CXPB1covLOjR9v4PxC3Zn/
         0xLw3h7TiCGM5tDHkMdKy3NwAdzh9yGO2EfHuA3dDbIalqv3VrPJ1lghbmGm+yctTCfz
         ooKw==
X-Forwarded-Encrypted: i=1; AL+hErF47KbpMk+tocWrv53T7p/GEvJEtTtpyUBPKH5JWyf7RRSjLjkjDXjhfcERKY9zZoxZJEL+aBVdBplK1w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8uM57vwKaWjD/hvG0HuXpq0YiJRqIrtMR/F/aDqdPJ3UTts2SB
	srOzhdIuGqgcQFXN0DHF6Gz3+BPxLIs6My/WZZdkJESSJnK42qwkHkX40t9FaXv8lg==
X-Gm-Gg: AZFdTZdL5r2Dy5+kEmxcO8Ly9otJ8t3QQ+looyz6jPSe0uvDDjHeATdpzhGOoARUhmE
	oFDNgng2FA40Mj1XDrTloTy00mOIHp/nY6D11kROci7uDpBJb9U7TNSmSXNf55WiAX7wIcmbMWC
	NhVP7iju34rpxYFhgLU6dnuUHBA5e+aqwPGWPwMTi34EHg/nL1GhVK9i+CG/Czw8w1CNvTkcuNj
	q4T9zcnTCW5zmYyZgc4Sh4T96Jf27hz5axS+Zc8ifxLxF24NqCmQWCr3fJfvhyd6vCWJuMxjWNa
	F8Mmjj6/HMXetZB0ccfuD15AVINXzZR9tO8zhGBaRryRHKcs20yAcKPUXwuNLX1ZY+KwBPMwuIY
	QZFTmd8usjp6Mfl4Hb5Dy5w+CjAG/paHxS38IEmoGvYUGD0oEbUsid0jpT7P+qYa7Izr6IXyOry
	k/LL6WTD1S7gGtJHwmaeoP1kO1t7d532bwfxluM2V25Wfm1VOPs4DpcHqPkZgRh8UXSzzbz5ua2
	lGDP5Bx2vER3Xo7p08IBe+eSZLx77ZAbiGGGrlZp0pDgbNVdNqJzTK5ZcQTIVgu6OcD1TaEbGDt
	/NSDlb7nqAdvfZEJpyk4lhSiQTixPbCywkHqIIr+/gpGQgrCguhSfDcn2cRJbgEAgkR+NQ==
X-Received: by 2002:a17:902:f645:b0:2ef:dc42:10a9 with SMTP id d9443c01a7336-2f03ef3d32dmr240566145ad.7.1795745460078;
        Thu, 26 Nov 2026 18:11:00 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:5bf8:984e:5bb:e51d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42b1sm110269495ad.17.2026.11.26.18.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 18:10:58 -0800 (PST)
Date: Fri, 27 Nov 2026 11:10:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Artem Novak <artem122novak@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org, 
	axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: validate decompressed page size
Message-ID: <awjlpLnyVmKRqhmQ@google.com>
References: <20261127004411.109585-1-artem122novak@gmail.com>
 <awjaHB2ugCG_F3Io@google.com>
 <CAPufuhb9txcosy48VXtfxwnC7Ct448J=_HbR00JnZR1QG-NfHg@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPufuhb9txcosy48VXtfxwnC7Ct448J=_HbR00JnZR1QG-NfHg@mail.gmail.com>

Hi Artem,

On (26/11/26 19:34), Artem Novak wrote:
> Hey Sergey,
> 
> On Thu, Nov 26, 2026 at 7:19 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> > Yeah, I don't think we should do this.  We only ever compress PAGE_SIZE
> > buffers, if some backend decompresses it to a something that is not
> > PAGE_SIZE and doesn't signal an error via "ret" then it's a bug in the
> > backend and zram should not cover it up.
> 
> I see.
> 
> I thought it might be worth having a defensive check here,
> since allowing an incorrectly sized result to propagate seems a bit sloppy.
> 
> Do you consider this useful, or should I rely completely on the
> backend contract?

I would probably prefer to do nothing about it, IOW rely on the
backend contract.  Most of those compression libraries are used
in other places in the kernel (f2fs, squashfs, etc. etc.), zram
is not the only one to rely on them.
