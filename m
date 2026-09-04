Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBED468C23;
	Fri,  4 Sep 2026 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514576; cv=none; b=IcuvNfsaZojvU2zNSAgrsB+w28WKlxaGo7ELrGzZ83Yxym7ojlrM7BXaYZqCRLPUrdZw6CRny6UzEwIO3Awx2on5RBLiYnE+ckDgnkzFVIyHtwYO3NKSsOwKcfelM3ndtKSDTbqJ/gIuxrCwWSHqRP4W8T9aXVfz6xsjQ2zKTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514576; c=relaxed/simple;
	bh=E30q6xWkz3SJ09FtFyDQILssqBaKUrJXbdFpdnoB58w=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=ayVByXfGVMeCCwhnlhRilRPsjhJiUWW8ICRxIYa8PT5TtlJ/poIUGdl8V/MyAaguM22iwGDG/v1jJ6H5bYtl9KkisoJQWfSgiOxaTs0PkCAr91qgcmAD/eZ5AvW96S6W7FLsCp7fdU+OrZ0V7+sjY6rCRc/Kq6ZKKQh9HohW0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nojY0jcj; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nojY0jcj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5ED90EC01A2;
	Fri,  4 Sep 2026 05:36:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 05:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514573; x=
	1788600973; bh=u0KCUaZRNaA4dmF8L78r6ujqfisMQB5TBvF5SJrRSUg=; b=n
	ojY0jcj6L9kiTjXsw8vKSgEm/s0QRmNlTdcXvoZ3NqMCZE9h+SHrqHs8nLBz4Toz
	7E5KlHeZTeNYoYRNoAscUqFTgaXW2HcKRck5W14WAbxE2mL6TKYCDpcRYEkGcMMc
	B+VRKWJo9NtmYsZxZzmXmVdOqXobH5YJJI6RDzM/1ni/A0ojd4OVnWmyY3qGrBWD
	7xsm1N5hyktWAhhhVWdt0Vwpj032ZtMNHwy0KvHzabzr09US11N1k1oWBW89i/zL
	9lMuZ0+NrOEmY9b4CZfl22kVdKNAA2DBpnThoPL8cz3zVnwxMcguyJL0P69D66/K
	w1c7FRInx4vS8mFgymTgQ==
X-ME-Sender: <xms:DZGaaolkr8KoyBYz-WjZbeB1yaEH1dhfEHbkJQPGlvDDUX2fqZn6gA>
    <xme:DZGaah5Emkf11dlojui0g4fAWUXcX6tt6vWQhDn5C6Of1vulynWvkSTf7eznuRXjD
    brn7Q18U-Om9e3TUsupAzfNFKr3yW7jLWW_wMg9pwZUeuFA0is_mp6i>
X-ME-Received: <xmr:DZGaamhQZFky-pFVAVuh8nptloQiT8P2LfuN00oBNx0RTjLULLhQi53iypgLlZZbs2ra1pTDQkt1aJQghC8i_pJ-LYAGTxIG6WU>
X-ME-Proxy-Cause: dmFkZTF1sA8Xp5SQpLKPpl7AOr0OCI6a5muovCjMEclTQyynzEcS3CRdTjaZz8PU8K7WR7
    lfQ3mDP7gXeanu8WmFTTNTNg/WI3tmXduWuLwEtqkTz5KfwhqzwioviZErMgjDZWxH58hL
    ih/8BC4Od4xW5ClBg2Setyl1uFZbuKpueRv4UkSy93ie3kcU6K9mH8wt6e98EXVurgHAvD
    MBDOw+EcwXx7T/tslfs+d2j7oiGrIytLxYYyT1iUYG4q6gimgwbZjGKP0TSVgw26FCz7SL
    lg+B/dQvzS+oOmxLOh6t9JfYFKVOoBcMAeQr36ZU0zAxhgEHVdZcTZoA90wPHeyf1527oF
    k3OyW34Dht9CgzQ3Oo87BQ+mqNn5f7fALyySpRLchR8UAyRkwFTR+A/gaW6SqAql8kldI6
    zKAIdess88t3sEAk7xxQoyc7W5dpyMkamvVKql6CqGqN9nfnXvvCO5IrZN3PLF10vBBEh+
    g4Y7T7tNrvcrzrdSFaAY73UIyggkO2HbE/5pNEHzLkBp0VY36ohaA2F6+CPjARhN5mSd83
    yLIfxkAaT2PF9JkhQO84KnsZjyUE3zHls+v10H5SHPZP5NhpZzwBQgNxmv4laLNlEzymQ7
    8zh5JX7YEqlpMjTSsi5BxKsIzpvpjVehZV88KQZFDdny7Uo1H+XSVjRfIU6Q
X-ME-Proxy: <xmx:DZGaamGnPA4BjrV3a_ztpdzN1JS0vsulw_wmNc-bnVTyLlo1bk5J1g>
    <xmx:DZGaakQoLY3AQgpERsPsuuKCueDFedSzaOCl94lHA1bVdCv5CrLLcw>
    <xmx:DZGaarxaADq7VOdps5zwRVnxDZ9q9MI5VGQ-_25GE9gE2p21fPYSFA>
    <xmx:DZGaaocYOtmzs_gWJC9cpqiFVOp9Z-1cAIeY_qx8aeMmMZ0ekpx-NA>
    <xmx:DZGaarUL4JJZDBr2lrPR1rJ7iHTX_1jlPqWCvkJ7ipO3xt0AQb8LJwKS>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:36:11 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <d095be631aa91b6fd5704f4c159618d394a82414.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 29/33] swim: Remove unused macro definitions
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
index 3b8acaa21787..1501444fe070 100644
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

