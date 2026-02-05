Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA723EA90
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304193; cv=none; b=gFjJTcLamrT3X2DohRlHsMmawXWFWP7eIS+Wh2G0Xg0Rn+MLLBDY7CAIE+tP8xneX0WkfPl8riAQcSUn2HUQcZfapbTjIMT5S7aVUkkJWUZXg4R1eZAkr73A+ncm3WrYY68WrZX3t7CL55iupX1P5l6IlNKDPMukm8QNLbflEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304193; c=relaxed/simple;
	bh=uqCPIjmXVz+ylWQk9Ma/HUX1A02IFnhacygnovlEeXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLblCxksL3DdMgmUdBf4vh7E8C0j9o2J2uRLZaWF//VdVAXCUbgwRfMFo1MvuIkZXGBRt+LJjUnziaKnRZFyBTyA9vul3dKUljQrk4f+IE/Bry/mqXIpg+kh9lHKcbS9bntgydi5gLh7OBDbWcCaJBefnH+vcSYvm1FKGdnpfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAOhhvkf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAOhhvkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770304192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWAate0VAub8j2pH34K8wd5v1+2dxKOy22ySrdtazPk=;
	b=CAOhhvkf+BtcGOXFwQPqtva7dpB+Sm1x+p0kGcmYuaUofHsKrU6onwyZJZpI/+MotAbS+Q
	N/YfdbuHOfvN4aT9Qw/+B3ulf6uL/uSBtKOmZltdn6V26kbMEGqFZr4Xrd7zVGJlnupCtn
	6Z8nP5JWwYxH+bfhbPI+qnXRK2xUitA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-SQeL31z6Mk-m1x2hz6VG7A-1; Thu,
 05 Feb 2026 10:09:49 -0500
X-MC-Unique: SQeL31z6Mk-m1x2hz6VG7A-1
X-Mimecast-MFC-AGG-ID: SQeL31z6Mk-m1x2hz6VG7A_1770304188
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4178D180057E;
	Thu,  5 Feb 2026 15:09:48 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EF9B18004AD;
	Thu,  5 Feb 2026 15:09:46 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v2 0/9] Extend Single User Mode (SUM) support in sed-opal.
Date: Thu,  5 Feb 2026 16:09:23 +0100
Message-ID: <20260205150935.238137-1-okozina@redhat.com>
In-Reply-To: <20260130162527.570255-1-okozina@redhat.com>
References: <20260130162527.570255-1-okozina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Changes since previus version:

v2:
  - Make separate patch adding Locking table UID
  - Make separate patch adding RangeStartRangeLengthPolicy parameter
  - Make separate patch adding Admin1PIN parameter
  - Add comments explaining differences between passing Locking table
    UID and separate Locking Ranges UID via array in IOC_OPAL_REACTIVATE_LSP
  - Minor whitespace fixes
  - Minor commit messages changes in IOC_OPAL_LR_SET_START_LEN and
    IOC_OPAL_ENABLE_DISABLE_LR ioctls patches.
  - Additional comments explaining expected answer from the
    controller in IOC_OPAL_GET_SUM_STATUS ioctl.

Ondrej Kozina (9):
  sed-opal: add UID of Locking Table.
  sed-opal: add RangeStartRangeLengthPolicy parameter.
  sed-opal: add Admin1PIN parameter.
  sed-opal: add IOC_OPAL_REACTIVATE_LSP.
  sed-opal: refactor (split) IOC_OPAL_LR_SETUP internals.
  sed-opal: add IOC_OPAL_LR_SET_START_LEN ioctl.
  sed-opal: add IOC_OPAL_ENABLE_DISABLE_LR.
  sed-opal: increase column attribute type size to 64 bits.
  sed-opal: add IOC_OPAL_GET_SUM_STATUS ioctl.

 block/opal_proto.h            |   4 +
 block/sed-opal.c              | 385 +++++++++++++++++++++++++++++++---
 include/linux/sed-opal.h      |   4 +
 include/uapi/linux/sed-opal.h |  25 +++
 4 files changed, 389 insertions(+), 29 deletions(-)

-- 
2.52.0

