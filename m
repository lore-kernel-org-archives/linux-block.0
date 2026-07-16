Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26092400976;
	Thu, 16 Jul 2026 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197308; cv=none; b=eNqqSGznEMz5sCPlKl2WtNYXkjWYGwE3uqqcUFAELf8xYeFWEJl1SJukMdfUvFS7kgmj1IDnIGsBmPHn357w6rFaDKFTJDjm/f6qZnIq4oDob60Zj4HogKni5WZdvEqSS6Kp8o2baB4e4rOtB0LPh+QSTsChWZjZDczKuh3ziyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197308; c=relaxed/simple;
	bh=kUYbXJGZMJnEr7YUm+oMbf37N0uhzXCa0XuXlWs3eF4=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=TmyXLpPaxJrjIiu1OfMl1EiU0M5dK9+KwqiujxAn2H19oL9W6dd60663a2s5ElQYNtN1NN36WXhdGTFyr4p2UE+wfVdFULhuC8+e9izihVpWUCVtGzmCNuAw6OBN9kSLX7k/eeMw937/o7tdi8wZ88k3fvAVtoH0iFqdDK29K8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A+sKidsO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+sKidsO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 556F7EC00C3;
	Thu, 16 Jul 2026 06:21:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 06:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197306; x=
	1784283706; bh=RfdQftSd0bqFLi93eILZLFCZJisgSzL+oaSqmY+MuEk=; b=A
	+sKidsOmpx+fsKBaxv9ATYvS26qYVEoOzvV+hhCLTRwF4IKV/cMU8E7PUQQQdACP
	I0Q6wzsM++0TUhAwstlwMKrEpWkYO0cyoTBNIuLbQsVtpYTMZVeStYGycZDvBB0l
	LNnuDMSiLDwua+g/+IMhZKxJ3wsySxaZmxkyTMcLNczh3xaTvfvZlnXyWaSetd2t
	RqJY+svmNtzYBhENMyhv52raDagjV4ZH6hbEkGJ4MaMQpXq8ri1gMYBWQ80deYuF
	OXenvQpdhXw9lNJZ7hFB7BUE4H2zXEf+8LEqIiUNZfjz7e+TzHAZGpUUHQX1O5zQ
	ILh757LtAnFvHA+obTylg==
X-ME-Sender: <xms:urBYaqzoJSaWimIExWXX1axXxJ-4_Aqs3FE7PWOQqkTBljkpANw-GQ>
    <xme:urBYagX5C0aiTFNx0hRf0RzTIxod1dRSEMwFyxJ87pgBz3zTmeCLnyKrXNr6t2Nd_
    4xmDaL545f_YmUihOjRXMgwkTH-ut8l6YRecqxHNVW6fbce8Hs9AHs>
X-ME-Received: <xmr:urBYasPgSe9914FMZ1QOLdo8XSRPFjM3FtBLjG-NnGyfxcfmzz7GSl-qVlD4mu3th-PjSsgyO88VHj6kBuT91HACRyt3vh0melA>
X-ME-Proxy-Cause: dmFkZTFNd6IbQ8H02rx08ZoP12RP2Y9vRARhgJlB0wIR6PSDfpSKBP1U3vWtu8R6W2Elci
    mTbDQY7i3QnNpByXjBC06gze8kG+fvg+RzUwEsui3pN/l00MK5NihMyimabiULXhdRmgUZ
    Fp2vyfOvyCSMxk3LYLdS15NBRAbETzMbMczO1MNe+QWWvbcZSFDUzJDvejX4jDXHbMarlU
    f3AD73FJWuDyz9b43nqa4DbZUGiQLP2V73l6cRGQdOXraCcCk51WiPnNJeqlwif8p1Liiw
    vB3zT16g7f63egnFS0GX1I3OcL8mp+5HlRupkBt+q953qX1G11NJ8jDFlunH7Bs/fVh7Mu
    2CgP5G1rPkDg5erWWhiOiMddYv+Ao2lyLYd7rQMfxmC0dRFYvhoOF/5Ja4tLA2UvKxDFTR
    VSJFaGY0wpe/E58VTCCF4O10QQV6ZHelSWkwpYAy6pTTUN+iVuP40onjRnz2K0uF+8jKJe
    c01Ll0LUfhR46VOFjGEUSF+uCPudJ4Rth5n9HdN7kab9dlh8FF6V+ixyowCHPJd93vQwIj
    zyyHaprWM0UCxnn6ZYN+DsuSg3xkpt3zOQ/OiCraRSYz4NtYqFfyiJ5WL4IkS6sGyykYIc
    ldgGCbOVV6ZYP1hmZ5MAQPF+n5g1m3INMacJQq2x9qXkf511gvmfO2Rqi6Zw
X-ME-Proxy: <xmx:urBYaiDgkB7z-4f7hTFkxZWRZwuCRIqvZCPQ_iDlNOJ9hXOY2HVEVw>
    <xmx:urBYapfrGB4mUiByhmIo-xIg4vhMixlBSbuh3nN-MKwYRvdVWrdjIw>
    <xmx:urBYahMXY8rvSkQLN7-GOHjMbDN_Lr1quk7NZc9G7muPGHm9u4gBhg>
    <xmx:urBYapJzrhpf0KmKbNcj0Eu2Z87DOvhCxcXtYKK7GJnZ64jdNT2-Lg>
    <xmx:urBYargJVuWCdb6_1SH0OpUpTOpuVqZIzBP_A7JHWPAlD-DHT2J4_tG8>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:21:43 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <38052482a1b7010beb01c0d96b0849875f5f8e16.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 27/31] swim: Remove unused macro definitions
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

Also remove the horizontal rule at the end of the macro definitions as
it doesn't any add value, IMO.

Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 444c3f31ba48..9661d8f7a5ed 100644
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

