Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EE8528E;
	Fri, 10 Oct 2025 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061702; cv=pass; b=tncJQ7fzTwvPah7xBtmcJMQ2A2Ts92riBa5CZeLCGfYR66pqlpDGtoR3tBDFcRrOF+gZcY/XvXhR6axnVXYamwtCQN0kkrXfx/bkY6qFNWPUT1IEXh+M1M6QUO1J/DGNganl2pKaEAIus9SGba3AutFJLzFqVg588q3tSIUS08Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061702; c=relaxed/simple;
	bh=fm3jUi5cGAWhmkua8b17eHHqrJb8hTytfdYGyNXrD3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoZmL3KWIfjEn5pqx+BcvQm3/55c1oazs9qYgsSxcpaHVIDkB3sNzBm37Q2iLjdyhTbsZXaWN/lTksKcYMfC8MbHMXU9AWGcSjvstmFLuEoiuG0Ou9/5/JkmWiN+CIderibvR7UKB8jfHICfkUxMgFJb7zQlTmdFoLrcIxL/Rck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=blkgz9WH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="blkgz9WH"
ARC-Seal: i=1; a=rsa-sha256; t=1760061674; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RSh1B8jc8FRDc7h1MpB+nhnMu/GARvGjz0iUrf/DL1WcYIZ4qZ7kycybgAatC+S3KND4u3ys3wC1SYVjOwzrVS1HSwNYTf7oZbHjmrPfbMp+wSxihd/PAwlI1ANCop59BMUUvf95g03yR2931tahhOipTt4DGZ6T+qoVUUSZQlY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760061674; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fm3jUi5cGAWhmkua8b17eHHqrJb8hTytfdYGyNXrD3Y=; 
	b=e/mofW8jOaSMUwtjfKrSPOp0Rhz7yS/obsBgOlbN4zI9JCKR0B2kxu9GrLf1lqJdQp0qac+QzWKDj3PbnwsjI3FDSyQw8Haold2FY038ElmZPB03phT+9NQs51LbFFRBjjPh4migv3Ee5MUPLEX8x79z8jiPnSPB1ohRAQ1//Nk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760061674;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fm3jUi5cGAWhmkua8b17eHHqrJb8hTytfdYGyNXrD3Y=;
	b=blkgz9WHu5WRoDgIher2KjylbV/KSsdbGzyZ0mGj4pbCK1HKYedlZjpIPbx7vYNe
	9DHjoQE9PhxK5FKkuMN1AR5sj7oOyY9CDJ8p672nPeIgdbmafw56g0PR45jbCN6IXA0
	26H77Cl8Tytuo9Cpm08Fqjxq8qDP8V74ort5qdzo=
Received: by mx.zohomail.com with SMTPS id 1760061671900618.6254623367178;
	Thu, 9 Oct 2025 19:01:11 -0700 (PDT)
Message-ID: <dbc7eeec-325d-4d7b-80e8-a8574943d894@yukuai.org.cn>
Date: Fri, 10 Oct 2025 10:01:03 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 2/7] blk-mq-sched: unify elevators checking for async
 requests
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, ming.lei@redhat.com, nilay@linux.ibm.com, jmoyer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20251009074634.527661-1-yukuai1@huaweicloud.com>
 <20251009074634.527661-3-yukuai1@huaweicloud.com>
 <c7ce7e7b-3195-4609-807d-fedc87515740@acm.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <c7ce7e7b-3195-4609-807d-fedc87515740@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/10/10 1:02, Bart Van Assche 写道:
> On 10/9/25 12:46 AM, Yu Kuai wrote:
>> +static inline bool blk_mq_sched_sync_request(blk_opf_t opf)
>> +{
>> +    return op_is_sync(opf) && !op_is_write(opf);
>> +}
>
> The "sched" part in the function name suggests that this function
> schedules something while it only tests something. Maybe
> "blk_mq_is_sync_read()" is a better function name?

This is just a prefix to indicate that this helper is user for scheduler,
just like lots of other helpers in blk-mq-sched.h

I'll prefer to keep this name if you don't mind :)

Thanks,
Kuai

>
> Thanks,
>
> Bart.
>
