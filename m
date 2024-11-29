Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C1381BA
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890383; cv=none; b=bFXP6L/EMBbjMsNMsqv+LDSBH7ly93o+vicb19Xk5iirGHCytXTdjeztcDiX2U/hN7qL6TzzzVhclTEMTrPbBoHPqo0vrC55ctkjhPxgPgkwwEsSrtl18Y3AFfYjQO9I1GLkabKiv0hMV5/4cxkT4oVcJPXigM/UOpIqoMxX4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890383; c=relaxed/simple;
	bh=LF/v2APQUH1XNOf6nW5RuGpUkrh2C2KCHmydIhInUF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKjsdU+ZeYPPj816Ms71rD2/QaEA5mJKu64zh2eqRbGzd6e/Iwl2hcfoGMZlaLWkAgLBoR5LIalxyKdCrQ+5kD9TEvQjR0OG7/d2UroKonV3lPS/FDEqmI087PXLHPNCaSdMl4lGuOCivbzds+t9Toku2kIaCSHV+5QkKqsdUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0GV1sUv1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0GV1sUv1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so1766768b3a.0
        for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 06:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732890381; x=1733495181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpdiAit/JMF1gHPpQc8Fla49evuVYP+pTUnVRIxMK3o=;
        b=0GV1sUv1MMyWWEMgQ3rStXRFIdububnbj+tWsh1T1Yp9xziwvUqbtDxX43GaisKoe+
         jD2S+5OLF7Pv4T65fkJXaX/P+3IUYmPRVgApI5Z4u6ra+P3o+CLGEBQ3n0eVVuISubAD
         EUAnWK1KgOiUnk9b58q6IgKkbpX6BfgC6cCisyoQPGuJPi0RLujhRHf9ebVnPGHbmi69
         UUEKQkuhdy3sjbyTGaUec7CRVwLxTBqcKACf4FM4BTGcgGrdTdehfNI5xgWV3akIJauS
         SbiV9EiQz6jZDAud4S8Wkb8Pxdbs8i0ERXDV4XZuPChcidODhsLIW2b+aVEcE/3cv4PK
         9kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732890381; x=1733495181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpdiAit/JMF1gHPpQc8Fla49evuVYP+pTUnVRIxMK3o=;
        b=doGHUVDRMzpHspfWPjTPzVJ0vc89kqAHoIgtPfhzlmjcmsWz/rOkSjoVf7J4d1nObf
         COGP1U3yFpxcm+MOw5GvjfsTPdcJJuSzCR/dmXR72WMbM2Cj0AAdjaMyZ+FjmOlaXwbQ
         dx2WGWTzgT90Gl+TNUNTchTYQi/QtpeSB7on/o82ns1j4tKRGA7sVbQj/E1su+FrtgsV
         iSh/ffjDkKcQJ6ZSP3scRCAYK0uNIHTRdVRK225fPCdmLe3mWslOKhrortofQ9HlliSI
         d81zk2pRak77t/EJanuwwfmz6F/dSiimOYwwj7c0rad2vn6wI3xBOYJIowIjh6W76f32
         /eZA==
X-Forwarded-Encrypted: i=1; AJvYcCVidDE5FFh31JVfkMj4K5fd+rRvcQBA1M0+OH0TMAdB0FT8a3GPjjx2hwqizrcYqoIw1jKvFTVGz91Kmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEI2tFt4EA8zvFtznRfqjyFsRauV3WVMLE1wZqlwxPmO5YADZS
	80JLpr6CnkfKGzij8TO2lSADRK1Q5w2nIalUInVRtahOfB6ZtJwKnTVeKhCZoKM=
X-Gm-Gg: ASbGncuwaM5GN/UeVfC6fA0GAgdJ8WAwEtTsU7UYRipG3iRgkyT/RNxD81GRbrWJUil
	qOwMEMYuiifTk59DN4iodf/5WBVm1BmgztDsKaGbBAKAT6ZYB7X8hdzzQnSR6fd4QRSj5xQvGrv
	lCLe2w8HseVRtrXvEkrAmGJI2ENGnfRDUqw9IGqQHgfP35hCx8o7JKbYEkuNv8ppxxhbjFpGjlS
	xDZGIKvE/FjbgDUGu+Fn7HHPzZJLpmsqQVcQ9wNP5MvFPU=
X-Google-Smtp-Source: AGHT+IF0QExX6hh1JwrsQ9zgcmfY4UXrFOwgjfuxyvDcnHZyG8PwBXvfyqaOLuYkD/JB15qDMyDYOA==
X-Received: by 2002:a05:6a00:4b11:b0:71e:573f:5673 with SMTP id d2e1a72fcca58-7253005dd87mr14711275b3a.15.1732890381258;
        Fri, 29 Nov 2024 06:26:21 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254180f7c4sm3508146b3a.134.2024.11.29.06.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 06:26:20 -0800 (PST)
Message-ID: <2f95587d-e34f-403e-9a0b-84e9e72fd208@kernel.dk>
Date: Fri, 29 Nov 2024 07:26:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] block/35: enable io_uring if it is disabled
To: Frank Liang <xiliang@redhat.com>, linux-block@vger.kernel.org,
 osandov@fb.com
Cc: Changhui Zhong <czhong@redhat.com>, Ming Lei <minlei@redhat.com>,
 Libing He <libhe@redhat.com>
References: <CAAb+4C7EK51kXwTMz3MfrvK83A8ZqcpnV4Sgp1MXRrMJ7WuhoA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAAb+4C7EK51kXwTMz3MfrvK83A8ZqcpnV4Sgp1MXRrMJ7WuhoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks fine to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

