Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442B34105B
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442292; cv=none; b=e6jBp59EmqnlnwGMPb9s+wAQp5pYUd9i2f9Y4VGHUJv7yyuizMo2lgKVFFy1/nIWtNiXjHBmccK6iaA+gskLjlHXcvlj9FBqEbZavJj/8J7w4aosTMSC9qIYBhGVaGxaMhSoIe6gFZidWcr7hdRbakj4yFUtj0EGGpi/x7rmq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442292; c=relaxed/simple;
	bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9hNwESn1fk7nPMhNKkbUuDW3c/jNbgDgXnWQ3Fw9lc2GnU8JCPBCgeBiXxk/nSia6uVtfS/oYc28V5hNCsO53w7DvyFpwgrj1oahZlILT2qq3kVxxmSMdWgwwsowYjIC90DQY1Xs2VwBdcK6Sa7NX02GTbAj1YcAIxaw69Bmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Si1Ttrv6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Si1Ttrv6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488c2690057so8751925e9.0
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776442289; x=1777047089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=;
        b=Si1Ttrv6cEHTjA72bV+np4M6baGUM3CYgOs/WZPuLR0MuNnm5EmSq3fRBYqsMB8bTZ
         yXkZ0yzXw1uckNPZCtonfFfJZCiFW7Q1+c9Y6e2JOQ6u20qyicGzcpBHSCTroVVaVK74
         dnR9clhBIYHTSxe7W5V/r/i20/DDqfpFBqKgawA79uk3GNiS7Yg/r59UuzPDdD8UGyVX
         AZ6reanv/zGaAjFGN/qs60H/+SR7skXdupPFrivHWqyMSa5rRboyT3kH1MZlrPx9PF8k
         wFG3zxHuMGg4RRpUnhFQYT/YRSPvJAoFDLHXIJ3Jp07WNsrxHJPjOshysRBFaHd6A+sT
         z/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776442289; x=1777047089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WF57saiDQPuLgei3ntL2rXLAGu55hVNv5gn2ybVfrAg=;
        b=mqhUCM1lpGXq1aV1gJBSR256TjrgnShhoV9aER3UG6qb7EROMmULSv4n/nfLpvMZV6
         5FODlDxS7MDTreT1TiXLfb0x04uvM/O8iAFNOmSzaMFDyBNSedZL+2VbKBFlCM/hip4D
         hCDDGNM+FE2kMEi9DjLA3MrZoT88yHxy5UVIERcnVzAdBK0TbC9cHUDzhuLAmT1sj433
         mnEuhEGzzzsFun5BR4P06CORfX3Yr7NX9IvszlEXKl1SzvTnXLEUewavwnoHYH9MyVKQ
         8XQi2k/4VlMLMeX7egR7CMXOl9Cbz0Vy4ZU8ixAm0FvJQaoPRcgZ5g9cFP8G7SQ3KKGb
         TBlg==
X-Forwarded-Encrypted: i=1; AFNElJ+8Pg4KPXLzDbrEDgroE7uGqRFcZqNOd4NrUOUxc112l42KKjFHXaECwhZUcP9y+kQU9MDn60yAmTKDBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77lp4gNfqGCvxwoyvdtCvqWWAG7HNrPaaBEiANSEZBDCYbf6J
	sUTrAMTCUcu6QXEw9eye5umdlDVRVi+5Z5TTIaElDdm4hOfgHWT6QNEsocc7HqkPuPg=
X-Gm-Gg: AeBDieveoE4SzFYhr2qvfRQWsqQ3GX1/8pw9BY1ES8pLzMJzvSBXOjshaH3zKM7obGy
	T7GHZp5VuajRxHxXCOeughJp9FJrtOHkdt2rLkCUUz6wfDGy0IhD5WFTPTmVsafDFNqD1FVM5ay
	6y18sSWiUNi1SwuA5rQS4ayw69grclxvNSP+vmGqQO6vDa+ntguE1Xo4AJyK6vl1Uk/Xpqdj2sy
	XWjJ+BjVhHhDsqJ1eSs59YnqAX7f0AfgxNNBbGsNtXLlLJDrS1Uk3nr1navFJOxTUP5Yzk9G6IA
	OtE5COvFza1NDBPgVS9qnG7Uiu8ODkW7uOv+XxYiD2SKiEFNvIk1DVwq32MWWy3IeDOPsPnvCYx
	lG2vMGYLY03p7vJEDWJsbl/fwBmerMp4WdKDKpFaWh34d9IGNXeb9++Tezbi9WZbgLImdM+zaG/
	/pa66QKwhkJEVjnTrdXeu4iHRsf8oI2++UaMWvTjvpKEkcWtLy9TBvGBNhUQ==
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr52764605e9.1.1776442289414;
        Fri, 17 Apr 2026 09:11:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm54863625e9.15.2026.04.17.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:11:29 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: atomlin@atomlin.com
Cc: James.Bottomley@HansenPartnership.com,
	MPT-FusionLinux.pdl@broadcom.com,
	aacraid@microsemi.com,
	akpm@linux-foundation.org,
	axboe@kernel.dk,
	bigeasy@linutronix.de,
	chandrakanth.patil@broadcom.com,
	chenridong@huawei.com,
	chjohnst@gmail.com,
	frederic@kernel.org,
	hare@suse.de,
	hch@lst.de,
	jinpu.wang@cloud.ionos.com,
	juri.lelli@redhat.com,
	kashyap.desai@broadcom.com,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	liyihang9@h-partners.com,
	longman@redhat.com,
	martin.petersen@oracle.com,
	maz@kernel.org,
	megaraidlinux.pdl@broadcom.com,
	ming.lei@redhat.com,
	mingo@redhat.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	mproche@gmail.com,
	mst@redhat.com,
	neelx@suse.com,
	nick.lange@gmail.com,
	peterz@infradead.org,
	ranjan.kumar@broadcom.com,
	ruanjinjie@huawei.com,
	sagi@grimberg.me,
	sathya.prakash@broadcom.com,
	sean@ashe.io,
	shivasharan.srikanteshwara@broadcom.com,
	sreekanth.reddy@broadcom.com,
	steve@abita.co,
	suganath-prabu.subramani@broadcom.com,
	sumit.saxena@broadcom.com,
	tglx@kernel.org,
	tom.leiming@gmail.com,
	vincent.guittot@linaro.org,
	virtualization@lists.linux.dev,
	wagi@kernel.org,
	yphbchou0911@gmail.com,
	Marco Crivellari <marco.crivellari@suse.com>
Subject: Re: [PATCH v11 11/13] blk-mq: prevent offlining hk CPUs with associated online isolated CPUs
Date: Fri, 17 Apr 2026 18:11:16 +0200
Message-ID: <20260417161116.373130-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416192942.1243421-12-atomlin@atomlin.com>
References: <20260416192942.1243421-12-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Seems like the commit log of this patch is duplicated, isn't it?
I noticed it's like this from v7.

Thanks!

--

Marco Crivellari

SUSE Labs

