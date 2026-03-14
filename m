Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71A361DC4;
	Sat, 14 Mar 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773497732; cv=none; b=i4jrsXx9eoQnH+xdo6QIwGYdPzoQNEMmeaEuQLVw34fJXlyvh8b+CMnt0VTrdIqAWcLwDv+wolgkcklhgZslO0+oegodZMCEY5PITDHLh66L2+NJokvffu7/g38BMhjSOijfV7zCGFKfTyuQxyEX19x+wHmSBm3Ai65N/1AnJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773497732; c=relaxed/simple;
	bh=De261tD3L7fpwQ/AkVdXFng8Gkbh96Yt2Hurrim0bCE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hOlqjDXRjZ2F+csKkx65R5T5NWCsWe6M2EdSx9y54J+UzBtDLHQ4FMt9KBfgvnPu9xeZgEGf35eHl3UFTVH3aM8pnzBnhzfFfC3R00o6HChcisEQ0yIng+yS/voznNPbvPhz3nrA5Mxn3PhaNHTRCSeZcwsh+bQRHW/36qM2B9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SlW2LbHh; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SlW2LbHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773497723; x=1774102523; i=markus.elfring@web.de;
	bh=CxeUHfbXdBtktIBVhmb65Y5ZaLBhqAiuev8Ij2CYrfQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SlW2LbHhucy5q5LH7sFfYpqwNY0ydN3VCk0Vuyrgd4ySIB92KuaXQqKc9XiJIVUp
	 1DBL4F1+QrmPJ4xIccT5Oz28MclaDlzFssUMKMcPm3YnA2sZ0wUWLtiGyr+UW3ltr
	 cWERqiBFkoMNxy7IqdySQ7Xb/4miDNs2XpC8NRwwd1Y4WipKjyNz8jsC50c4bOpGn
	 4AllxrEtHaM8ON7BYNiX/7W/6g3swyn6vVroJGpbdx9y/1U93N9lAPFXxpaaDrNS2
	 qKyq444Ih6odHneGxnfhQpii3iX4il5d+UhxpK72rqVFByfsZUCzuVI5ca8epX+gt
	 YQ4ERuVMU8GUaRKYQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2kU-1vqOCh2RWS-00BlKn; Sat, 14
 Mar 2026 15:15:23 +0100
Message-ID: <ccebfd2b-0806-4ab4-bda8-2b043427bce5@web.de>
Date: Sat, 14 Mar 2026 15:15:13 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Felix Gu <ustc.gu@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] block: Omit a redundant pm_runtime_mark_last_busy() call in
 blk_post_runtime_resume()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UIi8JWatyiLYBtk7CwTJw/VLAZKV1dQVLxmGssNllfJbZWSxxUE
 9JQWMD6B7WvQi6JGPfOD3j0ikr0f/ycuiROvWF0s26v5CojNM10tFWb8CxA56WL+uoW3B7E
 qvTBdrM2rRtfxNXgL2yCv7rGlNtkiS9AOKPibrpCcLNwtQYZ5YwuId+Ux05hSEh+FfgVaAP
 d0IQP0XKqduJdh0Uk6amQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YHQXUXrE29w=;2xkA++akTtCWFIecmty28p0ljrR
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Mar 2026 15:06:37 +0100

The device's last busy timestamp was set in a wrapper function since
the commit 18c1fe53d186867243f4cf17f4eef60737a16c4c ("PM: runtime:
Mark last busy stamp in pm_request_autosuspend()").
Thus delete a pm_runtime_mark_last_busy() call before
a pm_request_autosuspend() call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 block/blk-pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 8d3e052f91da..d6eab3193a20 100644
=2D-- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -181,7 +181,6 @@ void blk_post_runtime_resume(struct request_queue *q)
 	spin_lock_irq(&q->queue_lock);
 	old_status =3D q->rpm_status;
 	q->rpm_status =3D RPM_ACTIVE;
-	pm_runtime_mark_last_busy(q->dev);
 	pm_request_autosuspend(q->dev);
 	spin_unlock_irq(&q->queue_lock);
=20
=2D-=20
2.53.0

