Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210492;
	b=r2KTtdX6/KJTdkwJbhrZ2aEcA66wFd9RLB2rHPDMI/uxeSuW1crpHXLDxSd1bDoQ2Tyv
	 lY1I08wFYW3qTWB7dBco4rV2NhaZzXk7otlOYVgTZXjvts0u+eG3ZOsc1i+wwONsEtn6s
	 Qb53jNUcsfk5v25yL7KBt40A1f+bsWWxz4yCfHaFlw1lUAKsh/5JDLgLLwx3FvLf6PPt2
	 adASkfiIiqysw0iaRWcoVICxrjS2GZOnHwIU6CWytbwDpnkiVFlmUZRbug+hQImb53nBU
	 35xVwUN7Zfxlx6EXXvPcH+yJsJKKozS6IYVQgl444eYm3H/qvn4+OZ9dLRGp0tj91MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=F1uXydtMvoyYKc3cxUTwFffd3egFBZPK9LIE95K7tDk=;
	b=1/hbFbdd3ZvCd2Oqd9/Ll+Y2aYZRaizFDBjOlLG9lJe0YzywSAyZV1qYQFJEH2MOluw3
	 SCkKyehSgiIQ4gHusBg5ryKv2vJaoGN3Cj42ZK3lZ697IW35Y3ovijltzzKNfqNQQ5QdH
	 LsaCWLMBXMNrE/ZOYTiQ+BW9IejljBwJG327Qoi2MRF953FHeUOQDWqed43i0SIXLYZ72
	 JROKmEVI3G+1Jcre1xAufRBCMrONkgRyr+6HGlggywZPy0MpnAlXVwPFegEKJmC8EWD4b
	 xG715jh+eP2GclVMXen6ApKdjJ6YZ5cGqP3xYTLC2BD5rkmddOQE98X41XA1G2SWmZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=2vA8lNBK;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E60060A2613
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 21:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E60060A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=2vA8lNBK
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jWTBW6vRSz1XM6JB;
	Fri, 20 Nov 2026 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1795210482; x=1797802483; bh=F1uXy
	dtMvoyYKc3cxUTwFffd3egFBZPK9LIE95K7tDk=; b=2vA8lNBKlgA8mu1VyIjP+
	9s7C5XKzzcC6XxGzG80BFlPN7Dz2om6zAZoLOvLjUmDHypwvSEcwNIHt/gFNQrMW
	DamnsLOt1HuFD85eqS9sxMweR8eSF4yZRwwF6WaeFVpEWt6Up7pC9D1jykRMq0VS
	pYQRqcpYGps+A2kSTzqMGiq/wBvSAjC/CMV9g7+I6lqIsivWq4lM4UkONsDyIcQa
	8G2mpLVkjKIwjxmnvbUEiwxWsNFVMH0mMXAYD5/RoeCvXYwRHzt+Lc3I7JmFRGa+
	JkOv2R+o8h4og4TGKzZU4JN6Ac52XfhIFL4UyLjiUFUVj/IbkRwNoxEHC8+oNEdt
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wrQn91qZpisG; Fri, 20 Nov 2026 21:34:42 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jWTBV1wcdz1XM0p5;
	Fri, 20 Nov 2026 21:34:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 1/2] nbd/rc: Declare the loop variables of the wait helpers local
Date: Fri, 20 Nov 2026 13:34:33 -0800
Message-ID: <20261120213434.2945873-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261120213434.2945873-1-bvanassche@acm.org>
References: <20261120213434.2945873-1-bvanassche@acm.org>
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

_wait_for_nbd_connect() and _wait_for_nbd_disconnect() use the variable
"i" without declaring it local. Since bash uses dynamic scoping, these
functions modify the variable "i" of their caller, or the global variable
"i" if the caller did not declare one. Declare "i" and "sz" local to
prevent this.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/nbd/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nbd/rc b/tests/nbd/rc
index 6205c4938b7c..9a68c2c9abd4 100644
--- a/tests/nbd/rc
+++ b/tests/nbd/rc
@@ -42,6 +42,8 @@ _have_nbd_netlink() {
 }
=20
 _wait_for_nbd_connect() {
+	local i sz
+
 	for ((i =3D 0; i < 3; i++)); do
 		sz=3D$(lsblk --raw --noheadings -o SIZE /dev/nbd0)
 		if [ "$sz" !=3D "0B"  ]; then
@@ -53,6 +55,8 @@ _wait_for_nbd_connect() {
 }
=20
 _wait_for_nbd_disconnect() {
+	local i
+
 	for ((i =3D 0; i < 3; i++)); do
 		if [[ ! -e /sys/kernel/debug/nbd/nbd0/tasks ]]; then
 			return 0
