Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A557A708
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110262; cv=none; b=kmZL7IR/b6e+fuBOrVJM1jImrEix5CjAdBeL0LkHnetqXNb/jGv1DOjJe8MnU5a6U+9llFFByDoitmtzzOAsCpzNVwidf2/kYctybfourmFdpRjQIUhv6CtdtsyNomsJEHgzc4+aP351rFEuFUY3N5+iKdqIWLLxBcH0KQu3WZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110262; c=relaxed/simple;
	bh=RoQut5AVHZuhcbsg5rERP3+10LBVd5UTRpunDEoOXys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rQRVd//D4IzaTVy96konveaIAXLzXKDf5emToMyjEifSQRyocUZcOpS8sioUN23TlRSYApfRL/eN8Dg1W6VEwUwOO9waRuro3TaY52Tw4uZDUuB6Bat4swCanc3FalpZcNleaV/r4eZ7I2Um+YPpY9dR/qqRJ0BKdSlk0dMJnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3ClJx6cS; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3ClJx6cS"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bed82030faso73958339f.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 07:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706110258; x=1706715058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv4/8CDW8QIlduDHXHHg6GE3LBQ6HZvZ3aGnmpvuq+E=;
        b=3ClJx6cSNtblLTPIBhe0FvfG4QYncPrN0slzIyn3sBYELAW80YXz2NBB0XG2OhuJIl
         Z71SX9nBY7HtcY/wsmdrPwSK/FoJ+YKMj5x+Bo7xGoBmRAoS3A48FPlMSivGddMY4SwJ
         Lmtfd+ZWrZ4DJs0xEE5l3yV4snRNyVn9VvMlPD/x0N/H1KQ2S57QsCXq7cVV+hu8JhRy
         K3ZvA/iiG/jo1/IgkqN24qJy8WuafJ2UeihF/Q2+MqNpfaX3KUKqzTC5ykhUPmWFAy9E
         ++bkPzCAickJ3NQX/j9Ndkbg7DhPlivUqjZ22uyGcHjSGEQQhFCpJlG/C3u9/CesUmMT
         ps8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110258; x=1706715058;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv4/8CDW8QIlduDHXHHg6GE3LBQ6HZvZ3aGnmpvuq+E=;
        b=BxgQ+C+h+Kpq3ZKqoj6XnTHTfgKCw37DnD3oB6HyHq+s79i7btX3sVDkiccnI09vLo
         YR4N3bv9V8tg+HFQqrdywBu4e62rwOBiccQ3EY+8ICHshbg5Aj0leYQK3FZr8Jdeuwjd
         00WDuKf1kcFIjbBUvTLApfO4R9ouCxAroX2JRy3lFcZIuTqnZ+oxjRfceaNv1XMwYb+n
         /aWkBOopWOwE/TDd0IWx8GjRLQDw7RKRcLjYChHfZ8xMDcMMdSjepiBEsC+ZVkcI7Z6O
         3hJqoodEVfF6TpfwG7b4+oyFiGuyQ3pipLXPM9bJK5k9nlVbe0lIMfiVlgXYE5MASVxd
         GPXQ==
X-Gm-Message-State: AOJu0Yzv3Cn2PPDmTJZn6qxWM9IF6p+gmI44+ixulCXROjZ7PHtbhw2m
	fBs2UIK5WTzC8IqI9NDcCfzLSjHk5dQxaNSDS7o3wBRXHNhLqpBxRn9aRd8Gzm4=
X-Google-Smtp-Source: AGHT+IH7F3rrjrPWkFhZDQe8Kjz8JwG9WX12tOjmn6LkuKcDAei6tT85d2CDl7oJ0hRoJWTK/Fpvrg==
X-Received: by 2002:a05:6e02:1d95:b0:361:969c:5b4b with SMTP id h21-20020a056e021d9500b00361969c5b4bmr2895875ila.3.1706110258312;
        Wed, 24 Jan 2024 07:30:58 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o3-20020a056e02068300b0036194d1dad6sm5297438ils.40.2024.01.24.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:30:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124072436.3745720-1-bigunclemax@gmail.com>
References: <20240124072436.3745720-1-bigunclemax@gmail.com>
Subject: Re: [PATCH v1 0/1] aoe: possible interrupt unsafe locking scenario
Message-Id: <170611025731.2148128.9958144886915388505.b4-ty@kernel.dk>
Date: Wed, 24 Jan 2024 08:30:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 24 Jan 2024 10:24:35 +0300, Maksim Kiselev wrote:
> I'm using an AoE device on board with D1 SoC (riscv arch).
> When I enabled CONFIG_PROVE_LOCKING option, I got the warning below.
> After some investigations, I made a not very elegant, but working solution.
> The patch sent with next message.
> 
> I would be glad to know what you think about this.
> 
> [...]

Applied, thanks!

[1/1] aoe: avoid potential deadlock at set_capacity
      commit: e169bd4fb2b36c4b2bee63c35c740c85daeb2e86

Best regards,
-- 
Jens Axboe



