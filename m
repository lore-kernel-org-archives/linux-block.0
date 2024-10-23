Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74F21FEFC2
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729723622; cv=none; b=T5hI88MWk3jZhq6cLkRfC6oawtkIJ0o9Zd1lqutOUCAAzo+xJpP4L+nWL1qye2Zjo2+HwHf7Y01lAouoCoqCr0EbWPNf/f/99ZhWPgBEEC2p6z3GBcNjEtmxZV/CIjrQEiFnqQw9grzM/d9b7uD9Tt8NgR+ib7CCrpNkWx14HLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729723622; c=relaxed/simple;
	bh=0l/PgZTd9TEwrC9cZdu0aB2nHruTiA1U5cUnsMLibog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfyGNzUul5CGEUVR9QwxVUN6dU+IU4spR8lVdtnigV8gnUWdQnGG+JpwbPzh0IuqfCe5pHEtCc/82oycASsljJf5qQj1JiZkBDMqqYsoY4pJjWSnNAtHF2eVolxBDx1rTBa6pCB8D3nkblxOVwagZ2syyC6roZ+G6esPPGAiNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BbCt+JRi; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BbCt+JRi"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-6e35fb3792eso2711867b3.3
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729723619; x=1730328419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0l/PgZTd9TEwrC9cZdu0aB2nHruTiA1U5cUnsMLibog=;
        b=BbCt+JRidyuH7T2w5FSLBrMoPA3/xf+SEMwK1iMFKPFbVSrIsxe7D8l+RxzjvS/mxx
         p6nDFlGU9KkQm2TyadWrqGxg4scb8WD6tQuLhIbbsAr7QdYvIfPmEZrnhaRlujmTydko
         czyJF1dMf6xLpsBnOhEuFIQr2r8kaRY/UbWbd4jplvz2Jqh9WrIrdHRHpsq97bg3lErt
         uQzzpvzK/uEV0XigsvZtsUicU/y7XTWwu70OCTA7jw93nvrzjsOxzFZ7UKbuIGJ2UNlX
         AmUmoLHDm3MGQwsERZE3CM6M1VQtjxd1dt8GTgZQN+870wJWQ+siTIC+8aYiejDvsx5/
         wtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729723619; x=1730328419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l/PgZTd9TEwrC9cZdu0aB2nHruTiA1U5cUnsMLibog=;
        b=FYOu7Eg5KL70GQx6zTj47iTpoTZ+XzhTgOeNPGh20OIwrXtrUXYa0/NCGmNnsdHrSn
         36YbVLZy8uHOUXWuTqcfRSFftj+v5oEkQ8C3op3wwgkq1bFW48Jk/nceAvDpv5SnKgfE
         2cKZbv2ytxHgAsXby+S84CI1MpCK++YB5dS0LxNyRT3Ggvsh8y6Z1euWFyeOGx5zwlDZ
         lI6QYN3p74EaaEWlWyy9UKbjoqzXGNzYrShyyU3tmaWRqb9SWeD0ZSGrBrrj3BksqTzx
         1AeVHo4CS4Dy7bpw0EDDYr6Lu98N9aUNkSTHKYJ5ueUFlQbf/NVHbY1Q25B2t1qdzY7q
         1OKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8euTwBqbHTaFlXM0P44bdm3UP6ZgWVNTJU0Gol1MXsMEwQou/YKgDrFI16CHBh4KqVM8cSmigqhv2/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YynuOJ78CYfgGZS2c3XXcfYO0Urb+CTcPh5Z+BL/rZfh1kRVTIa
	mZl2QwzVpt7VBo1XU8/KwVGzihRtcZ22FvX9FQcq4l+xpIzUpry1qqs/ZM1AFCI/QRWHjdpAJ85
	euJkOFsKWs0K3HfMEOqAQP3Y3LzcI6i+w
X-Google-Smtp-Source: AGHT+IGAc4QQX4FHufuma81xXUxhwG64USeC0PIDZYJ1FrBAEQIHWUdkr3AqqbKC95Wi/RkbzLq2vrvVl8d8
X-Received: by 2002:a05:690c:6c87:b0:6e5:bb93:4322 with SMTP id 00721157ae682-6e7f0fd850emr49970747b3.38.1729723618818;
        Wed, 23 Oct 2024 15:46:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6e7fb877c08sm685167b3.57.2024.10.23.15.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:46:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3A6AF3400E6;
	Wed, 23 Oct 2024 16:46:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2AB77E40152; Wed, 23 Oct 2024 16:46:57 -0600 (MDT)
Date: Wed, 23 Oct 2024 16:46:56 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Xinyu Zhang <xizhang@purestorage.com>
Subject: Re: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
Message-ID: <Zxl84HCKslTQ0BeZ@dev-ushankar.dev.purestorage.com>
References: <20241023211519.4177873-1-ushankar@purestorage.com>
 <f7c9ca22-02b8-4d1e-a9e3-7770a01fbb59@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7c9ca22-02b8-4d1e-a9e3-7770a01fbb59@kernel.dk>

On Wed, Oct 23, 2024 at 04:31:53PM -0600, Jens Axboe wrote:
> Yep that looks like an issue. Since this would be nice to backport,
> please add a Fixes tag as well.

Fixes: 37987547932c ("block: extend functionality to map bvec iterator")

