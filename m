Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.46.152.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443537;
	b=vHVN0LuHkJzLS7WRXH1TqCDr0mTdLz/773Hp0m+DFW9S4FjocgemnWEDhnr0s3QC/a6G
	 BGnZj9lQoC1+apvgtCN44UeG8HvezPGny2RIH0R6cyVIEZl6fFo3I4EknXaBAvkShJNUX
	 jlBZm8A1cesg/m6PTLIVvrcncIdE87V0JEJpVZNlCxp6kzF+RRltgkYQOwEoBJ+gEYzzp
	 UKcmqfbFUqrzvzJO3lEAind4fGtX8bUmLdYpFaH6q+01JvissrYOmzJJjq7FTsW8yeTM0
	 mRg4mvBzDHn4G5tk0uV4EOpzYztEPOOKgffhvNjzpfeUXTigyjdz9EFpCiocrKxCYXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443537;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=L/aQTbe9wAoE1ruRv87uPYYfnTniS7DIV+mGMqkZ3SE=;
	b=jUSvQmFTqAzdunjeHBO4cuw44vFL3cOUMPBbWDwYOjhzDQryqVsdC5Bt4WcZQwVWYRQA
	 dRA68HlzYDug3/8d/UmY3N8oJcVrl4KULXI3+BIYx+TDSrTCwDBZsIdyuX/VsBu/C9tDB
	 RJ8EC0iNDiSa1vBfaCAOTFdbkqLOw7ag9xglIus2D/Ni848ywulaOYSKtIWiRFi3dcVQb
	 VI8qjhk91devWkOgcyatdIsVlXgWZ3CA2PYjePyXk5QcaNTlpJHsOWhKQHN0oyQwknkml
	 phLbAtuDRORzSMguf0gGywA3E5p7xkNvhh8X2EJJQqbVdYFvaJSvZpJCiVyVxy4o0kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jregg.de;
	spf=pass smtp.mailfrom=jregg.de;
	dkim=pass header.d=jregg.de header.i=@jregg.de header.a=rsa-sha256 header.s=default2602 header.b=J6mBWweh;
	arc=none smtp.remote-ip=78.46.152.61
Received: from www421.your-server.de (www421.your-server.de [78.46.152.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF21606A31A;
	Mon, 23 Nov 2026 14:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF21606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jregg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jregg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jregg.de header.i=@jregg.de header.a=rsa-sha256 header.s=default2602 header.b=J6mBWweh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jregg.de;
	s=default2602; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=L/aQTbe9wAoE1ruRv87uPYYfnTniS7DIV+mGMqkZ3SE=; b=J6mBWwehWdpwXjiS7o1dCkdR3n
	wBLf7azH5pVfDFSMuomo3V61rIwjoh5QtvgkMHBniWkLF5WGtXnuW+uI6thThQ7G5rvZVvAyOKYup
	XmvzUd1/n5R6lak2K4iG2ZW2TyEjgUFdUzVPvzRhAN+2DvRzIwTfpIOjxtGJKrq89Bqd9UMJLqROT
	0/QDL21UZyTUlJySYp3XO4TZOFkPy69pYA0Jf24D2wF6zsnsgAXlxetzb/gdWoZVnlqWDRagEhfGu
	diZ/vp2dwtWiDrDP5J1yIvFNDuRi64KPPsUJ8WQobwN5DboSAEPhw49PhycLrROFVkfGrtbIzhBWq
	SwUAZKDw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www421.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <mail@jregg.de>)
	id 1xVUsZ-000KcK-2h;
	Mon, 23 Nov 2026 15:18:48 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mail@jregg.de>)
	id 1xVUsa-000K2g-1x;
	Mon, 23 Nov 2026 15:18:48 +0100
From: Jenson Johnathon Reggentin <mail@jregg.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jenson Johnathon Reggentin <mail@jregg.de>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ba8947364367f96fe16b@syzkaller.appspotmail.com
Subject: [PATCH v2] blk-wbt: Fix data race and avoid possible false sharing
Date: Mon, 23 Nov 2026 15:17:43 +0100
Message-ID: <20261123141745.237765-1-mail@jregg.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CANpmjNM9n+nCb46nEAUcrU6kecC5LOyYSxKWN0So0pZwYZ34GQ@mail.gmail.com>
References: <CANpmjNM9n+nCb46nEAUcrU6kecC5LOyYSxKWN0So0pZwYZ34GQ@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28192/Mon Nov 23 07:24:27 2026)

From: Marco Elver <elver@google.com>

The pattern here is to avoid possible false sharing. However, due to
compiler optimizations the code may simply collapse to the write if we
omit READ_ONCE/WRITE_ONCE:
https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance

Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
Reported-by: syzbot+ba8947364367f96fe16b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/20191105182746.217864-1-elver@google.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220759
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Jenson Johnathon Reggentin <mail@jregg.de>
---
v2: Pick up Marco Elver's 2019 patch with updated testing and an updated
Fixes Tag.

Tested with KCSAN, HZ=1000 and null_blk in a 4-vCPU,
2-GiB virtme-ng VM. The 30 second fio workload used two direct 4-KiB
random readers and one buffered 64-KiB writer.

The baseline produced two wbt_wait/wbt_wait and three wbt_done/wbt_done
reports.
Neither signature was observed with this patch. All fio jobs
completed without errors.

I also did an AI Code Review, it really wanted to add READ_ONCE
instructions for the reads inside the close_io function. These changes did not 
impact any of the KCSAN reports, in my testing, though.
So I consider them outside of the scope, but I thought I'd mention it for 
completeness sake.

 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 953d400fd013..a60df3524b98 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -156,8 +156,8 @@ static void wb_timestamp(struct rq_wb *rwb, unsigned long *var)
 	if (rwb_enabled(rwb)) {
 		const unsigned long cur = jiffies;
 
-		if (cur != *var)
-			*var = cur;
+		if (cur != READ_ONCE(*var))
+			WRITE_ONCE(*var, cur);
 	}
 }
 

base-commit: 77cc1587b17a356f1638f09ade33872a919a82ab
