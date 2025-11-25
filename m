Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45721D59C
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076889; cv=none; b=RsvskqSXcrbJ7unUiSd8JhStVSa50xblHY+B/L5Mx1qr7cj2MS6AQADxwxyJ+a3wBhFeDoXeAgppN8bggb3QcBXcJyzn0hnA7tEqis+pB4n6lv30oIwQG5spzIg7uDlM3yAHJ557tjzxSUuuaVeMahFOqXsH8haKe+buXlEVBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076889; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRJSPE3S7oclXCW4n6o924tBovR1+D/3ofcf24294/ycPyCX55yOUKrkc7QMNqoWmBTuPGjfRC8Pwcrh3QU9eOgW//DPbVPW9SpPTknIoyr7SLtcuafWbFSwvGA44HZyKo1PqkQ7qiKDRFCzndoYhPgBCQQN1kZ2rQqzQaLzh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+srcaVn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+srcaVn"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so7669102a12.3
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 05:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764076886; x=1764681686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=S+srcaVnwTxEdnt0DzwKVDmyzP6pEIuKZQ6KOQhhkFH55Kf3bIyTii4YGzezHnioU1
         BBYkyEt/Q3kpB1JK8DiFDywmJcmjQi195XAudmtDcJJk3/LP+N05sDr29iajWcEfyspV
         ptVKgZGgloWprMleh/CxAuuHEzJ8Y27OX/vai2k9oJSWWM5Q9P3MjO7J7pdcQQ5/y7yF
         GGNGC4rlVIgqYnpeHKVvw/vBKePkVKfBusJmBUTdghkiVwKK9ZI6p3QTyAS5f7vqJgNI
         zC6XBusssXX52DpdndBIPEmPFZDu3VD3UyZem9oLxxR09sUkNGA8vo83e9BuQa0vLBPj
         ISnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764076886; x=1764681686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=ZVQulEVl2VIQWj/8sWz88ohtH1hdJEJHvYwpggmmQhtcSkBbjxyRu4sDerUIwx1YBU
         01L5uo4kIE/wWeoQOpv4xq637tCrWchxtVB0VbvGYO+8sgnhFMsKocC2GqfQP91gnxsx
         7gP4gPHKWR8nuEB9paHvqMpr5EfUixcveMg0CZyAzY6iSXy28wQquofo4yVuX47NcDvY
         nwNkLKeXe8+LUg9BPJJMMoTZjyKr+oq9xUaZVPAwyIGe1m9wwZrs+1lbGdZ416snBUh3
         BrqUYJw7Q2p2L7Lj7/pRLI8bXQ5jIje8wsq2iMn0msIfnNdOIGj3zHjzEHO0IU2DreUK
         fIMw==
X-Forwarded-Encrypted: i=1; AJvYcCW659UTpJpNqC9JzlT+EkBpJAgBf9SoaYHbo9lZELrD0tQbZdufBm8IsuA+JSqBu2HEZvewQbHvA3Tvdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4CUMls6L4Qfa1+BJhoYye6qqIvnx0oErfKexKlMD8PP+G+aq/
	t5zJaWRScCxrYZ+UCWHiBb34dZnd/U1vYh6FOP8yqCnjnKTOVqMqydYBljye4oyELQLlbPz/j08
	fgnbTrHWI+n1jdt/RkYgjjckp1LOyUw==
X-Gm-Gg: ASbGnctlkofYeCRDu8ZZk3N6GkBzOVGLtqmay8K0oDcwfxiM3McRsFooDotZCHJ44Kc
	wPj0Be6uyLOCfNS+yhqHXbv0dcQFVUV24rpId4Zr+1oWU5nm+i06Q+lXaR9lR5tQMEAVgMK85Cg
	Jx7yYPsWwc7Tg8EQvpoT+lyS3bHFvN1ZMAMbisJ3uqCgjqPDRFo+9iwTcde16fEL+GcETEFm3kJ
	fgC52tI0C0vs5BzOf4Fmsp+MjD9nn91viQUEdtiRbhD0hFgq++95QRpD9yMDDVj8KjWVHsYjhVh
	hJva0Y2q5l1t7wPRl7zvdYGeuC3TEmyg7YODg1L1g20BIgoV+1N7A7cuwA==
X-Google-Smtp-Source: AGHT+IFdAjUbTCRihlcnMQbRe3kaTpxY0zS2TJvPnabL+VI06FANQqQrLV6dY7bbefHQ9hiFBD+KK4yE+DNgNHPMVMo=
X-Received: by 2002:a05:6402:280c:b0:640:96fe:c7bb with SMTP id
 4fb4d7f45d1cf-6455469c726mr15216782a12.28.1764076885654; Tue, 25 Nov 2025
 05:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 25 Nov 2025 18:50:46 +0530
X-Gm-Features: AWmQ_bmI0Nc-U-7V1vG_PnxUMzavwAZMXSjJQCtXVqm1t0YM1hU1mPKj8-N19OU
Message-ID: <CACzX3Avd95DD0g1ec5y3Rqhs6fpo0dqcKBScUr17AOHcw_2JhA@mail.gmail.com>
Subject: Re: [PATCH V3 0/6] block: ignore __blkdev_issue_discard() ret value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
