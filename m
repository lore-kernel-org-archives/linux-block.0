Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332B263F4E
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833108; cv=none; b=ay/6p4dSHwm0GjsVN5RMeyI3ZsA0I2Y6BQuuLVZ/CQ5U8iLsgNbmfStxJbrptt3vOMxMaqhwMPqFH/qJNoLqqOIgl4zjCMoyW1tuWLcSwvtYJFUEdB/ckvOwTVZinP23xavpfwmUlye27cqVIY2eydp57UOmZq4UOTuJePma3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833108; c=relaxed/simple;
	bh=KA/1k6dL4O0oHrdD5JYTUNRz5VVYfHtgmC9vbfXDJEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HZhkbNaSK0SXaPznJlnyg9XF5D/TuDZOsXvCbFiY6tvJVYGigYvhzbMFZwmOP7nDTPbzbK79ZJK2bVBVLkZGcLdk33OXs+kXcS423Rvlcl6W65iR119xhgoQAXKyBjzvqLVz0j30YjzOShloRINSEFjZ+T5XVuS0MWdl2jePibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jvoLQvfK; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jvoLQvfK"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da8e1259dfso50298475ab.3
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747833105; x=1748437905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O/QLSEHglCnX0dczH0/O51NaGvFooTHNgYfC5puML0=;
        b=jvoLQvfKseQ/CYVLR3jLGmcqYXY3dpU94pWm+/9zHmzTWTn6m4nuqVKwBz4tm3rMrd
         uRzRGYAd696VCoADj4VYWqIr9NWkWJjOGO2ottS4DwTYImQ2CwDv6NoXZ3O3zXugrjH2
         j4LNuyRDt+jIKCGtXyPsa07mxQTy8DOCGthJ24CPUhQ335RZIIoxZNQNvuU9HXjFJbe6
         4U3pgPOMsC3YS+AuPBopwBmvlMVorXLQZ0BucuFI7LY+VxNOe1Bj49EVBYPUb5jlE0aM
         ejOGLG5PQ+IOD9q2hlTvdSeBrAaXJ5GKNFpi5/5G8+2RPr/rRVnn9fcYxEWBTpimH6gq
         2KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833105; x=1748437905;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O/QLSEHglCnX0dczH0/O51NaGvFooTHNgYfC5puML0=;
        b=aYOuXMhaTeybGEMj8Wp7rBIF6yzEysthmJrlPCcM/38wJ/76CKEYEsXx5nhZX0hkpY
         1gDWz9WPYza4VDEyftN2D+5ov/ctWpuXHXQvl7xAEb+5DyYTE9983D+ylWrFWOXX4KwR
         ADFLd4jxxiICJKC2s3cY5WUz3YoFPfyVhjbQDQEca/1YXMT0Mm8+kYymKcCgF05Tg+Op
         7ywMLkstNOFbnfQ/6yJi29XBBMGopVLodIMRxVi8v1ZPVD4/ZwTalJEXGGC3ESOtH/QB
         NFMnwIDTZRl9+GEjpNByWRpNTzL6vhpmhD3hOZJw1VGPfWGjZxEBE6kU1qZZHkOFf93R
         aKxA==
X-Gm-Message-State: AOJu0YyxzgRU25CpAfMZLyP8hRQOXFjXJC6G7iKdAY/WxndqkZNsOEW3
	l4qwRtd7yTD1eEpmgfrrWCnSBfUF/DzYbd71AW+Iih7cWujIJSb6bNRn4OMiamcvk+l56MzPW3L
	zFYhm
X-Gm-Gg: ASbGncuZ3vQLs3LFI7hTz2ZQ0XyzJMhAZoUvI2m1CJSB6hR0+SErOIff4LeH/7Y0UDC
	7iORLtIfNuQeY5xU1kLQpZ0/cd8858jT62X5lLk8mGb7gAK5yyL7uFEaYPNfRgR9P7QlENAns5B
	pC/9fPjCIU/ae11UIzDeqnmWKL71J48PpfrpuF0r7nVDYibqarhx8hPPPHZj9tfBhYvQZA06Tp6
	xd8W6QnfabZtHbMEm+IiSViuLr3FjK8oF8iOISlLBIWNRfPYvcwjkB7/88ltTAYaFG9LGJXR8LL
	Pjc/3LbyPx7kiya0+uFKA6qviv9nqLVJHpn+6NBxAg==
X-Google-Smtp-Source: AGHT+IEjswRosJC34ZBchles66CpYE19JJHgrAo55JBHtOwpPoypxe/nmpkaDhiHjutF5LTQz1yByw==
X-Received: by 2002:a05:6e02:3184:b0:3dc:7b3d:6a37 with SMTP id e9e14a558f8ab-3dc7b3d7069mr77803955ab.8.1747833104759;
        Wed, 21 May 2025 06:11:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3db843f7fbfsm29716295ab.43.2025.05.21.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 06:11:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
In-Reply-To: <20250521025502.71041-1-ming.lei@redhat.com>
References: <20250521025502.71041-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] ublk: two fixes on UBLK_F_AUTO_BUF_REG
Message-Id: <174783310404.804195.9704387738908088189.b4-ty@kernel.dk>
Date: Wed, 21 May 2025 07:11:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 21 May 2025 10:54:58 +0800, Ming Lei wrote:
> The 1st patches fix ublk_fetch() failure path for setting auto-buf-reg
> data.
> 
> The 2nd patch makes sure that the buffer unregister is done in same
> 'io_ring_ctx' for issuing FETCH command.
> 
> 
> [...]

Applied, thanks!

[1/2] ublk: handle ublk_set_auto_buf_reg() failure correctly in ublk_fetch()
      commit: 5b2a1c40684ba59570b302a56de31defc8d514ee
[2/2] ublk: run auto buf unregisgering in same io_ring_ctx with register
      commit: 349c41125d3945c53f2c3d48d7225dbdd2c99801

Best regards,
-- 
Jens Axboe



