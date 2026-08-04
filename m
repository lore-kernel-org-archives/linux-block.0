Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37C3A3804
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837361; cv=none; b=j1m8N3wy6Bypcg0R1O4x317ERZn6dRtXwxcoGjK4XRuSaiFwHxqaT3+aAGiJOrd1FHP4gd+LXgZwpAslVKpg3KdDtl4r/fBsT4eRXRaKz7s+pWHCoiFuja3iuiasB2Mb3Cc2SK4EcgKVbnK+TQH8zgUG/M+P1mTozvWx3/c1Klw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837361; c=relaxed/simple;
	bh=BdCQ7B6ms8+cZLFi44DRH277ZqfecQSQ8JhTAxDQzhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmP0V3gdG0vs/3IZOlFGSlLON7tQn3Sxb2Ff/EJa5jWDjgIlmmecsfKADnoCSYefHjvZoOzX5iMJ15tr+1AReV779nX67MphTG3fZrZ4p2/pokOFliBJcmDJP4rblztTUkcAobW7jkvbPQdYT86QnhxDMZJWWnk8kfesFaSZ79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=niUJn22K; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="niUJn22K"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso3142693a91.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 02:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785837352; x=1786442152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jbdEx1M+4FfJ4IeX59PvZeBMByZsH3JmFbsrDkmiAU8=;
        b=niUJn22Koi10Nv5ckuGGscWiUTsAG6SkXtcmbzYUbYnr05t2fmMiEQj0I2Rggn/XSz
         PBgrcBLL+G0WPTpw9lEz3yAU7ANDMy2iKCnWA/30Aj6m56CIvrrwC2f71NuT/OuLhNTx
         DE0CD3kEcq921lRunzveBvcMr4ZgJfNyZug0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837352; x=1786442152;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbdEx1M+4FfJ4IeX59PvZeBMByZsH3JmFbsrDkmiAU8=;
        b=sGggytPjZIWz1vW08dO4jT6Em9SdPuBoORCvmAasA8+oORxnVy3R1Sq936EMChGyK7
         KDPg52wkDc6alanAe7NQnY7uXOpCiqnUoCmX8cEz3Zwh1NP3pXrBD3ZfvGupYRCUcQoi
         zMK5xTV1qHwI5DfDPsAFXcFgYSvA+imTHgsxF+ctmbtcsBCyJTCrS1wMoeUQ9rsOI4np
         auIaHgVOAYZHmAxvsGr+gLdPQjRZ3zumMWW20cA/0XZprVIPfdrQKXCrZOqHnHx57d8V
         X/9yYKrocbDjorn29rvAdm2jjd9YcgdC4Hbu/mq02qgVHt0uV5iPykwNI/x4LItebynA
         PKPw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8SMfHHQ+M1IsKcoXc/1VUNp1Xxe9mslWOGiBTwnG7eIPgl3vWAM665CycF+YHljpNdK06Y0aYaADzJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfMx25JXoxcHzD4FDISEfopnB/c15Kq/+qGsg38Tvhiw77Ocd
	+Yyb8wnkp4aDnPRr0HMSea3IqDA5C1Mkpy7CSSIJxjx5/e1XR56pnZzVprH4nwiYjiu+vbbuOVc
	ePbk=
X-Gm-Gg: AR+sD11KJ5ZlTx0FvkqpBDlpaAldbM+SIReCaHsCMR5+Rh+vMz28igBDjAjidi4YYpV
	wyE+3tmHahGVAFyC0nYTOgR39lFn3X2BpBSaCDDKy0fFd5N/6BniQgAu5/hy6l0vRzR4D/tpLtI
	XBCmxvio/S75z2AK+NFX/xgco3iemVDAh0BDMCTm5dLUuVP+rQ+CtzCc3qc/okptb3Po3I4ZH3p
	UPFr1aY0YsbNBnfAjLwerF37HU3hwsIvM78C677pEZ8+n20+cYSwcgJNruf44+ZsJiGw2t4yMpj
	XaRjg0FEKaTnNanTttJ7i/A6H5vDjec4vL1mr0Z16hlaet/9DQNCliVvf9AH4iM2+4YICBmwGoV
	x9kf5l6WCRFHLLAFkDUna5jGDMZGN9q7H7TwQ2qLbnppMiXTQkUlanhJ3zTrq0J22b6yX7Peu2u
	MwcZwhRue6fLe+8ynByRKFl6vioFN5L6k9cd2i+dcXtjYov4rsaHzYObwGGPpjjl824Qr4yHaIN
	BUpzWRa97N8g/qSIWgFgqKI4CY6
X-Received: by 2002:a17:90b:3bc8:b0:38e:6497:ca45 with SMTP id 98e67ed59e1d1-38fbc59b19fmr11657536a91.39.1785837352272;
        Tue, 04 Aug 2026 02:55:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febff7eedsm1076407a91.5.2026.08.04.02.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:55:51 -0700 (PDT)
Date: Tue, 4 Aug 2026 18:55:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Haoqin Huang <haoqinhuang7@gmail.com>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v6 0/5] zram: fix zstd error paths and add parameter
 validation
Message-ID: <anG27GxIP_oEufv1@google.com>
References: <20260803141256.60599-1-haoqinhuang7@gmail.com>
 <20260804093841.67920-1-haoqinhuang7@gmail.com>
 <anG0liocTV6U2VV5@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anG0liocTV6U2VV5@google.com>

On (26/08/04 18:53), Sergey Senozhatsky wrote:
> > Patch 1 removes zstd_release_params() from both zstd_create() and
> > zstd_setup_params() error paths -- the former is a layering violation
> > in a per-CPU callback, the latter is redundant as zcomp_init() already
> > calls release_params() on setup failure.
> > 
> > Patch 2 rejects zero-size dictionaries and prints distinct error
> > messages for sz < 0 (returns the original error code) and sz == 0
> > ("empty file"). Currently errors are silently swallowed.
> > 
> > Patch 3 adds pr_fmt to each backend file so that pr_err() messages
> > are auto-prefixed with the algorithm name.
> > 
> > Patch 4 validates dict and level parameters in each backend's
> > .setup_params(), rejecting unsupported combinations and out-of-range
> > levels.
> > 
> > Patch 5 resets per-priority params on algorithm change before init.
> > 
> > Changes since v5:
> >   - Patch 2: split pr_err into sz < 0 and sz == 0 branches
> >   - New patch 3: add pr_fmt to all backends; tweak winbits message;
> >     add missing SPDX headers to lz4 and lz4hc
> >   - Patch 4: removed inline algo-name prefixes (now handled by pr_fmt);
> >     added comment for lz4hc < 1 lower bound; added braces to if
> >     branches for consistency
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Oh, and also
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
