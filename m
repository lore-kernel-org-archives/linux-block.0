Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9B3CCFAC
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942830; cv=none; b=nX3mwS5r/M19rzDFJwocrdAkonZXrR5Y9hLx8R4AUnY8/LidwRchnQdqa7Cw+yr54P0UF2m+PGV8BwWulSwa7gANu33ZXFHDriUoJkqHZxu2N03Q/YrpLFd5A4ml7nuxw505PkLREsIT1TbFAXdXKeXxFwaLarA+estAMtuzyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942830; c=relaxed/simple;
	bh=Dj5OjDu11BbYt54wqKY/YU/Eu0S0RSzugCdLTqwK1l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgWbEyAEvGrf3C5t1B9S0+YPKxXK+HLg19Ed8Y/Sqs/MNdSIvfBcz6PGCi872NJxwaRyZTWrqIsi5F08aIR8RmCiOabIl362aFKKRlBClWmWG9KNX6+gxBQoZWMMDJjcGOVnZLM79N1kgWV0kOn+Z8+3XlqYNbrIHOKKFJhXJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ONK4/yQK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONK4/yQK"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso3288378a91.3
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774942827; x=1775547627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GuH7iIH355fRKQUbODvwVt65TnT7rv82+xQMO+HW4Zc=;
        b=ONK4/yQK6CYuRka+MaJadMJn/nGfyX+Mp1B9HWZuHCCH138/xT3QRcd2G97da2aE6x
         +mK0q2EoGWtUfruRiJtPhVgpVI5eEvBtQP1PKX5T7ip0Z9eIeYfkD9GCR0CdbGU3ch6Q
         m6PD0dM7mAyNVrTfKFRpaXwTjWuW78eCY98NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774942827; x=1775547627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuH7iIH355fRKQUbODvwVt65TnT7rv82+xQMO+HW4Zc=;
        b=KCMao6/WuF3A5RsF6s9wAVfuIGuZPaIMqsncuho8qnpvXkJIoWCopTi/yBtXiBqHuQ
         Zr1UL7SIUd1T6PEXbQhrYkDVFmOEP8Fv3rB2crLpd3AP8ynIxuhKpUNWD9Ifv91EqtnJ
         +aS1BPz7R7yEQMTEzcdXYBP+HlawKJ23qirzkwmazolZogJ6VmeRA1AdNsM1mxwiTxqj
         IZk9/PopOgpI/6Q+fVIyg0MQrOx/BROabcjTRUdEi4jPFKa8F/ubxmNmLNjsr4dgJAXF
         luotyF+9qieG/7qzUdLSQH7q2B6mMzLyZDwvPDWOKa1bK2M5/eM1jXAKbYBErSsCpBD2
         6PcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXYmfviDxfuL+ilbQHEy96b/IqHZlceXlCViJKqUjqcKRbrivl38fZbEoZ90RCd5pcKcqtquUXc5QgNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08DH8lzoDFNNgjHGec2ArhSOmPX6zi4ebI8rEuYZ+abL8KksG
	j7bWsGwC0M7xlKYpkxj1/ieGDaBdcjRYyotU6d0sM8Yhc4FctyCRmQM7Pr16eiru7A==
X-Gm-Gg: ATEYQzznaSj101ZG6sJ/m/NAj3N9JZ1ZcttrbOiIf70HqJCVjEpQ1JAUqsqStQ/ccH4
	72+lrXv81P9mqU7hJc18dyyjuHivxPIPwDgGcTSTTlJr6vBw5Uby65i8abtgxeFoPF/64FMIY+w
	Kc4WjNRDWbMbw8hfKUjO3GJq0L9jGfAS3W+gaHO2PHqIqU4U7gZPGSz7dvKcSZ6SviNX6ar7yzz
	6Ib7mlJnyaapoh3ea2f3sYXkvsy0F4M4ue+fuX0Rlu/koB4kCv0S+/pdO+mk9k8OfZL4ue7NXUY
	QYa17QeYqfXpjlBrnI3N60SA7U39vUa5k1H2thLXOYFJANKayGqIlBVPA1gAsG5UAVmfamBXm4v
	m/YWQ6T8l24xJxOtbNS+Aj0HSTImNENbkTnZ6VER12pdQXHn8p1U5TtmnnPzW+HOX1SSHG8EZaJ
	mIhrewYDCF2w2ZtPqIwQMQ/FRyT1+W67ONTFIDgN7l+C+KZ21sf1LHXrAVf1TMaEo=
X-Received: by 2002:a17:90b:2d81:b0:35d:a9bb:1e41 with SMTP id 98e67ed59e1d1-35da9bb2001mr5840966a91.10.1774942827011;
        Tue, 31 Mar 2026 00:40:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm1049975a91.10.2026.03.31.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:40:26 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:40:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Brian Geffon <bgeffon@google.com>, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] zram: do not forget to endio for partial discard
 requests
Message-ID: <act6COjXXZecVwQM@google.com>
References: <20260331073737.774503-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331073737.774503-1-senozhatsky@chromium.org>

On (26/03/31 16:35), Sergey Senozhatsky wrote:
> As reported by Qu Wenruo, the following
> 
>  getconf PAGESIZE
>  65536
>  blkdiscard -p 4k /dev/zram0
> 
> takes literally forever to complete.  zram doesn't support
> partial discards and just returns immediately w/o doing any
> discard work in such cases.  The problem is that we forget
> to endio on our way out, so blkdiscard sleeps forever in
> submit_bio_wait().  Fix this by adding a missing bio_endio()
> call.

The last sentence should be something like "Fix this by jumping to endio
label which calls bio_endio()"
