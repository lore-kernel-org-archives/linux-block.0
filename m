Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410DB136352
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915390; cv=none; b=PU/dLeIgf1fLsMN+RALB240/dHQw9OKVNLeZ8gfItlvR5X7SFMdirJIBFECQPjvPL9hJFhbPRYkrQ8U+j/6Gl9mK2imqImliCek0S3mXA7VzNV9haHzQD96US/Nr+q8eAJrkDzh8V1Vf79wJa9wEiGD0v6E3qs/NYFIrf5lSX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915390; c=relaxed/simple;
	bh=NZvHln3bcfSZ/TQLs4xr3IKvbwiNkKQxP5LZ2Fgfd5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IFPR39XOZxvHe1rHt7Bi9I2tKAlztRYyCm0aZEJFme4hScpgWperN4x3gn4cDwKS4hdqXg1Jr1AUM+YiYez1YuLgyfQivP1EalK2JrQsxrM+J3/JsTQDOJV3BUtyvvFONlJB1OaR+Bi1b517Gx0p53Sz6WodLu2+Nb7Zg5gSW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fxBV8f+p; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fxBV8f+p"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2243803b776so95031045ad.0
        for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745915387; x=1746520187; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHdRz/EtmBEiEa3gK3w++o5QutFIQ/a6w+5iRyEUy5Y=;
        b=fxBV8f+pfGgJYYFOavC57essN5m3eX35d0hvu+KXKWUUigmrVfNiW+X6N7xZ0+wWpR
         RpJ/UoO7y+68iJ8kk5yIlenijdLG70e8DQHItSqParCTeNcTSG1VyXz38A+Qg2G686Y/
         phJ2IgWLvUq78OVnUGC4dSBGtwOGIeRbzz3QOfY6f1WBFRgGCsOO1GXxc9H51pAvIcdV
         F/BY/YFIVo64dAnq3PxbutA7SVYKE+Cu2gl0Ul5ByueRreFDd1Vu1WRu236RKZ2Lqyy5
         EUFdLFSSkLQcz1GPN429h8NklVkA1VlgqoRP57L8mswjdCj4HgK5rK9gK5sGlyp7BhmK
         Pbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745915387; x=1746520187;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHdRz/EtmBEiEa3gK3w++o5QutFIQ/a6w+5iRyEUy5Y=;
        b=N3O1uRTmY049X6kwS5koA2KloaXA+rTx9fHNplYbhMa3aT14sXH3R1QvUovMZFyr/g
         4+G+BcMFB2u/g9wq52Itgnd+g71WAPOA0pgiWnA8/hiFhBcQbRq6nGd5png15A/jvmAv
         v984rIG8WH00foXU12jZ79CZwwPqHPLjNufkGT/5w9aOy8qyC+xOmC85uRc32px8FyHe
         seu8tfF2dEdFR7GaF+meZivHZW1pG45IpAVj5OuYYjurshoyqTB8ErRDStblTE1n8x+b
         9HS5156lWK7WP9v5clTnfemJ/+e7NpYY3dqxELL+COLoqf9WZWidN8x5rFibEAw/TpVn
         Tmag==
X-Forwarded-Encrypted: i=1; AJvYcCV/XL4f8UINio45PJ6PMyaYrwdlwoP1kITEgeOEKBhtUXggyE+rgPv5wsNZeeRjk+VTgoGYTW7Uy2HRCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwVBnulhVcGgYELQwQQLwZcW+CTCk5akw5fLL7wxW0TJexnHE
	DcHGhscQaVv202C39cyQAiPb0Pxf2EkyVQx7n3+ll6KRrmNDB72WSE5uUPK8rA==
X-Gm-Gg: ASbGncuzmoYD4FODcdJRe+2dynCEuQur6HDtl8gWCrvFBEk4gPp9onVOXYKvkupJ0t1
	ma4O9Hwy1pAxBXyHCOzjXZJW/ayEVtuIwIalpJyQoUL5X1TxmwP6TBDEuXRBNUDlLQD9lL13yWU
	9h8234zmzK9DjyBN4vkOsp2Ic/HVi/sWFs/bkLzD+vTEmy/xwUaNHIGutdrPgeBHb7kQbnK7WpY
	OXP42wJFnW4gpchdRJLtEc4pMntkvBQ/fhvEy/fp08Xq7zahAjlMZsuFVZKweQwC7t1fOLwnhTj
	NNZqDzhZLdDUYxG8Q9yO1wwmV3oyLn7DKMEZR3v4
X-Google-Smtp-Source: AGHT+IHtyasg1PY+dWv82Tx3oLvGNB5rgnrxkjELFD38XpCHt8wN8rT0V6Wq89ygKYgaphfBMh3T1g==
X-Received: by 2002:a17:902:f70f:b0:224:8bf:6d81 with SMTP id d9443c01a7336-22de7022ec2mr33292685ad.46.1745915387470;
        Tue, 29 Apr 2025 01:29:47 -0700 (PDT)
Received: from bytedance ([115.190.40.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c13sm96762425ad.162.2025.04.29.01.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:29:46 -0700 (PDT)
Date: Tue, 29 Apr 2025 16:29:34 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Kexin Wei <ys.weikexin@h3c.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: remove test of io priority level
Message-ID: <20250429082934.GA3896701@bytedance>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
definition"), the io priority level is masked and can no longer be larger
than IOPRIO_NR_LEVELS so remove this now useless test.

The actual test of io prio level is done in ioprio_value() where any
invalid input of class/level/hint will result in an invalid class being
passed to the syscall, this is introduced in commit 01584c1e2337("scsi: 
block: Improve ioprio value validity checks").

Reported-by: Kexin Wei <ys.weikexin@h3c.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
Kexin reported a LTP/ioprio_set03 case failure, where the test would
pass IOPRIO_CLASS_BE with priority level 8 and see if kernel would
return error. Turned out she is using an old kernel header where the
change introduced in commit 01584c1e2337("scsi: block: Improve ioprio
value validity checks") isn't available. During troubleshooting, I find
this priority level test confusing and misleading so I think it should
be removed.

 block/ioprio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 73301a261429f..60364d3faf800 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -46,11 +46,8 @@ int ioprio_check_cap(int ioprio)
 			 */
 			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
 				return -EPERM;
-			fallthrough;
-			/* rt has prio field too */
+			break;
 		case IOPRIO_CLASS_BE:
-			if (level >= IOPRIO_NR_LEVELS)
-				return -EINVAL;
 			break;
 		case IOPRIO_CLASS_IDLE:
 			break;
-- 
2.39.5

