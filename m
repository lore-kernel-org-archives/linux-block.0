Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8647317144;
	Fri, 26 Jun 2026 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492522; cv=none; b=G1Ux3h95zwhLPlWR27fAgkgHGt6WvYC5i42vjkRwkLuHL36G+tY6DBxWNC1hjQ1liBDK0NzbERPRBNxc0l6v9NtYoQT68PPGEKHYAHmBnWwFclCLsR+tGrPvd5VbvqFw6PR7Ge6NjUPHvqWMANI7DkdaKPwQob0gIstrGWR6H7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492522; c=relaxed/simple;
	bh=0r9WB+JvDOVqSN7EWPziE3y0xVpQV9z6CLpEvpznNQ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W8LgnRsqkPJtJwQTCpZM/xk4ZzW2Eng7nJa+J6xHMFnuH7cxvsNxaWOs3PU6UBJqkekk8hxzYeVFY3o/HdZCh90yIC4FlsryH+nm5ZCx2Xi/SYcmpsfR2fmrwnwMhTZz4IFAG0+cyPRmPzIqDf7+XTxQtBoM/ToPogIbTSMZg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pmlxH3VD; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pmlxH3VD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782492501; x=1783097301; i=markus.elfring@web.de;
	bh=cq3OsnIEaNxXV0IVloJnCEarbh4R9Gmloj/wfWIwC18=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pmlxH3VDwAY8RqXrhV3YaXan/Lz+/WMCHyMwBTnWIdMw4pX9gjPqpmzCvUmL88fn
	 ledi5AqaTDsDlpMJvfAvmIUDk6QgzBp5DxSOoY8+kVtFKZlvNDt7uS8Irvc3gw/Zi
	 ++WESJbTAuEgoU+4wMQzSFj/53NSPGtxBbtZvfJlvv8DqirrTwWoNIPTCQORgRe/1
	 f4yvl9EFTHIwNQ2n6aeN5H1SYHQpkJKImPhFTlvupwOUfC2I0Egi4i3RuyzSIsxyz
	 6rcCi/9Cy9VNovniHNAX29fUOO1mzTDMpGZtPzfUYFfVwePA2m+KZtEDoagiyQ6Xu
	 KQ3N+kibiOEnR7L/vQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1wstA41SSP-00KxJ3; Fri, 26
 Jun 2026 18:48:21 +0200
Message-ID: <196e07e8-aeb4-478d-bb05-1faaea976e08@web.de>
Date: Fri, 26 Jun 2026 18:48:17 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block: partitions: Use seq_buf_putc() in cmdline_partition()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-block@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jens Axboe <axboe@kernel.dk>, Josh Law <objecting@objecting.org>,
 Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
References: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <59dfd2ef-2fda-4dd0-a288-52c35613e778@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eq18YjzQYC7WQl+AyAH2x10ntsCTmCeoGj2gWtky/2kaQ8N2Y03
 6qA8qGyvGjoBXpub3mJmseABGCLcoKQzjdMiQtPmeQ87hnm+GTYXvwQuOg8vu6oa2JIphcF
 16GadylVgq/jOxpWDi0SfHrakBcTr+zDw+DE/yXZd4djXxyO3Fnmpy+faQYLvMiievrGsQc
 4sex4lN1ZAsDNB+877KGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0NdExzu81hU=;GqSut3gtQuApedkeObKApBU4vgE
 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
 UnZ95w==

> All affected source code places could be adjusted at once
> if the change acceptance would evolve accordingly.
>=20
> 18 source files are left over for similar development considerations.
>=20
>=20
>  block/partitions/cmdline.c | 4 +---

Will development interests grow for remaining update candidates?

See also:
Clarification approach =E2=80=9CUsing seq_buf_putc() calls more often?=E2=
=80=9D
https://lore.kernel.org/cocci/3455eaa7-297f-46c9-a8ab-91e5bfbe0105@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2026-06/msg00030.html

Regards,
Markus
