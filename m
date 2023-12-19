Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405873D0BE
	for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58dd3528497so3396876eaf.3
        for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 09:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007757; x=1703612557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ/Ctfez//36rxiAMzDY9eO5erWY+DJ5xRde7UPMFpo=;
        b=puVSoxozmMISFoKcYJsX0eJ6NcNcSQGcBiFgngTSgPWaDcDVYMlvrP0LioUpvVAbu1
         nPq7C8aZH0qjO4uiW6Qjom7BbdPxHoDzPdrRHsb4KAEm9sXuFPeU46eMXehsS1dvuZ0B
         vKwft2B8qO9AZiYr2BKGUpJic0x6N2rnDZeinT23WnMiX7m/RhoDKKKO3HU1O+O2cPvL
         jXfekV1Bf5gmEHpSADnLvy7bz9rLU53OzW9hjNhCNP5B697FWY+Ath+oUI4NSACPfiA5
         6sRLEUq0jIaD2+u3x6zQyGlU6h9fqMomxLX/o3OGbta4kuvn/UcDNehHGctxxz9S4/1Z
         otnA==
X-Gm-Message-State: AOJu0YyAh0U3VElLNQ6yqovJPR+zZhY0+lW52Yl18xplTGaqGoraMhig
	KSq/W3wHdaG1F0fsz8Qxs7uZSgs4v2g=
X-Google-Smtp-Source: AGHT+IEODffAAuUR7rpjVrqAf+QLS9v4PPgl0Wn2IPkLdmfYO7MG512+fwCzYg6LD0HFNKQtTKo+3Q==
X-Received: by 2002:a05:6870:2208:b0:203:6595:c115 with SMTP id i8-20020a056870220800b002036595c115mr9286043oaf.37.1703007757230;
        Tue, 19 Dec 2023 09:42:37 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:2c02:6167:94c9:999b? ([2620:0:1000:8411:2c02:6167:94c9:999b])
        by smtp.gmail.com with ESMTPSA id bs9-20020a632809000000b0059b2316be86sm19822601pgb.46.2023.12.19.09.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:42:36 -0800 (PST)
Message-ID: <54a920d3-08e3-4810-806d-2961110d876d@acm.org>
Date: Tue, 19 Dec 2023 09:42:35 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prevent zoned write reordering
 due to I/O prioritization
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
References: <20231218211342.2179689-1-bvanassche@acm.org>
 <20231218211342.2179689-5-bvanassche@acm.org> <20231219121010.GA21240@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231219121010.GA21240@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/23 04:10, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 01:13:42PM -0800, Bart Van Assche wrote:
>> Assigning I/O priorities with the ioprio cgroup policy may cause
>> different I/O priorities to be assigned to write requests for the same
>> zone. Prevent that this causes unaligned write errors by adding zoned
>> writes for the same zone in the same priority queue as prior zoned
>> writes.
> 
> I still think this is fundamentally the wrong thing to do.  If you set
> different priorities, you want I/O to be reordered, so ignoring that
> is a bad thing.

Hi Christoph,

How about not setting the I/O priority of sequential zoned writes as in
the (untested) patch below?

Thanks,

Bart.


[PATCH] block: Do not set the I/O priority for sequential zoned writes

---
  block/blk-mq.c         |  7 +++++++
  include/linux/blk-mq.h | 17 +++++++++++++++++
  2 files changed, 24 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11c97afa0bc..668888103a47 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2922,6 +2922,13 @@ static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,

  static void bio_set_ioprio(struct bio *bio)
  {
+	/*
+	 * Do not set the I/O priority of sequential zoned write bios because
+	 * this could lead to reordering and hence to unaligned write errors.
+	 */
+	if (blk_bio_is_seq_zoned_write(bio))
+		return;
+
  	/* Nobody set ioprio so far? Initialize it based on task's nice value */
  	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
  		bio->bi_ioprio = get_current_ioprio();
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..e7fa81170b7c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1149,6 +1149,18 @@ static inline unsigned int blk_rq_zone_no(struct request *rq)
  	return disk_zone_no(rq->q->disk, blk_rq_pos(rq));
  }

+/**
+ * blk_bio_is_seq_zoned_write() - Check if @bio requires write serialization.
+ * @bio: Bio to examine.
+ *
+ * Note: REQ_OP_ZONE_APPEND bios do not require serialization.
+ */
+static inline bool blk_bio_is_seq_zoned_write(struct bio *bio)
+{
+	return disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector) &&
+		op_needs_zoned_write_locking(bio_op(bio));
+}
+
  static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
  {
  	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
@@ -1196,6 +1208,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
  	return !blk_req_zone_is_write_locked(rq);
  }
  #else /* CONFIG_BLK_DEV_ZONED */
+static inline bool blk_bio_is_seq_zoned_write(struct bio *bio)
+{
+	return false;
+}
+
  static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
  {
  	return false;

