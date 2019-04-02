Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467D6C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 08:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4E2084C
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 08:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GAwnoWUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfDBI30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:29:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49662 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBI30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 04:29:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x328T7jY048686;
        Tue, 2 Apr 2019 08:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3jRDUeiXkFHvwsqHt5Q4huXUFy4hLdjxSYti9CSQj/w=;
 b=GAwnoWUrHzAWxYFqKX2qWZ7HHQ/7wmP4djhF2mv2AZgSRGy7mjE5aQ+DgV4sja1kYouZ
 0Rwhld771QO0sSH3jVCfaCHYnN0I6oRYg4rz1REdPNUL6zraiG9GT4dtftckH3YnyHqK
 yVcTNZbDHzxfJPeCBJIXMOFQWMJQ4YFQT1WMoxXqmoVJR+wT5Sp5UB5CaoB6O8wo4QOb
 6iRlOKGjCtAHJbwAkGjhtIt1A4M+HsbEKGdlJ1QNMw/H5rinVSNx0NW4xJ6JPMgbrGpl
 7/tGGVnBnVEa2JJvVwcTT/OdjXUUAp3hS4ipKMY7srOaQZO9TKJ8yvmRIOFvZE9Ue1No 1w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2rhwyd3rn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 08:29:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x328T9FD031285
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 08:29:09 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x328T8qi006998;
        Tue, 2 Apr 2019 08:29:08 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 01:29:08 -0700
Subject: Re: [PATCH] io_uring: introduce inline reqs for IORING_SETUP_IOPOLL &
 direct_io
To:     Jens Axboe <axboe@kernel.dk>
Cc:     viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554174646-1715-1-git-send-email-jianchao.w.wang@oracle.com>
 <15be30c1-db76-d446-16c0-f2ef340658ec@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <dec8be2b-46bc-622f-63fa-251bf8609855@oracle.com>
Date:   Tue, 2 Apr 2019 16:29:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <15be30c1-db76-d446-16c0-f2ef340658ec@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904020062
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

On 4/2/19 11:47 AM, Jens Axboe wrote:
> On 4/1/19 9:10 PM, Jianchao Wang wrote:
>> For the IORING_SETUP_IOPOLL & direct_io case, all of the submission
>> and completion are handled under ctx->uring_lock or in SQ poll thread
>> context, so io_get_req and io_put_req has been serialized well.
>>
>> Based on this, we introduce the preallocated reqs ring per ctx and
>> needn't to provide any lock to serialize the updating of the head
>> and tail. The performacne benefits from this. The test result of
>> following fio command
>>
>> fio --name=io_uring_test --ioengine=io_uring --hipri --fixedbufs
>> --iodepth=16 --direct=1 --numjobs=1 --filename=/dev/nvme0n1 --bs=4k
>> --group_reporting --runtime=10
>>
>> shows IOPS upgrade from 197K to 206K.
> 
> I like this idea, but not a fan of the execution of it. See below.
> 
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 6aaa3058..40837e4 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -104,11 +104,17 @@ struct async_list {
>>  	size_t			io_pages;
>>  };
>>  
>> +#define INLINE_REQS_TOTAL 128
>> +
>>  struct io_ring_ctx {
>>  	struct {
>>  		struct percpu_ref	refs;
>>  	} ____cacheline_aligned_in_smp;
>>  
>> +	struct io_kiocb *inline_reqs[INLINE_REQS_TOTAL];
>> +	struct io_kiocb *inline_req_array;
>> +	unsigned long inline_reqs_h, inline_reqs_t;
> 
> Why not just use a list? The req has a list member anyway. Then you don't
> need a huge array, just a count.

Yes, indeed.

> 
>> +
>>  	struct {
>>  		unsigned int		flags;
>>  		bool			compat;
>> @@ -183,7 +189,9 @@ struct io_ring_ctx {
>>  
>>  struct sqe_submit {
>>  	const struct io_uring_sqe	*sqe;
>> +	struct file 			*file;
>>  	unsigned short			index;
>> +	bool 				is_fixed;
>>  	bool				has_user;
>>  	bool				needs_lock;
>>  	bool				needs_fixed_file;
> 
> Not sure why you're moving these to the sqe_submit?

Just want to get the file before io_get_req to know whether it is direct_io.
This is unnecessary if eliminate the direct io limitation.

> 
>> @@ -228,7 +236,7 @@ struct io_kiocb {
>>  #define REQ_F_PREPPED		16	/* prep already done */
>>  	u64			user_data;
>>  	u64			error;
>> -
>> +	bool 			ctx_inline;
>>  	struct work_struct	work;
>>  };
> 
> ctx_inline should just be a req flag.

Yes.

> 
>>  
>> @@ -397,7 +405,8 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
>>  }
>>  
>>  static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>> -				   struct io_submit_state *state)
>> +				   struct io_submit_state *state,
>> +				   bool direct_io)
>>  {
>>  	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
>>  	struct io_kiocb *req;
>> @@ -405,10 +414,19 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>>  	if (!percpu_ref_tryget(&ctx->refs))
>>  		return NULL;
>>  
>> -	if (!state) {
>> +	/*
>> +	 * Avoid race with workqueue context that handle buffered IO.
>> +	 */
>> +	if (direct_io &&
>> +	    ctx->inline_reqs_h - ctx->inline_reqs_t < INLINE_REQS_TOTAL) {
>> +	    req = ctx->inline_reqs[ctx->inline_reqs_h % INLINE_REQS_TOTAL];
>> +	    ctx->inline_reqs_h++;
>> +	    req->ctx_inline = true;
>> +	} else if (!state) {
> 
> What happens for O_DIRECT that ends up being punted to async context?

I misunderstand that only buffered io would be punted to async workqueue context.

> We need a clearer indication of whether or not we're under the lock or
> not, and then get rid of the direct_io "limitation" for this. Arguably,
> cached buffered IO needs this even more than O_DIRECT does, since that
> is much faster.
> 

Before punt the IO to async workqueue context, a sqe_copy will be allocated.
How about allocating a structure with both a sqe and a io_kiocb ?
Then use the newly allocated io_kiocb to replace the preallocated io_kiocb and
release the latter one. Then we could eliminate the wrong direct_io limitation.

Thanks
Jianchao
