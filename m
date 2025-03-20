Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B940BF5
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434697; cv=none; b=e0sLduIvP8ST9nG+4d80qCHKG9O8PS2f3QyBK//vEeSXGOHJGl0EXP7jAnPxhztBGgIGTlBWQVAP5wo9d56udAlH0Aq8DYoNww9QYzMtUhZsM89O4RVsKsltibjDpZ/976aZ8ijhrvPBKmoYn/gKAmsR8sQXR2cRhnx5Ux8wSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434697; c=relaxed/simple;
	bh=s05YbhR5WYdi/b0ZDOiXXObSHRy3LI5il7+bmt9NuSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/YRlPjNkU9Z4BXK9So0kvOLUsQq/eAkQQ6lsc8qQatUx4WBo4Izk1TJX+/dn7r62jFqgR1VJ3aY6+9sySnsSFTH4i5QMqEnLB52FPJ2J/vcfJUMzY3UnxDyXY5rORZIwmMgKTXRcedBJh5CiJigra9dQj5GpwJgvZGYVkbeAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4O3sNkZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4O3sNkZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742434695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=smrbqI+7Djc1aIri/LuGzG0PK6m6BhqwuIgU8mlWT2Y=;
	b=N4O3sNkZ9QaI43FmzY6erKGw+H4gA4bUD5MY0/DWxJqceGkepPLSKscgX2m7lY7xZgS/bm
	4WlCMyTcy25UyBfRmEMZ3b+TAHbLFNcRoglgaiLDw2FI8lKhKbe9Xl4bRtyiLjPEr1Kh31
	KW2qunnN2XLbYSy7bBC8zSa1Rabfia0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-rmMVNS0qMCSFyw4wfQ1vLw-1; Wed,
 19 Mar 2025 21:38:13 -0400
X-MC-Unique: rmMVNS0qMCSFyw4wfQ1vLw-1
X-Mimecast-MFC-AGG-ID: rmMVNS0qMCSFyw4wfQ1vLw_1742434692
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D11819560B2;
	Thu, 20 Mar 2025 01:38:12 +0000 (UTC)
Received: from localhost (unknown [10.72.120.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 182301955BEF;
	Thu, 20 Mar 2025 01:38:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] selftests: ublk: one fix and two improvement
Date: Thu, 20 Mar 2025 09:37:32 +0800
Message-ID: <20250320013743.4167489-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Jens,

The 2nd patch avoids to show modprobe failure in case that ublk_drv
is built-in or not enabled.

The other two patches improves test deployment.

Thanks,
Ming


Ming Lei (3):
  selftests: ublk: add one dependency header
  selftests: ublk: don't show `modprobe` failure
  selftests: ublk: add variable for user to not show test result

 tools/testing/selftests/ublk/kublk.h        |  1 +
 tools/testing/selftests/ublk/test_common.sh | 20 ++++++++++++--------
 tools/testing/selftests/ublk/ublk_dep.h     | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/ublk_dep.h

-- 
2.47.0

