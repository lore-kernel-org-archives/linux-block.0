Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD6221727
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879706; cv=none; b=A4z4Xv4xZSshRTXYr5UkFOZvY7KDzxnhsvh+5CMTF/l7G3DKCD/Z6ET6z3SJJTkrefVH3d3SbMneBYu1r1VW8gZssMF+MXa1jG7PNW6r7hjMvyN9G5ovQI1UBqp6tcfeDhx7HxYXaqh4D7qJe+q82XPO33dDSEIUvtx1xi9PiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879706; c=relaxed/simple;
	bh=cGWDQmyIK6KEavRjyqGrhlkBwpD6x5A1LRNYzTiLjBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LT348Wrs1qnJr8MlGW5wlHQgKYIhcWqwlw2ws3LZvy3k4GQvb9gSIZzKERSzyFbrcnnIJB0/W6Ss4Ug6mw8Fem+ohs0PoUbb1/TAGxXoO1NsJl7BcOBOZ3hUzAjzK38Uybc4KIlQSBUaAq+yAigxvlW9fC/z+X+/w1WsMpgZ6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x/aCgk/0; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x/aCgk/0"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-86a52889f45so136299839f.3
        for <linux-block@vger.kernel.org>; Mon, 02 Jun 2025 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748879702; x=1749484502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJWA462aorYyyZlN9ByrlEvI7nFQWtQZ5+19hR9danM=;
        b=x/aCgk/0FBMFtkFRfn1lvy7DZccgB6tDRtDcPXAqCeQvn/VtRwQu8ClszL9YKb8rWf
         y+Vh+FArFnEDIzNZPhErbZCdFUcAQuInVYLadIagglNaS3WWo+OKqVah3ehSaXnbGhs8
         J7DsTDC1wbkZI5pq1yCc5XdzI03eCu0AoMHnG9Kb55816iYkn7wVTOL5/n7crI2XUbQk
         PrVFsVyXHR7PQV7tKC/t7bFmULirW95dRr0TzOkybHFeglbxH2hRaVUhgcLZD5YIvNDa
         FOsBhuqtwPTGiAqkvs0nUgS8hqvWVq3vAYcY8evllrKQitBR+6joOyCt8LNoo3u0MEwR
         RKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748879702; x=1749484502;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJWA462aorYyyZlN9ByrlEvI7nFQWtQZ5+19hR9danM=;
        b=nVy9PD2FsVpKBLafIKGEPY6EnjDXkCIVObAFIW6DCVd9c6L3xt8g+8y/YhiyuXIxn3
         rlffzSiR6OtPcnrvOxY90tEInEkUZ8CLCo63G4nmLjOtRn2leWvcSpJEvWaEdquBR1As
         IrOpAQCFHlOoc3e0nIdaPM9yxfmpJ5GUZfk5XfObMMmvjOSAFREUHu3urgF2E8RyT2pV
         o1cDGlviYNGW9LXthTvysjE4tRNqa/NqTYsDr5/oyYl+EeP22PXOBIYhgHom0lx2U5gv
         g6dRFmJ4UvX7+sLEu4gnYY3UDQOeggafi+402BShp7rBNoYKpqbfGsdmrjElsUgJFMZQ
         R1Xg==
X-Gm-Message-State: AOJu0Yx4RYi5pXUXifJ0Un72rS9DpnTiwjA4yTk11B6iF4aNtmTM1ndS
	Qe5CjPnVZKHzpumlQoWTHMu3sylkGGtmF9yTtcuuIzs/V9z7b+Ys0GISS6JB4hZOJeI=
X-Gm-Gg: ASbGncve8AY1LYffe0Zasp1CKNqmSdky84qaLtS2QLG9nsBB13oLueiv0Q+VtouyEIF
	gwa7Pyzr+clWI+FPsmbU4BZwgT0/ICLhmwZZNJJiLhP+g3MBsBUwOuuDBxMRO4xXUXDlxW6hstj
	Q6xi5MI3bdrq3fQBZV87lqMoG995jzxsKJU8xJaZVeD1lYWcpOErD8IrHsjje9L3+bWidnW/Cqh
	1DsK6XP2JSFp7CYIfrH5Pgfjs6/oPifel+KWv+eDuundhR0qzBwredEuuoIy+yqLFGk3+NvJ7cA
	ajaQu9k2fd7q5pddYZh5pP6u/bTerJRiY1G++QFfgQ==
X-Google-Smtp-Source: AGHT+IFfxSbhaLrbPZE0pV/ennFtlwvm8hY2E86HT5p2P3uLKKXmyNSs9DwQY9VIbJOgq3aMDO8zmQ==
X-Received: by 2002:a92:cd87:0:b0:3dd:8663:d182 with SMTP id e9e14a558f8ab-3dd99bf7148mr125417255ab.13.1748879702340;
        Mon, 02 Jun 2025 08:55:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7e2801esm1824842173.33.2025.06.02.08.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 08:55:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250602132113.1398645-1-ming.lei@redhat.com>
References: <20250602132113.1398645-1-ming.lei@redhat.com>
Subject: Re: [PATCH] selftests: ublk: cover PER_IO_DAEMON in more stress
 tests
Message-Id: <174887970147.61479.12673912613922445797.b4-ty@kernel.dk>
Date: Mon, 02 Jun 2025 09:55:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 02 Jun 2025 21:21:13 +0800, Ming Lei wrote:
> We have stress_03, stress_04 and stress_05 for checking new feature vs.
> stress IO & device removal & ublk server crash & recovery, so let the
> three existing stress tests cover PER_IO_DAEMON.
> 
> Then stress_06 can be removed, since the same test function is included in
> stress_03.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: cover PER_IO_DAEMON in more stress tests
      commit: ec8010dd4afde3ebb6457d278a104a2e54deaa32

Best regards,
-- 
Jens Axboe



