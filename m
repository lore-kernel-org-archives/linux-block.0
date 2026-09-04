Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B386426EB7;
	Fri,  4 Sep 2026 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514323; cv=none; b=ekTjwnnGe8s1SLp2o8R0Zr6ke0N238rLouNamuipqLhFkhU2jtQRqZOgnix5wpIX5+HraroVm9p2mJMSagMka6PM9edikdb4eycLryQsKhcgjwSWYLjJkSiAw5XqsqRDHCqRY3BkA0f37dNDSGApS/qrw9PbO6rTEqQJo4p5vDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514323; c=relaxed/simple;
	bh=6osIxefW9WuJTL+x/nXswa0PPTDUDWFo8rRm7h//FJk=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=cugfiTyKrVdeBZkksbnbm5tHMGyy1deiU4V3JtMiasUyLmkoTrEnR4ccmHZaVbupUcSvO4aORvPxWk7d2g7hnOBEcABcUL08CZqlSOwPEUZSB+8F5Z7IOYZGCBuxXO93qwx922rvl95ONA2TGX4kYoUpsOK8S9/exBMAiSAJ+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F5tyZmQv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5tyZmQv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FBD014000B7;
	Fri,  4 Sep 2026 05:32:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 05:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514321; x=
	1788600721; bh=gDu691Ym/3Wgf1jg+44n93Um7djI9WASUBUmb+nUwCo=; b=F
	5tyZmQvernSgBlICdoorrSGFjBendHBlpKOMfMbETiLObACZ/nca9LsujUNhe0Y1
	Fyz6QzJyH7EFUulpi0hVWL53Tt7IjodWug7ayFbikd/jiiHt74Npsx5vHYRUY1p6
	3iSSxcJnnz5t8EWI0alujWAi7/xMuNagBqUBKdpJUYem+6PQb3x47wEH9hZEuFC1
	mONBxfziBpLMRhHShRxj293HfXDcHD5kj3rHWCgx2+oFvhBvD/J/V+rkEro6NZBp
	A2re9eArggzr0+LPhyq7H7992Lmjv3WKQPu8OA/GdO0MR5zqd1xPm3zZdzErTV5v
	H7/zRDzaar0rGkz3HltRA==
X-ME-Sender: <xms:EZCaavwPQa_xfyGZA3C6d_VSlP67PKfvl6ucLze20_P_iT2dJdELBw>
    <xme:EZCaahWWranD3ue1ugbRUBSKqyUC0CaNeNh1RIMjQOTVbIUWYOPqXIl53IhkBg-V2
    tVZzrE8SsBnN08QDWO2mMLCmITRmjMUrdn51FADzj4SrNY8qoM9gAKk>
X-ME-Received: <xmr:EZCaapMg9jhnD3FAGNDdOYbm8DbEaj3z6meDsQrdMtmyhrwXtFxcTghwDOY7FpmSv4uFmS33CILwaUVmpxmwb-UOx6w1RBDCUhA>
X-ME-Proxy-Cause: dmFkZTFwU+S4kdAMlQ0v/k0AIIWH8NEZGASJORdIHxKTKTXUZu4/+TuTqA94nuiEUMaRxS
    Gofh+bL92h8RMpG66xVFwu0W+p9wbh5ZRd08LqtVKnsUP/9Qrp2soVjzNROQy1equ47t7H
    GqReSb441wEtgq6NIY2eQSaFWVAevL8uK2VrYQsRbjCnFUu9sctSvc8HbwNcOZhBWEvrxc
    v4dU6ftgbUqTDUj8aqtOMM9o2mrrjTYuxdDT/c0DbswJjHoKR/5ejCxg8Y/5mjJMzYLbmT
    GHbOCAcx+v5nQg51GRLb73A1+7BY5hn9tVP95J29cL5TZcJG84qND/yu/wkLW77nvFWlU4
    yw5nNHdUJw9PFoq3R0XlCxYDTeokboKRRKq2IZTIC1DwsS5pse0c9iPJXqzu6kJU9xupCR
    eGThEVo9OURlerh/TprEmXWyAOmPwUBszET0DPAGnrAmLjtbim/UnVz1di4MZZ4lHumF1b
    W77H10Baieug5/VK2zCZM6ICEEXyeVfYyQxpNiYby0cqijK612Mcxip6mkcvwR3zSP4OvO
    lsWebpEtaOPcDmDZgCX6omrhmAXtq2Jse52rrwv8e+edpfyLI2OC8j7m/Yg16SYI23sCIh
    7ntqpWc8uN1d1IkTjzC6bnHzRTGUiWXUqxWigLVYmTCavSeEAYGcybycyuEg
X-ME-Proxy: <xmx:EZCaarDr_HGO_hXJ-Rdh4TFe5venUUDJUUg57Nx_YsK5s9MfPgsTXw>
    <xmx:EZCaauc3PT5se_cLweDOtvqhpVQwcLeYdm2xIHofdWV5PRlnniocOA>
    <xmx:EZCaaiN1J9BKhDiryrrpoHVTzjZr1sAxBcw8Lh7E8o1M3rS4Uzigbw>
    <xmx:EZCaamLgjJJ9o9w_kgJiQCwKUis8sauQzR6ZylkIBGko0tV0LmJ8Ng>
    <xmx:EZCaagiDLSHEtZwUSa5T3VKCqS--rvXKzgtqFGHQ2EjG1R4v8T-Znk_x>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:31:59 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <fc511e72753ae18b6f021701aa00d480335b0caf.1788513996.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 04/33] swim: Don't disable drive after every sector
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This fixes multi-sector reads on a Sony drive. The Mitsubishi drive
doesn't seem to care either way.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Fixes: 8852ecd97488 ("m68k: mac - Add SWIM floppy support")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 4ddb87977fe1..3f92677ad127 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -473,8 +473,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 	short i;
 
 	swim_track(fs, track);
-
-	swim_write(base, mode1, MOTON);
 	swim_head(base, side);
 	swim_write(base, mode0, side);
 
@@ -490,8 +488,6 @@ static inline int swim_read_sector(struct floppy_state *fs,
 	}
 	local_irq_restore(flags);
 
-	swim_write(base, mode0, MOTON);
-
 	if ((header.side != side)  || (header.track != track) ||
 	     (header.sector != sector))
 		return 0;
-- 
2.52.0

