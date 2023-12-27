Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6395396
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="wRBQpcU0"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-20389f2780fso4234036fac.2
        for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703661912; x=1704266712; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rlmtxuw1kYY8GVgYzzd0HTJPJ+7vbZfSEFgBhzg17jo=;
        b=wRBQpcU0PGijYSCaNwDtVMPCzw3JcETdxCACgD4JFmu0DT7NLB2Ouy88f9V6iVzosv
         F7EuxBx3+soKY/1nx3/i5WMYiBE0i5W53qHCqvUNKUrdRJnyN92Y0t3vJTsKWrpwEhNr
         61/xTqLt4y+UwN5drBkoDqHIG4yDPS1LV0qwdzpXpzFCtMvQ9C431XPkmo3CFysUmOkf
         uUAU3yJI2o2LxXk7NvUoiCxhLJmvc5yVbhvUAa7gOW1IGq4KdpZ2bV8hk5SyBUaeD513
         0iGBpmEMhu3vzIokJJZen0A8fkXApN8U8UkVgQ2g9YAICcuZ0PprD3r5mRld8VC64ChY
         XJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703661912; x=1704266712;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rlmtxuw1kYY8GVgYzzd0HTJPJ+7vbZfSEFgBhzg17jo=;
        b=fwbOLAs1Uqoaf6LcnFxCLdjIQBAL0TIjJuVED8TgEecy0LEGpqHFV8fzPbvDZ4nFHD
         wdlYKPa/9MZaDRuRqrXHUs9iKMO4gMGPAN36gvLqQvt7gBXq8leW5mzA4Wi5jBuCNiUy
         G3EZxf62WCrE5siTwdYaW8saedtgh/r8wy5mwn3rZ56nGJPTbjku1cihyKWgMkAK4LXD
         s8UWkZIBGRCfC9t8S/omHbaNJRAUtHibCcDTSRreTtWFKtAYH8lvvrgSwOO44MauL6Gd
         LVIoPIDN+HQzAm8spWsmKTBiogbEs4cVYClTCWZtcPwE2dB8xWT0mFyv5iMsFFn6k2Ri
         ByGw==
X-Gm-Message-State: AOJu0Yz9Nqe9X3cLgS9plwoP8drLVTsMRWcflwPdewk32NQboOqDEFrg
	oCf2MX77rc/91X+ngNjggT7IU9slqWrb9g==
X-Google-Smtp-Source: AGHT+IF7znp/AwmYDdxA7jyqY9qzWPLuT8fC912Ygsnhfb3tdSVxmeAabe4WmnIQOm1u2EUdKy1faA==
X-Received: by 2002:a05:6870:219e:b0:203:27f8:b5e6 with SMTP id l30-20020a056870219e00b0020327f8b5e6mr10860036oae.117.1703661911136;
        Tue, 26 Dec 2023 23:25:11 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id g33-20020a635221000000b0058ee60f8e4dsm10657162pgb.34.2023.12.26.23.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2023 23:25:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From: Li Feng <fengli@smartx.com>
In-Reply-To: <20231226103743-mutt-send-email-mst@kernel.org>
Date: Wed, 27 Dec 2023 15:26:30 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E148FC5-F9A9-4A86-99F1-8D0B93412181@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
 <20231226103743-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)



> On Dec 26, 2023, at 23:38, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
>> I don't have ideas right now to answer Christoph/Paolo's question.
>=20
> Paolo did some testing on this thread and posted some concerns.
> Do you disagree with his analysis?

Paolo gave a very detailed data analysis. Indeed, in some low queue =
depth
scenarios, the data dropped somewhat. However, I suspect that it may be=20=

caused by other problems (such as test fluctuations) rather than the =
benefits=20
brought by deadline.=20

BTW, I think 128 queue depth test is a very important and common =
performance
test item for storage devices.

Thanks,
Li

>=20
> --=20
> MST
>=20

