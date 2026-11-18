Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032766;
	b=4ONe4zR4qyF5x5OC/m0fR3YVnwuKQhl85Md8NqaLN7aor70Tts6wJRyWsmo7MUpey+NR
	 gNNsB3KmeOhW7AqJ9/LkO8r6eSdYmkGcP5l70aU4CKZFoEH22T634l46zr9/ta5BTD+m6
	 yPdRNDnjPZEXjoYTDT9SScG7KaPcVrNWyDH+aSpVn+AjVOBZ+sFKhjlSnqeQgKbQEHatb
	 5UuCLqhORcNF01iG9pfLL8XYRJZ4a5VIJW4IMOpj4DtFV9OiweeHkk8FObnpKR1nksNry
	 buMtth3hoiFQlk9SZmFZNH1IOx1nIcQVsf5e92aRLKdAiDF3mc/cNO5w6C01srq1WVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Pjuff7q7uzbEL6ANRmv3ID5+cImAFU4IO3TNfZpMezQ=;
	b=XxYQcnY5/ZZXAjAsESJVLQH80QgBlP5CUfyEEfTVIzhBMh0Cc/0lOGbVGADG8yEiJOS5
	 Jh0Kc3SV9d3q4X4alzqy95e1vbDraw+ppuO80L7w/EOp2njywRkxaPj0Xp5MbWrslqvxy
	 3AA+g8DxyRVCZH0XzxAhy9vKfAScYFfJjm8ZyUBP1rai45avGftUujz6FSqtjoVuzDzW6
	 rXoYe2qtkIhXDeXFOZ3N9KRIwWpMmG6ouSujTdE/tYMCERCh/8zqics0OYHWr+pK5Ylbx
	 W+x13pNgEeMU3mlvd596zf8Re4U5Y3435SNIDdgpmqVrpWIJj1zSgz+6zm/OW4JW9CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YZ7d3lcY;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B8606A325
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 20:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C90B8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YZ7d3lcY
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-490d838b425so767372fac.3
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795032765; x=1795637565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pjuff7q7uzbEL6ANRmv3ID5+cImAFU4IO3TNfZpMezQ=;
        b=YZ7d3lcY633MpPdzjWfeEyddVT+G02tld5QoTSdv291wxWB0jwFPK6qsBfYsuUz9cX
         kAkzP3LUouv2tijYjJr8sJHC4NjR5gdQsOpn7qWo+6lPhvfvcrw03ejYxDZEH4Qoaj1E
         RNiNTK0iXxczAY7HrtLO+bVjz6OOX+BM/PNjokwUt860VRPz84en7wkjjhhDbx3F9pX3
         w6Yh/fYPUTTL5naOyUHHAu1UBrc2k1NL2FrhfcmUIJPSRgHJznmsQZIZd3Buanai17Jp
         OgDO+LiHyBJp13h4BnLLXG1ojjUnUNoxNhdRWQw+8khp2DEx1JaEO95Dv4tx34KBKU0i
         Ym1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032765; x=1795637565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pjuff7q7uzbEL6ANRmv3ID5+cImAFU4IO3TNfZpMezQ=;
        b=pDVFkcJxRZOpuALB79aZjHs6zHhoVUuJuqK0qdRTnJlQqkUijfMHb9WIUSH1GH0fBt
         F7cb4O/n+RIBb9IDTfodJLUOY4MZb8E2Ujb96F6dS+TOh/iHFz+gx5aCHT3NZK7twLzB
         mJRcDLDv4TaZCauJoeCe/3rHx9G8dMrKONID32ZN8gKZ1JIbYc7/Aqytpqy4Xtu2NOhr
         efljWXLJK/X31lJU0jiG7jdriv81k839vG60EL3Mvwsvy3+uZr7HR4XPrQTwle/XLkG+
         Puk+a/kMGASI4F1Fees3gwFVfL4zdQvMMtLu7Om8Wus/5Jgp6RP2s4Rzgl6gqEZl0gPk
         +1ig==
X-Gm-Message-State: APuU4Z/r/y9br2JwGXMqZBPpWXWf672AniXXaZZ20WaKSg33qYMmIt5z
	DH/jbEzR7xgveqfNg6JjWYnMlfnKSphYyAP9pHo2325SgsCl9asvzf7LBloBqXpYy9E=
X-Gm-Gg: AYBFou1ugfZfh4c9wBe/8T+h57hZue2nUy086DfLIUsoExgmu2N+ibYbivSjLd3naDZ
	oGsPPGSXfrLiTD84j/oBm4d+KFnQKmIiVB2EAoBVGYCYlBVTpQTVr11kF6WNEsVvRXFZubz2Wkf
	rPhookWO3kl+ZREEWhsB+P8g2DoQT+/ZX4Bg1gc5k1gFsnmzDu2i2N1+hDi8QZ0E0cDiWzdlpyV
	Fa0WvzEEyfmuXiPoWqlEEXGAeW+OjZq78a+eexbaOsxnCiJFnzjNfjmP1e95g3YAnR93hSZvUTV
	YCoIVJ24aInn12wRx+r4jkkXS/H16DvusIBYxkhqxFqW8FKZEbrSkpiFSHYBJn57BUTlGaSOCRu
	tsgixYax2GzOXc8BspTSPbsfGQKXe5BNACputbX7Grc01uTDtK6+lCBE6/UzmhhTmJtwUSWA4j6
	nb/i8dJ67jm0Zkx6ENBdtkH3Ajro126mp9EbCUkuUQkfmTXPyzPY4mYlio9HkGhkrs+2sEMc+CC
	XNMwJm3ZeMl71p++nZzdmByGrrzQBJkIhPxiJ3h/+vYIkJlTPEIcjujz/9iPBD8tMLV+aakpjxM
	9U0MkmDo+7RqOamTLrsIoVvU7B+y1IQMnU1W26ekhRbxR1ULRbZkwek/rPJhmHcJR+qs9BVqm45
	R6nGaMzWWn9QEyfbe7kzTsrzUlondNoH0T22cnAmGjJldl2E=
X-Received: by 2002:a05:6871:5826:b0:494:75ba:c6d2 with SMTP id 586e51a60fabf-4b75f1206c7mr3688243fac.13.1795032764761;
        Wed, 18 Nov 2026 12:12:44 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74372cb6bsm2987383fac.4.2026.11.18.12.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 12:12:43 -0800 (PST)
Message-ID: <17a2244d-010e-425d-acc7-ce8601982a10@kernel.dk>
Date: Wed, 18 Nov 2026 13:12:42 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix NULL pointer dereference in
 blk_mq_complete_request_remote
To: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>,
 Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 12:28 PM, Srivatsa S. Bhat (Microsoft) wrote:
> Add NULL pointer validation in blk_mq_complete_request_remote() to
> prevent kernel crashes when block drivers pass freed request structures.

Please stop this nonsense.

-- 
Jens Axboe

