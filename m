Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA591DDC1E
	for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026885; cv=none; b=gz2eVxAYJEMPogsIrexsAsOEwypI8akgLmwlL0sa665Ri8DR3oJfDKt1sF39ry0Vx1juajbRYhjpnAAV0vZPMvnOWHz0UhFa441CPqdcuEQM1wk9glVarZQHBHP8iAwFa+VO/5JEX+VqaAD2i2dAv9/KljcgH6Jpvonds/Q5FIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026885; c=relaxed/simple;
	bh=+5aEYy8/LHHi4FXnbdS5ukMXKdh3+6yLZdvJXSlBL9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfihVCtRxjiCMXED+NeQwh5g5y34re9dcsJJsGvO7ytn1z9XFg0V0zYOMTaUAQJioL6RYBsJS4r9wd/C8t4tn956mG40cJlsLhwFg3LSTjy7hmuQmskX7CPEBQZt7QSmcP2l79OUkqAxuM1bS2h/AqH6w8t4TTDer3r4nXNTPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bh/WqrKd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bh/WqrKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751026882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJSFEuy9I5CCg7RQrigp77Ej+GXF1LquTOkHLyT7czY=;
	b=Bh/WqrKdTOXrScNAQ0DDWUDQXZoHKMbHSZR7cQgRZH8v/XVMdh0YOkIGc41BfGDTAKlgQq
	YdIM5Je9QBz2lQh/K8WKc29AgoZf7oHfUMQTuuUp0eKn0Xc05iTMSEj0zG7EDhp2gFpWXR
	xw7F43BlBkbnMpBdnoNV55+fFnool6E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Ie-8pykHPsOo4W7_yQLknA-1; Fri, 27 Jun 2025 08:21:21 -0400
X-MC-Unique: Ie-8pykHPsOo4W7_yQLknA-1
X-Mimecast-MFC-AGG-ID: Ie-8pykHPsOo4W7_yQLknA_1751026880
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450db029f2aso8901295e9.3
        for <linux-block@vger.kernel.org>; Fri, 27 Jun 2025 05:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751026880; x=1751631680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJSFEuy9I5CCg7RQrigp77Ej+GXF1LquTOkHLyT7czY=;
        b=UCiqSqSws39rPb+kc06Uqo/3u48uFPM1A2gitgDMa8JTqOH/9/Y8+DoKyHRArbu/86
         hQDfQZ584YfgV4jKeCi2EARWqmkWSEjmW9h78QRfA0caQRi/VWx5tgavJBAWv/Cdcu9W
         PBabKChLevXDiO+xUjDZNQzYHH+dFOlLr+hU9fyPz0SliIaBac0OaUR+M72jqrSrXfs5
         hPUKw2AzpVU5ic1qN/LKrC82mrM/MxjyPbPnLpL7V/G0rV9sCepjnMRGkA+2ftJn+WNv
         Ki3a+DPuBQJMhgZi7jcTQbSVscaycd/8ip9soYxdjn/wSWPvp2SGwYycuhOQgudAbniA
         s2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWn91UECGg3DYN+DVGKiOWaOnrZn8t7Ej41rrjEfR7HF/GjoQNii7HxeFDWa5mUkKDYNcOOGS6F9JjJfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYXh+Oh7hNuJSj5cw4Tacl78fZx9zOUkRqsdd8Uc9KSe+2atIg
	2Yhp4I29aSvrh8h+mN+NDYZ8yu4hX/eroA+UXXHaK6CtsaXGkhbmQEjZHzd9ViPVCL7r+3jdX+e
	OUlQQdhylcMDS35BnpmflkNt1mJ7Iz8BQOxarChR5cw+ThEfYaugyS4+g7yaxNbqp
X-Gm-Gg: ASbGncsF6BsfCusp1/epmRFAw2v6Bc7zTHoe7pbODZqJgmNZlPbpXbFdJo0CtK7t48k
	mSPWcCv3Nz5ULH2oIMwa+cv1yr5EyYHnnTXR/ayVD7TQl2QD4Xmz2iLDPRDsjJZIDFwpH6XvtP2
	A4u/GJ7me0BX7qcdbp0Ej62/JKp4jo6nHAJGnBp8c59pXoWeT4AF7QPRRTbajZBbhjm10a0C+6H
	jiK8q66o7ftoz034/YJMiWyn7aQOGNNqqsZAvEZlUG/nIy87nzGSLeSq7wjQ2Xejg2js5XQYDyI
	5Z+eNKgt+wOghfiT
X-Received: by 2002:a05:600c:1c1b:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4538f376511mr31929525e9.3.1751026880153;
        Fri, 27 Jun 2025 05:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPFIKbNJqoUHfjnJfvtoip1KeoRTxGz5M9CfWv8c4GpayUIF3Rky7v6/Rn9JzNgvu+kOV4tg==
X-Received: by 2002:a05:600c:1c1b:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4538f376511mr31929215e9.3.1751026879698;
        Fri, 27 Jun 2025 05:21:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45380fd167bsm58441225e9.0.2025.06.27.05.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 05:21:19 -0700 (PDT)
Date: Fri, 27 Jun 2025 08:21:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250627082048-mutt-send-email-mst@kernel.org>
References: <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626023324-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71958505493CE570B5C519A0DC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71958505493CE570B5C519A0DC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Jun 26, 2025 at 09:19:49AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 26 June 2025 12:04 PM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>; axboe@kernel.dk;
> > virtualization@lists.linux.dev; linux-block@vger.kernel.org;
> > stable@vger.kernel.org; NBU-Contact-Li Rongqing (EXTERNAL)
> > <lirongqing@baidu.com>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
> > xuanzhuo@linux.alibaba.com; pbonzini@redhat.com;
> > jasowang@redhat.com; alok.a.tiwari@oracle.com; Max Gurtovoy
> > <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> > Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
> > removal
> > 
> > On Thu, Jun 26, 2025 at 06:29:09AM +0000, Parav Pandit wrote:
> > > > > > yes however this is not at all different that hotunplug right after reset.
> > > > > >
> > > > > For hotunplug after reset, we likely need a timeout handler.
> > > > > Because block driver running inside the remove() callback waiting
> > > > > for the IO,
> > > > may not get notified from driver core to synchronize ongoing remove().
> > > >
> > > >
> > > > Notified of what?
> > > Notification that surprise-removal occurred.
> > >
> > > > So is the scenario that graceful remove starts, and meanwhile a
> > > > surprise removal happens?
> > > >
> > > Right.
> > 
> > 
> > where is it stuck then? can you explain?
> 
> I am not sure I understood the question.
> 
> Let me try:
> Following scenario will hang even with the current fix:
> 
> Say, 
> 1. the graceful removal is ongoing in the remove() callback, where disk deletion del_gendisk() is ongoing, which waits for the requests to complete,
> 
> 2. Now few requests are yet to complete, and surprise removal started.
> 
> At this point, virtio block driver will not get notified by the driver core layer, because it is likely serializing remove() happening by user/driver unload and PCI hotplug driver-initiated device removal.
> So vblk driver doesn't know that device is removed, block layer is waiting for requests completions to arrive which it never gets.
> So del_gendisk() gets stuck.
> 
> This needs some kind of timeout handling to improve the situation to make removal more robust.
> 
> Did I answer or I didn't understand the question?

You did, thanks! How do other drivers handle this? The issue seems generic.

-- 
MST

