Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14815284895
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289402; cv=none; b=Ia881ZVBqDs5bVfspSOVZ+2nuLW7twP9nWoYn2SjNdTbrfPd5IkpIXAY4uVEBxAvOof4Zq4l+SU9zkJcMHkVdhRc7+1derfZ/n5QxzLOLzqVnnaIAjgSNZbFChXLCJs/3+3EwbGZBdHEdbZUeIU/3fH6A+MtBu+fidGE+JhZnQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289402; c=relaxed/simple;
	bh=5ahPTF1dO7WZVwcWo+M++mxZq6PDtdVjVHOQ5rmRnWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEJzbAmY1i5Kn26LCAGRoRgTXDKO63agVBkXNj7+wuR2KYBQ3DNq+im6Dl2ERmYC9xyIGHQScGRLtwe9HqJ3gdaadR/PY+MEsfaucQYSO/BNsSaMtreNB/ssKrRsWTFzkgpiKdWgcTJjNVIt7xs92/HyPNuwkuTi/elxYDwJ14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWEVrkfC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWEVrkfC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so8562505e9.1
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 03:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770289400; x=1770894200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r+kACTt6EJL1j9YGnDxqpQoSBP97ve7DYqzeXaZbiVU=;
        b=KWEVrkfCN+pAEFaQP7oMKsp/HRQZ3gOZvEhF3m+VmeJjQil1zeb0JqkRMJgAHb2rMI
         WbAOj2GrAbyMKIseRRBNvlpGRjsor0fJMbC2O/PgjZQoKDBW+3HDEoRHpYEA4abZry5c
         GLQg8GiqznYOOxqOt/OUM++0HRtH+GDwYf/gzZO863/GY9SEFElZwnVYJEi0bOdJbmqp
         TpdArlVzAoHP5PKoTl5uHT5P7vsEM0Va5Fra2F03nIdWf8Ghxq6rV2IOpdV8FB+a1/Tc
         jm59RlcoOs8/+rCzPP16e0PIAmpq9rRbldL/Lnc1eTCJZ4zwWEjB+bxVGxdGiNBNPVwO
         hGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289400; x=1770894200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+kACTt6EJL1j9YGnDxqpQoSBP97ve7DYqzeXaZbiVU=;
        b=loBcMQs3SrQ8XqIQpJovDHxK+l+j0Y0RKTKKIyH2/44bIJ4JaFWWCZ1xY5hN5FdjDV
         AIxZAAxDNRHhM5EbLnN/kREosmN6yi5FDM0WQaYQRebk0EkCDKXv1JCFR7aRFu3EU959
         hgBMmOP3T7bCrZz300msbiY/gnJUswAqAX1D2kHsMJduEDezOgKDA68ylZSiOQkRwIUm
         zYp+huK7CCbJwqrATIX9uePzTxhD801jUTk2qPZzqIyANGzzEu0a4SEqGS/ziaM8MnjD
         HI+erHekJCUDiSZ+pD6oAjeew/BspytNko+xQytVnNCyOCltJ+rhKzx9DwSy67xKqiQp
         PwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5MdCuFEIxMHr2Nv0XacPgzPTAbOE6Sd723VWBzwCuerFxPPpZpsY9n7kw3YKUqQJB3X6VuXAPNdEdgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXkbvG+QjF8lZZtg3E4sMQ7jbyhI10C5hzKhn5Vdou8je/yYo1
	fj0G8VjGy2w0MmVtrMbbnd/qMxjtoCi6qDdkiGEBhgJ+qrFkfnhRH2cGxW9g3zHn
X-Gm-Gg: AZuq6aIcLChCaMnCsG7AAUPI0It/f1H6QtJeUf60FxPgcO7WxNRuV8/E4PFbFnbutbz
	t1+RHEsbmOxH7wBeN3frRz0sqVtSOhlZP6MqEdM8ltqWLTbtPnCElw2D+Og6U+A+BPZGQVSWUOx
	j+gw4urQJtnyHQ869FoVGQG2xIYEA2WUErpmJJPklTlwRl+b4r3V3CPL7EmC9ERT/ZPr9h9oPfy
	FtAPH/MBNa0TkkgM63peDV91YnGKcSUguo/TPb+9bw6bwGCQJ92Z9cCaNHt5Zeu1PGfU/v2Ods2
	MjrDQAa1BqdE2tkdjZ5N1tLdSpMYCRpLqfhIYJt384dDQUJ/kk3o1kFi6QbmSm/6P7I18bfC4Mw
	ZwT3OQIb4dljYWslFVqa+djka5lhBRKa0oobnWRBw6ZAxOKwF8fxc9m6HCurQeF2WdQjNx7Sw4N
	ufJO3iL6pDGVebn+U=
X-Received: by 2002:a05:600c:c4a4:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-4830e98a84amr80983355e9.25.1770289400350;
        Thu, 05 Feb 2026 03:03:20 -0800 (PST)
Received: from [192.168.1.27] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm46340715e9.2.2026.02.05.03.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 03:03:20 -0800 (PST)
Message-ID: <7ac95fb5-b206-4bb1-ad75-20a5000cd5f7@gmail.com>
Date: Thu, 5 Feb 2026 12:03:19 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Extend Single User Mode (SUM) support in sed-opal.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gjoyce@ibm.com, jonathan.derrick@linux.dev
References: <20260130162527.570255-1-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260130162527.570255-1-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/26 5:25 PM, Ondrej Kozina wrote:
> This patch series extends support for TCG Storage Opal SSC Single User
> Mode (SUM) in the sed-opal kernel interface. SUM addresses few
> shortcomins described in the chapter 2 of the OPAL2 sepecification
> extension (see below). It better isolates Admin authority from User
> stored data by taking the Lock/Unlock/Enable/Disable privileges from
> Admin when managing Locking Ranges configured for SUM.
> 
> This permission split necessitates separate ioctl calls for operations
> that previously could be performed atomically under a single authority.
> The series refactors existing code and introduces new ioctls to support
> this model:
> 
> - IOC_OPAL_REACTIVATE_LSP: Switch an active OPAL2 device to/from SUM
> - IOC_OPAL_LR_SET_START_LEN: Set locking range boundaries only
> - IOC_OPAL_ENABLE_DISABLE_LR: Set lock enable states only
> - IOC_OPAL_GET_SUM_STATUS: Query SUM configuration status
> 
> References:
> - TCG Storage Opal SSC Feature Set: Single User Mode specification
> - cryptsetup code using the extended sed-opal interface:
>    https://gitlab.com/cryptsetup/cryptsetup/-/merge_requests/832

I have tested this + cryptsetup userspace on my collection of SED devices
(some SATA, but mostly NVMe).

There are several broken Opal2 implementations, as vendors
usually refuses to fix it as it is out of support, we need detect
"supportable" SUM.

Anyway, kernel ioctls should remain simple here, in general, LGTM.

Please check comments on for separate patches.
Once fixed, I'll add my review/tested signature.

Thanks!
Milan

