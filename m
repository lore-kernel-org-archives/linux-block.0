Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA35F9CB
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177033; cv=none; b=Eu9En8I+PHKGnB4ztNkMbSJpZozHl2ice9hR/5qEKr454gUjn0A4TapkM9S5+poRt+b/Dl2uj6nuJiorv7SUVEf8RRMRBaQ5YqUwU2XpIY0kFvoyiI1eBT4q6ugb/R3KrovfOXxGjt4nq/O4wzL/JcLra/6mrpg0jN8br1znYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177033; c=relaxed/simple;
	bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFl3h1fTJUdJIFPjm2noDBB7XFECT/xKf37T8RF3mBzSktk0uVea/+c4rzJ0D1hcXN4rRlkd9c3Y+AE429BxrPk8jw97hFHjAaC0oxVitZq6hnM62HNvV0JFnbCLgN0Zcqbi+A+b9nJ7BWn3MigNj/tp4UmknBUbOvh6CW89h1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39ac56756f6so1795148f8f.2
        for <linux-block@vger.kernel.org>; Fri, 02 May 2025 02:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746177030; x=1746781830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
        b=vlsQsA2VmWMh3pVUOpYTj3oAzOj2euqPcr/Dgf8c2x6PV463W1G69Xi1OpPR3oFnEm
         ieMiBEGvDDsXFrK2/sw5om9IRGH9hPqmTrFJ+YeR16xQByVBK63j9e8vtPyxuL3r2rEa
         Q4O0jeMpTfr7WtP1vGFcWuBAqvmHa97yTYMmEqmbymLnCLPoOcPcfhRUgil8y+v0++4C
         zKVj3DTv48hrMx9Hla83jJcn0yelojZPJeos+zvSmeDT2827OS0hXc/g0tUaClIMpb/6
         Q8FWiX2tbzY483dJHr6Xq2CP6AvT8jSGiOfOOcu95QvKqy79AcdNN+aAaMFlzJg9+ESs
         AXLw==
X-Forwarded-Encrypted: i=1; AJvYcCWiCW+w+G4+WbLr5vlyuPoF7lV+/QDika9+Cy9OGEvHjIfb0tlKyJjMrhvfkIOaWRBnkxgME6vpCoHfZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCn6JuLMwOOLT9uwntBTuSk+3mPMUpKt+8lyad/b/MWg45JPy
	Bc3TQDJcHA62RT0l8G/US4bA5EEd6XRmvfmC72AVOQAPMYCAwrhv
X-Gm-Gg: ASbGncuT1zsvoKKj9cwTGKGt3WiQ+/F135ruBq73lIedVWSVro5ZP1P/4l9AHctJxOu
	G+gvREjPB9nuwcvTJGvyulkewJ39Ylki/VZwr+M4Ho9i5zux4ro62niD7ist/3g2KZA9ZjBGGzj
	dxkKsLqJ+fYCO0JoSrtgOnbv0EMYIGqrLBp8VJSBgMyFceXY6s582rYgOEH92o3Q6/6g70259hY
	9YUcOmx/iwWfiE1ROo4i6pKbpEQxBehyXFGuVciF27d3UemSvtrg4ObdV8bHwW+/AE2c2PN35Yc
	nizqV3rx5baDUfalsAU0UhdKuFDa8YLABwDiV+7Wz0HbqmTMwPTkjOJ+Rg==
X-Google-Smtp-Source: AGHT+IFLrf9McKeNlI1alTUf1xbxfpJxlm+/bGngIsh7qC28r9P/drBt8I49s+30+E8X4dOWyA+XpA==
X-Received: by 2002:a05:6000:2ad:b0:39c:140b:feec with SMTP id ffacd0b85a97d-3a099ad33e0mr1562345f8f.7.1746177030287;
        Fri, 02 May 2025 02:10:30 -0700 (PDT)
Received: from fedora (p54ad9a78.dip0.t-ipconnect.de. [84.173.154.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3bc0sm1600068f8f.35.2025.05.02.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 02:10:29 -0700 (PDT)
Date: Fri, 2 May 2025 11:10:27 +0200
From: Johannes Thumshirn <jth@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: use writeback_iter
Message-ID: <aBSMAxP4hlEd8uwP@fedora>
References: <20250424082752.1967679-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424082752.1967679-1-hch@lst.de>

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
