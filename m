Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E11C48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 10:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B642084B
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 10:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="KOe/7GGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfFYKfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:35:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39547 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfFYKfG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 06:35:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so12248992lfo.6
        for <linux-block@vger.kernel.org>; Tue, 25 Jun 2019 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EGjfhIk5TSN9FaIfuigOm3JkqdiZdbnqlP1fTL53QW4=;
        b=KOe/7GGnb9guFoDqCfkS5NUn9D6GDW6anEPhkzSe4sb4u4e5wQeNrsV+R64/xpTuhl
         iD7V2xuwQjeDUzbRsYt4GUeVK8aenCJTNrAxhSFS/H67p5oyemMuW9iUadPHrnaduQ5E
         QZtGmJNZ43tCR3BKAqAYwxw9Z1vFM3bkyZknYFxHgYEHw338izNPCusYNFh8Dmu9CHLl
         I3bpWPCznu0PuIxo6HsejEClDHD9NjC7ovnOrvczsFmU2k5U0CqIYS/MiOyZGjpNBBDE
         5+vQLLFo+AeTwZpVBmCJqfOGp/Q++LuhMwNwjO5alq2BUMmVoXcpaOQESrx/69WsQZUU
         NNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EGjfhIk5TSN9FaIfuigOm3JkqdiZdbnqlP1fTL53QW4=;
        b=ph9h2a7PHC/2j31cLhs7cZre5nsB3HqkByVSr4DoN3A08S9xZZhRBSDjvxPIblP47h
         8iwocx6JTd5W8sOh65Bk8mRFc9Vs6WUGh63/RP4Q/M1ZuCrXBQFBFOO0/l1xge01i8oO
         wn8lS+mDhsboT2JBgsWQf5BCtOKKHcwuavaM0Sa/SmNfcHeIMsL8dXE5xy96quZhWruj
         MKCNp5s+UZkWom1sBnyYreb8wmgh5wpdiJZHWOIntHgnE70Y/lcnTXbwdQv2y6ua2YOp
         JpFxrTBowY6sWhHTMdQOZz3LeHCUHF+3xUpf8S6snq3GcNWkkAHDqA4b0FHblGrMc9w4
         0L7w==
X-Gm-Message-State: APjAAAU7KKWIND40CtAKrlkduWn9yUmW3bHmZ6QlVgjWTmeSt1uAro64
        Is8+kgAc1Ppilu6LHEKOTTDf5Q==
X-Google-Smtp-Source: APXvYqwrNvD5m3v3LyKns+LBQyX4g8GF8KVIhTUjFGqgIDy4CqsHB0bpIJZ+Jvt3yL56+cH0RwtSvg==
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr77759447lfl.1.1561458903508;
        Tue, 25 Jun 2019 03:35:03 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id t21sm2214209ljg.60.2019.06.25.03.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:35:02 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
 <ee5764fb-473a-f118-eaac-95478d885f6f@acm.org>
 <BYAPR04MB5749CEFBB45EA34BD3345CD686E00@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <cce08df0-0b4d-833d-64ce-f9b81f7ad7ca@lightnvm.io>
Date:   Tue, 25 Jun 2019 12:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749CEFBB45EA34BD3345CD686E00@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/19 12:27 AM, Chaitanya Kulkarni wrote:
> On 6/24/19 12:43 PM, Bart Van Assche wrote:
>> On 6/21/19 6:07 AM, Matias Bjørling wrote:
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index 95202f80676c..067ef9242275 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -284,13 +284,20 @@ enum req_opf {
>>>     	REQ_OP_DISCARD		= 3,
>>>     	/* securely erase sectors */
>>>     	REQ_OP_SECURE_ERASE	= 5,
>>> -	/* reset a zone write pointer */
>>> -	REQ_OP_ZONE_RESET	= 6,
>>>     	/* write the same sector many times */
>>>     	REQ_OP_WRITE_SAME	= 7,
>>>     	/* write the zero filled sector many times */
>>>     	REQ_OP_WRITE_ZEROES	= 9,
>>>     
>>> +	/* reset a zone write pointer */
>>> +	REQ_OP_ZONE_RESET	= 16,
>>> +	/* Open zone(s) */
>>> +	REQ_OP_ZONE_OPEN	= 17,
>>> +	/* Close zone(s) */
>>> +	REQ_OP_ZONE_CLOSE	= 18,
>>> +	/* Finish zone(s) */
>>> +	REQ_OP_ZONE_FINISH	= 19,
>>> +
>>>     	/* SCSI passthrough using struct scsi_request */
>>>     	REQ_OP_SCSI_IN		= 32,
>>>     	REQ_OP_SCSI_OUT		= 33,
>>> @@ -375,6 +382,22 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
>>>     	bio->bi_opf = op | op_flags;
>>>     }
>>
>> Are the new operation types ever passed to op_is_write()? The definition
>> of that function is as follows:
>>
> May be we should change numbering since blktrace also relies on the
> having on_is_write() without looking at the rq_ops().
> 
> 197  * Data direction bit lookup
>    198  */
>    199 static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
>    200                                  BLK_TC_ACT(BLK_TC_WRITE) };  <----
>    201
>    202 #define BLK_TC_RAHEAD           BLK_TC_AHEAD
>    203 #define BLK_TC_PREFLUSH         BLK_TC_FLUSH
>    204
>    205 /* The ilog2() calls fall out because they're constant */
>    206 #define MASK_TC_BIT(rw, __name) ((rw & REQ_ ## __name) << \
>    207           (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT - __REQ_ ##
> __name))
>    208
>    209 /*
>    210  * The worker for the various blk_add_trace*() types. Fills out a
>    211  * blk_io_trace structure and places it in a per-cpu subbuffer.
>    212  */
>    213 static void __blk_add_trace(struct blk_trace *bt, sector_t sector,
> int bytes,
>    214                      int op, int op_flags, u32 what, int error,
> int pdu_len,
>    215                      void *pdu_data, union kernfs_node_id *cgid)
>    216 {
>    217         struct task_struct *tsk = current;
>    218         struct ring_buffer_event *event = NULL;
>    219         struct ring_buffer *buffer = NULL;
>    220         struct blk_io_trace *t;
>    221         unsigned long flags = 0;
>    222         unsigned long *sequence;
>    223         pid_t pid;
>    224         int cpu, pc = 0;
>    225         bool blk_tracer = blk_tracer_enabled;
>    226         ssize_t cgid_len = cgid ? sizeof(*cgid) : 0;
>    227
>    228         if (unlikely(bt->trace_state != Blktrace_running &&
> !blk_tracer))
>    229                 return;
>    230
>    231         what |= ddir_act[op_is_write(op) ? WRITE : READ];  <---
> 
> 
>> static inline bool op_is_write(unsigned int op)
>> {
>> 	return (op & 1);
>> }
>>
> 

The zone mgmt commands are neither write nor reads commands. I guess, 
one could characterize them as write commands, but they don't write any 
data, they update a state of a zone on a drive. One should keep it as 
is? and make sure the zone mgmt commands don't get categorized as either 
read/write.
