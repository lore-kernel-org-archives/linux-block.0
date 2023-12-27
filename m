Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFE2C684
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQuiJLhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703671580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vpvi0QuylzJT57z4Iry1XFcRTO36VgwNkYMSy6kylAQ=;
	b=jQuiJLhVeDlz2xfDFyT9fIcVGOhJ1/uX0Ejmm76mK/LIyFDiTUqWnVN7OWD570CWhHmaKC
	1fBpAY06BMcjOVzdyws5CY2Hy3MWM/6BZ1uIZ1caQvZ+pwfnn0h5MM3Xp0Xd1lTSiPQrZ9
	aS4z6yYqtZx/tR3WtDjAc2izAImx2+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-2Isy-zP2N8Ccz6b2Uj8VpA-1; Wed, 27 Dec 2023 05:06:18 -0500
X-MC-Unique: 2Isy-zP2N8Ccz6b2Uj8VpA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d5d0de143so5983395e9.1
        for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 02:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703671577; x=1704276377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vpvi0QuylzJT57z4Iry1XFcRTO36VgwNkYMSy6kylAQ=;
        b=sbUXPy2b424Grt7BIXRajWc+yp4AEWvJwsDBPN3r1n+1pDdcbhZdQRoTh24m8T5Kwy
         B53ddipo/KlFkH9D6JG4JqNLlfXg8OJLThNvLvU7REyoK+JHP9+hB58Bzqx7SlCVJggS
         KbqjOZheDQPvIktvBc+slVBWmNNURHMod/5S1uS/R+Ne30x8VIqe44X1ih5kfLjocouw
         /7bJ17AN3HGB//FJFDtquxmY0LsQAXw5uzfqoOmSvUugx1lQHLpjP8lmG3aNutueWRgY
         mMh6G+FPYb8oOWOHvWJronnY1tB1rjwx2RWiDv0vpgn4mdqco64U6b4p9rH1ur/e3Uv4
         Sr2g==
X-Gm-Message-State: AOJu0YyHLCRvbkaXlO3yrJDNmGKywzfZDauc0vdtAUEAiN0mAI2SghzR
	SrJOP1ZbIT3mDTSNLhiDFhpWuexw2J5WSPrhMUCrv0RPfxB6ZbKabpc52dlfyWb4rO+098ke4+p
	bojEEsvDeSAdrml29qI+QBpDDZmqoA+Y=
X-Received: by 2002:a05:600c:3f94:b0:40d:5e3e:33af with SMTP id fs20-20020a05600c3f9400b0040d5e3e33afmr217832wmb.51.1703671577594;
        Wed, 27 Dec 2023 02:06:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5FpgrgHxxLBaIeXm7LTM0yLsMuN+g4thXte0aFhycFE23DDxpgalZv2U5QOQ/j0TgZHDoNg==
X-Received: by 2002:a05:600c:3f94:b0:40d:5e3e:33af with SMTP id fs20-20020a05600c3f9400b0040d5e3e33afmr217822wmb.51.1703671577203;
        Wed, 27 Dec 2023 02:06:17 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c459300b0040d128e9c62sm31122809wmo.18.2023.12.27.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:06:16 -0800 (PST)
Date: Wed, 27 Dec 2023 05:06:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231227050544-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
 <20231226103743-mutt-send-email-mst@kernel.org>
 <2E148FC5-F9A9-4A86-99F1-8D0B93412181@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E148FC5-F9A9-4A86-99F1-8D0B93412181@smartx.com>

On Wed, Dec 27, 2023 at 03:26:30PM +0800, Li Feng wrote:
> 
> 
> > On Dec 26, 2023, at 23:38, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> >> I don't have ideas right now to answer Christoph/Paolo's question.
> > 
> > Paolo did some testing on this thread and posted some concerns.
> > Do you disagree with his analysis?
> 
> Paolo gave a very detailed data analysis. Indeed, in some low queue depth
> scenarios, the data dropped somewhat. However, I suspect that it may be 
> caused by other problems (such as test fluctuations) rather than the benefits 
> brought by deadline. 

Maybe. I think it would be up to you to prove this then.


> BTW, I think 128 queue depth test is a very important and common performance
> test item for storage devices.
> 
> Thanks,
> Li
> 
> > 
> > -- 
> > MST
> > 

