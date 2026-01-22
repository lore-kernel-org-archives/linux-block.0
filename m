Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D116395728
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110319; cv=none; b=iBFajBn2e9/j135UbsDLXoMH6nsLKIFUXCae2LmAC95sizmhu5TeMpmi910CRPgd+18o5+gAQPMDNB5TSfW55qWzap+z+YHFIcQewr/yWtdCMR4ljW0sdfmeZ9oVKVCW19NGFzvB7Zzp9zIPeg0u4yaWVmLIBSb4mFQn0nKxpfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110319; c=relaxed/simple;
	bh=IIYaHPRbcs3rphguiguxXePOm6v8tbCrYnTQ3/yh44c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkSLxj/dJnhZIwtA6vTs1bnOZsvlkur4NvgA8E6CYcITuxjI2XJDxUUIf97eWRZ0hLWyWkCusX4ktmlNQzG/S9yEaxAgVMvGbBqpyqwdgybyqlZxpbPNgDJHLps5nrinxujlXXvDPZhZ7LVztNMdfV5JYoqOj8vzeROm5j33Z8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/h8E4O5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/h8E4O5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769110303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+NVNtPeyA94bHMCqiFAGcAyCAKl0Ro1DViUhI7WDRBM=;
	b=W/h8E4O5r/mIKoymB328ureEvRKHZqZ3WNx4Ej/9QDAzdmTWbI7TFAfl3zKtlxHwumvdJU
	22Ts+g/OlMDLTLf60+ZJUk3JZMWvkdCXzO/eKsTYkn7mRfs20G3Dl+lL0d0sYFN3N6cTwZ
	F2Sh5SCguyG3VpxAV1DpjAykuxvkFTk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-mxaGGdWsMG2XtSyMJQ9wyQ-1; Thu,
 22 Jan 2026 14:31:39 -0500
X-MC-Unique: mxaGGdWsMG2XtSyMJQ9wyQ-1
X-Mimecast-MFC-AGG-ID: mxaGGdWsMG2XtSyMJQ9wyQ_1769110298
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8227B195608F;
	Thu, 22 Jan 2026 19:31:38 +0000 (UTC)
Received: from host.redhat.com (unknown [10.22.80.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF93C1956095;
	Thu, 22 Jan 2026 19:31:37 +0000 (UTC)
From: John Pittman <jpittman@redhat.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH blktests v2 0/2] blktests: add ability for multiple dev sysfs checks
Date: Thu, 22 Jan 2026 14:31:31 -0500
Message-ID: <20260122193133.3087906-1-jpittman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patchset adds the ability to loop within _require_test_dev_sysfs()
and check multiple sysfs values rather than only one. In older kernels,
as we've seen in recent testing, its common for sysfs values to be
missing, so it's good to check these files prior to testing.  We also
use the new format in block/042 to resolve recently seen failures.

Changes in v2:
 * set attr variable to local in _require_test_dev_sysfs()
 * removed empty arg to _require_test_dev_sysfs() in device_requires()
 * changed spaces to tabs before _require_test_dev_sysfs

John Pittman (2):
  common/rc: support multiple arguments for _require_test_dev_sysfs()
  block/042: check sysfs values prior to running

 common/rc       | 13 ++++++++-----
 tests/block/042 |  4 +++-
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.51.1

