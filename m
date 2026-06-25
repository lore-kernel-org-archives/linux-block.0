Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF011276050;
	Thu, 25 Jun 2026 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374895; cv=none; b=Lxq/LYAHf54kQSQv8F9sICzFjXvQdqZXEypcxJnzDjwnfYhEdHu7dWTuybPH0oGA6hZ8ILGh8ayKRucrIFnEDv0K37QRcwQLDYs0GDfC5pXgxO14MbcLx0YEnHxJKWm/YysU77dMXo/k8eDCsdvFuOVgyJ2BKSHsJNq6odq02O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374895; c=relaxed/simple;
	bh=U3zUAF7k+2zCYcCVDV/oNsc8Eu66cfcoM2vy6+80T+4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Qkwx1JaV+44kHMzGwcwtaBLsyBB6at+Kz2imuTd1GOBNuCdBTIOFTd/UooZSsWltWpgt+CFsHJh1FmWBv8PwGo+x6xMpG9LY6nWQfewUthAVVveywlV3UDxje0UKz2zmaOzSwL0iJiJoqUut4zrmU9tHtC0dKIlaV+IaO+P8m9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=U4Q9ElTr; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="U4Q9ElTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782374883; x=1782979683; i=markus.elfring@web.de;
	bh=M+al6GJ1fPay5QxZq22D76WNf5V0IWpbaQwEumh+my0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U4Q9ElTr/PaFpap6UrUvxo3mySoqO27qLvoKMUpsY2q8SSt5/XltpftvAIPljroE
	 Psax5sejfUATGl6YPHi7/G63ygRqhM3MFiu4fDtFwfsPPOP1kFI/bx8+2tPVQYPXP
	 GuhGwLJQfmDqhOdJwsTae++iJZS8y3zBRqcrYRxBJEL94nbxXQgYF8fANxTVopNT3
	 xinGEZQ0PXUWnvjw0xmfLDHIp+GoBl+ZdCnFkKn4uBQcGOuL10G1uYrGngkouahEG
	 XwMRW6gzmT92DVUWMwrelOAOK6RAipFaLS+Vl/YnCZ9pt3iTJ4ln5HCUGAIclzgFG
	 +kEEoJUphpbk/dVldg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDMR-1xBS7A3NDT-00gxay; Thu, 25
 Jun 2026 10:08:03 +0200
Message-ID: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
Date: Thu, 25 Jun 2026 10:08:01 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] block: partitions: Use seq_buf_putc() in cmdline_partition()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GBr8beHp50WX/eGGYVlXA78IUs8o7eOEMyAa3zUQdiyZfNkf8Zc
 hmuS+2KpWU0473Cw2TinDmsvoVsshLLefqy/4EM4ictctteQ1kNB5x5d3YxJheb3Vyl2Gsh
 wseRwi8IaII5BUvKIHAjPfpb/Idjztj444OXD9ol/nX//WsFlZkDRQL3EqSIWD7fpl9Exlc
 2fIjbtNTNc+tFKeTalKgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x1aM+NFnva4=;HwO/XOdLQQe+R/iNgEtpd/LLCwj
 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
 inXiEZNbrQ3WefynvufqZ0gzR+k=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jun 2026 09:50:33 +0200

A single line break should be put into a sequence buffer.
Thus use the corresponding function =E2=80=9Cseq_buf_putc=E2=80=9D.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

All affected source code places could be adjusted at once
if the change acceptance would evolve accordingly.

18 source files are left over for similar development considerations.


 block/partitions/cmdline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
index 4fd52ed154b4..ce7488b3d2db 100644
=2D-- a/block/partitions/cmdline.c
+++ b/block/partitions/cmdline.c
@@ -376,8 +376,6 @@ int cmdline_partition(struct parsed_partitions *state)
=20
 	cmdline_parts_set(parts, disk_size, state);
 	cmdline_parts_verifier(1, state);
-
-	seq_buf_puts(&state->pp_buf, "\n");
-
+	seq_buf_putc(&state->pp_buf, '\n');
 	return 1;
 }
=2D-=20
2.54.0

