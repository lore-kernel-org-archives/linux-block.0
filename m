Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A285C613
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422294; cv=none; b=X60IsDn+LlRz8uGQRZFtIPMP0xvgFc0B28t1MXT0X8vSZYRoY84+buM55CzjBzpBRrGU4w1ITr+07CXXB1R0kVj+C7ZY/sy+bdGGgS3WsY9cKI9Le6AmCFaqzRpGJfCWJJWMoUQq5oMDIu8fDg5xiK/EQ39FsDPsmMR9gH4fR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422294; c=relaxed/simple;
	bh=ljSc69aX7CTWHRJdJgdDl33WKuH5zjh5+KLUUrTuits=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reElmOjbPpqauWAqzDMko/AmO6XtjRbvQxwOlYn64Ui1wFWHPaxHhHt+UOZfjVR0fgP5CXPCpgVD9RFDqrgyf0Y7DTaJqqpQg/kU7p6C6W/OkcPwRbrEP2Ldsy/YbOEl4M5kUy/G5mqhhTC2FEt7vujW6qEL7GCDh6b6l1paqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsZNs6G6; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsZNs6G6"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66843536f94so2661883d50.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785422292; x=1786027092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1PX4tMMPrcdGijfVy8V6872YM9hf92en2GXQCdp9uYQ=;
        b=hsZNs6G6om5mxPyofUaQROUzuJzPDM4SsMVyAjU78dawP6bxQ+CQklL1YsbOJLOy2z
         MwCxbygrbrdfIQEpF8cwhAv/DtRktS/alddUAg5jsxb/bM1SYKwJvMuRaYWihQo8rosH
         5Sgjwr4TfpLt6t/Pb/VEEGUr8QM84ymbAf9czuY6/CxKuTahmE4NJ7ygmhnvubb1pZUh
         9eLxE/DZzLTpVlUWGfnNA8tMyMp3oKQaNTWJ6RCnVYD1PdJviVSjbwmHdDNIXwgVHluD
         JLE87ix2Lw96RjLSR/3ip0mXYlBusowlze+DqyDhTNvk3YZGjG1jG1mvjCOckko79sod
         LDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785422292; x=1786027092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1PX4tMMPrcdGijfVy8V6872YM9hf92en2GXQCdp9uYQ=;
        b=PlZLWjmrDaD2hbtVMJZqxO6Zgk3v8pLJk8rD3uCK7KPytVr8u7sMKna4eoJfhaXFHX
         YkJw7nTW5HLr2T4le8iz9T89rUNq4zAGWZ7qUKhRAop/KM8DoNVM0nee2CvcHVYUu3mY
         FsvnLF4vutGHDVeSzx1UwPal9RtRAVQ6uqGa2sQxrReVAsTPbrejW2QbQ2JB4cyrJgyW
         gPZEazBcsLXCXM39dyNeq2VHfrik+M8LaDkKUpt8y9kaRFf/dGG9H9zeXvt8vuFQ2irO
         COa80G9z/a7R2+NdHA4JRwxYDYI6tphXQ8CC8DGKtbBSh6SBQUEoDaSSQNB3jUeP+597
         GAaw==
X-Forwarded-Encrypted: i=1; AHgh+Ro71ZT7JuxxXgybS0g7j/Y7beLV3E5AylR2R2Wjzw4YEgbXUesMM9Ld2lceN9EGVzXQTtePyPDl3u8yJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9cjhcO+M9i4sI6bWkChGJ9nlo4kVqcZ1xJiCU66qRiNIxVMF
	gzIQAGoJujf5v2h/fADwvvtp6pevu1HyTo/kYahOxOF7KmwRk+sGXQCp
X-Gm-Gg: AR+sD10IgIRxLKwgomLJT0abJniVOTC6VToFSkpTwIxCQBCnkonOdLif25IuzKZDeYn
	U1yN5uoZasHXiLYcwHVmrVFf91De5YraCC6UCmvClbBglNLB3CRQgVO5F3hPrVG1lYFfez950ZR
	R9LtwgZjZ78WAfinX876x/QLpqIb5AX1JKCZb+PvhFGZc3hv6LRkrUYpDbj3YCVvWyNjKm6Li/8
	KqbhplqO+C2JgjrhPiSsWRghShl3yA39IgLWYb7a8ljeYBfDX4O5nmn5T1MYv8ICOGqR6qfYgxN
	DDJDX/lJGyREdgD9x/cJRQfG/d+HZRnmkd8O/Q3T0AVLpVbOF+iVachRBwCv0E4yBzl65r9xLGr
	CDxboyLaLEsEpXrKqnBvHhc/hv7UPL5Ls04MX96f7Ir8KWikmFnQi+xBRKfZNaDC1rpBikW1Mpa
	Khy1HmKdxxm/Ofi1dSYodmWBVdmALS73jJets886J8NLNe2EAtrnsuh58CRaHfRJw2k6MS71Hnw
	NPP0QcSBJhLkUB8sRN7QH+4VFbnHqidOoJDvn8nXxakw6LemqrnrINUUvnZNX8haqI6DxO3Kv67
	Ifs=
X-Received: by 2002:a05:690e:438b:b0:667:bb60:78af with SMTP id 956f58d0204a3-6692f7b02e6mr1322456d50.90.1785422291746;
        Thu, 30 Jul 2026 07:38:11 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6693b131342sm127756d50.19.2026.07.30.07.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:38:11 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:37:50 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ublk: split request validation from io_desc init
Message-ID: <amthvuMO8t9UHIv5@fedora-laptop>
References: <20260729012951.3744582-1-csander@purestorage.com>
 <20260729012951.3744582-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729012951.3744582-4-csander@purestorage.com>

On Tue, Jul 28, 2026 at 07:29:48PM -0600, Caleb Sander Mateos wrote:
> In preparation for moving the struct ublksrv_io_desc initialization from
> the thread submitting ublk requests to the daemon thread receiving them,
> split the fallible part of ublk_setup_iod{,_zoned}() into new helper
> ublk_validate_req{,_zoned}(). Only ublk_setup_iod{,_zoned}() accesses
> the io_desc and cannot error out.
> 
> Return a bool value from ublk_validate_req{,_zoned}() as the existing
> error code ublk_setup_iod{,_zoned}() returns is only checked against
> BLK_STS_OK.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks, 
Ming
