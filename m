Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689932824A
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092477; cv=none; b=RBW+cRCxWB22Kj+0ucPDV+Dqom5mJJq3xr4hoRRDkP7Pmh5Z7226aetHphxRNPBm5f+SF7L3lLg6VYHAlja545y2NBla032YKxHErCqbJL2tYJ7q5iV88eg/Yol8u2q+MhGVTa5fpVvb+NdzjI50r8b/STmhH0H8v+81vjcTJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092477; c=relaxed/simple;
	bh=v4dArKPL2s7U35JwEjDVfI6xYNC1N2X7E7E6mgAAHgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=afyr7WaT4gWd5MpV6mAd0eoRQeNgTIPcCpa23GaIBh/aoQVDQtC5zalV+kuDRHUbXyTfCqL4TaVM6m80l4E94YgHbaJtUvtu9PWClGc772jg7zw9UKj0+lSKwAToIW/CbNgyUF7057mIME+FAEkub4c3mTBdf90ER+sfH9BZNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dIi8KHlL; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dIi8KHlL"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-433791d45f5so25106455ab.0
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 09:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764092475; x=1764697275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rKQn3fIdsVxf3SSS8cSBeccYoyGb8mWRPbOMpOycl0=;
        b=dIi8KHlL7Vpe9pQK8nJdthsYFuTVCgKpkwshzi6x93+85SjPcwWU8FgAJqpec0hae6
         rOii72FblLHbNgC/GdIcew+ccXYcbWf/NrOYx7gm3k6qsvUh/cWpkLGYdtELbFyDhMXf
         6gzEzdgmBWmbZ8zlwD/dgzBfkBW5qEgsqL4beAcDDlmfLkKgKD2XCM9RrSmsXIF3iUgZ
         SxsEpeR210olHxiAMkwzSt8xcKGkr3KlsR3hQpVuSq7bHarkk8sN98M5EvfDN/eiZvw3
         b10u8LK/2Cmzmz6ONmiuL0JCoA6Turr5Gt1WFd1rB+kFxrhThvqwo/enKnOqAxLKRCuz
         JrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092475; x=1764697275;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6rKQn3fIdsVxf3SSS8cSBeccYoyGb8mWRPbOMpOycl0=;
        b=LRizUfoTlhCC9+TyXMP3nGRrTekkDw+islHk3FqofCAAITmHFPBBx2YBnY52JlFj2c
         nwWnAlgXtXyff6pk5IfXLShrBILgmUbHJjWiy+E7i2VQvjd4L0rV3HqP4BGISh8XHaMw
         QpZ63gIGjuQ7PLU4cuayNMJC4oMEA9nDsDVA99Xojby3ZcMA2taX3c2ttxhZpPtkcLgm
         Ah5VisG9n3YJGn5UpiK5L8tPD6qcDjj1EKwzU9fbt6nQxAXaU/o9fF0ZUGRRMzzDnTVy
         hJyA1aId20EJlimpRVKCH3riJep0AO9cCxBQ2K3iA792IA29LS2jpbW+pt0tJHNMttQa
         K3ng==
X-Gm-Message-State: AOJu0Yyb12CCs4vhZZYCNeppxncg45u0lR/Ta8ueyWklhpU/qH15HEVb
	7wHHCAI9AVsSkcoVZ8S3FT+sW1tWBJECKOyxSbxECzlUQ/AlUuUGs8HRRhxNJFGgWRucH88uQcd
	zdpZJ
X-Gm-Gg: ASbGncvH7lVIF008A5o0utplg161kRSO9+mXFGrkOnaR/rqeUlJywlzGUqyY4yiUHoW
	DyY0PZRF7WBNVPM9nGkeVRKUXNFejtrf9CaE8kfvr+9ItHnW6Leu5cOxXiO44kQpqgNeTSzl756
	a4bZSOuax5fg5myx7WiN8jTM2eHQmVthAbU1Wb8CjKcfmDGRMlcUlz+/cSL1jj4xZE00xmNQ7Zz
	IDtzuUhJAjFTbOEA069wOMJYQMZJk4qwVtzW7/rlCVPZRJFox0S/UzRKFxmBv3sy75DjUDeDr5O
	cLLFbFs08deigo/u4QkArzqvL0dlVElTV69jQ0rgrq1m9r9UpuJNs8YUixZxrskmYjlaZFzke4u
	9MqZOZWsTueZmZQ23s+4DBR6OMDJi9VcxfRMVHdCLEnlWavZ9A2ckWSLWCFBxG9L0t5ND0h9Q/C
	I5wQ==
X-Google-Smtp-Source: AGHT+IGaNU9n6PCrW3Ym1tTa8906i92tE601j1UOjtkLz/PP3u47ethrME6gFNvIi2RANJCoe4G6Fw==
X-Received: by 2002:a05:6e02:19cf:b0:434:96ea:ff8f with SMTP id e9e14a558f8ab-435b98f0a6cmr129027565ab.39.1764092475167;
        Tue, 25 Nov 2025 09:41:15 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a9056ba8sm79356335ab.7.2025.11.25.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 09:41:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@infradead.org, shechenglong <shechenglong@xfusion.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stone.xulei@xfusion.com, chenjialong@xfusion.com
In-Reply-To: <20251104123500.1330-1-shechenglong@xfusion.com>
References: <aQneZipPwoRsoeeA@infradead.org>
 <20251104123500.1330-1-shechenglong@xfusion.com>
Subject: Re: (subset) [PATCH v2 0/1] block: fix typos in comments and
 strings in blk-core
Message-Id: <176409247408.26472.10970040431812646377.b4-ty@kernel.dk>
Date: Tue, 25 Nov 2025 10:41:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 04 Nov 2025 20:34:59 +0800, shechenglong wrote:
> > This now adds an overly long line.
> 
> Hi Christoph,
> 
> Thank you for your review and feedback.I've fixed the overly long line
> by splitting it as you suggested.
> 
> [...]

Applied, thanks!

[1/1] block: fix typos in comments and strings in blk-core
      commit: 3a64c46c40460386aeca6e8698076d1207aeaf44

Best regards,
-- 
Jens Axboe



