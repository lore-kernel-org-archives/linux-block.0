Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F665190
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429813; cv=none; b=D6sfIzMoKG5AHt7cFwRP6SJ0MmUAOgtcbAp1HrTb0VVdd9xtnM9Vy3y5gcmPH0UNvggShYiiAlWDCYPyPWAmX/Ap9Xf8hfFJNQIPn2PcAZ9fezOWhVcgE2XrGY3FQVQoCBsL5clhled2cDZzUOGCWBGFGDc622y8iuJX4JomxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429813; c=relaxed/simple;
	bh=bc0S6cIFBA2vA26HXceNFNmVnRSVc2vKRlJ3HDDEU5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2NjxCHcS4cfFBEDA8PJDcytkwBLS8XUWRhzC07g5Lj665vEeu4Xj8VywTD0m4+BsRLapzbDejlTWeaOUgACCfxdxs11kPRVbdd8AjD/ffwmU6/Ir3VbiyyTZLntJb4va2sGgHcY5/F+DGf118gdEPvgmJlB3e2a0pj24MbbAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=sk5Hj+kN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="sk5Hj+kN"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512aafb3ca8so2207657e87.3
        for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 03:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708429809; x=1709034609; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L48l2hpsjGRvCKL00qVAvQZynCjle73QSMbq61LuMbw=;
        b=sk5Hj+kNeqKp0neNl4yP7buVytIYy0v9yAxxU8uI/zFuN4H0LUfJEQw1N/ny7Q+foj
         1YPJqARSiqNqIUNZkdTsF2BO9BqBWHhcM0f+i5/6p9iBCGrZU3DvRsDemchIbyWR1BW5
         A8YSzyI1pPzC65G77VoiW+ANU7gF0QF4Ky0oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429809; x=1709034609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L48l2hpsjGRvCKL00qVAvQZynCjle73QSMbq61LuMbw=;
        b=KSHhoEqBENXEbFTSXDMytzPx5Qm4PYEQpAhYnrYGzXiH7Z1XyREsZb4KmRbT7ENdlG
         OM4lthpZu6kiIDVACEuCSyM9CCgkArLOrD1xWahJU07hw50/hDOAUGqC5B6Ksvi89r6+
         DWSBhr+7Woki2yN0pa8yhLe+LYUpPDYAkr197Y48nv1PLkCGX46lSOyahka2YMmW+L+W
         V7gUl//I1Kp3G01sV1I6uC5m9negO2gRLRZJYjkH7cA9NK86nC7+6Ku7hl07mcsczKZ5
         O0lUvGT1VVXuvvEGZ23E5Rv3jR0DW66dxCwcjkCoo/NNDx50jcecMST5OeL2WJeXr9hN
         LzDg==
X-Forwarded-Encrypted: i=1; AJvYcCVXMh5qa+zfQ0V1QBaCkvGunGEDpCq5ZLphJA+MEzV4yHZhR1Xdzi+P8gCfmtrppttziYOS1fRkNR1EMTTTedVT9BuVyMNuKJhowhA=
X-Gm-Message-State: AOJu0YzpDihGtBjSZWQ+fzaiVy+6DmEpEaA9qnIQttJZz7nOZbbZ2M0r
	gy8fBcQzTtVb05+ufgbV1GLKxXBLDZLhM4gnYJ3JvwBjhA8EFC7q67FT+Gp71hM=
X-Google-Smtp-Source: AGHT+IHUZ8iQeWiuL3aFeiidpOcUFxCSR6QyScwRy5qnJiOguqCxJ4LpXQwdFCaOwM+JubG1vE+kxQ==
X-Received: by 2002:a05:6512:1088:b0:512:c9bc:f491 with SMTP id j8-20020a056512108800b00512c9bcf491mr971397lfg.47.1708429809506;
        Tue, 20 Feb 2024 03:50:09 -0800 (PST)
Received: from localhost ([213.195.118.74])
        by smtp.gmail.com with ESMTPSA id b7-20020a05622a020700b0042e124c7b17sm1679254qtx.60.2024.02.20.03.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:50:09 -0800 (PST)
Date: Tue, 20 Feb 2024 12:50:07 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] xen-blkfront: rely on the default discard granularity
Message-ID: <ZdSR75QHen-omYCZ@macbook>
References: <20240220084935.3282351-1-hch@lst.de>
 <20240220084935.3282351-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220084935.3282351-3-hch@lst.de>

On Tue, Feb 20, 2024 at 09:49:33AM +0100, Christoph Hellwig wrote:
> The block layer now sets the discard granularity to the physical
> block size default.  Take advantage of that in xen-blkfront and only
> set the discard granularity if explicitly specified.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Roger Pau Monné <roger.apu@citrix.com>

Thanks, Roger.
