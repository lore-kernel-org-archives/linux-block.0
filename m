Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DFC29C33F
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392124; cv=none; b=mytqyfsvau+8obtwX7BdfxvvfP/DJiucck85MRlKb3yWOPr1Tm0hXmkt6x3BosrKfETXrRSrpAOgZjc0BSaHCRVtgYgjlpN9ZVMZsy6vBmkhE8Dw2fLnWTgvFwh0iZm4fGXN2Qzb+lAgsJnGQAqwETtmYQurb40TNf7xFnn2nsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392124; c=relaxed/simple;
	bh=TUqhTjxSmgbbOSmM3LshGnX/fx522BYm+59TnO62gmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXqKnZ94aSP7rhubT0wEBCBBe6n3iT60aRSwySThgItteYd8VXbdX/jVnMndgBAP8MtISu5J6q1pkww1m78SvEcXuRQg78o9tju5ukXnsJIdeQZ7L+5lZKb7ONWd3NMtoqhk+feL/u+ndcPaLyw/R62PHzhHXYYflM4sWCXZTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7DM9CGy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7DM9CGy"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806bf03573so4673425e9.2
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392123; x=1770996923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tNiBPH4J6dHQJPTJqUC2sY6lgQ8YQLxjhwEYV21KKnI=;
        b=W7DM9CGyJ8sOihmpM1f3JThDqQFsdvXUI38NzgKW1wVvhtMiAjS50UdvtpDeGnsrmd
         h7o31q8wwm1uf6Qzfto4v01sFPL9wzYUGtGH1ywjMYAXTXQM4DSvpte1niAeN75FOrgq
         KbsNxeZJC7H+Or5bPe4eDxlGDPpz2mSKAwLitrnE0YyAwujr7vqt0BCC+EhGMfvFrGyO
         ikR9COS8QG7rTLPEc5oIg+nefi5QQDQ8BgdQHmVEChuRqF69sJ11JZxCLtBIsAeKmaxy
         hA2bZriLIa79/ChJMe7pYhczcBoZtkezXi2NPUiF7c56aT5rfqEM+BTLlce/oImW1tWm
         hotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392123; x=1770996923;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNiBPH4J6dHQJPTJqUC2sY6lgQ8YQLxjhwEYV21KKnI=;
        b=xRqmjdAr8yKS0saiXNcm5dGOMdNlCXnTluAiC3aRu4kyhNHjU6Y3nZaT5Iw1UFZ13p
         /EI4OAv0CPG0qRBhe6Wn9Bb+0OgOJLvsZUrIwvOrifm9plpXwkygJujK3nywl2ZGO+N6
         iHcX+PFmisdIaV1iOmNRFGUMXOMR4Jci1hEcnq/9znq8RLz8wWzVGbYmo+mirQDsmgrU
         1A6L/gfeJF2dqDiFEtWZH1HO3LSE9qVPukJeCBF4BBujIfcj3ACm3k6NM7Q1CXZKuxxo
         xQiyOgr0w0gl6boMZPappSBL8D/P9fdZBT33w/8dlLkLS5vWuHY5ds6fAInuMwFpRN2z
         MJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyLYiL1EZ7g5QA6z34JYaCWq/RYeJecVXK/kSDb1UDezGeLGT2FNeh/ft0jgfE7g/Uos6sZCAdyDtqwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBd4mzgyuv3rT5fVh7kWRSETPAfiQMKdH4fkChwafcpOxQvV4
	JJ5kWm7G53D2fPmu6nhw+NbeIlgb5NEjVi3IWhKqVFsHHEwmH7A6m4SN
X-Gm-Gg: AZuq6aJcNPJR7MvX8gA5T4xo00/Oa8czjmexkEsw+3b3QiRHOn9eExw01hxe1BNJPmD
	QNH/wMJPBPljrLKimJ3kfG1YGsRCmI2k01tfEhD4jWriCXPAeK63+I5kAU2h3bd7TGByrqEjSSC
	uPmpUFQWcBgkuxVxfEG865RN2yKr/QWocCsL6M2UUtV1dck3Cn/r7DPGGPoUqcL3qj4gCn7SF8h
	F1CYtoApDdS1uqtJekLjqkLTJXMPsHjHeZz7XjfgYCP/DCnBFVClLda6fOIZAWPVPvZMPA1WxGQ
	BcP7XrT92VMQicW7WEfpK7CwoEkPNxANOfTxw+jKAqZQiNN+Ra4DBZpFu+ZLhuUrBJHlRyId2ZZ
	3kOW3yt18w6OEJioUcjiatXHyRAj0E+6Tj2zCXV4kI1EI/o1QXnwy4QUZCejWd3YzZf+PLQAUZr
	zophvFmUzoQl8oUlQoVVjeg2Ux/5SSCthQgSyn
X-Received: by 2002:a05:600c:4f54:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-48320212d61mr44561405e9.21.1770392122665;
        Fri, 06 Feb 2026 07:35:22 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832097dbfbsm20144345e9.9.2026.02.06.07.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:35:22 -0800 (PST)
Message-ID: <31c81430-0317-417e-a491-048336035a93@gmail.com>
Date: Fri, 6 Feb 2026 16:35:21 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] sed-opal: add IOC_OPAL_ENABLE_DISABLE_LR.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-8-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260206141804.278721-8-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 3:18 PM, Ondrej Kozina wrote:
> This ioctl is used to set up RLE (read lock enabled) and WLE (write
> lock enabled) parameters of the Locking object.
> 
> In Single User Mode (SUM), if the RangeStartRangeLengthPolicy parameter
> is set in the 'Reactivate' method, only Admin authority maintains the
> locking range length and start (offset) attributes of Locking objects
> set up for SUM. All other attributes from struct opal_user_lr_setup
> (RLE - read locking enabled, WLE - write locking enabled) shall
> remain in possession of the User authority associated with the Locking
> object set for SUM.
> 
> With the IOC_OPAL_ENABLE_DISABLE_LR ioctl, the opal_user_lr_setup
> members 'range_start' and 'range_length' of the ioctl argument are
> ignored.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/sed-opal.c              | 24 ++++++++++++++++++++++++
>   include/linux/sed-opal.h      |  1 +
>   include/uapi/linux/sed-opal.h |  1 +
>   3 files changed, 26 insertions(+)

Reviewed-and-tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

