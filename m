Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE35318EC9
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773123324; cv=none; b=QOSRWA21cbJLSxV+OFpd1okpSkaGDHb+YlyFOPtdWoyorTzfkDxLkwWDlR6b75IuJl/pkmJ5wIsSD4XSeAdTOoDuhnLKbHT8UOGQjlCa1+/aMACySfxMOIgLp7LTC/BHgQiUUicldqBc5YFkf8sZsQ/sTA/Ox2ALXYADkvw53dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773123324; c=relaxed/simple;
	bh=1er7LkezfAFSOP1NGwBywoioOUqMCd+5bCfFyYunW9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUBd3dYonxMLmu11yqZMzjzfiKV2PVBhIkdLMf0yJtP2W/8s56p+MD9cLHcK1rWnnBACx5sHSXcq9rcpdwZ432bOD4PYE1uOJ+k2A3RCsfssApSucb+i9sAJ7Auie5UmRzaAw2HP6KHWhp4xRjNpCyd95cHkEZ+XWgCcjoyq+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f6l8RBqz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f6l8RBqz"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82748257f5fso6886762b3a.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 23:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773123323; x=1773728123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZhurTqHkOB/Z9dHHGlE2leBBgsn3TEX7amO10nnH24=;
        b=f6l8RBqzRujV3HLvR1W/Hqu5AW8vNndYymRVuQQo3Z+BgDeOnvQK8pOa7ULgGiw1tS
         K53yYprSEUIGvnKnxFHoEgF+zfH+X9qe/PGGa7zZcuTfx3pVr6m9xDdlvkDagDyCLsV6
         SYsDRr2OeDXLEvlc1nrBWYhxBDsJASzp1zh+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773123323; x=1773728123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZhurTqHkOB/Z9dHHGlE2leBBgsn3TEX7amO10nnH24=;
        b=Pd+aRdUiE+4rvb0hpUuUSnJvNNBfTrDdBZfT50pVvNtkG0chFgaujsvqwrJ/fV2NwN
         HsH0bDpHLWakwvsVnubW9FLP6X3Lp326etHaplQVLUl09URCnPmghsxx6HgLf+tbVDp1
         gPxXVA4nCPLKHMzq2oU4aDwTh4n79unyCl6SzvSp0MT2Ta0dHfCih6ezesEboyEnidBz
         CoCXD3z3Fp0dDwNYpIiMV+ToeGn6gXaums0uKdtoX5uNQPtsxXdMdWOmcJWoapGGufER
         5/M/B0+KfsEuAcl/FLVI6bg69dd8/8BqitPTnYBRVaqKY5Sd9lB0zlSesZxkFXLBxp9S
         mrEA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Gy3QBkQLpS2kuztFU8I22l+zZ/V+XXrs/9OgeFPC+jMrBT6lbJBty1RPycqMwGT7ldCFw8m5mgfzRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN340iH2ClG5fAw87Gz4glwX982/M4GR+p01VcO4iZR8XcMUYt
	H2HpmGPT9K8cJSlifokt9Nh9x1TyuwRrdU7rxB8v1ZDYYlBkOSWxMV7/27o/ZgJFkg==
X-Gm-Gg: ATEYQzysCc8yZroH860lkr00cMNKmx2/fwrz4Bj1/+C+k1fJF40uL9OSHYLdfDsqTjK
	mgQS+PttAskR3yBQt20PRPgjXn5JO8bTFFHhat4DAy0MDg+vBQudvt8xMeINr4qW7lERrgRQuCb
	x2nj2qJEh3WaEkRogzhxvKj5mvcz/CaHS+mnvMkIM/3bc53KIQKvPFG0frjNmXF/Ou6sFcJPp5s
	QfT7i+xSJp3W6Qk63jElfrq6PiebF+W36UXeS3Akz0QQ0OWoumrRry393HPLriuH09OeCOGmP+h
	0Qfmv1oZxov0SN9E0TfXU2e5+UO49vgWlxeBvMnfRUCDp7YlbBQQSpo4g5bxK6NQ3UA5NWX8kDa
	V3wGpBW7gOamhgdF2VMjldXUtjfLevaLP7OUJnKqi9o7p/5UxkdTPwUYW1gtpYpf+5y5L0AR/pW
	PoXcdJYLghFpq8o+RqM4QCjNw9qPg3LqHeIpHwtQfiZ/Nc7MsiO2hcHA3wx4REWtw=
X-Received: by 2002:a05:6a21:3f91:b0:398:94eb:1bfd with SMTP id adf61e73a8af0-398ab2ddc20mr1738818637.10.1773123322772;
        Mon, 09 Mar 2026 23:15:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5620:959c:240f:eb2a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636a9dsm12304586b3a.4.2026.03.09.23.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:15:22 -0700 (PDT)
Date: Tue, 10 Mar 2026 15:15:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: gao xu <gaoxu2@honor.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>, 
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: zram: Optimize LZ4 dictionary compression performance
Message-ID: <aa-2nItXDdeDj4Xi@google.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae51966c3cb445e9983230243bb6a5b2@honor.com>

On (26/03/10 02:54), gao xu wrote:
> +		memcpy(zctx->cstrm, &drv->base_cstream,
> +		   sizeof(*zctx->cstrm));

Do we need to do this memcpy() every time?
A nit: if it cannot fit on one line, then let's align sizeof(*zctx->cstrm)
with "(".
