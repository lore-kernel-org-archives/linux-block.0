Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795598234;
	b=v25PXRSwf2FbnyOzvBqOmhFyNU5RVVgFd11aQ1LHcqG//OxbHwih32vy1jZa9M4XgURB
	 EW2yVx7rCnUGje8IMWsJtqT3EzptZPbyja+1WI9FnwEfm+swuqlL4duqP7j7X27d9IfgK
	 oreavajvWyMrFwWps/AiZ61X6XoDkkQivgaMiiSLkTWwnSz/9RHILIPu++KGZgcgDm+gJ
	 fRnql2nD87JPOosZNEiuqIGTE+e0S/I8DmZE9worwKDbkeBh85OMDqlJgyxGM8m+3Mew4
	 m2Lgb4cXwPEtPi6cHvHl8ymxhCjmb7KSlUqiTODfQ49ten0Oq8ZZ4mjC4T3HO3QaPsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598234;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=cAYdqBNBEgg5h2s+5Nw6P6avYopE1k6reY3QHsLhPtk=;
	b=vq4g3REMqZwkq0IC4n/wT1qwOsl3UB11tz1+yY2jB/tCzt53WsPH2r4zMrsxbUHvWVlk
	 9QJjtNRE0v7dVGNWO/GI+9X5IhwUJZ5J7pz7a5XTi07veigCSxKjofQ6+lcgWtUa8gv50
	 IHn4kp2SmdaYy74czs2SxjRGWqDF/JXsffZsMTTSFFyfuqj28Bl9G+BYZIHBMlGfNHaWz
	 sRka9dlEVcCIyIEBc8gOljf10+SCKuLTKBq2cbF+bI0gFfa/imNHsKDW7MXhvM0nXYa2j
	 yvD3Qq/86kp0GVaNcSZbtqQc2RFQBNHysVGKHLtRDg/XwU9FRWpOgp+yqz6VSVkByHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ciGEVnWH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JudkF65J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2F606A680
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 09:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D2F606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ciGEVnWH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JudkF65J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795598232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAYdqBNBEgg5h2s+5Nw6P6avYopE1k6reY3QHsLhPtk=;
	b=ciGEVnWHm+m6pmaqeVd7C4zNrSasb5/wyhZP9jyIabcJ7+O+bSbHDGQLXuL1LUSFgqgl0B
	umFC8NXHXe/TE0DSNV5kE+wJvOLcoiIZNFoARE6BbWMkGegSv/VaxX1sllsNp0ND0AiFEj
	sWL9mx0JdcvSzslgMKWP/8azpLPkGC8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-onaxC6DTN8mqdXzNA2HhGQ-1; Wed, 25 Nov 2026 09:17:10 +0000
X-MC-Unique: onaxC6DTN8mqdXzNA2HhGQ-1
X-Mimecast-MFC-AGG-ID: onaxC6DTN8mqdXzNA2HhGQ_1795598230
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-85d630e451aso5140266a34.2
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 01:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795598230; cv=none;
        d=google.com; s=arc-20260327;
        b=UgttoKgkehTjKfkx7q3KeVnxga1fIGcV4XLB76ESSyx2Dwx0gNCY/weTCORCqN60jE
         tlcXfHydoK+Y6tzbRclECZ+u9TuUIDJB15mFzPcF5NUGHzNeGFkmAB8yHqHp2x60J0HP
         nJB73raIXZI9Zai89XQyf4kOid1g1y6kI1+0GiVsQSJa/co6vwoet8V0hz1qKzMJjOvp
         CzH80Q7XOtPjLJCTbxM1cmYWeh6pCDyqG6FjlJwhWnA8kSdJshS6kN1xZqn9H5mQuwoQ
         jNvaPriI4LnQne0Xw/V0CBRmTv2AseW6ncfJx7lsRfEz2fHrnC2PZkmDYkiXvBgdUcsX
         Mo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cAYdqBNBEgg5h2s+5Nw6P6avYopE1k6reY3QHsLhPtk=;
        fh=V1/e7DCuAHjTHdJreWSiSwxzCwkdwNjA75uJc8tVDuo=;
        b=hlj99rlSuzFOF12SWCdK2utQsZ3ODocYQRsihdv81qw4t4916RPTWkpB0x/RCcb4cQ
         qJxqqa/PCSuEF1mygObxiFvsqyDs9CuCYoagJ7G9X4PCLAPry2j/Akp7nWH5530ycTfw
         tHzN2Z38s7ioGa9YrVpxPIPBtCc21SZ6ID4+C28wPFWFjlqvE1XnW07WxNnHOv8uXqZS
         BHwgc6GqVaMMe3thDM9wR92XYqTyt47YpbuJpVCadtlQ5QBzUgnzSZfpYVCwVG0xiY8V
         7ANU+fQ9k2w+sJy1190VSYaebPiafbs3AecTQTHziJm0Njj6lbBW9KK3LzJeVIY4cG+r
         bNVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795598230; x=1796203030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cAYdqBNBEgg5h2s+5Nw6P6avYopE1k6reY3QHsLhPtk=;
        b=JudkF65JwYvbeb5GQWVmPLdEHPSFf2+gNky2kvpZc2DGvjUf1O+EG0ZrDaj1mFmCHx
         NhYmFNfgKv+3QPOP4L/nax4E8dJUax8cODhz1kupNoQeSTQM8+J6eVokJPBTzKyf0sD2
         o/N0AEWyZ3Ygs8yKoPiXFsDRNHT4E6Br4XQQUYIPL7YsSZXGyvbc1W1DTMR/vUBR/KIF
         HI1TgRO8Pz/EeOOfHh/EUURmVZw+JTRnG3tIt/Sunr6scHaG08kHoolJS8CMKkrii1eP
         aQdgiD6VutyvftdrR2XLK6vQlYfp5TT6bqf4vQhvkb9XUwd0bmnMcPxIx5lgVPoChVHf
         uDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598230; x=1796203030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cAYdqBNBEgg5h2s+5Nw6P6avYopE1k6reY3QHsLhPtk=;
        b=zcA4NkXo7P/rQnpRmptUKm+kVTidJROZ24tXy4EimxqIYAzSgWHAVcxQmq8WsFF+H6
         CiN/D7fTCay+jY98UpIKSbcP7JHnCNt6N53QnodgzAojphfqGx2v8mWZeYh3GtqQ8uvV
         kVgrjrVc9AK/47MsLYN2HNXWGztHTDvMIAIXfcPVkvwzU5nDFvSm4AetGLIaAjLmOytJ
         XcR/TAqXF2nwu6PtPGUa5STwVTxmimi805ErB2PfAPct/+wQXX2+C2OuLlq1ceB3rLe3
         LZyMIe6Cr4Y0p6GrkSqAinTGU+eq5HLDaD+2FTHV/Y357BPL/H40kxyuxLZXntGrUOdS
         Cq0A==
X-Gm-Message-State: APuU4Z/AUNcF2qBQn8g4oyYIvxyEDAlnjio2Xn809rXxYDh87tHC6Xcs
	xoB48Jk1nnWyJNuaxXdnd23OfZ5D0SxWiTe1TVjqjDH2VGly0u3N7DyoP+oSN+6bzK6b/prZniU
	eOMmXKJCq//I/1OZAR++PpTFC29wrXqMeXX/mLT6rFt4CxR+4HWR1EdBZiCd4sk6x/2lg/ZnXxB
	I7mK1ZeldgriQ2tuSmUXSEfJpoVXzpmn60LwNJGnA=
X-Gm-Gg: AZFdTZeD6hyxPpmYIY+TFDCFneIt/Q7f3MZMuGCqR63EZFhxJ74WONdbOrgufDiSgvs
	cHJhxTusti490nljD/wyETfyApScTRufILS7TZm5ouPJRONUnbVP6udBnQH1Q2+v3KQWumHepnW
	MfbT9u6uUzqwiCOP+MzOV72c2Imb19ykz9sLQ//SoLVwBBpNtEYkLulJdkFO42eSXRvVl55larZ
	CEYEDMv7HvCeZZ4
X-Received: by 2002:a05:6830:6816:b0:862:c3f1:634c with SMTP id 46e09a7af769-86315a059cbmr19500996a34.25.1795598229901;
        Wed, 25 Nov 2026 01:17:09 -0800 (PST)
X-Received: by 2002:a05:6830:6816:b0:862:c3f1:634c with SMTP id
 46e09a7af769-86315a059cbmr19500980a34.25.1795598229514; Wed, 25 Nov 2026
 01:17:09 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125083947.263216-1-afaria@redhat.com> <20261125083947.263216-2-afaria@redhat.com>
 <ad36d8e4-27af-4c6a-b3af-984118434797@wdc.com>
In-Reply-To: <ad36d8e4-27af-4c6a-b3af-984118434797@wdc.com>
From: Alberto Faria <afaria@redhat.com>
Date: Wed, 25 Nov 2026 09:16:33 +0000
X-Gm-Features: Aa3M54oSeBIW-vwAXD8TpkpgkEkcEGIL-t9H6mGs9BbDZ7mXBgrqV757jr0lyIM
Message-ID: <CAELaAXwH8-gn+nuD96gDSeKZMgKZjX22Q-hVywXbQL8si6S1Pw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] virtio_blk: add fua write support
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jens Axboe <axboe@kernel.dk>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowangio@gmail.com>, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 9:07=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
> On 11/25/26 9:39 AM, Alberto Faria wrote:
> > +     /*
> > +      * Do not advertise FUA when the device is zoned, since we
> > +      * would not be able to handle it on REQ_OP_ZONE_APPEND.
> > +      */
> > +     if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
> > +         virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
> > +         !(lim.features & BLK_FEAT_ZONED))
> > +             lim.features |=3D BLK_FEAT_FUA;
> > +
>
> Can you elaborate why?

The virtio spec currently only defines FUA for OUT requests, so there
would be no way to pass on the REQ_FUA to the device on a zone append.

Alberto

