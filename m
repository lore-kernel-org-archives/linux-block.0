Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F3273D8D
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660071; cv=none; b=dkCp8ZtGqxQ6Y1x6BxCqzZPMj30Qkxv6k7C6H1ndhq27k2/d2/CN32y2zFBK/WmAP2fyIno9GXwivn40ODM8iK2Gji6VoWW+2/y1s0OgdPO3veVSOTcwgqLCFGzpaD4qu5NW9Mt7z2XI6ydHcuz/3hTUa7pQ5vut+ha9XkD7CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660071; c=relaxed/simple;
	bh=HQ91xczjmFp5kTwFFwEzWq3LTqzFJdu3evK2jzqvTYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e54TDijH7zh5pjnhMrZ6Lo8H4uVNoM8z5VvYZYkwhpCgmylPUA9J5s6BLa2Hr5hBasz1SlV5owq46mR/i3TN6dEL2v9eqzrVCOMWhq1RgSxx2zkoMQAE92pMNTuFZ7Kmr1O6B/ZhzVhOuLfi8YlXRQajCGCba3n5wYxPZgC0TeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iQf7HhFl; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="iQf7HhFl"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR5Xj66Nrz1XM5kt;
	Wed,  4 Mar 2026 21:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772660059; x=1775252060; bh=5dc+hmX0/QuLP9ZEP1RTmBo2
	lDJG/nbEKhJ1yNSqbPQ=; b=iQf7HhFl3UH0zc223t8qYGe8zAtvMcSBaBfv92qa
	SH4e/kie6xsYyFlH7HwqAAla8kfxagq8DtEoApsbNW9f4q5fKRza8fHnNb3l2c81
	gR1t1MUahhfN18u9Cksg0tFKfkse3NEEJu11QBOZd/+jdu5ede/KsVtM7DGJDPHb
	jtauubIZjjROFkbtssTFIePn12nAvfHg6iDNCHfjvatjr42DOnNbwjewVtFyr1zX
	pHjUa8Gq6hxpJ+ChYnhRQY0q9SH6LVF2eKN9A1HV+JON8pbpS+IO9c7On+7wDH8l
	pa4vOas5gvU68jPQm8aJeBXS7hwTFE8ZeriQMlBE5I2R+g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id a8tNubCfN9fS; Wed,  4 Mar 2026 21:34:19 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR5XQ04z2z1XM0p0;
	Wed,  4 Mar 2026 21:34:13 +0000 (UTC)
Message-ID: <159e66de-5934-4d60-862c-de4dce9afc7d@acm.org>
Date: Wed, 4 Mar 2026 15:34:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] block: Make the lock context annotations compatible
 with Clang
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>,
 Joanne Koong <joannelkoong@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-4-bvanassche@acm.org>
 <aaiP-EE4M0iywHzc@slm.duckdns.org>
 <dfa02afc-b517-43cf-a136-4c5d464fc457@acm.org>
 <aaic_mAZCuC0wZdX@slm.duckdns.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aaic_mAZCuC0wZdX@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/26 2:58 PM, Tejun Heo wrote:
> I mean, yeah, static bug detection is nice but is error-prone manual
> annotation the way to do it at this time and age?

Clang verifies the consistency of the annotations with the 
implementation of the annotated function at compile time. Hence, I don't
think that these annotations can be called error-prone.

> These annotations have
> been around for as long as I can remember and I've never once found them
> genuinely useful. Sure, maybe it can flag some latent error path bugs once
> in a blue moon but for the most part they're unused and unmaintained
> appendages that just add to noise.

Agreed that these annotations were not very useful as long as sparse was
the only tool for verifying these annotations. The verification
performed by Clang however seems very useful to me.

> Here's a challenge. Can it reliably and in a sustainable manner capture
> anything that https://github.com/masoncl/review-prompts can't capture?

The above URL points at a repository with AI review prompts. Today's AI
systems are based on LLMs. LLMs suffer from the following issues, issues
that do not apply to Clang's compile-time thread-safety analysis:
* Hallucinations. This means generating grammatically perfect but
   factually incorrect statements.
* The "lost in the middle" phenomenon. Ignoring information that occurs
   in the middle of a long prompt.
* Not being built into the compiler. Clang's thread-safety analysis is
   built into the compiler. Given the computational resources required
   to perform LLM inference, I do not expect AI review prompts to be
   integrated into any C compiler anytime soon.

Here are specific examples of what is possible with the Clang
thread-safety analysis and what falls outside the scope of any code
review software:
* Documenting which synchronization object protects which member
   variable (the __guarded_by() annotation). It can be very difficult
   or even ambiguous to derive from code which synchronization object is
   intended to protect which member variable. The Clang thread-safety
   support allows to annotate member variables with __guarded_by().
* Whether or not it is intentional that some code paths unlock a
   synchronization object and other paths do not. The Clang
   thread-safety annotations include __acquires() and __cond_acquires().
   These annotations not only enable compile time checking of
   synchronization calls but are also useful as documentation to humans.

Bart.
