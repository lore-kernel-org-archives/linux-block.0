Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479E2905
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579954; cv=none; b=LUP7ztBIXdIJprnf7zA3GtCZslZ6/+3w0K9JfYQetlC5U+6UYYA8+q28OC1Ge8mCCVbo+qmDtwWqZvU1siQtEZAfAXmDn1UmibusDZecYwhbge/fZ1AgAlr5Y1VQ/rEzBP+FFdvEOMOjiAFq4MW8QhQtcEx2eZPHLQIYHH6ensw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579954; c=relaxed/simple;
	bh=W/priA7qZ9nOepOzunD2BNrBgpdAEFGb5SMud76cA8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMfnZgkFxOqtjeqL737HaGWoc3AEJiPs8GlsRpHYmSCERFTN+Yo+bNOiXoveuXTCaPpi8j+07Nm9sHfxEu81JGqrGmkytfZZg8RHC3vcqnb4W3vyI1hyXUsFJ37ijtvcjqeOae4NeOzaaHHUKwRyfAFV0DIx3sSxhC3kUOA0I5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMJ8luWb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMJ8luWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89499C4CEC5;
	Tue, 17 Sep 2024 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726579954;
	bh=W/priA7qZ9nOepOzunD2BNrBgpdAEFGb5SMud76cA8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=uMJ8luWb0FadBhEBBOLQCy7LotyBn+EPZF0JGGYgbB02laeANIUzibPYBB4cbLidY
	 7N87l6NuqHv69OUV9pwYTQvDNUAljjiSHY6/v51/qeDqCnBF5P+mrKm46ZaoZiUjfI
	 qiBw8R7HD756EilPSVvpvG1q2SFKwk7K5/DC3kIYL1L22MsBCVQmbIpSYlga0SYtga
	 RwiGALx+vy/chP2pcsqlf5BmfaRkZA/2MDzHena8uic+VZEawnxUb64koyoAnV5FhZ
	 jf2uG/+bCC+aR3vmJDSeBRq7iQ5i8q1Sw1hsGCz0J8VCP0ru0EfsZ8iUP97TDMpXN1
	 YpxsqrvL7pJlg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] block: Fix elv_iosched_local_module handling of "none" scheduler
Date: Tue, 17 Sep 2024 22:32:31 +0900
Message-ID: <20240917133231.134806-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 734e1a860312 ("block: Prevent deadlocks when switching
elevators") introduced the function elv_iosched_load_module() to allow
loading an elevator module outside of elv_iosched_store() with the
target device queue not frozen, to avoid deadlocks. However, the "none"
scheduler does not have a module and as a result,
elv_iosched_load_module() always returns an error when trying to switch
to this valid scheduler.

Fix this by ignoring the return value of the request_module() call
done by elv_iosched_load_module(). This restores the behavior before
commit 734e1a860312, which was to ignore the request_module() result and
instead rely on elevator_change() to handle the "none" scheduler case.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 734e1a860312 ("block: Prevent deadlocks when switching elevators")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes from v1:
 - Switch to ignoring the return value of request_module() instead of
   doing nothing if the scheduler name is "none".

 block/elevator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index c355b55d0107..4122026b11f1 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -715,7 +715,9 @@ int elv_iosched_load_module(struct gendisk *disk, const char *buf,
 
 	strscpy(elevator_name, buf, sizeof(elevator_name));
 
-	return request_module("%s-iosched", strstrip(elevator_name));
+	request_module("%s-iosched", strstrip(elevator_name));
+
+	return 0;
 }
 
 ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
-- 
2.46.0

