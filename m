Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179C2242D95
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819377; cv=none; b=hYMXB4VlHgf6gcw4+pTeaq0L6ujRyIYdcW+82MyirfO+qZVFUaU//bl4bQ+CikvXrbVUI3nxgHMuyolPj+9GmDXH3ATnI0NIue/QkJR0nhtJacElHFh/dF2nLUqeF1ztbvLYnXzDW01StC0Ecs26RyAZasuuFhZJGtNQhKGY1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819377; c=relaxed/simple;
	bh=tWfk79mnWvNL/spZ1+LGfZxsdLe4Y1lpLgD/tXkao7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geC3JDz8So6/obDBiZ3rrvdAHFOIqPEOoY/+nhu5TOaFS9O0u0UpQ0plSaRu7SBZgmv3JROIliv5rG13tCFoLJC2pxp14Qy6iyGL1SRDuuAe4k6ezcMV35qFVQAIsCHFUEq3JJuz07MFCas4ozQbgwEMfqPHMO9bjV8iG3B3JMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTZAdXFv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTZAdXFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747819375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DZvTzAYTyZqWBe4fK/MLr2gUojvCNcxaE6qBL5ZF0mM=;
	b=KTZAdXFv4b/ouND3fh7Ue0CLDKHHYBB3WnQ3EOHpB0oL0c2i6V+XhQZ3E0DT7KdpcROK0C
	PTm62DbhpKK5bfggQqtasjwsadEj9KxzOMF2ppC/EMOzHU55VCWXFtd+TeBbG2n04BH1Rt
	Pq6zzZIuFfp+qw0cH5nrOI1+IEvkhPo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-6hMnOT53Pu-8I7xtwsHqcQ-1; Wed, 21 May 2025 05:22:53 -0400
X-MC-Unique: 6hMnOT53Pu-8I7xtwsHqcQ-1
X-Mimecast-MFC-AGG-ID: 6hMnOT53Pu-8I7xtwsHqcQ_1747819373
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso20146335e9.0
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 02:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747819372; x=1748424172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZvTzAYTyZqWBe4fK/MLr2gUojvCNcxaE6qBL5ZF0mM=;
        b=V5KSjjsM6OdN7Gz1yGqadbwm41b+2RnKfqZZR0O+8j6a5UMUFRgm4xjZV33RBPYBnz
         CSUXLi0q56KJ6/mKZH20ProGX4B2pa0WtrPy9Jzl/ZLnq1ftcURe3XALVfTsItldmiYX
         oGnhkmm5aQ8E5EH7Y4rXraIK3ws/pkf07+I/0EwZIdYiYVqYLNSkhmZRoBDu1SpkcFkR
         AkbW12OVzWAgYcyN3MADiwj2V3o4AzzTXyb+UE3LgYMJnYrf0JkZYyybXaabhGnuXEYF
         GbjBH2OxPi3pxwWTzuuQrVcw1lYWnm28JbKYD62ccuNzK7ialmBsjIGDFK/s1PFA24Qq
         Wiyg==
X-Forwarded-Encrypted: i=1; AJvYcCVkYo4q8uIiIqq42Z+UQXWf1sPubby6lIG3ckxfPEHAGeM4hmbSNsr7DxPv3pPDsGB481YGH09Dxn8n2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YycZ62KXLRpYUjlv47hLabhWFeAeo5Z0h7coUvb0lDw/OxpkSYG
	2PyRJZvLi9F0Z5pqP//2JCI9sS2yUMTRArJF6jMgcOKr7Nhpl/p1tr5UIbUKVmpYsITdwREnlht
	EoCMZXaaVIfcnsIixZzCOWRaXMkwh5dOTmBAzzUNBOQ7+y+uAIffbdFirsH1gzRhB
X-Gm-Gg: ASbGncsgLSX+QYzdCYU/rZIYHrWluVlDyZ2XdBUMUOlEc4sP42LDhoEt5wy+8+596Wm
	V5bV5Pv+Uta45/OBtQaC1T+EmjOfM2fhtysd6r0at3+LNhx7Yxm6re552vAizROeVNQb9HbITOb
	geDV38kjTVHpwf3w6l60yz2QB5mHd5WyQBMTNNHoxvbuQDjmNhvqTAR8USQvZiNc09Lissssmi8
	AZsjMpPq2YpdFc7ad09JPkvxVDAksMN+8Ff8fs/PuIo/TNefjzzcJIkxVNDtSk9O3BAW2FXmhC7
	lBbu+Q==
X-Received: by 2002:a05:600c:4706:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-442fd63b22cmr176798075e9.18.1747819372636;
        Wed, 21 May 2025 02:22:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBL57AdpBfDWr4rRpAMfgCHlomkA0vufcKUCfL7Opz3DpoDLZ6aZkFarWHJc8jzn11c6FS3A==
X-Received: by 2002:a05:600c:4706:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-442fd63b22cmr176797765e9.18.1747819372285;
        Wed, 21 May 2025 02:22:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm66003115e9.3.2025.05.21.02.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 02:22:51 -0700 (PDT)
Date: Wed, 21 May 2025 05:22:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250521052213-mutt-send-email-mst@kernel.org>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CY8PR12MB719585BEB8E62DDB228942BDDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719585BEB8E62DDB228942BDDC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, May 21, 2025 at 09:18:29AM +0000, Parav Pandit wrote:
> 
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Wednesday, May 21, 2025 2:45 PM
> > To: Michael S. Tsirkin <mst@redhat.com>
> > Cc: stefanha@redhat.com; axboe@kernel.dk; virtualization@lists.linux.dev;
> > linux-block@vger.kernel.or; 
> 
> I had a typo in the addressing block driver's mailing list.
> Will resend with right email shortly.

let's figure out what this does first. it looks ATM like it papers over
some kind of bug elsewhere.

