Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08BE1993B9
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750644575; cv=none; b=oLUvWz+4XhL4Wzwg6qAB1O+QSn1ruOer0gCJnjz7/GSFM0Itnuw5YzWrccfHz96RCVOL02HzCkpFmo/ZYjj+DLws+pKimIqITYFsGWx0vCT92UhCZHIE4WkryRyIFvWiz4g7HVUBVlHj5tJpSvEad+8FZWosTpb0L7B+C4mE3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750644575; c=relaxed/simple;
	bh=x7hpiDR4qKglD7Ir5DagYi1QENn/t1iu+UDVk8rRHpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsEPK+Lo82vZk0FNyLi067l1pl5/0maxt86Np6/emM/34/NGtAIaXzetMxl1nN5Y8ZLysj+xu4pVD8OnNobEPgbIP9f/fpgkpxlG1U6Rk7QNddet1PSbQAMd77VhCpMoxYE2EFo0uB1hJIGldSpSIh0Go4EBVLQ7JfCA/5sqmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RIaoyvH4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RIaoyvH4"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1729652b3a.1
        for <linux-block@vger.kernel.org>; Sun, 22 Jun 2025 19:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750644573; x=1751249373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJgHAjKlP+uQglnNSL7ta3bomofU87c73wx7U9vhabo=;
        b=RIaoyvH49HBPs51B7bkGzae8O9K1clEqpohUcrM1j6roxkDRlVpQCX9HxvuknTl2Ko
         ENSfqWHT7rKYOD82dOXgaMDLekgna6hGz+lq82MP3SbaORVmUDkleiYLgK0nFC5axq4a
         b38G2d70+tzhvW/q2Zk9Jw3oJcQEu/rxvtp1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750644573; x=1751249373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJgHAjKlP+uQglnNSL7ta3bomofU87c73wx7U9vhabo=;
        b=JADNTFt/HuXCIUs+1xRwQ9OhTLjkH1tTeVOMp3B1JEI89QSYsw9IQaEI/QQfXX/GCX
         2GiYYpWXIwj8eUaTdg2TdShog/2X2YBUjjVu3SBLqPmd15nMvrXezBHbHUMNsfJZluYZ
         uC907s+WUcLS8JxMhn+xvMSk63XGbYelKnRYsZhzoTn1P0ZFsCFOGwyewBeLT+Lug0O7
         6YAxn5XvqIfwPGeO8ZNZGrZRYkIinZZ/Hntd4rvH+jbv7bLYsZX6k40Dhguny0YpLw1G
         kVYwOpF3dXGRxmUtBCqe9vuOpAHWYV6AUBkIdn5z3LiWL3UgkofHMnrdE8gbGK++d+vT
         EdJA==
X-Forwarded-Encrypted: i=1; AJvYcCUG2lqB502aWQY0ARTvbSDey10hx1Gb2UsH44HhugSRGv3ReqPiX8NaVCxbXQn9d+Z8//nSzwY4oAsH5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwohBKNuP/NJUaGtWCNYvZFVUI5RdatPkLl3KtVEgaU7skF+mxD
	p3Ho+TmqHbf23FKAx+pCm6+cki1p5PXh50c1ZGwXZ5LZTJ+JY5ImYCFYl5mFNl6zeA==
X-Gm-Gg: ASbGncsCiGlRECjy9kdtZ2aenLIn3kK277N1TKoZSc/iKWFHeDOCyhxVdbTC4yim1wa
	z7hT84PsohkE/iUTK+10SklLsF0EbQQhcfRiLO5tgbnrDn2M046b+Ji8igrNAMJ2MUfCYy+1EDa
	BOrCpQOKPe0GjBzHabTk02QOXqvN/NdyB6H6FlqoombgVn0yueS+Gsx0ES4doB0Ius7oc7njHm5
	s+3Njo24szEzMLt/BqagQilprcxqkuE4QpJAnxa8v7ZfhNFOpeM2z6czVLD43x5S3kSGrDJ8EqU
	fxOqw1gL5OPPl+cRUa03fWPL3eS42Ax5umiNbxf9qiYkLk8Yanrbiby/LK4qQUfO
X-Google-Smtp-Source: AGHT+IG6cUGGcE1aPZGXsILZBQLtYk0/qTh3KpldgGraVWjCXgnv13V8iaPuV2aRqOBbSlL69Z4D7A==
X-Received: by 2002:a05:6a21:7a47:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-22026e9ca83mr17370601637.37.1750644572967;
        Sun, 22 Jun 2025 19:09:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:b9f:1985:9000:6db2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46b8c8sm7353540b3a.18.2025.06.22.19.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 19:09:32 -0700 (PDT)
Date: Mon, 23 Jun 2025 11:09:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, bgeffon@google.com, 
	liumartin@google.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: support asynchronous writeback
Message-ID: <jpj6huz4rqophy6xpgvfnlydhajzal6fbxfteydl7ihzanpqn4@e7esbgc75gss>
References: <20250618132622.3730219-1-richardycc@google.com>
 <n6sls56srw265fmyuebz6ciqyxqshxyqb53th23kr5d64rwmub@ibdehcnedro6>
 <CALC_0q8-98y0v_jV6QOFTKRAGhJ4nCXZ=q9wutLZPCE0KnKymw@mail.gmail.com>
 <x54netqswex6fpv46nlmeea3ebnm32xnwask4zxw7nmcn7tqdz@4mu4hwsa7hsb>
 <CALC_0q-aRtNS8c00nCD0key27UH9-_2kW=PoXQKrLQ5bg6MU_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALC_0q-aRtNS8c00nCD0key27UH9-_2kW=PoXQKrLQ5bg6MU_A@mail.gmail.com>

On (25/06/20 13:56), Richard Chang wrote:
> Hi Sergey,
> I copied three linux-6.16-rc2.tar.gz tarball files as the data set.
> 
> Test Flow:
> - mkfs on the zram device, mount it
> - cp tarball files
> - do idle writeback
> - check bd_stat writes 185072 pages

Sounds good enough.  Please add as many details/numbers/etc.
as possible to the future commit messages.
