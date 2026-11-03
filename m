Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716287;
	b=pKt+0AotaAKaQ36QlcnKb5RyqvxyFX4uf8VPjfvHHO+QorW93fz3eyYv9yTedr+k0aEt
	 FZh4VS4lgbJFc8i86VZc8HzA7ty3m1NuIVvljO4rYMpNG9x+n0AdTwO5wxWK/DwMtW7sH
	 2Y+eMceGTyiibvklseKhgTYXdQP4txdcGdAO57phOlIgyUfDsrgg1b1eaVz8bBmbH6+Ma
	 Zqk+kRwz3Ew3XsDO3ZiG2qbX5VO8S88YcKyfTWvWMj2n6YRwxaP2WPfuboUVEOAt9HpVu
	 uXTltt3rPJV+KlTBlvbAj6nx5wLebdjsCaMEo3DBQqzsbuTzwfuQcUZvx8srTVnxszg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=c+hvimF6nQkiqAYkp9zrSjR1jjPwz/uqjAtTj/2pCgA=;
	b=X4530WG84YdIHH2k+iBOpOlHv6fJrfbQuwxKWbhng39ptWrMdOAMzcCHPiZjB/NVbb8p
	 KVzJ4eb1Gm2rXvKBOcdREOtsBKbSHv6lmGdUaDHcGaVBXjXZh+sCFkHPNBX4b5gRHSnnE
	 JjpGfGmD0IY/1WzGviHAw+0DakZBj/zxXSLyIMIH6fb7XHjODWdak9RP/GNe+dHLtoKDT
	 sYpFTJM8rmn4XkFXVKm5JCSNeIbKlBk6lELB+S9D14qHrwuAcOne2SrDjXYo0iPgf7AcI
	 mZJgJCdvt5oDP9DPhcK/JYJPX4tjW0HLOxQlP1Fx7ukgE35mRhPpRokOv+XInCYcutg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="bccSw/9f";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB0606A335
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCDB0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bccSw/9f
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1438d9363fbso738369c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716286; x=1794321086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+hvimF6nQkiqAYkp9zrSjR1jjPwz/uqjAtTj/2pCgA=;
        b=bccSw/9fzlOOlFcbWjiZwUnf1UQws4mHr2WiRgd5F7GigM5SBfd/Ad5GBvOVrPq3lS
         S25xNVuACzPzy3+mi+5rB/NpfkvdfYDJP9HTD+LIxF7DsjUpZrxQ/itJLuwB3nwsydbg
         wDtbdSCxuq0MHb8yVdfho8gSyKTqGpNfsgtAT5N3YdiZI3ly2wPtuF9c1yPu45xUwzr1
         41EXX5JcRx+qMJy0hrkJig7NR7hjC0TchpZ2jTYrA8qw8LhTBK37rdLzx5ZgPHmoxYBZ
         bmnEiGGmficMEzYdU2oMjnGa/R6R/nThKGOXRPmu6rGdbDruUdPgjyopPkM6iG4uza5f
         fMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716286; x=1794321086;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+hvimF6nQkiqAYkp9zrSjR1jjPwz/uqjAtTj/2pCgA=;
        b=j8VdtwOLsDEoNHlwzEFOtYj/xHPRDQvy/7XOdwB5BZ5QugFl4cBIwLXI9/BUCY/ig2
         TIxtzKKxu1Rb9ZCcytXCUckzWnlmmy8kN4TceiP2J6Kc8e4TG0RmcPmtL7gncZDpsmXY
         xATJ00fRsr2XnOm29Xl0qWfa/ESKdmBzrlZpRJHtLcLniH73jZHfAW/D/IeuoUHrcD1W
         SH8KtV0pP1xtpEb3LeJUyDZ1qGXendbZciO9EhXjA0lUn1cf2dZeBf/tHBBFMx2bDXbP
         fBkP96ZR3+LCIs72VNiAWrHHqyV8ktmc//tNwPEjhOOYJ+UaYsPpf7qkHrm5dxCuAVhY
         qxiA==
X-Forwarded-Encrypted: i=1; AKwUvBy27HNFrgmamRhMqjvuUSazirbFH4ZR7hCDfH8wVbeV8dFgphpjvhCv2rL9CHfBr8BoGbILURWA8DzdCg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8cxYPkcUpAf25uA0CHnID9ol7tcC2itj3MIbB9/MDEx5+tiJh7
	X17yrhKG4G9YRgsdSSl/7PLvKU2FdZbA7cWX3QeiiVgtAkpUEyijxiQxUJXBqz3NhKEvgCHnHeK
	xVVxuRYc=
X-Gm-Gg: AYBFou0qrvRBIHucKfKfreQRWNw4tr+Jx+4H87gWK7WHRE81RS8cQ1PvUTtFFNAPFTk
	ZamTd2zFvMBt7RuudSI3Ny2s9spxj2TVk3RNRwGH9FMupQ6VAU/peUk2ErfipNORX4Gs8ZhoGs9
	uVPNUfumGIknlcDA5wUu+xWaNdXPVe8ssJOr95h/aNWpFEiP95daasPNeXciLLKGhwviUxUhLt7
	EU2rf+9PDF6GDLQ9Tr8EIJWhnoRLniZUnFHS7FzBS+tnF+lKH95WgzEb6q/PdslPwwtTdH8r0bR
	4LZk0ZzyIN535o1wPjqcqloe4IDsTZEQPtp7acMaYyGrYlBwq6UT/m+ReGZEWiO9JaOrIR0BzWH
	QplxOGVy3y7hw6LY44VZHKA6fRjqjvGCw8C4sJb4XFj9JaC5iR7bu7j6psIygi6JyPEWgmJlLra
	OHAZWdHRgjOM2ZL8g+nDC62k0/UwFn3ZxCH4uXa2o/oi8IMzX0W6lR6XY8ZmHimbW9H8mbECvsZ
	NJm7itdiDugT1vpDEvWHnd6wMLp0Jj1qOwI4PLWZpYdLdVSo2jcqp7YSGuvP6XcAGko/8wbmigq
	VhOHe/nF0/P4+ctRXA0qgdy6aagp2KSS/POa215OKrZIh9pT6C6CeFzLIMXM4pHXnabuK8QusH4
	/Qs/qv6Gykf+j
X-Received: by 2002:a05:7022:b0c6:b0:185:6c8c:d860 with SMTP id a92af1059eb24-1ac599f50b1mr19273200c88.5.1793716285874;
        Tue, 03 Nov 2026 06:31:25 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, hch@lst.de, linux-block@vger.kernel.org, 
 shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261031221610676B5VoVcwMgkoDNVZH2bVDO@zte.com.cn>
References: <20261031221610676B5VoVcwMgkoDNVZH2bVDO@zte.com.cn>
Subject: Re: [PATCH] zloop: reject mismatched conventional zone files on
 restore
Message-Id: <179371628470.3691261.11003519751886691863.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:24 -0700
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


On Sat, 31 Oct 2026 22:16:10 +0800, shao.mingyin@zte.com.cn wrote:
> When restoring a zloop device, zloop_init_zone() checks that the size of
> each conventional zone file matches the configured zone size.  The check
> prints an error and then jumps to out_fput, which releases the zone file
> and returns the value left in "ret" by the preceding vfs_getattr() call,
> that is, zero.  zloop_ctl_add() therefore treats the zone as initialized
> and continues with a zone->file pointer that was already released; any
> I/O to that zone then dereferences it.
> 
> [...]

Applied, thanks!

[1/1] zloop: reject mismatched conventional zone files on restore
      commit: 09c2e203e0ea8b68e7c9500401fa0ab60baf1a9d

Best regards,
-- 
Jens Axboe



