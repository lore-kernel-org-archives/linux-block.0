Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F2270ED2
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126153; cv=none; b=kVY7cqwavqLxVt3Y9bQ9hwj1fthEkJfN5rJqoZEz4ifzH+MT9FItMqZRJ9lV8LA/l/rEfhwZEJ2EaEOrzbIDbD1wCEzSyglxGqBmvnFzj+SV9nuzuCtc6YSOoJmhDD+qqq+GLsPa+e/ggAtX3vQsnPSO1G+YItraLKVKq0XKYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126153; c=relaxed/simple;
	bh=wE+b5SfvlhAZ3EtNwxr7EY6eYceepz/tuP9WeS8c1Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJqd1sM6Z1VE/Dwsp541QIB2Xr6VsVeipGeYAKQ1z8xYCzw9G+wDoYB+kIIlIaT4dMhn/N9jfk4mvLrvUOedtBbhM4qBnLk/2ZgM5FLqj38oS1KoH0LCxp+DecSZtVTe+IQ8PvG9UvZucdRSGBl7ZmHEIETrueuROnFaCg+fyww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8SG8MrV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8SG8MrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756126150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wWiO+k0dOHTECn0yUrYb6y1dZkfsp112py2a3IEf9no=;
	b=Q8SG8MrVHYxx8thYGdqyYV8YfgOTXJromxz5Edj4h8UCcc8lbcTgJ7Wb+WR7iufyO8jZSr
	ydNSfGHdL2egK/5painfPz0pzB5b9rOVObDTi2M71JxgLoj0hvG/MfQJ01Tcma21YFnZW5
	37h9f0NOu6LXzBYjK1PY88cPSfJuHAQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-ulXsg3WuPu6CK4hrnJothw-1; Mon,
 25 Aug 2025 08:49:07 -0400
X-MC-Unique: ulXsg3WuPu6CK4hrnJothw-1
X-Mimecast-MFC-AGG-ID: ulXsg3WuPu6CK4hrnJothw_1756126144
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C42418333EE;
	Mon, 25 Aug 2025 12:48:53 +0000 (UTC)
Received: from localhost (unknown [10.72.116.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A9F530001A5;
	Mon, 25 Aug 2025 12:48:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] ublk: avoid ublk_io_release() called after ublk char dev is closed
Date: Mon, 25 Aug 2025 20:48:23 +0800
Message-ID: <20250825124827.2391820-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Jens,

The 1st patch fixes ublk_io_release(), and avoids warning from ublk
selftest(test_stress_04.sh).

The 2nd patch adds test case for this issue.

V2:
	- release ublk char device in async way for avoiding dependency with
	io_uring_release(), where sqe buffers may be unregistered finally

Ming Lei (2):
  ublk: avoid ublk_io_release() called after ublk char dev is closed
  ublk selftests: add --no_ublk_fixed_fd for not using registered ublk
    char device

 drivers/block/ublk_drv.c                      | 94 ++++++++++++++++++-
 tools/testing/selftests/ublk/file_backed.c    | 10 +-
 tools/testing/selftests/ublk/kublk.c          | 38 ++++++--
 tools/testing/selftests/ublk/kublk.h          | 46 ++++++---
 tools/testing/selftests/ublk/null.c           |  4 +-
 tools/testing/selftests/ublk/stripe.c         |  4 +-
 .../testing/selftests/ublk/test_stress_04.sh  |  6 +-
 7 files changed, 167 insertions(+), 35 deletions(-)

-- 
2.47.0

