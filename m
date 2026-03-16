Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FC3CFF4A;
	Mon, 16 Mar 2026 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680840; cv=none; b=bhy/sLm/fzAVfrtpAFlqpXe0W0qEkVc6C0zjsDVJBMlQqqevOVfyefa/y5CJ8mXeYXkBGFsgX1gKmxsrkIAeOl3xTtulgcYVqkvELknXk3K6diLk9MJMCiP3+jPlHJir7vzrfujJtffNzq3atIy2UMLc9Pgh7L7M/JLupd6FdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680840; c=relaxed/simple;
	bh=wdairoIinyiwaXKAySb95Wp+HwHjAGiOzXmCev0LJxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgyQrzQeZxmjZigOceNLztOr09hz7RasNihJBN3A/LGFDko578KJV+9jhNcT+35azBUrxeXK65qvVvf+VWxcbOffasUGBYtS5RYfpOiVgmN4r+FlYHdhKNDN938AKybyD9oQJ6Rz3+jpzPthWJ6unal5FRcHsdKLPIGfVthgvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gyff/pnh; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gyff/pnh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773680836; x=1774285636; i=markus.elfring@web.de;
	bh=wdairoIinyiwaXKAySb95Wp+HwHjAGiOzXmCev0LJxg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gyff/pnhC15r0NmPZ61+9+HJ9DtrTPdSD9CwC+EQgRlfzyuQxma0C1HhEGtwSD82
	 FCONEpwMiwnXDNf43vbYYYwsCVmoWyP18PkwFmgaOlkUgDhwfh864z5bF/L/6wP6n
	 tDSoJ+u+5OzpPuD6Npoo4gDDLvBgKFGRnXutHLRhtBpcyQpC92d9ISm9HDjFvUcCW
	 vUumKQy+afnxuiUD/JL6oYarJPikOwJ/K/49/POZuQj+hGYKfH13Xql395b1YIh2n
	 QmH4/nIWajv8JNXyNCNY3ptvNX7e8T4/BhCGSe4sX3sQW18q1DiHVEcXv6e5XjF7M
	 st9kof5u9V0aXor7UA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1wJZff1wMR-00PUWu; Mon, 16
 Mar 2026 18:07:16 +0100
Message-ID: <d6e5ceaf-25c0-421d-bcd6-69adf25146ac@web.de>
Date: Mon, 16 Mar 2026 18:07:14 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block: Omit a redundant pm_runtime_mark_last_busy() call in
 blk_post_runtime_resume()
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Felix Gu <ustc.gu@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <ccebfd2b-0806-4ab4-bda8-2b043427bce5@web.de>
 <6b088e89-cdef-437a-b6ec-60c65fb4cf4c@acm.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6b088e89-cdef-437a-b6ec-60c65fb4cf4c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8BzxfjPdTR7Ja/DAaJfyN5VRvtrbpoVJs57Uq+xYDxf6K2ATYII
 zx7baQZaKP5mmPD6b4Sekv5IIwWiNyHxWMIpaFpL1Gaslh9hLSUbWCE9jDGwGujoKxN4THW
 Muf/SP8NVaKQst+a0ZKtO5cauJiYq0eZuxIhBiDuzb9n132e8XaBsGDFT9KoD5yN3m5EQFf
 wZgrju3Nd8D89yY5rADIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rCbE3hOAHhA=;JhOpD4WyrIaDEJRbqar5y9BXbgw
 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
 wBkm6MusZuDeprBUMks2H8BaoDOQXYqGw==

> Isn't it expected that the Coccinelle script is shared when a patch is
> posted that has been generated by Coccinelle?

How do you think about to take another look at a related contribution?

[PATCH] Coccinelle: api: Add SmPL script =E2=80=9Cpm_runtime_mark_last_bus=
y-deletion.cocci=E2=80=9D
https://lore.kernel.org/cocci/4fa1cbbe-506d-4acc-acd6-57700d76d0e2@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00117.html

Regards,
Markus
