Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F51E766F;
	Fri, 25 Jul 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455454; cv=none; b=Hwx9YohUwmWIZMBgVPNhwSJ4suuqlG0N9b2L6g8XMVQHLEaIFscqdw154ycjvsLiw0+k0RtodfwmWCjScMG3R9pKOLLdLgVme31r2AosD0iuGYPdF5Mmr5BNtXh5GrXcXhhfpeeiHW5M6P4HF3qAKwf3sFX5Cs6qumJZ+T1C9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455454; c=relaxed/simple;
	bh=efRsqmiKdTfVnl5wIYBaRfnw2qtiUPPbBzsckE19XAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBWHP8KyB+ra2429IoX14n74x9J14Pua85vuKD8QaCrGYjEFEN/tiH11oKk4/UsHgNSLBOW/OxnibuJX/PXhVoY4D2ULBOpcckC2Y40I9KQjlFr6znkopNSEKlGungZnUR5VD/H8CVrFbNDxVWn1QDKX21z7KtlPiMPWAG2XZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3fl2KCZ5; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3fl2KCZ5"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bpWF81JPBzlgqV3;
	Fri, 25 Jul 2025 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753455451; x=1756047452; bh=sRefQD6SLgT5XB1Gr/GmRGut
	lvpyNP/b7Qtq1m/qCbo=; b=3fl2KCZ5odc1nFa/dVj17Cc318Nq7BMnht74h7Qe
	IIArAZm7QCmVuD3oB4NdEKm1EZLpXNIR2QYiSl3fvqCcUkKYe/OSVlKHscHR3MV+
	9rla8RX7FZv2sQwPl/hF016XTg8KY3S31HLz3PpiPfQ5ZEP+/RnzM5MSr7311VPp
	FxoJkwiOCh65DANfuLzGGASNhq40TMuIHI7+EWX5rL52wmrU1ir6jNIq1jkbk/Vn
	aMaPqV5nlc6CuGNLhLd3VNlH3shzfjWnrY09E1eyMQhQbCHBHVeySRbaRqVuyZ3T
	l594y28IugLFL9aOuWSdzQJtb/9EfSzQaXjnGld21Oqcqw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZkWeoJ6Jv9mE; Fri, 25 Jul 2025 14:57:31 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bpWF35HKqzlnfqg;
	Fri, 25 Jul 2025 14:57:26 +0000 (UTC)
Message-ID: <ee09984e-5b01-4454-b982-e5a51c05295e@acm.org>
Date: Fri, 25 Jul 2025 07:57:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix typo 'programm' -> 'program'
To: =?UTF-8?Q?Ignacio_Pe=C3=B1a?= <ignacio.pena87@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725041416.73567-1-ignacio.pena87@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250725041416.73567-1-ignacio.pena87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 7/24/25 9:14 PM, Ignacio Pe=C3=B1a wrote:
> - * Re-program all keyslots that are supposed to have a key programmed.=
  This is
> + * Re-program all keyslots that are supposed to have a key programed. =
 This is

My dictionary tells me that the current spelling is correct and=20
preferred. See also https://www.merriam-webster.com/dictionary/program.

Bart.
