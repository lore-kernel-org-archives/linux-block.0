Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDB218845
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242349; cv=none; b=t2Ct+qlaqJm5ZBVQAgLBQJN/oYun0FkFtYdTqRwTJzdoq+j70+6DllrB5OsKc9I6/U/ro+RTnz+qETV9cad7KDNuBOHkOEMMcD7kUy0LIWEX/Moa98lYPx0ZUKZExDiiut7kYmMmdr6YxjJw2+gQpd0c27+u/xMhP23t9V6mfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242349; c=relaxed/simple;
	bh=hKrRe9Gkr9FLh5hkkL44NiOyyzggZpgD0UvuoWxV5Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apJlP5HSIvWi5pgDhplURis72sFejls2fwuJFjZE+QQrJdHvTAAQ5lH3MmA3CWzhZ6TPP4Xlf5Z5k8ax21aYBybfsdxKnf7gc2Hrr7XhzSYREC863crVc/pkpOwflP2uO+SlJZDic15kwzncCxPdfO6cabyMu4a82WxOw5hLXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=curJttDu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="curJttDu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488c2690057so65291155e9.0
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 01:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776242346; x=1776847146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uiIgsRprakARIWlZaS8OwEXNRL+oY0Yv6SrAxGX3csc=;
        b=curJttDuXvd3UyObRlHIZhC9mTKtrgQlX8VMwjQ4NFvhytB6Lfc65Yn9xcF2UrcZYm
         wzGl2uArDqTXZPln4jvZaMlS+GkK8tOmSmzNMVqK6pShZxPnGR8l08PD6ooNAVmo5vJz
         Ym+X93KlCkdnq9dLm2zKHlLbGWx7wakN8JaGgkzrzqhP4x/lTgOSKXsAMFEnqNiqTMuM
         tTSVgw9QCZCY53MeJJxmCYq7BIEzjaHb8CTsJs5IUMc+uQkD0r2R00BznguYXnW7RorW
         KWuXFKtUfJwIfw4W+SdhqNaynv7oekub0J0ika+rr6bN7CW1u5VnjEXMUTpGxqK7nyXX
         iIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776242346; x=1776847146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiIgsRprakARIWlZaS8OwEXNRL+oY0Yv6SrAxGX3csc=;
        b=fwl95+WcA/rY+qq31Vt/dJ4wn+mrk0eJG/lwhXrMdHMi3CZUMcssVcs1jETq+NEJbx
         Hq+LITPNAY39XySL/00KBjc3LOgYo1RpUKDQUWPgMEZ9IjPf3AnmAgco/7raQfHD6ULE
         5ILhszSGd4dpmIw4ZICEnxM98EOJiCte6I2VIzJriUDJcpiBTl9j6jia0toiAFejEiZt
         OJEf0NupgE75kZ4WPojcqTkmI47NMyZFBeUpv1KdZynvvOVaCwvSJe6+ahJ2PaflzzDc
         CYupXR+binJERcA/F25dfmKr0eDi9BcKm7LpZ6xOJaA9+K19ST1ZR7W3K2SeJreI5wy1
         TQjA==
X-Forwarded-Encrypted: i=1; AFNElJ/68TgMGtWhWWn6l/Dvqs8jsMW227CO74qxVzspVEnH3o9+kl/87jfdNpJrBdAYwJiBbRTScN7HcBrIFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgknMsc7TLus+tdr9FMVc2dfR04jIDo5Ia+ej85KE3VxYNWB/5
	vYbLzoIRAf4EFq19lpoE1bItRUKxKI4PBvaMZ0okx9Daa314ReV/opi/
X-Gm-Gg: AeBDiesMEJR5QYuSNoFZs5KaizH0KY7hHeCa1trKu/vymUN3cHF23EQBylyPmRSzaE/
	6jGSSPMRhElcoMD7rDZ9gUGwXEprVD0/l14JaTD35ywxCG5tDhNBiYaE188eZSck5KAAIl6Erb1
	jIk+xxPkW030zBKcjJYFH606oe+gJVB6wqGrR1iiUw2X5ik1WCj3RGuhVvf8rlWt+1u1s5FqA4y
	9TXPxpHIndIQtmbTAboHTAZZ+aL6zPJ5F7KcIY5rX7zrd93MzKOSQKVCFKfXnHbP6/UDsTMOn0j
	DYYhY38JYiWYWAakmm9pCmr6o1JvkccWN1qYwpjwK/RVIiYnahl+pryfWMrJuHXc5QylWN3SVAq
	4iMTtY/VnPHNs9b30Bf3U065+FFT+SrmngV+H4RINBVrj8TYASebzma2NnGOfHvl82YDjruNoGN
	81eqo3cghtxbzZtei5AJOqbQdcYyN3BF9eXQ1AoylDtPbaw8lTfgZO
X-Received: by 2002:a05:600c:4ecf:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-488d68685aemr294277755e9.13.1776242345566;
        Wed, 15 Apr 2026 01:39:05 -0700 (PDT)
Received: from fedora ([216.131.111.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9ad7csm14366185e9.15.2026.04.15.01.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:39:05 -0700 (PDT)
Date: Wed, 15 Apr 2026 16:38:59 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v2 00/10] ublk: add shared memory zero-copy support
Message-ID: <ad9OoyLh_PG3swz5@fedora>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
 <ad6N4JWaeSGgt7Mr@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6N4JWaeSGgt7Mr@kbusch-mbp>

On Tue, Apr 14, 2026 at 12:56:32PM -0600, Keith Busch wrote:
> On Tue, Mar 31, 2026 at 11:31:51PM +0800, Ming Lei wrote:
> > Hello,
> > 
> > Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.
> > 
> > The ublk server and its client share a memory region (e.g. memfd or
> > hugetlbfs file) via MAP_SHARED mmap. The server registers this region
> > with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
> > builds a PFN maple tree. When I/O arrives, the driver looks up bio
> > pages in the maple tree - if they match registered buffer pages, the
> > data is used directly without copying.
> 
> I feel if you have the ability to change an application to cooperatively
> share memfd's with a ublk server, then why wouldn't you go one step
> further: use vhost-user-blk and skip the kernel entirely?

I understand vhost-user-blk is backend, which can handle UBLK_F_SHMEM_ZC
in zero copy style too from userspace:

https://archive.fosdem.org/2023/schedule/event/sds_vhost_user_blk/attachments/slides/5444/export/events/attachments/sds_vhost_user_blk/slides/5444/stefanha_fosdem_2023.pdf

> 
> The value for the existing ublk zero-copy setup was that original/legacy
> applications didn't need to change. Of course it has the limitation of

Yes, this patch just provides another choice, and ublk server can choose
to use any combinations(page copy & shmem_zc, existing zc & shmem_zc, ...).

> what the ublk server can access, but if you're trying to get around that
> with cooperative clients, then why not go all the way? What is ublk
> providing here?
 
The change in client side is very small, also lots of applications
pre-allocate IO buffers. It is one **supplement** or optimization, which is
fast than user copy or existing zero-copy, and more friendly to handle than
existing zero-copy.

If any DIRECT-IO application wants to take the optimization, the user can add
the small change for triggering client buffer registration, otherwise
everything works just like before.

Honestly the optimization is inspired by the lsfmm proposal "dmabuf backed read/write".

Thanks, 
Ming
