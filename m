Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F618E340
	for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352458; cv=none; b=N2DzTMFsKYEL7ylnHX8p1hRbWKXUFxiUfnaSRH1F47dnmeUDUA+9e67HXeV7JkqY3uDxgiIp0RmRPBJGu2CoAnXkk/VdIlyQpKSyzTT4wYXGO4UUVdYAnEHIiOeGBnNc2DJ/B1mwFzlZ3MOA/ALjzMaH+yidlLSPaRKGfUpileA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352458; c=relaxed/simple;
	bh=yrH5RiUDqyUKBWR4qaWPlzmcZTtKiCubsoo64C1gMOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alYsYxK8lD7zlQPKSfyEf3ki61jK0BnjV2C+9zCAt2Lx3zpobbYIv6qII6SyvgVl+pPVFpRmyjVejugosbJe5YBXy/NN+AfiUl0vLJHwsXlwquUnK1fxLgkoQ45YNzGUzDwz3KhL90mytty9zrwOBA93Ut91J8WF8SLKCNQeK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SsVPAptx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsVPAptx"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea79711fd4so2195913a12.0
        for <linux-block@vger.kernel.org>; Sat, 19 Oct 2024 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729352456; x=1729957256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdOGwlCw3huuQdznMhpR23CaAkTrnKq7LeUBCihBJE0=;
        b=SsVPAptxGpso8lqZ85bqD2Aezx+07QcSIbSC6ZZLo19BYE2N0Kzcb6xdedmA3lU/Ya
         rvFtbQ4xQg/w5ROz8tKmFjNwXkDfIiQxCzzzFqcYCkX6aNnsscCxDqgJnt3pJ0ezNncj
         1Yl4te8p2ucX72HtNayY0mtUAlB3oUSCTxmMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352456; x=1729957256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdOGwlCw3huuQdznMhpR23CaAkTrnKq7LeUBCihBJE0=;
        b=lnb0jUEDS/OjOYCx+83amvdp1uYFnyhFLiA4lQMkgYN55TM18DCLFmt3gu8JHUi9KG
         LcJN/fiNLeeutfx9YAvG0rOXdfqUi4bnIXgmUNJY9GNvfWgSE0/3Y919sISTlkoEfpRN
         spAvzc9bZdwJl41hNfJmXHtQJiAs9hbYR8eLoXVn2mVHwSCdkNKbOaGmRTxDDgcfXCnf
         4RNBX/M9e7WutuwK/1EorWO0rNOBSkprsFYn4tSrF2JO1Z0p/2c0SgZ4B32v/R936/8m
         SuyRuaIG3r/vxkqeo4rkk94lHdqkmLOOyg6IM/iVXynTLucb66xsWUczC8dgFgGwxsI0
         OLPA==
X-Forwarded-Encrypted: i=1; AJvYcCWM+c1rRtVx2ry39RMhhGIiSd+WUJY8RV7QYriIBCOz2O8nBygc8b7pFH9FAM3zsSsiFyYyyN8qmcQt0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjxIvKknWeCIhjI5y22qRC6bZU1YqQh/sBJIX6eoFC0RmURiz6
	2AUZlUx8JmCcNTRdwuxRi8CvSBrBpA87a8kWhNuqNNM+CgJhtztITpp3GPtSmCZZ7EvDQFDsasT
	98Q==
X-Google-Smtp-Source: AGHT+IEfDjdja7lGATFV3HYEW4lNdWoi/ZTr/wWuI5Nd3Nf0DlZruhHHHsiDoqciVr1VCiboqJIbEw==
X-Received: by 2002:a05:6a21:1709:b0:1d9:2659:5db1 with SMTP id adf61e73a8af0-1d92c502373mr8372954637.19.1729352456098;
        Sat, 19 Oct 2024 08:40:56 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4f31:a9b3:f4ca:dea7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc28befbsm3111514a12.74.2024.10.19.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:40:55 -0700 (PDT)
Date: Sun, 20 Oct 2024 00:40:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241019154051.GI1279924@google.com>
References: <20241009113831.557606-2-hch@lst.de>
 <Zw_BBgrVAJrxrfpe@fedora>
 <20241019012541.GD1279924@google.com>
 <ZxOmzVLWj0X10_3G@fedora>
 <20241019123727.GE1279924@google.com>
 <ZxOrGeZnI52LcGWF@fedora>
 <20241019125804.GF1279924@google.com>
 <ZxOvfpI6vgH5oXjg@fedora>
 <20241019135010.GG1279924@google.com>
 <ZxPKP8SEb7Y4ceOq@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxPKP8SEb7Y4ceOq@fedora>

On (24/10/19 23:03), Ming Lei wrote:
> 
> there isn't even kernel version...
> 

Well, that's on me, yes, I admit it.  I completely missed that but
that was never a secret [1].  I missed it, probably, because I would
have not reached out to upstream with 5.4 bug report; and 6.6, in that
part of the code, looked quite close to the upsteram.  But well, I forgot
to add the kernel version, yes.

[1]  https://lore.kernel.org/linux-block/20241003135504.GL11458@google.com
