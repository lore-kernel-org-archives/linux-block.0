Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215798;
	b=HVyuK5UIgpWGG4syOOgjDr5ewxtH+xQvi/9U6B+y31+JwmkE/+2FXTGwQ5wdLuebbB5U
	 BdfxD4MPzYr0Ye6j9Kinun9RFo3wjDhyaiuOcHM57SHCWWxATZSQ4GiTEBkcYyoBlidzE
	 k7rwfqjRCodKGHDaLG2PmcF5b3QFJczTGyDIWZcndE52wnauOemWe+aeKJe5RbnQL3bWS
	 Iks8eW/Ev5eCghYOZjgBpPfzfUi7yDkC8fApHKPNDoXdkYelozaj1c2dh5LgFYdvd8qMT
	 LRxhQspninHo23XZuNLnq3BXJlBDmdCccx3i0qdw4nd5BH67q563wtdV/1uEY/1ohUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=f9049V9AUPRlAKOgmHgrqtVctdDL4sW3nSIon5EWHd8=;
	b=2QI3x/q37zPMMDidxH++sRQppT5TpFwBriaZRstw8N+dKCfByfbcdCcxmaB4vsbKfoh4
	 0/vBaKoqZBdrNkm5a+hxW0+dZ6yznYa24EeOmWKXPtESqyk6KRjOztijD3bFbgx9HrvIv
	 UnOserqRKEzvk8s/4jV8WWUZfsAZDDQwdbghjpk2GvZ2fsAGu36LJcn8dgOiljctb1jPx
	 El7G/EdMOfMZwvNY448o0fL4VSgo61DEY8r5pSmyDwvlLXr+crBRPRp2pnVM/GX0TETyM
	 Pa+qXPEKn7GdtlhJ3N0Pp/6L4D2uPnwci4CR8gnfEL//Ai+mO5DZ+ICLzZhWrnTWa7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=licZOLa9;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF4606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BFF4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=licZOLa9
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-833e671ee9fso1402287a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793215795; x=1793820595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f9049V9AUPRlAKOgmHgrqtVctdDL4sW3nSIon5EWHd8=;
        b=licZOLa9oYZN+Eu+xoaLT197bguPsNc6WPFb00oJsKTnKGnG0+XYvqxqpfEoWpG1t6
         X4FFMTvB0hYkJwwGOFC/m6itxzwj1/qAjFIm/HCibVipTJWTxaq5nCAMCmPzjVf7UZik
         wQHBw43H75cnA9wp+vi7iiuLdC2FmJ0HGEQsf0LpdnEAlE22Rx9Eoc98zniblbbsMuzH
         0yabVJxCW7D73ifk7eQO36Zf1lZ1hoHBhJDl/cxHVrN34bKeMi7qbIsN+yTaKb4zNM46
         0mXmZlP+2I3Cfe4rAM9yeUhd/Sct3MR45TDFD+mjFQCtWLyjiY7KlrGi/2OPmij0QuuG
         qvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793215795; x=1793820595;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9049V9AUPRlAKOgmHgrqtVctdDL4sW3nSIon5EWHd8=;
        b=F9OzxupsPZgcmkIEoZqLcqcLt63Jv1cZULYR7cVtUoKTrRN1HAmIQJGwNiHx0eo8XC
         I20WuhOUJL+ZZzHVLZZiPdf0lDXit8oxPZziqNppe27mMVreiQtBfRQlFFdoupIx7xBp
         yLTF3hxbfHyvrz/9lElNm3e6V/c8Xka67lxHoCrKTSezYSSWn072zeRr3yLzdNIJ0pfD
         Jqp/3SJwiW8HQPW5wdtonKZnOiaD9pJQiNwsv76QjgjKzPNZkaws9YFR1ZzmNwTiSWRV
         oxxf61QpD/8p0vuFRFww4hBSY9fJR2pQ0HuAY/FLOrXrajzmRSi2lvz3bvZl+EEWOsri
         ZU6w==
X-Forwarded-Encrypted: i=1; AKwUvByPXz1CMSIwfAPEo2eI5jhyRSR2hqrbGFw2Oc/xYCYOnyAYJ7IMweFU91NIr/drh/ZcCwVWjvoMPyuzeA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJCba2IFmqiMMf/HsZmyd/CiTkxJ+aNFhbzgapPNtIQfqeYfCik
	u2VdXxzfVzRXLW1LXzm1ZBO/Se33WmkSAF64MNNsSGdWvQrwjQG9grBXwuQIxcP4Nyk=
X-Gm-Gg: AYBFou0eIdN86hx5z1BGH71HwK4tJQPc63DAM4NbnOslgeqqQmgOTZrKYVxCYpOxgtV
	VEElx3KbG8hAFjbsXwVkcGVyYILdjqKeiZw/0/M4VYOQ3anYGZEedBEasmZ7K4u4QM6sVrnRjIS
	iK0edQPLOlvyfwIZn1ulOrXTnA7GzFFfng5eYZym/xC1tL3bIdnwiiLMFV3BX7TtJrI3ENJbHfo
	gxXycX3WZgItXfmsXQvoQr9k/qjVhCRhNLpvnPfS4zQzR9KyfWo/KrCVyDMtZAd9QATjX/r1Z03
	f8JvGTblNWHDkfol27qZVm7MA2h4iI7MLd/kAkNx8CW6qnPDoLgY7evfc0QNH8Nf6VkGGd6uEeS
	9yLoAqYNWive/gAbcFymhFfYbHeRSSJ0ZeCdgpeB7WOfg4jTsyiIUSfCwWdMTyT2tqBiZzLSbn+
	2ZGFfVGdurmZT3qLUsuvemW3BaDR2Um5WmJPVOSpIljwUuE2aAEACm6TLII+pSiFcCCUKKlLr2s
	jVt5TBAPWrUbfi4PyY+1I1PoxZ6rgkyMxsTSTdWtfbW7wxsKyDkaLpF1NgStv9QqZD61dVQcCuE
	wXDt7MQgidAwSlPBACqXhW1nfkjs6qP60WG3nWp1or1fE2suafo/olnr11Q1tqMm8IVTmW5SZWe
	x/+VzylTEfQ==
X-Received: by 2002:a05:6830:2315:b0:822:b69c:ff69 with SMTP id 46e09a7af769-85ac0804a61mr2905242a34.21.1793215795564;
        Wed, 28 Oct 2026 12:29:55 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85bf6e90bddsm884178a34.0.2026.10.28.12.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 12:29:54 -0700 (PDT)
Message-ID: <3c5a116a-394b-44a1-bcee-0cfdcc43712b@kernel.dk>
Date: Wed, 28 Oct 2026 13:29:54 -0600
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
Subject: Re: [PATCHSET 0/98] Various block related fixes
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <c16356fc-662e-4939-ad76-355f3a62ed4c@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c16356fc-662e-4939-ad76-355f3a62ed4c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 1:22 PM, Bart Van Assche wrote:
> On 10/28/26 9:41 AM, Jens Axboe wrote:
>> Got a giant pile of stuff dumped on me, and went through and did some
>> vetting and, particularly, commit message rewriting to get it to a
>> somewhat comprehensible shape. If you're CC'ed on a patch, please
>> review it. Feel free to queue it up, or reply back why the particular
>> patch is garbage, if it is garbage.
> 
> Hi Jens,
> 
> Reviewing 98 patches at once is too much for a human.

Yeah, no kidding...

> So I asked an LLM to take a look. That LLM identified 9 must fix
> issues and 15 minor issues. Please take a look at the attached report.

And likewise, reading through 60kb of text is also too much. The plan
here is that people that are resonsible for their area/driver/whatever
will grab the patches. Hence I think any kind of review should be
per-patch, eg reply to the patch with the review. I'm not going to even
open a giant text file... I might, however, read a targeted review of
any given patch, but it has to show up as a reply to that patch.

-- 
Jens Axboe
