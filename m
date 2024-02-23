Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18E1292F7
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709814; cv=none; b=dzNYsSZsG2+UtONXkIcKTgfWdoc8NbQglmBqsddgrUDl+HrN1ML06rERTfxMJPt/6xOJF32DKr6sz0MF8eH5DKXx/PCo9GPQYP4uSQHzvPF5+51jxu+JAB5Mb5/DxBuZ6YM8EqgrPzJbjfgQRovv2ItcEMwQOSoEmseK1hGXibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709814; c=relaxed/simple;
	bh=SEK03gUgsAHVyBKTF0SeCekKr9R3NEdzFcCnlWlT1bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byQPSSAm2s51DANU7Rx6zvWWRKElPw9UM2Q70C/ubbDaG7JyUC1zMLvjWDsvFtqy1hX8Ylk17abbXcaYD3ZNGzmCzgso0uT7sye/asQUC5HThxbo27g+zNAj6hJiCQ5Mz1fJBwNaTpMt2rU1I6NLcmVXJcL5Fo3T8NfX//5U3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c049ccb623so883292b6e.1
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 09:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709812; x=1709314612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBgb3133dWWVi2hhB7h7NHIAti/ExYEzD/m6pD+d9CI=;
        b=T+AIV1YjQsigF3Pt9aKRIgKGpS7WOMYPtDMz4j1Ir0cfPyRnQ+6dDIrYbX084AD9Mt
         qPMa1KX7QuNdh8nkv79YFzqwHgOMANsgK1Tq9icUlN72xrTIeNAUN5ztrjqQh3hHR8KA
         vDIQODlAEIiZ1I4UqyC+4oyeGsLUCZtIHKjQoAUKVzv6IOQTC16R28Ytbbb+RZEg0NS6
         zJEHHG8gBanTWoSqWZhcnYioH/gcYBhJHYHfmitoNZix5oF5gmvuAHWXcbed7mGqThbM
         Q6SgMp/X5HpH6UdG9hZhwlFPHLooFlNZG7/jLLk8N07/GbV8OUu5X99U8WE3QrDMxyqB
         qfXg==
X-Forwarded-Encrypted: i=1; AJvYcCUrKtcW4F1kGs2DOAoEwVpD3Ak1unu3OjCoggqMmBTBFbDveciFE5Si8ePp1cwR/psMzIjr1oi/l2d/SUZGrRiljoGC831XDksO5JM=
X-Gm-Message-State: AOJu0YxiKY8+85o41V1yP2xQHlH/XiHKn66xOxDVZJx6+GeDR6EihoHh
	t8HwLNAFclRV7G+qWkWPImfc9rlSq4dQstEtzIQ5Hkgm3N+XL0Cmw/L//x2vIS9LH6xrEv62Q9U
	=
X-Google-Smtp-Source: AGHT+IGbYpIhPAaa+76bZP9NfoGjlH58apihqp1Jeh57mXakscWDl1A1EkXzjkZJgYEtNoSB+kRJHw==
X-Received: by 2002:a05:6808:15a0:b0:3c1:4b06:7ac2 with SMTP id t32-20020a05680815a000b003c14b067ac2mr637798oiw.12.1708709811740;
        Fri, 23 Feb 2024 09:36:51 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id qj9-20020a056214320900b0068f914ac80bsm4751610qvb.50.2024.02.23.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:36:51 -0800 (PST)
Date: Fri, 23 Feb 2024 12:36:50 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: atomic queue limit updates for stackable devices
Message-ID: <ZdjXsm9jwQlKpM87@redhat.com>
References: <20240223161247.3998821-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223161247.3998821-1-hch@lst.de>

On Fri, Feb 23 2024 at 11:12P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> this series adds new helpers for the atomic queue limit update
> functionality and then switches dm and md over to it.  The dm switch is
> pretty trivial as it was basically implementing the model by hand
> already, md is a bit more work.
> 
> I've run the mdadm testsuite, and it has the same (rather large) number
> of failures as the baseline.  I've still not managed to get the dm
> testuite running unfortunately, but it survives xfstests which exercises
> quite a few dm targets and blktests.

Which DM testsuite are you trying?  There is the old ruby-based
"device-mapper-test-suite", and a newer one written in python which
should hopefully be less hassle to setup and run, see:
https://github.com/jthornber/dmtest-python

Mike
