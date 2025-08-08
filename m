Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0C277CAF
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656135; cv=none; b=RXNkRMaRb+mtiwfb8XBPf9xfhkVBWnL40gFo5d6kV5RN0fCrG3hK6qnuAowN4XBZzEVUXkClu1+I1wmCx2Hdyj9CS3o1Uc/xQz9xf3In8D4Fia+e52PIFBQtbctr8ts/njRCfx65HfxennIvxt/insTR1GiSXlsoe85cSdC1VZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656135; c=relaxed/simple;
	bh=AwqI2ate9xOTmJrt9TYMHJbOytgp965hWnkzbeK8RHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fKeOGE1SFfb+jm3iXRQEelVcC+yMYSgAlBdOzV9FRomLZqMlyGFOtU1k0QAN45NhUXgj7hB4e6QwZg97zxfwCXPDmq2Yhz84bdKckPip7TnfORb6uNfIhV+8/KsMmz1km5fd251Q5o8HxM4cnc12JTArTH3m8Oji7pFnQgvhQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=KgoEk+cS; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="KgoEk+cS"
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id BFA8B1018FD1
	for <linux-block@vger.kernel.org>; Fri,  8 Aug 2025 17:58:45 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in BFA8B1018FD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754656125; bh=AwqI2ate9xOTmJrt9TYMHJbOytgp965hWnkzbeK8RHw=;
	h=Date:From:To:Cc:Subject:From;
	b=KgoEk+cS8U5V1PbpDznWHyvWLRvIDqniNrVf/GkDX4BYaJUmbVM9Xd2bZKbGau2xf
	 tZfw6hKvV+q7jkJucTLH8jDlEH+6SQxAPLkDJTmaDUGSaaLBTUdLeO1JbtigAeyX26
	 XphgiwjyfH/uwySyTCcOaZqCCoKlEoce2mrXT2yg=
Received: (qmail 26809 invoked by uid 510); 8 Aug 2025 17:58:45 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.326992 secs; 08 Aug 2025 17:58:45 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 8 Aug 2025 17:58:41 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 93882341550;
	Fri,  8 Aug 2025 17:58:40 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 3B5301E814CA;
	Fri,  8 Aug 2025 17:58:40 +0530 (IST)
Date: Fri, 8 Aug 2025 17:58:34 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: axboe@kernel.dk, hare@suse.de, hch@infradead.org,
	john.g.garry@oracle.com, yukuai3@huawei.com
Cc: yi.zhang@redhat.com, calvin@wbinvd.org, david@fromorbit.com,
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] block: genhd: use max() to improve inflight IO counting code
Message-ID: <aJXtctgVs6Md6vb1@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use max() macro in bdev_count_inflight_rw() while populating buffer of
read/write inflight block IO count. Use standard macro to
simplify the code without impacting functionality.

Fixes: c007062188d8 ("block: fix false warning in bdev_count_inflight_rw()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202506272336.CvAqaAxB-lkp@intel.com/
Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 block/genhd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c26733f6324b..af74cb80eadb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -147,8 +147,8 @@ static void bdev_count_inflight_rw(struct block_device *part,
 	 * traversed and complete on a CPU that has not yet been traversed,
 	 * causing the inflight number to be negative.
 	 */
-	inflight[READ] = read > 0 ? read : 0;
-	inflight[WRITE] = write > 0 ? write : 0;
+	inflight[READ] = max(read, 0);
+	inflight[WRITE] = max(write, 0);
 }
 
 /**
-- 
2.34.1

