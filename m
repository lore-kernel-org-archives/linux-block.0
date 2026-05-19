Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9ED36680C;
	Tue, 19 May 2026 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170810; cv=none; b=lAD7OGnLa1MHpGL/1pQiyuULjGR6GyUjzdnwFh0HbVuTBCXVud3yXPJHYwIeZ4rZD4a3992FnuOSrjAye6RnOKdmRKkEyJc86+cudrzZ6c9vtlADJdLRCpuhmRe2/VUvoBxwDNZoCOtFHSjMivDAYxxPzlqkN6sdzLSxCxQ50FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170810; c=relaxed/simple;
	bh=whuqbBZNBRmr01l2+lcD5+9rQDpmKmNFbb1OKiEk2GA=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=S4/NCvPmdasegvPcUzeTOVGYxL2lNzKtuAB7wZhwZYlkZ3H3uDy6My6yJ+r+RYIsa2A+gLXVGHeXa6B8Guv9ctszDmc+RA0yNurV2UVAr5uomy2qbCSXsDhAZD0S8KSG7UaW131A0cgdIaCz/6eOq2tdsHHE/ubJ5OxKnzdO2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=g+eOARi7; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="g+eOARi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=/1qtrQcPViPCwk0kXdkfFBM84jq8LoxwcNH49Tu4Wsc=;
	b=g+eOARi7EbR6nVyD80JotgPihBJmo/de5pmK6rRs2p1eQ+7K9kpq9rmJOaD9et
	oMBx9VuLn3j0np3ma0U6SnKuLfVPU9nsXNlZcNZDAMCkaRdIIF/9qwQeG+tPIFdT
	r62+v7cplIOOlOXjNZMzBsxYRgGUriVQonpGqs/RHc2p4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnjyLb_QtqqqSKBw--.46364S2;
	Tue, 19 May 2026 14:06:19 +0800 (CST)
Message-ID: <6A0BFDE2.5000808@126.com>
Date: Tue, 19 May 2026 14:06:26 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Ming Lei <tom.leiming@gmail.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: axboe@kernel.dk, ming.lei@canonical.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/loop: Fix NULL pointer dereference in lo_rw_aio()
References: <20260519040103.22776-1-zenghongling@kylinos.cn> <agvqK_4EelxnXUvf@fedora>
In-Reply-To: <agvqK_4EelxnXUvf@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnjyLb_QtqqqSKBw--.46364S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4xtr18Jw4DtF1fKF13XFb_yoW5Jw1kpw
	43GF1YkrZ09FW8t3srZw18Xa4F9anrJFW5WryjyayrZr15uryxGFWxta4YvFyqyrWrt3yS
	q3WUAFykZFyUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbiSdUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrxsT42oL-dshFQAA33

Hi,

Thank you for the review.

在 2026年05月19日 12:42, Ming Lei 写道:
> On Tue, May 19, 2026 at 12:01:03PM +0800, Hongling Zeng wrote:
>> lo->lo_backing_file can be NULL when the loop device is being cleared,
>> causing NULL pointer dereference in lo_rw_aio(). Add a defensive check
>> to prevent kernel crash.
>>
>> In v7.1-rc tree, lo->lo_backing_file is cleared in __loop_clr_fd(), which
>> is called from lo_release() only, when it is guaranteed that there isn't
>> inflight IO.
>>
>> So care to share your stack trace?
   Syzkaller has managed to trigger NULL pointer dereference in lo_rw_aio().
   Tetsuo Handa encountered the same issue (commit 1a83d226268cf), but his
   patch only adds diagnostic logging and is marked "not for upstream".
>> Also fix loop_attr_backing_file_show() to use PTR_ERR_OR_ZERO()
>> for correct NULL pointer handling.
>>
>> Fixes: bc07c10a3603a ("block: loop: support DIO & AIO")
> Can you explain how the issue is introduced in above commit?
The issue was introduced when lo_rw_aio() was added in that commit,
which dereferences lo->lo_backing_file without NULL checks. While the
design assumes no inflight IO during __loop_clr_fd(), fuzzers have
found edge cases where this assumption doesn't hold.

>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   drivers/block/loop.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 0000913f7efc..d8db1b0d8018 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -397,6 +397,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>>   		cmd->iocb.ki_flags = 0;
>>   	}
>>   
>> +	if (!file)
>> +		return -EIO;
> If lo->lo_backing_file may become NULL, it isn't enough to add check here
> only, cause it can be observed in lo_req_flush() & lo_fallocate() too.
>
>
> Thanks,
> Ming
You're absolutely right. Tetsuo's approach only adds logging to help
diagnose the issue (and he marked it "not for upstream"), but it doesn't
prevent the crash.

To properly fix this, I need to add NULL checks to all functions that
dereference lo->lo_backing_file:
   - lo_rw_aio()
   - lo_req_flush()
   - lo_fallocate()
   - loop_update_limits()
   - lo_can_use_dio()

What's your preferred approach?
1. Simple NULL checks in all functions
2. A helper function with proper locking
3. Your recommendation

Let me know which approach you think is best, and I'll update the patch
accordingly.

Regards,
Hongling
~

