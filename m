Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A4B5
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 16:11:50 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so3535849b3a.0
        for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 16:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702339910; x=1702944710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCMseI9UB8yOPpsjJ/R2TZ7S1vtSuhjjwpdtycZS6UM=;
        b=Gpx6qrABYZiI5Izw93RAoTR1Tfxrk8J594AqmjewHjtH8YRDa/mNp77t+TcNyDHkiR
         zLZnrMD51Zv/JAsvbhFsEZaTJX0H6esUcdAzmaTMd2Nw8WvLbn4jVZ/uDsIGlb7v4zwv
         +0zesCUr7IAzmBAAGoMK2tLd/ZpusDGSJiK4HhFfnJJ4VKzFmO7KhZL3Jhod2zYwL+YT
         37+LcyaZfS8cjwfZk2ZP6TtwdJpNewiSV+ki2Drn0ZcH3U1yhupuyD/cM3mGbTKJDbe9
         4Z4TuhZvxDLUxEgyM4lr8R9GeWE0L7iLT9uARCmZZb3ymxXMi89lL8EmFGVImQ16ZFzs
         i22Q==
X-Gm-Message-State: AOJu0YzVYCCVbJ5wWwjOBmATlSjds1MdyI961tCkI8jM9w4lyL3D6TdV
	9WYzzrDKBAS2S7NC8LRkGS5wY4sGj/Q=
X-Google-Smtp-Source: AGHT+IG1NomgD5pA7rjmnrGVx79sEk8MTQxwbfiIosgy2utm/wYhtbuu7FjesezCJ4qzciTQzRwY0w==
X-Received: by 2002:a05:6a00:181f:b0:6ce:4587:4d7b with SMTP id y31-20020a056a00181f00b006ce45874d7bmr7858289pfa.24.1702339909172;
        Mon, 11 Dec 2023 16:11:49 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3431:681a:6403:d100? ([2620:0:1000:8411:3431:681a:6403:d100])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7880c000000b006ce7ff254b9sm6890318pfo.68.2023.12.11.16.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 16:11:48 -0800 (PST)
Message-ID: <d660cc31-a5be-47f2-9fdf-ba4bf5106226@acm.org>
Date: Mon, 11 Dec 2023 16:11:47 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/blk-ioprio: Skip zoned writes that are not append
 operations
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20231211231451.1452979-1-bvanassche@acm.org>
 <19eaaa5b-e4b7-41aa-b5a2-7d5a89927a91@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <19eaaa5b-e4b7-41aa-b5a2-7d5a89927a91@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 15:31, Damien Le Moal wrote:
> On 12/12/23 08:14, Bart Van Assche wrote:
>> +	/*
>> +	 * If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
>> +	 * originate from different cgroups that could result in different
>> +	 * priorities being assigned to these operations. Do not modify the I/O
>> +	 * priority of these write operations to prevent that these would be
>> +	 * executed in the wrong order when using the mq-deadline I/O
>> +	 * scheduler.
>> +	 */
>> +	if (bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
> 
> Ideally, we want the bio equivalent of blk_rq_is_seq_zoned_write() here so that
> writes to conventional zones are not affected (these can be reordered).
  How about the patch below?

Thanks,

Bart.


[PATCH] block/blk-ioprio: Skip zoned writes that are not append operations

If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
originate from different cgroups that could result in different priorities
being assigned to these operations. Do not modify the I/O priority of
these write operations to prevent them from being executed in the wrong
order when using the mq-deadline I/O scheduler.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  block/blk-ioprio.c     | 11 +++++++++++
  include/linux/blk-mq.h | 17 +++++++++++++++++
  2 files changed, 28 insertions(+)

diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
index 4051fada01f1..96b46d34e3d6 100644
--- a/block/blk-ioprio.c
+++ b/block/blk-ioprio.c
@@ -192,6 +192,17 @@ void blkcg_set_ioprio(struct bio *bio)
  	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
  		return;

+	/*
+	 * If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
+	 * originate from different cgroups that could result in different
+	 * priorities being assigned to these operations. Do not modify the I/O
+	 * priority of these write operations to prevent that these would be
+	 * executed in the wrong order when using the mq-deadline I/O
+	 * scheduler.
+	 */
+	if (blk_bio_is_seq_zoned_write(bio))
+		return;
+
  	if (blkcg->prio_policy == POLICY_PROMOTE_TO_RT ||
  	    blkcg->prio_policy == POLICY_NONE_TO_RT) {
  		/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..90907d9001c0 100644
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
+	return op_needs_zoned_write_locking(bio_op(bio)) &&
+		disk_zone_is_seq(bio->bi_disk, bio.bi_iter.bi_sector);
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

