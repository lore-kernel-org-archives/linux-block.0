Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4A2E400
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606183; cv=none; b=c1+oQrr8fdv/pZsyM0tBeVUFc0k3BDzWmivRo58tfM1oYbvTLrXrAABw+ihEnXG7yFIOTv1noKWqP+hrKtge1D2DxL7InySvphpmb65zALrw0EN/NtoKnvqavxEP9IlagFDEZXs+wFSaDtdDGT/xIV05+B9DH80mMALXAnSIhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606183; c=relaxed/simple;
	bh=YuGI8G7mMoSKC7FmbKPejrJWuWeUEciqXjspQA1m42A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NyutWCgLvH7xhvDGyq+8+gS0h0XOct7sqB1DV+Hohbe8GHbViwxJcxmW0Nz/tFQ4fITLSxipa6zue5Q0tvvelqLI6cRh1JD954cdlXGOIxOwIxXdRsxP7tWyH83QP+w5oZFnzTYmrOAuZm5ueGEGGHA/G/UwD6kl66K2RC3tbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Lx+NG96W; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Lx+NG96W"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso120460139f.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 11:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705606180; x=1706210980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZFw/g45Sfv3rd+FLyrFhzqHKteoCQj+JxAYdZr1FUE=;
        b=Lx+NG96W9ICCSkp/gyUSRbBh+xNod1N1mJmp9d7lpcstfaNM/vVkvqNm0X32QpR1FV
         IF1E2/QNgbbooyKlGVl7yxA4BRBruXHtFWu7y89t1ZChbe53YmiOmnNmbPlzlnuSaZbh
         d2pI06xwqM7emf3bVVU0OIryH6utTRw3Sr9cy3m6YFuSDWLb873LomGKhEiiH0A4WjrN
         aPl7VeFS7fcCYWgSr2YDrkSkxYxNJ3O9wlno4FMJiPJW6Lj8A3eUhQkhKoxrBr6L/SIx
         ZcadTjff1POuGrTUqAh3jGAHA34AJjf13QOzb1GaFvV7XbE+U36Gmc+PIqbVipsPF0fW
         4c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606180; x=1706210980;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZFw/g45Sfv3rd+FLyrFhzqHKteoCQj+JxAYdZr1FUE=;
        b=IDAamCVOu762FKflrwVuhqkAolaun7NOl3+qnaAzD38pnBwf7hFkbIB5W4jqVW/fah
         uMyHAtfrmFQ+B857LxhjbNOSkNxVwbIaNqFX2jQZwLyLnLpsFPA0rNDEPhFSIK1ki+Oe
         RKwG8nYL1ffoY+xE5rBTvYq5XgjZndVQZrlbxkpn13nj7k3nd+fa/qdM76wWq2uJzKJE
         ZWME7U92IFCXBCEYvzx8/BYQuCRl8578TBSQWNCDIINgnI9CzSzQT8M4Dz/TYi72mAvz
         IdCDwmO9Op1k6WuK0clwjPDbYwp+cIH0bbCfVfVeOHCUgcH084GSW8pAvA11HeqP13Ju
         cdaQ==
X-Gm-Message-State: AOJu0YzuYWnbK+3UIZxJBrVftKoZJnGYQTt3et63Y/1Efafojd/eKxRx
	hN0ajHGNDtPc5s58VwtOtdzYQ8c175+rbqiF2GJDfRHE2zj8atCv0sSnJb4aH/3Pfr/I6BITMYG
	63/8=
X-Google-Smtp-Source: AGHT+IHFNkrXWR72fyeEBYD8ric9y9YjXJz3EB8niJf0IdSTw/MfxZ4LgUzlqgy/mvxGB7adiZO52g==
X-Received: by 2002:a05:6e02:1caa:b0:35e:6ae2:a4b7 with SMTP id x10-20020a056e021caa00b0035e6ae2a4b7mr289501ill.2.1705606179970;
        Thu, 18 Jan 2024 11:29:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y5-20020a92d805000000b0036192817df0sm1499900ilm.78.2024.01.18.11.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:29:39 -0800 (PST)
Message-ID: <ede4179c-8fa5-4496-ac21-4e3fda41df81@kernel.dk>
Date: Thu, 18 Jan 2024 12:29:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET RFC 0/2] mq-deadline scalability improvements
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: bvanassche@acm.org
References: <20240118180541.930783-1-axboe@kernel.dk>
In-Reply-To: <20240118180541.930783-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 11:04 AM, Jens Axboe wrote:
> With that in place, the same test case now does:
> 
> Device	QD	Jobs	IOPS	Contention	Diff
> =============================================================
> null_blk	4	32	2250K	28%		+106%
> nvme0n1	4	32	2560K	23%		+112%

nvme0n1		4	32	2560K	23%		+139%

Apparently I can't math, this is a +139% improvement for the nvme
case... Just wanted to make it clear that the IOPS number was correct,
it's just the diff math that was wrong.

-- 
Jens Axboe

