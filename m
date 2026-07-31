Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492B2E0B5C
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514265; cv=none; b=feCkRzdGmwW+UnO5zbY8zkXKej6tfDijMEIQYkD8AsldUsf8JCQvH7mtFZmce83xoMA2kd8LTykPjVhLewTt2lvXFBgx7pkBbUoLEo52GaE7RXFvo7w86c/1K7kEzy+8JsbMZRc2Naiwd59GIm0SGO6zDSjfGufky6pFFUjEXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514265; c=relaxed/simple;
	bh=x9RJ7SMSgLg5w8jqdPtEfg3L/BzThYw+TbjPvp47GTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8fmnbKjrJFW0pJKvEEt8LuGSKPfziCl4Xb9R1XbsrJSbLCJFllr6TNhtAoWeHC/QFH+FY7ZmXMAEzk3hQ4hKJDcG6Io5uYAxWUhVzH3WwQsMY/1ZtbmIx4t4wJ91lamZSvNEnCzKLH3GN2YZMYPJwfYVbh7F3SpkLABopmfn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvjGV++v; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvjGV++v"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81dfdbd86d1so12298117b3.1
        for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514263; x=1786119063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MBBdrgEiiLcHMNev7v4q80tW52HBpHM4ov5sou+TpNc=;
        b=FvjGV++vI7toAfsmZ47f6dDKWqmD65apM8Z2uo+zXCyXM8AGDJsiepkda5gncT3AtP
         bY/yGT7yjM9PwNJhMybPDcLVSe/l40fF4FBWqvTfuMACifLu6Kn5hB2GgbR5fyxTBTqY
         /9km0FLbArxCojGl0ltg0FbUjrLIijfcOisaAn68EC07B5SIUIApJLnToa5Y174F4hxw
         5qErzDCy8MQzCIZdr8i/4PEjnP3i7Xf7y+JsGNW4L/r60PJB7HAQ3/1dA2wJW5anljI/
         EK6UlW06K7JPSGL0tV4QIO1z4T8h252DaAe0mWrByaDFRu8TcrZIix3jumlPYhkSGT+1
         LTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514263; x=1786119063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBBdrgEiiLcHMNev7v4q80tW52HBpHM4ov5sou+TpNc=;
        b=anOUthIr6yw19KFQ2xQ/pN6vC9u79xzTw7B4WpFidtTUv5AnSRheaRBhx9rg4SEnXx
         1y4+QpHn1VSKbtZRjZR6lQQGeU/GJT92nnKZ3DPaYTpGocKbG9X+ItbPhrBW+Q+v7cV7
         wi6sHi4u0/yV9s2JDaiVB2hDak2DiyRt5SDxOPyUFAefpLbx+Bfy+ujZLBpGQdSyTjFV
         0Mykoo8gdWcwnpJwH0GemJs8uyUiRp7WUtcsqpHW22BRqn3alns9APoMnnltpvSt7My5
         1iP5dnlxpGg3VRz2N/46FaQ0c/oQV6NfQgEdQieLhfFi2TVOoapg49BQ7sDJOT77Y9KR
         rr2g==
X-Forwarded-Encrypted: i=1; AHgh+RqchAZu86CDPMMLxgEtiE64xAUBDPHoQJz9N0ZjIfd1i9nKab0sBA8aDtM0fap00r65TYcZpKyxw74ScA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbn6biCxleofTYrIf1Z9eFdYFnZoNMI/KOSLvRuPDlYQh+8vUm
	VwW3RsD6H3nnQ/h8rg9+ph8sAFMHlQ7mNJrkN7Uw33R5hG3EHmyCgrHzmd2+sNSk
X-Gm-Gg: AR+sD131D6LLRyE0kkA4pb8Wy9j7jNioZD27n3jiM8hMfHiz/o/tQOIXCXk/oDNdqTX
	j/O50OnJ4E/22sSt0fU2brjqBMDrBHJ9T/61qWfSalYuPhGlS4XCM3IyUYbRtPStlCXypp1fYrM
	LHX07UUouMVp2Ds5IzgeZyMxjpNxNXgEE26MIrhIBSWPEQCfxW30XlUGNBVX5d1RTxcKZM3ITRd
	f83GHdNj4u/Ds8Kxux4VnXjgpsR7D1uYvzTMldGtMXtcs4Jb0yi3JyrcaBBMRK7f8QfMAAMiMCy
	frpICKE9y9iy22CIbilQkn1Hw2EhTG9IkaJn2SP1CmFa+QSeGmb61Gyfn1j9XHF8Sgr8dZT9+tS
	pWJRO++shxW6/gOsvombNTmBdqo87HdtMWJlYvwVmiRIEFmPlR++cO4ZzTp22pRJEqAQyMUFbTK
	h2YHb4SdIls8jbksE17FA65PHajebrKTz7Yc/fARfF4UqdhRbekWOKOJM1WkOYVDPgFv/F6iYZ4
	kJ+b3Uxd7GFHDtqp+1ZWLkAy2d+LUwRLqhNKrZzgIyta2XtFajzaZt0CeLDoeT/3W8Q
X-Received: by 2002:a05:690c:b95:b0:81e:4e5d:484a with SMTP id 00721157ae682-81fd49d80camr6175327b3.2.1785514262639;
        Fri, 31 Jul 2026 09:11:02 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd133d96sm8958217b3.44.2026.07.31.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:11:02 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:10:53 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v2 1/2] ublk: validate auto buf reg before taking
 uring_cmd
Message-ID: <amzJDfYFOL44eMe3@fedora-laptop>
References: <20260730010910.799346-1-yangxiuwei@kylinos.cn>
 <20260730010910.799346-2-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730010910.799346-2-yangxiuwei@kylinos.cn>

On Thu, Jul 30, 2026 at 09:09:09AM +0800, Yang Xiuwei wrote:
> With UBLK_F_AUTO_BUF_REG, invalid sqe->addr can fail after
> ublk_fill_io_cmd() has set UBLK_IO_FLAG_ACTIVE. The uring_cmd is
> completed while the tag stays active, which can hang teardown.
> 
> Split validation from buffer apply so the check has no side effects,
> then take the uring_cmd and store the already-validated buffer. Apply
> the same order in FETCH so io->buf is not written before __ublk_fetch()
> state checks.
> 
> Fixes: 52460dda3a77 ("ublk: move auto buffer register handling into one dedicated helper")
> Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

Nice catch!

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
