Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944946B5
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903761; cv=none; b=Jlij45miJalFw2HFQ+tjqJ5arKEDRXEkDxRD+u/1q42g9DbI/DnlZ0+BgUc1CgfDEuu33NSWliwm/N9nUJ+eirS4wtIYbmCeS4w7eBInf7CoeHNqAra3NyOtf9ja0JOFlKD573QDPFubSrUmMH58A59Iq4DJ7qM6owjnbGOLY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903761; c=relaxed/simple;
	bh=OxzUK6xKmkb/D9Clbd6H2Yr3VE3NxDyT49Q2Htd+VYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atFc7Ja6okVwfy141r5PtOdzPeXkmyM5bicN03+cXgtIVgFleASHTA9cx1Shqr8wjW7jF4ZCTX5EtUPn7s5+QXN1ZsErFf5cyayGguf5tUK0LeCEjKT2CW5A9GiZdb6+dTF/2O/dKZwXdjJtWpavYQK+Wx2gSoNUXC0sr9tNJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IGNex18S; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IGNex18S"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d5jRL4H0GzltMQM;
	Tue, 11 Nov 2025 23:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1762903757; x=1765495758; bh=av5NYl65EGSAoNlxV8VxrmiYiMSHM+Y6T2I
	uIZZEUyg=; b=IGNex18Se9UrMDw+kzqXXC3gNoYVlVjR1dcgqZrpTHnrOAi3X0A
	3X7Llw2vUHOCnskCNe1k7m8WKrq29APmqCg9FfMf3U2P1TkytjBc/1KO6dpwT9UP
	mmFPYFkdxIHslUmMBoqhq+ur3gNi091jSnuekZ50uF6Cdo5ANc41zoFsbPaV5hOJ
	na0Xy6rNMCcfvUi/cxz/MXXKXP/58UJuytXpGqaU+kIi6H9w6R9Qr55Dsam9bPeM
	ob6rKol6xgavifAjT//nfd1MSPiHVe1n183Ivg9Bl3Bx3NuJ4UkhAl+79Lu1Scke
	bRYZcavqScV7R0Ot5nzLJZyUBXJq+ahyYWQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TK8JZ0JhkaHz; Tue, 11 Nov 2025 23:29:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d5jRH26GJzlgqyc;
	Tue, 11 Nov 2025 23:29:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Refactor blk_zone_wplug_handle_write()
Date: Tue, 11 Nov 2025 15:28:59 -0800
Message-ID: <20251111232903.953630-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This series includes three small patches for the zoned block device code:=
 a
typo is fixed, a lockdep annotation is added and the code for handling zo=
ned
writes is made slightly easier to follow. Please consider these patches f=
or the
next merge window.

Thanks,

Bart.

Changes compared to v1:
 - Combined patches 3 and 4 into a single patch.
 - Renamed a goto label.
 - Removed the local variable "schedule_bio_work".

Bart Van Assche (3):
  blk-zoned: Fix a typo in a source code comment
  blk-zoned: Document disk_zone_wplug_schedule_bio_work() locking
  blk-zoned: Move code from disk_zone_wplug_add_bio() into its caller

 block/blk-zoned.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

