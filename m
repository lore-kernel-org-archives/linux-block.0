Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A02D97BD
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383702; cv=none; b=LNrfsETpIkpsamw0OBOyZ6x0l1MuBX1pmdBAQeo6wV77AolOfsGvSCQi7SWC5EWtN0zGx6k+WJXBdtFBWBiUyrCgLQLtkecafwkehzFpUJBiRlTmOzshtytN+zErfyU+bfdgmjHoqeyfIzZPKiNd9F5uu8I/pRgydpiTD4/INNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383702; c=relaxed/simple;
	bh=ANSDfvvEmdp2eTq5092OB+KXtxwLop0sFn+kfgouwMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hl3j3hOQSgb5yN/YFm4cNMNRrIkqUGtvrwCMqm6ssz6WIVRl9Ry2/nHqw8GZMB/JQrS4ksmB05kZeZCqnHJGpXVcNagniPn1fRepS5sejdYwxEeoHGQz5oiTrW9EczIATlrQ34vbzAnDNL9QKtHlGqKO4pyPsoH+rW/E3JkQk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qMCveOyF; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qMCveOyF"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4clnSg3LBHzm0yT9;
	Mon, 13 Oct 2025 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1760383698; x=1762975699; bh=SsyGSiiFdmAXcVa8gwtyyaHwfeWNEP7tMDo
	lrsDVeRI=; b=qMCveOyFZ5epy6tbn0hxQQAlf3lX2Frhz4ZPDky3rJoL37zMeK4
	4XZmoWxqR/D699J60DMD9jkqZYqoIm29CJMKxwv6gL6AwU9JvBjyH2GtAz/d8Bdo
	ehxtJhthZsGoeNO9OgDFyU5QxO6TAkHCrKnwhnmVCATh5uX5Q6lwhMwspYKCLqur
	nieLEdI1PmNnMtTjQaVp6gGKX+9LcEq00ZtIUOk+IndmP0uXInV98V0z5X2QiStf
	qD2rbKry3yNn37wZCfrLLfTz5NiE6sPhqn1UWraaXZRM6xz7+Jl3IY55yX3O4w6T
	f67Vv/T6Vd2/R21pfMbkRZjodp02RmvhoLw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XR4z8Ebghk1t; Mon, 13 Oct 2025 19:28:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4clnSb74Kyzm0yTF;
	Mon, 13 Oct 2025 19:28:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] block/mq-deadline: Fix BLK_MQ_INSERT_AT_HEAD support
Date: Mon, 13 Oct 2025 12:28:01 -0700
Message-ID: <20251013192803.4168772-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
modified the behavior of request flag BLK_MQ_INSERT_AT_HEAD from
dispatching a request before other requests into dispatching a request
before other requests with the same I/O priority. This is not correct sin=
ce
BLK_MQ_INSERT_AT_HEAD is used when requeuing requests and also when a flu=
sh
request is inserted. Both types of requests should be dispatched as soon
as possible. Hence this patch series that makes the mq-deadline I/O sched=
uler
again ignore the I/O priority for BLK_MQ_INSERT_AT_HEAD requests.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (2):
  block/mq-deadline: Introduce dd_start_request()
  block/mq-deadline: Switch back to a single dispatch list

 block/mq-deadline.c | 129 +++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 68 deletions(-)

