Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0A63D5
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342691; cv=none; b=s6PpQWI8oQno7kLjMStagBpH0/Qe644rCL9t0TbfTsta0GMjo0qK8fuD/623V/Au9cxUW+t5o4NRjQQnAIyMDx/Xa4xZFiUhsn+diPZuiqwi+ZE9hUAGPJiFc1QhLz2XkXAAiKZByhW3nnq7gQegGVjlGuCcKQYZSrIsDlzbEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342691; c=relaxed/simple;
	bh=qVNG3h7fwnkDGoBvJSidDIh2Id1/BYsbkmE+Gpr//CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcxlmngnuuUrnBa16B7dL7+ZXpMWV4hZJC7zSFHeNb0Eb6byqCogXehC/fCdkBvNW2GiASdzeRgfqVmBkcjUhQYxtruxuT8EJavnYDYlxsaWOjtbyaGC8oyiS6Q377vAevb9soTeaDI+6cCGhbPfFQN5nTjUaLS/uGUEFFO2S8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R3l9R6k+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R3l9R6k+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8c50fdd9so26598795ad.0
        for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729342689; x=1729947489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1+Krb8JUAScTM2OBqmTSBCxzoFbFZfHApVtK3rfZ8s=;
        b=R3l9R6k+kef4sn4N/7PldJh8Qsh4xRkh9aK6W1+8oHufDNZx/c9Sq1oYsuN1BysXC7
         Is6GSVOCBc6Zv0C89eh+ipOrq6bCRED1T/igInHHJFGqmt375hjkuuzxOUP3+5FSwGHd
         QjbqjO0KUta3GiYpQm07zd2BmrTJKP8AdyDiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729342689; x=1729947489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1+Krb8JUAScTM2OBqmTSBCxzoFbFZfHApVtK3rfZ8s=;
        b=A/waCFMQxSnQ+LNZczeL5bBTKnwd2+ydW0fAPWfO87Xlgb7Wb1BnilH1PFaHV0+lPa
         LwNRV+ZKIUmCMU9gOOtPSQTOMbAhQo0tZ4kkFS7ba6jt69NQFD9hFi1w1zHoO+3Svd89
         iTqZOwx7BQKdjsTuCzqN2CGwOF9zPhdM5R50H1pjh9KLmQsFgruFbGFAp3Mj4xSVsA9n
         VLfFhVd3xEN+FZCLjXskGygtLVXZp2Ew6j1YMOBIJBxEFHl8GpbkeN+paCsgoFafnkTo
         YXcyrGi08D1o62CP4RcPwh6YocxNbzhzj5pgqMHLgR5TAIxCwSzzpUVWY2MP9hFyxSBm
         hXqw==
X-Forwarded-Encrypted: i=1; AJvYcCUozMRdm/r2214nDRrRiBuOnrjxMCU2qa+N4pQ7AYdr3lDYQ13cxvZmiFAxez8ZdB7apXnJSSC3dEkXgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMnMWUDmnSkE/r63FeaLyJ85F3IwqDJAt7I/78Exaf3v8bhqs
	m/vFetDsD0AMGrqJ7XCF2Hww/vxXGPPhwNpFUQTxXcPddCyuASgPj2E0IczjJA==
X-Google-Smtp-Source: AGHT+IHem561svfvMOHxGoKl2sGSXhLp4htOwOsiuZwJJughHBueoz3HNqNf36EgfKBG5z7hdUxbhg==
X-Received: by 2002:a17:903:2311:b0:20b:5ef8:10a6 with SMTP id d9443c01a7336-20e5c10be2fmr84937705ad.8.1729342689063;
        Sat, 19 Oct 2024 05:58:09 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4f31:a9b3:f4ca:dea7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a90f243sm27370545ad.259.2024.10.19.05.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 05:58:08 -0700 (PDT)
Date: Sat, 19 Oct 2024 21:58:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241019125804.GF1279924@google.com>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
 <20241019123727.GE1279924@google.com>
 <ZxOrGeZnI52LcGWF@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxOrGeZnI52LcGWF@fedora>

On (24/10/19 20:50), Ming Lei wrote:
> On Sat, Oct 19, 2024 at 09:37:27PM +0900, Sergey Senozhatsky wrote:
> > On (24/10/19 20:32), Ming Lei wrote:
> > [..]
> > Unfortunately I don't have a device to repro this, but it happens to a
> > number of our customers (using different peripheral devices, but, as far
> > as I'm concerned, all running 6.6 kernel).
> 
> I can understand the issue on v6.6 because it doesn't have commit
> 7e04da2dc701 ("block: fix deadlock between sd_remove & sd_release").

We have that one in 6.6, as far as I can tell

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/block/genhd.c?h=v6.6.57#n663
