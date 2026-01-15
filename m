Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320C25228D
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496018; cv=none; b=uwZ88kZowOxdYRC3XKq+hx0dP9lD86Lvba1jp6sglrIZmlL3NQ/9GRbnkStOgioGSXWQq7hQgX4+bbOQTQjVFBMmDDrvp6PD3u5v7TFBJJLJdcgkocMG0GHpp9BVsLl/epaU+QuQRKjSJf2/prJhDjWou7O0/xysvKi8FumEE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496018; c=relaxed/simple;
	bh=2JxGyKIPgE87YLxXlMWHMfYRMdr2GStF6rnuzsKEayQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rd0eeV4haAzVrI7vmXdtS27lzWHSXbNoqO2IITh7yz8o/RmrG881QtFzsI92b2uxC5WPRve7e5LGAFk+P4PeWnDs47CTCBBKIc/C1r36bBLcdnYlabQ9KfFRW/2ppnl3oG4lXoxCFqTiiazi4U+Ib/5iFPW30SsFIvr6AweKYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N7Pvwfjm; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N7Pvwfjm"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dsTZm260Yz1XLwWq;
	Thu, 15 Jan 2026 16:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768496014; x=1771088015; bh=2JxGyKIPgE87YLxXlMWHMfYR
	Mdr2GStF6rnuzsKEayQ=; b=N7Pvwfjm/vv5JuxbUiNOZIa3bDTztthxKQ1psF3Z
	LBl0w2gmgRlH1zs+QGMQcarIm7ium7jehU1nuU8ZlLiAqet5SBtAnQdDbSs+sakQ
	Mfg3qHEjmCXY5znwQ8g4xdtrr8WcIk4XzPxjSnT3w+btysBKtaT6x9+3FCWdI31q
	EJUwxehBNV5mjgxKjoRRWN/BvKmeaUFkIBg9pXn9vykcglSrnwbQ7/qzHb3ymTA0
	3bkqX7qA2i0lVwS7WpCURMol849GX19JbREEiX1AE1RnKZ+n+AA6f3VTrY68VER3
	5yGIm9fAPPi2CSW2uivZ/sW1xRksr/cCo8iCAOT7c9otzA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nKTb412N5kfX; Thu, 15 Jan 2026 16:53:34 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dsTZj62pKz1XLyhS;
	Thu, 15 Jan 2026 16:53:33 +0000 (UTC)
Message-ID: <33fe1cf9-a779-427b-bf74-1eee4434517c@acm.org>
Date: Thu, 15 Jan 2026 08:53:32 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Annotate the queue limits functions
To: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
References: <20260114192803.4171847-1-bvanassche@acm.org>
 <20260114192803.4171847-2-bvanassche@acm.org> <20260115062613.GA9542@lst.de>
 <1eeca326-9403-4483-8b03-36621e79db81@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1eeca326-9403-4483-8b03-36621e79db81@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 1/15/26 1:11 AM, John Garry wrote:
> On 15/01/2026 06:26, Christoph Hellwig wrote:
>> This is missing a commit log.=C2=A0 And not really telling what kind
>> of annotation you're adding.
>
> And we removed these previously - see c3042a5403ef2.
>=20
> Does sparse now handle mutexes?

sparse is dead. The most recent commit is from February 2024 (almost two
years ago). Additionally, the sparse maintainer doesn't reply anymore to
emails or bug reports about sparse.

These annotations aren't for sparse - these are for clang. This patch=20
series has been queued by Peter Zijlstra on the tip master branch and is
expected to be sent to Linus during the next merge window: "[PATCH v5
00/36] Compiler-Based Context- and Locking-Analysis"
(https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/)=
.

There are some subtle differences between the sparse and clang lock
context attributes. Sparse only cares about lock context attributes on
the function implementation. Clang respects lock context annotations
whether these annotations occur on the function declaration or the
function definition. The former is preferred since this ensures that the
annotations are visible not only while compiling the function
implementation but also when compiling all callers of a function.

Bart.
