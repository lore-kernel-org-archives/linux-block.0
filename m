Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003A81AC6
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323834; cv=none; b=iAFzBFPxrRfVVO3bz3Kbgj3N3Zi38xSKkWk5QGc2/sHqxbFCF74fLQfZobr5HOK4f6e5TnN3Ikh49sfMzhTgzTwn4CrFHvI5N+zuDaW4UFzSYQraFW42SDY25CPUmd48SKKE6olibIYDGqRHWzhKh5RoBC2B7bdWDSW2ibaOnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323834; c=relaxed/simple;
	bh=RYSO2FbsyUtFSzUQTCXFk2Hq2fLA6/1JXzENsM9trWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RQSZaZC+gTqV52B6PgmEgXbIeYnXNKemk7/M9BAmrAldQ3hC6bjQsLkQXXWBqLcnU8Fi4qgmDTyZefIMKQo3YkXF3JqbWz91t/4xrrECy3xV9wpB1+6/djmQAQGEIK6Kvl6FQKDpooEiFYBIUUd/LqAX5wlHu66jLv5egN+Xfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vq77BLc1; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vq77BLc1"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso534039f.0
        for <linux-block@vger.kernel.org>; Wed, 07 Feb 2024 08:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707323831; x=1707928631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wY2HuCa4eOpym238h592uLbJ56WIqRtYGY5h38Z5DHw=;
        b=Vq77BLc1/C8hXiIdYY7IHT6/VEoXF2vtHqUl9CXa51b3SPexCFq4lcZ5mJyF2wJWIu
         FSLx4k19lBzV4pK5+baqToh050oIHR1EZUSLo45JiOk2IcWAXx8zQxFm/VFn9+uClEGY
         kkuuRLEVX0MWrVb7fdY58o+H0uUfi/qgjzP1dqwMU76oUq5GH3/U+15bs1kAxaId1+6M
         YEewi1XbeNsWglSThVgV1e/HfBVvBPNFP6nYaHZxbPC85we5gfrR+3UlN2NuG0I/uQmX
         2mDCFzmKSrCX8PZPN5jlHgeA4Er8bxH+pHPK2wab2JIHFYcd8q39IV9WY2PocvC0RIEp
         ogRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323831; x=1707928631;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY2HuCa4eOpym238h592uLbJ56WIqRtYGY5h38Z5DHw=;
        b=ZhWdWraYPxrgkVDdOMec1ExdOXtEKwEFHZM9ktRGpAZUQebQPAYVZKmNOS5pp0K2TG
         R05MsAhQa0L4C5B2h4FlHWajvpLypRJJmSBqR0Nj9cHc8uM0F79ibZedFeSRFIVI5XIo
         PIGEX+QvVI83Y0/unCFyPAFlrLURNPjg+K9ozCKmfoxWylS2GeAIZ72urj2kelsiS/2O
         exIn4EqdQYvGqgddU0Z/rglnQGy1cDG68iXWf2p7NtvIAVes/JZTJnG/Kk0gCj6gtN2B
         oWRWWqMLwUQV0tDFvhiNF2Lbvns2Kbm8PNX8ZOwVe3S6Alt52EQbhmbk+w7tEStRpCxf
         MGew==
X-Forwarded-Encrypted: i=1; AJvYcCV6Fw49zVnEiJUMSqsnOEW2E7dlqqwtinNhgylLcn78IzFDtSRhTQJZVN5vW9ua916T4/Eut2HYP8dmw3UmirhUCopKOXTZ3hK2VLg=
X-Gm-Message-State: AOJu0YwzT49cE+JR34Yy8Kr134e1eCkS9tmNI643jfPRA6xhuqXI/NUW
	lJcSqUpS00qp6DC37jawDz7rAlSs/zApwtHj5GkyvCZ82Ahc7zQuh0H0fo1rkgY=
X-Google-Smtp-Source: AGHT+IHBekYriwzFUTmIs2HuOvJpILsbppgD4OcQlP8S9YNmgxXVN3UyHD4Ag57kljwURqP1sLZ4Cg==
X-Received: by 2002:a6b:3e42:0:b0:7c4:606:6501 with SMTP id l63-20020a6b3e42000000b007c406066501mr484657ioa.2.1707323830176;
        Wed, 07 Feb 2024 08:37:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6R1qbJwxbKZcTPkOsFeXY98TBMZKhJmbLCybteGMar+zmb9vBZvWn3Q7539N8D3y4EbiyR6A+g18QfVjfQq/liMbjDzqIw5AldPvT5SqGZ+IpqAJf0W75xD6GO4x75tE3U7TcnN45szS9xsvpxRCu1LbeajMaFBRkVG/Hbo0Rn362pSeMrGAv/zSDN8o=
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x4-20020a029704000000b00471294696e4sm400268jai.38.2024.02.07.08.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:37:09 -0800 (PST)
Message-ID: <b1668ac2-3fa3-45e6-ae79-a127cb095eba@kernel.dk>
Date: Wed, 7 Feb 2024 09:37:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] BUG: unable to handle page fault for address:
 00000002de3ac841
Content-Language: en-US
To: Guangwu Zhang <guazhang@redhat.com>, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 io-uring@vger.kernel.org
References: <CAGS2=Yr7_h6ZiOSjRNXjDeXDQJrcDE+4LW5cJYAuB_2WnZYGSw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGS2=Yr7_h6ZiOSjRNXjDeXDQJrcDE+4LW5cJYAuB_2WnZYGSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/24 12:19 AM, Guangwu Zhang wrote:
> HI,
> Found the kernel issue with linux-block/for-next branch.
> kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> Reproducer :
> 1. offline_online_cpu_in_bg
> 2. some_io_in_bg

I don't know what these two things are. Would be nice with an actual
reproducer. I can trivially write something that offline and onlines CPU
in the background, and I did, but I cannot reproduce this issue. Ditto
on "some_io_in_bg", what does that mean??

-- 
Jens Axboe

