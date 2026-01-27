Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4B355021
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525839; cv=pass; b=LkJjly4YiIsx1VQhogTkRIuPbSXjhyNZ1EQShKC1IQh2F4BLeugvrIQQw95P63iSQy01f2wBREBCakIwxdNN3FVPPEmXbG8lD64zgRB3sW2LJlkswllzNxCXgtt1cxM6DDEIRrMymLfTvh98/1A9amYkps/2t1S99MHCv1uvABg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525839; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecgeuyd2BajS6St0QwMHyhCeA5347zgarkr/yMaZSezsgbeIOC31yUTnj55ULm8tX5FY4cxfNbKQ7/+4JTO1tscj8GJb/jlukQPeb6opQapDy8GeqiY6/FYxZe6Z5qK34mu0m5/bsRpIziYdOxqs+9B6loQyiosEIYe7KkJ/lGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkJCOcjr; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkJCOcjr"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b884cb1e717so816142266b.0
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 06:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525836; cv=none;
        d=google.com; s=arc-20240605;
        b=h+2KgaKpWNNEesiNCmuMEwKqi4/P8fU3pm7CRroWHv1rlfvmYh70FfB2p0dcSuzKBK
         6UYp0/3NyilT3LvdZ1iDTOvMmafmf6xwmGwQ6LtRUj65ToVSghzfTFdT86pSTwiz1YeQ
         BGjP/JEh1q+skhoc1SnmGa4gO7tzAmCKIv8Gd841S+C0mt+8PaeM735M/VEgosC5znz8
         z4GHBtMaphYybZGS8oRwuMoAr1cbfugv78RvFr3Q09jIMM5DBb2FrF22+DXzncV8cFCV
         0nKgQYkU53EHNoMtD5cRk2tSri2lxVc4ONqYLzx7Yn4k2jj+mvcGKVfkJTXYyCDIbBHC
         ITpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=zdx8hxWM3mmGxJZ0DXkQG2kWonUDKjH34DQaCct+0yQ=;
        b=N3wFyxv+ToL0ivwEYixOFcDcY7q5o4qzDnK7mwNpXyLmLGblC5U9FWArr7G4pPUJS2
         P8iDtKxPETfsF+OQFqSV2Ek0gfqYrE+6LZf4KGAtZiGojJiJ+dcreM45AAi0q0VuXROy
         u0vVrPjVDn/s6mj9pvHptbHLVv+CGMCQ20ZksmulcW1c0W6o2UUfhc1rmEoAujgtyVb4
         cbX7kQLoQOJX59JPoREhEdGo/bpFdYzMIV5MRQsSn/qTFN5He6xxz3gVQ146K23Qj4za
         q+1IHcr37o+BlTlJywBhKNR43+lRGkbt5r53QH5p/u/UPLtgz3I20VpRaBRm/hbX9lVp
         YJIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525836; x=1770130636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=GkJCOcjr7X6KtcJY30ZuRa7/aqsS/tRsv4aPAPpaAiZMpEVLO9XG6pGd1y8SdczMQh
         48lapHpLy5vrAlwftRyXgbyLbQcKKsaSXQbfwWt6Kxmqzd/wh+EX8sFvSj3y/Aue/laF
         bb0bOnlBVkLoY9FW0D/z6hnvYseVG5ZQ3WaQ+Cki+krMSnAYAI6jr+vj2O6vJYEJSJPN
         ZGSSpHo8KY4IcPo15gm9nnDfwafNPcnpQ9/Q51lugcNdmuTOuIB3LTP8urRE2l8e/UtV
         qaCO+HITT1EK8JGVGZYVVKVsMJ3/j5VMH5zmptVF5TlqtMzAfzttrbMVGycHzDXTIccu
         Gy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525836; x=1770130636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=kiF5+4GyqWlfdvI14wglsbRmxuM2Qub+kKILALu4fTRQBeGjK7TtiRs12Zs0GeMG1J
         Ph42ySAo9unJNV7FjhtRIEFVa9nVwMKhS8pzjeJn6dMmYb7I6ovuETGAupNCVlU6uiWo
         WrPx0csXzN2NnfxmEKSUwIg8ZOLD1m4HvG/EQwouoyES0mK+uJa2biYMSYnZH8Aiql/d
         ZS9RO3mMZLpU7xzI1iOYc69upGoExbWUUwL0T8Jde56rZJOyp1xA3/to2CblnFMIIvEE
         NQzGdXoWKsRvAOYCyths4fn8NIXVkf2NVNhPPwCkF3v9ZgvG3RfdQTDnlE1S+PLqLQcI
         gkTg==
X-Forwarded-Encrypted: i=1; AJvYcCV2E0xqjTIDJyOyc/A5Ke+bHs3SrQskGIdo6CEduu3s+GyySfvqwknDLWl0ksm1l/PNECxEA2hmj6StLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxB8XukDvuNT3AC7BqRaP68CMzZIpvEqGb4GfnwBeMgWzcd7m
	x5LDUcsBwa0BcN7p5sOfGr1bi1jxfSUTlO7+GCHFXePaCreexZK6Xe5rTeGsq1Ub0haz9Tlyhbk
	l/RRbm0XFQvjVYf8cfLrhYsZcy/npnQ==
X-Gm-Gg: AZuq6aIJX8B7VGVzo2AbbEitKsE2/ztN62R3TWgirunvHFJfWpDQSTJlPZF+rRqIaPd
	UL9vaY6gvqhcgFle2b4XGzHjMb2O5QR5XXfj3pteJec4/FUwuRZAZnkYuY9URtP02VtixqEaAEa
	+iNfgIOLDg6ZSRP/CzUx5YH886phekdDxOkzXsCSH9a3SdbZeWH8HEessJuQa36VzXW5/bv0Qgh
	AjjEqtWCSRDc/+JD+88w63vkuaYHfttdkIUBvdxTU7uJ1v2Pcm6QnicelR7XVTvvcJAsDrECKE4
	ysE2WOr0yqIPZL/Hb/22r2lU67eVJyfhWWG8ZIkwSNhZh4i7OpsxhF/j2g==
X-Received: by 2002:a17:907:3c94:b0:b88:4ff8:1300 with SMTP id
 a640c23a62f3a-b8daca89e5emr131696566b.26.1769525835895; Tue, 27 Jan 2026
 06:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-6-hch@lst.de>
In-Reply-To: <20260121064339.206019-6-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:26:37 +0530
X-Gm-Features: AZwV_Qh-bXQokozgO9CYibn8UPXNXVRECr1GxeaPZ8jRlXI3X_4jeQcXdNJkNL8
Message-ID: <CACzX3Avvr4e2LR9P_XDVtAXaU_KJqnO2SeUMc8Gh19H8-BpwgQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] block: make max_integrity_io_size public
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
