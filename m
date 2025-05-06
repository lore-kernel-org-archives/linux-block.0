Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8F280012
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539126; cv=none; b=l/6R33e7lPcpKo/oFnYbZUsU/z0Xm4r6xkJLg6D5VjTsnv/xKMWpesewdIyUPS8jM7ibqF0CkUhzakfCC2pFY/RDVJqANUMDhp5H+Lqfq5YnMsv0ak3k7bred0PxgGbiqyxhor7zUPN+VCpbiluzICAx8oZnxf1ovTgudrZFuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539126; c=relaxed/simple;
	bh=CWhLWoJ68d+L3DttjMSCWB5CLe+R3KlOs9umuFuQpdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6R3/RpBqDQPD67WcU3jhKg1lNw27+6T9FrTkEx14pyztGDXHuHRnkufzqOqlGpyzjb+XjxZRCSFY24VWXsYG85XfAOahV/LwWXib9TVdF6U3kcqfakz5G+1IaxWeISqlyo4081nzw4F295veBrgoXdxLBip67N29y1UQ7sfWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ewnkrJKh; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ewnkrJKh"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85e73562577so586791339f.0
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746539121; x=1747143921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKxeLyjdIQREoHI8o3puEaH0t8r7tm9V/jgghIF2Dw0=;
        b=ewnkrJKhuayJUKWstDCU9W0UHZpPhLq58Z6/BG0PQfK5lmhGeG5ZEHsABKVtsvOSQ5
         bawYNr2Nvaa04qYiF7XYBO0VTMCXzoIufgzhdxYns4dcm1qekVDG3vmQGCGi3ZlamIsh
         BJD7HXDEqsRo8UzNns6jAZB34ypEFto58qRwO+1ItEv7oG7hk9VSJYj2lBwbfoWzKOwW
         aMIGLUuL10ET5K685E9N9DiohojEIY9qBneQDbfaPDhtPE2/LWEKIQmDeWIWRXnWha1w
         q7GW+kuzIlF4u8XXLzSt3ZUtzZt2AzoWibEV4AdzpZFzLQwSlqcm4iz/pOC29cFYV9Lu
         jd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539121; x=1747143921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKxeLyjdIQREoHI8o3puEaH0t8r7tm9V/jgghIF2Dw0=;
        b=bYtbDvNW9iis90wJLmNtfNXto6vohdW7ay7Ps69lvi+pknU8sC6XRQRUpeCF/7B1LM
         TdSOj4YoyOLfvca5fMOy0gUg54KJB4JqSkKil8KTuQht+n+M2uKME0EqOA+Gx7plTp00
         fjbbSUU53mGXNlrW7pGe3CjNmTGGBTF+bH67MPJGqFaUUKW+u3/sjY3hRjsjR3nWghpn
         /WNu0CtJ2ygF4BzlV055ff3qm4lcJOEWpQA2iI0u1dDmzynCaBgbTSJ29fl3IOzOu1/6
         018v3gD86LEgq+ulgCfNzJ2XpjRLTDGL3agFqTiWJuDGPlokEmgmhXDwlcCBr/tJd6Zq
         aB8A==
X-Forwarded-Encrypted: i=1; AJvYcCXtimJSuZdsy5kejpt8CRPbGAwzwV5hz/SOLWJo4sK6Md24gXDElaflBURYPv5eU700jETj7jIM/8fLbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5D559AOmvWijn4UXfxGbbf19ghhxCBYWseYY2lulInVYapcLe
	1lc1Vz+e0lU2110m/B77z3iojgZVBbLW16z+gXk4I+38NY6IuLO926qy2/9n+I0=
X-Gm-Gg: ASbGncs4TPBt52Auj9nl6NMTj12ag8G9rH3aIGlLZ1NzSITAtZrg+RGFIeJ4gzjT+vq
	dYI5cnWFdJiVo6bEoT+OjgGkeSmjxY57HeHGygYHrgBkjBpBeRh9AvUsqQMoASRVyzPls9MgN5B
	yQTKcRc6ZctuqE1jZnPjlQSbhU6tNv0HX2f1/1gAKT08J0cz2ljulbR/sP/dvYqINuf/UDIB2af
	UF3wIa2kxoQDHHlErazF/RolHNUPGb2UjwKTP1ODjb0CS6J+SYaGkpTounlBAPvpi6mX0z22uhr
	JekWPyYXxR6iu6AHHcN6/LZY65g4N8fN/QSG
X-Google-Smtp-Source: AGHT+IHbeCZbFKQyLFu55+TDjE6yCmbcaGHc+Mn+W/Ad3eldvRvX/xGnzfn2c4YshIS9ToGklmqAUw==
X-Received: by 2002:a05:6602:29cd:b0:867:3889:45e2 with SMTP id ca18e2360f4ac-86738894f82mr175274639f.10.1746539121403;
        Tue, 06 May 2025 06:45:21 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa2bb418sm220110539f.2.2025.05.06.06.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:45:20 -0700 (PDT)
Message-ID: <a562c00b-6675-4bb9-9148-c212bab8eb41@kernel.dk>
Date: Tue, 6 May 2025 07:45:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: only update request sector if needed
To: Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jth@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
 <20250506115937.GA20817@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250506115937.GA20817@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 5:59 AM, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Johannes, you need to update your mail setup, it's failing
authentication verification and hence often / always gets marked as
spam.

-- 
Jens Axboe
