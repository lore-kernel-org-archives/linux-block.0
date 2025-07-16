Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574ED2F50A3
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669769; cv=none; b=mnwMoZma55yJEkCQmXi6BL+xGM6YkkaurtBbB5EKjYHqVGCpn1eG4omr6F220GNniUJ1okhRLqJL5uudJiAORZV9UzAWSSMPjmApgNj8f8F5bZPNQtet/9ntuWyZ6hbL0w4SlNrEs2WALOXk42fhq9s6Ih0Yk5995S0hKCpHBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669769; c=relaxed/simple;
	bh=PQrBkQTNit79aY5TWiavj2p46R9zRBWMt92Hr4xcPoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBZJa6Dst+Iih2tBGOlxwR3aAoP8bxIIul5+65SGk4fkCXWCp89xPGsL3IW8UmgLjWtzHWNKfa4L4Rxk0p72bdQae9ZbXsWUz8vzNKlTCT0ghsTKnyH+Ey/14tS46uuuPxwBh9K9lMlt7z1TECdXcjnCY3owd0sL8+fEvPiZGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wzxEgpbs; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wzxEgpbs"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e13a58191eso55752465ab.2
        for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752669767; x=1753274567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRTgLvIeTVdmv5gEosjnjFza6w+DF31dimbJth+OV18=;
        b=wzxEgpbsd01cvjqtmmcJ/6mcHSQQJwZIi3+RzJyEVY8KPabh3ZgNXI8qv4YYKRvwL5
         Y0+HFx6aKo3XzJBA4mcpE+oFoIi5X9YVKA17j6jYym8CMFbVaHlvhuISAB/Z+GiBkEw4
         YogxjPIilzGpOpv14gaNWjMtwnWzUOH4GqM0EiSOO3gfHhlYMYZw7Cyv36MdOhuE+INr
         XOJaHa+sPYSiSr1vxbnXf+A2RVrggj6SW4O1L9Cjv7DxSi2hf8Zbsa5khwyapmBQYrwf
         z2L0FRQi7qpC6LsJxvAzXPMm8yXFNeJIf81r+uTtSsjdLhyDx/QdvSmL4z3In5KkP1so
         sw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669767; x=1753274567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRTgLvIeTVdmv5gEosjnjFza6w+DF31dimbJth+OV18=;
        b=pejIIRfUa8jxiE6SEVRk+8n0CHeF9SLIShdEhx8IjIIY1KIiIcHCsE5PvT1ehqGVM2
         Z/QgPLWp5qOqv/uYJvlRmmnIjhCYmHUz2/B3dQ+/RWC+FwzLCF29fwrrz7Gw9SN407tQ
         j6sbjVxvM4MBx2zt+95DAdWXeDcFIYjm0hnl1DTjyay3DKo1GJopigyj5VFWQStMhUjg
         tckfu/saOR7qc/3WS2DRaFmsfWY7plodMM8H2R717B7QGv+Po04D6Z89uMDEVX48RVEA
         mw5snhpe3gCPJZq1NGRHLR2F/xkYUAocc5F8YfQAokU9D5kO0scmQZzxrEcs4p5zb1Pt
         OoRA==
X-Gm-Message-State: AOJu0YzSHiwJIBxHnR/Pib+wJHK/+nBnWrUW5UMHxsvc9oB2JRvmtgHZ
	TN677ONauTHxocEUdyQO8enqfKrOtRkVe0J4NYV5i1W1ML4NLpaisT2c3axkPwjwtac=
X-Gm-Gg: ASbGncsB/RPG1NSdqNoZwMUP6VrV0bHfem0m2Ka+0CFM5gUbrIYBJ8N9Kv5CaAqSljH
	tW7W3yzc5xR0PI2kWUyM0Z3moxXsPTYBaJEsoZjlfyC7YlwlZ+cowf3C9iHCE8But2xIzXZzGUX
	iXKBc8vyB0S78GbFuCzQnQEbZLl+FzAV1spsfPhIt1GsFxAj8PTI9lVcuYzdBSMzO8kkAsuYDqO
	333XJj/TJxpgXebcUDDUXRmCh9BJxH14tPtDoQTJLiIfa8beO/D6qho2K0QBf6wg5xOuUQKCd2P
	jg54vj5DvKtgCYW+LBC3YhSnzGvrKHxkVm/9/ez6ZT8OlQn2vqS4glpCEsoutzZ7vA+DfPCPeV4
	KBoo3D01/6+goHwNck30=
X-Google-Smtp-Source: AGHT+IF+LJcfBS/2chcoB9A3s2CNXd8k4vYJsnjyO8+5SgFhywXDKW10w3meCXUDwX+iqpDHnDeQXA==
X-Received: by 2002:a05:6e02:1a45:b0:3dc:79e5:e6a8 with SMTP id e9e14a558f8ab-3e2824e7123mr31224415ab.15.1752669767387;
        Wed, 16 Jul 2025 05:42:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620ab8dsm44372355ab.43.2025.07.16.05.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 05:42:45 -0700 (PDT)
Message-ID: <165c8823-ab20-4f1f-91eb-3712824f9e02@kernel.dk>
Date: Wed, 16 Jul 2025 06:42:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add block and fsdevel lists to iov_iter
To: Christian Brauner <brauner@kernel.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>
References: <20250716-eklig-rasten-ec8c4dc05a1e@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250716-eklig-rasten-ec8c4dc05a1e@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 2:40 AM, Christian Brauner wrote:
> We've had multiple instances where people didn't Cc fsdevel or block
> which are easily the most affected subsystems by iov_iter changes.
> Put a stop to that and make sure both lists are Cced so we can catch
> stuff like [1] early.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

