Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF330E82E
	for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787476972; cv=none; b=IQvqWSZCZ5DNvbede9GyKhnIXlH6BhiGvpnHfv8LMFM4kOs3fS76O2ay1aBlav8gkQ2p8WgXaDQ2oNUPxS1F/OfrgqArfttoNRamVasYoLOSdz+qO5UuG0BTC/MOSpwAm5eRVr/YDgiaNo1U2ovqQEOkbowzK+8nM6QRkEw8+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787476972; c=relaxed/simple;
	bh=ZAbM5ZzSRQQctOQdSc6pxuB1NSI7fvlayIsQMqy2b3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5GIpepwWIWyYVWdPKhqqVJfIGAluFkAgHpuQffr1mlXXzHwSIKbjyUZBwYmhaUyLMNMTUO15HZ2Kw+j8Wrdq6fXh59x4jRa3SUNLkDPO6W320mynn+cOo07gIrmqmIFe3i29c+1JhtwlDCApex6j+SOnsfSYm89TRDpK5L3b6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso5805811a12.0
        for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 02:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787476970; x=1788081770;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQiELkebPQsa4teNGioOnmp2bdecpMGlUV1ID9pf4MQ=;
        b=Hr3iqGH3q2aptcDPiA7+0tYfaJryoaV+7DzRZav16xWNYqhBr78cOu7COdcR9iLGwE
         zrC3R2EWi8f030yYwtUDhjL5mzqeWu3tjpsyY5Qcsh1xPM71PVDtIxaVaj3+KeJjoypd
         j5wsvmgJljhPGP7XAXQc7DRHoW1HV3SNIoApb4Gcpr/mgSeaZPyfiFaR4vKqgw9iTBoe
         kyn5ZIXZQdpmc9wusT+oJnTidgdRWYgcXxHX7YVajY3t7DHrj94e4VgcIkbt0Luu3HZQ
         aq50drwuBSwFRQAz7pdkOGwwTHKSlLU3pxdJCU8LKzqjQsiRL6A5n7BqXSk+yqPkamD5
         Mu7w==
X-Forwarded-Encrypted: i=1; AHgh+RplpaXbFuTdx6QIJaHCd+Gx8RhOBTmlnSkIdje7+A4SN8Whiyyk2PgmDP+Lid2CvP79/rju5U//zCk0/A==@vger.kernel.org
X-Gm-Message-State: AFuF++mHjfSqpD7P8r5lUfs0dTjZP6EYc1mfkJuA+z/sMjJpBfHlXPdZ
	jTwqJXWQiVEAr0XNqdcQ5edfgmqcMN3fzzf1uH6Ft8dzJnpYm97sOAFX
X-Gm-Gg: AR+sD13htn/m3x3dFrVdASUUphRDsKxICguCN08YxHFbdih15dq0n3nz08WSXvq5bEn
	bYLMdVFTee+b0OBY/RMYR8lr8RLPEPdpwYbZbs0aJA7g+VwPyYjqFX3NlXiOewiyqIMG6gA6Ntr
	GBbTBCO3ieEC2ZASzuYn7Buwig21PvS59sn+claHkjFkso0JxxKFS7UWPGWCMPE/z+nIyEAry57
	kedqwQB1F1ywJH8bzs19U/VA4RY5gETDqmmVoat4502+dU/FEUCGWCFXh2jqAQwBh0Eac9B5BjW
	WHEclvRVRVNF4nZiWr0iSNrm8aT36gwRqonmyecMgKnx+x79Ui0n9Wtulsc1oxm5gI3zAIceaUE
	9Ap8wOYqwH+hcduMh3WqJr037uflbvZsZoLc1pO3PEVsOu81SKmxJVdUDahCBuXDWvpIWdj66pb
	C0t/2ZJ/7HF1CNB78Re7HJHvX2bZ8L+p8vr8vhpTvQ1wP5HzU8XTEToIWLFJX5nHo0YG1oSU1Zz
	28d+zb8OmlH9ubsxLJ2hAoaZbqGFg==
X-Received: by 2002:a17:907:a606:b0:c20:7166:cc16 with SMTP id a640c23a62f3a-c244d86531amr2601546266b.15.1787476969598;
        Sun, 23 Aug 2026 02:22:49 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1aeab9sm2629558a12.22.2026.08.23.02.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:22:48 -0700 (PDT)
Message-ID: <cc507305-faa6-44ff-b830-72b8de023a8c@grimberg.me>
Date: Sun, 23 Aug 2026 12:22:47 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered
 context
To: Keith Busch <kbusch@kernel.org>, Chris S <coshi036@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 tom.leiming@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org,
 Weidong Zhu <weizhu@fiu.edu>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-4-kbusch@meta.com>
 <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com>
 <anpBQXfo7eGNU2-v@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <anpBQXfo7eGNU2-v@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2026 0:23, Keith Busch wrote:
> On Mon, Aug 10, 2026 at 05:12:45PM -0400, Chris S wrote:
>> Keith, I checked this patch against the nvme_setup_rw() WARN I reported
>> (the second link in your cover letter).  __bio_split_to_limits() is
>> called from blk_mq_submit_bio() after bio_queue_enter(), on both the
>> cached-request path and the newly-allocated-request path, so the bounds
>> check is now serialized against the freeze window in
>> nvme_update_ns_info_block().  With the capacity forced to 0, the bio is
>> failed here and can no longer reach nvme_queue_rq(), which is exactly
>> the race I hit.  Thanks for picking it up, and sorry for the slow reply.
>>
>> I'll drop my own "nvme: don't WARN on I/O to a namespace revalidated to
>> unusable metadata" patch in favour of this.
> I'll need to revisit this approach as it is dependent on something in
> the stack calling the split to limits functions, as well as the upper
> layers error handling for a catching the end-of-device condition later
> than before.
>

Perhaps moving it into __bio_queue_enter would be appropriate... It already
does disk state check. Perhaps introduce bio_post_enter_checks() for checks
that need to serialize against queue enter?


