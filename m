Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DC1E8836
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 03:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329270; cv=none; b=MmCPKJ9PpBHNMhP79LHoUVlu5iNLMmWeZBUzPRD/hGYNc4P7/4d7A5yu1ha44JYPVznNcg6uBW8cVc+tIpE8GBqXrft8nxLto9ZDoA8VPLYo6zqpBXP781rFrIjipkUIrlNIWu+1NEI5hMKBRnbdRQSYHcc07Mqv7lx9EosmQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329270; c=relaxed/simple;
	bh=PBZzJhhS++dXmo80FkzmWZDseuzI7MKxG8DCDnPsOgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFWuJEkQgakvSayytS6z1q2vLY1vcIKExjiL/L/WDTKp0LvnOxvCg2PBot7+K7gV5ju2Qg23CGY61wmDc3TxmeQcLfw07H9pIxwUsWgwN5UXoEUxCNNlc7xk7B6XDM4kssJIYY2/ZVyWzxg1kDe6Sm6P8aMkurwzJz/MVFDJ6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m6/9tP4r; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m6/9tP4r"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74924255af4so519218b3a.1
        for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 20:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753329268; x=1753934068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WL+2BPnTAnC3aPsHZj6YPievVUTX6y3GMCc4wezgf1c=;
        b=m6/9tP4r3LCMcxlNIrjzcZpPh3S5hmgnNlUqlVNZHDSSpchGs92bYiTil+tRLLi2q4
         1a+2+poeieDimgHrLOKxchuPvR3Xsc4YVSQ0u7N28SBKVRKncRBL42XgPT6xKv99r6+Y
         vCi4iMJoQ1gGCV4wCB9JfApTxze0rzcsVUTSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329268; x=1753934068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL+2BPnTAnC3aPsHZj6YPievVUTX6y3GMCc4wezgf1c=;
        b=R1eX/a+CW1sbDE0L8pTZB0s/BKPxzIIgDvHoal68hvYQZXtV8Mo/7uAXnS2cKHtkRO
         jGdBmcDx4wadjduBTuQ32A4uTKCmo0g2Vx2pK2gz2+wlrkKBCNO5Qsu+keNgnEgOYq+c
         UU37D95Kqv52YKRaiw9ZUKGo4vSQsXcP4yw7jOo+vtOxsSw/PEc+yfXIHR8wXH1L2YEF
         mBxUVeG006pg9lot0EWVMZcFimhivrLrO0a5VZ2KUgjXwSby9oAhJEjXd1/gnmSHDqfE
         gW0losCfhoUlisdX4jxajmPWjWbH8PQT3LihYtOsGa4E9PwD7RrvP8F9cg8hHCp8opYj
         7d4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9GIYKGx1mDJErYPEp/a/tRVexy42Wmof47LSMQ87Gx7Op0lsAqf+NtDazfo3Vct09sObUApzwqDGCrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyTocfy8hyk+3W2juZhvegqeJRuWZNQWonk+6j2NbaDfeKtsPV
	yNX7LLtaPokODt2NCkNMrVtZcxmb6ok7IuBVDLeOLXfplgC8jnRsMpRraZ55sxS9yA==
X-Gm-Gg: ASbGncsX57Cs0MjmOK5iaP+OP2d4TOoQyWKv35gyEHO7BCFd0mXtzoOUr5ooCqQRuFr
	rObe8TYan9UatNSedJIH1jbYecDEsByOEsvhAu0jhI187Kn+yhHuBFbKGikEKeFRURRa5O+qrAa
	gcOXIEiXUlGIxu73DpJ6JG1QqlSeUzhRvD+n5bISA7p7I2UJ5/3zaf1p9T02FXc0uejvWWDB/Qz
	Cs01a5PApF4oxXOzgKKRzQ0BRWHA2CDN249jJCA50cbDyz13z+dKaZblmYiRothmLTiWgk10GgD
	JpCLB24BVymKroPDVY/1BlLAwLAEPuHGhS3oYcOgzi+U7nC3lf6ejgHed8UN51LKejGRb/Lwqca
	5jKupR7Qq3H9TppMjIxRcJ+moiA==
X-Google-Smtp-Source: AGHT+IHsbVePvODhIn1uJ67FVYK6H53hSEG197rz8kScO29hZU0Is5UuR8jdyupOSSvJmuj02zYEGw==
X-Received: by 2002:a05:6a00:2182:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-76034c4cbadmr7075505b3a.6.1753329267597;
        Wed, 23 Jul 2025 20:54:27 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:23e0:b24b:992e:55d2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b0649fcfsm525132b3a.143.2025.07.23.20.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:54:27 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:54:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, axboe@kernel.dk, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 0/1] cdrom: patch for inclusion
Message-ID: <nlskide2ahqj4gn4jvvazhhmdajqsacz5ch3zukgg2fbfmw2dk@tkyujyzz4pks>
References: <20250722231900.1164-1-phil@philpotter.co.uk>
 <eyejjkuzdzl7qlq3os534ckt3jsvvnvp76pyqcrpzcignj3oms@w7cvw6oht5lk>
 <aICXICNEcwutw9C4@equinox>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aICXICNEcwutw9C4@equinox>

On (25/07/23 09:02), Phillip Potter wrote:
> On Wed, Jul 23, 2025 at 10:14:32AM +0900, Sergey Senozhatsky wrote:
> > On (25/07/23 00:18), Phillip Potter wrote:
> > > [..] I plan to do more digging regarding this, hopefully
> > > this weekend when I have some free time, as I'd really love to replicate
> > > the original crash.
> > 
> > I waiting for LG GP65NB60 shipment (arriving today/tomorrow), which
> > shows up in crash reports (it should have CDC_MRW_W.)  So I'll be able
> > to run some tests soon.
> 
> Had to fake it with mine by forcing open the relevant code path for the
> check to be done. It still didn't crash, so I'll be interested to see
> your results

100% reproducible (at least on 6.6 LTS) with LG GP65.
