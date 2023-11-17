Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XAfiWi46"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F2A5
	for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 09:49:22 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c875ee4f10so1027717b3.1
        for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 09:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700243361; x=1700848161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yam8G6FwKOwI0HHQbkBX8TJUGIUkTiuJbTuOE94zk5s=;
        b=XAfiWi463V3iU20ukaVnQYsLLWiBJ/WPdpRN4+mrgUSvfOm680l47SYubynNpcuvpw
         2s0ApTocaP/3iDbHlV9KwTSTp/RR14upHDdvmDPzcnlVYZs/P2M6PQg69odPY5i5i/ky
         3meP54W2ujrbMculXlNwUSJ8n3Nzf2wXPdnLMwK4M5KyZcJsPV9IOjgl4I7Cvjen+siZ
         zXA2Oag9M2lmUTQaRGYA8KiI6M6W1Qz6S80bNwZN0NdaK4R4pmLUmQ3152n9ej/hFbMx
         PfJbbxnb/QfuFkfw6jCJs+2abPWdZM1Yo6WFASK87ehOWd1t82K+4LYrKTPwLfP8EIK2
         ON7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700243361; x=1700848161;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yam8G6FwKOwI0HHQbkBX8TJUGIUkTiuJbTuOE94zk5s=;
        b=OUl/luTWUvfpH8PjZpjWwytJ/yYYhpfHkZ/IYhrYK5mD5FaWnD0Im2cHCZpNwZ1gZT
         8jRB9dL7jMDKYi2JwU7hghmi2/hQkLZg/IG0SQHR7NzHH3D/ZxcfFZvAikm9eJRNFPJO
         U6puUGFi9On2c1ElOa0f2ypwzvWxIAkO7tJ4D6Zwha0pe/9NxlYjQ1uLx0yO7+b+QVqR
         zixi7V4BdLuiRriAjEO3zipVhcDmNxrrkVMYjAOMptZtF1GYKQGRiPHH6lXCPp0vWN9n
         ntO0RZpZ7ukI50/CN44YrJrp5Yd0d6Kpxd9ugdCeYT5V8mEzKQ+rMSoC2XJIWOGfPDVO
         kl1w==
X-Gm-Message-State: AOJu0YxJ6ioBGcOGfmCsBzXzKBS8hk859rZyrZWftuI7faoG4gBJmEe3
	n8slsVlpIKLmBsXfRNYaC4jwmBkbD7hwvIZtUKdbPw==
X-Google-Smtp-Source: AGHT+IGmTZOY1+ZP5gJweNT3w6oYvGf/CWL+wMEc43o1f3i6SFUl6aMTs03Lp52HAuV1NomQvn7D0Q==
X-Received: by 2002:a81:9a8e:0:b0:5a7:af72:cb55 with SMTP id r136-20020a819a8e000000b005a7af72cb55mr326326ywg.2.1700243361593;
        Fri, 17 Nov 2023 09:49:21 -0800 (PST)
Received: from [127.0.0.1] ([65.199.232.106])
        by smtp.gmail.com with ESMTPSA id i133-20020a81548b000000b005a206896d62sm602031ywb.111.2023.11.17.09.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:49:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>
In-Reply-To: <20231117023527.3188627-1-ming.lei@redhat.com>
References: <20231117023527.3188627-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/3] blk-cgroup: three small fixes
Message-Id: <170024336093.765610.12724227238108173300.b4-ty@kernel.dk>
Date: Fri, 17 Nov 2023 10:49:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Fri, 17 Nov 2023 10:35:21 +0800, Ming Lei wrote:
> The first 2 fixes lockdep warnings.
> 
> The last one tries to deactivate policy after blkgs are destroyed.
> 
> 
> Ming Lei (3):
>   blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock
>     required!"
>   blk-cgroup: avoid to warn !rcu_read_lock_held() in blkg_lookup()
>   blk-cgroup: bypass blkcg_deactivate_policy after destroying
> 
> [...]

Applied, thanks!

[1/3] blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
      commit: 27b13e209ddca5979847a1b57890e0372c1edcee
[2/3] blk-cgroup: avoid to warn !rcu_read_lock_held() in blkg_lookup()
      commit: 35a99d6557cacbc177314735342f77a2dda41872
[3/3] blk-cgroup: bypass blkcg_deactivate_policy after destroying
      commit: e63a57303599b17290cd8bc48e6f20b24289a8bc

Best regards,
-- 
Jens Axboe



