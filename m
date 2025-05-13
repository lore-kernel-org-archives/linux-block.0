Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26E1AB6F1
	for <linux-block@vger.kernel.org>; Tue, 13 May 2025 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747168584; cv=none; b=bIn3Fky/bX04m9ZsvOBort+tlNGLmAtl11F42TLJ4VVcRvpOT0SrbacW3UuQE2nslrQMnFYtt44NxVKXqdiFNo/R54j1w9fTAGYqisHsDy07uR0+Hfdg/e6RUkKEvqehK2A6Lw2fuHWlR+UkvHasUl7Ej+W6pPEjEO2Zrv+xz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747168584; c=relaxed/simple;
	bh=OsBFMsbVTvWUqEa2Ivi77Ddk7DXrDz76EPZX/rh04bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhrQ4iJL2xkyLPhlJ3xKvAirZAmJOb/sqevpA3uFb5rMSnIcUGkX4ZFh2IluGyOulefn8f4U0Mc3KGKcjY2OIGjp95IHdYo57xfI2YgGEMEzmUhrNlY2R7Mg0rXjcWCEMVgzldJHf1cUZl/C2EW6VVXWp4Eh7uFpUW7xstYkwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XCBmBK8l; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XCBmBK8l"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZxpCn1BKczlvq7q;
	Tue, 13 May 2025 20:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747168579; x=1749760580; bh=2JRlxPc6rNijMnhLYD9VbXPq
	buaEtWkAwpk1yhM/b+Q=; b=XCBmBK8lFUMFHw+9rVajDfYJbPmi/W6F2W7DiLXm
	6QVNNGYRwqEpUywqrTniAoHJSnTBiSw6K336r4JuMclykrNlDSmh8oJfjnmSXVQD
	aJm0ZQ9hJ37qkfj1EbV643tpNilAk2B22PHzPGrb/7Y9cgGyVQH/wu6UOkrRxR91
	P3TLTD3a4qdeBLofo8uIDhHq1LoZqnkJCsSXILIP/HZyeFlQBM8DmqOgmIAakRHi
	FzneBxqISO4At4iypNUEcY6M548KRmrYnSBV3HsgyVbzyVHUZtzZYwwZ9E4kwiHr
	putYXquOIwDxWyfU9H8MfxivDrEdU4OdLQZjmxCjNlGSTg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OnKKU9gPjvgk; Tue, 13 May 2025 20:36:19 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZxpCf4hzqzlvq7w;
	Tue, 13 May 2025 20:36:13 +0000 (UTC)
Message-ID: <9e9164e6-b0d9-4940-9fa8-340f06d9d77b@acm.org>
Date: Tue, 13 May 2025 13:36:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Split bios in LBA order
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai3@huawei.com>
References: <20250512225623.243507-1-bvanassche@acm.org>
 <20250513064434.GA1199@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250513064434.GA1199@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 11:44 PM, Christoph Hellwig wrote:
> On Mon, May 12, 2025 at 03:56:23PM -0700, Bart Van Assche wrote:
>> - Modify blk_mq_submit_bio() and dm_split_and_process_bio() such that
>>    bio fragments are submitted in LBA order.
> 
> blk_mq_submit_bio calls __bio_split_to_limits, which returns the
> bio split off the beginning of the passed in bio by bio_submit_split.
> I don't see how that would reorder anything.

Thanks Christoph and Yu for having taken a look. This much shorter patch
seems to work too, and this patch shows that the reordering only
happens if a dm driver is stacked on top of a zoned block device:

diff --git a/block/blk-core.c b/block/blk-core.c
index b862c66018f2..1503781b6fd3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -706,7 +706,8 @@ static void __submit_bio_noacct(struct bio *bio)
                  */
                 bio_list_merge(&bio_list_on_stack[0], &lower);
                 bio_list_merge(&bio_list_on_stack[0], &same);
-               bio_list_merge(&bio_list_on_stack[0], 
&bio_list_on_stack[1]);
+               bio_list_merge(&bio_list_on_stack[1], 
&bio_list_on_stack[0]);
+               bio_list_on_stack[0] = bio_list_on_stack[1];
         } while ((bio = bio_list_pop(&bio_list_on_stack[0])));

         current->bio_list = NULL;

