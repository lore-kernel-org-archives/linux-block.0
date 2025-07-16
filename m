Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693911D7E26
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681770; cv=none; b=c8JvPvYSctRfPpSj+Dl5KyWWUZcz322wNNYO1EzxLiHxMSyH9eRyNYWPB4MJccUWIfOwpAp7yCFKFl2BrQ3/5F90JsjlFg4rE7hkHEOAHdTDq0rpqHPoOC1YMnUPfdUfOwgZ3Z0bZZ4zUgdyytNd0lhw/UXgnbXlQYYViPcYyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681770; c=relaxed/simple;
	bh=vTcYX7fNfoQTfQukGT6rjSXtIcvhhfSy0DYv3Ah/+/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S0FZ9B0CoAQFVgkzCTPrQJeUuw2nICLEKJ51UzgFIgAWJdM3DXgGd9jFxWsS4zPMWNP+RSC0c40Sgu2xgYw6N5sfjBwz4lI77W3fk/2fc0MScLcCHKdEH3m6cj2hAh69sGqqCgeX9K26gm9IwXGTQy9nXTfyj71pihz0ezWnK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R+5Jp/o/; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R+5Jp/o/"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ddda0a8ba2so49679985ab.0
        for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752681766; x=1753286566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsIbsnYA3DIl+Gp2Bi4UCyQX5eQJbJ6yj/BF/RV6/x0=;
        b=R+5Jp/o/jhPqs0TqwKEcSdErk5dKMWTpkvt5FE4ryKK6nmXJLS9bzTgFRSrezEVtM8
         MwNUP9Cn0DzyFGHrl8Dq/CLZKVHEjdl+EXwPoqiskRmet1GHs3mVGHc0KpRbQZueHm95
         03qcWIUV4MbLWDjTxr/ZkB4Ieipu2SFv2NU6LuFFcuQeEdYpWZTkE5inZ3x7L4SSGoU4
         CIA+XKzq3vCDtxROcul55b+kkeBA5QqvIld12/dGcUSPls4V+euZkm4OlBrjb05tCP0W
         fB9iWqF+rsKCe9F6axy7uaUZUUJYu6Crz6t6itYzF1tX1HP6V00bVa3EfMfstiqpAfNK
         Lwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752681766; x=1753286566;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsIbsnYA3DIl+Gp2Bi4UCyQX5eQJbJ6yj/BF/RV6/x0=;
        b=rI3o+vYlgi+U8A2pgQ8P6TrVNVTsRhG70Ky3XlCcafWk92QxF7HXyWDZcRc9Nirsru
         CduUyWHqqphbf331KbmHnWKJ4ZxGt9b24P23ANktAe2qHvcBF0tUcWCmRxhfMHBcW36K
         U2FAOWxVwPiZZcxwurnBWIMlZTOgD6cute5uJOUo+/5TGFuZnz4LuSTiLaJFV7/bLthp
         akK2BMTySco2Y1dODx034sKI7PP2Kdd8RZJu9kFct6fgxy8s1LX0Qzz4cG3ashMMFUIu
         miHUJ9bvv7prN1KBDINLXO16cVfKWvQxMzgbUo/ADiJu+GU7bGjTyrf6e+IX8ApQbDDZ
         k6Yw==
X-Gm-Message-State: AOJu0Yzn3qUg7xnb6DAbpoBGoJmIdsc2bhnW7vEJXWzp3dFYDsPm8WPW
	lXvNBzIwEJUzmAC+Fmv8tpXab8JqE73Ebw9QFFe+yrbE6DCrgKIMWFHbAVX7PbVjRHDWZznXw/e
	GupBo
X-Gm-Gg: ASbGncvzrg6J6LngWuUSzP5Pno1M+SeIH0+sQX80CSRk1oRQLK0YZo8oWGhuwERYCyh
	BZ5/iKVkKivC0lhoDq9Pj5waW8k7EHv/m1ltdeyXMjkOBBygu34jD2nbdKsxlYDF3s0HA0SMi2k
	5ig/7GScgcyObhNjHZLJYRbdMLy4deJFfiGir5fU37PkFUvRhRf06aLrJuoEvpzb9FfL47yg0tl
	Msz1VydPCaYr9FilXLfy1/ud3Exu86eG5b8irVYDBsvAWCbWUZ4iO3dvt63gldvpnwFWJoKKseu
	7Fp+IoC8Y5+tMQzp5roOI9RzTOxQKfVMFseTJqTqL1qmsSbj0xrdyZpHbIbW8LmgZxcgRuVF6Xd
	oSYmgS8rqvhCDXQ==
X-Google-Smtp-Source: AGHT+IEUh5NARKjyL5Sq1ywVzH4VA9EIs8xOc+p6cLFCfjRJ02MFZmhdrbh2VmZVLvF8zSpyz3yemQ==
X-Received: by 2002:a05:6e02:2501:b0:3dd:9a7e:13f4 with SMTP id e9e14a558f8ab-3e2823d4176mr37514685ab.6.1752681765828;
        Wed, 16 Jul 2025 09:02:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2462422casm47200785ab.63.2025.07.16.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:02:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20250716133631.94898-1-johannes.thumshirn@wdc.com>
References: <20250716133631.94898-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] block: fix blk_zone_append_update_request_bio()
 kernel-doc
Message-Id: <175268176496.313644.4229551614496959474.b4-ty@kernel.dk>
Date: Wed, 16 Jul 2025 10:02:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 16 Jul 2025 15:36:31 +0200, Johannes Thumshirn wrote:
> Stephen reported new 'make htmldocs' warnings introduced by 4cc21a00762b
> ("block: add tracepoint for blk_zone_update_request_bio").
> 
> One is a wrong function name in the tracepoint's kernel-doc and one is a
> wrong function parameter.
> 
> Fix these so 'make htmldocs' is warning free again for the block layer
> tracepoints.
> 
> [...]

Applied, thanks!

[1/1] block: fix blk_zone_append_update_request_bio() kernel-doc
      commit: ab17ead0e0ee8650cd1cf4e481b1ed0ee9731956

Best regards,
-- 
Jens Axboe



