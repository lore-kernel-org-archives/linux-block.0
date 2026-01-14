Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441A30FC36
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424899; cv=none; b=g72la58rLI5PPFiSmO5duD51Osn8inja/5HC8Xbv5EUN1hlYCzp6A4NDUFfEEG2WkbOqq3qBHCqWnmpsDNTmbjRl1pwZqbRgBQwTYdIIjhVALTF2GfquMYfiEWwcb5X0R9xsewA8QHLFtb5nTvUfot4lQBC3hpnlsSdi2UMslfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424899; c=relaxed/simple;
	bh=FWYRfxHwHDLuJkRMX+d3jo9EbcjAQIAUu8EoH7BejKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3Aoho9Vk47xl5B3QfP7FkzK8W6iP/nFZRqAmMWlrm11KRfr2EplZrB7kszF2LafRV31FeI1eP8tvpB30TIv8PyPX9AHwDGFo4Xu3ej08NREjvd1uZ/6EW2qqvBVMs/aNxXDwDKbGIJOSZScjT2qjylibEmDEV5vkD8yF5I5D5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5N/VwIF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5N/VwIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768424896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lsZPmMeUIRcybhL3ie7PTVa/I5MMOZ22XbOYUaSI1VI=;
	b=e5N/VwIFtsOD32XwA9gZDSECGmqPcpg+xrdsc7ZhtpNc+X0OK9uzgjkpbrCSOsBkYAhGoY
	mgSddbKg1riXwW7p6HByPxSOVk4TcIcPbwnZ1h2RoNJLtn8IPiLov9Z9n/dLaEzuTGFmkL
	YUNP3Vy/W/4U93wjnmqhz5k607TfOXw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-e2kNx6RKO_CYLKhWcnUdlA-1; Wed,
 14 Jan 2026 16:08:15 -0500
X-MC-Unique: e2kNx6RKO_CYLKhWcnUdlA-1
X-Mimecast-MFC-AGG-ID: e2kNx6RKO_CYLKhWcnUdlA_1768424894
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 707921800365;
	Wed, 14 Jan 2026 21:08:14 +0000 (UTC)
Received: from host.redhat.com (unknown [10.22.66.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF5DE30002D8;
	Wed, 14 Jan 2026 21:08:13 +0000 (UTC)
From: John Pittman <jpittman@redhat.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH blktests 0/2] blktests: add ability for multiple dev sysfs checks
Date: Wed, 14 Jan 2026 16:08:07 -0500
Message-ID: <20260114210809.2195262-1-jpittman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patchset adds the ability to loop within _require_test_dev_sysfs()
and check multiple sysfs values rather than only one. In older kernels,
as we've seen in recent testing, its common for sysfs values to be
missing, so it's good to check these files prior to testing.  We also
use the new format in block/042 to resolve recently seen failures.

John Pittman (2):
  common/rc: support multiple arguments for _require_test_dev_sysfs()
  block/042: check sysfs values prior to running

 common/rc       | 13 ++++++++-----
 tests/block/042 |  4 +++-
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.51.1

