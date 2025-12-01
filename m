Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB383B186
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598895; cv=none; b=YjD3FcUTR+jq4pulAgxhGUshEVwZAcl7q87BeGysZfRqtR+h9h08B8FVO9qssM1gLCuO2nbfEQ8kroYFo5BNlD4R4N2ck7u0VDJ9MzUnVe3ScJdx2TGGUBGUOeGPnm8AfdCjudVGZUUu8sdyI8uUeR2y0kTnNgE+n91mvJfPk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598895; c=relaxed/simple;
	bh=y8k9WCia62/gkCcjzQcWLXGsG9zvI5l+jCmdvO7PtPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A6H31T94yp47Gm/IMPpO+yeE9d51j9gU0gCzkSDvdNUZ3bs7TD+zUSsKWQOD59m5KdDuvbLuCRNOq+CkiauYkQ7X0bHGS9ceLXtSqrddmGkBdfejFh7tNOaz25dbv8Z8mC7wUlvJjKEKxQr6SMQ2cvhLn7dVB4veurndPfptElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AiPxYkEj; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AiPxYkEj"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88703c873d5so178561839f.3
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764598892; x=1765203692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMvJB+evqyspXm/yMhRRd1PE5P7nqg4yls1DZRWNZsk=;
        b=AiPxYkEjWZzSBT/+imFewX7Lj9nRg6N944JgNg8FIv6yxYixggFJrGToZpr5rGYTYH
         8+o/9WHdYGga/RsSswqrjrv7Zw/HagVMZP0zmrE3h6TlQEWM3QoM5TzTjiD20sFs9s/3
         /ZjWyIRazo7AH0uXIb3KANirYvHIY4UrCeXMrfrJPue9iLMl8Uk+iDpT8nwkmyGohdCP
         QnNtH89zJn5fYHoo7UnmrfRXardxmeTKLB4FJCsXtlJIz/CmdeFpL61K5r4eKpCCTWHu
         iXp9gkGZ1baxsTmRP6sdyfx1Q8qiLXEoUvlOZ82fq1OuOHTqYWbaNkdHeS5cKofxFJOi
         zcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598892; x=1765203692;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMvJB+evqyspXm/yMhRRd1PE5P7nqg4yls1DZRWNZsk=;
        b=eU4aRDhbzYwBAf2x4kBuQZ2hpEpdH7EhjLrsknf501bIntj4sMhWle30Rxf/xlaxHs
         NBOGCy39lpcVW9aKHUZcjYiQqoYsu7S7M6guYoseZo751vgIvWRKKLcoIAhiFU3Vm01X
         ySyMhRgxIP0k08T84ZHWo4gfEIU+IT7zhpO0hqPpmXnVIHn47v+zkQUmI4jCwkFnyzhq
         /+8ey0XXic54zgWueOoVfjZQQjOwFRMB/GXQ54+NCOyDMNMT3iGWgyZzUfaYFofHkfv1
         gfaWIXAeKdf4DbvYuCxwlqiMcKTrnXtm+pyvQDeQfBKIVFBRoqTBIJv530niaEy7tY6p
         6MKg==
X-Forwarded-Encrypted: i=1; AJvYcCXy5Y6waQvs16dZohftaHK+yIcXHkF9py4r+cBh9wuZzFCvl1YJ46GEyosJ5Qd0sgDXTX6g0DK5W8SFMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NKf+V4UwPp7NIl0QYU/QUi51PXqEJj8qyWLAlXza/EY7gO8i
	8Q7zdfD6sy0dAhggUfec33dEHANW4CcUE8Rb0E5DWzcfv48bfTQkIh3xoT123aTALNv6fHWhIp+
	JgOvvqS8=
X-Gm-Gg: ASbGncvL0mRpaELbMMePKUCom5WTsaq4wNtYoTI7EupXQdm92ZV5AEV0Q5XaWBRX4g0
	atlWJUgOqwdMuUZWofw5yhI018KqSoQIK6Qrc6bJvb3hcgaPYVMVRLmfE/E3iJXjdG0cD+fHvGh
	SakMgTqjmrK4TBOfd3ptvSdA/px8/iTTrbEQEe6JPlmLBlGODYp5E83xd5NBPcfzGcU2I2CHt1O
	aM/Jm9sbRu1mKCyrkW/g141XjdDwP0VA2wcCY4XnwpGBTcZK4DeCuvfHGEhIRqWfn3VxfzQkKmE
	jbIxzykimIVggi0vTiQzD/tBNjWYJgp6BkBRTdvxPCb89VzqCjLEs7mMiYF4QHMbT+VqFcrK46m
	LXTHLRh+SB5UvDv4uw4tpUKY4yqxaDjIhZYGwSiYjG+7GtOz2e2AFakEMx3CbTqr+hDm4CEINN0
	UtoA==
X-Google-Smtp-Source: AGHT+IHk5DhaLu0KiORZNqJo9ph3+2qdgovs2WpXvQOdOKHfJUlwS1KeMZLCaK0ugHxnIENRCeKAcg==
X-Received: by 2002:a02:cd2d:0:b0:5b7:bacb:803 with SMTP id 8926c6da1cb9f-5b99948c395mr15692273173.0.1764598892403;
        Mon, 01 Dec 2025 06:21:32 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9bc3716e2sm5795794173.25.2025.12.01.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 06:21:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org
In-Reply-To: <20251129223542.2047020-1-rdunlap@infradead.org>
References: <20251129223542.2047020-1-rdunlap@infradead.org>
Subject: Re: [PATCH] block/rnbd: correct all kernel-doc complaints
Message-Id: <176459889163.423001.1675303366643422403.b4-ty@kernel.dk>
Date: Mon, 01 Dec 2025 07:21:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 29 Nov 2025 14:35:42 -0800, Randy Dunlap wrote:
> Fix all kernel-doc warnings in rnbd-proto.h:
> - use correct enum name in kdoc comment
> - mark several struct members as "/* private: */" so that no kdoc is
>   required for them
> - don't use "/**" for a non-kernel-doc comment
> - use the correct struct member name for "dev_name"
> - use " *" for a blank kernel-doc line
> 
> [...]

Applied, thanks!

[1/1] block/rnbd: correct all kernel-doc complaints
      commit: d211a2803551c8ffdf0b97d129388f7d9cc129b5

Best regards,
-- 
Jens Axboe



