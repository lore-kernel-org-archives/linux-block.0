Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36826320CAD
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160668; cv=none; b=s8yD7PGOapqE86E2twMLnmR03nu8nKY2fFdmNpFPzI8Jg5ijn++MLltffYPzcsnrTlhVHpmpfhV84wp39/nTqY8xyTfzhLDCh7n1iKf0aKXwIbWlv0OLqpAq8JMc3e0GgNV4VRCDIwJuASdjye/OvIK1FVn7lAGDgVHNrHSEYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160668; c=relaxed/simple;
	bh=k8EhROUjYERP0Ch4nDtJyEefEgaAuRKiF+48GLDuoIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6rDbxLKk7BeKIU9CS+J3prXFtSmP3qPrwO2LhtzG5wKy9+QJJgRBAXToAt50odOjocg0NZ5jyIv1j0kSfZ2sHmwXbqYp///6osKf29EdFdB1z3dJ58LEnkHb4OD+Yg3Z99YZx03W5aXsDwhoGJ1urkA65hspvWbNONL9LCtUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=am749Cup; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="am749Cup"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f036b17easo2894244eec.1
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792160665; x=1792765465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81TJiBOlLcOCNf9MZHKlyHWBdbkiRUw3r71ZgsqNvYc=;
        b=am749Cupdy1/Xx6BqDu/X52fPHbpjt0DGHUgxsSiiRxL3189ikXXRVRYO1par6BwLl
         9DuBgenHJNape3VUqGemLPM58oZk30fBDOWvD4ctyEYTusWcHRISrZpM9TFXuf1PGxFi
         G5zJLfXnag1hi5QKgdqr7ywhW46SCdJK8amGxgxJ1lCEM+nf2phW33F8v6IU70Kt2fik
         2Ssp4Ziobog6z77u526d485qGhGwvBotfXlfvRMmlcFq6APo52hNet7a96I1P6tidOIg
         pgAyeVEIs3XnPwHpuJgqKZHw0iFI8eygXxIBpkH/Waa7idGqQWZqTX52HnioNQ8Q2ztA
         r5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160665; x=1792765465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81TJiBOlLcOCNf9MZHKlyHWBdbkiRUw3r71ZgsqNvYc=;
        b=rgx+V0wAYSB9AevoplAMNUQP+Sij8oxa68lP0BN/4rGTTGErqyDMcc//4AkNBS+HfC
         BIy18akTWa6Bkxh9YIkdbhKCgdidSzgNJal9lyJHOQa/l8Ct5407ysa8rRCjMHewmsHo
         /htn63R/hnEP3SFwgO9v/mhlqC08JV9z59CyKVTVZfL81Eke4nTIc8qPeGcIr/SAFOVl
         XWlCgB3CyB4l2RgwcpBWWQaR/db5E1IaFTPFmXkYDJJgXMrS1aWdodR+tAX8xUbSNHT4
         XYoGbsj/c5pvpYN11ZohQZZdyRnXl8g5+O+j8swjQlvanI+IheX4DqO1yq23kRP16lBS
         RDMw==
X-Gm-Message-State: AFq9FYK93k1V1h15mTiLB/CQFYY+3kl2pTfRHq3CsVXpUGhY3fP5Wxvl
	8UkMVw+SzADZFOBMR8eJutL4FN8YolyWKl2LA/9EaJIKLF+73HaEexICpRO1vqxgCGc=
X-Gm-Gg: AYBFou0URQU5dF/OTnbitUaftakJBycGytpsddIW6DIR/tBqlzArD9/LWic5uysyrdV
	AzBV+cyCYB4bWHmJHKVXpAsfycEkFc/gjq+oHLVnU2LyT6UFTR/rTvsaumfiSB3kRSld9vaaf5p
	KWRFfrNDWEfG0LheJMSw1rX2IbkH0XVg1Ia/GgW+QG3DT42PuGDkyefJ/e5C0+gPVgYm8WULHco
	wh4ZzBOAx+CnU1qf0bbtLdxtKiXLUa0ARp3SJt4kAl1swMDMEXUAyeP6U+Y0CNNN2fpTHn6Q/CC
	uVzTvxl92TujWarCH8mV8JSZInkWhfzSlNEpLwULkz7HfUoJVv0f3b4DNa8iDdCLRAo6MsnVvOQ
	PF1ZWNC8gfhFDX8Kdrr6U3L/ddKnqdvXwB08JZrfrTwEadZoLkU2HP/iQ4rNoKnS1eQpB2uil6z
	w45tqS0MqAeINobKG+l1HlNnKC/N/cot0Y78EZHtU+E5vUWdvb04wuzKO+4/npVOY84KmaSqzdg
	UZ9C6+XwOuhkoENlnPCTB1eWrQpRoAVVcAMrOWqL2snEdBlqAaV8D5VpA==
X-Received: by 2002:a05:7300:1343:b0:351:727d:b9c2 with SMTP id 5a478bee46e88-3537e05bd1bmr43338693eec.17.1792160653373;
        Fri, 16 Oct 2026 07:24:13 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360819bc569sm7024523eec.11.2026.10.16.07.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 07:24:05 -0700 (PDT)
Message-ID: <4104c9c7-2df4-4008-ac2d-0c999bba98d6@kernel.dk>
Date: Fri, 16 Oct 2026 08:23:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: print device that had errors
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 1:30 AM, Johannes Thumshirn wrote:
> When testing zoned filesystems that span multiple zloop drives it can be
> difficult to figure out which devices access caused an error.
> 
> Prefix the error messages where we have the disk available with the disk
> name.

I don't know what this is against (doesn't say), and it doesn't apply to
the next branch...

-- 
Jens Axboe
