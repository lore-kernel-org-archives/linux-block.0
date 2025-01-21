Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8371F1503
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463887; cv=none; b=lxjLbLGLWBiF4TDgUJsYx0ASBqpY0j+srp23ItfRsH09gPFJ3wAyapbooOLPUVXJpjxyB8pCpOaD01BwqvAg/uNME9ct/bFzeCNnejWAsPyDQBOPWpAp+F5BlPPc2OGFDDs/vMzZMzh38MOtWPjOAuhokWgloJFFMuszqw/jh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463887; c=relaxed/simple;
	bh=AQAB22mqhB1zQtLhuSvyO1zMhf9LsRH3MKVRpXJJHd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B8wqVo38ZQZvD9f1l2+KuOf2WUnHwkIsaS28Q23nuEOO6rkLWoVA4vtyDrMy/YNbvZ7P6TBqcWjKmCHbGlEqB0meEgOhpKaboPxoJdoadEi0b0ZpcOhHhOKN1FQCxLCKO+XSZ/Wznkvmb+c+jLSjjYBI9qDRbmw6s6DmDLoxeIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej3h+SDQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej3h+SDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93BFC4CEDF;
	Tue, 21 Jan 2025 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737463886;
	bh=AQAB22mqhB1zQtLhuSvyO1zMhf9LsRH3MKVRpXJJHd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ej3h+SDQoDSlgTpuKzbq7ZFLeTQSz1dwvhl/tlWyEbNbH8YZvG9lhdy5dZrGg+W3w
	 OC5gm9FtH6cjdI3b2/Wb9kdGBVV52vY9e1jkbq2+2Nd8z12O6Gzd4xSXwZVzB617Cx
	 QWsINtFxZEJZTs5sgYj+KUuePtwa7mfFmRkMUHJq/UxRSsj4s68QgsAR32yDjyY73o
	 AoGK1rRMa4utHmlwcvExLepXCi/TLh6nkVy985WqTB5eOVnLrlBEO0Ct5EWjtdu6UQ
	 BysqSj+nmzj+YvcC/nlRTizzalAp5cHV7YND5fPOpcz9BMnZ1rpxMeFuGHZagRPrt2
	 JH1wynjp7GkUw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Jan Kara" <jack@suse.cz>
Cc: <lsf-pc@lists.linux-foundation.org>,  <linux-block@vger.kernel.org>,
  "Jens Axboe" <axboe@kernel.dk>,  "Matthew Wilcox" <willy@infradead.org>,
  "Luis Chamberlain" <mcgrof@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Rust block layer abstractions and
 benchmark strategies
In-Reply-To: <w4gsgpfgz335cvyjjk5oaykl3wav7d2q4robxuw73pqkkxznlx@hgap3lzl3vbs>
	(Jan Kara's message of "Tue, 21 Jan 2025 13:04:30 +0100")
References: <871pwwctcj.fsf@kernel.org>
	<pAX6FrMK2jF3_7cYCG-6vidZEz1v2Gey8Qwq1QJ18zbttR5hgHP7ziCajIo3_Gok8strlNhWaOLX0o5jIKDFCw==@protonmail.internalid>
	<w4gsgpfgz335cvyjjk5oaykl3wav7d2q4robxuw73pqkkxznlx@hgap3lzl3vbs>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 21 Jan 2025 13:51:11 +0100
Message-ID: <87sepcba9s.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jan,

"Jan Kara" <jack@suse.cz> writes:

> Hi!
>
> On Tue 21-01-25 12:13:48, Andreas Hindborg via Lsf-pc wrote:
>> I would like to propose that we have a session on Rust in the block
>> layer again this year. Specifically I would like to discuss some rather
>> puzzling results I observe when I benchmark the C and Rust null block
>> drivers. I did a write up of the challenges I face at [1]. The
>> observations are not tied to rust, they also manifest in the C driver.
>
> The results are indeed somewhat curious. One factor I didn't see addressed
> in your blog is CPU scheduling. I've seen in the past cases where IO tasks
> were getting migrated across cores leading to jumps in perfomance. Did you
> try binding fio jobs to one CPU each?

Yes, I am pinning the io jobs to cores with fio options `cpus_allowed=0-<jobs>`
and `--cpus_allowed_policy=split` so I get 1 job per core.

The kernel is configured with PREEMPT_NONE=y.


Best regards,
Andreas Hindborg


