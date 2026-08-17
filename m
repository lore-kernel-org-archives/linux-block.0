Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949F1A3029;
	Mon, 17 Aug 2026 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931844; cv=none; b=oLZ1jL00yV46DqzHNNAY4yA+vTPoCyEmAh0j7S11WxEaQb81Y7/1Fy1y6N5bBZY6wZt7rRkfN28NdC5AebnMZLtuANxPNa6TiD4vl9k9r7QwTuwf3K9LOaxfKRWBmalSp5EwGlEiVWqjZ86Y/ad707zClLnUxSPi6A5cGokqbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931844; c=relaxed/simple;
	bh=xqtJQev9uhpvVN8FSaMA3KHGnstMHKHWTjDRSheaoKE=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=HmXA/vMO5rNcgVSChGCFtxX2a9rL4Y7/5iuwmyfPc7FinooDLpO+jyAHFjASo0XuHs/u0o4VQsMC2mj4ObMo4iO1OsHZQgWjdq1bzPIbzCxGTteLHPBffdcdNUYSk24O8UkyiAXwhmU/u9C4zjv4PyFiPPT/v0eUkUDXK4MuwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OV1d4fu/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OV1d4fu/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 24141EC01FD;
	Sun, 16 Aug 2026 21:57:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 16 Aug 2026 21:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931842; x=
	1787018242; bh=pzXDTelpVr6jSOvH67+qkoLTiRHO9b0TevyHvWmS/I0=; b=O
	V1d4fu/hW7j5Q8g4L9bUkMFIb67N5RHqJ+10TqjPhmdq33Q3Pql598HAj3Ug1ZXR
	kwe2BQEXO82qGDxlOmaGZtMbQ0zlu/OvO1terGZJebu4/VaS9qglriEWXsZR09q8
	GZLpqGmZqE0gkSUDIUQHvgdVRtLX5eWOlsYJl6JBaC/k61iZe+WfG2dmYl+mrNIb
	wQWPBwn5hgYEwq7tIDtmnDKy5gl7H8sJOGGaNiPf9ZRPZXNkpaS4xlhsIz4zRdmU
	4tt3EXm906mHQxkm5H4Jiror73txX9JzVUPeqWVL63uDdpj9H6mDyCyfy+UgwN3C
	Ynk7ApqcLsga/lHJ4VOqw==
X-ME-Sender: <xms:gWqCatydEOouG1VD5sH_zmdMV26PfZKpcS9MiteoQ3IcNj98DBBIUQ>
    <xme:gWqCanU-BDgjXnXos4gH6yyEeelWqrgE49EjUpa5tubb38ht3sLbf5ddu5p9KrMMH
    Lwhqb2iTzF1ItlCWFUHmOk1krrt0ILKxPHWjQS8cNitLulmGcwfvLE>
X-ME-Received: <xmr:gWqCanMRoievcPKFNuRVxupjO-8sACIbSqCcttx3AWtZQ_TtJjIYrA21pWu5u7uOwwMDOwCqG7Jv2wJFMy-Lx7F1awF0WZsLp-o>
X-ME-Proxy-Cause: dmFkZTE4hc50xdhPXg/illULTp+C8DYFyqEdlu6WRFncsb6QnuuT/gcUnwV28CSittpzBY
    CanXMgLJ3D2f99+6fhcgPhKU62j4D/361qP39o0jreF8A1XJd9tbHbTT3THo+0Ngxn+KIR
    xmSykI00CRbwgNWRv8pmFJk9w9o4Guyae/9OdRSlW4+G/cXS4TLBuEOOa7VrQ1zx7uzt0k
    aiRQ8f78TROqGsNBFEeFBQ0S+1oq+UQzE0LFPz+xu5GHoHcx5q9+AQ38+8xzR6IOKHtWR9
    dd2Vu8AeIxRK7b1SVEdgm5fqxWGAl0hW++r8vV0P6QNaTx9jFo8LB1mZXd3D6ux6m/Q5Fn
    sbWIUzwmLq6iHoQN4dDsunW73vw/urlfWbCTIQxCFA/CtdpOk1SWRtIaqkg5RAAsSs9ql+
    EDePXUKkvctxGotP88VvT9igRrnqTu9pRsC+runuH6WmdNO1AQIDrP9FHZOeCOZjCtegbE
    Pdw5DTyLwTkoFmZxaj1MdtAvs7cz0koN8C9bovV89MpMC22YBYOyDavHwbWeo7RbNGsaoO
    1C3BRwHwPFXsWGRkFAnCuNMAvtQLj5D3cPM2KOeDs7IDq1ogbFl12R7OudwQMnNBbRyZOp
    xJQnWpjHrTBy/4arxjtBuq2Vrra7XuIqqN/cTowU1P5mjd9aMbGRnRHEVeOQ
X-ME-Proxy: <xmx:gWqCahC7G9qw9fzACXM_XkQYpZTpeuTHtmdRozuhLGvVTeVJGlQedQ>
    <xmx:gWqCasfDK66hMx3B55FtAz2hOozFTTJJPDvDQxlEH9Ey2N90bmlhzA>
    <xmx:gWqCaoND5Py3dFfMXxoAhAU5-flnNxUn1LkTJJ4guSfKMiN2ee3GOw>
    <xmx:gWqCakL_2sA8PCzz5SlQj_1XI2tPwnQKlGygFyRTB0nXkI7CA2PLyw>
    <xmx:gmqCaug8ZG_-_1ssvCiHfU6FYGxIxq5sw9nja0UyPUjT0bCXOe9PWNOa>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:57:19 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <282df3d29b34298051d3427c37fb1a39c310e6aa.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 19/32] swim: Deduplicate polling loops
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Replace duplicated polling loops with poll_timeout_us(). Change the
interruptible sleep to uninterruptible because signal delivery shouldn't
be allowed to shorten delays required by the drive hardware.

Change the timeout for the !STEP transition to 20 ms in accordance with
the maximum interval required by the UPD72070 spec. The existing 1 second
timeout is impractical considering the number of steps in a typical seek.

Change the return type of swim_readbit() to bool because that way the
bit names make sense i.e. the reader doesn't have to remember to invert
the active-low logic used for drive signals.

Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Dropped swim_readbit_timeout_atomic() as it's no longer needed.
---
 drivers/block/swim.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 9635f4df3fc0..36e28a766a5a 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -19,6 +19,7 @@
 #include <linux/major.h>
 #include <linux/mutex.h>
 #include <linux/hdreg.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
@@ -296,7 +297,7 @@ static inline void swim_action(struct swim __iomem *base, int action)
 	local_irq_restore(flags);
 }
 
-static inline int swim_readbit(struct swim __iomem *base, int bit)
+static inline bool swim_readbit(struct swim __iomem *base, int bit)
 {
 	int stat;
 
@@ -309,6 +310,9 @@ static inline int swim_readbit(struct swim __iomem *base, int bit)
 	return (stat & SENSE) == 0;
 }
 
+#define swim_readbit_timeout(base, bit, val, timeout_us) \
+	poll_timeout_us(, swim_readbit(base, bit) == val, 1000, timeout_us, false)
+
 static inline void swim_drive(struct swim __iomem *base,
 			      enum drive_location location)
 {
@@ -331,16 +335,8 @@ static inline void swim_motor(struct swim __iomem *base,
 			      enum motor_action action)
 {
 	if (action == ON) {
-		int i;
-
 		swim_action(base, MOTOR_ON);
-
-		for (i = 0; i < 2*HZ; i++) {
-			if (swim_readbit(base, MOTOR_ON))
-				break;
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
-		}
+		swim_readbit_timeout(base, MOTOR_ON, true, 2000 * 1000);
 	} else if (action == OFF) {
 		swim_action(base, MOTOR_OFF);
 		swim_write(base, phase, RELAX | PHASE_PIN_DIR);
@@ -349,16 +345,8 @@ static inline void swim_motor(struct swim __iomem *base,
 
 static inline void swim_eject(struct swim __iomem *base)
 {
-	int i;
-
 	swim_action(base, EJECT);
-
-	for (i = 0; i < 2*HZ; i++) {
-		if (!swim_readbit(base, DISK_IN))
-			break;
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-	}
+	swim_readbit_timeout(base, DISK_IN, false, 2000 * 1000);
 }
 
 static inline void swim_head(struct swim __iomem *base, enum head head)
@@ -373,19 +361,8 @@ static inline void swim_head(struct swim __iomem *base, enum head head)
 
 static inline int swim_step(struct swim __iomem *base)
 {
-	int wait;
-
 	swim_action(base, STEP);
-
-	for (wait = 0; wait < HZ; wait++) {
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
-
-		if (!swim_readbit(base, STEP))
-			return 0;
-	}
-	return -1;
+	return swim_readbit_timeout(base, STEP, false, 20 * 1000);
 }
 
 static inline int swim_track00(struct swim __iomem *base)
-- 
2.52.0

