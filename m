Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0DA3A641E
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789804; cv=none; b=KMA1VnLQprQP/50GOhaSaVU9G6h9W9suv6vLu9OEPkpIDciUnWrFYU9UNolS2gbZiYnSWpkXmmqz0U2OuNxVlrk+KWyqG25b17edl7YFkA5oxdcF8ksecx1kZ2tOGvw1PL7AJdCfsohFeqa1CKPY2Dul8ZNAzgCqQmR9kPJ3EZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789804; c=relaxed/simple;
	bh=k3hQv9gFEIVWQ8BuojhozFDq2pcGJwnuFRlaWbZuJLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nu5OmqFi+LRDODDlFMAV9KhUPQEPAwdrUrZf4LjlSqmxokGEeHy5r3fM8e6fl2C8sjqJh3cFqfNEk5FKUdwPlywkrATU8KkUWlJTE8GClePDOGawdfmbn07j1ViMmiV42Kh2gZbXuzDnAb2i2/siBq6ZGOAhg0WG4bw6a6MeuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxtoQgbx; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxtoQgbx"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ad019bbd4so6577225d50.0
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789802; x=1774394602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVqejN9RcyteX0OK/Wyi8jfYU0wStXL+Y9sOPfh9k1k=;
        b=hxtoQgbx2Uk8OlZmjjNMnhNYkUKT+wpKSKyd4eWcn1FgcaRMzq2hHQt9FOq7HZpZHk
         ua4L2A4lfckexLMfu4VjEtSLXEj5Rq6vi1O8W8Qn2ln/PBWS5V6MqkPlh5ZIn8mWvWI1
         wkgBOSK9FtovWO6pUn9hKsgBSM7mOMM/bvSlZrzQ5oVk1J5JxU3vrNWGuhplpG8rULxR
         dN2m12U4PWAxdyhhVgUqv+NgyF5xMuuxXGOTwfUW2k/ibW7uvo2t/NawYeSv6r4gRPhg
         F3ul+dJLiV9eD5sAN/5sWgT2e8Z61hte1k1A3aEZ/PxkEqgZJtrssqALAspkPJzRYozb
         rEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789802; x=1774394602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GVqejN9RcyteX0OK/Wyi8jfYU0wStXL+Y9sOPfh9k1k=;
        b=c72l9egVjLAGMCW8FVcxr/01Hhg1QfaTVe6JIidtV4pcFlm3DOq+eeqmUrG0bfTQXz
         P41OmKRfQKmh8ACfly1kg8L3xNsgNpBfmW0SoteKrXEflWhXeGkIjXrjeR1uSLPpP2F3
         Is9PcgCowxY2BDdXT1aDVbF9z3Ywvr4IcJjlwh67psdJQPghQAutKs7Tc0G9qxy3XAfu
         FPe6sJBjTdX3eMv64HYCG3CefnntzYYkBiHafvd48n5uGmE96ZFlPwvO5k2vO9pBU0XX
         Ur0mDN+osvyGfpaQ1mz8WKQQHrQhVlkMlqO8s0kFHGH4muaVgapSWg86fu9A+Vzhm8Fv
         WXxA==
X-Forwarded-Encrypted: i=1; AJvYcCWDagGfLxK1oEI7jpuXrzAEgYHvpyyh6+Mnc4p+Qo+b+0wrwpi8WPsbVPaUAKyWSfGuExC1d9BwDgFmgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTeyK7sNJJJ03+/58I6kskFOUfvVxz9AsIT1FYqoteZyBS/7oH
	lPMhlW3Z3hfHo/Tb/M+tYt6KHWEFtSmH0VUqa48cG3RQHHd07Wf8gn/Y
X-Gm-Gg: ATEYQzy6zz3+5OsMWzVt/a7DlNqQMNFjHautt2oHHznzbVySYeIJTQn133+8qgVFbH6
	TTiBnK8mFdWtvG3tA9TRnt+nvsXZBrJslkU8jdwp4XUggQ5xrhi6Wfsje1StbaBSCiGMO3WGX+V
	BbV3OH9OQ2BqkUsRQ8lLusw2tVmcYjBQE5FJdvt+jqFNHiws3n6YrGzk0uvQa0mXs2xpnNQNoTu
	AwfWy6x9C6wSsMK7+CAT2VUGZRULnGK4ejgAwV8ESOp62bF4ZhBMHtMFHHjQugdBtKGZZ3K0cdH
	ndxpkQEe0vTUOtZCUIsPwnU+Op63507Q3sAY9w767HcJNL4Z4CXOy53VvHmnDtqyrYD+6tiEXg8
	PyT6Uw9jKu9ExkLzD75YNy4Q+ooaRSTJpdhci++LDCoTkvHAnUE33TZOkbNnqQo7bWA/cyKjDQt
	InHTk/bQx5r6wciVREY9GFdwhWlgWU2VI/k2jEKvgw1PwIdXikxA/HtAliovQ06MKIvnd/J0JCV
	5YjCmuW/U2/qlL6mDUWPSEK
X-Received: by 2002:a05:690c:110:b0:79a:38a2:d8ca with SMTP id 00721157ae682-79a718c62demr13000817b3.23.1773789801990;
        Tue, 17 Mar 2026 16:23:21 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a715d221dsm6858217b3.37.2026.03.17.16.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:23:21 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 2/4] drbd: Fix variable dereference before check
Date: Tue, 17 Mar 2026 18:23:16 -0500
Message-ID: <20260317232318.18923-3-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct is 'req' is checked for NULL after resource was assigned from
a member from it.

Check 'req' for NULL before assigning resource.

Detected by Smatch:
drivers/block/drbd/drbd_req.c:1996 drbd_unplug() warn:
variable dereferenced before check 'req' (see line 1993)

Fixes: 71d075200b462 ("drbd: rework request processing for DRBD 9 multi-peer IO")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/block/drbd/drbd_req.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index e88b5da15c1e..4cbd9ec15157 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1990,12 +1990,14 @@ static void drbd_unplug(struct blk_plug_cb *cb, bool from_schedule)
 {
 	struct drbd_plug_cb *plug = container_of(cb, struct drbd_plug_cb, cb);
 	struct drbd_request *req = plug->most_recent_req;
-	struct drbd_resource *resource = req->device->resource;
+	struct drbd_resource *resource;
 
 	kfree(cb);
 	if (!req)
 		return;
 
+	resource = req->device->resource;
+
 	read_lock_irq(&resource->state_rwlock);
 	/* In case the sender did not process it yet, raise the flag to
 	 * have it followed with P_UNPLUG_REMOTE just after. */
-- 
2.53.0

