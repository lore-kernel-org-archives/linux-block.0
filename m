Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA50C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 20:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0342B218B0
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 20:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OdgJgLUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfBFUFF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:05:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36191 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfBFUFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 15:05:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so3388954pgm.3
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oIvBkJiBzrKQDAhe5MG5Na1EGx/NKSJvjkVLzH64xck=;
        b=OdgJgLUF4kb7HdRcV3k2JghnN8ozCW5PszfAMsZVlPGIwBoq9EplKYK3z6KJhgZW5E
         TutbXsR80MKPBDDnOV7d99LjdmLmFxxMEYswk5mSR01NR41nSX/LxR9+vN18WujpRAq6
         Z/reTlyxRAT5QBhiBiqJ3NIfPEHq8FWMPAzD7/dGUIXmdma+dhztT5MaZ/eTFGzMXlZW
         XifDZOe/1AhlMBnL7Px66fNzU2bzXi6hVrRhVXfjBp7PUdGvzP8OzdD+R0BM/JZCSjiE
         5MS8wyirkIgzOoO5RRzxNzX6I4N3Ke8Bpc/iVX7AnDxgZCzf2q56hC90bgrPobVpht5u
         0NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oIvBkJiBzrKQDAhe5MG5Na1EGx/NKSJvjkVLzH64xck=;
        b=X7OTE46X9tlKuONvig1gIJ9HSiGpFshmMy9V54Fci6a31riHXnTS4ET89Eyb3Cdex0
         l5KFV6j3+G/c15zr3dI/l2pRseIPne4P6wIQMVtXtRkTKBjtJ+mErpnvaoS5PtvQQ6mr
         /ncXtSQrT1rk4TqVXGPEhanyhqA3iEWW1cJcTfcx4ON9w7eEdLLqbf4rFOk6R+eQLImo
         vlrzRJOzrlUWw52a53jvqENvRsZ3e4FT2QfL3ps9nloxQCMV9DKlZ+03TbLAlWhx377q
         +JOimHU5yQ6gBrWuR0tdCESMdLDujuXSlXpMTJ/8P+lf86ajCM9evaNR9SXq/NPWhoQj
         mTVA==
X-Gm-Message-State: AHQUAuZWJZUT4Ewcb1gv22uW+RX9de4uKMEmbThC3u51bxoWxZibtI+M
        i8ERAkkfc0r/p5+C4vsHKUQfNQ==
X-Google-Smtp-Source: AHgI3IZ/uCW3mNhako84kehtwhPgCkYihNzS7ZJKKui55XqZoWppWVg2Yh3B+vXCvP7UQxuNN1Di9Q==
X-Received: by 2002:aa7:83c5:: with SMTP id j5mr4811791pfn.21.1549483504658;
        Wed, 06 Feb 2019 12:05:04 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o189sm10797919pfg.117.2019.02.06.12.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 12:05:03 -0800 (PST)
Subject: Re: [PATCH 04/18] iomap: wire up the iopoll method
To:     Bart Van Assche <bvanassche@acm.org>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com
References: <20190201152414.23296-1-axboe@kernel.dk>
 <20190201152414.23296-5-axboe@kernel.dk> <1549040392.164323.2.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <985ef5b8-1078-beb3-69a3-a3a4164d5541@kernel.dk>
Date:   Wed, 6 Feb 2019 13:05:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549040392.164323.2.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/19 9:59 AM, Bart Van Assche wrote:
> On Fri, 2019-02-01 at 08:24 -0700, Jens Axboe wrote:
>> +int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
>> +{
>> +	struct request_queue *q = READ_ONCE(kiocb->private);
>> +
>> +	if (!q)
>> +		return 0;
>> +	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), spin);
>> +}
>> +EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
> 
> How does this interact with block device removal? My understanding is that this
> function can get called after a request has completed. Which mechanism, if any,
> prevents that request queue 'q' is removed after kiocb->private has been read
> and before blk_poll() is called?

The completion event is split from the reap, the latter being the one that
would put the file. So we're never going to call into ->iopoll() for a
kiocb where we've done the file put.

-- 
Jens Axboe

