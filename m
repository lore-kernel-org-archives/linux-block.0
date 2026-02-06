Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAE26FD9B
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392202; cv=none; b=TcDfaChCwgD2UfxQETdGwB1zXJmw6Ya9gSlqoiWSFQgtBSV39RHydi2r766veWy7CutycLKDG58rRPIVTByLJV7t2t4rdxkcR2G1VLpaNgjY4LkWzBljicEODrHTsa2udgOxNElg8RhWpCxr3xxNDytmpVvClhWJQp2QOIVAUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392202; c=relaxed/simple;
	bh=NFdAfMMWwELLeZLgcJRVnBHD94LYN6ukCPKmMwDHBIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJB/wu0+Rn/1d5IKuL06iTDilGyBGRDuY3uUSUC5xZYPm1T9oFR5XBZgGImsyhVbKhgMK0JbTxQ5MGXDQKalXoZRaldKbmgsHo0TJAg89wXUXiq36Gttake0TwNT6BfP9Unu0hFkjmUoTIDh1QsHLkT5sGzEKOV3XLNAdxnzwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3Ju1mpu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Ju1mpu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so18241275e9.2
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392200; x=1770997000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TdI6n3DaBkYtE2eKsn2+fkmcYgbAkDuoh7MibNtFd1g=;
        b=D3Ju1mpuYWMR0KbcJvoWV4GTueYNUgDFZHGQ9P2CBOgsoLJNwA33BMEIHWECVXD1up
         UdiZC4fDtJgiWlXlxCVoxgeiUrurkhYgM9oFQf6fmCuH22SUS8ZYpMIzhueXq+S2Q0W3
         gxTd/y9kM6PVJXD6abNvscC8WgZozJ07jNXa/L3UsQbx4QqNpmFZd2LCtXgvR4yL6l7H
         9lUNMlZ9FQeC4SEgY4c0t2+P8TbKbP3lxPU/z4kD/kMj7rW1QYopcEtzqQiYiTRPVpZW
         4vxfFiljPZwqmU0EXCExDHCrdEjzQZ+mrEUIicCcLZlTOZHqeo/Lff+TbCTu8jPw4OPQ
         fPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392200; x=1770997000;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdI6n3DaBkYtE2eKsn2+fkmcYgbAkDuoh7MibNtFd1g=;
        b=T0apVt/Nd10Wq62xdcd3Zv3hQqZ5f84IMYUK8QZqS4DM3XRLSc6elhlAV2Dx8X1xYE
         jlAXo1J6gGS3Mr09z1Ju6OwFqp3cbBWOCwAUPezow+yh0/2fGt7leNhc4ksaXuWYdaVT
         KhVMc5xDLSDaSrf3UPCD3C9tyaGUUkXrlnEtA30wE4aOBlVYFKBShg7gcE5sdRRFIUH/
         DdjNs7VmHmWQHwEJU0WFUJlOX0b5Q3BOcPZFRMPiX27/HZGcVAiGaU63e9gQtLggp97g
         4oh6RYMBeFXvn2jYP2X2fERj580E4cWlWDMf9hJhXNuMxgOkFXFGTEsRKb5ikD6oXUp/
         3Gjw==
X-Forwarded-Encrypted: i=1; AJvYcCW8lJ1C0BBJZM/ipJGBRlOmK6zYw0BxeaIFUcEkca9I5KwYbbUObqhvSIKkGS4qVGOFVGdldh5p62e4Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzozDZkBnrn7JA5ASDX+L7DWZ9amFUU/GfDhRaNGA9deSlCmEDe
	IYf0UGDTNdl4ST5Vn+FBNYEcWtGljZ79nPXbCsyp+82PkqwmOODuBB8D
X-Gm-Gg: AZuq6aITAWz6W08gQYUCHkKgRThQAH052hcKVT6lROa9/TLYc9/wbC4KN6ykyTxAE/W
	unKYXqTwHgP/3kuG7aCuGSRw5pRZOUs0GSvysqNVqOk038XGXYQHJ5WdLcovVrquIQFfX/+54rG
	DTNRvGOTczjBOMPdeAPVV/m9acz2objrPKPw5VqhQknN3PnAnnHkx6D2ng5suhYTegZoOIzEGrB
	DrjbJ3k7aGK6bNVDR7FNeXNe4SKl3ddOe29VLTQbh37PM9T1RsJhm/2fNOYrD85TaNEJ8cKTSUC
	estmhvXAdtoThvWVF6tM3cv5iPrUIr9FULH8qftcr3wYbpJdOtKhWepBKdXlb2+3rr3haH3DzpP
	C8G4rZvQj//GhwKQAzFbtwH7V0odyQP1RiXpBjc5DnoUw2YD+INvzJ9YaKZIQsJICrL0RepMzuj
	mf/fdXbt6Dp8O0SlyHAd5ncLELztbuY1XOgB19
X-Received: by 2002:a05:600c:3509:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-48320214735mr45472615e9.17.1770392200015;
        Fri, 06 Feb 2026 07:36:40 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd211sm6617228f8f.13.2026.02.06.07.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:36:39 -0800 (PST)
Message-ID: <f03b6bab-229e-4972-a55e-10652fbf6cd9@gmail.com>
Date: Fri, 6 Feb 2026 16:36:39 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] sed-opal: add IOC_OPAL_GET_SUM_STATUS ioctl.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-10-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260206141804.278721-10-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 3:18 PM, Ondrej Kozina wrote:
> This adds a function for retrieving the set of Locking objects enabled
> for Single User Mode (SUM) and the value of the
> RangeStartRangeLengthPolicy parameter.
> 
> It retrieves data from the LockingInfo table, specifically the
> columns SingleUserModeRanges and RangeStartLengthPolicy, which
> were added according to the TCG Opal Feature Set: Single User Mode,
> as described in chapters 4.4.3.1 and 4.4.3.2.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/sed-opal.c              | 159 ++++++++++++++++++++++++++++++++++
>   include/linux/sed-opal.h      |   1 +
>   include/uapi/linux/sed-opal.h |  13 +++
>   3 files changed, 173 insertions(+)

Reviewed-and-tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

