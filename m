Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blk-mq-tag: change busy_iter_fn to return whether to
 continue or not
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20181108160609.27568-1-axboe@kernel.dk>
 <20181108160609.27568-3-axboe@kernel.dk>
 <1541694515.196084.218.camel@acm.org>
 <8a340d9c-da15-90c9-760e-fb80fb2871b6@kernel.dk>
 <1541698519.196084.225.camel@acm.org>
 <c4ce645a-1e09-02eb-ca41-088e83a55cd8@kernel.dk>
Message-ID: <57c15689-c5bd-be21-6a19-fbf7eb7dfcd0@kernel.dk>
Date: Thu, 8 Nov 2018 10:50:15 -0700
MIME-Version: 1.0
In-Reply-To: <c4ce645a-1e09-02eb-ca41-088e83a55cd8@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/8/18 10:47 AM, Jens Axboe wrote:
> On 11/8/18 10:35 AM, Bart Van Assche wrote:
>> On Thu, 2018-11-08 at 09:31 -0700, Jens Axboe wrote:
>>> On 11/8/18 9:28 AM, Bart Van Assche wrote:
>>>> On Thu, 2018-11-08 at 09:06 -0700, Jens Axboe wrote:
>>>>> --- a/block/blk-mq-debugfs.c
>>>>> +++ b/block/blk-mq-debugfs.c
>>>>> @@ -424,13 +424,15 @@ struct show_busy_params {
>>>>>   * Note: the state of a request may change while this function is in progress,
>>>>>   * e.g. due to a concurrent blk_mq_finish_request() call.
>>>>>   */
>>>>> -static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>>>> +static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>>>>>  {
>>>>
>>>> Please update the kdoc header above hctx_show_busy_rq() such that it reflects
>>>> the new behavior. I'm referring to the "will be called for each request" part.
>>>> Otherwise this patch looks fine to me.
>>>
>>> Took a look at the comment, and what do you want changed? There's no change
>>> in behavior for hctx_show_busy_rq(), it loops all requests just like before.
>>> We just return true to ensure we continue iterating.
>>
>> Oops, I added my reply below the wrong function. I wanted to refer to the
>> following comment above blk_mq_queue_tag_busy_iter():
>>
>>  * @fn:		Pointer to the function that will be called for each request
>>
>> Additionally, how about similar comments above bt_for_each(), bt_tags_for_each()
>> blk_mq_all_tag_busy_iter() and blk_mq_tagset_busy_iter()? I think this patch
>> affects all these functions.
> 
> Fair enough, I'll add a documentation patch. Didn't consider it a big deal
> since this is how it's always worked internally, but we haven't exposed
> this break/continue functionality outside the sbitmap core until now.

How about this incremental?


diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 097e9a67d5f5..87bc5df72d48 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -248,7 +248,8 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  * @fn:		Pointer to the function that will be called for each request
  *		associated with @hctx that has been assigned a driver tag.
  *		@fn will be called as follows: @fn(@hctx, rq, @data, @reserved)
- *		where rq is a pointer to a request.
+ *		where rq is a pointer to a request. Return true to continue
+ *		iterating tags, false to stop.
  * @data:	Will be passed as third argument to @fn.
  * @reserved:	Indicates whether @bt is the breserved_tags member or the
  *		bitmap_tags member of struct blk_mq_tags.
@@ -301,7 +302,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each started
  *		request. @fn will be called as follows: @fn(rq, @data,
- *		@reserved) where rq is a pointer to a request.
+ *		@reserved) where rq is a pointer to a request. Return true
+ *		to continue iterating tags, false to stop.
  * @data:	Will be passed as second argument to @fn.
  * @reserved:	Indicates whether @bt is the breserved_tags member or the
  *		bitmap_tags member of struct blk_mq_tags.
@@ -326,7 +328,8 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
  * @fn:		Pointer to the function that will be called for each started
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request.
+ *		indicates whether or not @rq is a reserved request. Return
+ *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
 static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
@@ -343,7 +346,8 @@ static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
  * @fn:		Pointer to the function that will be called for each started
  *		request. @fn will be called as follows: @fn(rq, @priv,
  *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request.
+ *		indicates whether or not @rq is a reserved request. Return
+ *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,

-- 
Jens Axboe
