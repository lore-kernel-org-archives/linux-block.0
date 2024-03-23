Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE631EB34
	for <linux-block@vger.kernel.org>; Sat, 23 Mar 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711209927; cv=none; b=Az0Jz24VfPyDcW0PvRfOAdjd6UOC7KRHmUxRwOMlh/Ppk77E03CmzHZPRlGhPZiCrDzDUltFPLflKxSwBmW4jo3qjWN3mf9iyxxc9coLQ10O9O2DFAJZ+MaI+5dfT4KLH5BtlSARX8wH0s9WT2BIGK2nq8oWvgzHLGuow9a/Tpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711209927; c=relaxed/simple;
	bh=UTIcrrwXNx/qWXkxlQfJF7yP5zzW0DBI70wtwcfgnt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERIm8UxIdgxBti0+NQgwsL8Lu+AVHzev3H5MbmhaCNypvWb+NaPO5/XLme+2MAqWJ1Cdt5KurZcSN6BN6zFZS1b6NdLlJWpOXBSuFMB+hu/MNjieTJMLacQY3qfyrmIgjFH13lC2rt38hRTFl7D38vMwQMUf5CCYD23ujylM5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69629b4ae2bso26997876d6.3
        for <linux-block@vger.kernel.org>; Sat, 23 Mar 2024 09:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711209924; x=1711814724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwgP8PLLhEZ4I/JPIIVutoqihwAKeS31/sLLIs4EdsA=;
        b=IMt7YYJg/z067PzZQmEDn2BVJCqWNBqMrNlCkLqx9YM88noM9+rsZh6ShK1xW1LQHc
         FULw6n++jMUqaUgO8FWyh6ZmWh/PoQq42yH8FR39CGbuCV5hALZxX+9ZXcG5Lv7Io8lN
         B4XSw9EXgESgaqkQ8jo3BB/vK+eF5h8kaCFn8p8sKUO+e/cFvSJ7Cuuy5h3kk9oj1oTf
         XTbmkUbznbmwk0vQfDhLkKbUZWTVyh8dbTWckq/fmoDF951NXU252GSRv+SWeXoUarpY
         96L9xF8+IXVsorIqEd0iaecwAjcc6WOyW4XNLSNYWVj91YG/ley/k9ZZHhP7fduKTOir
         eJqg==
X-Forwarded-Encrypted: i=1; AJvYcCU6D70d6i8yoUIjn0hWTdmz/uETfernU6Zh/uBdtIjo6JCHuy5rwwnwIVkb5nK47QXQXph0gq5YIIhD0q1Qhfo0fq9QwTbSwKQWd8c=
X-Gm-Message-State: AOJu0Yz8DJVifotEv2z4brJsTzzDDbZQqlrzJSdcIhTqdWzdDdSMc56Z
	707dgUfmCJOU1oRg3E6ZkNp0+IomuL5qHeSxFfgUkZD/EOt0WN+Q8D3V/ql8Dg==
X-Google-Smtp-Source: AGHT+IEshk/dc6HBbutRsVAeN/yLgWxtrdsdReob4esfZAV/w/UrsUWSizBnvhEbX0jZww+wWyWm2A==
X-Received: by 2002:ad4:4ea8:0:b0:691:1fcc:e26d with SMTP id ed8-20020ad44ea8000000b006911fcce26dmr2460772qvb.31.1711209924582;
        Sat, 23 Mar 2024 09:05:24 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id jr9-20020a0562142a8900b0069186a078b3sm2170108qvb.143.2024.03.23.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 09:05:24 -0700 (PDT)
Date: Sat, 23 Mar 2024 12:05:23 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
	mpatocka@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 2/2] block: remove blk_mq_in_flight() and
 blk_mq_in_flight_rw()
Message-ID: <Zf79w4Ip3fzSMCWh@redhat.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
 <20240323035959.1397382-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323035959.1397382-3-yukuai1@huaweicloud.com>

On Fri, Mar 22 2024 at 11:59P -0400,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that blk-mq also use per_cpu counter to trace inflight as bio-based
> device, they can be replaced by part_in_flight() and part_in_flight_rw()
> directly.

Please reference the commit that enabled this, e.g.:

With commit XXXXX ("commit subject") blk-mq was updated to use per_cpu
counters to track inflight IO same as bio-based devices, so replace
blk_mq_in_flight* with part_in_flight() and part_in_flight_rw()
accordingly.

(I'm not seeing the commit in question, but I only took a quick look).

Mike
