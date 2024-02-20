Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF267C6A
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431371; cv=none; b=g0Pz0nmxVjNXG2FmW0iWRE/7FIOvPndKgRo5lMx5qo+PTYgSEHm+2snvLZwaYZjmIZ492fabmOgwdwAS6NTBfi/bFjiujMDn6bWZzHcDHWMLRqticyP9t0w+B6Jj7QnNOi33TubJFEbdAvNngV6SL5wmZZSWdhrcGanNmss9pnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431371; c=relaxed/simple;
	bh=9Cn3UBagmDs/qlAaKr+ErLKGFbFXtl92H5uvB8XU0o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9JxStMDUaeS8qnuEq44lZShIT0KtpddUf4nKIhj69OlTkYCUolV3FKW4IfQeNxAoJFwOVCX9XHXU2kad6yhDPEFvGBbYP/iU1VtJRzC/kNUqC3nRENTNURjqUWPufeNloFp84qMKjOY6G/Zo6EDonECsKDqKl4aYCqqU/Jvmzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=O17RsbGY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="O17RsbGY"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512a85806fcso2998481e87.2
        for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 04:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708431368; x=1709036168; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=knwiP9OAWZECA9KKubxtxSMpv+I26MM185zuFGNZSsA=;
        b=O17RsbGYXjblegUBOybxW2neSaYYWEjDxKyrQd6XWkYD1NFEYe00ECdUeP4YVWrLu2
         CCISWpXe7hFSf4b3v3DFuzFmiF4jIjRuTOtRvpruqMopCIVsH2O14Ll5l+2y2dNyxImI
         /nxSWpBZ0oZDze/yDR0YU1WhhAbI0Zq3POFQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431368; x=1709036168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knwiP9OAWZECA9KKubxtxSMpv+I26MM185zuFGNZSsA=;
        b=FEejaMWGHLhrmPD/y0Q+Hx+UUL/fAAUsVC9BIExXJuc4aO0keNZQ3ha30wOitTBCm+
         BVFlxYs2Y66H+/C1BhWPomABnzBCZbDxdQx6ba0uYwUlZcz4MEh/UKTXWrXCbJO308tz
         PWQxfQIDEbMMcpMZNu2HskqUOd9MXhc+SnNxNP+KlbM9FP9GpqDTxbHhI6t+1x3Qrajk
         t2rJBJOzKJ4gR9xTA/yzcOT6PwE9dQKNJ9IObDVkbCdPGuOTbATGqZ5oI1MdrKgCl7mo
         ngcWqS8UyZsXtDiFHAOp8FHhGFVE7g2lNZA38RciMXWPc5Ko5U4OLhByLGmOz77EoV5h
         gcTg==
X-Forwarded-Encrypted: i=1; AJvYcCVMP3jhoMbgk6PRaEqOfCtV+ZYANpgDh1gxhpOc1TF6bI97iBdZVcG6E+v0uuaCsNOqFMaG5o6tScPQjJYLMq0Cd3+M5vnyKIpJKrc=
X-Gm-Message-State: AOJu0Yw7MhZ3Lg/2ByHKYK6ozsFD+KEbO/3eLo4/fRbRERDI7qV3fhUV
	+065nnb9p8LvRKNGUIB9RJ9uX9MIZzMK9T2hAqWrATxRlfXVYxN5EmZkNZLRoGM=
X-Google-Smtp-Source: AGHT+IFpY0vxmPHLW+oy/ASL3Cytglfrlsy0I7GgUOvlkTMsZmHHJteUe3+LWEIK13qALwuImAYeVA==
X-Received: by 2002:a05:6512:12c7:b0:512:bae7:30f0 with SMTP id p7-20020a05651212c700b00512bae730f0mr3484188lfg.51.1708431367923;
        Tue, 20 Feb 2024 04:16:07 -0800 (PST)
Received: from localhost ([213.195.118.74])
        by smtp.gmail.com with ESMTPSA id mf18-20020a0562145d9200b0068d05b81fb2sm476529qvb.15.2024.02.20.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:16:07 -0800 (PST)
Date: Tue, 20 Feb 2024 13:16:05 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] xen-blkfront: don't redundantly set max_sements in
 blkif_recover
Message-ID: <ZdSYBQB-F1CwjoHN@macbook>
References: <20240220084935.3282351-1-hch@lst.de>
 <20240220084935.3282351-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220084935.3282351-4-hch@lst.de>

On Tue, Feb 20, 2024 at 09:49:34AM +0100, Christoph Hellwig wrote:
> blkif_set_queue_limits already sets the max_sements limits, so don't do
> it a second time.  Also remove a comment about a long fixe bug in
> blk_mq_update_nr_hw_queues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
