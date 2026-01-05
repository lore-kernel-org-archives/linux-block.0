Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92B2F5474
	for <linux-block@vger.kernel.org>; Mon,  5 Jan 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642305; cv=none; b=lplJjho9HPPBmt/q1mXI+7TRZ4xjgR+4m7zWSd+ZAAR7DJNpYEouZlACOkHed65wHrcT3hHKl9UWwTP0dla9BoKebMkVhecyz33RC+qcEVrTbobGdpVyCMDY3HytJ1Aj837FiNIpb/Zl1DfTcdVeXs1J0G5QAwuizfqoiW9ZEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642305; c=relaxed/simple;
	bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqhcxSCW97LqEoEKmcz6rTk37hQEC+uDaxbxSOx+a5Sl4DTD6WW3+Y6lA0qd+DFgOC7AMIDjEAX67QzLHzGtUPw+/DwF3y1XuVojpg/SP0qITq8x1H78nkVCXR9a+WFt6iwXcM34Ftl9RskGcGT5kSdC8etriV8Id7uBUvpH4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETksLqVT; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETksLqVT"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dfa9bfa9c7so143104137.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767642303; x=1768247103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=;
        b=ETksLqVTa/rWQVeVpFW3EcxtWOf4jSk2PQJFyV92uvF1+i/vZndoJAVxyVzUEJ1bEe
         NBXaL5NLbik7My4h0huqO2W9/20sKW6WzT7q/ypqqM7snAmKUoEDBtMmSvV1e9ntFN/q
         Fu9dq1dvD5xk2bpkTKMTWjfPSdgLTBJDJPS5/K8Dfd654nkUSrOeCsLt3Jm6PFwN3FRi
         x3m1kNoCVpXH6Z1oJt+GuuEaavoxa1gq3ROBhi6NqH35zJOu/6+J7/CLi8UVnRYTNCiB
         uyyKEA/Ldq488hHFUOTKpleAMZv4sCfpRwz/R9uLTCKeqTXRwTbwYjOsy/clsaLVMgmz
         zHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767642303; x=1768247103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hCiIn4pkcdXwiuTSt4bKlicJ67pvEXWJY3pTBr64Mw=;
        b=ByhwUVvxMSWG6n4+jB0CPuKD2WV9sgS2IDI5lyya/AZg+j5pRQrnhAx6Aqs161C6QV
         83JiW1Uui9F2zeuiOzgxIWyPy8S5CvaOcsysW/yg1323fNb34p8BUroo//aX+vMBzIsC
         VvTxkM63eyPa9DAF6vYsIy0CZL9Qe6YWB15rgSd1QikyeV1OIfKsR3d6FsdC+Dpby9gG
         6AWI4jwuE21zgkdrvE1j/YSvuS7EW4HmJcQZJ2SUewPdg8TAeuAJAk57zLBP6h2g4NgB
         4bULSiy5xEVcNqre/pZW0wuafFtFGWMZQd7upEjxbL0LIMRFDQvOEvJP6fac4rZrvCbG
         jW7g==
X-Gm-Message-State: AOJu0YzX1hLKxBPar7s0x7olWA5Gn18h9qMJKBD26otYEPIWzjCmTUMw
	okvUEjTTTtr6eDg2Iu6emHiZocRBPgkHavKY9ikbO/hPnCcfr/ADFWrpVA90yCknSGCj8Ztlj5+
	RV0zuYeLyhnGSrsNIQs7mhN7bHTEQcdU=
X-Gm-Gg: AY/fxX40rp6WaadQf6DVTnHGUwYiGvml/Kpros3lcauL2g85fQUdiJv3OC5eSsl6T1n
	4FhVnBoDred3NDP47niseyR8s97HzP3O1SDjRbJGSDnpvBg5PR7ziyTJCZKclxk4PdeggQoMLNl
	Pkl6rv4wAm1ovqkG2wozRXDciMUhY/uj0X6hPfKvTKzrxA1PJcqeF/4mCFX5T4NSGnJhRkyiQsg
	cXNb0ZBiPo4cuFQoZnS9kEC9IatItUctzD9yAQLVGcNEaj8QQwauW27PclEftFC9d7DvFU5d3o1
	VdDt5eOadtM1rbFciH/wWsyAWEmk
X-Google-Smtp-Source: AGHT+IGhC8WZ2khF0B1ZzYJv6toAwZVLBn6s50DlREZq57HJmP/rBfKKkp/EHegrMC2uWHxcxNwyVNHyTQnt+yA/hC8=
X-Received: by 2002:a05:6102:374b:b0:5db:deb6:b261 with SMTP id
 ada2fe7eead31-5ec743c206emr191171137.13.1767642303017; Mon, 05 Jan 2026
 11:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com> <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
In-Reply-To: <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Mon, 5 Jan 2026 22:44:52 +0300
X-Gm-Features: AQt7F2qOyhucU5ykqhHlHKS-jroXL1WRPJ3u1HtyHqgDS9V3cppHeXbKF7tCIwA
Message-ID: <CAPqjcqquxezUTTQJyo+dpbXEUdg7iS6GnQbCs+ve_i-Qp5MbiA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> We don't support NABO != 0

Also, what do you mean by that? I look here and I see that the
boundary is checked by the NVMe driver:
https://github.com/torvalds/linux/blob/3609fa95fb0f2c1b099e69e56634edb8fc03f87c/drivers/nvme/host/core.c#L974
- doesn't that mean boundaries are actually supported?
