Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B235C199
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480325; cv=none; b=pIJgAgQtorHn0g7HXhTx9sN5HjBDkv3uJYYYi/VGmllkG0FQA772Xo2dXUTgSkOBpNxzTp5H+fIF4Wn2Hvt5+DycoFVXHOfDPmLr8kGP+VLNFeMoyzwEZVu4w5YipnMbCvnDuFyPM1ZWPhb7SybdIK5IRhaLzr6QhSyEOPHtG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480325; c=relaxed/simple;
	bh=YyuOw8Q0/T9WgtH+0EJO2hSUuWsaXIXtzFZu3JVN8TE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sPxHKnWmArfXGAUfwUj66e6R0HNwJrFN5JSLFQFv0m35bPKccfmON26OX7obujGn+SnIXDNIciwyO/YO27TJ9Bq4zj7njC7txq3MVwxQKSSgwtM8sMYY5v9YE4I32qJNHsGg+XLr6CrSWP19fQ2feY7CwQJVwkuH/9hDyU+XY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VwSVSiNT; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VwSVSiNT"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-433100c59dcso23323175ab.0
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763480323; x=1764085123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4AZ1H1F7o4dF87ZOWmvmXAUCUSSC9J0kROior/lM3M=;
        b=VwSVSiNTGI2tPk036y37SOt9byPS2rcnvhmwlPoqokH2wM6my5fzzYTgVKVR/y2tBl
         FD53wgvLHhTF3mcyHxhjcJitaBYm5x6lH+8hnAwhMNikE6Yw4+M74/8Vd9fiXA1zK0G9
         lY4mCyurVm/5oP/mr01YlbkaOiNpiZ5S8j+4fcQVw7yM8wEN2TEyVZ+Vk97QsnNmffiq
         eaikFJTO5tFihX4nRQOBDScWxB8fJ6ti3uzvGsgpysnnUqMA2eJgjXvyJkHSQ4VbGtfo
         SbSJnkSbHMWHTTBlNE/5jps0vUUwuoigz3aqzzVRl2LSm3YxyzBONOUBNZK2Bd38RFuL
         S07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480323; x=1764085123;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4AZ1H1F7o4dF87ZOWmvmXAUCUSSC9J0kROior/lM3M=;
        b=d9TfBgr0W+jNEyWqARDm1fxKVBWs3iCKHWPNzf3LfQx9bIJO7irRrdgDYBhTB+7nzT
         Cj9QxGU1jPL48kjiTYNGC7nNTJtgrfIEXuZr8+CKH0ygiMM5P0sl153QPsoSeAOSqdaM
         xFvC0Iu1tNfAX44Cuf0/W9fu0kt7hrwbrY+dPKa0FKF+FCnxSNaH7QKK/Wn7FEmuYB/S
         XqkNpyvIc3yKn2dc2hebMuqeWZFj/jr6Yh05YQtICAFGy95kON2S1DfJWP4SppPddvUE
         0Flr+stT7dejX+4HeSVywiXNWHPkdWdJn9uC3ZvdBXzhPVywLT4DnwnF7f89/suTiJQV
         2i9w==
X-Forwarded-Encrypted: i=1; AJvYcCUJFBDuGPYvnJe8YVCXY2AZX/e0Fxs+X6vmcnqmXzHqJjYqlhgkxzoX6j0XFzipr5KzVNIH2/sWNfw4ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5o3oaYSPvTN0G2pFx6/rBJYm8cRnuH6CH1YgTz8XHccjhxS/
	a4RvAVYUAKW9LANerEh7CNTySZlmTlRjZvOsIi++rhhEkGjR6F6Sij2dZlnCliw9dXk=
X-Gm-Gg: ASbGncvzbh7BTpFjWdNriv9Sp1YrWqOOybMqMqapu3WtwvnSyFCQzcpVOVKQ0bEYS37
	huNa6rQt/CwW5SAZzaFQ/dxEkWtX+zYYjc4n62TPZXgVfDAaQICzGJWrjSh6aZQ/WjLEpw2c7Tb
	9g8CDvFYAy1P+zYsMoJ/dKLRAd2uwtvzpPKLxQRr9DzY9UgDssxqhFqXPiTuLkw7kSjG6zBQD0w
	gjDlRw5sEyQ2DT4ERjfWWbOUnxpFeKOo+Q7xGqMFCntUIosMaYBOgBaGG/obdecDdLITYeruBhq
	3si1DGQ6NaJhp5byRpcg5viZmRXnT47ONExQGYj6X682uRIjaFZITsMvnM9g0dmw+RGXqaSGwIe
	84bKPqxYf4NzGMwU7oJPcDR7TClLp2OrnLFE7BsIBTfQUQFzoYduvODifl7q4nPX7pQUp
X-Google-Smtp-Source: AGHT+IGOAjl+lk3/PXczazt18iN7tgLDRPZ9uWyfZPv0T2taK+010OdOmJFclvk8hgGche1I/bPH0Q==
X-Received: by 2002:a05:6e02:148d:b0:434:96ea:ff5a with SMTP id e9e14a558f8ab-43496eb0099mr158039065ab.35.1763480323213;
        Tue, 18 Nov 2025 07:38:43 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434833e94f1sm83498515ab.10.2025.11.18.07.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:38:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: shuah@kernel.org, david.hunter.linux@gmail.com
In-Reply-To: <20251118090753.390818-1-hsukrut3@gmail.com>
References: <20251118090753.390818-1-hsukrut3@gmail.com>
Subject: Re: [PATCH] drbd: turn bitmap I/O comments into regular block
 comments
Message-Id: <176348032225.300553.3972505243693659876.b4-ty@kernel.dk>
Date: Tue, 18 Nov 2025 08:38:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 18 Nov 2025 14:37:53 +0530, Sukrut Heroorkar wrote:
> W=1 build warns because the bitmap I/O comments use '/**', which
> marks them as kernel-doc comments even though these functions do not
> document an external API.
> 
> Convert these comments to regular block comments so kernel-doc no
> longer parses them.
> 
> [...]

Applied, thanks!

[1/1] drbd: turn bitmap I/O comments into regular block comments
      commit: 2c6d792d4b7676e2b340df05425330452fee1f40

Best regards,
-- 
Jens Axboe



