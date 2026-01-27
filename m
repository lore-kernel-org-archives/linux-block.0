Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9835BDC2
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525888; cv=pass; b=H2Q0nIL2ZWDL4BUX0zo5nuWcAavKLoCL8JSAbMlA7wjgSlpJz3Yv9dBc9nk/pUkWzs2+Ae7ZAuai/mfT9tq4GyS6Q8m9i3JqzeuIYTUrMgOIc0C2Fjb8BuqycIUT6u4Qu3ixDG+Iai0vIpS2uctsF0QynlDGuIfdrheGBxOaX3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525888; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjdRpv0m9QLI7xCkgkM1IWPcvomhMOdP6b3eazr1zQacFPSySpkT9eJ6r/98jK5KMPSuNrkvsYdJVNt3D8mIYpgWN2J1OuyrXWvsA56mo7cN5OstW+ccqB/5KlU77fySwqK5Kjauf/gJQC5rbqS3k1jM7sYf7fL98vZxXmAYSWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ1uuKOL; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ1uuKOL"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so9842462a12.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 06:58:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769525885; cv=none;
        d=google.com; s=arc-20240605;
        b=f+mysg7IrrJjBbrq3fiiYiy1SOCWvwMyZGi2IafpWghQH36Uy+cJq7TyM3UzOFMf8c
         7b/8QHEwkPSpV0MGZa6s+WxkZT1ClOk2H4QV5xuIpEK8I8SQjreqQavPLXvgJDpkQFmx
         uLZZKuOPVu7yOUiRvaQpga/byQtEwfztz5Kd/euOGhHh7T9o3QxgsOdlY/1aImnIW8a9
         p5bxjOAcso6skFcBXsgMQmCaGu676uOLx4YhtoL0Y5wWFhPi3C3SZda2gFal2LTkExAT
         PIvqi5GPD+BdpiynTPXJgf2ddzgeFs91NtPRCac53g7IHz9R1BtPREIMa+4avrt2F3p3
         t8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=tdEKukuIH2rhdagtf4vNsBLdRtAMjbqrebqisWfL8Vg=;
        b=cJkaHdTH41fSgzbGiQLqMg8DH8duXnI4tnYS/HW3G5040eXVJV3iPv37ie9dQokec0
         ofOBbc+SCi2gULI5JjMNjHGC9dKfBxxkSEFbb1/YWTAeJFQ2GrpOfaYfxw+HtCtrf2Yx
         nvR2zOsxrB2OGrlXKX9aHWNaVM+vN4basm4GGY9kBVpRT0/JsINa94lOqgCerkVwclOE
         bASZZmr8F9zpzMgsPht1tYh8WkcicjmjrsUAXJBwVzu4V5xHnd191d4PV4YE2LCloMbM
         omYBPyksMAM0uxCVesrm0FQyxxfW2WBQEqB2nVYg2w9msYf7lvnjvKpTUuwnwvzoufw8
         Z3Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769525885; x=1770130685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=HZ1uuKOLTv3GJ3SCTXzF2cAvg/yqb+tw2b02AlJm0yuQ/Nxqt0IoBLYbwtMkgWqyxG
         AJcyeCGAIi1aMZr/hPZzrvvVMcnN0+Lz1NJyvOlrLKvCIeYS1tE2yHf2oYDY1r5TsdW8
         GgYLJNo9lCxnXs+1jB+2eyaxsV+MrvvtkgRSL0EYS0Mm57/GJOtzWgmTlZvH2k7w5Yxs
         Cw5hOtl7RGyKlL0sQgluLIohVz6KSD2kaU2dFqT4nk1PCUdjhulLjfWqZbNSAuBU2sKN
         el4TNYmrq567bSYkZgRfj0eHb6EKvh67J72XO92eJR8VUXdSqTBWOiLwGZ4xMhC3Drgv
         zRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525885; x=1770130685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=pEdCeh0avOPDQtGx0jQBJNaZMXZX2MDz3YKF8ddgmJM3LTvFmvDaUmTCdLyrPtoL2H
         zGqX/aWsyV8Kyf6oiT28eZYUlxFuv2/1oRfZcNU+h+G12UKdDdmHj5Yv4mcc0m8LJFRX
         qj+tN7FfxA/RGHYxNyL4OyZHEAMxRI0c0OIfPDDBdHiP1MMCzdP+xUKoJJlWP/aN/ms5
         coaFuNlQrs1wBE6inflmcJlpUK4u513BbiIehSYJzr0uEgUv1MNkp8rZGwSOk08obx1q
         HNQXXLVuaY2pv2TnGaP3tUM6DlfGrLFMwxdIEU/jZMqE33yg8DntAWzB9PMiMPHsnenf
         G8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCW5EdLu4J6IbPb0vQLz/u/liyfW6ZuEPnPda7VApZqBY/q4QzJ9XgGD9fr8tr+bSQe0OM8+/ZFftvglkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0F3mOq6yNWH2FatxC19Lw67aY03yQgDuWvOdJuQYD953foIU
	ONUrFAdjB2s/9zH96xK4LAa3NCh0LHI9XoFTZnE+j2seP0iabd1OQBq8D+6vraKuzH6MAnamAOG
	7FAs0IKt/UT3cSfURCfWjF/QMaRDhww==
X-Gm-Gg: AZuq6aKO1lHa+hb9GCxl0ujBbihjVISBuYa/hf6EWDOZvcHG+dzLSnPuG70SYzEirQN
	Fzgg/YRL6A3UN9rpTbLMkdnHdikNUsMyveL3eHINRzEHuQpaZsmuYwzKdheYB0yUJqNqiSSR3RD
	9VZjBDuFAZF3LTaD3OdJ+FyzzLHimA1Ww+YHJmZT7QT8seugJOF5MnOaGSMncQV/FQirG1xvdi+
	xTS09iY0XxdekHsdHDJPX/pvOsOXRWi9EYrFPCkpwa4i2xuJQkIOEIEOt7hHogLy/XJBnQ3NS8Q
	k8rLCWshD6dahqE0/avY3LI6JCCrlOn3OFFEkvRHtoTGi1KIHKBYjjad3g==
X-Received: by 2002:a05:6402:3990:b0:658:1b1b:15a2 with SMTP id
 4fb4d7f45d1cf-658a6015a38mr1102233a12.7.1769525885403; Tue, 27 Jan 2026
 06:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-8-hch@lst.de>
In-Reply-To: <20260121064339.206019-8-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 27 Jan 2026 20:27:27 +0530
X-Gm-Features: AZwV_QiLLibbUg0iWqpfZ42-4rmvFtl9Ak5eBKgkKHdzZSGOKr8Fr4xqlZcQZ0A
Message-ID: <CACzX3AuFkVucGMbP=YQTB9AH8J2iBzzhPW98JSizDNChzV2HuA@mail.gmail.com>
Subject: Re: [PATCH 07/15] block: pass a maxlen argument to bio_iov_iter_bounce
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
