Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A3313527;
	Mon, 17 Aug 2026 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931679; cv=none; b=CcXhrGWDXu91N94ps5lZxbgRj4soG1lxnZ89uqw6BCW4BqtcwJXqkB/XXlYOFdkXn5oxeYS1WiU4sNDp5fXXSa7/gCe7WzTnShz9tsjuZBZH5ElUWWngRp1AAQvuFW2Tqg3hvoyuycfl6o6qTMCIvADLDLM1/jdzEywKo5AinpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931679; c=relaxed/simple;
	bh=zLTL0XSX377Q5uxNjt9iEMwwDbPUSFjdEiz/iPykOT4=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=msnP8IErwzbn3TDhLOtu1UJCXkx5/NAkIXyueM5t46HBAmDkz+dpHAFB/btnSugLPCV827vw5B7vjWCxvP38Pc3udMrvuc7/JDBMCtqy9P2KuFDifCRmeTLT6Qoq+Cy2llNXXB4m8WTCIzeAXSoxiqiE31gH+EGecHCscimzLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccmUt68Q; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccmUt68Q"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0562F14000F8;
	Sun, 16 Aug 2026 21:54:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 16 Aug 2026 21:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931677; x=
	1787018077; bh=6enK1e/BFMkuBg8+irnlLj0CqFHztSRmCrF0cLMxqjM=; b=c
	cmUt68QrFGdRPwHn6tQZ8ODpQ+8Iez3Xti7AQt+sYE8vDWvWSfprkecOytblx1Ng
	VEpzp47o49qYrqYJXAVWk+NUsjBc4drOraAH1QagDc24i7cFdeUKqBuCF61FiN3y
	stIVg9PpIbWLS4qOJSxaMdpY7EEDsApDmzel8rp9yHzDLPvhoksxWgCJ4ZANaj8b
	ijd9wnVGgMR46ZHNgrxa5rewxsJr+EJYMAEKoQidPHG6eKWm2YbxQf0sZU3f7gNz
	nUQt0KO62kQeNotVOJs6XbiQynUTDGK4YVhcj+IUkQdtcoUdeCd+qy6gvbdJ8oGD
	HBsjaXmhSAr0Cfv7QqseQ==
X-ME-Sender: <xms:3GmCahibZeHzI7KOi2ngU9lrz7Q5FFjkBP4exfQ_r2YvNcpa5tkBcg>
    <xme:3GmCagH5B164QuRTMtphxD_s-MTOR84Kz1fPoP0dmNpgkRyVUTisQwpEthD3FV9oq
    c3OUIE0r9vXIDKDi3FjtEHYsEO_al4D8AyjyVl9F8E8JquJPHJKvyMc>
X-ME-Received: <xmr:3GmCag9H4hHNqXSPOPrq06oYeS6TaDRlYPFuoteJzrOIc5GkBy--ajlZZr5yq9c5c6fNThFGbeEWFXMWhDnZRV_Oe8ovyUGjHb4>
X-ME-Proxy-Cause: dmFkZTE4hc50xdhPXg/illULTp+C8DYFyqEdlu6WRFncsb6QnuuT/gcUnwV28CSittpzBY
    CanXMgLJ3D2f99+6fhcgPhKU62j4D/361qP39o0jreF8A1XJd9tbHbTT3THo+0Ngxn+KIR
    xmSykI00CRbwgNWRv8pmFJk9w9o4Guyae/9OdRSlW4+G/cXS4TLBuEOOa7VrQ1zx7uzt0k
    aiRQ8f78TROqGsNBFEeFBQ0S+1oq+UQzE0LFPz+xu5GHoHcx5q9+AQ38+8xzR6IOKHtWR9
    dd2Vu8AeIxRK7b1SVEdgm5fqxWGAl0hW++r8vV0P6QNaTx9jFo8LB1mZXd3D6ux6m/Q5nJ
    2V8/AeMgpE1uL7O5Xzeuwofsai0nR7KOW61a23EwoI3IQ4xylk4XZKkETDkcfU2Ln0BCmw
    oB3yijbdkpGCVS60IfhnXMVRjf4mksml96udoxalV+zAinioyrBBw2nhCQgQARSzXboTiw
    FwIVFx4G/eUWYlpYR8dHEj8HN6CiyMSk6d91rE5fA3LNDt7ZC46LgKf9rS1XftewQEE5z7
    dL/VCUV+qH1y8h9wi9posM6+m8ko269Ik/5Jr1PuRxEmuwcOH2xnygf9ibqerwYD+A07rM
    RCI4KXy1HSj7KfsejzJLA1i7vU688CY2akbGRKrz2Zv6Vt3uAD79TAafN6Ug
X-ME-Proxy: <xmx:3GmCany2bPs5HtwHeBSqKj-5mq5dGMhnxvEHh5gtbnNd1nyIon-aIg>
    <xmx:3GmCasPYGQ8hThYH2HlHOntWI5fVusogU9J6MXPIzjM193WMrJ2_yw>
    <xmx:3GmCas-abQk-SN8TW_IBVJrZIlGtaICFpbshIqYqFQilbyhAhaFnkw>
    <xmx:3GmCap5y093pBe-hzBpblusj4wfJF-XXfgvlTOeqN4YNDnb04-FeMw>
    <xmx:3WmCaqRPtwFGicGzJ7WpDSn5Em6WjociSL88-p0IzcbDAPrFrNepBtMp>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:54:34 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <26581501013da0b5174d0108d0a552675de5eb61.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 02/32] swim: Select appropriate drive once only
Date: Mon, 17 Aug 2026 11:17:10 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Before turning off the spindle motor, call swim_drive() to select the
appropriate drive. Remove the swim_drive() call from swim_add_floppy()
because it was already called by swim_floppy_init().

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 5d89e7813049..4721e073a874 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -679,8 +679,10 @@ static void floppy_release(struct gendisk *disk)
 	else if (fs->ref_count > 0)
 		--fs->ref_count;
 
-	if (fs->ref_count == 0)
+	if (fs->ref_count == 0) {
+		swim_drive(base, fs->location);
 		swim_motor(base, OFF);
+	}
 	mutex_unlock(&swim_mutex);
 }
 
@@ -752,8 +754,6 @@ static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 
 	fs->location = location;
 
-	swim_drive(base, location);
-
 	swim_motor(base, OFF);
 
 	fs->type = HD_MEDIA;
-- 
2.52.0

