Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C373589F6
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485064; cv=none; b=c8Z6rHtbZ/Uqzlppmr3SA8byWuaDI3EcYJkT2552vtgRnb8cYK4roCg/dT3MVdZN905fTyBBYRtobtOn7NotZVNhCEl+1z96JBXKs11Tg488pMldxZQ2Of3Z6B0cn6OA5bfDNRGbkfNlKTFaHd9eBQ/07oJ1tFz83i1ctvy+9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485064; c=relaxed/simple;
	bh=5vzhM/SIUz+4Ap7NzyjPxiiLu5hEeWvq+YIB5yuAeu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrEiz+steQZySQgbPipKr15K2px1ElkGR/wANGReny6lHGKOUkPMhb73dnBYXNFg21hopwtgIopoxkGP7u46BqUa0RJi+Gk1Yef+5CcaYNcH7ErnY/djZw0lbuVHYuKcixcqzvcc8FJ9VMirYeGRjYv2O6RcN18+Ui1+GKXwuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bdNktDnt; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bdNktDnt"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d8dcc7cd17so19201745ab.1
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746485060; x=1747089860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUXiMsRhp49WxwFrL2ZHliaPNeR8k4TvZUJR4f8P1Bk=;
        b=bdNktDntwwodXyTU3YwS4N5bvQ9FcT7EuoyUYEJy2zDHgx1gQHAFLsP5wOtn46yzX8
         WaewTk/+1egB6FpSCx005kPGlAPgxaOUAZlRpIiWkC1TmUsHvMptnFIHOCktqN3KKjqI
         2eol4iYHIeplWx117ceNmWPLG2SFW/xgORHf1RI4Zm8GDToQN2oIc1w3+mHBoJW0MN4R
         t6D0jAe6H6jhZJT6ngpPdwdq0q1zITep5ETZxvCSBQMzyOj8K7Vb3cLIJ6GlMWSweJfj
         /7ZHAu8gxo4rUyekenP7GfHOY6+CvlfFFcQIcioIEwVOKvl4RYMnW9Ibh5YwCsJn8D6v
         5gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485060; x=1747089860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUXiMsRhp49WxwFrL2ZHliaPNeR8k4TvZUJR4f8P1Bk=;
        b=Dh3EipvHUv1S/93QK+eAXoyToW33EJA962lLd3MneM71OQ0JN3/5E70waUPWtMylrF
         4wFssm35JJFalMrBZxx7ghttnhx8iY5RP1dy269ApjCR4WYxexM94kaVHhmXKUmn752Y
         /lE/LpFemV8AF4ViHHqmqXGnH2R23f7f9kvpAX579N5S0BoittU3GO5fEfQ8VhLnyR77
         Hr8RcGyTyGJTRnNpLcdfMVMag/Jh3Bb7TKKmTd+TJ3qPp1z/xKCr0E53HYbB+9sBxNcs
         OJPi3Ox+LrRSU5PdFa3OOqdar03qTa0UaQy/x0ACufrQMlfIGzRXx7cf3DCgkHy3nu6A
         e/Pg==
X-Gm-Message-State: AOJu0Ywm6y99jHaJZIVC2tf7Mca1IBOpc81gRoGXVc3aobaW9rRmn292
	YK16rSv/EWCnS+AggpTJ6HRXbTluUp0Eo2vqFqWMsrQXf+s/0glYBmNEpIMeHIA=
X-Gm-Gg: ASbGncvVJtiMkot0ZNUsETTkkYIH7xBOCa6hUxWqW3NW8GhwCDmCW9+5JO9Q3hS2Ntl
	/oPv8NnAMDL95zkRus4YKQvYLdBdjLBiMXtWiU/Ytph8H6JyE6xMlnPTZWXtOSKZrL0SOpHx2Fb
	ykrQdP/VZqrVku6t06fM0pthpkKO8aCwwC4dA5a/xQW19f0G1Y2MtVFtD+gAEMHKGAvSajKcJzz
	BaziabSDIs3t9vMMAXMc4uZDDuz+LaCsudfj1RP3+clqCcx+es0E/CgeuGVtnRAFmPapQD7BNQG
	ZX9TFzms9af5gbh0vvwpRitxr7BAwQTjQTAAcw==
X-Google-Smtp-Source: AGHT+IEf3Q5XIEWUdsdZ1gzRJ9WHwBQ516pZEGenHCRH/jbTGxBdSnDbkHR4Wlr831oweINUxTYt+w==
X-Received: by 2002:a92:d78f:0:b0:3d8:122f:9f07 with SMTP id e9e14a558f8ab-3da6cae00damr14583785ab.10.1746485060502;
        Mon, 05 May 2025 15:44:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa95febsm1944981173.131.2025.05.05.15.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 15:44:19 -0700 (PDT)
Message-ID: <3a6050b3-03f6-4c22-a2c3-33ab6a453376@kernel.dk>
Date: Mon, 5 May 2025 16:44:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
 <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/25 2:34 PM, Uday Shankar wrote:
> On Mon, May 05, 2025 at 02:31:40PM -0600, Uday Shankar wrote:
>> Hi Jens,
>>
>> Can you take a look at Ming's comment on the first patch and merge the
>> set if things look good? I can rebase/repost it as needed.
> 
> Bleh, sorry, I meant to send this as a reply to v2:
> 
> https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com/

Let's give Ming a chance to review v2, then I can get it queued up.

-- 
Jens Axboe

