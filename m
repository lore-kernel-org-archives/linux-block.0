Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657802;
	b=1hBtCfRL5JZgqEeIqRZdt49dU2DTSvElncs7NCTGVJekkGY2fFkeO0D21GzUjcyA4bAV
	 WMsZCcbm+XbUIDrXOAf4xaFW7pIrphsu7UG7auDQYlL9ZOfrm6T2t1cv7gcFSdXww4Qra
	 UL7gozEkOgeK28sy0PIznf+2MM5ayyMnJNEf82dFCYJq8xO3mEbDM+2DftY12652M1BU4
	 YZQzJF4ShFwtJzARaCoE+yJYIenYnq8H929EWq3nZi4Ph8kZA6bkalQ4RqzzDwYYk0lnk
	 JxPUQ8CcWmDcnIPJfBpF9KxW2wgHIxkPRACwop+as3Vee3tzXSpZ27cNTFTR3T2hRQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/tpzHtlkGwh77klAgQ3+7vDN5VnMY54g4sCcJN12BCU=;
	b=qD52Sa/sJ546BxPCMYdhAqJuYibp/EMBOpnktygcDCT5y4Ui5tUNu44M871XQ4/xmZPl
	 UiBs/qcgU51RdTqFL+8zr4O5psV9kFkH2k9/26GZ7GSNhXiPsivY2Jdc8R3lKTcOkdIf4
	 4grAmtM/BZnFZglMJjZkHpt10sHw6dOoD3cA5YZL9bf/94F7bb5E/XNLLCdr26EhQ6+EJ
	 EktYJy3vGhU5CVD05W1SaJjySRB1Qvw5j3i9QNqSqSEGRfAy8FrIgHWkjKsvIiQkfGgzB
	 yy9IMB+GCkt9eJQMti0gSKLbqKqG7uREMAcABAR826UDD09D+RWxb8sErreU/cIK5cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=HTnZrZZA;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66CA606A327
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 01:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A66CA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=HTnZrZZA
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38190551625so12732101eec.1
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 17:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795657801; x=1796262601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/tpzHtlkGwh77klAgQ3+7vDN5VnMY54g4sCcJN12BCU=;
        b=HTnZrZZAk1fimzpf7glBUawWrfz/uu9E4sN4bkzRxUwK+9JNC+YgbwMC26RHCqMaVV
         g1fAWikYyKwGlWsTuWlSm2tdpfSKYlMaqe4J+NBvOWJ1jzJWjfQHmb3QSnoQYXG8Pd99
         X2PnM1cNcu1HnNj+AlEXCYovWFuJCKZwJX7DtAQF3HyEZDGF/aM56unH5RHMBqVP3dac
         jQxzA4XpDOCLQq6+kw7Diak3FdD46upCx2ml4v0Tx91BRDlr/leBM44VeK33SH6Y5FnW
         oe6KSxmzGH9/CltxMd6DCGpdsFAFwLxUn8cFI61gpgbeyf0ySiKbkzXmcWDHv+nqIJGr
         pdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657801; x=1796262601;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/tpzHtlkGwh77klAgQ3+7vDN5VnMY54g4sCcJN12BCU=;
        b=rTEUx7rYc2nYtBKFQfq9sZGIt9GA6JChiwNVQiN/ZxCkfszvvzVOAp0Q4u7EC5v6aV
         gA6PAEO96m/fcT/QYJzGFnGxrE2P/HYH1tBkt5eIVGSxKcTgp3cIeb0OS4YfKiATxwct
         VxMIua4hlshtF0v+B2466ortH3LDJEDNanwmP33ilCo+ulYSWmSt1RBW7TmCfqRMYC1N
         GWlqQS1uvJjfEsXS+asMGLf9Fk6tXsLts7Aq2odUe3XKBUYHi7XUQvig+wi9Vc9CBGv3
         V+EDOSOvr2jWsv7FPQrcBsNBprzIsd7MAz0gMkOx+0XsUSujnz6By7AiYN+ksDo0WSY5
         xgBQ==
X-Gm-Message-State: APuU4Z8Im/xBBEdSeh2x1yi7kvfTaxSEIvOYPTTklngwGZ9PY0fC0oOd
	WE4isl1tXU6lTgVDR2wbF1q0RwZB98zMBr0pagk5IL0B3TrLEGZ9e4u2t+Sf8B8D3qQ=
X-Gm-Gg: AZFdTZeV9kp0Ohr68QOA3cdUpwCVFl1jqDiPbHpt3Kpal+sc1+Rgw8ZE95TymctVcfL
	2hd5xC2GT+fAbcSl7NaSlU7zipvlaskuRpHb/QmD5vIheLmC2Hpwf7Ngk1z8t0NnpI3dvvlbX2z
	4lJC2oXy4NkCwqCSRHebetafvDRdI+gJEvVzh06btOnrvxn/3OzihjkrYzQl7iWQGqrv6x8KXHL
	5vA7RCJvHcB3UDvWNIH/Ic1nuxhhr6IwYjGEqAxoCZAEfrcNVfktyAlFHvHd5KSPAr7uGjUCsyh
	Wf/lsJqjkFT35lXEFxAI1BsgsCjM/QW2m7/7HshoqQm8Hx4HbrAaicfWvXbsIKQuTv1fupXE5BS
	OHTShUE7sFA7x/LYMDNczYSi58e30x5HC4HCAOlZT0nakB5T1H2t9rl7u9qXHFqnPNH2IUNtLVC
	TQoe53JGoO/fMqhXa9OVrwuKzI1MNsJSqtNZASD6IKwDjCN0Kth9JZwST3ol1uHX0hDnjZW6usg
	0w/2DmjQwRoc+2pLga2D38LwR19wfNjsgi5kifmXLL7WpisPtAcCm2Y3o9vnBnqfHK78DsyVTWA
	8h771Zh2dNyiOtlE5fQB4FxZb9Co6OygxYL91qa/7zQcsyRrizvHkbnPfHUxNP1MQLuJSHVHPgy
	Exgx1lfURl1othiLb8A4jqUC/oS4GZrrUtw7vb7yTDRrLxD0yDkmEkL4vl00Pmpfpa9NAnQ==
X-Received: by 2002:a05:693c:8042:b0:379:8df3:d2c9 with SMTP id 5a478bee46e88-3856f14ca78mr21362842eec.13.1795657800466;
        Wed, 25 Nov 2026 17:50:00 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm54208971eec.16.2026.11.25.17.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:49:59 -0800 (PST)
Message-ID: <1cf30693-44c6-4761-9900-e36259082e4e@kernel.dk>
Date: Wed, 25 Nov 2026 18:49:59 -0700
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
Subject: Re: [v4 0/3] block: delay support for error injection
To: Haris Iqbal <haris.iqbal@linux.dev>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <20261111215838.103356-1-haris.iqbal@linux.dev>
 <179501806989.17649.3138860274842922761.b4-ty@b4>
 <20261120164416.GA32719@lst.de>
 <edb8249a-7bc3-430e-bbb7-243e1881a0b8@linux.dev>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <edb8249a-7bc3-430e-bbb7-243e1881a0b8@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/26 4:27 AM, Haris Iqbal wrote:
> 
> 
> On 11/20/26 17:44, Christoph Hellwig wrote:
>> On Wed, Nov 18, 2026 at 09:07:49AM -0700, Jens Axboe wrote:
>>>
>>> On Wed, 11 Nov 2026 22:58:35 +0100, Md Haris Iqbal wrote:
>>>> Error injection can only fail a bio today.  This adds a delay_us option so
>>>> that a rule can hold a bio back first, to model a slow device.  The delay
>>>> happens above the driver, so it tests the code waiting above the block
>>>> layer, not the blk-mq timeout handler.
>>>>
>>>> A delayed bio is marked with a new BIO_ERROR_INJECTED flag so the rules
>>>> are not applied to it again, even after a split.  Christoph asked on v2
>>>> to avoid the flag by allowing a delay only together with an error.  I kept
>>>> delay-only rules, as a slow device that succeeds is the more useful case,
>>>> so the flag question is still open.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>
>> Hmm.  This still has rela issues as pointed out by Sashiko.  I'd very
>> much expect a resend to address them.
> 
> I can resend with the fix, or send just the fix to be patched above
> this, since these are already picked. Let me know whats preferable.

Send a fix please, that should always be the default as otherwise
I have to rebase the tree.

-- 
Jens Axboe
