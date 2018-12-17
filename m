Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A7C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 23:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF492145D
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 23:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z7dXy1RJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeLQXts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:49:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36009 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeLQXtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 18:49:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so6878911plo.3
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 15:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G29AwnU8O9WRCMzLEfIqCQTJeIjlSQNE6Hdr5t3M9v4=;
        b=z7dXy1RJJTMURj9DuBdapNJ6irKiSuXyxDGf3Js/Nm0zV95mMLn0YmuQSCaQdxV8x6
         EJvMc5C/IM9na4ldxjWQBXbu/85FlGRuqLcddByDRJC2zuPkdeP8jegejNCMJKVCLmS+
         Ou6E8L1IZxkv5U/baHgLz+IfZibxeHKC5hJjDxgxrYXb/cAgGJIEb14VWXmf30le6hF9
         AzhBh0+twTgf2fZgYUKW9LW884RYlUmPONl8Ht/zkRCOXCxXZRlc3WmcO1ENd9FP1DXe
         CE45fFvChzlX2cxeyS40vcmIO/R/1MKHtBK0FPYWy29XTIkWprvxiPjxJpb8/S6dGsB+
         +Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G29AwnU8O9WRCMzLEfIqCQTJeIjlSQNE6Hdr5t3M9v4=;
        b=MG2z95yLi3nA17UNho/gl475KviBaRp4Tg/XjDQYQTGSvP1purf7H0xdzjSK7Z3U4E
         aWKk5JMcOybAgY8ZxB4fvIJiOtc6csluVIXimiVj86cdAjMCVxat+SwBRu32Wg0TRbFJ
         l4pBWoTC+WHSgj6aD48Ojt2O6Gy/EWC7wM18DgNzUr5boPCRWegJ1zPI3Dr9p4L5uJEk
         3uRkiouKpMgoiYfT8vKhssihG08B+JcdMDBQ8dxlSFNbw+mX25E10zNfpbKK5v+ziGvD
         hHINeBpkIrxk6DcbcZFQgB/RrUbwkbiJfGKgrkf2H44MwxSsV6CgLEpG3bjPI/Af6L7V
         1eRw==
X-Gm-Message-State: AA+aEWYDO4muigeKCv5VrD1ew4OVXGDm/OA0bvS9NywyEdK0oBWEkSXu
        Su8sge+n+cSMQy33x16YTnX6Yw==
X-Google-Smtp-Source: AFSGD/U/1DYmeSYSngGFgXTgs5OZUlPaHLsm1WjkMpndFvt9sdW+FcO/yTncx5nf+ieBwKHTkT/73A==
X-Received: by 2002:a17:902:31a4:: with SMTP id x33mr14162134plb.41.1545090587100;
        Mon, 17 Dec 2018 15:49:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o1sm19781727pgn.63.2018.12.17.15.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 15:49:45 -0800 (PST)
Subject: Re: Upcoming merge window
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6fe5169f-8032-ac2a-ecb7-f845c56b1d73@kernel.dk>
 <1545088576.185366.443.camel@acm.org>
 <8ae21d8c-81a1-891a-66c4-c94ff8bee20b@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Message-ID: <69609425-5f1d-3c4f-3b1c-34f3b156006a@kernel.dk>
Date:   Mon, 17 Dec 2018 16:49:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8ae21d8c-81a1-891a-66c4-c94ff8bee20b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 4:27 PM, Jens Axboe wrote:
> On 12/17/18 4:16 PM, Bart Van Assche wrote:
>> On Mon, 2018-12-17 at 11:28 -0700, Jens Axboe wrote:
>>> As I'm sure you're all aware, the merge window is coming up. This time
>>> it happens to coincide with that is a holiday for most. My plan is to
>>> send in an EARLY pull request to Linus, Thursday at the latest. If you're
>>> sitting on anything that should go in with the initial merge, then I need
>>> to have it ASAP.
>>>
>>> I'll do a later pull about a week in with things that were missed, but
>>> I'm really hoping to make that fixes only. Any driver updates etc should
>>> go in now.
>>
>> Hi Jens,
>>
>> If I run blktests/srp/002 against Linus' master branch then that test passes,
>> no matter how many times I run that test. If I run that test against your
>> for-next branch however (commit 6a252f2772c0) then that test hangs. The output
>> of my list-pending-block-requests script is as follows when the hang occurs:
> 
> Ugh, I'll try and run that here again, that test is unfortunately such a pain
> to run and requires me to manually install multipath libs (and remember to
> uninstall before rebooting, or udev fails?).
> 
> I'll take a look!

Looks like what Ming was talking about. CC'ing Ming and Mike. Lots of
kworkers are stuck like this:

[  252.310187] kworker/2:19    D14072  8147      2 0x80000000
[  252.316803] Workqueue: dio/dm-2 dio_aio_complete_work
[  252.322925] Call Trace:
[  252.326137]  ? __schedule+0x231/0x5f0
[  252.330703]  schedule+0x2a/0x80
[  252.334689]  rwsem_down_write_failed+0x204/0x320
[  252.340330]  ? generic_make_request_checks+0x55/0x370
[  252.346542]  ? call_rwsem_down_write_failed+0x13/0x20
[  252.352669]  call_rwsem_down_write_failed+0x13/0x20
[  252.358601]  down_write+0x1b/0x30
[  252.362781]  __generic_file_fsync+0x3e/0xb0
[  252.367933]  ext4_sync_file+0xcc/0x2e0
[  252.372599]  dio_complete+0x1c4/0x210
[  252.377168]  process_one_work+0x1cb/0x350
[  252.382915]  worker_thread+0x28/0x3c0
[  252.387482]  ? process_one_work+0x350/0x350
[  252.392632]  kthread+0x107/0x120
[  252.396717]  ? kthread_park+0x80/0x80
[  252.401285]  ret_from_fork+0x1f/0x30

Where did this regression come from? This was passing just fine
recently.

-- 
Jens Axboe

