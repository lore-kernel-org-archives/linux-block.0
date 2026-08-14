Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BB481AAE
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720613; cv=none; b=tjlWe5yD31wRc8lrfh7WJHXaCDFT6UFpPnuJcauKsVBlUBs2s2/hqQ2OGUzNyBFNDXKGXvWlojtbEQmAXNTopOFeoLJlgXUdR6T/ThL25BDkfbqp4XWeSQkTwDCqhqJ6f1latP8glSgnQD21irnkokZSXn9YOzLQCA4+hTSKjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720613; c=relaxed/simple;
	bh=6dgBdo0kz8D0VhXyVT7VOnoNHF/p9ue86NPOyUvtC7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hoWWpkvsq9nLCcKWFZp3PtiZJUbaEgd4w+jnmXX4DnR+xpWUB3w0AiRZtetKLD00Q0kL56LMNR2YvHssPZ0oTHsumPmv4ov0yXLVFVbf1HPNOv51/S5AY79Mdz/pqx+eoI6xYDuFI6NJHWPXYT+tPfvrdxNrZm9Uli53iFhnMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=E828Ctgn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="E828Ctgn"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47362928f65so1073364f8f.2
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1786720609; x=1787325409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRB4JuBVbvsbT/EXF82Pi+P9sAHp5M7GCKevXhSfrjU=;
        b=E828Ctgn2560U8y9tUZMK/kvTH7LoYmylKBd1MOwWk/84rhLT4B+MBybWFZHMUD3Y5
         /ElN8tBMQCVypJTA+KYGYcKffjnaiwLltspDkdpnqzQb4MSjun7BKvEwIjIcr0obaR32
         wtoC3cfNKdo14HR4cE1Dz1+zErweKHKjP/a1zm8N/bb5AlDURWTJZavmPzCzQhHGIcSa
         UHL/t2AhhHfT8ERXAF4t4cAC9cGou6IfCkjWeOZgaKb6R9D/Kaf8PefDL04n5s4qV09Y
         BI18PUiIMni0OwM62rExn7xI9Lm6XXwNNrw7p+SR4esKxRr5hcdpJN9Ai8DxaU11af/d
         MiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720609; x=1787325409;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRB4JuBVbvsbT/EXF82Pi+P9sAHp5M7GCKevXhSfrjU=;
        b=hzxGtYqIZRHtZbhaC2mrJd1e7BRD+nvQGnLbu3HbmYwiHu8/1kV+QeYzyXKboOxvSa
         1Xq3VCwgYvScoINlH9x9xcd6wPwQmILLvOzJS47TJszsuCV03DQSMEl9KDy47dJJMa8j
         9QA+r/WKQETEudiCHR5MpKitbsKw1W5oUOmBm2qSHr+vCtjL+BBsYz670GHJPPi6MhaB
         3ZaP/y+cYf9gnsHvVlIrjjW/IXhe2TFBceYTfMczqCf92hTroJnPBxMvIxmIin48UVVJ
         4RapQ5MmenNIjLAzUHeag8iwxhUKR1bdgGF7lvSfe1Vy2V6rwfaLLODdCLVFAUGobZB0
         9sgA==
X-Forwarded-Encrypted: i=1; AHgh+RrhYaAq8kYhFXXHHJGEDnkd667D/GaAF6bdeztWNJFl3tl9icF61wzst3ewrQONi81TWz8l5fR6dbT9jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLy22OW2vLHnrkLMmN0vyjAqjeuZjEzilr5LvRYF+Rd9/sCc+G
	GVgGWolg2P1Y+IVChfS1PYgnkCsbxzZ8P6t2/lIsagoget/XDrMfwWI3x0eFmNc2Af4=
X-Gm-Gg: AR+sD11Lsc3zRyeUhvLEIGIr8o8e71V3DJwuN0VfYy5LeokBvSeO2ofk/yDj+wzufSB
	MX5wnf9o2KD/QoEGlihM+ceqqSQowppu7/KEW38GiiWPB305kezVbT0sUR5QFfDy8ReWgZRiPQV
	V9ZVz9nAQ5VOCNIyAPTfJ9cKDNjpTeKuAjHmbEIJUGR2PhFnobXlurIqezp1JoJ2hgV9iGmpesy
	Jkw/8ee6bUzwzKF4+SVJl2i7y/8uFrJIcK5XDhsosNJucWrab5D/5Y3kUtRV8bUHmUlEM8Gwo2q
	pFQb7uGX1tyIizBPNy/+HfbjqDBQfhA29ZRZ4sgqG41alb+ChxCWc1HFJqRzVrnRVVB8sDKrCmG
	wGFNeRbqDhDDkIxiXgKSzrdRN0y3r6jvndUbHSC//nzkKjH4+7hK873pYKeEIw6tqGbcfzkW2Xt
	9SItudAAHksIi54Kerfw3bEUkMsfEqxFNxJTXKiZRMV3ig6IRadpIzONIxlRUFVqUE91lh1FuFo
	OIBhrRhrLDaikdGuZtXYN2X3se7uAL/6jyT0+gdc9ps6Q==
X-Received: by 2002:a05:6000:2c01:b0:47f:86af:8fe7 with SMTP id ffacd0b85a97d-48160760c23mr9039764f8f.22.1786720609341;
        Fri, 14 Aug 2026 08:16:49 -0700 (PDT)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219f7bsm8742381f8f.13.2026.08.14.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:16:48 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Vivek Parikh <vivek.parikh@breachx.ai>
Subject: [PATCH] drbd: don't leak the shared secret to unprivileged netlink dumps
Date: Fri, 14 Aug 2026 17:16:17 +0200
Message-ID: <20260814151617.73752-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The conversion to explicit netlink serialization dropped the
exclude_sensitive parameter from net_conf_to_skb(), so each caller has
to sanitize by hand. Two dump paths were missed:
drbd_nl_get_connections_dumpit() and the volume-less connection branch
of get_one_status(). Neither op carries GENL_ADMIN_PERM, so any
unprivileged local user could read the CRAM-HMAC secret.

Add a net_conf_to_skb_sanitized() wrapper and route all three callers
through it.

Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
Intended for 7.2 if at all possible. Sorry for the short notice, we only
learned of this today.

 drivers/block/drbd/drbd_nl.c | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f9ffcd67607b..b77f901fc3ef 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3306,6 +3306,26 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+/*
+ * net_conf_to_skb() serializes the shared secret verbatim. Any path that can
+ * answer a request from an unprivileged process must pass exclude_sensitive,
+ * so the secret is blanked in a private copy before it reaches the skb.
+ */
+static int net_conf_to_skb_sanitized(struct sk_buff *skb, struct net_conf *nc,
+				     bool exclude_sensitive)
+{
+	struct net_conf nc_clean;
+
+	if (!exclude_sensitive)
+		return net_conf_to_skb(skb, nc);
+
+	nc_clean = *nc;
+	memset(nc_clean.shared_secret, 0, sizeof(nc_clean.shared_secret));
+	nc_clean.shared_secret_len = 0;
+
+	return net_conf_to_skb(skb, &nc_clean);
+}
+
 /*
  * The generic netlink dump callbacks are called outside the genl_lock(), so
  * they cannot use the simple attribute parsing code which uses global
@@ -3621,7 +3641,8 @@ int drbd_nl_get_connections_dumpit(struct sk_buff *skb, struct netlink_callback
 			goto out;
 		net_conf = rcu_dereference(connection->net_conf);
 		if (net_conf) {
-			err = net_conf_to_skb(skb, net_conf);
+			err = net_conf_to_skb_sanitized(skb, net_conf,
+							!capable(CAP_SYS_ADMIN));
 			if (err)
 				goto out;
 		}
@@ -3842,18 +3863,8 @@ static int nla_put_status_info(struct sk_buff *skb, struct drbd_device *device,
 		struct net_conf *nc;
 
 		nc = rcu_dereference(first_peer_device(device)->connection->net_conf);
-		if (nc) {
-			if (exclude_sensitive) {
-				struct net_conf nc_clean = *nc;
-
-				memset(nc_clean.shared_secret, 0,
-				       sizeof(nc_clean.shared_secret));
-				nc_clean.shared_secret_len = 0;
-				err = net_conf_to_skb(skb, &nc_clean);
-			} else {
-				err = net_conf_to_skb(skb, nc);
-			}
-		}
+		if (nc)
+			err = net_conf_to_skb_sanitized(skb, nc, exclude_sensitive);
 	}
 	rcu_read_unlock();
 	if (err)
@@ -4058,7 +4069,7 @@ static int get_one_status(struct sk_buff *skb, struct netlink_callback *cb)
 				struct net_conf *nc;
 
 				nc = rcu_dereference(connection->net_conf);
-				if (nc && net_conf_to_skb(skb, nc) != 0)
+				if (nc && net_conf_to_skb_sanitized(skb, nc, true) != 0)
 					goto cancel;
 			}
 			goto done;

base-commit: c7c76f9232bd34835d821f14abdc5fafc17bc938
-- 
2.55.0

