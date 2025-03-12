Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7224291E
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782605; cv=none; b=G60zz7Nx3Q38s4EeudaVMamY14ExNCe9qc58IgHF87zI/Hq8PNgb9CrCv4IMbdzbm31NIXoa3DKLqVjvlh6CnPrj70RT70YywH8IQOlU3e2PR3OXTY7PMNw/VkIL4tAjeuewguexQZFtJP6vJttz1XYhkbA/J8ouRDCXGyzxhKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782605; c=relaxed/simple;
	bh=C6ik0I4TTm5al0vsqX+E332UtB3DtobFl/PwqgiXOYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbfSCLb72SwjJYBPWMeneoMsipRmir40ambBhc/JOepLEtVdkc7DhNeX0taVmK/k6MRmWknNHMlC92ykpRBTLEqmCL6tjiIwiazUXfDYwyvG5d+AKnhwKPIUqgshNTT3Q/VYwUMgxB0Z9uQO2XcCRW1kItyOYGDX4pVzGvYEB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoujRzdr; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoujRzdr"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e60f212fee7so5078164276.1
        for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 05:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741782603; x=1742387403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6ik0I4TTm5al0vsqX+E332UtB3DtobFl/PwqgiXOYY=;
        b=DoujRzdrvsDbRxmvEdU6RyU7B4wTmEvvvSr0rlnbp6sW7Y6gQIM1UHbtrZ7bZUMLA7
         s30IFFSEEvmw937dSsM8BYSMGoS/wFqR1BYEQYeCd1ldvlyrLJyjCm5LgrSf37eGM+x3
         YvWKIIIQ79+hyN7D41P4sq0w/dE8BV4+G1adUV9gjI1AJ3Y6T1gj3CiDobG5MAaXDKMP
         FEcMQhzjETeTimdM0xSR30LFFz14nP32xFjY/4ylvoSEwP/Rf/Us6IeOUnCETcTjBIy5
         zmA4v35UEloU72a5opGC7hHnIgqd9cI0hhxL7H7X6D6ZGI3JDMhEe/upa+btIfeK+rbQ
         yNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782603; x=1742387403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6ik0I4TTm5al0vsqX+E332UtB3DtobFl/PwqgiXOYY=;
        b=FeJupyUF/6m7OzT/cSUgRVpooG8n+tpNf16zRC+OqOip8hl2pHrF1lI1kLVkA0NZSf
         5GZBwz9D6r22rRoUzVsHK2opFEkK9IAtryorKVGW2k+aJkyydq+3L+HrYvNLFmWFKSM4
         O1reC+FFi462N+fOyFV69cu19Taslo8Xkk8LxTikheNeBhz2n4aUI6ZEfuyy48AqdxrE
         qg4BhCo33peB9r0Kfu0G+CNb2cSdbrPfIsFYDnR16q5fqH3R+QhM1FFkOCE4WMAv+L3i
         eb74JLk3/6RiMcITvJl864kVqMGMxb/O34ujSd2GMVqf8H7s5/atB+qRtMsMKNP7SlTL
         YffA==
X-Forwarded-Encrypted: i=1; AJvYcCVnGovEv/2kih6cnN2Zr9MqiENJ2HpaZkC/BNBnWErT6dG+3/t2PLZMSVgVwlCgfKua+b2fC723swvRJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoPbx0Rt1IKGLhbX+Na1vbq0Y4panjSLdttEtp8Kd/rDnM05A
	d1zfAFnXdA3aYbc9wMIZv5PQArDfEKIfpEUCFyvqF+Oxs508dHzsnW792xXqGNPS+AKIF8K1olH
	NYB4zw2iuOyCmA3rI8eaV2EMT9M/V4f3jC+7IqQ==
X-Gm-Gg: ASbGncsCJthdtjky8A8o2tzEO7KVFlIDv06sDWQeif1si3BJyzoJaZ3sECyKXYmStbI
	+wK5zspSKryte42Pr/dgF2DSRfxLRALkydW3tseMEYY1P3b4q320xx+3UYggymohPqeQQxqUhPd
	1hGjHsspKdVA3eroU3oqzRArhYgts=
X-Google-Smtp-Source: AGHT+IEOTymDhycwj3x4XJrFwn3GpynyoH/McVtHYKr6+MpNmJH9id1TqdMVe93G58v4pKq671t9MEut6J4fUtwcXvY=
X-Received: by 2002:a05:690c:4b0e:b0:6ff:28b2:50e1 with SMTP id
 00721157ae682-6ff28b25a30mr1908277b3.2.1741782603185; Wed, 12 Mar 2025
 05:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at>
 <8fd7f1d9-fc0d-4fa7-81be-378a3fc47d2a@acm.org> <CAPDyKFpwZt9rezBhBbe9FeUX1BycD2br6RRTttvAVS_C99=TiQ@mail.gmail.com>
 <4e7162dfccbe44468f6a452896110cc8@realtek.com> <aebf263c-570a-ed4b-bb37-22ab6596fbb3@tuwien.ac.at>
In-Reply-To: <aebf263c-570a-ed4b-bb37-22ab6596fbb3@tuwien.ac.at>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 13:29:26 +0100
X-Gm-Features: AQ5f1JojhidGObyleeO_01vFJ5qMdpz0_jjjac4sFNZbF6OZFcRqoqIx5daA8KI
Message-ID: <CAPDyKFqyWFfyhkyB4ZA+uH8YanYbb2safzL_qM13vCDDyesPQA@mail.gmail.com>
Subject: Re: mmc0: error -95 doing runtime resume
To: Thomas Haschka <thomas.haschka@tuwien.ac.at>
Cc: Ricky WU <ricky_wu@realtek.com>, Bart Van Assche <bvanassche@acm.org>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"James.Bottomley@hansenpartnership.com" <James.Bottomley@hansenpartnership.com>, 
	"martin.peterson@oracle.com" <martin.peterson@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 12:53, Thomas Haschka
<thomas.haschka@tuwien.ac.at> wrote:
>
> Hello Ricky,
>
> yes [1] and this issue are the same. As I only have a Surface GO 2
> at hand I can not speak for other effected systems, though I guess it is
> reasonable that others are effected.
> It probably works for some use cases, as it only fails if I read a
> lot of files, like opening emacs or firefox ( from the SD Card ). Which then
> causes symptoms as outlined
> here: https://bugzilla.kernel.org/show_bug.cgi?id=218821
>
> Hello Uffe,
> I will try to see what I can do with MMC_CAP_AGGRESSIVE_PM.
>
> All the best,
> - Thomas

Hi Thomas,

Any luck with disabling MMC_CAP_AGGRESSIVE_PM?

[...]

Kind regards
Uffe
