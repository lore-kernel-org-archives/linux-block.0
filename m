Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F559322A3F
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123726; cv=none; b=f80Mk5P88ZzQabfBGsSRVFptk0WwEW7bkoOtNEUinVhvBFevV8AwhnGSCy2aGoqTDk1y46Q75vxymNWNoZdcZE+cvWKuvcpNfvPVN90rvxexuf3U7nTsxQ7SVi5ldZ0Rasd7gC8QirAzp7uuTm0B7zgHOs4WsxLxgB9p27tknmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123726; c=relaxed/simple;
	bh=nsEtdyBHYuNtrwfkSUd+kMCvDYIhEsa5VyEqqaR5Uck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZdRQCOrtwYJbd8HXYC7Qt8KXlGd0n5HF36o3Uc9QnODCxESa28Va+bYtN/rgtcwYfbP03H85lhvRxVjxKF1v+ybt0Tq6dDkL2hOuur33bCinyidpGs4b3uysrkC3p/7mN18Ib5TDo8YlgbkmYZULbH27U2c1Qgan4b5MnlxWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qh88ktry; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qh88ktry"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae527552acso32010205ad.0
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 23:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773123725; x=1773728525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=64ARV6b6LChpJbIycIcc+WA+oaIfxBmH1ZYyI/Pm2QM=;
        b=Qh88ktryNKkBbHcmfeN7s1KCF2wPDA9aZG5vN0QW5NEcBxTHtk8L5SYVogG4IjkgE0
         e9W8eVRTs9/sk9ci+8a0XjNxH6l05Tuy7HrHc4UA7SG/lFdudBjHd8uAECCEqbKqXBj7
         rif2syzTZ+6Y4JdPleddhsWfd4dm4AZlWxv90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773123725; x=1773728525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64ARV6b6LChpJbIycIcc+WA+oaIfxBmH1ZYyI/Pm2QM=;
        b=U9OwwjwjlNNU+6bIvM6v2LYVu9B1CYMqutBhwaeBGBhY21cWzINNwlAkRdLBInpZO1
         SHaVXmdMAUTGgGebc8mmyGNCOqLsen6T6wa17jsmRGlQO+3I1dXtDEw+H2YDUpm62+Y6
         SNHTR9+XCRqElC5N75TyOuT2U4OnlG0874HvRBhIKi29yuXKcRjypAsbTwkNamVAjlB+
         NrJJTT0PqLA9/8NlobB9pXiJnAsH8wtKTJuBBHuDUZVdcbu53m17diOnNskZ+Tpqjrx0
         ui+NYYTbRX3xOcl6rIdgRmQFlGLVWlzDRv0QsgknC7uHl4hEuFFkNYjiVFEKQrdv4HZo
         VoAw==
X-Forwarded-Encrypted: i=1; AJvYcCVfsm2MCfWwzBnm4xdcKv+AxTXMBEiz6JSURjGRYOXdCIhxLARHPlwnd3hSBdxAYwUM3oC6T/9OUBbWnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlb9MDI/QFiHb51U7e8FJjk4REP4Isz8rkySSWRTihGambOR3
	qPO+TfM7Za8AyWkimi6iTUJedmyvRbC6kO61YIBdW5JLNAr+aIsP7nLus3RHyK9U5qn/YVEcLsM
	+sVs=
X-Gm-Gg: ATEYQzw3wivb93upeRK9he4XvAOuNV0C/eWYUC3OZ+EXyuwPxiFjzRC01TYdQCHhLWY
	NVpzYLTOCMkgzLsKFr04kBUaz50bC4CaGvJPXIMBvrhoY6NwwpRE6sfg/WMq+zjkI7+dYaYSRie
	oeE7oyIZff9ceQlGV3WQISC/V1w1qPhh6Z7nPOg5hS/7YVUB6ZxLGzks2oOWnHuj4Jyb+OntnJB
	61A2BaQCkJ2PVagFIECzXXDI2EMUKCkQeJztoeiW5Z6oHJqYyWDcrUg0yZ2nYx43xaCMJAX82Q7
	e/bnPeKTH5ilXGaVY5nn00Mii2dDr/K+ZlAhJs05pplnCd4YJSprUB0qYztUVYBhuTECT/iHHt8
	kVDdejiqOmCZi1VawN55dnrPfse3VSBDxsz+tmfYDJGBRkeYI9oXoYZZtO8cIOyt9iyxq4xPnRM
	ayXQNSRxvm9YfXYGHh8HBvIQ9OBz8rfs8gKdyDZacWeeOiPlq6aS/CxSCfHckCLnk=
X-Received: by 2002:a17:902:db0c:b0:2ae:80d2:bb79 with SMTP id d9443c01a7336-2ae823fe8e0mr154921645ad.2.1773123724714;
        Mon, 09 Mar 2026 23:22:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5620:959c:240f:eb2a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57b1fsm185091195ad.12.2026.03.09.23.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:22:04 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:22:00 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: gao xu <gaoxu2@honor.com>, Minchan Kim <minchan@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"surenb@google.com" <surenb@google.com>, zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: zram: Optimize LZ4 dictionary compression performance
Message-ID: <aa-4XYBDFQ8swwuq@google.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
 <aa-1iKEWKNB0zDwj@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa-1iKEWKNB0zDwj@google.com>

On (26/03/10 15:13), Sergey Senozhatsky wrote:
[..]
> > +		/* rebuild base_cstream when the dictionary changes */
> > +		if (!drv->base_c_valid || drv->dict_gen != params->dict_gen) {
> > +			ret = lz4_build_base_cstream(params);
> > +			if (ret)
> > +				return ret;
> > +		}
> 
> We should not need this, unless I'm missing something.  Params should
                                                                 ^ should not
> change once algorithms are setups and the device is init.
