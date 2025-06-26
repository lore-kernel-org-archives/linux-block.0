Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEB20E00A
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919639; cv=none; b=FjODLam8vfW/4rM6v5WY5Ornh/QlTexUWeazvREpx8cT/Lj7RpTbqThRSW0paL6m72xpb+psRDTQvTADp0xDWShTHHQjUkMqu1Iq6Q+Q19j6WXEw6UnEg/JLRWhWpKAcJIbagCB4/7t7sguFhexrSByUFl3GPhDQiGd3xvny7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919639; c=relaxed/simple;
	bh=J4s9+J+hh9eMHsOMiBgtL6JiImJ/4Z+NIXFm3a0EhpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXp4vrDbAartGxMJxJulnQc0raBYkXS+TP/jvDF3kfxLhHEJL3EQkGW/cKfbGmIPXKfYWbfKUexCeHvG0sivbX4UAoRpnSYUkJWD5Rjnu+cuL1vAfoZzvpfy5Xwq7ztgPt1ARzjUVAm5sL04NUHoHaHeaNruEqIcW7ENheHn5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIR3paP/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIR3paP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750919636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/TLlMh3aXs2TRrbk8rfKXAxcWbrMfWOfFVjrAWZ8rQ=;
	b=aIR3paP/I7Jad4i6rnZoKfrZU/CExFQTaLTlgbY5DK/dWA8yzHgZs1GMV33PO4H2hvgMKI
	3cdekMXZdfNYXABIJFVOB+QFXPaxyqQpPtHF1s1s0nJ3PP32+dyQV1+XW5a3oR4uF1C5lk
	i1YGxeC+SFCgXgOOXX07ZDnHW7PWYUY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-q0mjC4YkPL6O5Ic3av3uQQ-1; Thu, 26 Jun 2025 02:33:54 -0400
X-MC-Unique: q0mjC4YkPL6O5Ic3av3uQQ-1
X-Mimecast-MFC-AGG-ID: q0mjC4YkPL6O5Ic3av3uQQ_1750919634
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453817323afso3223925e9.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 23:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750919633; x=1751524433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/TLlMh3aXs2TRrbk8rfKXAxcWbrMfWOfFVjrAWZ8rQ=;
        b=NGZf0VvdQhA+NqumJhKBrT0Zbis/qF8mSjyF5yFZJM3QiTxhrVEaZ9hCrxb3l5rzkp
         zIPExCzHPRtP4QriVrsV5FO7mGjRSW4R3FfWOiPMrAw5Ep8KYBzMnbzrPRGMHFepgQaJ
         4Kk0dR+8tTKT8UK4RzI1MMAU3arhAGwlj4W2Zt/NtRac/xQWh46ublHiowd3FiefLqTl
         Lfi5THsz9dkSWj2f7+XwzKl5zIqG4tJApyj2gYDqPRB6cslNgB+dDuyIjvlCFtEa5yMr
         2E0/5ikvuqBwzDI5Uzut30TPT874LBf8s2+5fRuLGO7cNk79qUtFBUa3RHt6WhQ830EG
         dKvA==
X-Forwarded-Encrypted: i=1; AJvYcCVE6pkiOXFsNvJnGr3iYJcHQ4JstxeRgzfgXJoeMmBklZsT6cthx9JkBRfdOmeHhRSUOSucggEgtaAcGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVYflW3uKn+0P3reT3fmB1xVFub7Zi63rKv5p5ohHFqrDfYby
	w3wBR7giPoxpeQZL0glngkGRi09DGiwbClXhRhgWBriE8Xm2ROI2nkWMU9F3Lm+OxiGqPyVKCWA
	3hvq0houy/1v8Qo6fygNnLnwvZecG2o0EAbbuvJ3Jwrinkxi5CR70h1+ndQtBc2h7
X-Gm-Gg: ASbGncstgAR1FCJ6tsr/o4fnSwcRnfAwgOrr9fuGSVCa4O0W6/exuQY0K2dIVdyKcKi
	YTesQxbg/HIiH1mWciBh0sb6uBYxEsqeldCzenraO+lYqhVg+Syfw8tX0JWTMVz7KFCDZK8iIsT
	kOHmGLgVJXwyYZcDGNEllqhSPJTi1XcfK9k3+qlHrD4olKOpJrcYVz3ZkvQ5GvGXD1JEu6SJhV7
	wkf1VOkNQLOpwWPIbTAu58nXZf1TGMA3Ab2qx4komKG5Wy4D/KAH3VFgRkTv5evbJb+6M6CKRTg
	h0IhNLpUsxBlrLaU
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-45381af6a8fmr60953775e9.16.1750919633515;
        Wed, 25 Jun 2025 23:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY1gVtAu6xNPmuOKtlgkoZHvhQWkHC705oPq3RWgy6yjcOgBSGke0BghulB4p8vItj5d6DqQ==
X-Received: by 2002:a05:600c:3b03:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-45381af6a8fmr60953305e9.16.1750919633023;
        Wed, 25 Jun 2025 23:33:53 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c3c7csm39585545e9.36.2025.06.25.23.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 23:33:52 -0700 (PDT)
Date: Thu, 26 Jun 2025 02:33:49 -0400
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
Message-ID: <20250626023324-mutt-send-email-mst@kernel.org>
References: <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Thu, Jun 26, 2025 at 06:29:09AM +0000, Parav Pandit wrote:
> > > > yes however this is not at all different that hotunplug right after reset.
> > > >
> > > For hotunplug after reset, we likely need a timeout handler.
> > > Because block driver running inside the remove() callback waiting for the IO,
> > may not get notified from driver core to synchronize ongoing remove().
> > 
> > 
> > Notified of what? 
> Notification that surprise-removal occurred.
> 
> > So is the scenario that graceful remove starts, and
> > meanwhile a surprise removal happens?
> > 
> Right.


where is it stuck then? can you explain?

