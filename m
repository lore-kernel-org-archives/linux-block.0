Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244728DD0
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764722; cv=none; b=C+kkohKZUk7IZCpuQD4HZWnmu67DDy+jwIfOlMTvaT9o/w4rgSuJp8HylMI4+BlRrxFKDLoR56IvRai3qGKlA5fkAqJHdXn1zHMTUtWZ4UlXFAqKhT7Rkh7GjrMzvUAQ11Z14KpdV6aCaf/TjaIhpuB6OWhUy1XrBZPWhn/yp3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764722; c=relaxed/simple;
	bh=e4+qTIRSvbr3xezuWMNgo63ax5v3Ez/C2egjdgW8oRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxYn5cINzagBacbLgijf3YeafKQbKxZApmBe2ZvxTX+ok2NuiACEPNXRqeY/+oUO/XHyQcO2CX+LjoSpU1eHWpH3dCSWZtMOd2V33MTu8fOpPNKswQO5uSsbz4m1xMzk7d28ZHD4mvXMmuyfpNtVjcZFm5ZJ8OjKh1sK+aiPHe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=b+h0mG6e; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="b+h0mG6e"
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3d812103686so749195ab.0
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744764719; x=1745369519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nk8V/dlMGJTT7EJ3iOCz8nrH0KxjPbdjqQPBASQu2I=;
        b=b+h0mG6evCAAKA47e6O1ODXyi7fqnIc2sjc5Qiy7ZRvbHm/5W2pBFD6XhGQXx3asX7
         6cnQ3bSRqTdVjzq5T2F9+uvyW7h0baQMR2s5k12wATB0Lfsue1trATnMkLd4yJB/XEOI
         OlkP1VeTc6jsQI4BU/J5ZaMC5249tLt3h7ZFLkzr6dMpXQLYQZDVmeR8Q7yxjb1ZzaNG
         yFFRmxnUUOmkiKTUdb0IVByJpuOZ9tdVVYal2kLPEyFlnZLrmig82CIj5ScIky2W5h5W
         9p+7yFcVH/AzHYBUIGBfsexWQk2zH9zHZlyD2rvkuFk8zsvuunLWzz6crEkXRyMx15WV
         AILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744764719; x=1745369519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nk8V/dlMGJTT7EJ3iOCz8nrH0KxjPbdjqQPBASQu2I=;
        b=vlyVw24WQC81TPlsOhKyGtY7hHZWuCrFQZldT8ul8WiVGgidCyFwNa+zFltSuLzpBI
         GLzAOFJLhwRdS9J4aySEyBRfgWa/eEumQguyx5E8ksxcCP89MgRdutF6hjt3H5O6s/AM
         160Crp2c0USZ7P3xEcisZiuj6xMk6ingB20zDcnI4TFYFObBs0A1N0dbssoCHdhBUoMd
         eABJFSdFkTsNciOl2O/JXKRQG24PYWGDYoPttDhEEmJXCINMyCeR0ipISegGhJ5gjE17
         Z2/DP0XalmdDeI9Y2SI33mV2pqapYIr3CX7Pw5o5dmnUxwOL6ukWFDFcpey8PyuVh5/I
         PcDg==
X-Forwarded-Encrypted: i=1; AJvYcCUk791kWV+uaOWC/OP1NaBNSjevkeG0PuNDKTXFb4BLszM524spX2gq135VE/b76OloWrlSbeIek+8R9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+U9UOhuLWmxZGkBDs3DOAkvvkIJ6ONnAUlId/9ijnL9mRUxLw
	0gl207b2gqQ47uiZDr6+WzzO00Pm7ZONyV2DlNp2XDiGuIncHsf0feoCB/aseSnXwHgCsxM6Gue
	GgRH30VmgepiMD9TdoXSKvP1eTJ0SvpJktcgqvpJT11i3lTOh
X-Gm-Gg: ASbGnctxvNsd6myxHIe8eRNQTjQyiHUWcEB+vZYicZR/WLiYQb5sQFoIDaE4ZWBkpAr
	EaNeJnEsn7539ZFHA3+IRZVA7xAsY1FnfBZSRATlGv1ABw6lO1LL9VbpHrIld9UG0tLLrMeBsWR
	KNsqM/fqAiG4qrmeJsT5VZsRaQTYSjUBZP0xdvtqYIj2KBW15XK/A/3AKcprciNFMkxKiIbLI7k
	PFs6q1wwdkeey7Sam6MYNIfqoNIGKF5bVwS9AO35o7JH0sjFb+YYbRBhqALQ4hoEnXPIXGDv338
	V/QRQS8MbRMliFVrx56RWR1DvnJ3euk=
X-Google-Smtp-Source: AGHT+IFyPm70jh9iq82X7xoR2kLKM4ZdXzeG2REnhU6u8Y4QS6O75rLfWs06aciPm78nFH4W2ijwf+wI8vsN
X-Received: by 2002:a05:6e02:1989:b0:3d3:d344:2a1a with SMTP id e9e14a558f8ab-3d812043a58mr17042365ab.0.1744764718714;
        Tue, 15 Apr 2025 17:51:58 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d7dc596614sm8048355ab.67.2025.04.15.17.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 17:51:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C1BB3340237;
	Tue, 15 Apr 2025 18:51:57 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B4026E40371; Tue, 15 Apr 2025 18:51:57 -0600 (MDT)
Date: Tue, 15 Apr 2025 18:51:57 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: ublk: Graceful Upgrade of ublk server application
Message-ID: <Z/7/LTSxqLH7JgAl@dev-ushankar.dev.purestorage.com>
References: <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_49m8awtNFsY8pl@fedora>
 <DM4PR12MB63285A6617D8A9B9F22B912BA9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB63285A6617D8A9B9F22B912BA9B22@DM4PR12MB6328.namprd12.prod.outlook.com>

On Tue, Apr 15, 2025 at 07:46:51PM +0000, Yoav Cohen wrote:
> Hi Ming,
> 
> Thank you for the fast reply.
> To be clear, I don't want calling DELETE_DEV or STOP_DEV as I want the kernel bdev will be stay while upgrading the ublk server application.
> It would be nice to have a nice way to have something like FREEZE_DEV that we may use which will also make all the cmds back with ABORT result but both block and char device will be stay until a new userspace application will reconnect.

Have you taken a look at the recovery flags? These offer slightly
different behaviors around how I/O is handled while the ublk server is
dying/when it is dead, but they all keep the block device up even after
the ublk server exits.

The flags are documented at https://docs.kernel.org/block/ublk.html

