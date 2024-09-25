Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7C1D5ADB;
	Wed, 25 Sep 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279598; cv=none; b=EJwAUfM24YnjS1wc4zIYJwnkgVuvFUvA7q2ycwnaZWApsNW6qdEXtATdo6CqUFNhrcFbMhBwlCpll3B457tLWgm0+OCdqe8zr0DppAu52BfmTH8zfTFKgVxqLYtugW+6IVYGk44hqHEjVDp973SZlD1Ocbdqi9d+NclNVYlDRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279598; c=relaxed/simple;
	bh=6xNSqQY62TwzoRnM6zKPq/jMxraHs9/mq5pT+usKplg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HUlXUSZalesGb4DHQTeiWeGa8Xm1jPvfd/gD2UysYOoJCKGVOBQ/2/8ZtZGFiUptUgaBySEaai+d0kG17jrPLGBMwyw09Dek8h05a2TlVtUZCIquOYEiAZa9Hw9UzLIil9yjXYSGDpYoNFwApKZ0VXZSLy1hhGwBohMNBRaB+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wel2jqNH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wel2jqNH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20792913262so81248265ad.3;
        Wed, 25 Sep 2024 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727279596; x=1727884396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xNSqQY62TwzoRnM6zKPq/jMxraHs9/mq5pT+usKplg=;
        b=Wel2jqNHU8nbNT9UbfUYpZ6xEhRzv/r8/JKcj+I+zA98CWHg5Z5xVniJAoo4sXh1PL
         8ZLQT0Jf4D1N21i70IMdqAuZPPNSD0mcvebKMGZ9tREuZQSxNYQkydyH3WcGIROubnW7
         6ee/SPBzpr1OqoqKgf5IBJwdy5blaiZrzph5ahkWHEzzNk7JC2siYGCHeewDzgiy9OEf
         sfijRc9yKSBvN5a+qvWQYyDPU2PTLkxMyFoQ3qr/8ggCMHSzw72UVxJsCQb8j2QK7IYQ
         wbMm+NbbkyNRrWD9QQjkvLhJFvOeN3ry2vtgqSuHiqAgLbPbp7ZKjxe176v1Y3paUQqL
         DEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727279596; x=1727884396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xNSqQY62TwzoRnM6zKPq/jMxraHs9/mq5pT+usKplg=;
        b=V0YwZuT9rRCoICIaM6WbWwm5HDBob8rVqC12GRUAJ7DYdSrMUX3C9m6mc1SM9kYODs
         pA5Iq5511lYvo+T5sGiCSBAPpiKI1rd3bIQ9DTfNMJjxADxI4i9NO3XZg+SxPqcfKKdJ
         yM10DZYCXhqESp97HjGakzibc0zSaDz8C/2Tc/dYX6DdKDMqjYaAU5LqWpv2QIUTgxvm
         qBFhiDc8KRtMlGNz495OCNIq68ckpZIJXwcbo5hb320TtayM+W4MMsPULGRQXy6uoRnq
         gX5eS8hQXobJ5EOZrTrbrUXN9shgw6lP1560/3MdLzAajn8s3bbOeJFMobR39IkkMuwF
         tXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWID1gTTUDKhnGYmNNryqXTeKKniE+iA5OJ2+McO0Xn6tp4fNu6fjLrbCw3ydBNB6dikdJ60ySMst4vVNBC@vger.kernel.org, AJvYcCWa5cIpAPq90ZKsSuchwfDCkM1bneZofQcZX1oagBjA6lTt2c8YWsj5hDcnUbXHf2H1TZKwXrfsfnlKow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwkSHYreEtInqp6teXz4iuwFd2dK9FlqPqFvak6K2nddgIbn8g
	CW6ly7su4tvwnw8JYGDMZTipLgAjhTSd+nsfOpmivKGxbkGCPUbK
X-Google-Smtp-Source: AGHT+IHXb27Zlv1VDZa6RvQqB9yDW+MVtRp0Fh42cOgTpYIEztsBPZcKsNlS8r8VzvYP4+XFDc2VpA==
X-Received: by 2002:a17:902:cec4:b0:20b:b21:10b with SMTP id d9443c01a7336-20b0b21042dmr24488995ad.38.1727279596177;
        Wed, 25 Sep 2024 08:53:16 -0700 (PDT)
Received: from jassi-desktop.. (S0106a842a1f5d1e1.wp.shawcable.net. [24.79.253.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b0f8ae9a5sm5832285ad.108.2024.09.25.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:53:15 -0700 (PDT)
From: Jassi Brar <jassisinghbrar@gmail.com>
To: senozhatsky@chromium.org
Cc: axboe@kernel.dk,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	minchan@kernel.org,
	p.raghav@samsung.com
Subject: Re: [PATCH 0/5] Improve zram writeback performance
Date: Wed, 25 Sep 2024 10:53:14 -0500
Message-Id: <20240925155314.107632-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919003338.GA3748@google.com>
References: <20230919003338.GA3748@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sergey, Hi Minchan,

>> Gentle ping Minchan and Sergey.
>
>Hello,
>
>zram writeback is currently under (heavy) rework, the series hasn't
>been published yet, but it's in the making for some time already.
>The biggest change is that zram will support compressed writeback,
>that is writeback of compressed objects, as opposed to current design
>when zram de-compresses pages before writeback.
>
>Minchan will have more details, but I guess we'll need to wait for
>that series to land.

May I please know where we are with the rework? Is there somewhere I
could look up the compressed-writeback work-in-progress code?

Regards,
Jassi
