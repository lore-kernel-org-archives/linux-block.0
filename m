Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53387149C51
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508181; cv=none; b=Ip8LbX63W0NRSQ1GZqlxiJfOy2oHga3sJNRyfiHRZF+Z3s/7k48CsNoXU+0o2u/HnSDtRWEPnEYAtm/nyJ9csFH/qiT4W2B8vylzrUkfhNwUz7kJfTJVJ7fZnUcqzFS3KxQx1bebrG6Fjstel0joNVoknmgkjexUAAP3b+4xx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508181; c=relaxed/simple;
	bh=Gz3VSqSsT06o5tY54H4HaqFIbT5TGYwyyqU0Y/L5U0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sg211JTSzhvQxQEIrBD1I2qYnMSQvlzac0ZTYE0KwHapwOQJuoHdNM8cJln6mViJIGDOhbfW+XDoumWTw1J3YMBPT7z3Qd+L4blIK8b10072sNju84Dd2dklYAPYY58HMfXkDIe2orjxi6+15nPd4Rq8qBR+zyWR7SFTKORLLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOeHHPp2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOeHHPp2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725508178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+OtgIy/BJMXLC4HkMF7qZ6LVOdsNKLpuOpjRAQZMR0=;
	b=dOeHHPp2JSEW6EkUWS9HTSI/FCfPraFR85h5YlRLCiMXWJAyaFCymASu+sZxO185sK8yfo
	uJz50fnUZmzuBm5A6g1PcqzQrUAsrLzY3i9xNQTIJcLjxOIb+iO0f48WQyO94qCirqu/HE
	Buuab9Hoyq0DSZGyKc25SskjDwKOX3I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-UUpzQNCFM--xsxsgz3kyxw-1; Wed,
 04 Sep 2024 23:49:33 -0400
X-MC-Unique: UUpzQNCFM--xsxsgz3kyxw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33DCA19560B5;
	Thu,  5 Sep 2024 03:49:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.49])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 664A51956086;
	Thu,  5 Sep 2024 03:49:24 +0000 (UTC)
Date: Thu, 5 Sep 2024 11:49:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: =?utf-8?B?56ug6L6J?= <zhanghui31@xiaomi.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5pa557+U?= <fangxiang@xiaomi.com>,
	Hui117 Wang =?utf-8?B?546L6L6J?= <wanghui117@xiaomi.com>,
	ming.lei@redhat.com
Subject: Re: [External Mail]Re: [PATCH v3] block: move non sync requests
 complete flow to softirq
Message-ID: <ZtkqPxgC3tsRdDcz@fedora>
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
 <ZtgT4HhEsyRJMoQH@fedora>
 <1641f51b-34f1-47c9-bd69-e56b036fc0f4@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1641f51b-34f1-47c9-bd69-e56b036fc0f4@xiaomi.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Sep 05, 2024 at 02:46:39AM +0000, 章辉 wrote:
> On 2024/9/4 16:01, Ming Lei wrote:
> > On Tue, Sep 03, 2024 at 07:54:37PM +0800, ZhangHui wrote:
> >> From: zhanghui <zhanghui31@xiaomi.com>
> >>
> >> Currently, for a controller that supports multiple queues, like UFS4.0,
> >> the mq_ops->complete is executed in the interrupt top-half. Therefore,
> >> the file system's end io is executed during the request completion process,
> >> such as f2fs_write_end_io on smartphone.
> >>
> >> However, we found that the execution time of the file system end io
> >> is strongly related to the size of the bio and the processing speed
> >> of the CPU. Because the file system's end io will traverse every page
> >> in bio, this is a very time-consuming operation.
> >>
> >> We measured that the 80M bio write operation on the little CPU will
> > What is 80M bio?
> >
> > It is one known issue that soft lockup may be triggered in case of N:M
> > blk-mq mapping, but not sure if that is the case.
> >
> > What is nr_hw_queues(blk_mq) and nr_cpus in your system?
> >
> >> cause the execution time of the top-half to be greater than 100ms.
> >> The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
> >> scheduling efficiency.
> > schedule is off too in softirq(bottom-half).
> >
> >> Let's fixed this issue by moved non sync request completion flow to
> >> softirq, and keep the sync request completion in the top-half.
> > If you do care interrupt-off or schedule-off latency, you may have to move
> > the IO handling into thread context in the driver.
> >
> > BTW, threaded irq can't help you too.
> >
> >
> > Thanks,
> > Ming
> >
> hi Ming,
> 
> Very good reminder, thank you.
> 
> On smartphones, nr_hw_queues and nr_cpus are 1:1, I am more concerned
> about the interrupt-off latency, which is more obvious on little cores.

So you submits 80M bytes from one CPU, and almost all these bios are completed
in single interrupt, which looks very impossible, except that your
UFS controller is far faster than the CPU.

> 
> Moving time-consuming work to the bottom half may not help with schedule
> latency, but it is may helpful for interrupt response latency of other
> modules in the system?

scheduling response latency is system-wide too.

Then please document the interrupt latency improvement instead of
scheduling in your commit log, otherwise it is just misleading.

```
The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
scheduling efficiency.
```

Thanks,
Ming

