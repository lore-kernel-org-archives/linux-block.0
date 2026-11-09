Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220098;
	b=vAkDOlrN4a/7/sGbRXjpSK0h4GbFvw7Bw+Swqc55UevmBgW8+xrIHbNO5Rf69+fdtwe4
	 x465y2IanpxhYzErVwFyFZwCrsL6q9BjBTjesYpYY+5jM9WkpH/TU4CucNRL93RBTkJ0H
	 KloC3TOB6nefDPNCnwrL3IbKfezsT57Vdvc3CS++OpU9MGTu0B5oM8gT5z6fcEWq5LOtM
	 FyaDWiY28tp5TTWSSNsOUtn1cJmksKyzRWkmaEhThN+6VCgWJl2NeBJD4rbm53bOP4zRF
	 QaSuDamGmN+BhQhtZjY/MPMgcn+oqfacEFHSS1xx0bipw9r1bwXGPM09kSAeGo/h1/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YzoKSfiC/AhSKapcw2wsRzx1iaRFXs2ZfT9x8CFQDSQ=;
	b=HEMRmugI9VSnxxmXablzhtc0SLdJ5vyaYJkN1RDaMgv2/OcQTQnUuszbumMixhnxesSN
	 ZOP8/qlrAMVvzdRWs2H2KPyADLQkS3nrysMsPf2TSiTYIe/7nCf/H8GRvX9G2jUymGQ8m
	 +CvLqvy3Fflx+SFJZsV8EPuVgeBI4Mv3h1+qxM7LRgoGgy0gBw5mhXLB46eDn7yangS1V
	 FAXcA1XJnHqicHOerWouoEcMtbq+9x+nqGWkBGLZIk1tF2aAd/cs2Mt4lp/hQzHVJaLNi
	 ltMaPFjZ4Obkc4cF0V0+y/ODCWtvijBHlTirUiJuSZqI3Z9qsJqk8Uo3uqmbSOllyYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jeteANmY;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111A606A323
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 10:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F111A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jeteANmY
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4946589267bso29707f8f.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794220095; x=1794824895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YzoKSfiC/AhSKapcw2wsRzx1iaRFXs2ZfT9x8CFQDSQ=;
        b=jeteANmY0VL6R4YvcRD4sLqKJyLnLKr4Jwz9KhI3YlBStLIh5/S/1jzYd2RICfNHyl
         5vQSK+3DCP7j1LxfoxPIb5bWHeAWj0ga1gt1BrdgGY54XdtevRmi5rh3x6yaCct12yut
         AH+F19hFBr1aVUpWJUxNMaL1NLEqNIQG9ENOWPZ9ri9SVfKqKjoTaOva1wEXWscEdcMl
         MIpP2XCX1vEv4bIXw4XV/NJ21M5tGo7I165qXR14unff+cN3G0BwrK+S1xec0B7bt33t
         ASzjyAFrAKFyCshGVMtJcPnzmPJchb7N7I1pb96iLYihQF3CwhXHjJxmRCfV6d+mwqQH
         gokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220095; x=1794824895;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzoKSfiC/AhSKapcw2wsRzx1iaRFXs2ZfT9x8CFQDSQ=;
        b=D/NZbf14XUNcuLHxBxy7zlrpMvrLJSKTf8i/8X6DHMiJuSK7cNaii/TseKRpJtDYMX
         OXe9WGdDAEGeh5wFePMfj2o4/3Gzda6g3UzBbSlZVJFDk4D/a/9XY6+YFOTcXUYWZZLN
         Pb1ZaKigAo2RtGGet/EGLZLfqfOkoz4RDachCjikULd6ZG2fdv3USz1vbJVo2e48vDfO
         zTFFdczozgtrl/Ejssx5vmsFJo7LXgp+STjFgm21CpGBzG11vkGbd5kBLO6C78GAq6H1
         ZDxSg6bra/pGlCsQ2KyzlCpm8b/5ECUd3L/TO/nsd8mHQcslILrEPcS7g2a05BTNjIdd
         vKpw==
X-Forwarded-Encrypted: i=1; AL+hErEsNGQoYwmfp/yjQdlQYEWAWk8r2j6KJoxuy5oUDjSf2qS3PvH8zRCAKcMxl07tLthXbOlP5ko9V9+UKQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+T6kSsZ6BVozuQP5DKoqsc3Ya4HL4SXDO+Gg4u/Nt3VwhO7QBW
	uziGVnIWerXl3/b7yvpVMdngZTj3ln9hl5/tbNrlSlsmV3Q7EZ7UIgA=
X-Gm-Gg: AYBFou3Wdma/Ut0/bD4p9DNsFNSQ23RFpOmjUclG5yHZKpIWeiae7kQiPHAA4zPEL4k
	2mKkNTML1poqgB+RqyJDxnpb/k4h4Yw2xQy8jZNXJGJXo4c45eL3R8oTTktcmv/sJ5JOoftL6Ws
	cbKQ0XDb/XeNSzktrxTbRfpu/pyIHQSvSBQA29zCJ7XpUiBAxucqNEbWlfOAGw7ex/fpzhEzYZq
	fYA8Fht/uz+8ItP/HV7AtPAUehkQ4/VQVoWEX2vqlJ5uqZ4h8cdeq3cPd0kPBkvzK/aflhbzUm8
	2HZrMDW2DtjGBpOkfAGv7bgh6RV2CxpTLxgNNA8y/SPyqsPXc1Ilzb/zim4uoN6yM4E4iBMcdGf
	EfUX0tIS8V+t8gWPcPyd5+oMyBGx/zr5yC0avv/6o1Jy7b/8CKKQrCVrq0SF4UUW2xtfjo6KUHw
	TG1JmDOd8Pq32fCEu5p0kfO0hfSmMf+jpEDS88v8uC6EPR6vODYrWOSS3O1Bi5yehB4AOqJcpHB
	29Vp2h9yrIUeHkAIjBPgh7mHyzn/lS6Aykekx6LAN1qJk72P8rRVOfqEYBHpmOkc72ZiRngZL05
	7VTi5SZkhvhT1sYi37xM6jF4hx/NOSPq21rnjVBIjbLOT2hHnPKAOBwnQ9ouMqkD
X-Received: by 2002:a05:6000:230e:b0:493:9233:ce65 with SMTP id ffacd0b85a97d-4957c6e3a22mr7285786f8f.0.1794220095238;
        Mon, 09 Nov 2026 02:28:15 -0800 (PST)
Received: from localhost (69.red-80-39-28.staticip.rima-tde.net. [80.39.28.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597d09e20sm9165541f8f.54.2026.11.09.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:28:14 -0800 (PST)
Message-ID: <d3e9eaa7-fff4-405d-a7cc-d5daab77ae16@gmail.com>
Date: Mon, 9 Nov 2026 11:28:13 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-cli: nvmf-autoconnect: Consolidate vendor-specific
 NVMe-oF udev rules into a single file
To: Martin Wilck <mwilck@suse.com>
Cc: John Garry <john.garry@linux.dev>, Nilay Shroff <nilay@linux.ibm.com>,
 Guixin Liu <kanie@linux.alibaba.com>,
 Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
 Martin George <marting@netapp.com>,
 NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
 Zou Ming <zouming.zouming@huawei.com>, Li Xiaokeng <lixiaokeng@huawei.com>,
 Randy Jennings <randyj@purestorage.com>, Jyoti Rani <jrani@purestorage.com>,
 Brian Bunker <brian@purestorage.com>, Uday Shankar
 <ushankar@purestorage.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marco Patalano <mpatalan@redhat.com>,
 "Ewan D. Milne" <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@monom.org>,
 Hannes Reinecke <hare@suse.de>, Benjamin Marzinski <bmarzins@redhat.com>,
 Christophe Varoqui <christophe.varoqui@opensvc.com>,
 BLOCK-ML <linux-block@vger.kernel.org>,
 NVME-ML <linux-nvme@lists.infradead.org>,
 SCSI-ML <linux-scsi@vger.kernel.org>, DM_DEVEL-ML <dm-devel@lists.linux.dev>
References: <20261109000834.513230-1-xose.vazquez@gmail.com>
 <f2b862d6106122031d3ad93ea3bd1a7964508de7.camel@suse.com>
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <f2b862d6106122031d3ad93ea3bd1a7964508de7.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/9/26 11:09 AM, Martin Wilck wrote:

> On Mon, 2026-11-09 at 01:08 +0100, Xose Vazquez Perez wrote:
>> Cc: John Garry <john.garry@linux.dev>
>> Cc: Nilay Shroff <nilay@linux.ibm.com>
>> Cc: Guixin Liu <kanie@linux.alibaba.com>
>> Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>
>> Cc: Vasuki Manikarnike <vasuki.manikarnike@hpe.com>
>> Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
>> Cc: Martin George <marting@netapp.com>
>> Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
>> Cc: Zou Ming <zouming.zouming@huawei.com>
>> Cc: Li Xiaokeng <lixiaokeng@huawei.com>
>> Cc: Randy Jennings <randyj@purestorage.com>
>> Cc: Jyoti Rani <jrani@purestorage.com>
>> Cc: Brian Bunker <brian@purestorage.com>
>> Cc: Uday Shankar <ushankar@purestorage.com>
>> Cc: Chaitanya Kulkarni <kch@nvidia.com>
>> Cc: Sagi Grimberg <sagi@grimberg.me>
>> Cc: Keith Busch <kbusch@kernel.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Marco Patalano <mpatalan@redhat.com>
>> Cc: Ewan D. Milne <emilne@redhat.com>
>> Cc: John Meneghini <jmeneghi@redhat.com>
>> Cc: Daniel Wagner <dwagner@suse.de>
>> Cc: Daniel Wagner <wagi@monom.org>
>> Cc: Hannes Reinecke <hare@suse.de>
>> Cc: Martin Wilck <mwilck@suse.com>
>> Cc: Benjamin Marzinski <bmarzins@redhat.com>
>> Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
>> Cc: BLOCK-ML <linux-block@vger.kernel.org>
>> Cc: NVME-ML <linux-nvme@lists.infradead.org>
>> Cc: SCSI-ML <linux-scsi@vger.kernel.org>
>> Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
>> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

> Generally a good idea, but I think nvme-cli has a GitHub based
> development workflow these days.

While GitHub is an option, web-based interfaces tend to limit patch
visibility and broad review reach across subsystems. Mailing lists
remain far more versatile for cross-project visibility and discussion.

> I'm not a fan of repeated lengthy match expressions in udev rules.
> Can we improve the readability by using GOTOs and LABELS?

Using GOTOs and LABELS cleans up the duplicated model match expressions nicely.
However, the scope of this patch is intentionally kept to a pure consolidation.
