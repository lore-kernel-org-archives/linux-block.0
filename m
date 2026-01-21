Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47F3BF2FF
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986223; cv=pass; b=REiV2lIjVkqtEXG9HbmlcqM0hQoP1hYJ+2rCpQN10fVxRe6cJ8ec0FfWMh1uu6OM4AOcaarTfkXR00Z4rzm9D6C8HqqFyHa/zpegFSddJBmnl1nVpexjLvEiMGgwPEz1fq3UDinqL/a+xLJc+paSSc/10fUouVg43VLgje4OYNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986223; c=relaxed/simple;
	bh=DTM11NOPytJn8e2nQ7AZnyHhLRKIS92+0tvo25T/+AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlsMYJ1m0hkiwf5QxRe1HqqeqDhmoSXeOrYHuWNaS5cfXXYc5l38FLycmdLyFVvpv6aGcgdE+8AerVxARcbNL5m+urMnt9kmlqoVRNurbulYwFCSKGdHrdfyGXFI6jNZ7LhHBi55dDyzes/J/rR430lOCoLjDsNp98EHO/IOILM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxhOLVE9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tadpvrD1; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxhOLVE9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tadpvrD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768986219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP9la3aMNoAWVdP2WHQh7XGSfccjdpFKMpYPe5dyJ1w=;
	b=HxhOLVE9CXM1+upD8XDebPbveIadiYn69tLwWJt0jo4xoFPzFXKyDeC65tXQo8rmnmZdhC
	AMmMQkrQoN2exjlof7CmncbhV2dc+CpyUjNjqRaPe/Qlh8tfqZOR6d7VIXn7sSPrJXefi0
	2pc1xq4PDmdZMsi5hsmGybPwO707NX4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-N83E9tD9PgeKy0ggOXm_Pg-1; Wed, 21 Jan 2026 04:03:37 -0500
X-MC-Unique: N83E9tD9PgeKy0ggOXm_Pg-1
X-Mimecast-MFC-AGG-ID: N83E9tD9PgeKy0ggOXm_Pg_1768986216
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-59b2da78573so5481295e87.2
        for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 01:03:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768986216; cv=none;
        d=google.com; s=arc-20240605;
        b=iDp71789QqNt10IOYJmg+CSplcUT1qjLTf34ZXHCgIKweETfTZUqBOjjPO6sJZJ8ge
         RNaDFJfcSPpoK/0kOEisI4/ii1XTXgjvj7PWE5u2aEyW70zEIQBm+Bzs67tW03PGoT72
         upbPACSHZXfts/OnDX+5vC8wmvwwISTxVhlnR+/H5d+zyJp+WbL7mE4fSJMfSj+tzfiy
         Tpj2mylY4Pvcd7ck3e/NDf6K78oquvW/poAXkoeV+9HKfPAxOhrOmsh6WGW/YvVAwA1l
         LLK0krFVSueAl+JAhycu/5MU630BSjyyoXpgVAWJKzJuAX0lM572bkPyHVoPfhgOurtL
         qCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nP9la3aMNoAWVdP2WHQh7XGSfccjdpFKMpYPe5dyJ1w=;
        fh=HX6Ar3CSuow9xltRxp3hO2ACz8rdIgAxXv2r7limy7E=;
        b=XVqKIgCUEXab2Iz9FhaW5IOl/K1ZHSSJwu65Rgjl+f4GbCuV+r9JTn51GweSkEzCpa
         /uX4iso0M++2Pmk/YoLQq8LuxUrJD9MLOfWkIZEcrpV7145bOC0yF48/vJHhFxxuTYU0
         /UcInaMlEye0e+RoYdop+TnOaJTfas9PyJdYIs9nCgE9g+ymTSrMCkFEA6pvJlUO3edo
         eBls6fSK1NC3kHMKv6U6TlxQiwAloN3BNqTubJ3SPF2I+z65UKJVhJK6Q5ubjg7d30oa
         KHbdtyFNsE08cOY1MTkdi+S7cUqJz4Zw8vkAKCqRXkJEbKLwOoG+Lw4ASFcsYlG+kJaA
         cJZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768986216; x=1769591016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP9la3aMNoAWVdP2WHQh7XGSfccjdpFKMpYPe5dyJ1w=;
        b=tadpvrD1/cEvF4dQPpKXbvEZhxFRK18BiV2W/kyzHsHJj91ODbm3pbKVhH8A4Yi7jL
         +s/HaweP7w/Us029Xwbyin1hgIhiq1zR6B9Dc3WWYGbO5CNjPT9lEelMLQ9k1WK1GRAb
         NlqDW5iOroOnOnwhi9Ahm3PqPzwMbSPTEaGKxvGdIk0CrqokHtLaxBWUeg5cYc2MMqjB
         psHMSTtZ9V4Mzj7uG4s11GFhIJenxW4oCpfHr5Rh+MnslKwa6PrDVf2jP/WmhqbS5ZE1
         Ih7fw5fk2qSN6n4Ec5St4iIpYmMsK4cndyePmczBhLpIIFET8YtWzP6UClEDqRz6RXP8
         i9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768986216; x=1769591016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nP9la3aMNoAWVdP2WHQh7XGSfccjdpFKMpYPe5dyJ1w=;
        b=wMnDPrBfFSUSoxa8iZxx6iFdedGdV/QkOzcMRzHRpIWDFIwiWl/ht2EQK2x3sjMj2g
         yCtCl+Pmi9VlZ+Rlz4jiaFWJvB5lA9OS6YJaE2ysxVmWvRfA0nNkLQSEz4kwEWzcVBuC
         CC2ZabC4vv1YLpqMxoLz9zkf5iu9iPPESSvzh06oIKkU+j1O3NWCbIaJtGJ+ci+4bcP+
         7Qav1ju4rvOUG/8V0l+lelJq+mVFvc0csSIa5ewu86NpKRk7aKF2VZLHEQ+aZFarQaa1
         Znozg9KEX9lg8K3daXOAKV9Tqia4trXHY3+N36Y5p7qjC0pHFOrUbiU0T+w6uO+V/atD
         dawQ==
X-Gm-Message-State: AOJu0Yyqtxe2BMJwTrgamh38szwSNPWFLBy8LlEE6XXYodIqvJN2ATMe
	Sfe1Dk+HzzNWOgcIVJcc54hUX+95mIHX6A9XDjwW17RMRKxKiTSl9Tm6HEAjIwfF/cnuDfB0XbF
	0V++hrvR0ByIkYDoGeCPYg2A2VHaZM7tX/PGeS3pMR5uIDWat7k5J6i/dag5MNw5WCcGZRL2r9m
	MH/koayRAMwKgWIdknQZhXyNwVg1q3ZrtMyq1kULE=
X-Gm-Gg: AZuq6aJ0VqlVFaMezrRjF/5JUcjSCQoxFhbjIHkhbYPfMi1LUdwBgT65gl/8U5YqBXL
	yAX/7CFqjjNUK39sqEHfztpQExzDzwg699oOFkCWbcpVoAPKYQBu/oGZ0cYT0OmV2fFbXrIiICp
	N3+r17Ufzf/UzO/oy4Sp7nK1P6/o3CopSZrlaEy9B5WppkJcn5rGGpi/yLizDwcDBrFOA=
X-Received: by 2002:a05:6512:3b0a:b0:596:51d0:9373 with SMTP id 2adb3069b0e04-59baeef7cadmr6418641e87.24.1768986216171;
        Wed, 21 Jan 2026 01:03:36 -0800 (PST)
X-Received: by 2002:a05:6512:3b0a:b0:596:51d0:9373 with SMTP id
 2adb3069b0e04-59baeef7cadmr6418626e87.24.1768986215747; Wed, 21 Jan 2026
 01:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
 <aXCT9sFChMdhwNYw@fedora>
In-Reply-To: <aXCT9sFChMdhwNYw@fedora>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 21 Jan 2026 17:03:23 +0800
X-Gm-Features: AZwV_QjzmfPDk7cwbCp7-iHngLSxmXDTNHSTGJfvptIwf4Q1GJXRD3Dli0WxjZY
Message-ID: <CAHj4cs-VK+W6UXeiiTdarw+MoFtn4xe9diU3CtHXaRy7kGQxgQ@mail.gmail.com>
Subject: Re: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU in
 nvme_tcp_poll() on the latest linux-block/for-next
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 4:53=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Jan 21, 2026 at 10:50:00AM +0800, Yi Zhang wrote:
> > Hi
> >
> > This issue was observed on the latest linux-block/for-next during CKI
> > test, where enabling the poll queues leads to a tight busy polling
> > loop and 100% CPU usage during "nvme connect".
> > It seems was introduced from v6.19-rc1 and cannot reproduced on v6.18.
> > I will try to bisect it.
>
> It may be related with f22ecf9c14c1 ("blk-mq: delete task running check
> in blk_hctx_poll()").

This commit merged to v6.19-rc1, I will revert it and retest.

>
> I guess it only happens when `nvme connect` takes a bit long time, not su=
re if
> it can be reproduced 100%.

Correct, it's 100% reproduced.

>
>
> Thanks,
> Ming
>


--=20
Best Regards,
  Yi Zhang

