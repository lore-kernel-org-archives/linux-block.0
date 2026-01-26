Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6D2264A3;
	Mon, 26 Jan 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442973; cv=none; b=DdqcXq6oN7AWXDseM9ZNtCBazLt+XADkn+UaOAYib6SCm8pc6V3DraDywBRUeGGz5i9oG7XlFQ96sdB/40jQOVrTQMLMdXzMNyDhDSSoL1xdjy0yMFwRvgwnnYMOue3Fganb6m/T1R0xwWqV07ltgFywCro5Pf7XGkehlZLbcYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442973; c=relaxed/simple;
	bh=MYzJU2DKsgYEs8+WNe0VqkKqVfQssw6PPszUTaknKGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kezg4CADisiW6RQ7tG/PwsqJFFZdLp8qN3a/E7rRNMvJH7vbSA82lurYX8Im2bYJDuTdKzKrQgqDo7yiV6ZLzVCcRGYuBXWA/ccFQeNLBI83IG2JqQ4f1gTnneS74Vmij16fSTKI860iBiOpe8h+qMlG+6kYrp4m3QIdhN4vsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=J4+poeqy; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="J4+poeqy"
X-Virus-Scanned: Yes
Message-ID: <88f97f6a-f8a8-441e-83eb-71415398b40a@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769442967; bh=MYzJU2DKsgYEs8+WNe0VqkKqVfQssw6PPszUTaknKGs=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=J4+poeqyP6LxMsk0+Cv2eS9tDZjsjjOl2toosfup8gMpcN092CAlMuUydGEMvcaI6
	 9SkNq49VygVtiVewwvnzCybMF48nyYGTbtPeE8o1HtQlvLgpwpjxN/+PoP/F52Sn1+
	 u+0ydvREMRttnK5ECn6qUufT15m3PcjBNYi8JbhoZMjdVIRMS+gnsVftO67Fm2qQl7
	 Z4A5WKkcKgWv77Z1NzxI4RaE5U8DSWzwcgMPwqCKPwMOh6k0uwhsGfSnG0bKUCrjVi
	 U1qQfv8PycfjoGDT9TGr4ubQtHUvjF4/kIxcoWTEzcw30UY8+IT8utT2F/zQCmm5Pd
	 xQK83dOnhoW0Db5LquU376tWNv1OLog1uzCZ4UNuhIyAparHBSmKNw8VTFMPzH524v
	 +yILsQFoFtNVCxvQN6Ld60Xi9VBcCuF2vVht8uTSxI5HJQxVfKZugJasKDUKPiMY+s
	 F0XJJyhfsGC9SjgPgGLWV32TM89UOCQNyrfZ0sges4brtsc1cZVrA5RJP9PUeg0KTY
	 ckdYyCQXRx3L4/zJaUPeMKX5S137019EY+OgvvazzOd8tWPWW+j7g9wyF/BU3D1R8c
	 D8GL4NRvlcxfpSrGzTic/SAD8cjCQf3eS2BKXmqyl5S0dBI97RsGgESlKNt0FG2b4F
	 N58A6CSxnaXfprHJqljZtpLY=
Date: Mon, 26 Jan 2026 17:56:05 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: ublk: mark each test start and end time in
 dmesg
Content-Language: en-GB
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126112544.1811817-2-alex@zazolabs.com>
 <aXd0KdG_k-LDxeDo@fedora>
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aXd0KdG_k-LDxeDo@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.01.26 16:03, Ming Lei wrote:
> On Mon, Jan 26, 2026 at 11:25:44AM +0000, Alexander Atanasov wrote:
>> Log test start and end time in dmesg, so generated log messages
>> during the test run can be linked to specific test from the test
>> suite.

[snip]

>>   _remove_test_files()
>> @@ -166,6 +167,7 @@ _cleanup_test() {
>>   	"${UBLK_PROG}" del -a
>>   
>>   	_remove_files
>> +	echo "ublk selftest: $TID done at $(date --iso-8601=sec)" | tee /dev/kmsg
>>   }
> 
> Also `date "+%F %T"`(which is taken by blktests project) looks more readable, such as:
> 
> [root@ktest-40 blktests]# date "+%F %T"
> 2026-01-26 14:00:51
> [root@ktest-40 blktests]# date --iso-8601=sec
> 2026-01-26T14:01:54+00:00
> 
> So would you like to consider it too?

I saw this a bit late. I choose iso-8601=sec since it is mid ground 
between readable and reliable to parse. But if other test use +%F +%T 
i'll cook a v3 with it, no point to deviate.


