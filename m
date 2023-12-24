Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24530651
	for <linux-block@vger.kernel.org>; Sun, 24 Dec 2023 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Gd6ece58"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdf90e5cdeso393725a12.1
        for <linux-block@vger.kernel.org>; Sat, 23 Dec 2023 17:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703381908; x=1703986708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4PCt0BUJxtEtgmlWQFvEAznyF7V0hSV/duRlgdufCo=;
        b=Gd6ece58tBCOaqajBFkBPCiZNOwKE6XX0S/O4JyRd18eSQmW8UcA8nYnqWBqSG2Nv2
         MXxE/0o3b3yh4qV93XBzi9v9ZnOrsj4igGrUu9Tbq60zheJ2w8D1SEhv3R7hNtU5LICS
         biXa1G6bobXSEcgUAfCfo/DZDvtPAppGSQTkDSqcWWccVwpKCovU8cwUTTPluIRm6oup
         9nvidfNLI1wbNO3lEIX9nElvMT+V0H3C4jP63UxW5NNV2WApX5ao3MaJvTjqaZzO2RRh
         OZyUEM8Nw0Hbyzaztwb3uxsDGTgIoh/fLYQWyJu9YRZQ2AsUZkXoN2iao19GOKutYvTe
         YrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703381908; x=1703986708;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4PCt0BUJxtEtgmlWQFvEAznyF7V0hSV/duRlgdufCo=;
        b=gW/9UQj3IXBMaax6vnxDmfzyMfFz/AtA6ReXdShdiodOTmApvgxWE8iGDqMumW5ram
         SZdTxEgcKAIJ5RKIqJFBRlRr3d5NE760MSCs39yA22Uo/ShONOANm9NdntU08N53nfsu
         V6lVOwCzz/WQU64HyGic9BbIUXVQTcy12XJXAbx8S0zWfeT+9iPLxaKH4tN/Dzz/8aSl
         s72nKzrjTDigs/ASQaAuOCRVGh2mYh9iC7YNbYRD38ijkiCPdrV+KLK6Lvt7bzHkWmtn
         eecFFdSEdvHChW1muAXYwKngnLGI2HrsQ/kVkQFXfRhY65Ut1eOj0xT43UT7SqaEY/Xs
         BcDw==
X-Gm-Message-State: AOJu0YzI6RQhkYYApYSOsAuNyP02yqS9458kMwK7W8UJ9Dw8ZKw61d0U
	Zs6+B1/RU2xE5c4uRX61Z1yeKnGTlVdBow==
X-Google-Smtp-Source: AGHT+IGBrvgr5pgQQNrjr2yKzG+YadtnLw/TgftQcaHqh3uqbZcrmAcVRJmdd3rzGx3sugWBSLqC2w==
X-Received: by 2002:a05:6a00:1824:b0:6d8:f420:da04 with SMTP id y36-20020a056a00182400b006d8f420da04mr7534114pfa.0.1703381908143;
        Sat, 23 Dec 2023 17:38:28 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id f30-20020aa79d9e000000b006d9ae6fe867sm692086pfq.110.2023.12.23.17.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 17:38:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Coly Li <colyli@suse.de>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Geliang Tang <geliang.tang@suse.com>, Hannes Reinecke <hare@suse.de>, 
 NeilBrown <neilb@suse.de>, Vishal L Verma <vishal.l.verma@intel.com>, 
 Xiao Ni <xni@redhat.com>
In-Reply-To: <20231224002820.20234-1-colyli@suse.de>
References: <20231224002820.20234-1-colyli@suse.de>
Subject: Re: [PATCH] badblocks: avoid checking invalid range in
 badblocks_check()
Message-Id: <170338190635.1172668.12689831383588478650.b4-ty@kernel.dk>
Date: Sat, 23 Dec 2023 18:38:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Sun, 24 Dec 2023 08:28:20 +0800, Coly Li wrote:
> If prev_badblocks() returns '-1', it means no valid badblocks record
> before the checking range. It doesn't make sense to check whether
> the input checking range is overlapped with the non-existed invalid
> front range.
> 
> This patch checkes whether 'prev >= 0' is true before calling
> overlap_front(), to void such invalid operations.
> 
> [...]

Applied, thanks!

[1/1] badblocks: avoid checking invalid range in badblocks_check()
      commit: 146e843f6b09271233c021b1677e561b7dc16303

Best regards,
-- 
Jens Axboe



