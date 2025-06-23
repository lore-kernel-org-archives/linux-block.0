Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A7010F9
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750641591; cv=none; b=Y2OavE07jrDr59D8mobKgXJid6U/mqgC+SQmPvuBBnvkJq5Q82C1bVQVfvJ3YyN0mxGavH3PJma1Vtr0cA477MRMpxzZ+ieZw3UYF2E5nuffgYWSVkEa44R6U4llSBjmV1Zq4UXYy6RYlEyYirykY0eW7mOOJuTU6UohXn/9o9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750641591; c=relaxed/simple;
	bh=di4OgD9SQWOFiHvlJo+Fe7ECO+VS+QPf7ATiuVcyGgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0rpy0ZGYPDXBGO7BnSPY+ZQQvJastQsBBojmCKVEBTTVCUvH3QvWuy0jnwxNiO7F8IUNhUFN4gqmPiKfJInLtZiVnhhiyTek98r1HUxZKXSeRgU3Nl7Co2hYNzUFApkRoZ8oisPhwKDicuVa9l/ysDrBpnDt6By/2s1UKC5iEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+uu4UPh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+uu4UPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750641587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xthvLvozr5m1XNnoUzHoQdGRhqr0AW5b1Oh33UvH6/w=;
	b=F+uu4UPh9usUVlLmDg2ypb4uAXSpob2rUJXYq/N+r8euH1LpfiG5/cRPfsKMfAAv48j/vO
	zem7dQD0o5VsQbgKslPnH2nbi7CWo3Y4AJuLCHkN4vsEOL72uFVYZt9E8pe63zQWx6Kt4Z
	vSDxwPVYRszWj9UdDBna8qXK7Pvy2Gc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-88uqje9rM2yBxHOGR9CA0g-1; Sun,
 22 Jun 2025 21:19:44 -0400
X-MC-Unique: 88uqje9rM2yBxHOGR9CA0g-1
X-Mimecast-MFC-AGG-ID: 88uqje9rM2yBxHOGR9CA0g_1750641583
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D171E1800287;
	Mon, 23 Jun 2025 01:19:42 +0000 (UTC)
Received: from localhost (unknown [10.72.116.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B32CE195608D;
	Mon, 23 Jun 2025 01:19:41 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] ublk: fix ublk_queue_rqs() and selftests test_stress_03
Date: Mon, 23 Jun 2025 09:19:25 +0800
Message-ID: <20250623011934.741788-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Jens,

The 1st patch fixes ublk_queue_rqs().

The 2nd patch fixes test_stress_03.sh.

Thanks,


Ming Lei (2):
  ublk: build per-io-ring-ctx batch list
  selftests: ublk: don't take same backing file for more than one ublk
    devices

 drivers/block/ublk_drv.c                       | 17 +++++++++--------
 tools/testing/selftests/ublk/test_stress_03.sh |  5 +++--
 2 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.47.0

