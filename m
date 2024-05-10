Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B5502AB
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372616; cv=none; b=DJYP8+qjqht6a9JXNMgnYsVXSufjZ7ZK3yLsypvttNpaoeyon7sN96DkxWJu0YyiTEV3fveJqVp0Rxu1AGFIfhGfJtmexqLiUAMBYGa/SnhRIRmg4AeMzZ1qFXpB81XyM/Jt3nxVZUtEErf8vijbMB9kCCfKwC1S7hDNF8CnBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372616; c=relaxed/simple;
	bh=Wa5Mn2znRmsT1ure+if+PSLB11Dz07dBHpIR9I/D+ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZLlQi0s/hePNAm9CxF4vL9MwMlPDs1A+54sAzBVNzIHRq8UQX8rfYZpmE2OzaI1wP38k8UR2UpR0sM+zpMdaNjz6NjCI+DnZEqt14YlBwih+pmFZd1MV3cySV+53MNHLcWGJgMQmUfkYJFdJUiMkuZuPJ5RVo5QA5YHI8Z6wCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iyBnhcIo; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="iyBnhcIo"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VbgLh4FzQz6Cnk94;
	Fri, 10 May 2024 20:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1715372603; x=1717964604; bh=9PJ6nJztjWanAE4KkFB3RbuEtSHysLQRIzZ
	841AbzeI=; b=iyBnhcIonaUAJHkez73uKEyKL8MjXqTjMvsXSHSEpcffj8Ia+qB
	SMl8VvN4cT5eGK2W1EUrKiD64KM20PQlJBOpTBCLykAbWGx5INX1Ve/14yoA0nDQ
	N/DSdOHWR98eZXoyNmoZu/LAIn6NZGfkC8etZbA4AvXI4NZ2V6NFfBvzW9iPMyfW
	bOQQRE0eGCjNWTJyJxi3z0aG7dH+JhAPldFrJS/Ocods5T5AEy0duH4KFSzp+JG/
	gjvW6mDoCevwPm6kN0iY2q5LekK2VQ20KsZAPSTK0lIukJ0O8opHiRHNRHTPAxZS
	vCsdUcWQwtBPuw72KCodP/FogHpxXhh8vhQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2Ok4QipLd-Is; Fri, 10 May 2024 20:23:23 +0000 (UTC)
Received: from asus.hsd1.ca.comcast.net (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VbgLf3RFBz6Cnk8s;
	Fri, 10 May 2024 20:23:22 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/5] Five nbd patches
Date: Fri, 10 May 2024 13:23:08 -0700
Message-ID: <20240510202313.25209-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

These patches are what I came up with after having reviewed the nbd sourc=
e code.
Please consider these patches for the next merge window.

Thanks,

Bart.

Bart Van Assche (5):
  nbd: Use NULL to represent a pointer
  nbd: Remove superfluous casts
  nbd: Improve the documentation of the locking assumptions
  nbd: Remove a local variable from nbd_send_cmd()
  nbd: Fix signal handling

 drivers/block/nbd.c        | 41 ++++++++++++++++++++------------------
 include/trace/events/nbd.h |  2 +-
 2 files changed, 23 insertions(+), 20 deletions(-)

