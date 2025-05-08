Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24841FF1A6
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693049; cv=none; b=N8cY3TJgEJsQsW+xDbQaLt1AITUGAkSOnnPyHWjO8Q/1nwFtEnfqshy6kEr7H9zvXnbw3s761nXE3g0fgBAyj36sqICYJPmGFFsT63RarnI5o2y8VaTE8eqgj7hak8Tj8us3k8w0IJ8Fn6ylHsaW8DTcSzQsCs1lx9/XQqkay14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693049; c=relaxed/simple;
	bh=djE+Zh2QhDM34uc8sPlq4flT8Ezs6KE0DV3bU/bHg9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nFEcahDH/QlRb1bPv8P+PQxsFTEaZYQBRNaUAPkzXlPEOt46MsFdN16ZYXkQPVHmR56g7SrjE2crvQTiwx0jZRVkZAXS2YeEltV6msjMdXp/DcVUpNsoVomu8pcdHQOAwZfhT6g388GDhU0RurO2pY+VocS7Hgu4hqP8kl8bgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HHM+utRH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HHM+utRH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30828fc17adso799349a91.1
        for <linux-block@vger.kernel.org>; Thu, 08 May 2025 01:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746693046; x=1747297846; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qg3iNzAHxO1ssP3cCs+yldNF00Pr/dpTQc2LD20rg0s=;
        b=HHM+utRHdL0kCWf6FQn9tpcWylRtC8gv5/yBgCOaQ2d/HIE7Zuju/FiFMa9zcZ9/lX
         yQsd4RKU2KNToyM9ZrRhQx254S6CL6HcAkyUYAkHmAxzWrtCqe7czMT3U+LkpExERFNL
         l8tz3NYTsTbJYw8t0rTPZIdB2aAQFDkJd/y5/FHYDU9ph92XOtnt+LYXhzEILJnk4qbD
         LhmLxWqEr8MTxMiWKyD8Rnr10+VeiL/g2Rn3Fqj+3YKcF/qqIbyL/9fWaeIhIckk2XSw
         Abko2XGoVJ3SjXSW1nN8/PidjOLplKQzjLmAsz0QQJz/Sqg9Gt6WU/DtW7olcyLh491I
         K6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746693046; x=1747297846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg3iNzAHxO1ssP3cCs+yldNF00Pr/dpTQc2LD20rg0s=;
        b=nENa6iob/l/6XaK2wMIXD2mFPbE6tEH8EiF0DglCS8GaO6O88msxRFRjvwhiV3hXje
         i3DtP00dOHyoRD+llS2C23X/mfVfSqKEIjy0cFe+fWiBBamG+Fj0KsntCcH5NZ7s9lBP
         axKyVICRPq51Jdj/Jpm5Qv1u+KsQculihahMcn93xZ4+PJfv/mg0qdlh+8D3M4Dd7AIA
         A7cjlTokWmU8r1qRfo4b9o7Pu+HH0/ONjbAkUyMZxWzLiDzxkmTJquFT8R3Y6NiOxJTX
         BJOa1knBc5+UtTKP4hwlqUrF/B2cKT48FfLkFr8o+pmG4Qm6N0VgAPqGN/cD1r2pOwz6
         aTJg==
X-Forwarded-Encrypted: i=1; AJvYcCUvKL0N6otHMsmzE4boENxmgj37IIjHSjMxF4dFS0SSbXYJM/fr+JRg/xmh+giAlUW1J9FWNTDaJDnZnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylYeW4nasf3k07yR1GKfogUicmSS1Y4syskZOO6RdWjBuzBXKC
	IQkvJr8uVz1lymHj4jzaHxD8JZd9FMcqmupyuv7EAhY+5dcfdnWWw7uOLsOuQg==
X-Gm-Gg: ASbGncsKiCkD674QmCCo97x1/QX7vY67JtKE/a73suHRy00uzqVMJ0eoGkmh7GDwvOa
	9bf2eGM1Nxh6UI+9dXFz5hdWBWRkpEzkGKbWTxY2sNDvzNpJZGlmV1J7VwMS4arvvmRW9NgZ+DK
	7nP9KDJCt0tK03IxdPaCVm1pl7fwUXWQ+wL+CbilWnvK7Fwhjq68NaPOQQbZq8ReuWd+QFfgH8n
	UKw51wSX7HHnf69S/LIF51Bo8CwicFuXkknQOZxQHPR1ZVDE16HTn8qibZI32wNWUPufdS1NFN1
	EoihhjXPpJCr6Na1rQXz25L8I+azB/PN69vXc+HY
X-Google-Smtp-Source: AGHT+IERVr1KtdzcrRrNuFCo/sAAeq0g6uERPey1NFy1lXFkYYDkSmbIC+PFR0sYwk8FwWn/Pn0LxA==
X-Received: by 2002:a17:90b:1d8a:b0:30a:2173:9f0e with SMTP id 98e67ed59e1d1-30aac2498ccmr8223508a91.32.1746693045929;
        Thu, 08 May 2025 01:30:45 -0700 (PDT)
Received: from bytedance ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522948csm107344415ad.159.2025.05.08.01.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:30:45 -0700 (PDT)
Date: Thu, 8 May 2025 16:30:36 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Kexin Wei <ys.weikexin@h3c.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: remove test of incorrect io priority level
Message-ID: <20250508083018.GA769554@bytedance>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
definition"), the macro IOPRIO_PRIO_LEVEL() will mask the level value to
something between 0 and 7 so necessarily, level will always be lower than
IOPRIO_NR_LEVELS(8).

Remove this obsolete check.

Reported-by: Kexin Wei <ys.weikexin@h3c.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
v2:
Address comments from Damien Le Moal, thanks.
- Rephrase changelog as suggested by Damien Le Moal;
- Remove an useless break for IOPRIO_CLASS_BE as suggested by Damien Le
  Moal.

 block/ioprio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 73301a261429f..f0ee2798539c0 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -46,12 +46,8 @@ int ioprio_check_cap(int ioprio)
 			 */
 			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
 				return -EPERM;
-			fallthrough;
-			/* rt has prio field too */
-		case IOPRIO_CLASS_BE:
-			if (level >= IOPRIO_NR_LEVELS)
-				return -EINVAL;
 			break;
+		case IOPRIO_CLASS_BE:
 		case IOPRIO_CLASS_IDLE:
 			break;
 		case IOPRIO_CLASS_NONE:
-- 
2.39.5

