Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDC24E4AA
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899730; cv=none; b=PjYtO9CcePp0UqmsHDtbj2fQKwkblLEkH8E69VJGo6F7ymuK/YZ38PeS1kZHDVi9C+pOAIFh8Tkt+OnO3thMIvtoOnAvl0SKa2QUEZwAhFpyxfzvKrtXSKg5YSuHbJ544udfQ4U2uhWrgWusg92Bc1kbxRs5O9cinbY2NeYvFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899730; c=relaxed/simple;
	bh=ChH8JQW+24G+k/z6IVgewEI4M4eziivwRfO5fg4ASEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh13CJJmDb1ArCKiK1b/2FB9vcIO+EqqMsLmHd/xDXzAwhI9J0xSfopAZOQuZPq0oI8FXSA1xSJKhNjhgx1/UqCaSXVtQrhPD2IHX41cd0yKKTkZ27YyKbRi72gY1SwlppYIuCVHiYWLPu0Sg3wcFzv8GhEcqdvEQVUwhI0EFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uqPUP6c8; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uqPUP6c8"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d450154245so7068815ab.2
        for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744899726; x=1745504526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZRoZS+Y+mMzQkcR9ZaIRG/iM6N8nHa42Rbh1iSWTN8=;
        b=uqPUP6c8bUhdUyHhf6bhfk3bHnHVfFqphnP7H5CehbKb/ioOOz6AGP8n9VjYgKnqir
         M9dH3jVCSOSy3IqioAfNCQNzhhzQtPcuQ59TMCgR5sMvVHzXmMLkEvOezkDlJdZndUeA
         eooR+UMWmaaHYYk2U/1pp56W8W1t7klf6bxeZaL/gp+gD3ub0p97L19nYIIuKt6wFQ3x
         Qlc1rzauFaBDpNs+G0RrSF+1afpYO4i5pO/MnjcpDyqGbcQ8NAdpLNxb2CstFBOLCp5t
         6HFiuetEjSZ5U7AclBSiR07HPmQLSUleL0YGOchAA1ygn8TB7i342NI7WibjlYxq8eeG
         rAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899726; x=1745504526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZRoZS+Y+mMzQkcR9ZaIRG/iM6N8nHa42Rbh1iSWTN8=;
        b=AdUSj4rIgc96Yvbi/yt/Q1HX3gu5t7qn1rngXCxp2m15gSA7sWC7jaByPDWaTkLc3H
         Sh5ewi8oPuXAUkSH69GRo4asCcYeg/DqvJavvsCYuckQhvmG1APywwfqrEgD7z8Uhjwk
         ZWCpclXcBfERq608r23qUjfds6p67HVHORnfzRiK5wHsKIwiEQLTu7S5L9cmKIEpM3WG
         UFYO/45K+gjopEMHXqxump3ZVXxUCYd1LwKKzMjQ173lNlu1zgDZ/9ORAySDCQ2YuR7m
         T6NbNWQUJyJTqUY3rlHZusnB1P53BpbJ6IeuQea4DNDx2rGYcBcv++DBGFcceofNshwW
         8mhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS5h9GEYARcycejPxTo5ai9uAD/bWFVpZiZbL6Hzn//+EQMCx+6eeNRZKMkHD3sD3NlHbtLQWqV368Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbyOCdsFfOvc2qxcUj0aE5ClSQmJq9p/Fq2DXT6eCscwysBGS
	G5FRjInH8CtSgDdbRs3BUGA50wk9yquNy70GPXhwnrEOY/jB2RuVxjZt7TXGXxk=
X-Gm-Gg: ASbGncu8P0N2/KmVgyJcPSyhmG5or+25gU4Gqi6Vb390G1M8Z8UmkQrRqJnK20Wb7Lf
	NtY3EKubCz+toyFbR5wYRosaa2JY4vtA+h0sWSJvpw8flbeVyGLsjBo0E9dHClKmwQB+vTcjpw4
	LpoFdbBOx9AF79ZOK/pxMKmpv7p0LljAQfMXm8FlXajkQV2aQ9eP3pZ45WPFlR+s5txWEmZgmY3
	Ve3eV+Yee4PMNNbyBRyQaiGBhbLv4mNbLUEOS1O00zGrtHjAVz5Ell9cXH9uiMl/zg0F5iPGjky
	j32ZyRp/XuE3JgdoXjv7vHEOYsLXzp7Cd4H1og==
X-Google-Smtp-Source: AGHT+IF1cofliCWJOh0DBbsaTHd0EwFMPvoHs/6xBjwAt4zzA78evf85NMB16MLOCJRBTX+eUEkgtA==
X-Received: by 2002:a05:6e02:16c5:b0:3d3:d067:73f8 with SMTP id e9e14a558f8ab-3d815b1cda5mr50635235ab.11.1744899726447;
        Thu, 17 Apr 2025 07:22:06 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf82fbsm4092365173.11.2025.04.17.07.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 07:22:05 -0700 (PDT)
Message-ID: <8756abcc-c754-456f-93c2-f801ca3c8863@kernel.dk>
Date: Thu, 17 Apr 2025 08:22:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ublk: slow recovery process when io queue depth is low
To: Yoav Cohen <yoav@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "ming.lei@redhat.com" <ming.lei@redhat.com>,
 Guy Eisenberg <geisenberg@nvidia.com>, Jared Holzman <jholzman@nvidia.com>
References: <DM4PR12MB6328BA60A2F4C041C3181BC3A9BC2@DM4PR12MB6328.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <DM4PR12MB6328BA60A2F4C041C3181BC3A9BC2@DM4PR12MB6328.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 4:06 AM, Yoav Cohen wrote:
> Hi,
> 
> I'm running ublk on Ubuntu Kenrel 6.8.0-56-generic. I notice that if
> I'm running an IO commands that causing the IO queues to be full (at
> least the ublk hw queue) it seems like some of the IO's are done 30
> seconds~ after they where submitted. Enlarging the IO queues fixed the
> issue, and I'm pretty sure the 30 seconds magic number may be result
> of blk_mq_tag_set timeout filed default(see
> blk_mq_init_allocated_queue where it set to 30 * HZ)
> 
> 
> Can you guys explain the behaviour? 

Please try a more recent kernel - 6.8 is both pretty old in terms of
ublk, and more importantly, it's also not a supported stable release.
That means that even if we could fix any issues in 6.8, since there's no
further release of that, it's a dead end.

The only one you can talk to about distro kernel issues is the distro.
And I'm guessing you're using Ubuntu - they do have closer-to-mainline
kernels available, that'd be a much better base to use.

-- 
Jens Axboe
