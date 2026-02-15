Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07861217659;
	Sun, 15 Feb 2026 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771198845; cv=none; b=gmiuq/3jKlsBi3aQDscGjL7s7nFaHqWuaJ+outi2Q99gxUJaOKJt6n00ON0fjnGw1gM3L0lcWHUDVg7cCC8XpAoeFJTA/5g/wplcaP64oy2B6mjAIuiIok6lZBtfMVTsDhTvo8ht6TAfWGFcUou0wgL9n8IpsjXh3o10fA5/R6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771198845; c=relaxed/simple;
	bh=PBK7Gy6yOqD93xMD0GKqkyb3it4yG8n9UJvvL1G85v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gcG5HKMVDx6FHlIThdVFYOtPWcqSTXci9vOWyl/RP/iORnZKfr2HZz4OLvCxIMCqsKu8yoVtV3GUHnGEtJpk0jmQ0yldHJCaCNUD1Aj2oPWxbcCqJ2TJlsMM6KJ6KWhyg+Dx63jSzKeQUvFdJzhFeX3bL0avSnsqMHoY616fju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxYPJCgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxYPJCgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9EFC19422;
	Sun, 15 Feb 2026 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771198844;
	bh=PBK7Gy6yOqD93xMD0GKqkyb3it4yG8n9UJvvL1G85v8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bxYPJCgEsjiQG6SWt0NwbCdeEoOChcdXDWKWzk9Mn2vlrkVXazcE5sp7XZlRI0B+b
	 XFUCbLfrM1ezrptYH6/psaBuY5loKyUoDtPhVhEcZYwmwBOpDFBDM+2MRNidILppl+
	 VC0fzKYIgwkljNSdqfAANE0yJ7gp21HICWx0CyJ935vdIsnaotWa7Y/QWoJRRAnNak
	 MY1WeZB7BC106AvJ9+k+xdWrgLkY5n/SEpZP7eCkBgeLXoOk/6qabZpbbkVcJobqHe
	 2OVFXI6fggXgf6r/bu5p0h0XvgE49CVjosL3Vk/zdP2SzGGKHeAE88IKaLo9Js5QFZ
	 BOk3xbq/GpUtQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Feb 2026 00:35:47 +0100
Subject: [PATCH 60/79] block: fix arg type in `blk_mq_update_nr_hw_queues`
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-rnull-v6-19-rc5-send-v1-60-de9a7af4b469@kernel.org>
References: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
In-Reply-To: <20260216-rnull-v6-19-rc5-send-v1-0-de9a7af4b469@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PBK7Gy6yOqD93xMD0GKqkyb3it4yG8n9UJvvL1G85v8=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpklhRRzjj9sFhsnUHE/Tx66LCHKC5qeomJHUCk
 Y8jvU2yfAaJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZJYUQAKCRDhuBo+eShj
 d+GwEAC1KHf1/pmHLdJDHxI3cCCTlLqWwGumPnUyTFqd3m6XeHO7h86kF21vSosdJrHHb+XDNaz
 VTv4YxAvrpHaqaNHyZD4vArVYlOcsIJI5Hu284JnIPunXfuqMsSXAhbeDvJgSMxKktW5RlzCyOg
 yCnx2WhbeRjnv+hjKFH387A0ITVqtytkpT59eXNgagoyGLIa+k01l7K/1/S0+VZ3AM5cQ12qdMY
 skynG2WSw9hB+Kl+9yFm50dU7Kt/Ab4DtXV6mdjcCq4DkOwWiqJkYbMxu3/FaZrE/jCaBQ09ntV
 W4mSDcYWA55/eFd/dhWENhnOfGNaBsoRalvJswIVwvZheC1O1AqJeys/Q77bY8PEdaoZEZT7sfA
 YvVZP6KPs2F43KdFZuM/U4kylbcAlxalbKppHJ+srUQ2MJmk+9tr4Vdw/5H6kO5XZtBvx9cEQAT
 96rGiwnga8pPV97JTptFnTZIZmMjUwYUJyZVj/qhZzVMGec6oQjmkKUScUuEOTYFhK5UN173Jn1
 msXa41+56KcRX/sDcAIXBzWbmukOeZcVCI+Oh30dbAo5YQYNVUBXSs2wTB+AHqFSFxUajjkDtdf
 M8fJcZDtfK2c51lYwwrmcyqSRPcuqhYSBF/CkbBh59EXiJr9vL++/DTL/9ffjf7ZxF3HFPzHP9P
 OQyxV8MpPWhLDmA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The type of the argument `nr_hw_queues` in the function
`blk_mq_update_nr_hw_queues` is a signed integer. This is wrong,
considering the field `nr_hw_queues` of `struct blk_mq_tag_set` is
unsigned. Thus, change the type of the parameter to unsigned.

Cascade the change to downstream functions.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 block/blk-mq.c         | 13 +++++++------
 include/linux/blk-mq.h |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a29d8ac9d3e35..6a44ebb6aac43 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4779,10 +4779,10 @@ static void blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 }
 
 static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
-				       int new_nr_hw_queues)
+				       unsigned int new_nr_hw_queues)
 {
 	struct blk_mq_tags **new_tags;
-	int i;
+	unsigned int i;
 
 	if (set->nr_hw_queues >= new_nr_hw_queues)
 		goto done;
@@ -5086,12 +5086,12 @@ static int blk_mq_elv_switch_none(struct request_queue *q,
 }
 
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
-							int nr_hw_queues)
+					 unsigned int nr_hw_queues)
 {
 	struct request_queue *q;
-	int prev_nr_hw_queues = set->nr_hw_queues;
+	unsigned int prev_nr_hw_queues = set->nr_hw_queues;
 	unsigned int memflags;
-	int i;
+	unsigned int i;
 	struct xarray elv_tbl;
 	bool queues_frozen = false;
 
@@ -5178,7 +5178,8 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		__blk_mq_free_map_and_rqs(set, i);
 }
 
-void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
+void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
+				unsigned int nr_hw_queues)
 {
 	down_write(&set->update_nr_hwq_lock);
 	mutex_lock(&set->tag_list_lock);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index cae9e857aea42..171521e716e49 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -972,7 +972,7 @@ unsigned int blk_mq_num_online_queues(unsigned int max_queues);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
 			  struct device *dev, unsigned int offset);
-void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
+void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 

-- 
2.51.2


