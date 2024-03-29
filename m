Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C0146A9D
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720895; cv=none; b=E1mAhPeMqzGws3iihmCtKYp+V9lq6MbthteqHtx7DuSfZtEmtEr+5qt4zQnOOHA5xSE/uDa2204tf+L3DuTanlHadE5DLN/q8uu818ifzJa/Ls0bde61NSXZvtFQlc4HXmna3Bp3YDc1MQixghTKuphd6PV7uICzLWd9e15VNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720895; c=relaxed/simple;
	bh=i74F7NjaxnuQxdDtY85xiWNbuiNsx+NkmIsGdmHdShQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9ehwUISKz4g6WTo3dMP5as/IcvqRzzKCMpR8sa/lkLV1x0wKXAKjDy6mGVyQGZs8fej4oJ0ofIqjf4vbuJdcBl6RjYAadksKYmIyoy3YeV5IrFR0R3/1pCPuprA+6sZUcd5gjImZINwl/4kgKAj1B63BvFVuHZPM14s77gS8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e695470280so1036848a34.3
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 07:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711720893; x=1712325693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lohjzyD8g/hGhEYvGq+VpCtpRHCNchr+EEmW0UGYQa4=;
        b=blfWGuCeGf8dLcK+PG8BkTGSRuBFO+gJ7biFFVEcZYkLmLmQD6+EStSjWIbSgEDoN2
         DrnFdwv82SeAviyUc5VDnVPJub1V0BFXnDgX4OdMIV0KkAEqQ/7U+woZhyAYwWMnPoSE
         jEUNTLgHutSwqpIdAEtFDbRZXWXrlRja7CDan354Gr5bLAo6IQTSqqbeCCf0spsnUast
         75UGMKfFpl8yUsPM2jJ5Xj4qhSQsYi+Q/gHRP4+zqWCcFrAh96Ecn94E/WmfoUJ1zPCi
         YRd9VjXbr9V5Vc8MWAUPDobzrUMArf4lSU3zF+Gs6hvMOKPQZ5mWMbLioH4hzWWS0IYy
         eRkw==
X-Forwarded-Encrypted: i=1; AJvYcCUszhNUM6EaKuZHojf8Oi1DkC2bgPuxNOerSUntz26zcI6xH8xmdsPXGvHRt5JyPsYksLND77LMpMeHaSQws4FJlhbJbw80bslPpxQ=
X-Gm-Message-State: AOJu0YzeghMFSlS7LQnK+NDJAOWPiB3TX+sMnBgMhsZi8l6AA5rxFqG/
	R6ZdtbCh4WrHgmGmyaM5b8iMghzrJLITskwLc7tEBz01+jx+wJ3VUMuYOo10bA==
X-Google-Smtp-Source: AGHT+IFsGhp10NMaL9dWqt1JzkamUY3E/XLNndhoccAqNlbVHfXe9eIcnVwx/GPeWcdOmWfGWY+mtQ==
X-Received: by 2002:a05:6830:1da:b0:6e5:1aca:aa26 with SMTP id r26-20020a05683001da00b006e51acaaa26mr2165579ota.7.1711720892924;
        Fri, 29 Mar 2024 07:01:32 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id nf5-20020a0562143b8500b0069044802760sm1663149qvb.120.2024.03.29.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:01:32 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:01:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matthew Sakai <msakai@redhat.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, dm-devel@lists.linux.dev,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] dm: use bio_list_merge_init
Message-ID: <ZgbJu0Dx8uku5cTP@redhat.com>
References: <20240328084147.2954434-1-hch@lst.de>
 <20240328084147.2954434-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328084147.2954434-4-hch@lst.de>

On Thu, Mar 28 2024 at  4:41P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Use bio_list_merge_init instead of open coding bio_list_merge and
> bio_list_init.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
