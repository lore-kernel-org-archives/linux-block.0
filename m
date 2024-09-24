Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BE1474A4
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188484; cv=none; b=V07HptQcFgKrfPDwure8Ag+ispPvQ0RUlATrJ9we/df0Z3G+i87xNZrrwLd6aHBsEBxGw1mcxwFRjMxPQfqYjt3WX86CuKA8jf2qcYGALzHTo4hA2badLkFVFKEy9+FF4bfEbF7zvn9+9Hynh6MIPWxu1IfHaaJboFr9jzzjpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188484; c=relaxed/simple;
	bh=SGH6SgOXq8RqsLIWHNeN+dH1Qp7pRoL3FGAMeUT9K5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+HO1PE6L/CFcYJin7eIy+ZS65i7jr5t5K+BkBRwgYAIyhCM3XA6C3J8cRvhHEBhESGcNb0KVJDaArDpeoXpX6LtJUr4YbTIYYbkUwIUmsYCnH9u5477e+5ZFWUna7aazn2vX54cQtBFNqS8vZke0VNVhmZXjRvwNmQbk6Rz8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ja+p/uqp; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ja+p/uqp"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-710d861eb56so2448709a34.2
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727188481; x=1727793281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJyEo6t2FPXqilEdxVr18TZy7vepQT0NH0k624RGqqg=;
        b=Ja+p/uqpJuJXxTyqk9czi1hxZW9UPG/2fXwtva6bgcFGWevYLhrS87zjFDbrQrhKRC
         1U8d6jJGralsuzI5Fh/pUqUIunX80FsnIARqDvRGHyiaPkCOHnf6lw3487iFzyUywA5k
         q7PBwmEQXYS/T35SgIGxpS8sBSqN1RavQINALwE45UMmnVZmpWThVUX+aMN0EWgJ07Zp
         BdVJdkCqPqOuYtHYhIbWp1o/I7r8Ycec9yeZ3nyQnI1AvWh3TsA1tHQZLx0BhJJnFub3
         UASp3VxfnVNFEjbMTgMbaCS9wDNcJ79Wa0ft7BCBFv9o3b4lzfgf57c21gZ6CxkBVrY8
         b08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188481; x=1727793281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJyEo6t2FPXqilEdxVr18TZy7vepQT0NH0k624RGqqg=;
        b=TmmllQqxuvDnmUnb4Nlj6PzryfogOtCCzCLNlGmLVN7MXbPreGYITDsU2ZRWtb/z98
         wSjOdcQL/Begi11JTKsYMcK14w/zNbG3uY6+dvv57KZbYa6RFVJ3xSvZmh8f65UOan+n
         I+Y1/TIEeOdndxqdhMRLPEhBoR2GMDFUJ2M0tNmsLrm9oretLEUWtWViu2Q0HxSvDWCV
         PyxjrrouboXjq/PV7eBJ60Xg7p0Yf5eLGBE+sATvL6VnnfG0F5/uCCMBiEq1TxYPV6J4
         iC3l5YP34Bfvv5x/911eUIKl3DF25/LyZlE1ofCMvN0imwnkTZF1CjqZztutKNvTkkJJ
         EnMw==
X-Forwarded-Encrypted: i=1; AJvYcCX27fZjHB0RFobsmCHjjhqvG5LTdoqho9TRpYoyLtQrbgJ5gRBUzetpKQndgNfFodLXTr91eOEnxIIuyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwL2jJgoHTfccjqQ3KXWpOU6jf/weawFhfAZ615tt9/zH+PqCt
	OhJA9qnrCi7HwOjNrnxsxYaloE8sILvSogFLT0ug6HOjT3Yxxe45SzBTmllYX3A=
X-Google-Smtp-Source: AGHT+IEihmAPBM9nzF3WcyEafFp5NUAmItpxd1xotxyDrJW22eg2qfZ2kr4gu4qCdegjrjRLCmr6Ug==
X-Received: by 2002:a05:6830:6383:b0:713:658c:cb1d with SMTP id 46e09a7af769-713923ced57mr13011222a34.13.1727188480797;
        Tue, 24 Sep 2024 07:34:40 -0700 (PDT)
Received: from ?IPV6:2600:381:a906:59f9:da8c:37ad:a36f:91a8? ([2600:381:a906:59f9:da8c:37ad:a36f:91a8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-713beae42f0sm410842a34.31.2024.09.24.07.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:34:40 -0700 (PDT)
Message-ID: <85bdae7f-4911-43a6-a68a-3f263d4c1811@kernel.dk>
Date: Tue, 24 Sep 2024 08:34:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Prevent deadlocks when switching elevators
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
 Jiri Slaby <jirislaby@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 linux-block@vger.kernel.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240908000704.414538-1-dlemoal@kernel.org>
 <e30fe828-0786-40d7-9da9-4f570d261542@kernel.org>
 <47b98ddd-631a-4b49-811c-c0c1fd555d63@applied-asynchrony.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <47b98ddd-631a-4b49-811c-c0c1fd555d63@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/24/24 7:08 AM, Holger Hoffstätte wrote:
> On 2024-09-24 12:46, Jiri Slaby wrote:
>> this broke udev rules for loop in 6.11:
>>  > loop1: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write ATTR{/sys/devices/virtual/block/loop1/queue/scheduler}="none", ignoring: No such file or directory
> 
> (etc.)
> 
> Patch here but it's not in mainline yet:
> 
> https://lore.kernel.org/linux-block/20240917133231.134806-1-dlemoal@kernel.org/

It'll go upstream later this week.

-- 
Jens Axboe

