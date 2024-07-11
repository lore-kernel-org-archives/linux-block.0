Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46416E862
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721144; cv=none; b=unvbFt3UbYsQW8Q88eq+UUWrbXuK8N01UXogVwCini6qPmBiLbKwjYg98qhncBzR13KsckujX+lh1148zy6Zvi0Og1eZj4Au3BatGSuoHqqNvCsnsiCSlr+Mvyp5aMSTlK8UgKLFcmv8qYt7qXQhZVuMlhShltJRmfOE84U1asE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721144; c=relaxed/simple;
	bh=CIQamZnkp/Drp3uFIvs1O8V/19RPsARPKSrlJBJ5rR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9Dzl3UIDTEE9Id0s9S89fMLDh3N7fMnRTZdPLNCQWGL+I58umTxBNM8O362P0vKOZUoBE6JexTYEu/1/BTh+FZnqk/+j4dBK1GOCj9nmBmYkOp7LSHbOLHp+ItSq4P0hnDamQI2/YFRyRzJ4opbb9aqEh5THWiHKO4L5sCepmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YDOkEgmA; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YDOkEgmA"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WKjMB17KyzllBdg;
	Thu, 11 Jul 2024 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721140; x=1723313141; bh=81V/jkClN1/M74/EXET4PwyF
	NjBShrfXVBFcZc8Cre8=; b=YDOkEgmAtt5mXb/QLVhV5VusWPPE2VTpI0gmfHQS
	gYCMuVQc6W0vm/VLXMA6slAnvsVm35QggFC8O6rEOnreC0BL+euoUYRCGXQXTLbO
	KTJsCvxVSNGlFHkBC2T6kPfLMTi3obBRlOFCObadIIACSTLMZPs3Ygtqq6vml7vH
	9XFDVaM/Cmv1geHiaZDLO+AD6uJXXmAhVJgyrl45XeypiqEzTFz8dBpub95y6a/i
	DAnlHc8raIDtwayQ7GvfVaMKSfwbLYzfr0vyyp9OZnyHpUCjD9I5j53bb1yFugeN
	9+SL+iHYlp870g+982/5b+Hq1IYFo6MNwerAVIHNWggZlw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3clHxSnO-NXR; Thu, 11 Jul 2024 18:05:40 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjM83HYKzlgVnW;
	Thu, 11 Jul 2024 18:05:40 +0000 (UTC)
Message-ID: <3708bf11-ba92-43b7-8c71-30b2dff76c5f@acm.org>
Date: Thu, 11 Jul 2024 11:05:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] block: Make QUEUE_FLAG_x as an enum
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> +enum {
> +	QUEUE_FLAG_DYING		= 0,	/* queue being torn down */

Please leave out " = 0" since it is redundant.

Thanks,

Bart.

