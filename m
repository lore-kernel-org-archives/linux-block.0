Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68191B1D61
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729301148; cv=none; b=BDBPxXkiJy0vcLiDmIMI8aWjDy5dbPMI6p5loKiINUKzYQb1NDVoNwZ1Q+wfQxOnRm5/eMQV+XNMT2E+p9LJwACTeA2HHUNX4YxM/v2iLpkbIfaM2C1xWYofHi62k1Iu4ZGlpPrhwpy+yR+mD0J5balF2LBlOEnY8aaOM3cVUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729301148; c=relaxed/simple;
	bh=75V8MqUjNwnSU8f1oeiM3qYWYyFhe4SNrhQVucK2LQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdQSn9TDmND7eU8pSZriJeIO3CFI7aWZxzr6XbUxK5PX/KPFVuJpvRKsay9HIQFdoZxj1eK0K2PhpAxsJkFFJvgujxPIObcYMS+t+dIPbIMvCGSHZ/3MFg5aTSGwCiYlPevU+nsasQUZKY06tqlxZwLqlTqeWQhucpa/Z7HGiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZqiJR8wk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZqiJR8wk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so2055598a91.2
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2024 18:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729301145; x=1729905945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnj4HB1ajTY6/DFchE91upIw/+D5y+eay1jNXXw7Kn0=;
        b=ZqiJR8wke1b/xQ2SNL4EvKA3L+CxHlxm+WS3xLQ/ANaNP+tM24jvwKGJsyYGli74pm
         COl1amU5cD2KQ851LzIAnbDQFqI6U/nw5Svkxmg+cekeEY57ka5Oxuu8yttvpQ7iVH29
         677nZGUR9VjMhDB8BNDYW+kAz575sNDogAprU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729301145; x=1729905945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cnj4HB1ajTY6/DFchE91upIw/+D5y+eay1jNXXw7Kn0=;
        b=OhMZUDMVaXcJ0nQ2tAewjURxl6jXxISVOG3qIh1lK51SemkOXn6UWRAKVC5UDrYgIP
         Jc/EGpzhBGYN6TDE93WAC3LqEP4pVeKWPs+bA+gUKOsOVAoG3EGv8X1+l/mly6z1oP0N
         gZv9G5mS6jB8Aq3OfLVpyuIj+/oCaX5fyKhjhiEw/oiSS9x2PniBS2Cgo45/PoyR69u8
         /ZRSJZlbkEsLNLZT+dL3GqM0AlKNmoOpfg62EFRXGrsVuklKOhSCs88h9aabKVJ2OpOs
         v1/o3JVWL8fzFFQCB2BGc+/1yES3j+sNSCjX1TPpU/uF3ol7P9Gy23p7KUxfS51buhRx
         K12g==
X-Forwarded-Encrypted: i=1; AJvYcCXv9sX7TTIjG59sc2ZOwxoSeXjgjPmdJ/YgMfwUbeD5zAT2rpSLVqclOjVYXOzMlfC/FtOBzG5lE5HA0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUi0wyt+kzOkeoeiX/PjWPAhp4wbAoMUfsI3j0GRIBOAIeAero
	XjUr6efGQK1Pz3VfZrdJbj6JDQBnESM5KCBXuJrFGtxhRxpFB29uuvzWr1b1MA==
X-Google-Smtp-Source: AGHT+IGlPDq887rivAqHm4bVAV6wNxA2LxUdKzWQOAcbIupe+HE8HkrYJve1iEZUtd2Kyc8utzgSdQ==
X-Received: by 2002:a17:90a:e607:b0:2e2:b6c2:2ae with SMTP id 98e67ed59e1d1-2e561a01f11mr5439018a91.36.1729301145399;
        Fri, 18 Oct 2024 18:25:45 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e349:f760:c7aa:ea63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d78a7a9sm2904495a91.3.2024.10.18.18.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 18:25:44 -0700 (PDT)
Date: Sat, 19 Oct 2024 10:25:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241019012541.GD1279924@google.com>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw_BBgrVAJrxrfpe@fedora>

On (24/10/16 21:35), Ming Lei wrote:
> On Wed, Oct 09, 2024 at 01:38:20PM +0200, Christoph Hellwig wrote:
> > When del_gendisk shuts down access to a gendisk, it could lead to a
> > deadlock with sd or, which try to submit passthrough SCSI commands from
> > their ->release method under open_mutex.  The submission can be blocked
> > in blk_enter_queue while del_gendisk can't get to actually telling them
> > top stop and wake them up.
> 
> When ->release() waits in blk_enter_queue(), the following code block
> 
> 	mutex_lock(&disk->open_mutex);
> 	__blk_mark_disk_dead(disk);
> 	xa_for_each_start(&disk->part_tbl, idx, part, 1)
> 	        drop_partition(part);
> 	mutex_unlock(&disk->open_mutex);

blk_enter_queue()->schedule() holds ->open_mutex, so that block
of code sleeps on ->open_mutex. We can't drain under ->open_mutex.
