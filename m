Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397108;
	b=X6rioQ5+8Ot3WQshkcMILzT85YaLh7PGQZArlfVZW2ghc5VGN+gBYxc0eIAxHo/Z8Fg4
	 L3ruTzXIbJGJ0t+YNDXnFVJiADky2R8ofXfRTKR0ADpwfdyD1ssEDDFGgA+isEJj1JU3s
	 ldOD98XxUTpJHSFNEpMKpqTHRRcN7DnCyERjTg3DTXKMXcIC4pso8XMKHG4Oooeg+DG38
	 ueQoo+Bq0wf9lLGtMU390BW11/fGp0g8AbZLUXke549vp9Y/oVfweSbJZhlylarn+n4EC
	 nxaFXC/bd/qj2W8hLjHSp/ZuMRSdYHYSjRisv0/Ok5L9VkBsBBQoTwyH6Pl2b998mkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4fTSg96yjoQMA+V2VPZldNNXe6tjLZP6OX5IOcXamiY=;
	b=lCo33cZuTGdkFaLaHLWr7Oa8op9VS9l6YNQ4XP6o9zmYEAQ5MQNpYsxN3fPBOv2fpsVM
	 n4qJg5nXhP6dMXT5yuqCkWypjZDiiWjXaIuIftgF8ODakcWDIX8B9TXE1BD+XbZr+g18F
	 RZdB29atzUhxiPLdDRtljIY6SXGBV2rKWuVV42ufGLb+fLlCn0X5CgX/z3zZbpJe46UPO
	 71qPHPLr1hDyzaXmqbgeEE6oKwSX5thHmMeIWYe2izDQv1mN3fQrSJh1dVNhPlHyjlKV6
	 4rEPHKkSLwg2hxQ6TmpiQ2NMQoMUs0soqhFhphFUbi/U6PU/twtodgE7v4Ub+zdsUcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vB/q3lbx";
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21C606A321
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 11:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C21C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vB/q3lbx
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b31fc13124so23957657b3.3
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794397107; x=1795001907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4fTSg96yjoQMA+V2VPZldNNXe6tjLZP6OX5IOcXamiY=;
        b=vB/q3lbxzaYlSJ1+gXxktaNt86Jwvfy2jDt2MT+T7mKBFdt7mmeMZ53iEjIWNJFvHh
         IIZL0qdkYyYYgN57HQSKr33WHgMlUF00IUwe1XHSHzeZ0vQeq04AS/NPTTYTwXteT5k3
         oE04k47YKh3Ia+VqASIpobwla8xPQLSOThYuRjlsz7yg9lDbex7XBYVdr79DdDVBsJ0W
         +XecGUII5mlSenRVyIIkho2Z+Sg6AHHqWpl5E/qPGEydBtWPi/CySJkw4iUku8AJ8nqX
         3WpXH9hJEeg0qlAjq8gHoZDIvG2F7EpEqpUL31L7CafO6HFFbIROu7KCecTxOatcMbPy
         hMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794397107; x=1795001907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4fTSg96yjoQMA+V2VPZldNNXe6tjLZP6OX5IOcXamiY=;
        b=BfJLVSii1Id44LdhlpauZfCv25oxva2pz8B8Sy8Ah2E9aoxqY9hU++lhh9fjYh/XIx
         BZcVRxMuDvz1WPkNR7PTfEZq5NJ3RcF6nfVYJVkGpO+0imrfsseyL3lFeHBKsnB8c4A3
         zL2+vwozMbONsG12EwD4qFdrEH0Zgm+cWf+UlnS2sFQEqAGlepOVGF5I7n6cjZxmOQh7
         epLsDN/v57CCO03Ehz/nYqQusw+tdKQDrRBwT1Tz6hN6ygW/niQYehN5kLBJbpfFuCTY
         0QrOxJwHIibCsCHSzNHxdoOAHrNYtRkk71JYhDVeKHd76ZuvWfkCNni3abLiGP6tU1EZ
         rZKg==
X-Forwarded-Encrypted: i=1; AL+hErFp7FURoJ4Db01gbVg6Z+vy1/WaOtzh0NMfgB3xZ1Q1rh8cCeto3Q4WKfkVSoKXujSknsI5dGdOc59+6Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+TyAvWUPHxBUYBT6DjbcYCHUNYG+6gotO41+vJAbssX75ct0Pp
	+29zC7jmJpPiBMGS9/1/ooX6JS9LzVth1OJhVjyg4ymO5ze1KBlE3tQF
X-Gm-Gg: AYBFou1dPjcSqEfdNoi2LefWR/9QMYAxhaLQYEB03bh8QTs59Mo+BDEMPqR21/XAtSd
	hxrXyBs3PWmd8mnvX3qF6naviOkPxDpjYA5C5WklH1QBs84pyh5JACk+WK1Cr14zT/tyXyChHo0
	Xrj7hShKDXBJe+xilrKPaabNhJrkfStELAOqNvWHsLdLKwXhqS65MJc/kSsr6P5F4J8lw8WfZFT
	VCCT86inEa/DnrIrxDWm8Q9T+w1N3dIpFyv3e2xS7+DGJaMXgCiboxlD6RfQsA0zUOqmo0SwpEY
	qKXiRiOJiuiHwCO8n5TQyg5ELoYnREioDmaD4nwsy6Wr8DusetJ4EKHsNXUKabRM2AHj3bDCjbQ
	L/B6maHIelVkR1WfO3Ra9UXktrbCHAS6wTx7i2GwE5Q0AHOmt09GbW872ZXUPAYfbvfVGlFUhAy
	dGVZKkum1sTIN7UAyXpoE5tNNNrliBzoov5H7JxGleIc6drF6BY3fJh36DBYF47633EGhB63yBH
	+wbJIqPoFTdQ2DQz83/2NLOtmq80Nka9OSwPf34vvQc5k40KSxDIVQgF5cRhFe5KDithcJoLrE9
	gPP9+CHnI7CJeQFv9wMuMVvwJKDs0CchDXX/mmva89VGBlj9WN/vPkvP73bgIs9Q4I5L0cyidVC
	DKTloWknf
X-Received: by 2002:a05:690c:15:b0:8b0:d9ff:4f74 with SMTP id 00721157ae682-8b3a81ce1b9mr20456647b3.42.1794397107526;
        Wed, 11 Nov 2026 03:38:27 -0800 (PST)
Received: from fedora ([187.120.157.132])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393426f13sm42133187b3.34.2026.11.11.03.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:38:27 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: trintaeoitogc@gmail.com
Cc: axboe@kernel.dk,
	bvanassche@acm.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: fix circular lock dependency
Date: Wed, 11 Nov 2026 08:38:14 -0300
Message-ID: <20261111113814.221685-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261111101919.215767-1-trintaeoitogc@gmail.com>
References: <20261111101919.215767-1-trintaeoitogc@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> wrote:
> > There is no real circular lock dependency here. This patch addresses a
> > lockdep false positive caused by the missing socket reclassification in
> > the reconnect path. Please change the subject into something like
> > "nbd: Also reclassify sockets in the reconnect path".
> > 
> >  > instead of the NBD-specific class leading to a possible lock dependency.
> > 
> > Please change "possible lock dependency" into "lockdep false positive".
> > 
> >  > Reported-by: syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
> >  > Link: https://syzkaller.appspot.com/bug?extid=d7d72f3d467710442af0
> > 
> > Please use Closes: instead of Link: for the syzbot report.
> Ok, I will send a V2
What do you think:
```
nbd: must reclassify socket when socket is created

When we need to connect or reconnect a new socket, we need to call
nbd_reclassify_socket() to ensure that a false positive lock_dep
circular warning fires. Inside nbd_add_socket(), after nbd_get_socket()
call he already call nbd_reclassify_socket(). However inside
nbd_genl_reconnect_sock_cb() the nbd_reclassify_socket() must be called
too and this is not doing.

To ensure that even when nbd_get_socket() is called the
nbd_reclassify_socket() will be called to, put the
nbd_reclassify_socket() inside nbd_get_socket().

Move the nbd_get_socket() bellow of nbd_reclassify_socket().

nbd_add_socket() no longer needs to do it.
```
?

> > If the reclassification should happen in nbd_get_socket(), please move
> > nbd_reclassify_socket() up instead of moving nbd_get_socket() down.
> I was have moved nbd_reclassify_socket up, just like you suggested, but git
> don't understanded this very well. But I will find way to get it
No , I couldn't do it :(

thanks, 
Guilherme
