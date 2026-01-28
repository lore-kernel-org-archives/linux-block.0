Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF06302176
	for <linux-block@vger.kernel.org>; Wed, 28 Jan 2026 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769573803; cv=none; b=pekZxqWe4ugd6E97LtI0K5K2uGlmMejNEHjhOaYnGDN7HupUlKViGtdGBIcP70JFimKVRE3KkNK8UQFKARgRi2H8EwodlNeaUK8CAxbt7vNOsXV566wR8s4hPBKfmphOBvIBCG/rGvrtQnrB4vitW0IKVdfCJ86PONJ958u4UA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769573803; c=relaxed/simple;
	bh=bTImWss/BYcQhZ+04PoDOpJtXc3wnrm41egoAIBRf14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPd2jLR/sM9kmuPrMHWbS0lWtHKDXkUIqejwUtvBYQb0XEp28mfq8QnHInIme2hkW7p3BftJvukX2sQeEMi5EoS9PhbgzEK/0/tN2m7E+kaQqiG1i0OY11eCI6yzhuzDrS8DRakX0y67OBQAqmjgLwe2R3R1xToD4aSp9om8dlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pFQ+hf93; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pFQ+hf93"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a367a1dbbso108603086d6.0
        for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 20:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769573799; x=1770178599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoifIw0qoxwdt8GUgoNTHtGtVpgiDjUypOcaxxgq9j0=;
        b=pFQ+hf93zVxSn4K/WMonwcEURhJz4AV7Zjt/w4HxDOfH+ueR/e8ay0OoJ4zwSt5cs/
         SRHVFsN0aLJ5aa4JEDrNXtn3meLxpSwxZRJJkaBBLjXxXxOS4Ku+0+4xfCItRQowq18F
         E6LyHDktCDkkxk4b2SzRX06EtsFBxPboCk4nUu7X0vHTJ9zToQvRr+bJyuODntvHpIQI
         R/TJ5jebQqwOmNAsU69eLulISfy11uQ9iNmZGb/f/lO4YTbi4caIRMZvlR4SjdLrY4lj
         j5JIicgOB12bgP4qlSpAS0NT1v+x2EMZjKTB/0p2agdJUPeVGjImPc6xPchjDtXGShPI
         nx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769573799; x=1770178599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoifIw0qoxwdt8GUgoNTHtGtVpgiDjUypOcaxxgq9j0=;
        b=H33HDssznjQoUlo88ToKJbPfeIhbxxAi2QJdulC31Y8v1DETL7mkAADD7NK/dL/ADO
         wdXrMpbK7c2VcMOaNzawlxOzTG/4pO5Erefry9DH7bw6L204dh2GUzoL2kMgj8OdyAfO
         zDSU99xNMDjEQYL/CEErqxQ/kV+Ysh0+0esW/ZKXlJfDQklOXHkU0jCD5NkPsNZAyEBY
         APP/K33xbe3PLxMEEsjZM3HnupKRa8Y42lZGszl7iFV9uPXk69qx7BJ9kJJOXtYC5jHM
         e1WmkSQbAHFPX/JNRKtr1Yko76DL//D2FHHivzY1IudTPqL2Vu5iVCKUJCWtmNfvKHuP
         RPiA==
X-Forwarded-Encrypted: i=1; AJvYcCWihCVzEsDpu8lBnoKwl7yQ+zp4Z9wLtL9fXq3jjsKB5MCiwuxu+xQBdfpKdPmOK+e/ImLYOOKbox5BEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEudIP5H6Ym7zWrYA0beVR9Sw9NebWu+TwCCOsiIiz+79S38wx
	f4rhs6R39rMdyBKrqS2QUmxGv7G+1mXBHOZjtub0rsDWcgm4DvMdFbY5eymHKuc4s+g=
X-Gm-Gg: AZuq6aJ1+eKcqKtMKrlRbynVCjfdgj6ZlHWjjOjkgBNcx3SAb5INvPqt9A6+EaWJEqI
	VTU0+/zjcK+en+y6kkqLy16BMAiGqkhj8xYPVD0w1sxVZuL74q+l9nxDUd9TIDqOEmPvNNXRUjJ
	X+wshlk1q3WsCixarMZhuQ67DMkziXKPo4ePgGYzcMvPWa8SYtY7v6E+vl1B/mKtVrrUxGlxF4u
	izCNnwabUIBPm/+rsSGyiBPma/STSPyFjRlgRG4d9LvettDh1QNkrtk2R/c68LI2QjHIAh0h5m8
	K7XeOBphbBB9oQZ28aFIUjT5WS+vAY06LxtEo0ZJeAuzW+ZgzFrkkZHL/F6+FkSeeqN5F2OB1Ds
	kD1NoqLq/Em4gsuJXrdEqYYV2bqEo8pCxrkvaOWSRQgQhIiODxgpfuG3hYjYXX/DA0Es4gsrhWQ
	lqNcn7LM69VgUx/owqMQ/OC5imwfs9H7HWM3HNHkYa9H/e1v537ZX/wMePler2xXopbpIqMTY=
X-Received: by 2002:a05:6214:e83:b0:894:6a0b:2483 with SMTP id 6a1803df08f44-894cc95735dmr64225836d6.53.1769573798725;
        Tue, 27 Jan 2026 20:16:38 -0800 (PST)
Received: from [192.168.201.17] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375eb4dsm9914336d6.46.2026.01.27.20.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 20:16:38 -0800 (PST)
Message-ID: <10668b83-05f7-4745-bfcb-591d70379433@kernel.dk>
Date: Tue, 27 Jan 2026 21:16:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rnbd-clt: fix refcount underflow in device unmap path
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
 "grzegorz.prajsner@ionos.com" <grzegorz.prajsner@ionos.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20260112231928.68185-1-ckulkarnilinux@gmail.com>
 <aXhLQmRudk7cSAnT@shinmob>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aXhLQmRudk7cSAnT@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/26 12:06 AM, Shinichiro Kawasaki wrote:
> Haris and Jens,
> 
> I suggest to pick up 581cf833cac4 ("block: rnbd: add .release to
> rnbd_dev_ktype") to v6.19-rc8 to fix the kmemleak issue on the Linus master
> branch. I applied 581cf833cac4 on top of v6.18-rc7 kernel, and confirmed the
> kmemleak failure disappears.

I reverted the fix from 6.19 instead, and picked up the offending commit
in for-7.0/block.

-- 
Jens Axboe
