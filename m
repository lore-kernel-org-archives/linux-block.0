Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1658433E66
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833420; cv=none; b=qZGhoOwZ0oCMiFS/zsn4mjD+zvC1sL9xcj9IHGnwpHo/wNpjaQ8OVfBnNtL5F+JUVDOClwSf1ejBUkEhFMy4BKCiuXb5Q+MMQ3HZbYHBdgE5Njl7exFpn/s2vM1QAnprcC0+G9A7RESccZl9NYdKOoipdSTx96l4yRDUvyqDg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833420; c=relaxed/simple;
	bh=rcxUxarvckFEbzwc+77lGqnMQwy+i+2zfogoe1pGPuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DesbyWaLhsQ+qKOKr4ISq4y5XJAuQ9sNCpHTG46/rA+9TM1KRAONhIzUJSfqBNxvDq+ZNPtEJv/A5DgIhIT2pPSRYBqtv5Qnxc7lO8NnCOiw4WD45xxUbIECZa+ZLjx2HwyIbR8ftXEoNV8ha91JUUaURXsuC6b6aYCqPoYsyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ih0YrXAC; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ih0YrXAC"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d9fdf798so9201145ad.0
        for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 22:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790833418; x=1791438218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zgvrIEOpw88VrEORT9HbHbyuQrZfBbC4ttbFKpwgFuw=;
        b=ih0YrXAClCgFBCn9SASE45n0KaQdTZ8sJoUMQOnUf8WH3BD1LIfrruRykCRU1vYoeO
         +JIpWL81LBuL/fJHeNPsCvUMiL+CyjIGo2FipCNL00ln5x9BKDkDNI67yglabz31gfAG
         13ut3ETxcZHXx2pJII9NFqw7+srZD48spPcXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790833418; x=1791438218;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgvrIEOpw88VrEORT9HbHbyuQrZfBbC4ttbFKpwgFuw=;
        b=NzyQOvvtzI+sQ2mRiHHhoUZneR1SJ6KEhG53Xr2E5pQ4rPS5bN4Sec6zE4CauC7bda
         2vwGijChTwlFJNHKehrn1/soAYcjJGDJHXWAolwZuErmHbh+YYL8u8NvJqIpf5QDOsxF
         1N9lsgRGcEotT5d6/NgR1I5mh7mgJbe4LYMD5W5vse3oVBAUhT7+OONL20nlCSnjfgR9
         4aMJROH+5hcUpo+MSGP5Ub6frcJNHr7Y34DEzqm/HUA4Uzmxw+zJ1+9bO/NXoJ1PzaZ2
         DINqLGLTW/H4zx/kFDPV654fqi+MU+x/h2mnrk7RRMPkXeadcJ07PC6DH1+PbIZ8GHLg
         Qkbg==
X-Forwarded-Encrypted: i=1; AKwUvByS2Zm/YhDHVLR5ATLRuVngAirt6wiUWLasjf0DN3u3o2/3eT0HpuYp4NeiEGG8ce8JrBcG0geBrpWxiA==@vger.kernel.org
X-Gm-Message-State: AFuF++mxBFB/wmAeUKjn9xZJng2b54KgqNLpAb4/YDIrxdvtwpmanWzU
	QOoJ9OFH91dVqMwUikdE6XBpYmu6lCAa8Q60FHLwNIG/spIjK5Vw+KBetlIlIbcQHQ==
X-Gm-Gg: AYBFou3dcOUfCwYGt/dNFwoU5ig4u+/l6GDk+1c3CZIbqYYpOU7XXeJxHU1a+sv0AkN
	/1+UYYauvBbZFraw6Kj7taWrGfCVPH+zNJcS+oZKbtKPnGEHLPqWRC5rQzHpPa7zFhwxH9bTwUD
	lWU1yOh/xr6hmyQEdnduuybLkD0XY4pPP3nika4qpnvp3pgJ4mLcCEnlGiS8E48J7TMBgb5MDZA
	p+2eEThUE+xJCxGoHYzZicLZXweX9Wvy9xsW5gNcIvz2xtdG5BaF2QbG0zCNKYAmo3SpqDeOToH
	pECxd/O0UFXrkcdO/kYDwOZ/lfXsKaeVXkSomGOyX8oawBLT6zZDRxrEzln2mGvDRLxYlsXmSHo
	k3jihyy+Grzy6KMaWaENiUuGP4Mc6U4HzISIHXa6cjeeZ5tJ1CMy61Ej1FkMUvhvbXjq76fw6z4
	T3CA/75mChYpTzSAwZJxRdKN2al0V0vrju0+Xrz7u3knE/UyPbVGVXlqaKcCE2pDCdsNpt+Yu+I
	vgXCU96SX3bpxtjUNa55cKN7FwdcjsDVL7cmcy7yMERhWj+SQ==
X-Received: by 2002:a17:903:3503:b0:2e1:24ec:df50 with SMTP id d9443c01a7336-2e2e499e1c7mr26745355ad.21.1790833418058;
        Wed, 30 Sep 2026 22:43:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:d042:b5fa:ebeb:ace6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e30cc14cbbsm1942765ad.37.2026.09.30.22.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:43:37 -0700 (PDT)
Date: Thu, 1 Oct 2026 14:43:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	djakov@kernel.org
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
Message-ID: <ar3yt8Kl3WUV93lP@google.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>

On (26/09/30 07:52), Georgi Djakov wrote:
[..]
> @@ -80,10 +87,10 @@ static const struct zcomp_ops *lookup_backend_ops(const char *comp)
>  
>  	while (backends[i]) {
>  		if (sysfs_streq(comp, backends[i]->name))
> -			break;
> +			return backends[i];
>  		i++;
>  	}
> -	return backends[i];
> +	return NULL;
>  }

This hunk looks unrelated to the patch in question.
