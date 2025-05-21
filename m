Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A322D4D9
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846203; cv=none; b=QezPx3QYA6PGZTuibyv8vj49QXnPK8WbBnLCfmrklL9u1JjqTXnrcE7+LsKuRXU+sZBcQlorQKSIPZtv9i6RDGfDL2Tq4Bs8JkKz5n0ApsWPu0BF8z1Ug/694tT7rGo2e/BQFM4JQsC5JGhZ6ozcn31frmmwMdtpbOeHoA/t+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846203; c=relaxed/simple;
	bh=1dJoHE8GeNtckzx9RFaomoN/xQ5MjUgsn5hhVqqprxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y39ICBp/rAxViqGKY8+WodVdFrdEdnYMrg3eW5lRrGv3QfBWmnjwNLAj7v4dTbCphUTkqmpwThBzc6BkhfxdSjpUzFjgEpV9qrYSCLcifaSpBP08WQ+y7ITF0QwHiFjyC46t7DM8jm4iLBV6aNodOKcd/sD4fQ4D8nnA4KaPoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjakcZ/a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjakcZ/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747846198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqZFNdbupL0eCdCzdn3FtVLd/tCfrZa6LajhRpntDkI=;
	b=MjakcZ/a6RwcYrcawlzN+tGolKkBNLnRNB4RWphj+E5pchh/Lmp0qkIulorjqcSxmgzdQN
	ekBWFRNdaqm8Ab10kczGsg1H7SmAEWaOWuMoP00OGWn5sewyoWAvDmabS87nChda17Ww6x
	+YbjrKcAUPThOSMNR0QLsx0Jukt55h0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-eFBzw6taPWeXqyuoxkQk2A-1; Wed, 21 May 2025 12:49:56 -0400
X-MC-Unique: eFBzw6taPWeXqyuoxkQk2A-1
X-Mimecast-MFC-AGG-ID: eFBzw6taPWeXqyuoxkQk2A_1747846196
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso23698135e9.0
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 09:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846195; x=1748450995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqZFNdbupL0eCdCzdn3FtVLd/tCfrZa6LajhRpntDkI=;
        b=bvy2cn6QVlzwFAuQ/YnfJKpw3EZ80LyUDCLdtojqIKOdgxYiMg6oPZ0jIvszDjep2K
         e6cjqp5DfT6tU9dReo7DUOnlCcIW3jYBPbQetti5Fo0Mn3OMRunBDhvYZ5fosjzzLcdH
         16z9EAJ1VepN7r9QZ89Ko74I4Gh6Hk0hW72T7GWk0OYhjG7nltHSLiYmqJEjJ5RAcxq4
         FqcCLvVcPbnKN1uDkIS9DLWiUO0tYqP9eVCv0WynU1dXzvUGcszBtKTeU8dVABJm0dlg
         GERxDeCdsuJwVCth5Pw+AEZhTJHkJIQMw5iUbqXofNXT9NkuuL7DARlbsy8UTAHzabnO
         Yabw==
X-Forwarded-Encrypted: i=1; AJvYcCXIXDeWOlPf4EgeRtRVcMSFsPgUyr/9S18Yzv8jGw1HauqidxfFY07Nsjsj0YsEh3UvP/FVleR647u+zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYe0yWOjlNPzZU495vq5mPBZbDRN92kqdmz4c1S27GibmNCJh
	je09yQxtQxtPlK8OX5TnOs+mEMssBgE4LRvLx1zZBg/BOWgBvVvYFvJSgQwOTjMpzxSwfSnZIsB
	f9mc7jVWEpl4C4/93KejxPFUkffv9RJ+x2CKobvsGjHtRsLB4VY1AuJlmSxHRxDeG
X-Gm-Gg: ASbGncvMAOt3exvEs/GTnkuwYGm7WSD7XaBMzT+P/Vu3IdxIqNbKm0IqJdVgaf2nlO4
	Ezn3Wodo4CVjACVwSkrX/Q6zm8Vy0icFVPgKnN2s2Rd7/eS/NR1IKymu6tnttdFwkRu9t4F96tG
	ey5m452ShDqXyeqou2fFMTUFCt7bnLRRaXMx6CIOaswkuUqibxR4lPkD68mUewnj+cWs8PYh7/O
	6b7YuWQ+33C9+yzvpRwPENf6wUjXHUFxGlTz/TyJVHF9ofQs5/GdfQ3g4lVq8+NCP5apSo0x9Qy
	IbsThQ==
X-Received: by 2002:a05:600c:5493:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-442fd618f0dmr252334635e9.10.1747846195660;
        Wed, 21 May 2025 09:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOuXLutdPh0G1kKuu4RDEal4trFfwrT0Z7nnw08VTOi+Znj4RUK/v5fHXWo8/k4A36IsxuQQ==
X-Received: by 2002:a05:600c:5493:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-442fd618f0dmr252334255e9.10.1747846195270;
        Wed, 21 May 2025 09:49:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7ca2de7sm74037525e9.35.2025.05.21.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:49:54 -0700 (PDT)
Date: Wed, 21 May 2025 12:49:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521124926-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521051556-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A306A9A8CFE8FFC1B033DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521061236-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195A01F9B43B25B19A64770DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250521063626-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195200C1F5D877448DF1D3BDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195200C1F5D877448DF1D3BDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, May 21, 2025 at 12:40:10PM +0000, Parav Pandit wrote:
> > You can include this in the series if you like. Tweak to taste:
> > 
> Thanks for the patch. This virtio core comment update can be done at later point without fixes tag.
> Will park for the later.

no problem with that, either.

