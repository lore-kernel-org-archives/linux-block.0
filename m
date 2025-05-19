Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D914F9FB;
	Mon, 19 May 2025 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747692743; cv=none; b=E+CYI8YXgYIdW++k9TGUKYbrsjLF+RV4hugNYiDWd276LbdtpGekAB6SNyxoLV944eN+E4ukLjb6Yk9obxVj2+lOuh6W0JZ+LslvwBBHlSyE6FiQwtm1debKA3/TjkxO0C77eQ1kV8izP/1ucOMDyJdeolguPaX19RqApnqZpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747692743; c=relaxed/simple;
	bh=LMEG56td4ywXVY7nfEMZFrE/DmPXpjWKAiaV91tn/dA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V/4E6QEIyKj2yXYB1a/OdbYGRSPr4U6qegwylxfMcalDdsc+02Tf63dIeYZajRFLkZ2ql+EdNzPaa5pXQhhffcIsgS0Jmsgeg/t2Lvisz5DJAP8kR3LauCdcw8OYfbQCQUjN++gVUt0ns3jlwV+rpSYv8Ln/a+bEJFnUanPkDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W1bMKO98; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="W1bMKO98"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b1X3l5Tw9zm1KXd;
	Mon, 19 May 2025 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747692738; x=1750284739; bh=lWnCiSYGLXLTQIYsSx/OwpKS
	e7KefkvEb/U7hOIQ7H0=; b=W1bMKO98oLq/7I1V+GApF2W4WPzmTyNVwHL99hzT
	m1ufwADcXELUlsiY1PEFNynd5bjNjKRns9BSO7VzKpnKAEK3L+jsBKdUgKK9s492
	WgDodlIei/V8aHN4lYWkop+k/79qfu3467EGznzUzvDsmtQCQtpc16PMXLVDgZRl
	FMZlDWOZmTKjqvQ8aGRoznfX5q4/e5oTWCBMI2CUyckrsmpX/HQ8GlW6eTm2y8S3
	hLIPXnfbzi6OX+dx+nkqY7Yy/FJfH8n2ZTrdgPxvTVYXMLuXzbej8OD0RsuuUmb4
	/pm1w4p/oXOEdFl0qR85HVTemUCjPdIBaEyO0VvMhVWC1g==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OTpZxtz9W56J; Mon, 19 May 2025 22:12:18 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b1X3d4gBHzm1KXt;
	Mon, 19 May 2025 22:12:12 +0000 (UTC)
Message-ID: <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org>
Date: Mon, 19 May 2025 15:12:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de>
Content-Language: en-US
In-Reply-To: <20250516044754.GA12964@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 9:47 PM, Christoph Hellwig wrote:
> On Wed, May 14, 2025 at 01:29:36PM -0700, Bart Van Assche wrote:
>>   		/*
>>   		 * Now assemble so we handle the lowest level first.
>>   		 */
>> +		bio_list_on_stack[0] = bio_list_on_stack[1];
>>   		bio_list_merge(&bio_list_on_stack[0], &lower);
>>   		bio_list_merge(&bio_list_on_stack[0], &same);
>> -		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
> 
> If I read this code correctly, this means that we no keep processing bios
> that already were on bio_list_on_stack[0] and the beginning of the loop
> in the next iteration(s) instead of finishing off the ones created by
> this iteration, which could lead to exhaustion of resources like mempool.
> 
> Note that this is a big if - the code is really hard to read, it should
> really grow a data structure for the on-stack list that has named members
> for both lists instead of the array magic.. :(
> 
> I'm still trying to understand your problem given that it wasn't
> described much. What I could think it is that bio_split_to_limits through
> bio_submit_split first re-submits the remainder bio using
> submit_bio_noacct, which the above should place on the same list and then
> later the stacking block drivers also submit the bio split off at the
> beginning, unlike blk-mq drivers that process it directly.  But given
> that this resubmission should be on the lower list above I don't
> see how it causes problems.

Agreed that this should be root-caused. To my own frustration I do not
yet have a full root-cause analysis. What I have done to obtain more
information is to make the kernel issue a warning the first time a bio
is added out-of-order at the end of the bio list. The following output
appeared (sde is the zoned block device at the bottom of the stack):

[   71.312492][    T1] bio_list_insert_sorted: inserting in the middle 
of a bio list
[   71.313483][    T1] print_bio_list(sde) sector 0x1b7520 size 0x10
[   71.313034][    T1] bio_list_insert_sorted(sde) sector 0x1b7120 size 
0x400
[ ... ]
[   71.368117][  T163] WARNING: CPU: 4 PID: 163 at block/blk-core.c:725 
bio_list_insert_sorted+0x144/0x18c
[   71.386664][  T163] Workqueue: writeback wb_workfn (flush-253:49)
[   71.387110][  T163] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT 
-SSBS BTYPE=--)
[   71.393772][  T163] Call trace:
[   71.393988][  T163]  bio_list_insert_sorted+0x144/0x18c
[   71.394338][  T163]  submit_bio_noacct_nocheck+0xd8/0x4f4
[   71.394696][  T163]  submit_bio_noacct+0x32c/0x50c
[   71.395017][  T163]  bio_submit_split+0xf0/0x1f8
[   71.395349][  T163]  bio_split_rw+0xdc/0xf0
[   71.395631][  T163]  blk_mq_submit_bio+0x320/0x940
[   71.395970][  T163]  __submit_bio+0xa4/0x1c4
[   71.396260][  T163]  submit_bio_noacct_nocheck+0x1c0/0x4f4
[   71.396623][  T163]  submit_bio_noacct+0x32c/0x50c
[   71.396942][  T163]  submit_bio+0x17c/0x198
[   71.397222][  T163]  f2fs_submit_write_bio+0x94/0x154
[   71.397604][  T163]  __submit_merged_bio+0x80/0x204
[   71.397933][  T163]  __submit_merged_write_cond+0xd0/0x1fc
[   71.398297][  T163]  f2fs_submit_merged_write+0x24/0x30
[   71.398646][  T163]  f2fs_sync_node_pages+0x5ec/0x64c
[   71.398999][  T163]  f2fs_write_node_pages+0xe8/0x1dc
[   71.399338][  T163]  do_writepages+0xe4/0x2f8
[   71.399673][  T163]  __writeback_single_inode+0x84/0x6e4
[   71.400036][  T163]  writeback_sb_inodes+0x2cc/0x5c0
[   71.400369][  T163]  wb_writeback+0x134/0x550
[   71.400662][  T163]  wb_workfn+0x154/0x588
[   71.400937][  T163]  process_one_work+0x26c/0x65c
[   71.401271][  T163]  worker_thread+0x33c/0x498
[   71.401575][  T163]  kthread+0x110/0x134
[   71.401844][  T163]  ret_from_fork+0x10/0x20

I think that the above call stack indicates the following:
f2fs_submit_write_bio() submits a bio to a dm driver, that the dm driver
submitted a bio for the lower driver (SCSI core), that the bio for the
lower driver is split by bio_split_rw(), and that the second half of the
split bio triggers the above out-of-order warning.

This new patch should address the concerns brought up in your latest
email:

diff --git a/block/blk-core.c b/block/blk-core.c
index 411f005e6b1f..aa270588272a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -649,6 +649,26 @@ static void __submit_bio(struct bio *bio)
  	blk_finish_plug(&plug);
  }

+/*
+ * Insert a bio in LBA order. If no bio for the same bdev with a higher 
LBA is
+ * found, append at the end.
+ */
+static void bio_list_insert_sorted(struct bio_list *bl, struct bio *bio)
+{
+	struct block_device *bdev = bio->bi_bdev;
+	struct bio **pprev = &bl->head, *next;
+	sector_t sector = bio->bi_iter.bi_sector;
+
+	for (next = *pprev; next; pprev = &next->bi_next, next = next->bi_next)
+		if (next->bi_bdev == bdev && sector < next->bi_iter.bi_sector)
+			break;
+
+	bio->bi_next = next;
+	*pprev = bio;
+	if (!next)
+		bl->tail = bio;
+}
+
  /*
   * The loop in this function may be a bit non-obvious, and so deserves 
some
   * explanation:
@@ -706,7 +726,8 @@ static void __submit_bio_noacct(struct bio *bio)
  		 */
  		bio_list_merge(&bio_list_on_stack[0], &lower);
  		bio_list_merge(&bio_list_on_stack[0], &same);
-		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
+		while ((bio = bio_list_pop(&bio_list_on_stack[1])))
+			bio_list_insert_sorted(&bio_list_on_stack[0], bio);
  	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));

  	current->bio_list = NULL;
@@ -746,7 +767,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
  	 * it is active, and then process them after it returned.
  	 */
  	if (current->bio_list)
-		bio_list_add(&current->bio_list[0], bio);
+		bio_list_insert_sorted(&current->bio_list[0], bio);
  	else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
  		__submit_bio_noacct_mq(bio);
  	else
