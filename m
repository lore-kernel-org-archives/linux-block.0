Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57EA60DCF
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478964; cv=none; b=Z04s6WXr4ddeQ54vRyCCZAl1jHH2YgD2WUURVSaRQRn9NT7I6Q90DqSyN/OymaSRG9axSt8SJhtykqCV/BLz5fF6Kg/mAY9Ko0fQpMmIfn+llsJb5z+BG8AwvuRElA+rDZEDFJqfSSh0ARBKL1E6bGucdqdb58Z1ZPg4MS7EfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478964; c=relaxed/simple;
	bh=EtV2pGFPHWZXc2DgFQ/qOI1yYDFRLxpWqq0OhveCzro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbQeq6My9BzfIH4lgKU4qX8K5rQUBW+rkHr1UO0sM/3h9Ei4p223f4l6ez/rFk7C1p/Py4mJPCPlbnfavMwqC+PEx9zfK0951+SakJrQeoy1ncdgPsD4acnTweKt75vg8I0uCSBjDpwFD4N4ZfsBwfyZ2/AGzWXZjAh3i+6K3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PNZmKgDG; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PNZmKgDG"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86a464849c2so141510439f.1
        for <linux-block@vger.kernel.org>; Mon, 09 Jun 2025 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749478957; x=1750083757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BvQqX5iQdSePNBNBJ00et482dqomFiNGamV1dpJOl0=;
        b=PNZmKgDGSOj3dbGbxXrfHi4/Tu3Ie7Dn0M8GXxGB3o2K1huPftYVMLCOrmoopz3i+M
         cu6jjCC7x8loZ1H2Xc4SZ0hB4VDOjjudRi+IfemIAGLOhx+ZUM0TCzvfbi6fzHU1jvca
         0wPfG/t0FLOR8mys0KC4ILfth1fcppH7Ha2cuLwGnFUZkMTJUv2yIQ/p1T0RorGBzAnl
         y1d+N1fMTsrpllxy4Y9/N2xRea6PvlMDSMYY+3qmCrcEjKzfrvoz2h6jEDSbmApKRmFb
         q3wUGKmmJk8FsYvO2F8iywzVjxbwhsUbfpr8JfmSBrGeYbN9xVuSSrG1yPgArB9K/J/Q
         6p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749478957; x=1750083757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BvQqX5iQdSePNBNBJ00et482dqomFiNGamV1dpJOl0=;
        b=TBzszJkfby+srBLLYkqS/UiKCa4MTMLoZOZ3ri7SI+PS0XQUlzqfoti3lNnej7jUGc
         PYj3+H32+krbI9NJTf+AS78C3VJSmVG7nCakhwvR0SoOBrK/oDd4ZN63xuQ+DYux94u/
         nlYP4AiYizn70nyBH/kUtghcfEmYufArJ0E4qynmaJYVK1XZNqDwIAuArgBpegKiI1DV
         A1lnJ0dnEdyYowy5YpXRCx/nN7v9NdiP4W6xev3zWEX6ULNGKiZi77ZeAyg/wLgfo9od
         XUT2S0MiECsoR6TmsNiOVKvRISfMfLaVFNcimc5JDJ1gUY5zVe/0bvgNyfSBoqsebryv
         iVCw==
X-Gm-Message-State: AOJu0YzhvPP1Ie2WvGccMD+dRUAO2MhKhyVwFNYGGHi1AJjH06PGSehr
	cycvW+6F8X14FDoQ9WAlkZ50TZcYQnigYJcjskPxkLroTBgP+fA4DmFxwd5plgTsg6M=
X-Gm-Gg: ASbGnctj8ksvyY9REUT6FFRuHswutvQ0agdfBe3zcCsc3HlQ2UvvxIYvOOpfyXpNamD
	4n70R0232vhS0Sn1Qj4TkuvbMm+Sggj9MmGoGtxl9dUg64k3C3c2kvXq86azbdN2daD40OKtpY0
	GSc+vK4gVw0c5mqS0o6sp+MCKKv6+4bWWcTWcNlYHCKQTTQvgN+w7qe3EdO45Fftle8hqfotOk8
	48ou8T6qvf+XjOz19/yodjH77G91ZwU8Gb5gFdvVZ3pI7QkpBVsfLqGmVazDyScP+nfGc8yCE0i
	+z7obPZzone058S/X5h07a1NZqOP72PLCeEtFkPNJqzGIF32
X-Google-Smtp-Source: AGHT+IEU5X53TW7+qSifqoYWNiT2vzKJIH3v9vp8H2K5WCCseyEHuFGHSkfM+Ttqwza+nJvItopmwA==
X-Received: by 2002:a5e:8307:0:b0:86c:f0b1:8dd7 with SMTP id ca18e2360f4ac-873caa2049cmr9684239f.0.1749478957410;
        Mon, 09 Jun 2025 07:22:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-500df587ebfsm1836794173.73.2025.06.09.07.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 07:22:36 -0700 (PDT)
Message-ID: <28f59f4a-7ac6-4c27-ab68-b6621260c760@kernel.dk>
Date: Mon, 9 Jun 2025 08:22:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
To: Breno Leitao <leitao@debian.org>, Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Yu Kuai <yukuai1@huaweicloud.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aEal7hIpLpQSMn8+@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/9/25 3:14 AM, Breno Leitao wrote:
> On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
>> Hello
>>
>> The following WARNING was triggered by blktests nvme/fc nvme/012,
>> please help check and let me know if you need any info/test, thanks.
>>
>> commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
>> 'block-6.16' into for-next
> 
> I am seeing a similar issue on Linus' recent tree as e271ed52b344
> ("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
> CCing Jens.
> 
> This is my stack, in case it is useful.

What does your storage setup look like? Likely not a new issue, only
change is that we now report/warn if these counters ever hit < 0. Adding
Yu to the CC as he recently worked in this area, and added the patch
that triggers the warning now.


-- 
Jens Axboe
