Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210489;
	b=jZktz5GhH64izdM+eEfTCAOcP3xtrLBMPlD48/vT5eQVmoZ7CYkyuWjZYQE/rihFjDkD
	 i+f+P2AdcZLfluH5eJQ2B3Pq3BY+rw93k1QwHmimKB6xpizPO6JshuaZITYhZJDZKL7qX
	 kC9pRbmclCu1xUmgwjfLpSFTSTFb0tIiPpGxR1kjnABfJnqQ+yIzpQg8UjGMcWzAE/+XO
	 8EDNRQi4KHVLQ728ho3uKyPM2e5UKyU8pNX25QbuVsYbY9SV0mz/ZxR2fmekgxx4C+V1T
	 rpZTvRdm799Yk33fybWzYy4/LNbI+Q7kUtNjz75hxi5G8vnljkQXCWHSkEgpak0Sn4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OrTNQo/nFBLP8VTq9caUd+/LnpXs90EP5CZ00jxgXC4=;
	b=RsL978GniNNwjkUbQPAOUqNaRTyq2f9MAVXIQE+pJxzwBL+0f51EA7QxKeT6dgQvgBoH
	 vc69blNguX9C9Mmgsrs11xQELqxBlXdT76ZpK9N1lE2NJohBZTDx+8QF35QwkCQ9g+ecg
	 /scbPgmdylmr4VxcVW/1M+h/2g93y4QFIj63BVdsKaD76H2p04VpbOc64f42Nb/ZENrE+
	 WfY42lZZaycg9hzbQi/jqh87NHRARIK1TwiXAp6+1vDNHsvVLCmydatBfrD8fDLNPblc4
	 s3IKIArm41pPN2ESQX9/sSClfaf2uv8oMlkov2TyLPTD+XaQcKD387kYnjUmYUYfpyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=2DLEiLHf;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3B606A6BF
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 21:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F3B606A6BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=2DLEiLHf
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jWTBW2kLlz1XLwXN;
	Fri, 20 Nov 2026 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1795210482; x=1797802483; bh=OrTNQo/nFBLP8VTq9caUd+/LnpXs90EP5CZ
	00jxgXC4=; b=2DLEiLHfMPX5sZoQkqRXPK56TWrZy3neM/i6kSiZieRCVpwaMYY
	hJoav5RH+bhHbYRUoZnqYCpo6oVASVRjeActZB91ckvnLPnkaZbZNwmeamHKfjyq
	PiBsuWb+Il2uv3TG8DXNTKEFWWl7trtahPriWs1W0ujiuc0wg8P/MLA5ceKsBkJw
	0HPzorAb5Bi+pcaH/61SwB7Kdefhpr60I0H/deHVcNpwzj6h9NuQ4FK115OgifIA
	2MyeA1iCoQWlGIEO+Z+Bf4cgWoeeBzfNQqaUUwwa5kxjyUqArKKkY4vaeKLoqBoe
	edS7dZu543fFFGET2rstAbF1N8A7rR5OiAQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sOEwClyUPnKW; Fri, 20 Nov 2026 21:34:42 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jWTBT6cZ3z1XM6JB;
	Fri, 20 Nov 2026 21:34:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 0/2] Add an NBD performance test
Date: Fri, 20 Nov 2026 13:34:32 -0800
Message-ID: <20261120213434.2945873-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shin'ichiro,

This patch series adds an NBD performance test. Please consider it for
inclusion in blktests.

Thanks,

Bart.

Changes compared to v1:
 - Added queue depth one tests.
 - Added a bug fix for tests/nbd/rc.


Bart Van Assche (2):
  nbd/rc: Declare the loop variables of the wait helpers local
  nbd/006: Measure NBD IOPS with a null_blk backing device

 tests/nbd/006     | 202 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nbd/006.out |   2 +
 tests/nbd/rc      |   4 +
 3 files changed, 208 insertions(+)
 create mode 100755 tests/nbd/006
 create mode 100644 tests/nbd/006.out

