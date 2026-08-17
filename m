Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82512771B;
	Mon, 17 Aug 2026 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931929; cv=none; b=VWGWDZFymoC9XyVSoBoec3o5gDoE8kX9ycvHl1qOuJz8+lohKBDGNCkqr8IE2uBZufd3q1s17grjDeDDbA/RkhkVTNesXV/+mBMzDHIMlVJWExR8mqBMOAl1xhop3R4Ywfp3SD/lpvFOoy6v5muDmpHRQXoX9z3ZWITxj2i3pUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931929; c=relaxed/simple;
	bh=54K/A9i/HH1+WS7iAJeDoWE/ROR015M5fMtY2mRCmFQ=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=OZQVvqoqMtzdUWQkNvZbBH2RV6hGTtYLhOYCUTngALBspXN9WCud8LE98OFYJsjPi9NDPmCQQWN/rmT2blNkCjBwbteTMsPRUsgj7Lzo3ON51ODTM4G6UCsCiBGt377Lu4I4a2xffy8/xvBlJdrwMFsZ6zxUzLqbYMgXHncwvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dt15SJoa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dt15SJoa"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A020EC021D;
	Sun, 16 Aug 2026 21:58:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 21:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931925; x=
	1787018325; bh=CADlbh3DZbTdQsPB9Go+KlO7rugQ3loMjKFZLF/cQZI=; b=d
	t15SJoaJOeZrJf64MJUA1sc9wOvnblRDYwOD5PjdzISSXpbSv+HByRPavsvh6494
	YZT3hfnTFmXPiwqdciXX9pslLcu336pqt6Y4Lhjs9Y4SfcobFtf/EIjtaT3an9yy
	HU7lM3G638iFyPbH68vhfgBE2vri9WvMDMVIriEVYT3D8mx+6b5p3qzgSgXFSyQC
	3tQSXBlx9uhKe3F0Ir6pOB4XEXSR0e24TdBFNLQpIJEcRbMTj7Q1U2My04VJUwLK
	KerdWRm9R2Vu263J7AusCL1PLhICsIcwji2bCHuXIFtkDfmq8T41u09JmKRcY78t
	oh7P8SHWnFBH5SsfDfyTg==
X-ME-Sender: <xms:1WqCatR0dK8aNao6Aq5rpc7C-Xq7Q3ruBAgTEtoU_I3iqkSyCgYgZw>
    <xme:1WqCag2WSTMEkK0LRKLwu-uSdt3rG_aTYbnGycO9g1Bgy-FxxozayieDKhQPRoxIw
    -C8-qMQH5RPjHl0VvdoAR4HAHY9HH-k8IxnfFsK_O7Z2IkK1pTn0giC>
X-ME-Received: <xmr:1WqCaivt-gCIKXnD7F_I47p8r04BO5DsCEgwI-mkERapTfPhDPW15vs2_IYbOWbtSO4BkudtdUHxx5G-8HAJx3gYgrsklfN7NDI>
X-ME-Proxy-Cause: dmFkZTGGfSHbL2fI02qi3PxN23Kck6mI5WuUw/IvRcvpbY119ewffFmgrLaJZrOewmv0V9
    +yVjmNFRAF5v6NwN93pp2/ef5Xe4c3LI9irOXMRuZYHRPaDMJE6WMter/2+BypR/48/QT6
    HY5IjuzvgSjmo92SyO1FOx3Pzj+F3Bo7QzXF7kAkGOLlhjpoHeFsUQfm7dkDIAS3zbzZQZ
    kdzEEhr46dUOQtvTauSfnNDphJtrhISaD9OmmoKzjI1J4txcn9eV52lgr1VrqNf0UkcCn2
    OchZn8Fy5DmAdO0OzTlRhd5sxDSBZbWOqIe4VCopfX4yIdP6r//KsVzdicR3q2dH2I0XLi
    1pUzVeTTthPNKP72IAOBNG6b1fmICju+0U6R8mLnbtHG5/F2oaMv1jn6kCsoblxROScv+H
    SK9zzSAvd1nY4hZ/g8FywTx6VbXQ/+BuefoMDjrlulWdZa+ceGW/CW03pBCHntEWTr+dPn
    qrk+Nt0kDy1RR2VHdp+JXmpKLJDLeim1UbbU02MMbyKTQEziRJd9rNQap+VxkeMCf/nJ6J
    U4n5FsA8+OX13XMT3M3/Q71pZaAz7O1UjIokZwtKRuhDpa41s33YQYSSSBLq5IYwmclK4J
    rteSVWO5wn9gkDH1/Z2nU44FlN0JjjgR6XcsazZwB+izI92J8hRzD8BnA6iw
X-ME-Proxy: <xmx:1WqCamiY-FdyQwG7oQ_JtqC-NgIzAT5YDlcU1BLGABalHz-1NH0ZHQ>
    <xmx:1WqCaj8SMxEfZaxb3KJ3vLCqIp1yEePM-8hMPDJGq1NOOiiI6XmtHw>
    <xmx:1WqCapt8IB4bWPv-_1yJqPxOPJRW3sYs4l5PybEuFh2iiSB50olLNA>
    <xmx:1WqCanre6nQgVWWXaa30eZr7_rc9f36R1GCYKRxDx_fQcJbyCxT3wA>
    <xmx:1WqCauAOJGRbIwJRQa9Ba8Gvqff607yiGWxQODyWM0rLotK5deK85bKZ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:58:43 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <afb0d02ab268dc56fa0d9139032a4e37330cc229.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 28/32] swim: Remove unused macro definitions
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Also remove the horizontal rule at the end of the macro definitions as
it doesn't any add value, IMO.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index d7182f95c21d..aebebc7f5d60 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -130,25 +130,14 @@ struct iwm {
 
 /* Bits in handshake register */
 
-#define MARK_BYTE	0x01
-#define CRC_ZERO	0x02
-#define RDDATA		0x04
 #define SENSE		0x08
-#define MOTEN		0x10
-#define ERROR		0x20
 #define DAT2BYTE	0x40
 #define DAT1BYTE	0x80
 
 /* bits in setup register */
 
-#define S_INV_WDATA	0x01
-#define S_3_5_SELECT	0x02
-#define S_GCR		0x04
 #define S_FCLK_DIV2	0x08
-#define S_ERROR_CORR	0x10
 #define S_IBM_DRIVE	0x20
-#define S_GCR_WRITE	0x40
-#define S_TIMEOUT	0x80
 
 /* bits in mode register */
 
@@ -157,12 +146,9 @@ struct iwm {
 #define ENBL2		0x04
 #define ACTION		0x08
 #define WRITE_MODE	0x10
-#define HEDSEL		0x20
 #define ISM_SELECT	0x40
 #define MOTON		0x80
 
-/*----------------------------------------------------------------------------*/
-
 enum drive_location {
 	NO_DRIVE = 0,
 	INTERNAL_DRIVE = BIT(1),
-- 
2.52.0

