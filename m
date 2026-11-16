Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830457;
	b=SBeJYnZvIQtHNLdsPRX+tiTnQ1pAKRt+93QKd9W1YZ31htgL+RDS2yrHP5TSi3eO4NP/
	 5EiuVQYIQtYPMOh2IdE1KY6UWErVNI8vwBDpR++ju3sgoGfJ5HakOwyVpfWH9JXYpOYjc
	 8Ndoc861WtgP/6RgubywDDJCUN+5TUyYZxL6muPGw19CFDkVfKgyKXbqX+IN4bZe4X7Of
	 CwUX2N00bfXR3AeIgPQvEggJCM7OP2YYVS+MW+JeACizm/sf/q1YgKZAQ+0ExUztV7dWa
	 heH8cxUSAjxQtCXucKnQqD3G2OkPEQ/57aPd8dLKlJQxQdP2XqXYlsPR9ZUQfzfj1RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
	b=LQHy4DglvefUKBWDeO7X9UgH4ASgk7rmip/277ZJitKOQ9VTXAi3QtB9mDJIgMpzcWyF
	 2ZtpMyI3wTCizfYfhKIIu5xeKaO7d3qOhM9c1oS2tdwIf3GYPm+9Fdcu2tH/SPg8DLGNG
	 YLIWh8g3puqoj/Ndia65vlrpwWC1vSd4nkfIG+x2OEQl0lL7HS2fJuSGdaqO9EJDmBH34
	 y9wJkaeJC1Yx1DvUzr32QnXvbzzEpBxB1gmUZGb9Qwyieul9rbhQO2dksIhtOHzaC8Kze
	 MnY1AZG+ldzg+s81TiwPDApqnDUx9XWrBmpS4xkHvrqynbbutdmjkmkJZfpBi1i/cMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HPhDK7mh;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B17C606A336
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 12:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B17C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HPhDK7mh
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4923b9fdd43so2415778f8f.3
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 04:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794830456; x=1795435256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=HPhDK7mhvKoexu3wV/J5cAKBVCjdxnE0WqiM219E8yH7eWl2bpFOUxbsfidw15OaBQ
         3v/oOiLCUqOJKC7nE/sfeHMGODuUIsJx0HNirhnEfTrkTSlF6mxsAka4bN3HHTEKuz8X
         I7ILCePljUvo3TBsSDLONNTI31MYsfntJafmj4EM/wfNH8zBljPNWXbjdXsxXgFWpxK7
         QBsjZgUghWzTrvW3gB62VO1cEaBa05GYc2ZRtlRGIidAi9COFMIabjVojBmfGFLgZQra
         H+ROglAj/Ny78kycfy7M7MzfDC6v9ICyF5eD9XUlfn5SvIi4OODpHA/Ny8dfvpbuHFYW
         7n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830456; x=1795435256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLAz6sn1EqmF7aJ7KDEBtraVgj4ybxLcfJJY1MY6K34=;
        b=0f4tUnUsfekIOoCl0+I8zv4DGhVRYJWnBLMKbdYhYng4tBs2WKrE7xuLtJpWVgp2FE
         40lWK7m3aBnDe8HgtslLeBrjl8t+bxaltTr1l/KWv44riWkOezvBC/Sa+6eA+XTK5vR6
         onQR83kG0MehW0V86d7EwbIfIQORMx867yItA3yBUor3BN3GGPC3+oVwA3Hhnwg7Rqtg
         xCMfnyam4j6csf8YCM+yVjCPyUIT9putp71wxNzDHCiUmmbyXpndFUdQLNBGFYNhjzkF
         CFMnWo4udpHLR3tIvc/IaWyniaWT+WBSroE0mT7H76ROWYAh6GerKvATBbgy6maOAwxY
         P+Eg==
X-Forwarded-Encrypted: i=1; AL+hErE4qWsoli/Lf9jeMeMNHwUPy36/sFh/BYCctQFiIwF57gY9q2uNUGv2y26IhXRalzeOkm6YYbZivIGvKQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8d73cOLHunoeY9uyP9eRkAFfTTktQ4sd4zAz0vcsmKuX3NuQ7L
	q7s/vaWz/2+xLjCreiXhY2f91yl0s+R8VSNiRIiPThosXQ3fyi+ErZvdg3P1iKlpnCVmCd/+E11
	dCpA3AfgB4lE3UxERUA==
X-Received: from wrso13.prod.google.com ([2002:a5d:474d:0:b0:493:3d97:6e88])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e007:0:20b0:48e:3697:708d with SMTP id ffacd0b85a97d-49c70ed8e41mr16698595f8f.12.1794830455230;
 Mon, 16 Nov 2026 04:00:55 -0800 (PST)
Date: Mon, 16 Nov 2026 12:00:53 +0000
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116120053.371591-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2026 at 12:04:45PM +0100, Christian Brauner wrote:
> Initialize binderfs as a pseudo filesystem instead of raising SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
