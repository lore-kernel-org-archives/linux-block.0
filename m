Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block, bfq: stress that low_latency must be off to get max throughput
Date: Tue,  9 May 2017 12:54:23 +0200
Message-Id: <20170509105423.3672-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The introduction of the BFQ and Kyber I/O schedulers has triggered a
new wave of I/O benchmarks. Unfortunately, comments and discussions on
these benchmarks confirm that there is still little awareness that it
is very hard to achieve, at the same time, a low latency and a high
throughput. In particular, virtually all benchmarks measure
throughput, or throughput-related figures of merit, but, for BFQ, they
use the scheduler in its default configuration. This configuration is
geared, instead, toward a low latency. This is evidently a sign that
BFQ documentation is still too unclear on this important aspect. This
commit addresses this issue by stressing how BFQ configuration must be
(easily) changed if the only goal is maximum throughput.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/block/bfq-iosched.txt | 17 ++++++++++++++++-
 block/bfq-iosched.c                 |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 1b87df6..05e2822 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -11,6 +11,13 @@ controllers), BFQ's main features are:
   groups (switching back to time distribution when needed to keep
   throughput high).
 
+In its default configuration, BFQ privileges latency over
+throughput. So, when needed for achieving a lower latency, BFQ builds
+schedules that may lead to a lower throughput. If your main or only
+goal, for a given device, is to achieve the maximum-possible
+throughput at all times, then do switch off all low-latency heuristics
+for that device, by setting low_latency to 0. Full details in Section 3.
+
 On average CPUs, the current version of BFQ can handle devices
 performing at most ~30K IOPS; at most ~50 KIOPS on faster CPUs. As a
 reference, 30-50 KIOPS correspond to very high bandwidths with
@@ -375,11 +382,19 @@ default, low latency mode is enabled. If enabled, interactive and soft
 real-time applications are privileged and experience a lower latency,
 as explained in more detail in the description of how BFQ works.
 
-DO NOT enable this mode if you need full control on bandwidth
+DISABLE this mode if you need full control on bandwidth
 distribution. In fact, if it is enabled, then BFQ automatically
 increases the bandwidth share of privileged applications, as the main
 means to guarantee a lower latency to them.
 
+In addition, as already highlighted at the beginning of this document,
+DISABLE this mode if your only goal is to achieve a high throughput.
+In fact, privileging the I/O of some application over the rest may
+entail a lower throughput. To achieve the highest-possible throughput
+on a non-rotational device, setting slice_idle to 0 may be needed too
+(at the cost of giving up any strong guarantee on fairness and low
+latency).
+
 timeout_sync
 ------------
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index bd8499e..08ce450 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -56,6 +56,11 @@
  * rotational or flash-based devices, and to get the job done quickly
  * for applications consisting in many I/O-bound processes.
  *
+ * NOTE: if the main or only goal, with a given device, is to achieve
+ * the maximum-possible throughput at all times, then do switch off
+ * all low-latency heuristics for that device, by setting low_latency
+ * to 0.
+ *
  * BFQ is described in [1], where also a reference to the initial, more
  * theoretical paper on BFQ can be found. The interested reader can find
  * in the latter paper full details on the main algorithm, as well as
-- 
2.10.0
