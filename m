Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24570819
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531907; cv=none; b=NA+a7UOwk37M0p8Nl1xIvvup9Bcs/PE4R2OcrI4gsdizASnponmjN5tvFY7kIBFIym16tawXE408+LazKt9BdbnElS609uHuHv4Ms+MOLwQFiz6pJcfip4QJdg+2TOI06Eng01RfeF0bRHiN4eDK6GjbAyHBXteRoJFfmDx8MmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531907; c=relaxed/simple;
	bh=IwFG6XHbwz+Qs5xY8e1emLAVY+Q2RL8TFFVwBuk8bNE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ojy+Hc13z8WxYkYSrALYt/d55S4VLH9QK1FMfz7CB52CdW9hx+D0HGkGqJEnVriJZi+RExe14MGjL7E2qFnb6sXpneuNzDkYLHGVAUfenNMlPY5LatNCAWPcKFFdJwYU6HTH8VhkMZpzCML5acJTQ5bdde1Xsz8gmnW3dNvU1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PTVCZu0i; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PTVCZu0i"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844ee166150so167062839f.2
        for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734531904; x=1735136704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XDGxAFOz1ZIJJob0FNn+F7UkMCJGzcNMN4DWFulZBZc=;
        b=PTVCZu0iNpqQDvnMy0dYZhyKvmMdnQ2SfnODzwlRTVkBWpNay0DHG2aDXzsQmeC22B
         vZjtCndxc8G2Z7xYClfbgcjM9igzd8UMHgu/ngpiI+Mxl9lWuh1PHoEOdBCfPi9IugjN
         mFYN1Z30rImfGEGMmTrK5vFWx9a+6rb+x5GM+KqAflzKpVFVf3Wec7TT9ucY0U+D2OmC
         ReLnAEoqaJxtkV6QUyqs6bCtXjoJC1fOg9Wn8P1Glf5d41f+rRzjKIs7gByfYprz4pKa
         bqFwe7llkELVvcWPycFJ0WjmKbpRn9EMKgA9gc4NeyxGOasSD3EDBxmgLgD2TSaerq6M
         7hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531904; x=1735136704;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDGxAFOz1ZIJJob0FNn+F7UkMCJGzcNMN4DWFulZBZc=;
        b=wpJLtTlR9TqUw0uUzQXrcrR71BG3VAoBGlbKVFTkYOTKwxWN+zei3+e4PqrdArkpWi
         9wjyfZIolPYou2rPe7K6v5viYKYWVwEvsiwmr/4CMQB9VO+SPvJdOX/d1hzgTo4d3s7P
         43xNooAO3uyZYeMcdju3i0eLkPuvdS7GqEg9pSOXpseI8spqzWlbQuXgwllxfBPM62PG
         EvQAwZtAFwIrcfb0WGyAy59b/LHxbg4WSEquSqPWE/J6Ap7ET9UNl6mXkVo8xfd+ORRV
         HYowpjYpTh93iQKVuHEbAAAggRPDTfO7AgJXlImxPcVAyJPNl8oOdgbT6U/d1IRzUKcZ
         I5PA==
X-Gm-Message-State: AOJu0Yydinm4CmaBhF3FAHGQ2SWO+S1/M0rWuNNDpva0mSJQUYnjsKke
	Y+yEanj6pCr7elzKmW9U4aIkqbH0SrPDQvyi5ZZR8/5rzoMsLvlbYXQKIp2D50c=
X-Gm-Gg: ASbGnctNLUXMH+okcUqd2SNQKVx1qn+Nh4GHLfq2HsxhO+oh9Ck+eEC35ZtKZ1D448+
	/LcPGupdmtw/p8OiVOmMkINILJsdpSFrFdxp1XDEHqc62rjJmkbPGXgfgV4WEcFs3DWmWzPoOTr
	DjGgB3Kt5iIi0VeZJYHlK1Wg66mGQST14NjnZhlAIS8O2e1x4l3TxWfx0G2+Z/6L8X++NMQeFd7
	hfZVn6X3fKR81MpfXVj6iSac0/4JABMQu2p43whFDFk22uAPupZ
X-Google-Smtp-Source: AGHT+IGTVbkyRNru3nJx7Luee4Ngoho+YlhdN76BflDibPijqaQyfN6N5qx+grXbPrP/steEtnph4Q==
X-Received: by 2002:a05:6e02:99:b0:3a7:be5e:e22d with SMTP id e9e14a558f8ab-3bdc013324fmr26330665ab.2.1734531904600;
        Wed, 18 Dec 2024 06:25:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2425c4b3dsm26973945ab.0.2024.12.18.06.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 06:25:04 -0800 (PST)
Message-ID: <3504c4c4-62f8-4f97-b810-f5357ffb980e@kernel.dk>
Date: Wed, 18 Dec 2024 07:25:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block size limit cleanups
From: Jens Axboe <axboe@kernel.dk>
To: linux-nvme@lists.infradead.org, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-block@vger.kernel.org
References: <20241218020212.3657139-1-mcgrof@kernel.org>
 <173453176105.594208.15853494245370355166.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <173453176105.594208.15853494245370355166.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 7:22 AM, Jens Axboe wrote:
> 
> On Tue, 17 Dec 2024 18:02:10 -0800, Luis Chamberlain wrote:
>> This spins off two change which introduces no functional changes from the
>> bs > ps block device patch series [0]. These are just cleanups.
>>
>> [0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org
>>
>> Luis Chamberlain (2):
>>   block/bdev: use helper for max block size check
>>   nvme: use blk_validate_block_size() for max LBA check
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] block/bdev: use helper for max block size check
>       commit: 26fff8a4432ffd03409346b7dae1e1a2c5318b7c
> [2/2] nvme: use blk_validate_block_size() for max LBA check
>       commit: 51588b1b77b65cd0fb3440f78f37bef7178a2715

JFYI, gmail puts all your emails into spam, because it can't
authenticate them. This seemingly happens to everybody that uses
kernel.org as the email, if they haven't updated to the newer setup. You
should fix it, I only saw the emails because others replied.

And please trim the way excessive CC lists on patches like this.
Cleanups don't need to go to tons of unrelated lists or people.

-- 
Jens Axboe
