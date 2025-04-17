Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3B223710
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913538; cv=none; b=csfxbDli4JICT8JpaVvtueZBx6f1yguzWekTVfF11AvDfqW4q1S1BRVxg3jhvzbNaUGQ02cF5KlqdgmK5h27ZY0X3wEpPYP/Ruwx/ZMiGNhdQ7hlMu37HUroBOJ88WABSFtR0BH0RBfJPYLFrX4zKuBnTk6o5yU9KCYxHcuizHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913538; c=relaxed/simple;
	bh=rTuiRxzxitZgLIT1XC5cZUwi283dZi3TKrPCYJvkdCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtSzpTnR2RW0P6iLC7qxEGmh4/zfTaw/N0dr39jRKb+VRTEubzplT62sAOuX+xJI6I7P9wQm/aIwNE5Pbz+Ngd3uoP6OgCVW82MrlUINCc27Nz5703bk1rOLtpjslg+W9QP4Mf1QQ4qMIVONw+NyDm2VF5YBBGMW8mn5wyoB4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FJzQ4E7D; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FJzQ4E7D"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-7054f0e933cso9847787b3.1
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744913535; x=1745518335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETLbdoCGYCxOBaDoBm8VOLVwDOcbDf1iRxC1csRkQmc=;
        b=FJzQ4E7DnlmW7FOw5vbVd5m07ymrFmB5TRaY5Ay7MuYtOEiC3DGOLRhuY1hxpddIhQ
         FTjPlcFwNa/7jIRhmTE8LEKE8F8GEz6SD/Ir0O4Ncwi8denFDXrqyZTgdkdHAKU/yDab
         +nGhO1QJ7hoGzDxY92hiN6z5ib9GbQkfbc29LloPF93y8u6e/nZ7oCs2H/x+LAqJgf3F
         3B3XavJhvtMZfHnZ1zcUs6DoscpFkWs5spNVLl27LLfrYf6dOKBBLkKdxYO5npWiRrAR
         z7mMaN5v4OvmsOrzRAedzxcLF3eq+PgBgfVtOMBYuMF8UBH3jDKja9uF8uLAh41FmZxJ
         M96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744913535; x=1745518335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETLbdoCGYCxOBaDoBm8VOLVwDOcbDf1iRxC1csRkQmc=;
        b=hhFdqtGyFWYi2txK7UxReQYq2fPPEhuij+Ji7I2DX085gT8dIRo+4xuOTqLW7WIKhd
         N4x0/Hcgkb+EBBEEjOaYFUDzxSAOQzqa3/P4MN+0VAO5YMBf9pQtDIfcrnPCI477ZH68
         uklNT+Wc8/MgrgWdlt/H5HlOQyh8l8xdoI71XcHLy67CKRpNSvN8kwiVHfWPPJGGrLEo
         ZEY+eW52KSoRc9Ky3rB4wZT7RnCv7Td6jQ6K6RXLq1L8OCUPthhInqRMSeoUlxpFP77E
         QpIdol5c/nsDwUE8MCGUvg0BTJ0DorROwKOxI0mTKa7w/fs31AfkgUiI0roQWRSwpuuB
         iqmw==
X-Gm-Message-State: AOJu0Yx0tHUvxzvAchdwOfrvFD+061sKyq9GU+cqqz7V1/muz1PQWEKO
	FFH5pIONXtg9+4hqtm5YuaKBoui6AfO6QtMrlvk7kFGwRjU51EiIsEBLQncb1Jn+ddkb43Gk42W
	rU62BTQ3xD2KRBpUFvBOaD14H+jit7T7HcikUo19PC81vlqQb
X-Gm-Gg: ASbGnctdEkEiJoBCup2INDJZ0U93tKtsb75ciEGptPvBtOPDVZ0SHmjdGbl9ZLeNck9
	mOalMyj/hE4d6kqgkecYxE4kK7gamuvTYFK4OiylgsY6iq41MpJSXifhQTD5PXWxGOHBlqC9MO5
	fuSaRr7IcSmXsxBpHkWtL9CC1jGxJjcXyUXtwki0jaNYgeKdp/CFLuS0sCRQxuwauTjW02/0rCf
	9BGx8IohMZelguGwqVRq0zAyQdINI0qu2PMFkTSjFqldwCSst+PGVXk0j9IfZO8amwVhCL8zHOo
	4X5/s6JE0awyjJj3nrGppTqpP3WZbZw=
X-Google-Smtp-Source: AGHT+IF0R9MbSLsT2Vf0NFI3ZDq6M/6emvDo2HpFeNuloZsJLbRj1Z0ZjpzMDkIMThAG9TRxSL9xGop+EkMs
X-Received: by 2002:a05:690c:3809:b0:6fd:2b7d:9a4e with SMTP id 00721157ae682-706b32cb478mr103101587b3.18.1744913535406;
        Thu, 17 Apr 2025 11:12:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-706ca476ae3sm128917b3.9.2025.04.17.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 11:12:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 56B2834023F;
	Thu, 17 Apr 2025 12:12:14 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4B616E40371; Thu, 17 Apr 2025 12:12:14 -0600 (MDT)
Date: Thu, 17 Apr 2025 12:12:14 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Guy Eisenberg <geisenberg@nvidia.com>,
	Jared Holzman <jholzman@nvidia.com>
Subject: Re: ublk: slow recovery process when io queue depth is low
Message-ID: <aAFEfqhdRikKfMnu@dev-ushankar.dev.purestorage.com>
References: <DM4PR12MB6328BA60A2F4C041C3181BC3A9BC2@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB6328BA60A2F4C041C3181BC3A9BC2@DM4PR12MB6328.namprd12.prod.outlook.com>

On Thu, Apr 17, 2025 at 10:06:36AM +0000, Yoav Cohen wrote:
> Hi,
> 
> I'm running ublk on Ubuntu Kenrel 6.8.0-56-generic.
> I notice that if I'm running an IO commands that causing the IO queues to be full (at least the ublk hw queue) it seems like some of the IO's are done 30 seconds~ after they where submitted.
> Enlarging the IO queues fixed the issue, and I'm pretty sure the 30 seconds magic number may be result of blk_mq_tag_set timeout filed default(see blk_mq_init_allocated_queue where it set to 30 * HZ)

Correct, that's where the 30s comes from.

> Can you guys explain the behaviour? 

The behavior you describe was actually just fixed yesterday by [1]; see
that commit message for a more detailed explanation. You might also be
interested in [2], which is a test that recreates exactly the behavior
you describe. Before the fix in [1], the test saw an I/O take ~30s to
complete, but after the fix, the I/O completes quickly.

[1] https://lore.kernel.org/linux-block/20250416035444.99569-6-ming.lei@redhat.com/
[2] https://lore.kernel.org/linux-block/20250416035444.99569-9-ming.lei@redhat.com/

