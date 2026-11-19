Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059288;
	b=xy5pUXixJArGgAXTlupRh2lwxOg4k9d0E6CZEBN3tqm0fCUSRJUkF6LPYLV9bAcrUQKv
	 14psKo+fzU+ibO11BlGXwTqk8/whk7R3XGsJmmU92o7XSzgAB88SOSzXWBuPFM0vpe8zf
	 B7wg1TgJ8HJIs3ceVP8HdAHHOQmCnqeT4Gbyz1E1QBRqLPyk25AaONMsp8xATfkjez2Jd
	 EaipKphacVs0uedvB8gqKDPT01tCmPaQutanhyp5crMIZjzlhOUqOO7HrvOylJ7N2JE1/
	 9P7tSbgjT53SXyh0C9XKmhtRODwG3vC4q2Xdrt7cE8by2Fo5DqYsRBIUAa7PEB5DVFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059288;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Fi6i4FzwzgOIzLMAkaX8jzJ3YUL3/8d5FTuR/RjKc48=;
	b=fQy3vV1tOLaStA39GNrb7UQhUV9qTu6jxewSqno01UwBy+OWaBXJvQO6IAlj9+D4hcTN
	 KmNuP/hXhhNBfhDwXX0Upr1JUOkomnAyrfyhQw/MZ8JTegp1PEgUM2eZNEvQAXWXMK0ns
	 zWf0oADyRTlkB5Lr4sGXOymbgeSn8tQKK2At6doGsW9lv+C05yz7CpCukwAM3seX1BZ4D
	 ZdTM/ot+E3RVoMEQCI/UiketeTyXLoSCyJfMEgM00rPX9ohAS6qaS4huwKrk3Nun3/qYZ
	 7MGI7yjxG+cZRESD9gQDruhY0dkx1+WMg0b8ySwriBLmOAzVYCtlMOMg8HVamXr4mSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=CfG0gzMX;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD7606A31C;
	Thu, 19 Nov 2026 03:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8BD7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=CfG0gzMX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fi6i4FzwzgOIzLMAkaX8jzJ3YUL3/8d5FTuR/RjKc48=; t=1795059287; x=1795923287; 
	b=CfG0gzMXvG+50bMxlDczgtSNrOTU2cod+1aASUt0xww53xfDqEDCm+dxSsUH0r+SmkQif1gBR5V
	a67gcjk2BnsPT9b1+Y4bOfW58uc9nld5zbS8rkN3fFPDX5itULiMTPnTutlSEe1xLwUJShLFhvwnZ
	8wiyUSWsXq/ePJ4GNZSjrZ1GTfNGIhkawt9Wp/TQgUt9J7Kc/5A7wOTHkrTvsUQap9aIxo2s0K5oy
	BzMNQQeEGe3BA8/CZFdHZHEqZnQjn9QC4X38Y0TgL7VYU+14k4UFtZ2IgWtoagfNj8mCtzBvfPriD
	R1igwjehV8K2yiRfMt6fIV8gL9B31yqD25ww==;
Received: from [49.207.212.66] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xTsv6-001fCK-1w;
	Wed, 18 Nov 2026 22:34:44 -0500
Date: Thu, 19 Nov 2026 09:04:38 +0530
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Jens Axboe <axboe@kernel.dk>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] block: Fix NULL pointer dereference in
 blk_mq_complete_request_remote
Message-ID: <av5uTrDoSEx01BT-@csail.mit.edu>
References: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
 <17a2244d-010e-425d-acc7-ce8601982a10@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a2244d-010e-425d-acc7-ce8601982a10@kernel.dk>

On Wed, Nov 18, 2026 at 01:12:42PM -0700, Jens Axboe wrote:
> On 11/18/26 12:28 PM, Srivatsa S. Bhat (Microsoft) wrote:
> > Add NULL pointer validation in blk_mq_complete_request_remote() to
> > prevent kernel crashes when block drivers pass freed request structures.
> 
> Please stop this nonsense.
> 

Thank you for the feedback, Jens! And thanks to Hamza and Keith for
their review, which helped me understand what the pushback was about.
I've now clarified about the underlying firmware bug being fixed (in
my other reply), which I had failed to mention earlier when I reported
that the crash isn't reproducible any more. My bad - I can see how
that (unintentional) omission made it look like I'm adding a
workaround in the kernel for a bug that exists somewhere else
altogether.

Thank you!

Regards,
Srivatsa
