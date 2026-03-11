Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15836896D
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218138; cv=none; b=G5aR0/09UDw6D4c8tOyao6bUA+WwQDCN0eUSOU8c0wP9viUTznmmAPvo6zaZ+/RZNFd0eJ7jZxw5LvXcE7KT83VpHk5JqgkATsuV3wt8nJ4SPxvUmMn5XtXpoYDNl8kqtWnzNOl1YjwabWzhraQKmM1p7njmH76PPjnYVQbQDEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218138; c=relaxed/simple;
	bh=iu2lAlwqjx8r++W5kBZ0JHjU/gYpNE3pgMtx2u3pMlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TD7pSYED7oCWA3gb/Pvq0STJKnWBTW5CBvt8LiC1A9DXtEzW1hoKUPE0KUa06HZY7OBJAZTU70/Db3CydKPgH3gszEW0RjHZCMH75vDZo8SGDMSFYGrLZ2vmLSOkzR9LVSK7Stfn5EfVQbIxgREeeCcDQr1SDAQQv+NDotUOwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YT6MXZYo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YT6MXZYo"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48538c5956bso7204715e9.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773218136; x=1773822936; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EjRjPg4FR7ijjXynwuypftW1LlG57LuGHtatoIrW9iI=;
        b=YT6MXZYo4L3gHAq0c6oHF6AnbMNYt7CXMZobV42GZcpYftUaHRW+z4nDCPifEYZy00
         zr3t8rHWrD/wbZutP4wQ68djWEFmAqE2jE5NcFwcV+GsfF3f8LIdG3rmKSz2pwjchJP2
         4AbxZYAIMS/sWuvBGC1VDCuOc9qgAknP9+DPTVmoVh8ETDeIwFm6CV08VV2r4NbnQ+sg
         RmSZxVha8qkCEWmEI8U5VPfDairCG1IH9NX2Ohl9Q348wDBFkb3NEKQ37UufTNZ8iWze
         +XJAJOL21kR7HwZmBBKOiJQReexN+J5wTsqIYtxJGxDpTj8CIaODyQcy3VreRcCpGJdb
         LCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218136; x=1773822936;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjRjPg4FR7ijjXynwuypftW1LlG57LuGHtatoIrW9iI=;
        b=KGm9ZE7xkuu52QWBlSs23PU1rnRbKfmx+H1qRunNc0q73xkji+qM/wrKdscxW01m0i
         ODHQGHDzHvS1xQWukIQyj/vsMsu6gDUSLxn49hTpJL7ZxxC/r1r2fdZLwyG2/vji/sor
         54+Yx1G1QOVDvEK5bQUb1LfQMJEncQ1t9pLAbTyqyVmyd4L0jAnatiwnKSV1y95bizwZ
         Q/Tok2xH5wiRr4EmYwqELdsqEqWL7m7TEwjHswlYfSL302/4+27qaLyPHrzvVr4qJDd8
         TPdLyVzNZnBWKr1DRBc4FKZt9dyuQgh3yEizYQPwT05dRZ8Hst1RucH7KMlheIsSO69+
         ByvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB92FdVjPJ23ZW6JASXTrZAFi29tuUWnmsHqMJc03h7s7YIDzOK1KxUEdsOXNuh012vPSErIl98lRQCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTaDb/uD1Z9eVogsiFBRBm4ObnFO0C39Bql2R+yJ9YqxhNDII
	HuzvNiILhQgVjdnOlkyVo6r0OeEuqbe45+sQTrKmVmv4R+IVVBaEqSxLRa4xbtJ3qqFWzB23ydB
	ESzR6gag=
X-Gm-Gg: ATEYQzxxwbmaxaDUYBX2b2Olw6A+ixh6hYrXXuZJbjhp/S60OtzabQFVoK8Lb9fXraF
	qqyh15+cJjcSxMGlATgweuxsqrR/Ta3IewiZjhBCqPydn7R26BhwKI2mheQeuiyHkBsxKvBvsCe
	G3QisRvCsz6ssjHqeXWB5ycBRc9piNI7L8kvmxg1jCHSXzD5d3CNAsDmnkUYZMrQSiK3CyEVdZr
	WgR/rMNmZbRF+NetTmQlk4m9pNBi55UKRWM0fxKUU5yQWJFGRwQvC1ZmmiuNtSgHvFZKpJyEsoX
	CSWEzakuCcOkW7gwGRSE8yubXvkSKMKqHgVq76pUCmUL3knQej5sUaC6SMCM9XIjX0dHEmubLO0
	+P9icGm/3b8oyjDr/CdfKnP9FLSmR5iOwHqoCdAGfDQeusYxwszW6SEd/Vak+Rk3amKTwBxr7hA
	j8s/6g+8P3QRg8p5J57BEcAh2yJSH74yBiVodisK5AobleHVmmdAh6CO+MFvzLIcGRSQ==
X-Received: by 2002:a05:600c:870f:b0:485:4035:53a5 with SMTP id 5b1f17b1804b1-48541a447d4mr146819915e9.12.1773218135634;
        Wed, 11 Mar 2026 01:35:35 -0700 (PDT)
Received: from r1chard (36-228-122-64.dynamic-ip.hinet.net. [36.228.122.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae24a91dsm22493095ad.31.2026.03.11.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:35:34 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:35:31 +0800
From: Richard Lyu <richard.lyu@suse.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard Lyu <richard.lyu@suse.com>
Subject: [PATCH] drbd: fix pointer cast spacing
Message-ID: <20260311083510.183631-1-richard.lyu@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.0
User-Agent: Mutt/2.2.13 (2024-03-09)

Checkpatch.pl reports the following coding style issue:
ERROR: "(foo*)" should be "(foo *)"
+		struct p_trim *t = (struct p_trim*)p;

Place '*' next to the variable in the cast expression to follow
the kernel coding style. No functional change.

Signed-off-by: Richard Lyu <richard.lyu@suse.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index b8f0eddf7e87..978023e969f8 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1681,7 +1681,7 @@ int drbd_send_dblock(struct drbd_peer_device *peer_device, struct drbd_request *
 
 	if (dp_flags & (DP_DISCARD|DP_ZEROES)) {
 		enum drbd_packet cmd = (dp_flags & DP_ZEROES) ? P_ZEROES : P_TRIM;
-		struct p_trim *t = (struct p_trim*)p;
+		struct p_trim *t = (struct p_trim *)p;
 		t->size = cpu_to_be32(req->i.size);
 		err = __send_command(peer_device->connection, device->vnr, sock, cmd, sizeof(*t), NULL, 0);
 		goto out;
-- 
2.51.0

