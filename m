Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A138C4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 16:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiLHQs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLHQs1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 11:48:27 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337FD419B0
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 08:48:26 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id h17so1307006ila.6
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtTytaGK8EscfaX5sQg3WzTsPcFXdf66H/Qr7gq+ZeU=;
        b=1NsVi2LPvryDN0YAtJX6LCnADQ5OzXCjCNF5Oupz+xOmf6Z5HVHcfdWy5625BkIexO
         UPLI6mwR3tRA0ncoREpcYqAmWRjcQO++s0NBr4mWPc8q07+1woGt+JkoS1J4koa/m34i
         0uqh9nyJx6KJSXY6iDolAOLSwXgGMoCDTblFvkDBS2H21bc+5TZR9++P+qymHP87IdDt
         i7mJQ0460G0eqY73I96vwKFYE/SxEdk0GsPXjmjpWsjHfHrlC7okE6rvKSRH8b11sXFc
         xVlDw3S4/ZN0X0BptZoILKvSU0kOzZILD05dplubtfBlkbI340vbh9dQoUMNPKAYX6Eb
         z4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtTytaGK8EscfaX5sQg3WzTsPcFXdf66H/Qr7gq+ZeU=;
        b=LEFZhGOsgKKn9vKK/2hPLWBs3E89piV5Z5wC4ZRZkCi6kIVsgZYtLkAnPAlIUrG80t
         sHVZ/OImGgnxY/hXZrh3+LA86EjZhNU8D6fmer+kAswBYPbGIaiuP2qJ4wwjZuUkpK5J
         3V3zmK9bMlTQnREg2A++hsV4wtm324xW3MPG03WAuLGtGjIgb++aGZFqU00PA7xVVU39
         2BbP55lS0FSTd0FgcNqVtpL7clOsxB7K5cGnkjm5mHgTmY9ntkZ6gyJSkGNWeIPxTus/
         v8we2V8h86ZchjnWlfjTmn/D4rCTCSeGwK3y8NaSd5FLVPzZuylG244T+eJHoDOP9S5V
         iX0g==
X-Gm-Message-State: ANoB5pm4qA5VER77pqH/TiT0fkfvOKp3jPPTZ5lCqCI1l7/mDBnbAqzY
        smDpzfkOUbGbAj4Naes/OkVjlg==
X-Google-Smtp-Source: AA0mqf4Zzqp5ZuBvsh/zTJ1XExTv5sm3H2YTh8G90igsKIvVAiQzO0XoCxhbm7fpoFjKEzpIO4+lgQ==
X-Received: by 2002:a6b:8f84:0:b0:6e0:2427:f72e with SMTP id r126-20020a6b8f84000000b006e02427f72emr5170180iod.55.1670518105458;
        Thu, 08 Dec 2022 08:48:25 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n11-20020a056638110b00b00389d74d7e24sm8752485jal.146.2022.12.08.08.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:48:25 -0800 (PST)
Message-ID: <4701aded-0464-791e-8b8c-a34c422e8e62@kernel.dk>
Date:   Thu, 8 Dec 2022 09:48:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after
 polling I/O is finished
Content-Language: en-US
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        hch@infradead.org, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
 <Y5EJ+6qtsy8Twe/q@fedora>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y5EJ+6qtsy8Twe/q@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/22 2:47 PM, Stefan Hajnoczi wrote:
> On Tue, Dec 06, 2022 at 11:11:24PM +0900, Suwan Kim wrote:
>> Driver should set req->state to MQ_RQ_COMPLETE after it finishes to process
>> req. But virtio-blk doesn't set MQ_RQ_COMPLETE after virtblk_poll() handles
>> req and req->state still remains MQ_RQ_IN_FLIGHT. Fortunately so far there
>> is no issue about it because blk_mq_end_request_batch() sets req->state to
>> MQ_RQ_IDLE. This patch properly sets req->state after polling I/O is finished.
>>
>> Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
>> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
>> ---
>>  drivers/block/virtio_blk.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 19da5defd734..cf64d256787e 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -839,6 +839,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
>>  	rq_list_for_each(&iob->req_list, req) {
>>  		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
>>  		virtblk_cleanup_cmd(req);
>> +		blk_mq_set_request_complete(req);
>>  	}
>>  	blk_mq_end_request_batch(iob);
>>  }
> 
> The doc comment for blk_mq_set_request_complete() mentions this being
> used in ->queue_rq(), but that's not the case here. Does the doc comment
> need to be updated if we're using the function in a different way?

Looks like it's a bit outdated...

> I'm not familiar enough with the Linux block APIs, but this feels weird
> to me. Shouldn't blk_mq_end_request_batch(iob) take care of this for us?
> Why does it set the state to IDLE instead of COMPLETE?
> 
> I think Jens can confirm whether we really want all drivers that use
> polling and io_comp_batch to manually call
> blk_mq_set_request_complete().

Should not be a need to call blk_mq_set_request_complete() directly in
the driver for this.

-- 
Jens Axboe


