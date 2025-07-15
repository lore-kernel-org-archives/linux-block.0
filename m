Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170423C8D5
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550350; cv=none; b=dZ9fg2wDht+TuMv01SRm0Jxsb+jzQQDSStzBVzIQpbITNJFv+vkyXDbLq4tl2NM+aI635aQ3wj06fryXS4kKBSDzbZ2vIqwaqrUwR5iqpM53lpSNYHnG6szLolHYOTICk2opgP3c0p5pvO4hDIDw2JxK8QD8nvd6TakvV9N8d8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550350; c=relaxed/simple;
	bh=G/6Qw0QGoAHpeXel4/1om42k7CxgpeTGL+SaD4Vk6Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvzrSpMgdGqaQjZ59mGPOOBTS7rp7zkXg0x/DOSVmL/H67yHxYxwJa2Rp63nDa8+LaExiuipqvOeltZ82QUIwYrvFMNE2HOvqdbq5nFwxbHaXWLjvRe0YcWGKEwdzfPsJrjZjuJIg+vGkWYIiP/022WMbSlrgvPSC58J0xySI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zd6KwdYN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zd6KwdYN"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b34ab678931so3643990a12.0
        for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 20:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752550348; x=1753155148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wmdNxnEk7VZie3FE0SOO36LP3Yv8yGAzJzpW0/szP0=;
        b=Zd6KwdYNpsyYPCr1aHzzFiQo72thnB4ar23zKi/2/sC0mvN40QZj9JrUT65XP2tpMi
         nrOvoqPYpZRW2/B+eR9h21SZLkIwS10dGQ3GgEJE/QkYW7oC9L6o3fa+BmHPbMzGnfyA
         jzgG9rj54axqWN0i9qio2PYAiFwFkJfZXiNxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752550348; x=1753155148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wmdNxnEk7VZie3FE0SOO36LP3Yv8yGAzJzpW0/szP0=;
        b=XlTY+3e4XEp9AuO/qRlU/XCR8rkTv3rTEUIbJfwa47sVGdcYFg9BKiMXVSLv44z8Wd
         g+oR5kUJRxfDrN+jSonI3HvMB/crrnZdJbqvNUyAvfrit9OUGYpX89Y1PvS/npiBcLfy
         utH+hJvh75l+zZEGvFiINmjQZhdnVSoaSK+1BZCYdgPdmrN82jouFWCP3gPZ5oK5sjD6
         5PUTiBIR37ujc0lNSSRN9NOVNThsEnYM2K754nYgSagR/psm0efiCPOW/lxcjkE4wPwU
         90Wi3rGpA5bmNJ7pkbZ5kecsHm8rFRNkER0YHvbtSiGJ6wdGD/qDxQT8UmA376a84Fu9
         p7HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFSqL5o9h2QeI2EMms2Su5EH7v7RAwSJvMQJg3lSFCPICVFYhbRal0hYoKeiHDZIttEPSsaw+JrPdAIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Ug2hwIBkJko7llcsQn2vhv4/2+g+38Wf6U9v/yDTEhJn0l6q
	D9Yj/OzDyvszTgXjsMWT9vC/stMwymoPUpCHvT+MqIaTKO7oemXNgy/3S3XcFtPHj61eJ6x+9MP
	KX+s=
X-Gm-Gg: ASbGncsmiBL6Jj76wbWr+3YoQtncp45goHnNoCAG4BIIndQNh10P7DrfF25sxyyqxOZ
	RazHrniYjfjRNXiHbLqhHXRUyD4H9HvX7/TIcJ4EwgJfMQwcBsDl/dTF6i37qbAKj1aX3jiypd2
	SOS3fNdCo5aGhrAcx6Rn5VZ476Vuf3s1ShxYJMT08iYS25Tpv7cmNX63+46q3Y+mrabB4elbDoV
	gxDVXNdHYe/mPFJPZ4ilJKRuadF/TYL2Etl7L7TFYepKcqhr59OHbIwKstaNMHFhHNgAwCoUyGY
	VYA10xdiralNszW5mJ7od6Zoqo25i5+C2C8H808PgaC8/3tmTvRQxCbNfuFzvCfWuQohkZYjSAl
	8YlSJ/b9yDRxilOIEzgyTOmU2xQ==
X-Google-Smtp-Source: AGHT+IGLTlrXC7/42TJknf9kXw9iX3FUKSUyJl557MuswCc1Ra7jelj5beeAq9knMgSor25eYQkwiQ==
X-Received: by 2002:a17:90b:578e:b0:311:e8cc:4256 with SMTP id 98e67ed59e1d1-31c4cd6303dmr21844455a91.22.1752550347853;
        Mon, 14 Jul 2025 20:32:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3e3b:c5a7:1b48:8c61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9159ec07sm305695a91.0.2025.07.14.20.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 20:32:27 -0700 (PDT)
Date: Tue, 15 Jul 2025 12:32:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Phillip Potter <phil@philpotter.co.uk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Christoph Hellwig <hch@infradead.org>, 
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <z64pki236n2mertom6jmgznj4t3dkxeosr56fhpmykjdrnzs2l@5xlhh7htcaw4>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>

On (25/07/14 08:22), Jens Axboe wrote:
> This just looks totally broken, the cdrom layer trying to issue block
> layer commands at exit time. Perhaps something like the below (utterly
> untested) patch would be an improvement. Also gets rid of the silly
> ->exit() hook which exists just for mrw.

I don't have a CD/DVD drive to test this, but from what I can tell
the patch looks good to me.  Thanks for taking a look!
