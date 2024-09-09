Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8978E574
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725843712; cv=none; b=BOkBzT7Hj5TYefkcO9jDyNPStjFKgQmiLi4bcG9Urd/OMu6DhG/0r/LKH8vmtsyMglzmGSsiKT5HKrXoxnq5JQjOHkhHpLlrgSe6i+hVwx0k8KQ9A4Bz0UArWfGVsz73fwxIt1gxMLkLOYoMFSmI3x3fusgVS1h6WVm86B3Y4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725843712; c=relaxed/simple;
	bh=3komCaadvlEn9oo20c2Z7ozyg3n3M6lU2JZJ1iU0t0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUuIgGTFXLGPZAHWs3yo1Zr7fh89QszbazVuMKI57hPd3GCjVeE65b+WUe2m4+Zd+oqRCF6lSL7WuHsTHMGcu1HJaQg29l3LrfVfrXJ6+B959GoZCPLD4GsY8pPD3X9CL+IOgBjHheoUp0fUBWddejrcHzF66Di3cJkAGvt983A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhaG9YaX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhaG9YaX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725843709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3komCaadvlEn9oo20c2Z7ozyg3n3M6lU2JZJ1iU0t0E=;
	b=fhaG9YaXPqjCq0eU22Mr+7wc6an/KMGdioW0JIqWVZ9kBuh509zS8ZKyQ6ev4C8+AcQ7gO
	XIK57hgQot7kL32PZqtaALbNC5uoaHYLe4GiwK4qD2wJddRsPxtkmk9ngNJ2Du6WLH2Md+
	G/pLFL6QJpXcJ5j/ufi1hHGx8DG5INY=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-jLmmX7u-P2Sbmv2vDbB2ug-1; Sun, 08 Sep 2024 21:01:48 -0400
X-MC-Unique: jLmmX7u-P2Sbmv2vDbB2ug-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-846d766440bso1125745241.2
        for <linux-block@vger.kernel.org>; Sun, 08 Sep 2024 18:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725843708; x=1726448508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3komCaadvlEn9oo20c2Z7ozyg3n3M6lU2JZJ1iU0t0E=;
        b=hX/AhtTRccXnL1qTabeRpBNMQbjOsM27iLr5FSu+daWnw90r7x/UzSs0jDz2IYmgg4
         EJ/U+ZTYtwq/l+CicBcrmY8BihT9JUE4sPARx9KSA7/R2AMd3IRkAaQbruqJVgAZm8Su
         EQNdq62mO2sdvrP/xMRRx+6nLVvi9l7dGlxTwWm/BkaQMb0ueH9KZVSQVe2+yZvnOFwS
         x/iUiU5zuulMzJcOjJU3z2YEJTfrxSrKU4nz9sjR/A0DWwXUzSmvvZQww9T8XJTbWXkG
         HQIdYp15nBzb+I56qi9ol37jWy/ZPmmshBA+W+nQpEdfGVffVr+kqOQ9vWiUTUdBfqU3
         kjbA==
X-Forwarded-Encrypted: i=1; AJvYcCUtyhz3JXSLd11j0kzaM+OrmL+qc7JBLMhGIIZtGQxcdsmbN8miOqavqxhKhCkBi1k9s07G8uQa9HeoUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+jO590hnwGBI8SfAuqc0MIBuTdX/3OsmmRcAkFknDupa59I+
	FZ8SWI6G0sLAJ9vMfoS6Zff/PcN7AqlEdMNHocymDJU11FnNLwMhdMiqjmSDTkfSPrqm8bTdj0K
	bAymbjteWKmyho4rsvjl/GldjUVc0ucy8spXOBaEioL+ZQtLcf31LDoMK5ibd2MJ3MHvjnhpuin
	8CflZXYdKKBWbIFAKC88l240FP6hS1MNC/oDE=
X-Received: by 2002:a05:6102:2821:b0:492:9c55:aec5 with SMTP id ada2fe7eead31-49bde1c413dmr9034050137.15.1725843707714;
        Sun, 08 Sep 2024 18:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaQRLIUP1xngdGbx405YNFVCf6bA3MV+iOZQT4bK7rc/kGq1AYgxU5LPyIuZ4+D/V9c6o+3nL/XdqW7o1hNxM=
X-Received: by 2002:a05:6102:2821:b0:492:9c55:aec5 with SMTP id
 ada2fe7eead31-49bde1c413dmr9034035137.15.1725843707307; Sun, 08 Sep 2024
 18:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907014331.176152-1-ming.lei@redhat.com> <20240907073522.GW1450@redhat.com>
 <ZtwHwTh6FYn+WnGD@fedora> <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
 <ZtwhfCtDpTrBUFY+@fedora> <20240907100213.GY1450@redhat.com>
 <Ztwl2RvR0DGbNuex@fedora> <20240907103632.GZ1450@redhat.com>
 <ZtwyxukuaXAscXsz@fedora> <20240907111453.GA1450@redhat.com> <2d50513f-bdcb-4af1-b365-e080be43d420@kernel.org>
In-Reply-To: <2d50513f-bdcb-4af1-b365-e080be43d420@kernel.org>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 9 Sep 2024 09:01:35 +0800
Message-ID: <CAFj5m9KMhg8YLOLEX9tjSfA5T=vEx_vOhkhcucy-AU2UQy0V_g@mail.gmail.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this disk
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 8:03=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 9/7/24 20:14, Richard W.M. Jones wrote:
> > On Sat, Sep 07, 2024 at 07:02:30PM +0800, Ming Lei wrote:
> >> BTW, the issue can be reproduced 100% by:
> >>
> >> echo "deadlock" > /sys/block/$ROOT_DISK/queue/scheduler
>
> This probably should be:
>
> echo "mq-deadline" > /sys/block/$ROOT_DISK/queue/scheduler

No, it is deliberately something not existing.

If it can't work, dropping cache can be added before the switching.

Thanks,

