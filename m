Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C617A305;
	Tue, 18 Feb 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902867; cv=none; b=LubJdLMna4Gc6vqAuiEeTWNJBg/cUJ46I1zpdEoOeEUq+dloy20GOTNtPUgwNIR6QCrm/FVgCRbUnPw4qh6izrF9kCfOqGGI3C+8tsoACVGpCdFRl8HaRGDZaGQW63qOE+aIo3B8raPSOgW0okhjPcsHAzDVIPrEZu21x98Awo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902867; c=relaxed/simple;
	bh=FgxkArGrUtaVjhKeIMBnwOPXBLpq8ZXO3kVFROwiJuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mmNy/F2hGQ3Wbn42OSdzw+CU8L+Zy1+a1Kn87N1iAJ2TZHyNrO0Ovuv2jLc47qZILfR2yDeJu12JHWz0qPLy7UsWpq6cLffM1Sn38ot5PgttKEAF5hb6bIqHAj6fH8+fDue2Fj9h7cWIaRX1YAME8rip1ZIDm14A0Zq9lcBhTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsbsbF24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsbsbF24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1125C4CEE2;
	Tue, 18 Feb 2025 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739902867;
	bh=FgxkArGrUtaVjhKeIMBnwOPXBLpq8ZXO3kVFROwiJuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NsbsbF24pcHNf+K+vRrlf7dUNNvGI0M2Vohm8oMhc/4X04Qp5Dga5vysZ75oqTcxS
	 E1rnFVHh3iw4797tDCARhFQMI2v0gMKREs3MRe8ZPHlwRu5ZPCpbVjWBL1vN0OAdKa
	 lJo1Z4CZaKP09hGHHcAPQF/uyxgK7g51KnAA3W/i2pItcfJDQY32gHv1unhd5VCO1c
	 8FHQ+deXJsWZMuPWC5jH47Yjw9IAvRfFR2x9qD0/9BxwDJNE5MwwMu1ILa3vTnA2ox
	 xCz2wBU5vyaVjG/eGR1ipVhtjL7Up3Vp4DWPzTSlP2Gw7Ag5d5m4iHHq7rtEHczXRk
	 lyazw9t0tI7jQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "John Garry" <john.g.garry@oracle.com>
Cc: "Jens Axboe" <axboe@kernel.dk>,  "Oliver Mangold"
 <oliver.mangold@pm.me>,  <linux-block@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: set bi_vcnt when cloning bio
In-Reply-To: <464bc3f5-aef2-4e6b-b7cb-035077d1e3f4@oracle.com> (John Garry's
	message of "Tue, 18 Feb 2025 17:12:47 +0000")
References: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
	<KP4HxjAbrINQTT05XxqLFD7bPj5ONsT3hTQJYUyXtoHBYc7-xFNDZUN3R8pWT-Cd1Q5fguKy97Oy8UJv5Nj1Cw==@protonmail.internalid>
	<f4f4fff4-5055-47f7-9f24-6b1780920f4d@oracle.com>
	<87r03vfpkm.fsf@kernel.org>
	<jdr7luoFJWfOgYeggsdAevdQnJ6T77zXnaBFruP2zE56Ww7pz1i_9sl91pusOIn6oe0oIToFkIHzv8xxEW5eAw==@protonmail.internalid>
	<464bc3f5-aef2-4e6b-b7cb-035077d1e3f4@oracle.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Feb 2025 19:20:57 +0100
Message-ID: <874j0rf71y.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Garry" <john.g.garry@oracle.com> writes:

> On 18/02/2025 11:40, Andreas Hindborg wrote:
>> "John Garry" <john.g.garry@oracle.com> writes:
>>
>>> On 15/02/2025 10:58, Andreas Hindborg wrote:
>>>> When cloning a bio, the `bio.bi_vcnt` field is not cloned. This is a
>>>> problem if users want to perform bounds checks on the `bio.bi_io_vec`
>>>> field.
>>>
>>> Is this fixing a potential problem? Or fixing a real issue?
>>
>> It is fixing a problem I ran into in rnull, the rust null block
>> implementation. When running with debug assertions enabled, a bound
>> check on `bi_io_vec` fails for split bio, because `bio_vcnt` becomes
>> zero in the cloned bio.
>>
>> I can work around this by not using a slice type to represent
>> `bi_io_vec` in rust, not a big deal.
>>
>> But I am genuinely curious if there is a reason for not setting
>> `bi_vcnt` during a clone.
>
> I think that it came from commit 59d276fe0 (with the addition of
> bio_clone_fast()), where we assume that the cloned bio is not having the
> bio_vec touched and so does not need to know bi_vcnt (or bi_max_vecs).
> And it is inefficient to needlessly set bi_vcnt then.

I see. That is a few days ago. I am quite confident that for modern
hardware and workloads, this assignment will not have any measurable
impact on performance.

Can we add it back?

I understand if you would prefer not to, since it is not strictly
necessary. But in that case, I would suggest patching the documentation
of `struct bio` something like this:


--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -255,7 +255,8 @@ struct bio {
 	struct bio_integrity_payload *bi_integrity; /* data integrity */
 #endif
 
-	unsigned short		bi_vcnt;	/* how many bio_vec's */
+	unsigned short bi_vcnt;  /* how many bio_vec's. Not valid if this bio is
+	                            a clone (flagged BIO_CLONED). */
 
 	/*
 	 * Everything starting with bi_max_vecs will be preserved by bio_reset()



Best regards,
Andreas Hindborg


