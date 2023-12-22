Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEF1CA9F
	for <linux-block@vger.kernel.org>; Fri, 22 Dec 2023 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jSx+jrgr"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-58962bf3f89so320179a12.0
        for <linux-block@vger.kernel.org>; Fri, 22 Dec 2023 06:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703254723; x=1703859523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A1glk9zKLbiBtT4KFCCjRYLUlE9xUXR3enmqVpuLXQ=;
        b=jSx+jrgrRBLiFkDkr+VNswXXg3e9UWC1gfzosIv61c31nWhz6byvcQRJ+mx3AZHTwM
         4J6s+7FXY7lYcGq+hHCqNntkaCsZ/C9tpcub1+ULXwCxkdhIoWubjDxH/5NScP+Yl6kE
         5jKpeYakcn421iZ2CegfxE2zJc97FvJ0y2pCdG0a2UstXLTckIgFynMHeewR9zybbBNv
         jM3aPX/t+4kQlK89NZdlu7nMtqeZF875TlsVIBex/qoj0dfbN+tVIONmd+uKir7pTQZI
         iQIa7OvWUeuYOVRaKaHcQjcBVW0GYrKy6N04rAUd7ZOi0hG0dh/xPHBGlqodJUbeaYH5
         kcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254723; x=1703859523;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A1glk9zKLbiBtT4KFCCjRYLUlE9xUXR3enmqVpuLXQ=;
        b=qBcrsZBtmgXc5aeLvB30H/UVd5dZY2HulPeg/wpzhvz/xVb21TuG5mHZPNdIJfy4pB
         m96irflNMP8gMn+u3dk52WuYcvcBKjpr3lcsgQyKevdhw3f9TI3Ua2Gx0vppnLA2mms0
         Mh6DRSMFTY+tdguNvHI1rCKxvhyBTXBYbbnWIVJShvXex03nlBVMlXjN0y8GGD8pSSa5
         7FYnjlqZITX2XQe+nxpHe/7smXhHRafsW9nZDifsuQdCUT97ic5Uilr4/5+8odzYsuQ3
         IxagnPvxxt95s66EwQtSFfuslORYBMT5oGN0Sgq1n3c8/TUthIzsskr269baoKaLBB3+
         8mQg==
X-Gm-Message-State: AOJu0YyzmMcOYCAEgbLQUjTi4xfQGzYKxZjXZ+Jk2vaVcNKj6ZPbmXYQ
	fyot7Zmk4Y8xbzp6qTM2ZMTqK8JB5Z3c9sIjCmRAstet1+174g==
X-Google-Smtp-Source: AGHT+IEXHhpBdYu7BG4iQynwg6T9KXzttfdwH9ZhmEUK/VNC9mBrZ2I1QMoe3R581uVguT4YpbBIhA==
X-Received: by 2002:a05:6a21:99a6:b0:195:3ad3:b6c3 with SMTP id ve38-20020a056a2199a600b001953ad3b6c3mr1632140pzb.5.1703254723215;
        Fri, 22 Dec 2023 06:18:43 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id e16-20020aa78c50000000b006d9345189b1sm3498980pfd.36.2023.12.22.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:18:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
In-Reply-To: <20231222061909.8791-1-rdunlap@infradead.org>
References: <20231222061909.8791-1-rdunlap@infradead.org>
Subject: Re: [PATCH] drbd: actlog: fix kernel-doc warnings and spelling
Message-Id: <170325472218.1024948.10134238740797741096.b4-ty@kernel.dk>
Date: Fri, 22 Dec 2023 07:18:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Thu, 21 Dec 2023 22:19:08 -0800, Randy Dunlap wrote:
> Fix all kernel-doc warnings in drbd_actlog.c:
> 
> drbd_actlog.c:963: warning: No description found for return value of 'drbd_rs_begin_io'
> drbd_actlog.c:1015: warning: Function parameter or member 'peer_device' not described in 'drbd_try_rs_begin_io'
> drbd_actlog.c:1015: warning: Excess function parameter 'device' description in 'drbd_try_rs_begin_io'
> drbd_actlog.c:1015: warning: No description found for return value of 'drbd_try_rs_begin_io'
> drbd_actlog.c:1197: warning: No description found for return value of 'drbd_rs_del_all'
> 
> [...]

Applied, thanks!

[1/1] drbd: actlog: fix kernel-doc warnings and spelling
      commit: 8aabc11c8f4e0a57661a07f985ddc8a626ef9148

Best regards,
-- 
Jens Axboe



