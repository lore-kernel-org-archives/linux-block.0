Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CA417BD5;
	Tue, 20 Aug 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118888; cv=none; b=PH7jf0SVUbIHgi8u+gmNODcS5twIJCDnjohdCoGmEnbh4V+ziT4HfYD+6ItdhLKSussXttWXrunr/MheRnTo3QNAEcJe50y4Ky/Y6yxNv09hw4RIIe5X6Hb/yAwcWCNDqjIADABjBuy74vAJPlV1Kb554FcLzutlCUrSzvlv/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118888; c=relaxed/simple;
	bh=0TyCg/t44e3EhQkh0UUL8UrEW29eMrzhWvtmVLAfqWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njqdocxIJqnGsj4oAVfzxzNGejxPkWhAaQXm9OIbSWPsZtLB01TkpWzTC/q/nPZOIW6jx9fW1ALGQqiYZfELsZATzcTEZ7plqofPzAHo9dsoKnb3sBUpnq3i3mUWKDCGg7W1axHf0tCs9T0ZqY82FcFTfZQQaONVbPvCcDHCL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkkBLGdW; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkkBLGdW"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f6abcf0567so1661122e0c.0;
        Mon, 19 Aug 2024 18:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118886; x=1724723686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0myAGpOy9NnSjCr/mp35bKy5ul/TrTFINCm6hk6W9rg=;
        b=QkkBLGdWg6+pzN7xRvL/V557eXNbVrwCrhuyfDD9JtEqsW/MRfdxPHUfKDJuTh1MsK
         Ko6snH3b/YqdsBCwknUkpGw/Fql0MzKLl3mbhksCcJWWxCfWEkaPFRHuDqRbxYm5Fg+N
         kqPMzp1B855UrIkIF7SjPuifQrZ+BteWK2sbfnHg+biURCLJ54nKv+GHDm3pJy3kZZLv
         Jd+UygUYgpnUUghax9Cel9EoLsqdbiEisyZnFIgMbRCfjyyqA5SMIi617Z0X774jesKY
         I1zlXXwmBXNrWmQ5nMAW79jLmWqyzIex7TgoC0RDuAF1/RsNAXef2k6wLiYxA9iwWaVD
         V5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118886; x=1724723686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0myAGpOy9NnSjCr/mp35bKy5ul/TrTFINCm6hk6W9rg=;
        b=EurXRQLvd3wjl1lleqVOLKUL9f/EPjTiilnY8qOc/NpU7kIbj1XX8zAT4UTitv73zg
         buxTPXpbmY1VgVYskDWHhwvj9HnS0ODmS6ylAUeRKJ61pKnEkOxHlTDEX1NsdJgaUvuk
         p77HfwwxSRt0DpRxD3ZyopoNKZ4PkdLnjZt5wzAZSYnmTzi45EQMZymJQLcX8pW52bsh
         1RihN9C0MRDDIypw7LOFefsrmj9cPTH6JoqZVKvi5ANklDJ3nP49AgVlf8lb8ff4r8ZU
         tdvdrPrhBgMCfFeE052L0H/sfGUFyGLisFWWQtXWz2TEQcj2GUOl7i5Cou1WWkZ72MWm
         BSGA==
X-Forwarded-Encrypted: i=1; AJvYcCUhSQlBG6URTqSYBuyJteIPmzebO1R9haU2HLIyUZLFPkAfJIVyiGmGkFn5/FxqRsk7QBOKCm9P@vger.kernel.org, AJvYcCWiFk0q1pbhdOxcCzGTkxS3CpH1s63+I7BujEnAebfDExmT/kodYu/Wuk1M63xfwf3DrnnOFqH8fCeZmg==@vger.kernel.org, AJvYcCXoG0zRRFOCGd+ALiyS4cIoQgWuEcOtkxXHeDAqLY4vxGRqeJohsAT4x/f2yrtAoTG801wBBp9/psSZW67D@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwa6XEowfcvb/1nd+q1B0P6VujrlklWpso36werqZoMLs4xrS
	hCKgVrLhxGd3aSbrc/G6kkBHZuhAyqd3Drutibks87A0PVn6mRruBFd98vgb
X-Google-Smtp-Source: AGHT+IGFgkBu6kEON1wC1ByIqvKHIoytVz007ZQm4rCHJNl4N276x+5zql/wox4vaL2AROSFkidYIw==
X-Received: by 2002:a05:6122:2515:b0:4f6:b240:4af8 with SMTP id 71dfb90a1353d-4fc6cc1746dmr15350930e0c.11.1724118885707;
        Mon, 19 Aug 2024 18:54:45 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fce3c238desm5179e0c.45.2024.08.19.18.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:54:45 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: david.hunter.linux@gmail.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	penguin-kernel@I-love.SAKURA.ne.jp,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] block: use "unsigned long" for blk_validate_block_size().
Date: Mon, 19 Aug 2024 21:54:43 -0400
Message-ID: <20240820015443.5992-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819000502.2275929-1-david.hunter.linux@gmail.com>
References: <20240819000502.2275929-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link to version 2: 

https://lore.kernel.org/all/20240819002324.2284362-1-david.hunter.linux@gmail.com/
