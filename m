Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3A33121F
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674121; cv=none; b=oqjVt1VtjhAqOAZXFgFoAEOQf0OT2Or0RROeBt9ULwGmzmD7665jxEM/0VuN9Z5r15+pZ5+62veWog8Wju81pPz243V8fgGoVR2T6fzIHx2cRkYApTYbr6zBrvbzfMf3MNc1titKYp5rrsh9EPRWKd7lcv658curRID27dG77Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674121; c=relaxed/simple;
	bh=1Ge5gfoGyv0TLiDmdg7VFxgHEnOfWaCDzgyu38mSmrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3YzQdC+5xHJ/2iAKi89MpW/2nbVsQQp9YuSHJylYXfz5lUPBDRJqA3bofvXddYHd2VSCNnQzytv082cfVqHbMITlDcSHNniuzeP7aFDRolxQJuBH3lUNUkZKVlj5evAWZNqR4gRLidiYuM6jv1NTVORQ28sWSjXK79lXbiS1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=sR4smn5j; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="sR4smn5j"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638IfsRQ3800457
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 14:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Dque
	R3VMcaZMrGBpK+9TubzW0DI74xoKUrfLcydSJjc=; b=sR4smn5j86SJPqwuEiyD
	tiO3LrwmcnhTzYNq/puVbFVkdQ23hxVuhAkUQf+XO03Laic8F0LMMB0w65VG4DOi
	MjEHK9uj7aeFv/l1TdDJ7gbuo31iIbP5xUFzSH0CJ0T9ITcDfIVwPZDh10am+5b7
	ehPmyJTYiEI9yXGyzY5/G53LdBLNQNKv2p0tRQwtE/byTMVhqGihaAEgsZNWdGjO
	tyt+uX+NZg+/F+Q+Biwz3IinlnvjWz7wEkUB7z/BDtWx7ZoKXZ5ckuDdC944zQRS
	FkzIre59ahDNjblioAHT4fKYGPnEl1A9nuKVn1p4YOzRdPlEyPskoRX4KJ4JK+zd
	rA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3kxx6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 14:48:32 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d8e8c47a3so2801631cf.0
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 11:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674112; x=1776278912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqueR3VMcaZMrGBpK+9TubzW0DI74xoKUrfLcydSJjc=;
        b=nxXBvGK7nmDJpttWo38POH1GhijZDeZwfC2XUgJYL8Y3jVJNtIElgqHIewYDBK4i//
         UJYUU8zhJ9xEAkcHykIg9EBWtNhkaHn5SrtcjSGE41GvaQSDffcM3nt0WMssOBaCD09R
         fqoZK7T22nJLFYTb91lkvOj20Hb8rUoUjbbyXkGOslyvaBXZ1GVeeuE67J75Rf+/0Rlv
         7vtUfrl5dbMInQC/cirMuraaIQ0CYZlnIoYZd0dj+/2AQS0slV763zr0+FvW7H5Axy8s
         /KAAJZws8/iYmvdDaSDGYt9gQSwG8xUmRrEg5GXKGKGI4TcjxsBdd0X4TF9u5J8QgUNa
         WeRg==
X-Forwarded-Encrypted: i=1; AJvYcCWjf+pIjzF3hAEZAujoW5QzUIaKtPEq4ji4vlTrsPP1v8XUbxrq6ipMI9AsKS8V+VRW7k/qPheaN3e86Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YylvNQtZPNNGnudyH4mJeMwYKD5V6fkwMUZA18P0NL6n8vTYQfh
	OsBdhxOBlkMPtooN98Z2xzUisxI0gPhgewnLgB/EvC/oXUHxIVMmvGVbpA1YJMjuw3OWvjCiZ06
	EkQoaqYMg3KDknli8qI+LDC7uuT6mn59PkLAv2LbWVsN0r6YNvVGUodhuNqHU
X-Gm-Gg: AeBDieu9AJx+eVnjQ+mj+TLs/WUPa7GU/JUCBUZ8gAPoSmWYfBwoQj+35RSYQNJq0Zo
	VOo5PXhVXcOYYzUB6oQw6C/T2EYQQSCbf2KK9xMRL2Tk5xhAb828siOgfXd1eOZIFfJZ0KR2BZ3
	DBU2bHi9AJzUG/5QPsfOBCLrZMMtlyyg0ochy8UmVrxW5XYY9479T12wgNGl/UFr4uv2yi9bqO6
	OAxkNU745w2zKI4IBBqFhU2QP1bqlcVhelwMq2Q79ebm/3CxQ0Kpqo+YTxqTsLnwOKFScN53vYD
	vE5Gv+DZmh5qPrDtGCspminLeudB0sKRDrRMhYKRyZM8lpLG6GfwrIcN7UNxfQ9+bJGQB/coiqz
	Ly/HDAFE4yvzVSrhMqQDXEnjVcPBds6/ZDGmoaoVf
X-Received: by 2002:ac8:5813:0:b0:50b:551d:ca7a with SMTP id d75a77b69052e-50d62d18253mr330224441cf.52.1775674111615;
        Wed, 08 Apr 2026 11:48:31 -0700 (PDT)
X-Received: by 2002:ac8:5813:0:b0:50b:551d:ca7a with SMTP id d75a77b69052e-50d62d18253mr330224011cf.52.1775674111155;
        Wed, 08 Apr 2026 11:48:31 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d5ea136a1sm148904291cf.25.2026.04.08.11.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 11:48:30 -0700 (PDT)
Message-ID: <01e6c582-fbab-40ec-97ac-02675e6a08ed@columbia.edu>
Date: Wed, 8 Apr 2026 14:48:30 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-1-c4b56db43f64@columbia.edu>
 <c4453f4e-c1a2-4f5a-b278-76b63d5dc4a3@kernel.dk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <c4453f4e-c1a2-4f5a-b278-76b63d5dc4a3@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MsFiLWae c=1 sm=1 tr=0 ts=69d6a300 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=Da_CJWPV6nPH503sPTwA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: pb7WvazCCIG-0AM4ajEywFdyLy4m5y6l
X-Proofpoint-GUID: pb7WvazCCIG-0AM4ajEywFdyLy4m5y6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE3NCBTYWx0ZWRfX5tjDUKT+IRmt
 E7Dy68lWA6ztczQqjx69WZXJtEyhF+W4njgrTvyEuWTBEz9SQTqHLLoG0WPq8mZrUqAi116GHr6
 FGSYlcCM4Rgg3A10n4WxilljOMyNX48FVCf1QzibShuVszZOb7RWX8tEaJmMTvMS2yhttyeGeIQ
 FTaor3RzzilK3wUQzfzQ7CKVd98ZPlOdykicqWVwFhbqzgtT0hVBt28Kdbpw6ADM8VQGkk6Otn4
 3Dou2ilexEMrDhRvJDKlxU5rC5qT8SYFs/IOpETuE17UgEvFHMfDWv4lTqBF/5vAdf3/Dp8lLy/
 8Kyft6uE641SEeOjKsltt8q4jJhSipzfuDGIfTQpgBmMdOMWeJgDxliDnOrU6KTonqRzccxq4GC
 uXBoqteVQsZ6mxjmfeRluqKum20WRChiwecMjN+HCwKLYmbtmijHV1+ng8C2TRaD8VnWYpe4zeD
 z+dsWrVKPt9nEuQzTuw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=10 clxscore=1015
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=10
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080174

On 3/25/26 4:14 PM, Jens Axboe wrote:
> On 3/25/26 12:43 PM, Tal Zussman wrote:
>> +static void bio_complete_work_fn(struct work_struct *w)
>> +{
>> +	struct bio_complete_batch *batch;
>> +	struct bio_list list;
>> +
>> +again:
>> +	local_lock_irq(&bio_complete_batch.lock);
>> +	batch = this_cpu_ptr(&bio_complete_batch);
>> +	list = batch->list;
>> +	bio_list_init(&batch->list);
>> +	local_unlock_irq(&bio_complete_batch.lock);
>> +
>> +	while (!bio_list_empty(&list)) {
>> +		struct bio *bio = bio_list_pop(&list);
>> +		bio->bi_end_io(bio);
>> +	}
>> +
>> +	local_lock_irq(&bio_complete_batch.lock);
>> +	batch = this_cpu_ptr(&bio_complete_batch);
>> +	if (!bio_list_empty(&batch->list)) {
>> +		local_unlock_irq(&bio_complete_batch.lock);
>> +
>> +		if (!need_resched())
>> +			goto again;
>> +
>> +		schedule_work_on(smp_processor_id(), &batch->work);
>> +		return;
>> +	}
>> +	local_unlock_irq(&bio_complete_batch.lock);
>> +}
> 
> bool looped = false;
> 
> do {
> 	if (looped && need_resched()) {
>      		schedule_work_on(smp_processor_id(), &batch->work);
> 		break;
> 	}
> 
> 	local_lock_irq(&bio_complete_batch.lock);
> 	batch = this_cpu_ptr(&bio_complete_batch);
> 	list = batch->list;
> 	bio_list_init(&batch->list);
> 	local_unlock_irq(&bio_complete_batch.lock);
> 
> 	if (bio_list_empty(&list))
> 		break;
> 
> 	do {
> 		struct bio *bio = bio_list_pop(&list);
> 		bio->bi_end_io(bio);
> 	} while (!bio_list_empty(&list));
> 	looped = true;
> } while (1);
> 
> would be a lot easier to read, and avoid needing the list manipulation
> included twice.

Yep, that looks cleaner. Although do we really need the looped variable?
Can't we just move the need_resched() check right before the while (1)?

>> +static void bio_queue_completion(struct bio *bio)
>> +{
>> +	struct bio_complete_batch *batch;
>> +	unsigned long flags;
>> +
>> +	local_lock_irqsave(&bio_complete_batch.lock, flags);
>> +	batch = this_cpu_ptr(&bio_complete_batch);
>> +	bio_list_add(&batch->list, bio);
>> +	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
>> +
>> +	schedule_work_on(smp_processor_id(), &batch->work);
>> +}
> 
> Maybe do something ala:
> 
> static void bio_queue_completion(struct bio *bio)
> {
> 	struct bio_complete_batch *batch;
> 	unsigned long flags;
> 	bool was_empty;
> 
> 	local_lock_irqsave(&bio_complete_batch.lock, flags);
> 	batch = this_cpu_ptr(&bio_complete_batch);
> 	was_empty = bio_list_empty(&batch->list);
> 	bio_list_add(&batch->list, bio);
> 	local_unlock_irqrestore(&bio_complete_batch.lock, flags);
> 
> 	if (was_empty)
> 		schedule_work_on(smp_processor_id(), &batch->work);
> }

Makes sense, will do!

> Outside of these mostly nits, I like this approach. It avoids my main
> worry with this, which was contention on the list locks. And on the
> io_uring side, we'll never hit the !in_task() path anyway, as the
> completions are run from the task always. The bio flag makes sense for
> this.

Thanks! I'm going to give Dave's llist suggestion a shot on top of this as
it seems like it'll simplify this nicely. Looks like that'll involve turning
bio::bi_next into a union with a struct llist_node.

- Tal

