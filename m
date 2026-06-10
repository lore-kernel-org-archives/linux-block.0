Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6F332909;
	Wed, 10 Jun 2026 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118189; cv=none; b=gFbdf47jW+Sj+TbSWFidjfjoyijMkQm0fHt4PCQ/uYZzvx2Dh8z54WqutXYuUidnKs3gZRDWjigUrqvagErd9MDxrNClQc9JEKCDQCAM4VcYdI5yTxSu7BtZw2loLvFr8MAW5PUfjexNmKeJppMqkrWZcqeK/ciSrqij3O2Vf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118189; c=relaxed/simple;
	bh=SJfLQbgTPXaAhUfsaRNU1Kx3VtPAkUk8KgHd65/nuv0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YaGuxc13VzqoO8Nyj59NRR3wSrHLL/XmVbdGahN1Hwt6uv0J41/r7Qhsc8HEQoLv92HhMgdp3+mbnU0uQeLiBkyIJ16+gEqSft7yaeKlYGdpAmwfuMZsR4ynky8W/N8DQkScvaBQ2d4C+Iuf5EXJrtVqoWu3HlmakdudZ/Ns2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dr5dQZmW; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dr5dQZmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781118184; x=1781722984; i=markus.elfring@web.de;
	bh=AvfjeOQP6fyejVHxxw94cS//QRLwYtEoop77cWOoGx0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dr5dQZmW++89J/NftGkNCiuTmbo1dTce2CSdX9nt47lLScX4UbalTr+e9M2+tDjf
	 vJnNYtJaxHth8OdtyqkDmpVM37jI2Umcbk0mUZHeAxb9iMNn7IXMVnPo6Fy+YMg27
	 GXvaNjjwwRzU2pcGUFMLLRdzbtVFEEUlCuSZrGpSSToqioEiHdg7vJMYXNuIh8S/5
	 HeLc5Q1MowJyQxiS3cu/+fkseSheOAAVfwbAmL+SE5I52r1z0e/X+MBQ6eXeslTiy
	 McHVfyCdDUZ/7wExbzEz+lEk80COpiOBQ6+vl7Mla9I8Gwg+hLwB5QIuiwwh4D4xu
	 W3C6qHKCLoUlXp2HJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1xB6sN1yF9-00ntir; Wed, 10
 Jun 2026 21:03:04 +0200
Message-ID: <c9f86f0b-331d-4cb1-b8a2-00bc1e857ec7@web.de>
Date: Wed, 10 Jun 2026 21:03:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-block@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>,
 Jens Axboe <axboe@kernel.dk>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] rnbd-clt: Use common error handling code in rnbd_get_iu()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KGFMZs0CxEnY0oW8m7369iCAfN0PIsxmYRmi6gN2nh9l5Qr6fFU
 ULVn5fKU7omayqUtCMWGRK/0MMts0ecgwlk4Wb4cKo2iKsisl56eu89tHAJgPpG2jed4mSs
 a5OKr4IP34hRVJ29CIuqtaAX/8XB2dUh+ER2pAghEe9AK0XhSoOTUa8BIgT/oUVdrb0bp3C
 e7d/RG7JZ2B+RCBnBoD+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4cV28uoYJoY=;ZdqyE+DUdlqFZzuvQhm9X/N9JDn
 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
 BeaJug==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 Jun 2026 20:58:47 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of an if branch.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/block/rnbd/rnbd-clt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 4d6725a0035e..d8e3f145ee2f 100644
=2D-- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -329,10 +329,8 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_se=
ssion *sess,
 		return NULL;
=20
 	permit =3D rnbd_get_permit(sess, con_type, wait);
-	if (!permit) {
-		kfree(iu);
-		return NULL;
-	}
+	if (!permit)
+		goto free_iu;
=20
 	iu->permit =3D permit;
 	/*
@@ -349,6 +347,7 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_ses=
sion *sess,
=20
 	if (sg_alloc_table(&iu->sgt, 1, GFP_KERNEL)) {
 		rnbd_put_permit(sess, permit);
+free_iu:
 		kfree(iu);
 		return NULL;
 	}
=2D-=20
2.54.0

