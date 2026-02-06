Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F52FCBE5
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387502; cv=none; b=ZUCAkCKnqYyhyopqCkjCrVVmWF5eEk9TVhXptDlpH+YygdpzFo0fuImxbm0lGS491G+invU9LLDDOw1yX5yKyE8u2nycEXAjtOAjWQMtJAYBJegwUCng7ofEKsES4hZxdFUCfH/resS63TLN6l7EQDlfyNP7TIaHmHhocdb55xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387502; c=relaxed/simple;
	bh=0DF4MD1K7J8UrqxAH2HhAEY6xxwFKq2v5xwI4vyvdLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcFVlIaihvcLjZLu7RrXHkHKLSQS8Uod4WAg8opKv5xB7ARrdCfGAhDgu1TQiwcR816QLkI8bs5o6siwVUxlksQmouGblsfMpwjl9nPg2FZKU5cOmp+nswOKvxUTi5gI7LjL92hRKfBOuBVaK9J3pw0JBL8tiDdMYLYT1r+zmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpsENdMW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpsENdMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770387501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bullg6yNNBmzJkOHEKeTRCAiA39UYGik2XyNOgWAsSo=;
	b=VpsENdMW4I7l+fOXzoExoerFy5r2pouh+IPJxoHs1E9y10DY8mof9FEmrxJSf0hyZNEk7r
	RWSs9b601xSGW+BkNxPYIYaLFhQHTZzrybQrUAxui+8WG4/4y0UgorkjzXLOPW0NfQcp1b
	MICFs/e3vETvGelQDyCHY0vijUps/BM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-fc0RrskTPJOl5jXgmvj6IA-1; Fri,
 06 Feb 2026 09:18:18 -0500
X-MC-Unique: fc0RrskTPJOl5jXgmvj6IA-1
X-Mimecast-MFC-AGG-ID: fc0RrskTPJOl5jXgmvj6IA_1770387497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ECF6195608F;
	Fri,  6 Feb 2026 14:18:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.202])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A7061800464;
	Fri,  6 Feb 2026 14:18:15 +0000 (UTC)
From: Ondrej Kozina <okozina@redhat.com>
To: linux-block@vger.kernel.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	gmazyland@gmail.com,
	jonathan.derrick@linux.dev,
	gjoyce@ibm.com,
	hare@suse.de
Subject: [PATCH v3 0/9] Extend Single User Mode (SUM) support in sed-opal.
Date: Fri,  6 Feb 2026 15:17:54 +0100
Message-ID: <20260206141804.278721-1-okozina@redhat.com>
In-Reply-To: <20260205150935.238137-1-okozina@redhat.com>
References: <20260205150935.238137-1-okozina@redhat.com>
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

v3:
  - Add code comments in the IOC_OPAL_GET_SUM_STATUS patch explaining
    the different code paths for key set or not set in the opal_sum_ranges
    ioctl parameter
  - Extended IOC_OPAL_GET_SUM_STATUS commit message referencing the TCG
    doc where the new columns are described.

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
 block/sed-opal.c              | 387 +++++++++++++++++++++++++++++++---
 include/linux/sed-opal.h      |   4 +
 include/uapi/linux/sed-opal.h |  29 +++
 4 files changed, 395 insertions(+), 29 deletions(-)

-- 
2.52.0

