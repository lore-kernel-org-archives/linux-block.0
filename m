Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D918635
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866543; cv=none; b=f4LHtqyQbQteqq3Yfzg3goQkk+N4Otkie2WyGWVH+fhGCl414uiHxfSckwiSuHSPafKd8bCHgnFDXmLQ5EFbqohX3LBYUF4kWha+31PuC6bTVwjBBH3RIwFsFRETAuawqv+aRNfoWYQ1KeBT3DRRGcSG+IE/A3bSVTduIxm0pUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866543; c=relaxed/simple;
	bh=a77S/efIjrUe8D8VYvkKBhXjsHTJ5PTWISSmL0/UAJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EofpJJj85DP3eJHkmMcx4vq2PBDRPPfDu/lDOT5tFMGoIPPfSX0dx1JN6EpBkywYxtt3mpHYl6F922nqR+7My/eFfo2sGpRBFdqWVvQ4ILdTICsJLaVj+GPZyqTIFJtzpzQGy8kgCjOLlL4nRJQmIqgRSgrVsmXzUjidXTYbP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ea128e4079so158248a34.3
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 13:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712866541; x=1713471341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E89Ymxr6pBktCBvEVx2AbT0sGVMZ1MopzKCYdw103iQ=;
        b=ooqq7lt1UJyouxBbTavz+GQVyUtkWTKeKozTUZ0X2J+pokgARQz5t1CxWLld1bxF5y
         KmbMlRoET7ADzq/DpyLZzeX6/8uZJbIj18PMuoBDwwKrvSkppwaDhJkCOZ92Ad4hMv5r
         saOHrxuXwmrYScXsxr5lpqSkDEfva+usBcJclXPH3R5jcJeyxPWUJmlmR/z6rOLJEsZb
         jyRT15fHMOuOrDwIYH/W+m103iTPfDML3QtJ8hp9zEedzC07t9blONetqK/EgDQH25D0
         RflvZ/ttNJwLuPw+JyIlM/5wnku/vyJsom7mAwZfsbEoOwNTBBDyTVwm1gxgWZS/RVGh
         v/NA==
X-Forwarded-Encrypted: i=1; AJvYcCV6nEeIcCg7OuqAWzlOdd8hNZw3/6Kv3HEAwljaGiky3ehfgq4NT4lrSO/WJDXpV4kMZR8CdmLZ5ynHriu9sNrY/Y/AV447R+NpreQ=
X-Gm-Message-State: AOJu0Yx4AT4b9d9CQMEoxFhdNB7GDud8ov8lSbZ0mo5Oja8MBQlNVLq9
	vYuHwhPeJayUP5uzOs0cjXXJgxD1GuoJP52Yt01KHS6fotGDo5qwX2PvUDQLzQ==
X-Google-Smtp-Source: AGHT+IGMfloMnHcVdc0jLN1oWqDbdIKI9CSm7rrlvrKBYp8Xp+7b5Qg3914hRiBhSyMgDd7KUs1q5Q==
X-Received: by 2002:a9d:6c48:0:b0:6eb:5ac3:6143 with SMTP id g8-20020a9d6c48000000b006eb5ac36143mr106546otq.25.1712866541485;
        Thu, 11 Apr 2024 13:15:41 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id vr12-20020a05620a55ac00b0078d66d66d82sm1453999qkn.30.2024.04.11.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:15:41 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: hch@lst.de
Cc: axboe@kernel.dk,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	mpatocka@redhat.com,
	Abelardo Ricart III <aricart@memnix.com>,
	Brandon Smith <freedom@reardencode.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ming Lei <ming.lei@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH for-6.10 0/2] dm: use late bio-splitting and queue_limits_set
Date: Thu, 11 Apr 2024 16:15:27 -0400
Message-Id: <20240411201529.44846-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <ZfDeMn6V8WzRUws3@infradead.org>
References: <ZfDeMn6V8WzRUws3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I'd like to get extra review and testing for these changes given how
DM's use of queue_limits_set broke Linus's dm-crypt on NVMe setup
during the 6.9 merge window.

These changes have been staged in linux-next via linux-dm.git and
while they should apply cleanly on 6.9-rcX they have been applied
ontop of dm-6.10, see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.10

Thanks,
Mike

Christoph Hellwig (1):
  dm: use queue_limits_set

Mike Snitzer (1):
  dm-crypt: stop constraining max_segment_size to PAGE_SIZE

 drivers/md/dm-crypt.c | 12 ++----------
 drivers/md/dm-table.c | 27 ++++++++++++---------------
 2 files changed, 14 insertions(+), 25 deletions(-)

-- 
2.40.0

