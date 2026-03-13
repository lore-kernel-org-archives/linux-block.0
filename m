Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F943DDDD4
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425466; cv=pass; b=ia0IFIM//YnyZb+f4+kMfTd2B6be0uhLbo0V36yMrI3tCyAajdDGrntWFPT/f0GVCGmlX9wH2nITtPy5Fm7pBgdDps4Zy1SYc2O+MMj4aqU4t9kuuybUmjo56DiGY5fyTp7p+bR6SOgpC/1jZ0xA2tG6fofFH2PUJlyzkN0vjWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425466; c=relaxed/simple;
	bh=CQlXvEUAm5j1LubDGqz5a/eiOfy/QmxgSX0sKhPEFXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmVrd9WdNzvbmZ4lzqTvO++TSjSW0asnd1YzYNL69Re9l5ZsXX+xH3K8dcqcEHZ9V7Dr3My95YNROv3iq6ZDdr2IVJLkG5RlM+EVa3Yp+r8ieN9FKSzSUcPlK0YFrEqZKn3WF1wURN48PRNGkIODywaD/FpVkNyWWFwHh14ccME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=MaaAD/sJ; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="MaaAD/sJ"
ARC-Seal: i=1; a=rsa-sha256; t=1773425443; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jx2449L/xNchG+MsHfvoRVzn4OuKxQavrmo6CcVDJKgnJ1iSYJLMz7RNS5maWGRQ4d7MGBH5BksGsIFhZ0fpLJKr+K0qbzhRuxm3TlEpofA7QMLMQ4pt0yzOpthRnRa80q/m6Tir5aC9g1ATvIv2BC8stdxreFRRpCM3jvxRdR4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773425443; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lJBr918jvjyndyx8jpHpTm+m8/8Mw2Gu7Xnd8DjPVu8=; 
	b=X/TKHZ01oNeibvINGsIPzYcbYHHix6gVVTtefFxryWQDF/nutt6PSr/lQbESBur8wCDRJaukEmQbnuQDCFTmIzAqYxy0tF8aLOzBtU3ubEdyHwj4WfN9bBdGonMF2EY5jXvCkjNgOx24v97HwaqJ+dSWxlj7/MIXdPGg/S6bb8Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773425443;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=lJBr918jvjyndyx8jpHpTm+m8/8Mw2Gu7Xnd8DjPVu8=;
	b=MaaAD/sJPlpwspNM1nZmmhYI0RRL+Yw4zsl7hLQHTKQJj1pokiJgRKkIiJcJ0FvG
	JK+SSuWKxvsEmtxXUWHuxIkWkm4NmowC/YCIwe9zoaey4j4om8ErIGZyZxLAulQN94D
	gpeNA1zTdkp4uMogzKnpiWr5BYgz/SIuiGupRDp4=
Received: by mx.zoho.eu with SMTPS id 1773425441750178.6543463140457;
	Fri, 13 Mar 2026 19:10:41 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 2/7] lib/iov_iter: add NULL check on folioq->prev in iov_iter_folioq_revert()
Date: Fri, 13 Mar 2026 18:10:33 +0000
Message-Id: <20260313181038.30018-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313181038.30018-1-objecting@objecting.org>
References: <20260313181038.30018-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When a network filesystem using folio_queue-backed iterators (e.g.
ceph or NFS with folioq read paths) hits a short read and calls
iov_iter_revert() to wind the iterator back, the revert walks backwards
through the folio_queue linked list via folioq->prev.  If the unroll
amount exceeds the data preceding the current position — possible when
a splice or sendfile operation miscalculates the revert distance after
a partial transfer — the walk reaches the head of the queue where
prev is NULL, and the subsequent folioq_nr_slots(NULL) dereferences it.

This was found through code review examining the revert paths: the
bvec and iovec revert loops have the same class of unbounded backward
walk, but the folioq case is the easiest to reach in practice because
folio_queue chains have an explicit NULL-terminated prev pointer.

Add a NULL check and early return when folioq->prev is NULL to prevent
the oops.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/iov_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 852f9ed40e5c..325669b103ed 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -600,6 +600,8 @@ static void iov_iter_folioq_revert(struct iov_iter *i, size_t unroll)
 		size_t fsize;
 
 		if (slot == 0) {
+			if (!folioq->prev)
+				return;
 			folioq = folioq->prev;
 			slot = folioq_nr_slots(folioq);
 		}
-- 
2.34.1

