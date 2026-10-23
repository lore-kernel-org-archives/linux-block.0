Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792726166;
	b=sd/gE8QExRQ0PAx2/5xK2ZbkzT7kjg8pqVv2yxaIIzxY+IxKsacubHrrXvrhW3YVFPvC
	 xpzfTRaJV7jFklqoYc57ZyojvKydQ8AIHKzL1H16CPe2BAiVsOcblxas7H/IHFpN3eTnv
	 ENmBWy0wfImhkUhTHdc5IMp6/9BRasv2qkCUEqM4sWfxWsThTJqmprtUUyXDmhEdeTOLE
	 9wJXypJ8BgPXxtyDXq45OEmsw80MIuDm89dqAxz8VpQRNiRVTonup9wZwcC1eZ5LdZs3f
	 sRxi8a2MQSUSgHcNarUc7PHAl7AUlmjf52ZF9RIKwsuUSXazvQ7IZPMSdjSDBjV4GFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792726166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9uNfDtdkpMmQSCiyYsn9we+cKJrdTwJ3vYkFgm9/S6E=;
	b=X3Qn+zAp47vSFi4lj2MX51lQyBwTU8ndjXt9A5YacWvhUT2i1BRRnFKNsC8XTVQOM6jA
	 RserBEl4aXNcmhrHz7SnNVJ3KpdSTQbhZAbdscPRL361DMFFYvWise/0o+aDJXXdI+Ctg
	 3J91EBW8SzI/NMrP6fBgqNB10OzKvuSjtvpRj6W7K9UeZkc9fhzy2KskWp54UQ6fH1D6o
	 amDYVo1eW5N1sVd9+wLK7l7O+DhttSkqFGhoq5HFhPvUr7DpNZ67xOW8KpjwGsJM8AGi4
	 GOlOfk0AelJMR7GjOQHYMZhNLJX/aIi10sxEUwtrBCQhyf3cJWH7s+sjkI1rubqH3Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D73606A31A
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 03:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D73606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so665923c88.0
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792726155; x=1793330955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9uNfDtdkpMmQSCiyYsn9we+cKJrdTwJ3vYkFgm9/S6E=;
        b=RHWyzEEheHXz6R/y+gk0o01HFPAy+REbbvRwPIjcQ/9j6oRYd8N58kVd+iCcZTEeo0
         2Mue+dAGvPPljXezuVqGqRP7q3TJO4N/GhIiMfZjzg5R9BHvnVpxFZD35rKSvOhDYl6y
         pRtVZitdbbo7AsfGakMowKzRF1V9TvAl7Sp08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792726155; x=1793330955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uNfDtdkpMmQSCiyYsn9we+cKJrdTwJ3vYkFgm9/S6E=;
        b=VYYAlFgre1oQA94trOpFCB9sjt92WP1tJ36Ytkvb7g0W+qXgk7vkituPly+QlqxA0Y
         scoeDXrpRLrUM9ZJre0WuSB4eHibiScpe4qD7mVpX12wJ1RHmsVoYh84ZWYQ0LvYfaYR
         o4tYkszWrzuSzoZJhPLBo3VCbn0vo/KYRuoeA9gUeYWWXceIzrsP+EflBB9OzA2Nf9xk
         L+l2xoq1ZogfejdI34zLqPfEQUjn1qBMzZ1WLPnNcmAYhdYFWf1r8Y6OaWl6CSzsR6EH
         KkebDY1d4WFFI2+4+jfTiTbZ02dXc21thlNUI1MNFmH/DtipdkFljw4wrClS/p/gnJKQ
         JUyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLlqGxOfrZfaodbMKjKHBQVyrtUEd0HueHypW/oZhIi08g2WpHZz80LlJew92AlcNKmIPQtapcbc3g4g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJVVkiHPc/0FEaDQ/+8c4m1YADHz4E54kdNu1ZN0sXLJFahchhN
	40c62v2lho37c7R7IvAsTVGC/Suj1TGX8mNbXpM+QOASj94ri5Q9TL+E0FoM25Kvow==
X-Gm-Gg: AYBFou3AoUXIKhfTFOkMm0fSgbHKbMT0Lw6rRTOrQmiNmTO6CC64SB7RQiqBfjoUtBb
	2anlX6BqjsmoZ3HeMWiVD8NV4KTzjncirYWKiBfcIauUpt7e44lLydNLAB7eoK9tEs3g68eDPun
	cka4R2fE/fzC7gLt1enIzfI0p8fWNRfK+/pzVaaNx9COguUvBIdk9zENAh72xTqk2/2V/FiqAxe
	Z2kdMzQE7ZLmPwL9A5jMs5FmCvMRha0cWwNs77uxTN/nsc3d8NYZ2GrWuQcjUmLGnXj7d5WbRol
	IUMzVTj0fPr9d2tFSp5K5ZVskd8reGzz44cR9EKOai8ESAxZTe6/UqdKX95Z19RtjuU5+5302mg
	2kBtrBAr8Wp62+yqD0MQUAl0CNhnvPp2IkQC1p2/fMeKN9K+y8LpqsUclmsUgLhnnJnj4v8QLes
	i8U/0KUyAe5D0bPjfpqf4Kb9bEQH+FGyCrKdNCFHaOiiQZsvjaAHyHfxkBi9C5FBz/r/cGGw0KM
	8ySpr8yi3hZfOYqRRxBNAbWqpytvZD6LcG2xubvddPEjZsgl+/GtogM8n3XZW0oXRUquWlRGpVI
	ic6AI+6NeZuOdXmaEiSCWg==
X-Received: by 2002:a05:7022:150d:b0:195:9228:50a0 with SMTP id a92af1059eb24-195c74c48c2mr1343680c88.42.1792726155374;
        Thu, 22 Oct 2026 20:29:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:30e6:10e1:f7d3:a06d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195e5163e7dsm2445013c88.2.2026.10.22.20.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:29:14 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:29:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Geffon <bgeffon@google.com>, 
	Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Message-ID: <atrTd8REbAo-OH5f@google.com>
References: <atlt8YGuSxgRb5uE@google.com>
 <20261022232538.978-1-hdanton@sina.com>
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
In-Reply-To: <20261022232538.978-1-hdanton@sina.com>

On (26/10/23 07:25), Hillf Danton wrote:
[..]
> So the decouple sounds like the half baked croissant, HBC, the
> Eric Dumazet dude sometimes is happy to deliver to lore.

I take it as a compliment.
