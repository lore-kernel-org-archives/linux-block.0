Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C6C152
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372735; cv=none; b=VaL1x6wiu2lvuBYNiV5OBf3vr2UHfiEQYukoiY3fChp/X9u6bnk2b+Fc6eMG+C3SGLWge/fCfvVCT81GS/sVCxkhHhL36McXc5xlhAIF6WJ3P48hMDHFaHoS4mVrxM5rUGkVUvPKJMWUBrzHfhiO6om/AZxdks7x3FVZ0t8tMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372735; c=relaxed/simple;
	bh=bkw/wY75bOQcJPR9sExzb0NjpK0DZZ2z5tR/Pyk+NQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kGl143Ls8qhLEhhY/rt7pxU2uXo9gg0yZfIN5BYAPYhjhGHm1EeWHDqj87Mm/+zHMH4IoKbAbs+eXcmaELmQ7RRn/x9CPs71XAODAIYJA8WJuxR39ZUSi78rNHGKI/2QCup9EocPYBCN8trSyOW8nOuk+vIHRbl0Zq6AV8y9BYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xGiXGTEO; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xGiXGTEO"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-254e7bdfac1so171699fac.0
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718372732; x=1718977532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwHxi2gZBAyY9Pth3TgUjB1fWtcztmwkH5X6Og4iAe4=;
        b=xGiXGTEOhfgEbKEFyRWOg6I/pC9x7x589PfnPJk93gj1WAdyCHk2gHWcGHokTRQRev
         QaNPnFngnFIYygJhYyyO6FpIJ+MSe9+7jRYx+6fkoa9eR1Aft/nRlXA7s6+z4Tt30gDl
         ZbcFWf/ZvXLGN17Hth8n7MlTgfbilkP78erB+SH/OvRDIsIa3SnbBcQBhkZ03UhmUfwr
         r5yJb0bpo+aelDqjgcMu/8IlH8Sw/0snBY4iOoWenO3cL4u+P6VoF6VtcDf0eRkTTlD6
         obSl6EUdQstJRGGoItUP2ozmfj37yrzdls278gm2a8yBwVd4ECGSi7fq7KgLtD0OxCwr
         JE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372732; x=1718977532;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwHxi2gZBAyY9Pth3TgUjB1fWtcztmwkH5X6Og4iAe4=;
        b=jqxDv81ZA/TpnrXvJgTcDfQfJzjG+5swCL1cAdOj+nu65IPrtRvHqWhcuvUEDcpHLx
         mT4Bxd1+VYPNTNDy2fAy8xA4lIoqvJRSAzSw3/kEV8Vr+JFGQL7Od3abVX7Uihg+P0S0
         Dn7V05gKVStLUaiqaV3786Ci7lEhUA1z4qb60YhcpmHpfCof2apRBfbUITj/ytY5ujXl
         LY6Y2czTGTTrkSnfSs47sq/MS1JKFDYsRfZtTY848cygL6N1EZLH9gLmihBDohtfdOPA
         tG2XozOTZRTN8/8NCeDLv0Ul0Qf5ZyhjOzeh9c560YDhxw9XoQ0hCYLWFlfPgYV4xnMy
         w7yg==
X-Forwarded-Encrypted: i=1; AJvYcCUcCWYH6IHyGO8IcymP2mXsbZtjs4Ij237jcFovlMLzZHdX2LG2pAQ+nX4AkKlsj0FJHYkbuslUMRU9HyOC9IeZaokCx3ZXvTbbyyU=
X-Gm-Message-State: AOJu0YySA2fGbSVNMidS86OFnJ5Vz1IfmWKcUKdXv6WE7h3XeaPil2j7
	TJBAwx5tA/W2Oe68EyT2nrTn5//7l3/Jh1YwWbkZuCJ1pwcsZSvXuV+oQoD2Ay+bbd1vxnadlbw
	Z
X-Google-Smtp-Source: AGHT+IHPJ3jg4O4CayCJVLz/XAlaPDCafPLLXbngTwTHtLC5YfmxuMPfjWHQ9h4w7Y2VgmE0awSFQQ==
X-Received: by 2002:a05:6870:f112:b0:254:7e18:7e1a with SMTP id 586e51a60fabf-25842c5e66emr2860477fac.5.1718372732531;
        Fri, 14 Jun 2024 06:45:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc97fd59sm3043883b3a.84.2024.06.14.06.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:45:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
 linux-block@vger.kernel.org, Andreas Hindborg <nmi@metaspace.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, 
 Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, 
 =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
 Joel Granados <j.granados@samsung.com>, 
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, 
 Philipp Stanner <pstanner@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
 =?utf-8?q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, 
 open list <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
 lsf-pc@lists.linux-foundation.org, gost.dev@samsung.com
In-Reply-To: <20240611114551.228679-1-nmi@metaspace.dk>
References: <20240611114551.228679-1-nmi@metaspace.dk>
Subject: Re: [PATCH v6 0/3] Rust block device driver API and null block
 driver
Message-Id: <171837272952.233538.14745417711842930177.b4-ty@kernel.dk>
Date: Fri, 14 Jun 2024 07:45:29 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 11 Jun 2024 13:45:48 +0200, Andreas Hindborg wrote:
> This series provides an initial Rust block layer device driver API, and a very
> minimal null block driver to exercise the API. The driver has only one mode of
> operation and cannot be configured.
> 
> These patches are an updated and trimmed down version of the v2 RFC [1]. One of
> the requests for the v2 RFC was to split the abstractions into smaller pieces
> that are easier to review. This is the first part of the split patches.
> 
> [...]

Applied, thanks!

[1/3] rust: block: introduce `kernel::block::mq` module
      commit: 3253aba3408aa4eb2e4e09365eede3e63ef7536b
[2/3] rust: block: add rnull, Rust null_blk implementation
      commit: bc5b533b91ef0b8a09fe507e23d1c6c43c1fb0f5
[3/3] MAINTAINERS: add entry for Rust block device driver API
      commit: d37a9ab8331cfc0fc2eac0480f0af624c0144a92

Best regards,
-- 
Jens Axboe



