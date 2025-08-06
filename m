Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D121A0BFD
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449191; cv=none; b=P/uIHXsvzm0+p6ELLo52PBQqt5n9PhCZkZId/dhHNXLj1lE6+qZ1O6pWYt7rGoM5p261JxaW7FwCLF7LjQz4qYY8ecd9SDNhKL/yMHBPiaIwxcKno2sLBv9jcKp0UoL5/6yo+WeV+qgmcTMzN12zMzxqHek0K73FOWJpYtajps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449191; c=relaxed/simple;
	bh=2Sy51UIDbWhWeKHVaneconwV3uWv2TM+n+05gLEQfho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp4KUJEXkEIJwqlMfGE4CCAD4HC6tQenTaHPOSapjUtIEVJ2HDTIfWSdrGQXBAN8zIwQOG6Pt/hCob+biV/wP8pGuTp+X/l2k00cwo6tv6iy+Q4TVFSG0UzGuCyCDoMg0sJprmKBpyfac9LAy1wGkuWbeUOFSvIGjrIzxliJxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oIBzWcUq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIBzWcUq"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b424d2eb139so391211a12.1
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754449189; x=1755053989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csMGrf5jAXlWmahqYDn+czRvht0UxHaBsWoGJ3YlYt8=;
        b=oIBzWcUqWG5kPvgkoGOKVGeHS5T4ye27hPftT5A1Ktoacrk5GIni5tAhZpCpwVhN2K
         Nef5yyCGY3yDEezt7TOmmMVHeCZKCYWCTCi2ThOUfzNK4/6CdSuOo0AeJDEdDPDXkZAa
         QWgmLAHF4PXxXBcOz3naC2zpGGPAhi+WYY31I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754449189; x=1755053989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csMGrf5jAXlWmahqYDn+czRvht0UxHaBsWoGJ3YlYt8=;
        b=bTt9F4YZn0YpLFrA/yYCdcvPisOHGLaAMXvne9+28ayu8vkCHA+fI2wc3AFmNKTEWi
         e4Wv3tDa5/bPpDctQP6nxQiFXJDtNeEVHErqxP7huDguN9bTD6sQZhKEQxBoVxXA7FsM
         NibyboaelB+FDSQkGL/56j4Pm0xNiyWnIigp5rAeOODiKG9SZAArcH8bNOzcazpuhpiU
         cNHPrKuiJ7sLt+sOAfMEZ0s1W/KQc+FpKuI2mCATrMRbccaSyBT6EeRSlTH/k9NZ2icx
         vCx+WEu1CvyIq687srdOKVCgLBGr0Nq6kDVPO3fLOBcqvIa5aLF4/jvOYid+Bb1BBlNL
         dlfA==
X-Forwarded-Encrypted: i=1; AJvYcCUsyDU8pHgM37Uh1LD/aJdsC5FOqaCCJoSgclXMIrT0MGgtbo6jWBMTEI72bb3REsfV7siO/9RPYNEeeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJ3AzjsAlPA3/uK+KTHkTtlGOcSElCZtkkpo5o2YivTSeEbyA
	j6wrt/6Xa4iZAz/X5+9cSi3C0IPsvf9bRZrG8OoTZGtdrGlfCyIr7Bu5T9rli+ZJtQ==
X-Gm-Gg: ASbGncvZEhO1u31EpsQXA48U9UMvmFwgB9w+IpSd8vGusoq7Ur9CQlMGaMr68sC5CFr
	gL6uq8n+9zmDSRpUMoVaU/7yqoZ8YhM2HK1EwmVoZ120JIjhbYXXbtg/Yd17LqWV6LCqtqFXU2Y
	KtTdZQ+Ux9V18IrX6Wi1xF67AVCFmlnRyKda0BAJJUJAhTtYwOctMM484sMtv0OBsbfaxQzPtxj
	PzEPpAT8XHj1FxUAy2kKyjL5LtwKaxd+muVrfC9dC1SghSPxpWEzTx6nOSvzs3iDUD5NsdtaM+S
	BtAtPHtXDtCIL/K8u31NaHAdG9AB3EI/mSGQAO3HLzbQrEkm2uGB7/QSxp1FcpZK9/gXH71QOLg
	ORf2l1niBKiRIx3U/KEG/Hoc=
X-Google-Smtp-Source: AGHT+IEuIyAVHK9DXmPrpCmyJe8g9FqVpouWfFwjWzGsjgBCZSUXcftxofFAUIeBUhsZwm7S6rTi+g==
X-Received: by 2002:a17:90b:2d50:b0:31e:f36a:3532 with SMTP id 98e67ed59e1d1-32166a395dbmr1667250a91.13.1754449188844;
        Tue, 05 Aug 2025 19:59:48 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102ae8b5dsm7792503a91.3.2025.08.05.19.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 19:59:48 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:59:44 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org, 
	axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <h3fagdwigvveeqkd7zikzv2glcfiarqpowiumna6ngb7ktd4zz@7is5ivhmyvbu>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
 <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
 <6hs2ou3giemh2j7lvaldr7akpmrwt56gdh3gjs7i5ouexljggp@2fpes7wzdu6l>
 <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>
 <elixwhbyatkcaw7djpzfa6nodhxh4b4hg263ito5o5ibzewamx@nuux3sfh2g4h>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <elixwhbyatkcaw7djpzfa6nodhxh4b4hg263ito5o5ibzewamx@nuux3sfh2g4h>

On (25/08/05 18:03), Seyediman Seyedarab wrote:
> I need to correct my previous statement about the use-after-free issue.
> 
> My reproducer was wrong. The garbage output I reported was actually from
> an uninitialized buffer in  my test code, not from reading freed memory! 
> When the device is removed, the kernel correctly returns -ENODEV
> rather than accessing freed memory:

[..]

> The kernel properly protects against use-after-free in this path. I 
> apologize for the confusion.

Great, thanks a lot for the update!
