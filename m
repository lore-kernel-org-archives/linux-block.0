Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20B4C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 22:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1C1206C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 22:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QcJLEAEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfBVWq7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:46:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55659 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVWq6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 17:46:58 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so5314572itf.5
        for <linux-block@vger.kernel.org>; Fri, 22 Feb 2019 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qBOSh5c7P0DEQBU9HztfFzFFVSGGT9iqvgwTysEDZ3U=;
        b=QcJLEAEeUd7dHTFjrmu5J1pPK23qzxO8b+mAM9TGI2otq5DCfhGPIus0A9V62GCf04
         NQMnKorZORY9/fqn/0BSG5IDYo75c8nAldZvrueIXHt40JhO2V2f0X0Hd0VfyXthG+EV
         QtBe1n5iX8g4UQ62tuqDAoUC2KuiCWZ1h2UyaTmbHK6AIJR4miJCzZo1Lt5psl/yOhrB
         aiAAD+gUUy963dA5KQjfXY329+Zss3ONR2dUotStCWyImFsF7UxK86m1pFmR0sra5r4R
         Q1mFOZqhhAvaEoUe3xviOKinowNolJBtwXEkGSzghpCSvWffrs73iiInK7De/pztdSi4
         D9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qBOSh5c7P0DEQBU9HztfFzFFVSGGT9iqvgwTysEDZ3U=;
        b=WVUmAFw7lBB2ncBPQCnZN8H6Yn7noH/s5naqNschKmzmrO68JvgLN9VGdLqoVhV2Qz
         QzhQExkR4tdPnSASeyQiKOxlyzFwpRT3Ost8+y/xGjypsLVZEb263LnpTt78pXirjMvU
         zlEI5QmudsvFup0TD6CyM0ttN6XUfg9kczflzOVfV9WkLHs5N+DXssmmO9XI4I/oLQM3
         9Ag2Jw4hJNYxNNlB64CBnw0qbahG+jDsaNwM6xkGTmn6TcRy4NZetmgoPt8co2rONO1H
         LTcJTcKxTR59TuxmYRsrS/Z9Rug1mhObaTLcqQX3rOK6ZO68IKiiKCa3lMJEsWiAT1y6
         Bn9g==
X-Gm-Message-State: AHQUAubw/CVPqFiB73FcK72WaYY+P7y87S5M+BszIE9+Nnk8ABFtXQnD
        NYcd7SBpTrQc9S96uYbYNc/7uQ==
X-Google-Smtp-Source: AHgI3IYGD7c5duPTzf4cf2VDHsPXr8XT82DJnlleCdKOvnW4vjE8QyGLiayIGEBUEy62OdICnMue6g==
X-Received: by 2002:a02:9dd:: with SMTP id 90mr2811280jam.21.1550875618032;
        Fri, 22 Feb 2019 14:46:58 -0800 (PST)
Received: from [172.19.131.32] ([8.46.76.24])
        by smtp.gmail.com with ESMTPSA id l19sm1031645iob.46.2019.02.22.14.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:46:57 -0800 (PST)
Subject: Re: block: be more careful about status in __bio_chain_endio
To:     Mike Snitzer <snitzer@redhat.com>, NeilBrown <neilb@suse.com>
Cc:     linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name> <20190222211006.GA10987@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7f0aeb7b-fdaa-0625-f785-05c342047550@kernel.dk>
Date:   Fri, 22 Feb 2019 15:46:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222211006.GA10987@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/19 2:10 PM, Mike Snitzer wrote:
> On Thu, Feb 15 2018 at  4:09am -0500,
> NeilBrown <neilb@suse.com> wrote:
> 
>>
>> If two bios are chained under the one parent (with bio_chain())
>> it is possible that one will succeed and the other will fail.
>> __bio_chain_endio must ensure that the failure error status
>> is reported for the whole, rather than the success.
>>
>> It currently tries to be careful, but this test is racy.
>> If both children finish at the same time, they might both see that
>> parent->bi_status as zero, and so will assign their own status.
>> If the assignment to parent->bi_status by the successful bio happens
>> last, the error status will be lost which can lead to silent data
>> corruption.
>>
>> Instead, __bio_chain_endio should only assign a non-zero status
>> to parent->bi_status.  There is then no need to test the current
>> value of parent->bi_status - a test that would be racy anyway.
>>
>> Note that this bug hasn't been seen in practice.  It was only discovered
>> by examination after a similar bug was found in dm.c
>>
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  block/bio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index e1708db48258..ad77140edc6f 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -312,7 +312,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
>>  {
>>  	struct bio *parent = bio->bi_private;
>>  
>> -	if (!parent->bi_status)
>> +	if (bio->bi_status)
>>  		parent->bi_status = bio->bi_status;
>>  	bio_put(bio);
>>  	return parent;
>> -- 
>> 2.14.0.rc0.dirty
>>
> 
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>
> 
> Jens, this one slipped through the crack just over a year ago.
> It is available in patchwork here:
> https://patchwork.kernel.org/patch/10220727/

Should this be:

	if (!parent->bi_status && bio->bi_status)
		parent->bi_status = bio->bi_status;

perhaps?

-- 
Jens Axboe

