Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51A21ADB7
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008478; cv=none; b=RcX05trYbZfC5KLqLIkBGUHcIzxJ3mq5Uy5vs7q9pjxMjc+kcPA1MupmT/lWoOa8nxLH0HU5b9KWHIQe3GN6ntUIuddx8o3ToWRy6fntekU2nwE+DeBv64XWyBVeLz5PjY4k9ICzLSwyeyDop5SIBYomVmH97UHvhZgGB6V+wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008478; c=relaxed/simple;
	bh=wx0LqKlXVv8c72e871dc4Fp+9Lt/Vb3P1h0YRmNbohI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2Ltx+hhoVXewLexrG8n9UIUX+W1GIzVg/yIxbPbIcye99Rdiq+AMKiG1oOJOWSqHh7Me/J4VMa7AY6fT2FD6exdnQpJmSt4NU74GuATfiNYqkManeafbyJYftNuOMjgJ7zr1v160Tifd95DrA7godd7S3/ab8OePLmPuWdK2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NYM52+wS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NYM52+wS"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3122a63201bso1495048a91.0
        for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751008475; x=1751613275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQQGZP8E3Mk3yAfl5AsQy1iQwJzm3BFEFB1Lc1DUr9w=;
        b=NYM52+wSWuUIInGYzhFsHmjTbwqNkiUcRyYdt/a12FDjPzHT4cvki6J3Ef9pgROLSm
         3DwOXTT3f0VcSGhpAf3N8u+nL+FBCPuck/SQKrmG0rpShEEni0Q2s9edLCiptc7DZTmu
         YDxNApJXC2jyj3sW3K1Yi61FRu2w3eVCIhT3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751008475; x=1751613275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQQGZP8E3Mk3yAfl5AsQy1iQwJzm3BFEFB1Lc1DUr9w=;
        b=WtVCJvweTgwiePrGrnagPSf1peTpIBzlXOT7KzIqX7Wlqa6EN7eNeZXiaUiV2puB4h
         FG+clRkh8zo5g7JGjwYd+3B/mHTEgx1y2xRBCkl+chS1VKdBCfNgpfdrnZH0lNP0XyEw
         iUC1mBHFj6yu4xPP1eDPvsN7MY/r59n/DwsgWLzkfowLCY7wbmIGPNCZSJVcUf76EBJg
         ENs8wWN9KZTOM90yEMOpgSaBYDHe0KI0ypibaQ3SC6WiUnFn4JyVhOQ+hjGmArtPUApI
         Zy/LONrN4XtARli3BpxPuKIJL/yPCRoILOdEokQxPCcUfZE3lVpJ6ki0jrYIuv3o2sE7
         SD5g==
X-Forwarded-Encrypted: i=1; AJvYcCXln9tmsQVF8MCq5ZUmrmjWL4xFU9+t607V2BmpEvQYfpwNVg7ho3xdWb4i+3piSqhcphOQNo3C9Aj65Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kT7oGqrHrI0PERwHTQwDUsp+Jcwl5en5ogosL7mBxzD/PJ3V
	03N3ClQVkJO5dTIybvQncUaGTBhctt6Jif3SZRIqBASohxpMYvUSyIZf6g+jelHzeQ==
X-Gm-Gg: ASbGncu03ryeMnsxG/0hLy/b/NgCRol5nREn7bccPMkT7/Y/TUsFQwQKciiCbru1G7h
	xYbz74owp+KhYom8XmuLZxeM2oLqOInNYw/+nOGSpfUk8IlB+JcgrEh1X3WmfPIU76EAO9AXAhW
	pL9Fr4eCKBXo0tWs0fsZQzQDzSt9WHj55DkMJUDXDwgO5mvwCTpVWhojJPr+vixHLTC+NhpRWcn
	GyjwTBst+6ns+3L2Msic3CBzeYv8GogxZiQmPqQ0DlZck5icmi7xp4OWV2weYHx2ViHxG5QLlXq
	qwiuzVPv2FfYKxZTqn25IoORzs/33traQdW1smyMDZcMyXAW7BiI4dYrT13ZVyyE2dSPxAjheeM
	s
X-Google-Smtp-Source: AGHT+IFEeMckAwHl2Wie4Br0EJx5o3lYirvV/GsaZHYr3pkQ1uZ7EgbwhvZytiHcoLlJBTmyb7T0Sg==
X-Received: by 2002:a17:90b:1844:b0:311:c1ec:7d0a with SMTP id 98e67ed59e1d1-318c92ee554mr2959524a91.25.1751008475565;
        Fri, 27 Jun 2025 00:14:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de1c:e88f:de93:cd95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f539e69fsm6373395a91.11.2025.06.27.00.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:14:34 -0700 (PDT)
Date: Fri, 27 Jun 2025 16:14:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>, Rahul Kumar <rk0006818@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH] block: zram: replace scnprintf() with sysfs_emit() in
 *_show() functions
Message-ID: <2tckds345fhwxxxfjxsvbvktz7tdnd5mt7yvksoel7hpq4qewd@3uubp65rld3d>
References: <20250627035256.1120740-1-rk0006818@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627035256.1120740-1-rk0006818@gmail.com>

On (25/06/27 09:22), Rahul Kumar wrote:
[..]
>  static void reset_bdev(struct zram *zram)
> @@ -1292,7 +1292,7 @@ static ssize_t recomp_algorithm_show(struct device *dev,
>  		if (!zram->comp_algs[prio])
>  			continue;
>  
> -		sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2, "#%d: ", prio);
> +		sz += sysfs_emit_at(buf, sz, "#%d: ", prio);
>  		sz += __comp_algorithm_show(zram, prio, buf + sz);

Actually, there is a tiny bug in zcomp.  It's unrelated to this
patch, but I'll send a fix as followup, to avoid any conflicts.
