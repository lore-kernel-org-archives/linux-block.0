Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA82AF11
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 05:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728450254; cv=none; b=ecfzIQ79TOYRQOMgQAEVH2yYZ5BSYr+VxUuUuCo2gaQ1OQrXjfA613jTxEjADfdTViToXgJhY2qQQjPNeaBt5R+nJtxtS8+Be8xOHwWlngeapISnGIbvE73TzOayTpn1+SEFUxGw/cR3MmX1ho2lreEO3O3XJ1N5lP/P2t15VOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728450254; c=relaxed/simple;
	bh=52KBBC52D78DNpGBpcnSpdt6KLtWG4ZYzKwTsQGGwgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyBnCS2FAgQQjfS9YqOts0puBDlTwQWCL774jnYHfucEsZu3JGoN/R+nppy7ioJL8EhiU6COGrEO99ebcKgfjXLDEgc34OuXv1jeegkn4LOD0Zgq2I2WeyMqfZ6vD/w6ZCpI3WG5E5NbeIvq/0uEAVfsrRu2nk+PKFWYSk7xaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YGIqp85i; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YGIqp85i"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e0c3e85c5so1938101b3a.2
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 22:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728450252; x=1729055052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=59YmhJj1pQFCTTUfYWVg8bSAebSY+Euin/8lLtPee4M=;
        b=YGIqp85iWCktB4TeZLQsFWB+uaCD5xaYitW/uzfF2TKRMpODlmhOOYDMQd8raERtSI
         qNdy2OO3NhJBRflBDMobqhpSoRtWnngG4LuoKtzaDmnuJ/1HUwFBlHqLyo7A5492c4F+
         kPBILglTlhsjjZafiGqEkVAj9a9FngdHhTBqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728450252; x=1729055052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59YmhJj1pQFCTTUfYWVg8bSAebSY+Euin/8lLtPee4M=;
        b=PlalZJ2+d2QFd5pOIl+04V0eI+bC5hEv89g5kLc1PcE05pbtyNhLCs2kDoaabRioN5
         Z8Fp+8PnYUWUOAecLkqIj9nYLheEdy9+eH4mb1OtA2n744HGCO5QZoZ4oKvSShSdbDbU
         Srq+9sGdSYO/Uphn51Guu77qC6Siq/eRWTeJK2BCBxcdlEHJMyZmf5HVTGhUyZZG5nTq
         BIUS8DYta7s4gXn5XC/om16GFz3lB6mmfuaqiCAS+lthJ+8iJpqNrJDx4iCwz1UqRoxE
         KQJ8Cc6Fq9DcS9d3F7uRpAYhZrz1cO0foauPsDeCKuOociqsRxX2BwP3EX9ITRCjb4Uq
         zTYg==
X-Forwarded-Encrypted: i=1; AJvYcCVXHXIISS1V4kioXfRar/MnStyh+AgAm+DSNKr6EF/k5kBtATzjthehmugUQWao+E9jFUvNaUDyF0wOmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEahMKQgP7GcBat2lxOAGaxpNt3fVy+ucWmVh4vt18AK59qCU
	7bbqEH6CFiJ4D9lg6vXizNGQvYsVUCmShJ+izJYvJ4IkTJK1SCZ7XS0G/R6Pyw==
X-Google-Smtp-Source: AGHT+IGv+O0Xxi/f7walYhBQeBYNsgzDYdS7bwnTuNHbNahed5InkSavukSQEDmsEFhJNnLUsoCuKQ==
X-Received: by 2002:a05:6a21:30cc:b0:1ce:d418:a45c with SMTP id adf61e73a8af0-1d8a3c5bfbbmr1549923637.50.1728450251666;
        Tue, 08 Oct 2024 22:04:11 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbc725sm6984736b3a.31.2024.10.08.22.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 22:04:11 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:04:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: mark the disk dead before taking open_mutx in
 del_gendisk
Message-ID: <20241009050407.GB565009@google.com>
References: <20241008115756.355936-1-hch@lst.de>
 <20241008115756.355936-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008115756.355936-3-hch@lst.de>

On (24/10/08 13:57), Christoph Hellwig wrote:
> Now that we stop sd and sr from submitting passthrough commands from
> their ->release methods we can and should start the drain before taking
> ->open_mutex, so that we can entirely prevent this kind of deadlock by
> ensuring that the disk is clearly marked dead before open_mutex is
> taken in del_gendisk.
> 
> This includes a revert of commit 7e04da2dc701 ("block: fix deadlock
> between sd_remove & sd_release"), which was a partial fix for a similar
> deadlock.
> 
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
