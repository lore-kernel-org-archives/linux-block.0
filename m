Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA751C5F37;
	Tue,  4 Feb 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686024; cv=none; b=INxy0sYbZ5u/Roa62L409GTK4AKUDw6mdAPARySW/Q4Iuosx55+UpHXkQqDau8QrleXxbd6nIHQqepHcDvAl+tsKcejxZTyuhx316dcBVPE12ndRngQjHKlPrEmvOtv5z/IADxPzb79p7LEhKwGVTCRPSj/JOOwqDjUiJkncWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686024; c=relaxed/simple;
	bh=qsQ3qC5Tpg63dCD7/jZT/AEnIALZtLkxfeA7sZPfYvI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jSoQXLmbQ/YQPUosTOYOD+xQ+tlWkOdgPX+RT8J1dgkNSMEKqHfY23HYQesElQZLzXPLIJiO1px0HFwDWKSzjJYBupTLmug31GNPlZPTyOuLIFju41DM+KwiCg5AMZONDS4YNxvAFKsS5hdoMdloXUARe8YidpGF63YqrLSj+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JFNqQ3WM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JFNqQ3WM"
Received: from [100.65.217.97] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1B222054913;
	Tue,  4 Feb 2025 08:20:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1B222054913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738686017;
	bh=qsQ3qC5Tpg63dCD7/jZT/AEnIALZtLkxfeA7sZPfYvI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JFNqQ3WMJYt9x5FlRLFXv9KHyV1pKDlzhODb53QoWzpp6J3AdAjnkgoFXzX5upaKS
	 NFB7RQX/lTZhUgAoDftbhFMBWRFjJJRgsKy9ZaQziRTcbj53IbbgDHyBHFcvhpmjTi
	 8Sj+Z0cZpDnm8hl7T3Q2wnghxJwrjTRbik8PdIpE=
Message-ID: <974a03d2-3f3f-4be2-9dba-ece6dca8015e@linux.microsoft.com>
Date: Tue, 4 Feb 2025 08:20:16 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cocci@inria.fr, Andrew Morton <akpm@linux-foundation.org>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Ricardo Ribalda <ribalda@chromium.org>, Xiubo Li <xiubli@redhat.com>,
 eahariha@linux.microsoft.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org
Subject: Re: [cocci] [PATCH v2 1/3] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
To: Markus Elfring <Markus.Elfring@web.de>
References: <20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com>
 <20250203-converge-secs-to-jiffies-part-two-v2-1-d7058a01fd0e@linux.microsoft.com>
 <49533960-e437-4042-951a-0221164bfa3d@web.de>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <49533960-e437-4042-951a-0221164bfa3d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/2025 11:56 PM, Markus Elfring wrote:
>> Teach the script to suggest conversions for timeout patterns where the
>> arguments to msecs_to_jiffies() are expressions as well.
> How do you imagine that the shown SmPL code fits ever to patch reviews?

By the simple fact of accomplishing the same result despite differences in
code style, as explicitly called out in the changelog.

- Easwar (he/him)
