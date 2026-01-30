Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A82D061B
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790365; cv=none; b=rYa6IA5SB82KjC/K5ZcW8Hlcz+slvjB5hpEc9NMgzLTeXUuisD4OaJ1swXtw5voFxRRGsphd8pnvNpBTtHa0f55//+zKPjJ18xYJm+wP4FyAdTjNn9RAal9C66AaWXYxq7Ta9tLrUZsLNj9Kga9RiWVZg0NJWKbPCEsjfqTxdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790365; c=relaxed/simple;
	bh=5Z263AXmGssO1BQ6DqMOONhC7Nim5IJ3rjZ+yPAy1Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTwc/JkmF7t3Ncse5wVJ3hiFatMaIlOZjfh3JA2sJDBqKdAyc3B4lUFXWzUUNZqGxba/lRF+cSFANvlPR+dOl80QDB7HWCeZAl/tudigogGtG3jFVRyU6hQ50i86jzmTDVKEkPFTI50H/2qFCPyegNjUiPVjpy8ZrBM/TgiP1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwOVe4gt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwOVe4gt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769790362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ygfW8Aq/zgDsvRKYgEPkI4Q8Ibhe5PuoT+TN8rTc1YI=;
	b=cwOVe4gtzjosWd0p1qaFsn/2802xIgYMM6qjwYIuLxHvtUDh8zl/uLUQ/9PNmIa+P/2xuT
	7NzEI/u4VsSVEIRGmFBoxYylevTdMNCJan95GHMUcTx4VSoZfhIWDaMAyNFetd3vVFtQjv
	sdrW5p1fkM/imn5c8NFAx1BNzI1C09E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-TcED5kEoNXab0m3wM_uVBg-1; Fri,
 30 Jan 2026 11:25:57 -0500
X-MC-Unique: TcED5kEoNXab0m3wM_uVBg-1
X-Mimecast-MFC-AGG-ID: TcED5kEoNXab0m3wM_uVBg_1769790355
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 848CF19560A7;
	Fri, 30 Jan 2026 16:25:55 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 107683000218;
	Fri, 30 Jan 2026 16:25:53 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	gjoyce@ibm.com,
	jonathan.derrick@linux.dev
Subject: [PATCH 0/6] Extend Single User Mode (SUM) support in sed-opal.
Date: Fri, 30 Jan 2026 17:25:06 +0100
Message-ID: <20260130162527.570255-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch series extends support for TCG Storage Opal SSC Single User
Mode (SUM) in the sed-opal kernel interface. SUM addresses few
shortcomins described in the chapter 2 of the OPAL2 sepecification
extension (see below). It better isolates Admin authority from User
stored data by taking the Lock/Unlock/Enable/Disable privileges from
Admin when managing Locking Ranges configured for SUM.

This permission split necessitates separate ioctl calls for operations
that previously could be performed atomically under a single authority.
The series refactors existing code and introduces new ioctls to support
this model:

- IOC_OPAL_REACTIVATE_LSP: Switch an active OPAL2 device to/from SUM
- IOC_OPAL_LR_SET_START_LEN: Set locking range boundaries only
- IOC_OPAL_ENABLE_DISABLE_LR: Set lock enable states only
- IOC_OPAL_GET_SUM_STATUS: Query SUM configuration status

References:
- TCG Storage Opal SSC Feature Set: Single User Mode specification
- cryptsetup code using the extended sed-opal interface:
  https://gitlab.com/cryptsetup/cryptsetup/-/merge_requests/832

Ondrej Kozina (6):
  sed-opal: add IOC_OPAL_REACTIVATE_LSP.
  sed-opal: refactor (split) IOC_OPAL_LR_SETUP internals.
  sed-opal: add IOC_OPAL_LR_SET_START_LEN ioctl.
  sed-opal: add IOC_OPAL_ENABLE_DISABLE_LR.
  sed-opal: increase column attribute type size to 64 bits.
  sed-opal: add IOC_OPAL_GET_SUM_STATUS ioctl.

 block/opal_proto.h            |   4 +
 block/sed-opal.c              | 367 +++++++++++++++++++++++++++++++---
 include/linux/sed-opal.h      |   4 +
 include/uapi/linux/sed-opal.h |  25 +++
 4 files changed, 371 insertions(+), 29 deletions(-)

-- 
2.52.0

