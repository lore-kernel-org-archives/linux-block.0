Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D323E342
	for <linux-block@vger.kernel.org>; Thu,  2 Oct 2025 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424059; cv=none; b=riRcP8uzB2Dj5GB3HwfTyqn1oPbsMgeAu9A1g0C4DtxF2xpq4gSTT+ENAomMDlJCHxYlKOjXsHERjXpphnpES93LB0oV/6AQBgx1g8/A5qDFuFFmkKHBgBPdlhiR8ueWsX7kljxy7lLvqXssVS2qspaDh9VyT7Ohrjmn0AAWgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424059; c=relaxed/simple;
	bh=DWu5dR4Lz86S2AgggcpTnA6S7OA/C7uP7lj7+WsDpqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfPYGtIj4ZPwwZq5v1bYbUmday0jEOlSJm0i1N3jRvlWc0rl0FXxk2x4Xc0gN7WI8WdVQDpcHiD7UdE8pvfjOI9ZyAHcSEkEpxsTE5or+p+lHmLDeHno/I3r0QMoovw9A00DUedrYCUmdYBCYP4cc6kIpNkYRnHvoQmUfRcGvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FY3HUZKr; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FY3HUZKr"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-938bf212b72so41734039f.1
        for <linux-block@vger.kernel.org>; Thu, 02 Oct 2025 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759424056; x=1760028856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFqI3aHr2jj4uIbXpxHrhOEHaGHnaMLl/UipyF4uEpg=;
        b=FY3HUZKrjXbRq3WYTVv67dRMW4u+ydDODm4vlKWtOezuDNistJfyte0yLQxdnNZd6b
         YkC3zOH9GvXEw2+wHvVFepKTMLuoKjLOn4GAnX/NXX1whdFh2dFWk/HTrlBSZj+33PT9
         MpZfbbwKDViQq42JVyog79bW9VCbdpXO5Rg09uPl18x4vATRlwriw+tkvE6PWxKpydKI
         wKMkQQ4GTWYaGVyFAtSEHh0doLB2XdnR7WoPZedm5ihdmfHIpcUhgGzToQLOz5heMnBK
         AEyrruTVurB1HI6tHWc5sn+VUJXdaPizc3SCwQNY2wcZ+MV8Jyq1XIMskQHo+d/1MynD
         BkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424056; x=1760028856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFqI3aHr2jj4uIbXpxHrhOEHaGHnaMLl/UipyF4uEpg=;
        b=m9S3xKdv+8tYWeis3WnV8iOpWG3TTd1xReQM3sYoR608YLZ67DXFWK6hF2ThbfxBWU
         LAZBU7W5nUP6jeHr2+MOw0fWXZLcsnZlUA7qKku98uvoJlKmSOq8kFXf4Lz8TRJ/OcAa
         V0vCEVe+wy2SFEtj+AHZGesl0BKyXBLn8rzbwe0MUXpabhD7eWyTgj+4x7JluNF3Ukqn
         +8FIn0yLHj9/8K47nJVd+N2SdVqRHmuNCRtb/t966acxLtd+zsoqyoNSFJiWk3e4Jxqm
         MSYfp8dEvPQLvRDazXW+f6mQCAhtcBkRHD3bWct5rdqVrOEZRRqzjBCCvbznVBcyZ1qA
         sc0w==
X-Forwarded-Encrypted: i=1; AJvYcCWGT8hzMDiSe8mcIwEzW0uGETqsltIvGvjYWvkOtf1h4lL20T4lfjQU1B9m30v+UI6vSC+V1Ltqt/GeNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoB+yICDiVff78T0+nQM/SZX6sjCHAYVyZx2bnDYFwLnZdQb5k
	W97dBCfyKuOh/edG6VzmadMtIpsn/aL7ipyEXEFJlHjQOYCbZDH5pEu9EC4x1XIqzp8=
X-Gm-Gg: ASbGncvfLXDxcIsKhsQZxTF80CcuR0SU0mnwz4R7uErIGJzra7jMYIYeIQxS6navrgt
	m2hK3Fawb2beaJp0AVPtzNa21yP3J1huBtxi7GM/R1qCzx1quLGNsHkLsctMOgSZ29gcHI9GiwU
	B0I21kBs+YXTNrXdtd3hDFE4fs6tQF/z49ndENLduTvQETdQwdeG2Q5Ob8QJARv24v7/7vIrnWE
	XJe9N4mAJtKffSZUdCAzzLBlb8SGtcOnZtwztYEnqXowicrQNzYTPcE4MQydgXqP5bEVLrLCjTh
	l0aR9zUitLCAE3ti6QAIsZojEerVpoJTo/gCDMF8BRNfNplKnOsRRjIWsd48wjXUIB2f4vrpLil
	ISQtsa+iGjmHQlDfpUs1N+Dw/T+A1+G+NW8WNpD0Cmqmr
X-Google-Smtp-Source: AGHT+IHH+bU75feOc3kd43cHHM5DdNH15l/a1Pxl+MA4svn7zHgpfz9FVBhHlZNAnl8YqGJNYlTTlQ==
X-Received: by 2002:a05:6e02:1988:b0:424:80f2:2a8 with SMTP id e9e14a558f8ab-42e7acef8bdmr2852995ab.3.1759424055705;
        Thu, 02 Oct 2025 09:54:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea805c7sm1005335173.32.2025.10.02.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 09:54:15 -0700 (PDT)
Message-ID: <4054d4b9-29ca-4164-933a-49143755089f@kernel.dk>
Date: Thu, 2 Oct 2025 10:54:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>,
 linux-block@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
 sth@linux.ibm.com, gjoyce@ibm.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
 <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
 <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
 <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 10:49 AM, Linus Torvalds wrote:
> On Thu, 2 Oct 2025 at 08:58, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Sorry missed thit - yes that should be enough, and agree we should get
>> it into stable. Still waiting on Linus to actually pull my trees though,
>> so we'll have to wait for that to happen first.
> 
> Literally next in my queue, so that will happen in minutes..

Perfect, thanks! That's what I get for not being able to send things
out early :-)

-- 
Jens Axboe

