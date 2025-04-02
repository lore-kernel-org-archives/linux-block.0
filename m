Received: from mail-il1-f231.google.com (mail-il1-f231.google.com [209.85.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54621DDC28
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622463; cv=none; b=hOjz8jztsF+305nDMqAI27pz0bqet9fMo3YcmIef7886J+FKa+jnCsY0pDTbJJi1un7toLKWq/Q7RvLRV4CEcAqSm0/S0QUyTicxQBRy18D3tzvEWt/kdoAYjQ9TY5Tm63AXfcGcDh7wpJYrMO1ADlWaPv8eZaumBYO+CLa+Gt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622463; c=relaxed/simple;
	bh=lV/SwxkHMDeoIBtMKdT8vjsBHGJhbLBdcHJ4C+0jMMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZokIYlnT/elEkYiiolsBnoMY7TAZzhnEfOa1JqiN41OwbJ8L9OpgKRUmI0nTLl+/MslXha0LuFxrnYTXrDJGBmPWHlLN103Fk+iD+Gc4VHyeyn6TBOyz7GhC7BITem3JtgoNiA8JPMsIP+s/dHQphGGdQdPDyA0hqd1tkBVWkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JfTtlCRv; arc=none smtp.client-ip=209.85.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JfTtlCRv"
Received: by mail-il1-f231.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso1738745ab.0
        for <linux-block@vger.kernel.org>; Wed, 02 Apr 2025 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743622461; x=1744227261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RaIhuSmEG2G5gRImcsA2An6Xyo4MZv5/cYCExcMzv5I=;
        b=JfTtlCRvLM+P92rFUbnlT6JHjq9Pcc503XyB0KT4YmnhdWISk1L7p7b9UIghw93Lwn
         rgOCeOBsqinFAlCrJAXkxUrd8sa+mfoz3+bCVr+pXJekHN4Ge/ol5f2DegQbVUwyJg2Q
         344btZlxS6fTFQIeUz+yCDC+8sDGMoZ4xaJaPDXbHfBAUP2bOWE7H/lWCTyuoU2pIO1r
         aeYiGbNGd1yDdOc3bHboKeVDrBu4kboKvu54rcJzA46OvEwpS1jwPt4m1lEF5pxx5p6t
         XDzYA0udK5cSAvt6hG5mzyBPJu/34xUhDXfGryY/2akRZ46LH4UVU8PwL2v93+3kGWc1
         cZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743622461; x=1744227261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaIhuSmEG2G5gRImcsA2An6Xyo4MZv5/cYCExcMzv5I=;
        b=aeiykgBWy3P2kTbbzSbz6zDTpGh9I7IcKPaGfYrjVJBE9QU68WHpP/Xo3D5oej/vOv
         /a2tkHah8Vuw2fNg1SCYtTMpIP4yHFk4RBWpnE9ws3UVC6cJs0fFY4kCp2+RcR/c1adL
         SAliUiinUXI6cr5aPCwHVE/2tATLPBVR66Yy6sonvt6Vz57kDQ0rCjEITWCt+xu58bjP
         l/tRW0jLhocwz3KMdjxxQaMiec732kertjpjZk7kcKAG8+/WNOl1YUnnRVmLiVLZ1WRe
         4utmKEIM/fh7cz/uxWwCwwS5D1qgxpR9HcA0n2tB/SyoJmphxwQ6WPgzmHl///F4u99j
         K6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiXYAw/FmKtOtuGKr+J+HZk7ua83lqkkQc83vbz/FjigKIqsLFpegFI2ZJUTyaXX3MvUXnaoUc6KvNBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcgx511CHmSVColAk0bbUxAK1Ug8J0vzcTzQ85jxukeqc64V+
	MqBUKyjT14B5Zuo1YKiaMnIE6NHzsYccH56Cb3+HlmAk0nUJuVxdwEKtLcRuDRC1n8QGtN75s0h
	GUZi/H+5jUe9aO4lmhpOLNMdxoM1VqZfP
X-Gm-Gg: ASbGncuu1uV8Dgo9nbVhnzm0zwujxgFYskVIk6LP3yVW5oxNKQ3O3DmkpP+dkOA49t3
	R/TOHNY0Gk0c4gy57a3lowoErKMAYAfNaAEtazwv+3IERsiIL+neh6iMjvur+cwZUAzm2z7aBXg
	2Y0sIGSpY1stpUndAdgCdMNVsQlaRrZ6ZBNftmdUqoxara2qFQMiGUXZ4n976nkjSf2QZa8DBQe
	6nG0+O1Im2GdT2xJUtyZsotv39sE3oC4HpCVUlmFcUn/uwtuZ2dRvsEyLRwoA6pg3xDj4nXm8aZ
	dMCo9rYJtRFijG2ybuZxz0LGFCnqXa6cWiis4feKpnKP3xXQyg==
X-Google-Smtp-Source: AGHT+IFsAD207aygo+0nztSrAWlExKIbT6EOMKflxaoI+jAMbF2RFZ0fWIRVrELjJbRzWc4ygH65qwEhvjnZ
X-Received: by 2002:a05:6e02:17ca:b0:3d0:4a82:3f43 with SMTP id e9e14a558f8ab-3d6d547edfbmr43005475ab.5.1743622460924;
        Wed, 02 Apr 2025 12:34:20 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d5d5a6d972sm9687095ab.28.2025.04.02.12.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:34:20 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3ACB0340186;
	Wed,  2 Apr 2025 13:34:20 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2CA73E4031B; Wed,  2 Apr 2025 13:34:20 -0600 (MDT)
Date: Wed, 2 Apr 2025 13:34:20 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ublk: fixes for selftests
Message-ID: <Z+2RPI1GC9NoE/w4@dev-ushankar.dev.purestorage.com>
References: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
 <174359956539.20480.17105268115889494986.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174359956539.20480.17105268115889494986.b4-ty@kernel.dk>

On Wed, Apr 02, 2025 at 07:12:45AM -0600, Jens Axboe wrote:
> 
> On Tue, 01 Apr 2025 14:49:07 -0600, Uday Shankar wrote:
> > Fix a couple of issues I saw when developing selftests for ublk. These
> > patches are split out from the following series:
> > 
> > https://lore.kernel.org/linux-block/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com/T/#t
> > 
> > 
> 
> Applied, thanks!
> 
> [1/2] selftests: ublk: kublk: use ioctl-encoded opcodes
>       (no commit info)
> [2/2] selftests: ublk: kublk: fix an error log line
>       (no commit info)

Jens, MAINTAINERS parsing didn't add you to this email - I had to do it
manually. Do we need to add you somewhere so you get a copy of all ublk
patches (since you maintain its tree)?

