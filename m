Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539C208CA
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469422; cv=none; b=FOg8mtKu9YaDzOLCTrugRsUu3QNJtg3mOWOwaJBXqIp4QkQ6DF0OIr4RR1c51c/FQy2eU+BVlg4/VZC1CWIVLiWr3PmYFlwaOjWwRQGa88VhnKnVMhXLWsysN1PUUU8nnUOphxauxPQzjqkoBkI8Tb1tz5WrhQMmef/U0z9RY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469422; c=relaxed/simple;
	bh=JrHXpmaHuc/ZqfEr7G+WZIBvqhx18E/Ev0iuGfT//Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRNS5E3amSrK1y+eD3H2mx/6iir+HuT1RxM2gnnluiL68OKSnxxEOUqMRqWfxLjndgNIDsqEuZjVAS26IW1RISaZbA7Vry7txAnIj2wYmj3a1aPDKwbpUveng8r9VuYuE0MqVOZrLDXv9TWvMO4CGVymynEC8yIQye7bNwIg2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N/2bbKb5; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N/2bbKb5"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCTn83G4czlff0N;
	Tue, 17 Dec 2024 21:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1734469418; x=1737061419; bh=mGiPXSbNa9UxfhojN6W1PqzIoxRUnw11zXl
	6zegv8x0=; b=N/2bbKb5+oXc3A2On42o1+dcZHFSyONIQ0Xnya2FNslxaqtV56q
	zh3kklxEtTqrH5ELKGakLdKsaXvn5lRoyFHqyUR4ZIX6mqwBxffwAO1gMPmVZqIw
	MTIyMkS9PgjSjxoMSGhzA3t5ukYlOgC4mnshMHj/ohaX8fPMNr4MbMiiq8WaJHl8
	oudfNPH5aVHO8cq0rkfRN5xR6raiHzx2tdvipAW8PoHwMb1HBlf6QkDkosMPmet7
	/SaQYAsSRmAe0sPmuDt8hOC4gDjw0oMuOtkCmaGCcqQ3yaVSazAQ0/gsm0qUnVYI
	oAiEdT0eQeIgbIXPMFMI1PhWFM3z3A3OJ8A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qn1NWg1KmkOk; Tue, 17 Dec 2024 21:03:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCTn44R4Vzlgd70;
	Tue, 17 Dec 2024 21:03:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/4] Minor improvements for the zoned block storage code
Date: Tue, 17 Dec 2024 13:03:06 -0800
Message-ID: <20241217210310.645966-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series includes several minor improvements for the zoned block
storage code. None of these patches changes the behavior of that code.

Please consider these patches for the next merge window.

Thanks,

Bart.

Changes compared to v1:
 - Dropped two patches about which there is no agreement.
 - Added Reviewed-by: tags.

Bart Van Assche (4):
  blk-zoned: Minimize #include directives
  blk-zoned: Document locking assumptions
  blk-zoned: Improve the queue reference count strategy documentation
  blk-zoned: Split queue_zone_wplugs_show()

 block/blk-zoned.c | 58 ++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

