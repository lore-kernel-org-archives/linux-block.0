Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0601F5617
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767073; cv=pass; b=sTxh+st19296Y90+GSNzTlnslkUBKAACV8XXBOR1WMz8m1XEC6L9TbyYadSe77E6/AcQqz9ZQKzvRv1QrlCKJy4SPkOR1hnzfcy5CwGMrMqwmm7+xT3nDZu0EfZeD1GZqljnUicsjH66B3Mg20lLXT1r9PRsvWy2rmftkcFACrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767073; c=relaxed/simple;
	bh=cSeDcDctjIkmGITPtpUkoj63CtRlmHFsmwKva5ihsTM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mP0IM/ed651/mixHXTuVm/SEw0a9pZ/ZsD761VOk7XtuV7xwKJzR3yuP50yKV3/BDjgG61857UYZs8SLfc4jQlqebytY9CnolKrwS0Ksjp1P4RsKnWZPcerzaqBD2MTMNs7KIUK/7Llo96mzm1iez8HwOVyyHHyTYKDYK98bpVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=O3raY3Q0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="O3raY3Q0"
ARC-Seal: i=1; a=rsa-sha256; t=1750767067; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EaxPV5JcN0JVubzHnGQk3iOwDkPKkv3kKzRqNS5ocDjY1J2mP4mS7mr9kiKBQQh0yAW6Hl7nrDaXdbpquB0B4cwokx85x/1CYjk4EjkSV3qS4w2kmmlBZbA494yEcVjAZ1EeLY/5TxSKQ9hekGRAHmrGPZhsDndXzI4GIDVd7Ns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750767067; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=yYAMgREgdBLKgk4gAGrkwwX0mLQ3K95UHZGNEtxJQJM=; 
	b=dKzZyuM+bEYlHKLo39FlepkkV/6sn9RikfDfKf9A91aGjoIDoMGmOseV55Jmx0j2RgkxOi2JvLoS3vWzCaRMlLLqnon+k2DaJZZKq+EZ+fLb8JrhQsLWGyFDP0Xe1hIzESUrGshaHQQRmeai0b7uhpMNLvg3NfEmb5PVq6RMdSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750767067;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=yYAMgREgdBLKgk4gAGrkwwX0mLQ3K95UHZGNEtxJQJM=;
	b=O3raY3Q0ISWct9CKnErqdAnCNPHMd9nh6OZ9FujcTnbPE90PTMeRKjuGxzuLhbgF
	0Y8XeLJRsQnAycnXg+opXXfXddPP2y3iwgGixHD0ZyQ6SnHG2P1/yGj3AB86+fjFUmt
	5kIxuR9XlTwmMeVv8Pzrzgy9DDDn4Z9NEjntvhyI=
Received: by mx.zohomail.com with SMTPS id 1750767064110204.62192849232622;
	Tue, 24 Jun 2025 05:11:04 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: [PATCH blktests] block/005|008: double timeout on machines with more than 128 CPUs
Date: Tue, 24 Jun 2025 20:10:56 +0800
Message-ID: <20250624121057.85689-1-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

The current hard-coded timeout for block/005 and 008 is 900 s.  On large systems
(e.g. 256 C) the test spawns one fio job per CPU and therefore
issues 1 GiB of random I/O per job.  Total workload scales linearly with
the CPU-count, so the original 900 s window is often insufficient for
high-core machines and causes false failures:

    fio did not finish after 900 seconds!

To keep the logic simple while avoiding unnecessary test flakiness, bump
the timeout to 1800 s whenever the system has more than 128 online CPUs.
Smaller systems continue to use the original 900 s limit.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 tests/block/005 | 5 +++++
 tests/block/008 | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tests/block/005 b/tests/block/005
index 6a58da0..0bc7625 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -39,6 +39,11 @@ test_device() {
 	# overall test.
 	start_time=$(date +%s)
 	timeout=${TIMEOUT:=900}
+    # if CPU cores >128, then timeout×2
+    if (( $(nproc) > 128 )); then
+            timeout=$(( timeout * 2 ))
+    fi
+
 	while kill -0 $! 2>/dev/null; do
 		idx=$((RANDOM % ${#scheds[@]}))
 		_test_dev_queue_set scheduler "${scheds[$idx]}"
diff --git a/tests/block/008 b/tests/block/008
index 859c0fe..d67c5b7 100755
--- a/tests/block/008
+++ b/tests/block/008
@@ -53,6 +53,11 @@ test_device() {
 	# overall test.
 	start_time=$(date +%s)
 	timeout=${TIMEOUT:=900}
+    # if CPU cores >128, then timeout×2
+    if (( $(nproc) > 128 )); then
+            timeout=$(( timeout * 2 ))
+    fi
+
 	while sleep .2; kill -0 $! 2> /dev/null; do
 		if (( offlining && ${#offline_cpus[@]} == max_offline )); then
 			offlining=0
-- 
2.49.0

