Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69126C2BA83
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 17:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6B220873
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 17:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLRe4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:34:56 -0500
Received: from relay.sw.ru ([185.231.240.75]:43222 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRe4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 12:34:56 -0500
Received: from [192.168.15.107]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j1vuX-0007GT-JU; Wed, 12 Feb 2020 20:34:53 +0300
Subject: Re: [PATCH v6 6/6] loop: Add support for REQ_ALLOCATE
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
 <158132724397.239613.16927024926439560344.stgit@localhost.localdomain>
 <20200212170156.GM6874@magnolia>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <786c991e-cfaa-b2af-cac2-7165e6d7fa34@virtuozzo.com>
Date:   Wed, 12 Feb 2020 20:34:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212170156.GM6874@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12.02.2020 20:01, Darrick J. Wong wrote:
> On Mon, Feb 10, 2020 at 12:34:04PM +0300, Kirill Tkhai wrote:
>> Support for new modifier of REQ_OP_WRITE_ZEROES command.
>> This results in allocation extents in backing file instead
>> of actual blocks zeroing.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> Reviewed-by: Bob Liu <bob.liu@oracle.com>
>> ---
>>  drivers/block/loop.c |   15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 739b372a5112..bfe76d9adf09 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -581,6 +581,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>>  	return 0;
>>  }
>>  
>> +static unsigned int write_zeroes_to_fallocate_mode(unsigned int flags)
>> +{
>> +	if (flags & REQ_ALLOCATE)
>> +		return 0;
>> +	if (flags & REQ_NOUNMAP)
>> +		return FALLOC_FL_ZERO_RANGE;
>> +	return FALLOC_FL_PUNCH_HOLE;
>> +}
>> +
>>  static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>>  {
>>  	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
>> @@ -604,9 +613,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>>  		 * write zeroes the range.  Otherwise, punch them out.
>>  		 */
> 
> Please update this comment to reflect the new REQ_ALLOCATE mode, and
> move it to where you define write_zeroes_to_fallocate_mode().

Ok, I'll update it in v7

> With that fixed,
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks
