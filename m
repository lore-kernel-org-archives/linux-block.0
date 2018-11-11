Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com,
	Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: [PATCH] kyber: fix wrong strlcpy() size in trace_kyber_latency()
Date: Sun, 11 Nov 2018 09:25:27 -0800
Message-Id: <8233c3aac03494d50bf463787661edc523292ae4.1541957005.git.osandov@fb.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

When copying to the latency type, we should be passing LATENCY_TYPE_LEN,
not DOMAIN_LEN. This isn't a problem in practice because we only pass
"total" or "I/O", but let's fix it.

Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/trace/events/kyber.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/kyber.h b/include/trace/events/kyber.h
index a9834c37ac40..7aaa298375ad 100644
--- a/include/trace/events/kyber.h
+++ b/include/trace/events/kyber.h
@@ -32,7 +32,7 @@ TRACE_EVENT(kyber_latency,
 	TP_fast_assign(
 		__entry->dev		= disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)));
 		strlcpy(__entry->domain, domain, DOMAIN_LEN);
-		strlcpy(__entry->type, type, DOMAIN_LEN);
+		strlcpy(__entry->type, type, LATENCY_TYPE_LEN);
 		__entry->percentile	= percentile;
 		__entry->numerator	= numerator;
 		__entry->denominator	= denominator;
-- 
2.19.1
