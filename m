Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C134CDFD
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQoIPNSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703581512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve1uqTx9MMoZ3Gc+pAWDljbgIT4AroaD+W2YAl66BV4=;
	b=hQoIPNSym1esmDzn4+UXlQfyk+4S76/Fq+cUoCbl4A2Hymwk+kUAd3b/S7yRK38VWV2rYz
	3J21YioKHd67ECnkHPR+4Qf+8t7Ly5KYLJ8KMR+y+B1YVjGeJcceyW7pUAmJrtV2PoKB/r
	ZqMmhheJZRv76Z7tgObavilyZcx5KFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-vZ_YedPSNaibCOKTqajLBQ-1; Tue, 26 Dec 2023 04:05:10 -0500
X-MC-Unique: vZ_YedPSNaibCOKTqajLBQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3368698efbdso2757391f8f.0
        for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 01:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703581509; x=1704186309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve1uqTx9MMoZ3Gc+pAWDljbgIT4AroaD+W2YAl66BV4=;
        b=W0nRmXG38K6+tAhmQJNXG557wXYsU4Ljnzf+ok/DwhQUucg9qozyScZN6fijYjSkAu
         Z2FDmr40RWU4J8L7+BWBYDapwyDQycZP+sOUkiZqmdx8OTf+8kYLqgq38IGgWzDvWsvZ
         Q0vKlAatmP0XdyPbqeb9noUGjWPRlyK7KXd3j8Gnnw2ErlHCTSG2wXVSUmRq7gXKrEHU
         HNAzxqWnKE87+jmFYnBTm3VsLVf9kZDCEqVCMlQmDP/T/3+I3q5mlMrwJZTnaU4Vghe6
         v6fuxEjBWgIJIKRxZ7ORb0bV8/BgU6fPSKb5e9mYmPqGQuarKWHdCEN70P+6MzOKbdkm
         UjhQ==
X-Gm-Message-State: AOJu0YzgWzOUd/H2uGRsueU4+80byGN4qpZs3BpIs1PoJyRZCGCpFCCF
	vkzVxQhcUY4dWtBDh5ZmxScZeMJcMJ0BZfm/SrOw2w0xTbNYiiN/IhDNVQ59tj4S+0Yu73sV30Y
	SVCb6XswgRtTx5G3xYY4Rif2HZh1b3gk=
X-Received: by 2002:a5d:4590:0:b0:336:6895:f5fb with SMTP id p16-20020a5d4590000000b003366895f5fbmr3586475wrq.75.1703581509105;
        Tue, 26 Dec 2023 01:05:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLiMWpmfAgwDwhbbW5uVJ8j6cbfhcNo+n6TStySwWGpppm3cK94RSMZ4VKjncgbKZYFbBFBA==
X-Received: by 2002:a5d:4590:0:b0:336:6895:f5fb with SMTP id p16-20020a5d4590000000b003366895f5fbmr3586459wrq.75.1703581508742;
        Tue, 26 Dec 2023 01:05:08 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id df15-20020a5d5b8f000000b00336c43b366fsm3580935wrb.12.2023.12.26.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 01:05:08 -0800 (PST)
Date: Tue, 26 Dec 2023 04:05:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231226040342-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>

On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> Hi MST and paolo,
> 
> mq-deadline is good for slow media, and none is good for high-speed media. 
> It depends on how the community views this issue. When virtio-blk adopts
> multi-queue,it automatically changes from deadline to none, which is not
> uniform here.

It's not virtio-blk changing though, it's linux doing that, right?
Is virtio-blk special somehow?

> I don't have ideas right now to answer Christoph/Paolo's question.
> 
> Thanks,
> Li

-- 
MST

