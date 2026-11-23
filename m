Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795435022;
	b=OaoCcytIxQ0M9CbxpR4PRCk8PUHR7y0OAYJa8WL1D9Sj3ZdFK4A3FVCRUKCHjdRu5tsB
	 uwLpZ1eaQEjkDpvKqNBM+rfQFSFlp4RRk5Gh9r7RKRm8M4ZNYqcScaVBD8n9YcsnHw7WN
	 6WTdc6kd+JSAgleKDdKv49YuJARpOm6W0QMmEiLrRI9Q4IBrHctA32JotTQPFxMlwZc9c
	 JyIxjHBzccGQCIJsE02FsK210IKKMR+ZUT79xXuH7zAgteIlQtB3cOBG/jUPKl/NXnDTi
	 GFrbB533ggEriNO3Mq94cKmeHm38VTp/Cs8/Hzp37MFOeg2iDTac5aAY49ccqVRaSXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435022;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
	b=5F96lkQqj1Yg1Pg5QyJlq+Fm4teqNBpMfJrYlzivKtuMzGfhoO79ZL2j18bjaYgBefId
	 rDQS70s6/pF6xHQ3KsIQiA4KgBOk56GujsHI1BE+4D88zwyDklVm0ho0kYv8xNMcj2MzQ
	 wj/veVkH21mbNeTv1hSWxOpndQNionFyMx/1tJoLGlgvMak/ltv8OvrCB3SgQxes1pWqh
	 DEyKzX/j6OLRbHlmQCA0OhBUjzTa5BTE+RQCwGnLZ2LoNGxtkHpKzcs2ec29GMmEynBC2
	 2DoN0Q5Oj+qbJA0477c+F1G7YLTfqtDoGyN7Ac9JcPcS0Wc4UA4WopkuQcmaDAkI+YA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E+gRbUMk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uE3fBkPq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38873606A321
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 11:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38873606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E+gRbUMk;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=uE3fBkPq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795435021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
	b=E+gRbUMkXzr0ftgnphVyzjzHx4e5SigwzrZsgeRJCNybCOx25/aMeDa/5uK8JDEq0XaT8T
	/GotI0hz8XNeEaCJySIHX7w0tJVAPDeoB3onXSvfuP5VncwyfmwP7YIzUrYUIH/3A0FxwR
	7vcuuTbyVgva45tbdLQt4k2HsLFCp7w=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Q1tMQECqOziFG7lqBKC5WA-1; Mon, 23 Nov 2026 11:56:59 +0000
X-MC-Unique: Q1tMQECqOziFG7lqBKC5WA-1
X-Mimecast-MFC-AGG-ID: Q1tMQECqOziFG7lqBKC5WA_1795435019
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b4ed72293aso45804917b3.2
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 03:56:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795435019; cv=none;
        d=google.com; s=arc-20260327;
        b=gliSxglY7Uv1GLgBjHhiW3VaGAfQohS8bqdb4WKXmaYC5uogIowZY1jxKrWRToPQNL
         FS72qhHVtIQLA77pAnT+FhcQ/YjzgvN0MXz/rLCNLA0qmGMqT64B8s9HFv1CGBo7uNdn
         fpF3VR32SYnxA2OLjoc3VlpIpiHYUW5RxDPNV5Xql/ojbrbeCrr6rKc8PwtrLlJ1WEFw
         yfu+WPa6NZd9v+t0vFdWicECv8fePkEGr0RJJlBDZo8Y5HY84hA7GXp7W85+XLxPEJeH
         HTvsQfWKu6B3bgucCgpyiwtW1JTMRQMAtUX4tcF6bK4xhQKA37sKylaiQRLmexbI58in
         Q5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
        fh=hUESR8r4SdIZszp+UEua48XvluXvpXeXXsl/E53ZXX0=;
        b=CrJghCBEhWXTyxZtfGINS+TX8hPSyEzd77tuF5fTjW8s/asadE7hcIv1Kfcsz8fXNA
         UD4Mg1WgfQVSvI73M4vs7SSfs0RV9QDQONMDxeYHFogHyUT2XCfxYTtkB7zrpdI48QLO
         al2wWNMhlQcvEfYQysbOnkSIlgJ6+E8bQxwJ/GnwOl6/Jf58lWOsGTGQvTsE8tpuUXQG
         cVsZiORTcpJiYVZPfG8bc3w+ati54VU7qP7v1LIQfyYO2YNyzcSsueO2lVzIk6tfGhFN
         iZNqkLgl7aVuPjTR93Ak1KafFTZSrZXPSIpU8k8PXFb1fOl7uU2MmhbusV8LSaoRR7SH
         JYqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795435019; x=1796039819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
        b=uE3fBkPqZHuiV0zspXRYOlAIWjlsHa1xBh411w5ZfvWMkXRNiiCke1/VIMPgMms1cw
         emY44vAHwtWhEcy7QqtIcvwOEdAwbKkZT8gnb9pQg0GRhv+aCfl0/3pN6c2nOCFBkDar
         iGBmarvx33bHtPnyd2m47JeR2vILjrFMW30NjMcE/im19C0YwNf7Uq+VbBh8Wk5nFQLx
         yBFDMgB0Mwuu4r5ESKndz4VGkwJYcIa35a1H7nmRqItTsgjc2xx+eBvQ9LJx9KO0qV9n
         z/pm0z3kBbliJnL+sIRkMzmJlO0XRf5FW2DcnXZseXLmODP/phiKBd4puY5oi/HQexhT
         c+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435019; x=1796039819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
        b=Cp6mR7MHDJ0uoFmiZxsyIqCxhayk5vBzE5BONcpvfwGjB6ptiliBv2FK8py6j9JJxB
         3Si0j1XXSIoAeEBiXa4zDmSLnWLg/lRZtQMT1eH7vpVELRyV0rPqfVeqxiJHxkTZkXCa
         V9FnLLCzE+R/Knaxc8mHYYF/5h7xzzoSV3w//0eQ8pEMv9YHF+DfJZuRcFVZwKCikNPp
         UDNXb+7vHfTNzFubSKPHwGME1DPgfruGV3PyW4ONALyobCKOrPdK89m5OwPmInnR6+Ey
         hTq21z+z3YzwiC/vxhX5A3dSiBpHy/g4kHmajkJzEABXUjZTr/heY4qru2TZS/Nx3blT
         yWMQ==
X-Forwarded-Encrypted: i=1; AL+hErFGg4pDh5Amgh4FIeBv6H3ee9589ZJQ2Yu7n0gQyQv6ajCgK9hbldNUR3zP2BU+1FoX6BKw6LS0xr21rw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8aZyYJhCwBAYHamnnrzyPbhBOpj9QpG326m/WdrFPTd+rn0XhY
	ipnrNZV7HIZ11XrC6pyJDV0XxkWQfllbmEIKn1xNgoE1bn5N6IU0i1F1jg7AMBVxLSEjpdJllss
	ydVcjk4zbOly8uZdeESyEqIxUA7VpR/0j+bWdhWWArAaKAKt3pnzLq8lsssL77aeWvHnqoFheX3
	jHrwQ8HxFPt4SFThSGXbjGvVt9U5vsAMMq1FyeOUM=
X-Gm-Gg: AZFdTZe0uEGGlEAHfypWHC2PsPRSqO4e3D0dpVax+q470qW7707SDmpLU9aMEvYg4iY
	L3SF2aL8VCkXfuWL4g5UIdxwUFtHJlgkFSkDPLgcaS0A+fmWxLh6J3M1B31o6MNehaxcV+g+uBT
	PJH4v6NFOdRWe9BRtLN4p/ckmVqnoRmb4d3+GBBWCg78mXRhDuj1qZQu9Hn3FFPo3B5MHzhhO90
	kwGKSmLdVVZIhtVNXyqVi1OEB8Xd0I9Dvux6Ca+JYbnIw==
X-Received: by 2002:a05:690c:6b05:b0:8b3:ba8d:2f55 with SMTP id 00721157ae682-8b52043567emr39667177b3.33.1795435018755;
        Mon, 23 Nov 2026 03:56:58 -0800 (PST)
X-Received: by 2002:a05:690c:6b05:b0:8b3:ba8d:2f55 with SMTP id
 00721157ae682-8b52043567emr39667047b3.33.1795435018370; Mon, 23 Nov 2026
 03:56:58 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn> <20261120031305.3561045-2-huangsj@hygon.cn>
 <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com> <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
In-Reply-To: <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 23 Nov 2026 12:56:47 +0100
X-Gm-Features: Aa3M54pdTCvZmmXjws9eztEBY-s6WsNxLh4ieFxp9T0N0Za24a02lla1XE5V3KA
Message-ID: <CAHc6FU7rAr4Mbf3KssQdsxhdk7D+2SzxSydkyw7cgykGGJOi=A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] vfs: add super_iter_inodes()
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:31=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> =E5=9C=A8 Fri, Nov 20, 2026 at 03:56:23PM +0100=EF=BC=8CAndreas Gruenbach=
er =E5=86=99=E9=81=93=EF=BC=9A
> > > +
> > > +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> > > +                     ino_iter_eligible_fn eligible, void *priv, int =
flags);
> > > +
> > >  struct super_operations {
> > >         struct inode *(*alloc_inode)(struct super_block *sb);
> > >         void (*destroy_inode)(struct inode *inode);
> > > --
> > > 2.53.0
> >
> > Sorry to say, but this has gone quite a bit off course. Can you try a
> > construct like iomap_iter() instead?
>
> Christian had suggested to use the following methed:
>   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantho=
lz-241300d20168@brauner/

Yes, that's what I meant.

Thanks,
Andreas
