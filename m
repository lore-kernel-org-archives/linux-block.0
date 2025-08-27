Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6921ADA4
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296975; cv=none; b=fCtB6YYceNSwK6LQuJAgY+/NUD6REBuSIprWbUoqgbutQNLb7rdlB3CMClGle2A5Ewky/RO6HZzwQWwgjLFLslFEV6zvSNqProY6CEi3EzCCUG6Z7gNjPVMCjHvHtHDOuvT82rJ4fFVBWlZv9zdJ8Pr76//7nxAVH0iEWovlRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296975; c=relaxed/simple;
	bh=64RJLFmUTgn3KwPcakf3CMSl2h8w6OClYMuAconURZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ip+sb6Ttp/6BZX3P+2f7BF6oR1tqUaVpziCg1CI6jEYHfhI8jDhpuR4OCTa9HIZeuJgjuxOv/fCd/ZYy1tQ1yTcqdG9nrxka26rMJJ9y10jkmmN6O5LaD4mA9edIpGq5UORxHca9+tRquj9PuzudGJlA9WFrXNldgvlAHy+jwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MICPuqpK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MICPuqpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756296972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qOpHtV7DwoI0yeXFBc3V1qJ+g4e+K/ug7wxXTaTjt9o=;
	b=MICPuqpK0IIxkosdiQupC+6AdXfvBRKin2TPSjLuYWkHURJFdTqBbIBcZW6Au3JIbORE++
	TXcIIl+B5vrsC7kKmx7YDvZRSK9AImHePKujV5HXWP2/q+rZhj1XBSSpemMVTHSIlALVKf
	PRzq14CJHbX/YUkZNxuaXdwsDcwAsWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-XXFyNXmEM5eUAVJq5vx05Q-1; Wed,
 27 Aug 2025 08:16:11 -0400
X-MC-Unique: XXFyNXmEM5eUAVJq5vx05Q-1
X-Mimecast-MFC-AGG-ID: XXFyNXmEM5eUAVJq5vx05Q_1756296969
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF44D195609E;
	Wed, 27 Aug 2025 12:16:09 +0000 (UTC)
Received: from localhost (unknown [10.72.116.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D7261800291;
	Wed, 27 Aug 2025 12:16:05 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/2] ublk: avoid ublk_io_release() called after ublk char dev is closed
Date: Wed, 27 Aug 2025 20:15:58 +0800
Message-ID: <20250827121602.2619736-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Jens,

The 1st patch fixes ublk_io_release(), and avoids warning from ublk
selftest(test_stress_04.sh).

The 2nd patch adds test case for this issue.

V3:
- move reference counter reset into the check helper(Caleb Sander Mateos)
- remove 'ub' re-assignment in ublk_ch_release() (Caleb Sander Mateos)
- improve commit log

V2:
- release ublk char device in async way for avoiding dependency with
io_uring_release(), where sqe buffers may be unregistered finally


Ming Lei (2):
  ublk: avoid ublk_io_release() called after ublk char dev is closed
  ublk selftests: add --no_ublk_fixed_fd for not using registered ublk
    char device

 drivers/block/ublk_drv.c                      | 72 ++++++++++++++++++-
 tools/testing/selftests/ublk/file_backed.c    | 10 +--
 tools/testing/selftests/ublk/kublk.c          | 38 ++++++++--
 tools/testing/selftests/ublk/kublk.h          | 45 ++++++++----
 tools/testing/selftests/ublk/null.c           |  4 +-
 tools/testing/selftests/ublk/stripe.c         |  4 +-
 .../testing/selftests/ublk/test_stress_04.sh  |  6 +-
 7 files changed, 144 insertions(+), 35 deletions(-)

-- 
2.47.0

