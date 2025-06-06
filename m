Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E32BD1B
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174122; cv=none; b=BpOnvZkAZbn4H6InwvPZDaTmg8bxZjSfhdlAO88cb4b3zEwhmMzMtEny99eY6XCXuvuusiJHcGJpgUpY2K98OKqyxV4veK6Ha17eJv/l4a7mVeznOS7YaUqGY/OhrztD6iQS2vEbUH7ub2FjzlL/3ONjMtUKQSe1Qkry0iGDGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174122; c=relaxed/simple;
	bh=KFdc8NX0tKseoqIYFry8hsJctDf5blG6l9wolgAf+V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGVuhdL1wdbvZoDcLl+Ot2nQaEN2aTqP8olUSRKGAibLcRee1PKtwQfPym6Pmjl0OFgwC4wY/DPm56VATaDW7ydyO7UZDR5CWDrtJlT21k4lv/YJg+MVeb04hWXWJX15I3vuQKfsuXY/9G3IkSmB8WGHAXiWdcDzovVW+gesNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtQP3SrI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtQP3SrI"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad891bb0957so260365266b.3
        for <linux-block@vger.kernel.org>; Thu, 05 Jun 2025 18:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749174119; x=1749778919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDpd58J4s7WwvI1/iRGGpuy3gTH6y2JQCLm0hLYTmco=;
        b=VtQP3SrI6Mr3DNz6QINMghQ9MqZzhv2Kpu1CfdZgff4G/ClY331a9LQ6E3GzL1NYgs
         nqIaCjPhxKr1Ptg35lkZWDcGnXqLdkcX9/9CWYJzIdvL0VVuDnkqGa1nsSCzA6o89ntw
         IYG/nXOA0MXppiE50d4651rkAjUWaJIaUq0X6byAKngxzy2xSSEDZoDcVX7/PAGpfgim
         7nylQONjRDh8yFDrHOElBRGQYhnDVSEtQwGlB8Q6xLz+p2XVL3NUAJeVSlf2r7jhEt5O
         HNpEN5LUhkFgwEYRYgif7NvlTIHrhgDoTbiXnA4fPibblqiSGO9xik3I+jxLYjddwKIl
         yaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749174119; x=1749778919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDpd58J4s7WwvI1/iRGGpuy3gTH6y2JQCLm0hLYTmco=;
        b=jjTstdn3MBE2Gw+jEqU0eA0SDj1FGUqc/jgpDBVE/HIFqBUNgXRg3+nrm+XtCH3RJj
         yLsAmaLHlIJqO5RWpdC/vZ2lrIrl1lKkTzAcZgMyNbrbpgClqqfzTvV6zarDxZ32gQeh
         0qf306kdpbvqYp6CUF4hJB6DXTS+W/S41f5h78f8uiOB3vOv0hhUx5Fgj/fxQdqbxjH0
         8nRVXRUZCUBmMEZSkjx5lciWNqZlq0vCMxofobyfBv3utEL0+J7QZTUFoMmGWNbDDZ5+
         W4oYPT4Xu6SJ15spkSuTckrVNzzg1G/zVUrSO7kRXr/ce0Djqa31EWOGMpMx8b9uPNcw
         +8DA==
X-Gm-Message-State: AOJu0YxhD33ErtmORiGijZA2basgLR6LOZ3USQu9m72TDTi4Xu7ITDw1
	iZh57ljvjt6l34+/+VYZKpcieozEI+zjqyJEmo7EVYaah+PnDaHGfsaQpBSRCUK8D1o0eiPiHeT
	ygIkG16Ttmg9VW9xZfXhO12Q5wukWnA==
X-Gm-Gg: ASbGncs1mOurHHS3NqwEITFcVzY8bsn0hcK8druahY8emnuquep646s60jgoXtp29Wa
	Y1+5iOjX1t6QQy2RbFxuR3hWp+IGZJDJeSfZj0tgzzVBMR08XQXdxaXAlZmyFeEzTi9xZcVW7th
	ewZISGUkJ2TFYVmSADdszdC5R5XgWhdhC3plxi3SjpOe/VXPSGK2nHVuNt01w9fGg=
X-Google-Smtp-Source: AGHT+IFuZFMm2ddZwYaRiJpBVjSh4uUIeGdOOcI8W1e3S+MB8ZowXyooOoqYTMwUzzjW9o51zm7m+mYpT5kIVW/TGbs=
X-Received: by 2002:a17:906:c110:b0:ad8:9428:6a43 with SMTP id
 a640c23a62f3a-ade1aa1476emr110874566b.25.1749174118478; Thu, 05 Jun 2025
 18:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606003015.3203624-1-kbusch@meta.com>
In-Reply-To: <20250606003015.3203624-1-kbusch@meta.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Jun 2025 07:11:20 +0530
X-Gm-Features: AX0GCFswOvy7WbzUT2aNeMAGx7c3_8X_WI71937EsQxNOeFvgvgMrSmFw6LRfns
Message-ID: <CACzX3AtTwR3dWpYw_jwWKTZziz251cb7xobgF2ta5WL6Kr2uBQ@mail.gmail.com>
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	shinichiro.kawasaki@wdc.com, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> +       /* this should directly use the user space buffer */
> +       meta = mptr;
> +       cmd = (struct nvme_passthru_cmd) {
> +               .opcode         = 1,
> +               .nsid           = 1,

Minor nit: should use `.nsid = nsid` instead of hardcoded `1`

> +       /* This should not be mappable for write commands */

Maybe reword this to:
/* This buffer is read-only, so using it for write passthrough should fail */
-- makes the intent clearer.

--
Anuj Gupta
