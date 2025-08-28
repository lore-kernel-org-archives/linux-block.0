Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD84264A9D
	for <linux-block@vger.kernel.org>; Thu, 28 Aug 2025 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397191; cv=none; b=orEg+6NfxzHtV/76OfQyXGB4oWrpnpWiVnKTjSLwMhop5OWjUAZKrY8mGHUtxXIaApNz4TcuWAWKS+krWhBQKEw18GS5LPtPVLTEq+rXC1GOooLrC7ugf3TcXUnH++s1uvVKgz2+BiW3T9lKIIMYx6zzw+hUdr5IYFl14RW8A2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397191; c=relaxed/simple;
	bh=F//I10DGQ3c+0b/Z9jeGysiniCCLugL6GuqwDiDfu4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=To7zQg+IuJvycs+EjDCLfIxbBgTpoDhAvOGj5R8BLxKHvFwf+Lx30gHP6cjRQVYEenKTs2si3LtCnTun2ix7LcnZZbIqI0XtM2XFW9zX2lyXEF93cUcaXNa7Q/gYJtx9r/MmJS/55K+n2FVLWTm7VxvwwrHtdQejky0ZJNaeVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gqW0fJgs; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gqW0fJgs"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3f0651cb8aeso9855785ab.3
        for <linux-block@vger.kernel.org>; Thu, 28 Aug 2025 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756397188; x=1757001988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ1iBkivcgNxINJNzY151f9lwALON3YL8XgfKRBEIv8=;
        b=gqW0fJgs8ha6cUN1GUJE12BOGPI8m3auFSLy6xdurSNOubKCa20L37Bb4a58xKPINy
         oaJJMDWWN6jm0oIE52zCaWWvC23dg7Tr/mi4ge/Huq0gSogeRI20HIhXzd1oCHSmhfz7
         lDazi7b6n4zK77UWCWxetxdJCrkNqSwAWYvXKgqJsAVz2sIZ6QuEjhPT/H96DiGpUk8t
         rZi4zjo0t5258kUzPNZteGL4btzTMfCHtkthICLi4myp+w1gEBhuk/wOrhzTCB0UWKX2
         1sSx0KhTo+58ap6soFB0/7uHzMCMS30cZDjf2kVRoDcrW0zsyIilhxZq2LvCB5kPHI3n
         Aj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397188; x=1757001988;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQ1iBkivcgNxINJNzY151f9lwALON3YL8XgfKRBEIv8=;
        b=urINgrVCifP6dSTmv2YSGxhfclfQ/7CpkCPW8cs0RcE9JdrBejVtvjEWSO5/KVzjja
         t3ZhICvB/AH0YWIGAujy5vVTPzQFhDRvXQzJffeCk9MdH4dACBH+F1j6jbXsyAsNjXGf
         UGwGsMoGYYqlQGuo5m6cz7e1geJtiAoOa1AihaXd02Y0YIgbZS40CwyxJII+diaCKwO/
         5pJtIzI2mo5eIIaXk0SxUFOjk88JHM1MVPF44u+pdU0+OIi8Jw6KJOxKKi745oOIdhQ+
         8OtJQgv3jSxI7n7K3/KOIs2fl+L+IhKEbAHdmAnUBUw/pBgKpjMgJ/foPPGHih10EzCG
         tAXg==
X-Forwarded-Encrypted: i=1; AJvYcCXEG/bDWL0WeYKERM2PJ12C558ukQk+FjZWHbGUDrbw9yGfBjH1vxlv1nqnf/os01xonPTwUuh16EUwlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKS12Qj5DSdFx2w8w99GR3+Cpu0NwWMbeURX+6GHsD5+ApBHl
	0ETSG2kIO1IgyWhiBAWSo2MgTqyUSyxTPXxvyOoUt/ftrparx9MHHZ1qRt08WbW3H08=
X-Gm-Gg: ASbGncsyjZYASg+qS6PK2YT9x1qAaKZQPAw1W3lZ/qIkj1wiaUb7CTceoAhq+MzG2Du
	1CjotOMuNMEHAkGBfrnxtPpSSY/3eC6iTmWetoaSjCkdOa2Ycwotk3gc1mm1gcktoUOKY9RcHF7
	RH9VpDjo3qJvQeypxSYof/sEtufDKau7ySSXCfJgcddra0fm2Q+BXavBVWgeCeXNzHJ5XwJrRM6
	jFnw3kiVDayBQ8WAhQuhNR9ToUuA1/341PmJLszaeWm0CSwg0YdvL/Y6UrkELiMZBsLugqNK/c4
	7tk5knDtPKZZwYRNzme9C83hR7EloHkoZlQ4ChWc8AotC4QK8OyF/SkUwz+rg80MnB/WCnWlVBW
	X+6a0piG99t7Naqpnacx/l4KA
X-Google-Smtp-Source: AGHT+IFYVPLNEA9w3bodw9+YfXXXHlX/wG691OXdZ7TUdqpI2rZ1DapvCar4yq/2nhje8ygl3GK+kQ==
X-Received: by 2002:a05:6e02:1448:b0:3ec:7e74:36bb with SMTP id e9e14a558f8ab-3ec7e7438b4mr206664125ab.9.1756397187718;
        Thu, 28 Aug 2025 09:06:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c191f23sm111747185ab.16.2025.08.28.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:06:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: colyli@kernel.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 Coly Li <colyli@suse.de>, Coly Li <colyli@fnnas.com>
In-Reply-To: <20250828154835.32926-1-colyli@kernel.org>
References: <20250828154835.32926-1-colyli@kernel.org>
Subject: Re: [PATCH] bcache: change maintainer's email address
Message-Id: <175639718595.484892.13913272754617595641.b4-ty@kernel.dk>
Date: Thu, 28 Aug 2025 10:06:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 28 Aug 2025 23:48:35 +0800, colyli@kernel.org wrote:
> Change to my new email address on fnnas.com.
> 
> 

Applied, thanks!

[1/1] bcache: change maintainer's email address
      commit: 95a7c5000956f939b86d8b00b8e6b8345f4a9b65

Best regards,
-- 
Jens Axboe



