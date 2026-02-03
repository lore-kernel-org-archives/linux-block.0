Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6D3A7F7B
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128320; cv=none; b=IQkUIOttGtyAN4bCQMyVUOMKQ2uB9naDpRCSsZGtDtS7WgCDGKWv1sFh9u+6wD33BgRoa7UfMPD0Nm2i1ObuhcgsdYsKZK2bT9MaK/EyLrGhG3bUM2Vpt8iEuze8dmFPlx9K5QxsIzhevPi1ERvq8fzi1ic3vW0RRr0qRDzx3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128320; c=relaxed/simple;
	bh=KvCDqA65KrBX+CwTto3JC6CfMq5lUMnkIhoy59YRSb4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TzQ2U78FV/i8WzSJuhr2rXJJAF8xJRgr6wtXwFGGrfcwG7GlyWRgTFfI62fvHzzTWlKf/VchPTjKUsH7EDRmKLxtQkRYM/JUOLge4fh4xPnrGKSFuYsRFjC1u+Xpz9cbtp1praf4jgptzOmdbEhMT1J/JBRNRs91KU7li6jkb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CtxrHnbf; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CtxrHnbf"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45f171cb842so572859b6e.1
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 06:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770128316; x=1770733116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwcVV6buKbnV8b0sHH6/zSD7Dj84b+Ds/+4SC8Xo5MQ=;
        b=CtxrHnbfkukZGG+4LAitDmEeElzs2qDQonSSXkB+BhPmVBMz55RdFxAkCk7u9AnNmQ
         Z4l76aQQYyA9/RzUNympJaPKXBw5Ih8I7vN/IFtqFA+vcJdiogwd9x3X6FzO0JP7vN+G
         KBccWmgILdVIYtinUBLwXNAiQoaoV8tcAY2/BW6qvJCOBId7JnzxcW7D65dBpKXhMQLO
         LFaerT//fu56k8oTBbhn/jGp5SIdBn1+oqcp/VuJZiDHTlq1d2K4gRVzbNokm9/BkC/A
         Dhk2h1hwlMq+8xYQooQ1RIuiaXbZOGfQvEjvj/pbKuiGkaDHHnSq853fZhjDxeXtDIBP
         yPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128316; x=1770733116;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JwcVV6buKbnV8b0sHH6/zSD7Dj84b+Ds/+4SC8Xo5MQ=;
        b=JQWwgshQ2Aii/fJ2IM8Suf/pnOneYaAdGWDy9caG6G2pX/brGCoAftJUvyyxPoq43v
         WaSHwpOVGqslOHAjC+6fEREsvAsymfgjALP+dBimz6T/kmjFknoVNBoRuUrE/jVC82DI
         S0defxvEVZ5pbl8QQaS7W5XXuIfGp4bGUooum+qyOzkgKjGYcXB2pSDJfj3wMQgUbf9y
         TyMMCQCFBrI1yI5F6G0LCJ5t0hJrNQqzameHPZEOf+poPlwWCtUqNPoVIt/0lZ4qxHQ6
         oZIHTtFVnF1prMhukmni+0s2ljA4q+PvUmpBgpdiQ3wQL7NUL4bdlUUutpZp5sJnZSDa
         548Q==
X-Gm-Message-State: AOJu0Yy9LxGojfRrHzb60kXTqf9OmUOwlDSLL217KwuR3hkIMqRfK4D3
	mkuc6yjJPnV26F7sNpRxrwQhsbcwNFpOciFKhpjiyy8bguVg3q5+kd6T+ZpvZAJNJs4=
X-Gm-Gg: AZuq6aLS5o4pAQcdSmpFuXEHD0LaTirEcO+QuerDeftL3rB4vferuqPijA6XTf1kDU9
	6VmuDedlU8yYAkpVzNAjA6oTMw+9KN1ehZwi7RU60ZcIroSK1kSYVQ115K87IocZzR2MYCI6Y6C
	ckMLINMyeOSv9mRS2ztS09z/5CcR3f4wZxyZsnSvSVVswFR5ONHJofRuS4JwX7UjG2BSUZigtAQ
	6+6ghF6DGewK66MAtwN+F6lDXDyvQKdEpz/y9sE49CKpWU/euYigudXSuYob9BRTfuMS6F+auA6
	8sVuXm06CWG00tqeVQcKYa0/ZqyTED0fVz9P9KkqJGs4GQXVG1QcL2ZREgBJ6rPSROT2RLidld6
	/c3RcUrncRSrrP1Hqbax9Dq8n43GuuWfxXPtFTPcMeLNkUiCvBRaJZ+V1trJft9uP+9eNjJRk7X
	bYcUc91mehrOOhue6vEgxDBwF3U2UtTLDvzR6x6WgBAxvFa36XefuvZhW4BQSgokCA
X-Received: by 2002:a05:6808:c40f:b0:45f:103c:2483 with SMTP id 5614622812f47-462c1257df0mr1329964b6e.23.1770128316350;
        Tue, 03 Feb 2026 06:18:36 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462cb7ca939sm611916b6e.9.2026.02.03.06.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:18:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>, 
 coregee2000@gmail.com
In-Reply-To: <20260203141239.73274-1-ming.lei@redhat.com>
References: <20260203141239.73274-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: fix UAF in __blkcg_rstat_flush()
Message-Id: <177012831529.1184270.8914986281572027471.b4-ty@kernel.dk>
Date: Tue, 03 Feb 2026 07:18:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 03 Feb 2026 22:12:39 +0800, Ming Lei wrote:
> When multiple blkgs in the same blkcg are released concurrently,
> a use-after-free can occur. The race happens when one blkg's
> __blkcg_rstat_flush() removes another blkg's iostat entries via
> llist_del_all(). The second blkg sees an empty list and proceeds
> to free itself while the first is still iterating over its entries.
> 
> Fix by deferring blkg_free() via an additional call_rcu(). The second
> RCU grace period ensures any concurrent flush holding rcu_read_lock()
> has completed before the blkg memory is freed.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix UAF in __blkcg_rstat_flush()
      commit: 7ebd605ed5adf7ef688e15295cc8cb18c92bf572

Best regards,
-- 
Jens Axboe



