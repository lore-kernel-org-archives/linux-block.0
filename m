Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC127FD49
	for <linux-block@vger.kernel.org>; Fri,  5 Sep 2025 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102075; cv=none; b=JU+RnGFZuebXhorwjeERuC/5jb+uwLcNwp8rzGfH7G1PkkFqR0Tq/uLkCjxGF093qHCZk4GGFSCwK8fAl3RCVrmfZGondCvLgwSCE6bUBKXeCpZtt5rEBoNeC5dUs5tU2rWHHP1bgGDtLLFKQIRbnMZ0lxnAJgxC39yvCARkqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102075; c=relaxed/simple;
	bh=STm1WeWxux/k9ErGazCiP6pvMOeNUroj5qNzqv2OwyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RtexM3eEdTIm5ugjBuBIor2ubrVbFYsBf/zCJmNUgUc+bV4MlkWu2+K3zRbhFkIfv+Fi0VfrmM7yLv0BITCNxpZZ8HBlftGgxaO5lttXMdrc8weqDKwMpTQz0YILFb1KLLNimnMLA7RNmI3niLy4pfy7Mw4ZkgPAalUI1qqagsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eL5EWMNZ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eL5EWMNZ"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e98b64d7000so2298602276.3
        for <linux-block@vger.kernel.org>; Fri, 05 Sep 2025 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757102073; x=1757706873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NnTdCOEg5OXsYY6GJwoHnwWPPG37oz/se7JGI6fcqw=;
        b=eL5EWMNZHIbD1wGo0mi1SMZddzjg0TqTrLegd+/R89CPLoCL+AJjpxIKuAcrT3W625
         hUYjYPwTz3QtKn4k2MHWlCNbKm/ZLGXfxW8Wydd9xcmb0C8Zlba+F1sYLU1zdDKEKvar
         0L60OlPlYReGrj/4nfhPDfaa4iJh3iYelXqdq0dd+mTIPUJAPpQ73tlaqwihePGi59GJ
         QwxNMY0NHPcjhlk8wzDIF0jEPqNpPWQjkA4yR6BYxOGZ9FH2S6h17mn3vmiZcPr9zTjU
         93CFxTGREyt5tJsJm8NabaU6PB1ts+KA+gueA1TVijRgrO7ytP6RozoSnbKLzRYHcLNd
         s9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102073; x=1757706873;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NnTdCOEg5OXsYY6GJwoHnwWPPG37oz/se7JGI6fcqw=;
        b=Iq/1zKnrGzXYJ6J/OsI+eD+Atp4OqLXc3Un7z7Bs8+2cAiBdGKqGtQBrsxthTgXYh5
         crq8b4c1s14RW7qld0DOfctIa8btTn68ZqaLUWFJxb4bANk0Vy7nyoEgmvBXEG7vM185
         22+XvCkCqLmpLKc7w0fr7VWG8Suzo30M3YTgX2plGxAfbAIEKsXOmF/QOlJfc4qOSPVq
         eqer94gqbBuMim9xgiHAjVTZihstgERcG70OjjXvwfS5mHceMFUz5wuG56VUgVYfGoT7
         Th2uk5hV+vE0elN3WnQ3ceBKe4/Kj/SX3glSWOnB8lIZ78/xtJNG1t6PPt/4n5++3me0
         myig==
X-Gm-Message-State: AOJu0YzXLszUI9gHYn2LLfRlc0vSuLXYACsOL+EkE6vmZ4lwx7hLaszq
	Gxc6hOk5ElAVjmHjkZkIJz9ibamqmLxp0OVdP7euW0utyiWxqhofDjZFK6Kncj/4YFY=
X-Gm-Gg: ASbGncvG996t+Sl28obBL7OBVugX8+c1BvBdXoeJq9aY9UbDWTQkON0pVocVS6URBuD
	Eher8jbd1JsPkXNhstiYBPmdV9NB2bngc8E5uSa7qzzLUFnQgYUYXpuhgvA1nDYR5PBHfflOu3f
	piOlVrxdHWSh7/yWe71DmTUDd25d721nUGMPUbUiqnYuGp4JJ4Ea450iz2MtDKwE9IRgKbbbFWs
	bD/p84N+CT4J8MTwE9UFlS4ZW4kdViB0545UqhuEa4ZQSZLl10kKs7RpTRy8V2nx3umSMuzwwW3
	gZL19oLVBWKe2Gi28yigBJqC7Q29D8qyfKTzEfqSmzjwVAX1pQL/H1FUMj+duacP36C8XEOi4aN
	vHSL1JFA45FWdIpH7Ny9SKAR51A==
X-Google-Smtp-Source: AGHT+IFS6bxmxveB0S+gbdE1esXUwfY0MdW4w9rHkaICFKEHHTpXWj9UllIVCZDVFVQ47O6PC0q21w==
X-Received: by 2002:a05:690c:296:b0:71b:f6d6:9572 with SMTP id 00721157ae682-727f4b600a7mr898847b3.18.1757102072705;
        Fri, 05 Sep 2025 12:54:32 -0700 (PDT)
Received: from [127.0.0.1] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a85aefcfsm31548457b3.68.2025.09.05.12.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:54:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai3@huawei.com, bvanassche@acm.org, ming.lei@redhat.com, 
 nilay@linux.ibm.com, hare@suse.de, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
In-Reply-To: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3 0/2] blk-mq: fix update nr_requests regressions
Message-Id: <175710207227.395498.3249940818566938241.b4-ty@kernel.dk>
Date: Fri, 05 Sep 2025 13:54:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 21 Aug 2025 14:06:10 +0800, Yu Kuai wrote:
> Changes in v3:
>  - call depth_updated() directly in init_sched() method in patch 1;
>  - fix typos in patch 2;
>  - add review for patch 2;
> Changes in v2:
>  - instead of refactor and cleanups and fix updating nr_requests
>  thoroughly, fix the regression in patch 2 the easy way, and dealy
>  refactor and cleanups to next merge window.
> 
> [...]

Applied, thanks!

[1/2] blk-mq: fix elevator depth_updated method
      commit: 7d337eef4affc5e26e0570513168c69ddbc40f92
[2/2] blk-mq: fix blk_mq_tags double free while nr_requests grown
      commit: ba28afbd9eff2a6370f23ef4e6a036ab0cfda409

Best regards,
-- 
Jens Axboe



