Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B929C5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 03:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjAJDAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 22:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjAJDAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 22:00:05 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C842AF2
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 19:00:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so14957816pjq.1
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 19:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgFwkjg9EBzecfFxGPdwkYKkntqQk2e+FXvOTX8xDf0=;
        b=aDe57hXA3ujYg3k1XCzNzM///hY/u1/fS4Yt+yZYDzw7ViOkOyZXb8Y6QhduXw4x2X
         94Gks0g+c/+muSUA/CSOR65XISGnOqri/lhELET3WMkxersYdRdjl9jAOx5yIE+Fv9o1
         AxX9zYPiNi2/cmeQJAJRteqNuaZuSIoTHcruVbcfOWxVRoVplx8e2gR9tn/3wMmsoNn+
         4i16Ca12gOPfG4SUxZ4VMeKZNdZVcSOUWz3bJ4X+AwEj9VhIix+AWal50gbNIOTLJkYM
         lsZ92wkcK4tnUqXiYzE4XtPnOTmPYpgNKMQEtSmgWpzwdaO5zK+odEygRElqXE216xzO
         aAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgFwkjg9EBzecfFxGPdwkYKkntqQk2e+FXvOTX8xDf0=;
        b=ROa2GMNeVbYhBlleMIfBzPujuAeuY9QN0582qgur2G6XZxFcTTS9YpHbCG1vq/tPX/
         9cPfHaoQ3FToT1dqqLF9UspBdxYw+thIIYbg4LwmpydvsWtrUZDbERiGcqBwTeuxbpY9
         X+adb0vKNi0mIPPrlWaMOEpHBlGSCVVfF0EjHYAZB1qOBwStwmDNV2MP/VQ2GJUL3B1C
         zxyXRl95NDNaPhOPqO2ALoBSl29Iu2FIb1Z+ciVb/fgJaDT6FS4TEmdxon28mBT7+A0R
         UEapK0IkbmBn0piuu7xbTDfYsi/KvlJg/lsY/EI/ns/IFZ/8T9kWh0ICOuGb2py9kLzW
         RY3A==
X-Gm-Message-State: AFqh2koH18D88oLScnWUu5BFoKEXtWWy3zYTfAGjSyO3HbU+bX4sxFFm
        Bk9PqOz+QGN4nti61PWwmW7EO3KAYWXcuutd
X-Google-Smtp-Source: AMrXdXvMK+BjUBVFE5vy3zpAavhIoaOfcJu9fXufEE/QfKiVnCi1f92IPt6xqnKJnvU+cMqP4JwSdA==
X-Received: by 2002:a17:902:a589:b0:186:639f:6338 with SMTP id az9-20020a170902a58900b00186639f6338mr15687182plb.6.1673319603738;
        Mon, 09 Jan 2023 19:00:03 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b00192a04bc620sm6757660plc.295.2023.01.09.19.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 19:00:03 -0800 (PST)
Message-ID: <ed255a4a-a0da-a962-2da4-13321d0a75c5@kernel.dk>
Date:   Mon, 9 Jan 2023 20:00:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
 <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
 <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
 <07084f70-00a7-d142-479c-52c75af28246@acm.org>
 <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
 <873cbbef-e01f-3142-af2d-053dc040d17e@opensource.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <873cbbef-e01f-3142-af2d-053dc040d17e@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 7:24?PM, Damien Le Moal wrote:
> On 1/10/23 09:48, Jens Axboe wrote:
>> On 1/9/23 5:44?PM, Bart Van Assche wrote:
>>> On 1/9/23 16:41, Jens Axboe wrote:
>>>> Or, probably better, a stacked scheduler where the bottom one can be zone
>>>> away. Then we can get rid of littering the entire stack and IO schedulers
>>>> with silly blk_queue_pipeline_zoned_writes() or blk_is_zoned_write() etc.
>>>
>>> Hi Jens,
>>>
>>> Isn't one of Damien's viewpoints that an I/O scheduler should not do
>>> the reordering of write requests since reordering of write requests
>>> may involve waiting for write requests, write request that will never
>>> be received if all tags have been allocated?
>>
>> It should be work conservering, it should not wait for anything. If
>> there are holes or gaps, then there's nothing the scheduler can do.
>>
>> My point is that the strict ordering was pretty hacky when it went in,
>> and rather than get better, it's proliferating. That's not a good
>> direction.
> 
> Yes, and hard to maintain/avoid breaking something.

Indeed! It's both fragile and ends up adding branches in a bunch of
spots in the generic code, which isn't ideal either from an efficiency
pov.

> Given that only writes need special handling, I am thinking that having a
> dedicated write queue for submission/scheduling/requeue could
> significantly clean things up. Essentially, we would have a different code
> path for zoned device write from submit_bio(). Something like:
> 
> if (queue_is_zoned() && op_is_write())
> 	return blk_zoned_write_submit();
> 
> at the top of submit_bio(). That zone write code can be isolated in
> block/blk-zoned.c and avoid spreading "if (zoned)" all over the place.
> E.g. the flush machinery reorders writes right now... That needs fixing,
> more "if (zoned)" coming...
> 
> That special zone write queue could also do its own dispatch scheduling,
> so no need to hack existing schedulers.

This seems very reasonable, and would just have the one check at queue
time, and then one at requeue time (which is fine, that's not a fast
path in any case).

-- 
Jens Axboe

