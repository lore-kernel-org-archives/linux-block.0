Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205907;
	b=XhbTQL1BmuHNzBtnHslhc1eYmG4PUbn7SvPiaP49PSUNxViVGat5/NxNTufDU/SZmNi2
	 GJ+n1iihUnv561oY4nFmLbBhap+IZbuAffLTET6m4XaFLMl8oCtGSXywnRYQKrq0OGLYx
	 DJQQ29pPxsfIkZ9yZhtQjK+WKIazLVnXjFNG28IzSm8mUCzAUlY/tqoK3V84EyhfYdHno
	 PDlbcHqVvRpZ1V4VxYR6zUaFBNgaw3YWdCztHGVTjp4omK9I8KiIhM38/0p87vA1KuqPq
	 FRGOJyoI16Xzm5ZVB3ENB2D8urzzlC313Up8ZIo+EZOJhniM4CsfPDiMfORcecc7rmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xbzTZzd6c2OHG7ATbSHtBBCffWRVoOneAxNXsMNlw6c=;
	b=CcgPF56qsgUL4Iw1jEzhnPyNML6ZZnPvlV8lyMxjOHVwLEXWkYEgpmy0yI4bi0mwU/DC
	 3+933F7f39lndwXCSL2trYSJ6TiD7y4ZzvgpfChNtqiJIMKud2HmUJSWSNrX1U507b3JQ
	 gBXzLrGu1dlV8IjJv1Tipqvna/md62IPPhTVFW44AD8Tbaumws9vGlzpR6t0/QqTs0UYe
	 bbv9wZ4oX9U3mTU4V5YllnCT/GDc4KmWYXTwIn3p005VZEXOWxjy6MZkrdZY35ugYg48J
	 v4d+O70uADq5tIQXASgOPqS5/T4ZlGx4h5II//6IPFTDT4WgZVNOmkVYJXguQpbZoQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="a3/ewpdl";
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16765606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16765606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a3/ewpdl
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8446af403b5so751697a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205906; x=1793810706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbzTZzd6c2OHG7ATbSHtBBCffWRVoOneAxNXsMNlw6c=;
        b=a3/ewpdlsbMMwe+WRFgUPzleZNVCSG5KLIwmzvmsrRJoaQG8JtLMJ10xDkROSyinGq
         PbzYv/TgbuQcC+EjLg4JWV6qMwBWwNzhz3vXWGmRerl1siDOf5LAc5egXlGYkeueB+jK
         UF1W5n0eJ4QlVJeRo6ozF/WGhlXbGiKt/PnBwy6qVaTAZC0TSfrgGAF7dTwoyW+xakH1
         IUmjKOEsMGol7spJ/p9aBCYMviDRtcyNbZbSFkOVNqr1+us39Pw2dcwQz8ps6V7eQfix
         j/CLslAnCjnxEXii0GJi0GWteAYhHEc4icVodrO8pjhxinBn7MHGVZ3ceoDpDISTA+Nc
         ziNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205906; x=1793810706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbzTZzd6c2OHG7ATbSHtBBCffWRVoOneAxNXsMNlw6c=;
        b=oZTmxAS84IScMYVBroiGEGTpAgNpazHlahnlJkLJU/r+rWOpgduwlWZTrl2S1mZntD
         Su+unksCohUdqB1+IibmUd9HYAdWssbLoXlqKJJh8Gv7pSyYv7RQoeA6RrYrk3yXlJMc
         aPcWcpjUYyWoGk97NQmIW2ddE78OZ5NzMoxVxS/8uI2zEXx0JjAmLX5GPzjoUA2oCkqw
         6pklHHaa6WP5fWQBB2ikYZcHCTef9tHyK0EmgNNquy3SJerY81NWlVfi0UQvZL/i2CZS
         IACa97t7YWRlwRLjHjP5p30sCmNzkMhLKUgVOMz/+nZHEQSIMKwMyxAurLnRvOf1OceY
         yGHw==
X-Gm-Message-State: AFq9FYJqLJEIraYQvLP4xBmb8958ovXaJhTgQVOPwnZ62yR2nA2myyLI
	ucBn1iWYqASpsXVLCcqyyh9StLrZmT8U0NSSfWn9UsRm38Pec1/ydPUGko+ZAiULIR85hab4oJV
	OJRXSZVg=
X-Gm-Gg: AYBFou1HOvTI6DOHe/vPpm7HdMROnMqDfLGgRLLKYxP8I8ClkI1scyKlFvIGQcKmp0i
	pSbMz5nTm0T4TLbt05ARro1szqapgvY+0VMPhDwwkVv169ooVhbV4WOeMjU3WKL9D/Spje30V3J
	XX9GSvXTcWLHXAQrv6C4Gxsnl05PUd96HQVSWGEEPsy5F/dV6YWnk++iTdL+Go6DQV2+xSXP8uH
	iOUVfFETl9vO7XSiWfj5wUJbcJ22zhZQCaT+JM9v/TlyiekJGRemA5so8CoGLumpSKdJFpDK/Gq
	QDdZT9YWJJFik/XCehbt+yechobXeHF5t99uetABUb5Qi/Up0gqYkEsrW8YWcUjT6PN8Up48i55
	yKcaTJBH9R2xEIRjF9hLERpAAjKlp/hOcSbkxzuTwu6YGIPyBSL3Ch1ccFsMukWh7tViSmiKXsl
	nThbAMfoAmnhBTbOouaPDYnLLxaPdiNvHZ19Qiiq/rxb78z+gKlK6gGLavqQyGIepr4im53FaQm
	XydaNEd8fOsTJhfFgdgZMYCfV2emdPwCDfzMbJqSXtHmMQGkmISXPONtu/kjyLajWYo9lxPEwzi
	/VU2Tr2CZ4B6hDiFTlvO+6ZjZQJ9k+oxlpboH4SLZx1I+zXwVz64EDD1zI5Nn0RbvRXnvvjUeg=
	=
X-Received: by 2002:a05:6830:680f:b0:81c:a8c5:633c with SMTP id 46e09a7af769-85ab7b0d6b0mr2733885a34.17.1793205906053;
        Wed, 28 Oct 2026 09:45:06 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 39/98] rnbd-srv: fix use-after-free on two CLOSE messages
Date: Wed, 28 Oct 2026 10:41:42 -0600
Message-ID: <20261028164415.1262013-40-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

process_msg_close() looks the sess_dev up with a kref, drops it right
away, and only then takes the session mutex for the teardown. A session
has several connections handled by different workers, so two CLOSE
messages for the same ID both finish the lookup before either one tears
the sess_dev down, and the second one works on freed memory. Any host
that can open a device on the server can do that.

Take the mutex first and look the ID up with xa_load() under it. The
second CLOSE then finds nothing.

Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/rnbd/rnbd-srv.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1e3de82fd70b..1cfa2c580759 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -360,14 +360,15 @@ static void process_msg_close(struct rnbd_srv_session *srv_sess,
 
 	trace_process_msg_close(srv_sess, close_msg);
 
-	sess_dev = rnbd_get_sess_dev(le32_to_cpu(close_msg->device_id),
-				      srv_sess);
-	if (IS_ERR(sess_dev))
-		return;
-
-	rnbd_put_sess_dev(sess_dev);
+	/*
+	 * Each teardown of a sess_dev runs under srv_sess->lock and erases the
+	 * ID, so an entry that is found under the lock is alive.
+	 */
 	mutex_lock(&srv_sess->lock);
-	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
+	sess_dev = xa_load(&srv_sess->index_idr,
+			   le32_to_cpu(close_msg->device_id));
+	if (sess_dev)
+		rnbd_srv_destroy_dev_session_sysfs(sess_dev);
 	mutex_unlock(&srv_sess->lock);
 }
 
-- 
2.56.0

