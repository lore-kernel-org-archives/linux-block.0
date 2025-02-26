Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95821D3FE
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580328; cv=none; b=G/Wi3ARx9/G1wJDjVHmrs6voTdLznH/aPkg+P2GE6RCdgwYRXj5tz5gDSkKmkmAjZ16pQOw3p8rY8JFEZpuxMTCaoHzjrWu/vbLErkTjBq0RxaLA6z9r74V+zZI+CMFBOiVZ5/DGVU1cl0/RF1CrnVFDyw5eGlJM7zaIZ4Zs/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580328; c=relaxed/simple;
	bh=fMVSvdO9Qk7XWWOU/kG7NyzMG+VeN5WdRjOKq8C7m9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jh8j8jHRmEs4TISBhDfU/Dj15B3iDt573CaPxMZbmPkDJ4eLmP9B6HMMgWaNG/UM96Qqv0h2P85+YlULwtUYqIPJpkNZzY8KZprYAv0ulbsDgTT8ZSLt7fvvfT/u15yeCB7Cxjm+Zq/bxZu7QwS+ywye8ueHD10wdd4TYEdj5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MUqMlJkL; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MUqMlJkL"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d2b3811513so3159495ab.1
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 06:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740580325; x=1741185125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trZK1Q0XJm3EAQhjNCUlku9wqjbsls2X+EuichAbMRQ=;
        b=MUqMlJkLnXRu2zadwbmb28wbke+nzPeyqUKHL4eHpRUy81Szhy2oeYrFFX2Ig/FuKh
         3i0pUJcrUdsCEqZJNGK3OkUFiweEPOVLCeloT/Nvk+Qsmq/7AQ3y3Fr9Vet5orTiFkP4
         CQu2MLeurK2yIGcWNZQlWScGsulXD6gKxXfPDDvuPO69LPx3OhD5N07+feV+Gt9DuH1o
         GTCGKnGUPEItwSzuCc+sp552y2UNpQrWY0icbB6qEU3lgSPBqqlYAoyxr2SxygX873EM
         es6Zvi0iIUXgRJomuSddnLzfbfv+T2a/ZI4W0Hxpe/jHLXVHwaUrpHije/RU1jfAJI1p
         KIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580325; x=1741185125;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trZK1Q0XJm3EAQhjNCUlku9wqjbsls2X+EuichAbMRQ=;
        b=Ym9VKG6HfM5xiEp1XtxedegCkxflHISoXorKdySztU1ePZQCs20Z9eyYYTvf2Dk8Ay
         C7QVfgWZXxMOeCqWTR4pi0qEkZVBK1LCthN/N9NVvYYBUEeTKNBXAgYrhFuwIgTCiIWe
         ndLQIN9hs2p/QHwAHnxRDElj+pFSTggRoxI/9EVH50lT21OYpFg8CF9AugDGSMTCTwI4
         WlKQ1wTQ7aWwGQYZkoUR5zFlBzxi3lkfOV4Td1khNvmhNeOX0VQlPRuj/GWa9EnhDJW7
         Cz9XlZC4JUAUeBPaz20vMCfQIioEiKFq2EY2L6zeEO6KKEHEIGIWyiUfKNBMhoDtH+oy
         ou/A==
X-Forwarded-Encrypted: i=1; AJvYcCX8LVZJfawSByX+G53ImlueWMW45Qkbk+M+2Wyad22otvxZJVKQ55Jif/Nv+9mUpVRZr02toK+HpRjy1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9rXUd3F7GMA9Y1iq2l+i7wOKbyASSndZMrO+m98TBM73yX/x
	hvd7g4/SXwFAAQi5i5TyqSXNgKR7effaH76rdFsFOzrzq7/M9O4q1EBR+f45o5Y=
X-Gm-Gg: ASbGncvQcU5JICWB7FrYimgu+yrJZA/9e8A7F772tIollh2oXRhAtEYhXtb0cs5A2P9
	S7F5mKIHm0obOm6r8/lZJ7j8GCTFHQigdqMPGFjeLJ9cNTJf25Mn9u1tkooIyBTzT/V8V2gJgE1
	9qy8yLcZNsFL27T+00KKzOmrRxJpZri+ItoXopoGB4OdslClSKV6s5+CnCoHDAnOC6QIjZi3SvV
	LqcleVgh5dFpjaG5uLQ5AxD/EUFCiJvwFU2rNiwZ4MEX2QTINDXV6H4kkFwo8lTzTLdiT7Rf18K
	+kGqrkPt2ewdHB+b
X-Google-Smtp-Source: AGHT+IHabXtiuY9p9FWUehezndCWyS3XMFRLX6LH+PTKhkqUOLGI+DxXj2jxDHmMWTb/jH8LLzzPVw==
X-Received: by 2002:a05:6e02:791:b0:3d1:9bca:cf28 with SMTP id e9e14a558f8ab-3d2c0239750mr196114715ab.8.1740580325652;
        Wed, 26 Feb 2025 06:32:05 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04744daebsm908534173.27.2025.02.26.06.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:32:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250225212456.2902549-1-csander@purestorage.com>
References: <20250225212456.2902549-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: complete command synchronously on error
Message-Id: <174058032466.2230500.13734000197859662068.b4-ty@kernel.dk>
Date: Wed, 26 Feb 2025 07:32:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Tue, 25 Feb 2025 14:24:55 -0700, Caleb Sander Mateos wrote:
> In case of an error, ublk's ->uring_cmd() functions currently return
> -EIOCBQUEUED and immediately call io_uring_cmd_done(). -EIOCBQUEUED and
> io_uring_cmd_done() are intended for asynchronous completions. For
> synchronous completions, the ->uring_cmd() function can just return the
> negative return code directly. This skips io_uring_cmd_del_cancelable(),
> and deferring the completion to task work. So return the error code
> directly from __ublk_ch_uring_cmd() and ublk_ctrl_uring_cmd().
> 
> [...]

Applied, thanks!

[1/1] ublk: complete command synchronously on error
      commit: 6376ef2b6af3bbcb7c50dc657bdfb83aba467aef

Best regards,
-- 
Jens Axboe



