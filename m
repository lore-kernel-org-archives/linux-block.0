Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18981C144
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729345817; cv=none; b=H+ZnF0grTHQ+0+ejOGkBL1FHI7tICS2fZZqqM2MmjS2RbwMOvGM9vAI+BBMLnUtcKzUIDgwuo6M/CUXL56n4HoWW8VMiBaNoUKn5FA8FikturA4sL3g8uDWZd5Bglh+y0QExKK2UQofaKLTh/O6dI0KMLDr7VnqRyFA0TBKLfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729345817; c=relaxed/simple;
	bh=HeDm8xUYPk0j0bewRiA2qupw7pOKu0qyA3xXx1yBz/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttm+HSXu3By/8kF09QOaALN7ptDg9MtVDrXF+KopCmzmqwAOC1H//59Raw0S6YyPzLxWcIb5yFw/6VbP8xl2c4RkUFPJ/di1ZLehooRyw2qvMGZ7eTel1QXGTBHJ60xPa3tpDHNGZxzUzj0PsqqIpe7gJcp1oRhvdVZFziM7VNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aauzC1wH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aauzC1wH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2310078a91.3
        for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729345815; x=1729950615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9LY4UYr+6urT3mi09BYM3hDJ2nWuWzLfJ1t9kZVmEw=;
        b=aauzC1wHX58miyM3vUyQLTTOSylap8rPX8954u8zgJeX6jB62eEYToeVghpRqw/abB
         3gQ77pVERBy7lNCwv5EEwf0sJIqdf7hMmZ26DBIxxPYocu8lSOP5n7HgGBT5myPjBS3p
         MCjfqQWOJFrm9ZiAqm/59KitTLnDTr7YLL8pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729345815; x=1729950615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9LY4UYr+6urT3mi09BYM3hDJ2nWuWzLfJ1t9kZVmEw=;
        b=dVe+Dt3xVo9kANBdbJ9+k7P44ep1Yp3KchDxhLKzuua0ZsefjQAYnhF36NshUmeb2X
         TrVPWpebqm6mdAcVUXES1F6BXG8gqynoLUUBpxYfaGTfnaRJmQVzxl/1+6KbZTl4pPHc
         3Z+yfh5RogQ0KTVnINg7ALHfOAA6+bkolR/ykab1i8F3o2TPPuPXKTI0oUIYQIU+XM0D
         fQEmXOegbPqz373I/N4EyHCivivbRUm2NSqpuLt4dZ0NAuttfpeCNYm7anuQp9juONm9
         2O35A9ZBckWkF5zdFxdsmITtWYRpmwM+5EnuxkyE08OQKff2Vti5sEVMi3Wjsc37vDFJ
         TXDw==
X-Forwarded-Encrypted: i=1; AJvYcCXlO+5Wn+86IXZb8KNgiGLPjrchPGlYQS4iKuzY5uCxBoKXYe+C53s8LTdvuJd9qsMcyY7MOZ002/S7tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWc5PG5TzMo4k8s+gT0mIrMBTkfKkkgMKhg6Vj/MRLZFsy2cX
	teokmfSWNC/p/pQnCoPGN3l0J2Auwhag/hzxzxtc4w5EvYIrLSNN24LOggR6Wg==
X-Google-Smtp-Source: AGHT+IE5nh+NX1vAZwYNJAEhn1SiCmeyE4oMKEiNniaOHZAN6tm6gZjWgcnpAj0sYJEf+ek4jJ5ifw==
X-Received: by 2002:a17:90b:4f8c:b0:2e2:e2f8:100 with SMTP id 98e67ed59e1d1-2e561a01721mr6692879a91.38.1729345815271;
        Sat, 19 Oct 2024 06:50:15 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4f31:a9b3:f4ca:dea7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d792feasm4281642a91.8.2024.10.19.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 06:50:14 -0700 (PDT)
Date: Sat, 19 Oct 2024 22:50:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241019135010.GG1279924@google.com>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
 <20241019123727.GE1279924@google.com>
 <ZxOrGeZnI52LcGWF@fedora>
 <20241019125804.GF1279924@google.com>
 <ZxOvfpI6vgH5oXjg@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxOvfpI6vgH5oXjg@fedora>

On (24/10/19 21:09), Ming Lei wrote:
> On Sat, Oct 19, 2024 at 09:58:04PM +0900, Sergey Senozhatsky wrote:
> > On (24/10/19 20:50), Ming Lei wrote:
> > > On Sat, Oct 19, 2024 at 09:37:27PM +0900, Sergey Senozhatsky wrote:
[..]
> 
> Then we need to root-cause it first.
> 
> If you can reproduce it

I cannot.

All I'm having are backtraces from various crash reports, I posted
some of them earlier [1] (and in that entire thread).  This loos like
close()->bio_queue_enter() vs usb_disconnect()->del_gendisk() deadlock,
and del_gendisk() cannot drain.  Doing drain under the same lock, that
things we want to drain currently hold, looks troublesome in general.

[1] https://lore.kernel.org/linux-block/20241008051948.GB10794@google.com
