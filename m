Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB918486B8C
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991171; cv=none; b=SyTQcIRnP04xSyptpV+h7HbgDAKyAOy0dyIYayQDnZZbcPtPf0DlbkhPNGQhOrVE0np22U4qe3oegs9mKOVIV6Hcc5rLnHRawlLj7T6O/iTDs1CV0h5OkCxL0zDtnzKirh6ZQ+oN9Sq0KXSE6RAAMAnVNQnKQMc82SStDM0qBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991171; c=relaxed/simple;
	bh=7JeXBQLqae/WhahNYE53gzs3rKK7p/5RFDwmui2eLnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyVJAw1KlchXEeljCLy+hyvQbqAXW9wAN+e/Sm9fhceDBBZdEWFD0qZfPJPswXyzzJ6MQrCnvPQb/aSMixC94Rl+PEP75TAn1FmDS5KGVfm6NNqAt4s7lvYjLfwtV8g/xG4spwKEWlWEDehkgyTpEtBxhsDQR/+CdOr3iyS3TfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=tQVEHSG+; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="tQVEHSG+"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so496923f8f.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 04:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1789991167; x=1790595967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NySXqRqBMQS4yyS45j4W45LZP8TO8LAexSEh597hdw=;
        b=tQVEHSG+q1FiJt8yl0xxUwmuc3hCNFzcAmz+NVuIiIBO0c+fmXiev4fF+PBek+Zy5u
         sxfgeOdqB0evAXf6b0IpPss1wfpvxFYZuqcFil/UGKfDNU0B7xWVRFxSgxDhREp3+NeY
         tMDVeKRR7LWOKXxZBCdTBsMkmzLoLGpr/Rx0AmccBovIZudJeNzdM2hhZUmKHnAzqovZ
         n4mZKq5gRhCpT0vGUXZazOwtURDI0Z+ISwwwRXIjShy/ja1q8WHh1CbRe6D15HCeo8WZ
         miEi8qnGu/WieaOzBQFrfnHpQFQk0Db1KwIOeJHQsNYm+CQK2jKYA/YsSS+hwgm0arWq
         5K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991167; x=1790595967;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7NySXqRqBMQS4yyS45j4W45LZP8TO8LAexSEh597hdw=;
        b=MVTRf49bunmsOVB0fJgyN2Vy4naMrnSZ68gIFHhWvzkBFFV7Qbk5YT0x1YkcyyK5qm
         UJCke8LbdMmatCN2vgnBj4c+pbJtP4kR8iwq0jqklwDEo6hKD2q1tVXh45gZc28FtcPw
         pUbY7yaihoU06GaoPGfk0zOWftQxsnfIG2w5sKBZohpcEOADGaU6J90VqebEzrlsVfFF
         5Wo5A+IvhWy1PQjm9q5HTgVyaDFLWegM5PMbTGTOH/sTuvyyk7A0e831F/R9r+mxBe0a
         f7BKOAEEjd/gOoO2Inz9GCqvNqaQD3ECo01E8khptIXZcwyJGCubWppsMDMq8Fqy2Sbj
         4pyA==
X-Forwarded-Encrypted: i=1; AKwUvBxSsXl1oMjGEfgyCT8h9U9FEjUApSv3ku3cqXNsxdFbfFMx1qE5pLlrIuCAhYcT1enNktXLIwCno71QQQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n1mSBxP9CUK0MxiCP72OfEoZu5+Lt6hnNE3GydPYR2qckDcE+G
	tw6s40c9Ms/cK9m3Xdj5WHotWaWAdoixIySg9ed9blp4QSDVEgr5a8EP1LKoBrwt+VE=
X-Gm-Gg: AYBFou2ZHy03+smdEwAEetIL2KpDxUj21MfX+rVwuSYFwyoxMJ/7ucE+8muPVBHizrF
	oPtXTuic/+hEjaijGadNlGOOpsokwXJF88+7wrU6+HHtWvnPrVmblkMaNQYhPVDABILob6aMFX5
	jfQE5yEMRMV6YdKqL2/HT9AgCjogvFPfDYbDlczQcbybC+VpIxj3NEUqTj3JPk2zjhjOmKHFFwR
	UTkROKuOA6Y6wbTRlYPhIW7nMXypswvvS/pPmEUPNRGMI7h/f2XfiAhY8kaViamOYnhfGWGXYI5
	0S3XQUeQrJEr1OF8DMsVWeO9eDSa8bxPp8lEtro1LCdQexF2ZDDwhsiCRPArXVrh2Kp6lV9bu/L
	GGgguQpxQJ7NGV0rK06/ej19NnjAbYkYTpDC75lOdMq9PS0gcpF0J4LAFp5+0zpB8lKSEBASPxu
	vt9XZVNZxIADrSgC+B4LfR6Nq9vEX/bZ/UFqLEgKE1aO4oIxc0Kzb98XdoJFsQFCFzlGzdOcLAx
	aH05ABFIquAtLYaNDltr0obYp7GUBqKk6hWflZfEI4k3vCdEFV+UctNWyjj
X-Received: by 2002:a05:6000:2909:b0:487:355:4619 with SMTP id ffacd0b85a97d-4871e2159a6mr15005534f8f.4.1789991167137;
        Mon, 21 Sep 2026 04:46:07 -0700 (PDT)
Received: from [10.190.130.145] (178.115.89.92.wireless.dyn.drei.com. [178.115.89.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872459d409sm21348115f8f.33.2026.09.21.04.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:46:06 -0700 (PDT)
Message-ID: <b0ec8c92-cf1b-4e71-81ee-cbed5db56365@linbit.com>
Date: Mon, 21 Sep 2026 13:46:04 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use assign_bit() where applicable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 Denis Efremov <efremov@linux.com>, Yuho Choi <dbgh9129@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Hongyan Xu <getshell@seu.edu.cn>,
 Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org
References: <20260918141609.3022848-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260918141609.3022848-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/26 16:16, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.
> 
> Done with Coccinelle semantic patch:
>      // set_bit -> clear_bit => assign_bit
> 
>      @@
>      expression cond, bit, addr;
>      @@
> 
>      -if (cond)
>      -        set_bit(bit, addr);
>      -else
>      -        clear_bit(bit, addr);
>      +assign_bit(bit, addr, cond);
> 
>      // clear_bit -> set_bit => assign_bit
> 
>      @@
>      expression cond, bit, addr;
>      @@
> 
>      -if (cond)
>      -        clear_bit(bit, addr);
>      -else
>      -        set_bit(bit, addr);
>      +assign_bit(bit, addr, !cond);
> 
>      // __set_bit -> __clear_bit => __assign_bit
> 
>      @@
>      expression cond, bit, addr;
>      @@
> 
>      -if (cond)
>      -        __set_bit(bit, addr);
>      -else
>      -        __clear_bit(bit, addr);
>      +__assign_bit(bit, addr, cond);
> 
>      // __clear_bit -> __set_bit => __assign_bit
> 
>      @@
>      expression cond, bit, addr;
>      @@
> 
>      -if (cond)
>      -        __clear_bit(bit, addr);
>      -else
>      -        __set_bit(bit, addr);
>      +__assign_bit(bit, addr, !cond);
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/block/drbd/drbd_nl.c       | 16 ++++------------
>   drivers/block/drbd/drbd_receiver.c |  5 +----
>   drivers/block/floppy.c             |  8 ++------
>   drivers/block/mtip32xx/mtip32xx.c  |  6 ++----
>   4 files changed, 9 insertions(+), 26 deletions(-)
For DRBD:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Regards,
Christoph
