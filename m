Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B28C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 09:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5DA20821
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 09:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="HFX9CdQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfBEJXs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:23:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34943 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfBEJXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 04:23:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so2274921ljb.2
        for <linux-block@vger.kernel.org>; Tue, 05 Feb 2019 01:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IvOF0BMkxj+dbYdMrP+7G38KGilfiMp/dCW7tsr6uuI=;
        b=HFX9CdQJ4IHjKPomthOf6EUkF3fJepBla1QH38ei5xJzjaDxer0SfyZIfJsF1djMFJ
         L9dqC5G7Hj9cSLfWffhGib3le5qlzSLDIUDhxn7UaY0BYH8sd0NjicHEXoR/RrOOQK5O
         IzxOTQEZM4yDE+Wa48hcBApX9pN0PNh/aVHoxFmdzL9+OPYyQ3OZRpyWygF63OwnGuwZ
         e9uMxjc50098hDBi/uSiTPzDZYSMhnlATcE0++DPISM0Wg6PJtJh2qbR4eAK3NEuiOxB
         aVystB4kjQwieCUr7h/sUP0wgwdtvHG8UmSC5PahJEPIr33Evssn4xkUflpivZI/Lb1M
         Eakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IvOF0BMkxj+dbYdMrP+7G38KGilfiMp/dCW7tsr6uuI=;
        b=NJICo1shCsehZfurLeBCMQaiqIwCo+YIB1BognoWOhKrILJw263/fMN9h0vgr4wduI
         1uuYKzh4A1v1rm2ay7i24oysWZYFUfADgP8iJFe7R/Jf7eO62YLp3un0nDjeYUEbkrwZ
         O/vqU97rfptuLgETDHAmqBk7xujPFT1wLQPlpwPtmaxTV3adf8HiZBzb9ZTugXK2b3Ly
         g7gfLzTFgLucU5+GxkOCtuLMocOu1QAUyk3QaM6xQHEB7qw7lfyrW1ZzoW3Cg92g9f6j
         bOXJczyIUR24dJPnuRHSvEdTcf0jwftdo1kVhILFy1So/9rQOaXJS7sPQjhjFIMt+7Q0
         h5vw==
X-Gm-Message-State: AHQUAuZkWF3BPOPJPaKDTk+PA8d2U5DvJgKFvOsxEc/dnwvXd4C0M/gH
        RzER/2G1XFu9VD6E02Eq5zObM3XWXHY=
X-Google-Smtp-Source: AHgI3IYlpzIdUhdFVWlxaHT7CMI7ihdoS2DiCBjWKFsrA9ZMj+TRa1GQRjyR8iiUcHMuSc5bQsCCYA==
X-Received: by 2002:a2e:8855:: with SMTP id z21-v6mr2234092ljj.191.1549358624992;
        Tue, 05 Feb 2019 01:23:44 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id g85-v6sm3223415lji.17.2019.02.05.01.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:23:44 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: fix bio leak on large sized io
To:     chansol.kim@samsung.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "javier@javigon.com" <javier@javigon.com>
References: <0fd83092-515e-7e59-bc38-66e1d3b5d9c1@lightnvm.io>
 <20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <CGME20190130015343epcms2p14be92e88982e86f5e9d494e3bdc3fb2a@epcms2p1>
 <20190201082237epcms2p1b58a31cca3f4c130d92f61b5dcf1ca6b@epcms2p1>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8d8bae48-be1f-a211-0a62-a5421c77d818@lightnvm.io>
Date:   Tue, 5 Feb 2019 10:23:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190201082237epcms2p1b58a31cca3f4c130d92f61b5dcf1ca6b@epcms2p1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/19 9:22 AM, Chansol Kim wrote:
> 
> On 01/31/19 22:14 PM, Matias Bjørling wrote:
>> On 1/30/19 2:53 AM, 김찬솔 wrote:
>>>
>>> Changes:
>>>    1. Function pblk_rw_io to get bio* as a reference
>>>    2. In pblk_rw_io bio_put call on read case removed
>>>
>>> A fix to address issue where
>>>    1. pblk_make_rq calls pblk_rw_io passes bio* pointer as a value (0xA)
>>>    2. pblk_rw_io calls blk_queue_split passing bio* pointer as reference
>>>    3. In blk_queue_split, when there is a split, the original bio* (0xA)
>>>       is passed to generic_make_requests, and the newly allocated bio is
>>>       returned
>>>    4. If NVM_IO_DONE returned, pblk_make_rq calls bio_endio on the bio*,
>>>       that is not the one returned by blk_queue_split
>>>    5. As a result bio_endio is not called on the newly allocated bio.
>>>
>>> Signed-off-by: chansol.kim <chansol.kim@samsung.com>
>>> ---
>>>    drivers/lightnvm/pblk-init.c | 22 ++++++++--------------
>>>    1 file changed, 8 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index b57f764d..4efc929 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -31,30 +31,24 @@ static DECLARE_RWSEM(pblk_lock);
>>>    struct bio_set pblk_bio_set;
>>>    
>>>    static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
>>> -			  struct bio *bio)
>>> +			  struct bio **bio)
>>>    {
>>> -	int ret;
>>> -
>>>    	/* Read requests must be <= 256kb due to NVMe's 64 bit completion bitmap
>>>    	 * constraint. Writes can be of arbitrary size.
>>>    	 */
>>> -	if (bio_data_dir(bio) == READ) {
>>> -		blk_queue_split(q, &bio);
>>> -		ret = pblk_submit_read(pblk, bio);
>>> -		if (ret == NVM_IO_DONE && bio_flagged(bio, BIO_CLONED))
>>> -			bio_put(bio);
>>
>> Could we kill the NVM_DONE_IO check in the pblk_rw_io, that should
>> achieve the same?
> 
> I think it is possible to remove NVM_DONE_IO check here. And in that
> case perhaps it is necessary to change bio_endio call to somewhere other
> than pblk_make_rq, otherwise endio call would not be made to the new
> bio*.
> 
> Assuming pblk_rw_io's second parameter is to be remained as bio*, There
> are three cases I think needs consideration. NVM_IO_ERROR return case,
> the read case and the write case.
> 
> In NVM_IO_ERROR return case, for both read and write. NVM_IO_ERROR
> received by pblk_make_rq and bio_io_error called on bio, since this bio*
> that pblk_submit_read and pblk_write_to_cache function tried and failed
> might be a new one, so bio_io_error call needs to be made inside
> pblk_rw_io.
> 
> In read case, there are three sub-cases. The first is All data is available
> in ring buffer and NVM_IO_DONE is returned. The second is all to be read
> from the device, which currently NVM_IO_OK is returned and endio is
> called after read completion from the device. The third is partial read,
> where the data that needs to be read from the device is read
> synchronously and pblk_rw_io returns NVM_IO_DONE.
> 
> In write case, there are two sub-cases. Firstly, non REQ_PRE_FLUSH case,
> pblk_write_cache wil return either NVM_IO_DONE or NVM_IO_ERROR. A endio
> call is required in place somewhere NVM_IO_DONE is decided.
> 
> For REQ_PREFLUSH case bio (new bio* if split) is added to w_ctx.bios,
> pblk_write_to_cache will return either NVM_IO_OK or NVM_IO_ERROR. bio*
> added to w_ctx.bios will be called by bio_endio on write completion to
> the disk. So it is already taken care of.
> 
> In summary my feeling is that having pblk_rw_io receive bio* as a
> reference and removing bio_put in pblk_rw_io would be the minimum
> change. Please share your insight, I will try experimenting alternatives.

What rubs me the wrong way is that that pattern isn't used in the rest 
of kernel. I would rather move the calls to bio_io_error and bio_endio 
into the pblk_rw_io() function. The implementation of pblk_rw_io() leaks 
out to pblk_make_rq(). The code is a mismatch of some bio_endio calls 
inside the pblk_rw_io, and others outside. It's not coherent.
