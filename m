Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A7C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 23:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8592720869
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 23:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gtu2+Xoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeLSX17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:27:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35727 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLSX17 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 18:27:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so10187263plo.2
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 15:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9E9wDu2P4z5rNgYZzbEjQdVXi3DQlcFCAkeT2cp/D24=;
        b=gtu2+XohT4x4/+eMgURBLmj2sqloiOFn0qP1dQGtvA2m0PtHsUJ/y2+y9QhLkFH8DI
         fDnU372yWbUTehQsdJ4fnGOH0UyjLj7724C3T30psoYnm1UZo/l/RM7B02NH+UZPY3qH
         ZnvAFOfY3bqpNuQqiSfTdWWdYA7EFSWCPlHrsp2lWithuNGnGJtSTxIdqYhZp3qUVgYp
         kcKstSJJU9wGoB3L561/tkmPbuZ2yjHFdyZTgRJF0nWgu4IwSrC1K1rqFzrDDLueQJ9o
         XcOb1OmQ1oFry1QnsehBjfEUmVG9+Q++wMNb5ngMZJryjn+N2wXRzlAWTJ81JQJyOKcV
         fMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9E9wDu2P4z5rNgYZzbEjQdVXi3DQlcFCAkeT2cp/D24=;
        b=JRyBOBKOBpFP+Jbw+LEXl2NvX1F8TiQ+Cqb6rTvSnfC55JialLzqcZZxUJPiEcid2W
         uBZadUR9vE2LTFIzTxvWp1/3eXSg5nPilhSgsJEoP44LKKs5eSAAGKGkOn9WMNGTmU74
         rbCKfPkwlHIV4CwUn+4Udhg36GnIOvvMQI7oZ7w2vMOuHfkD6l0w8h00YhqX7Z2CWYRN
         isD1KoAQ6aSuICI7almoqYgWDUPtaeuxzKMuD1VgaSXgpLSzAIfVdbvHgFfIfJNTrXnj
         mteXlR+96yadQoEqH/H0KkdUxpxDRfCA6B4JGsNK+V8ueFK3qzmdYc4G44frdyZ06HFM
         2Vvw==
X-Gm-Message-State: AA+aEWYNzII8Fww30zp+h7KxH4mA/MDyPMcM9Fk8VROmfpVJSQZXsrVe
        PQm0nJ9PNYfBL0FOnHptCW0Hl0e4gmA=
X-Google-Smtp-Source: AFSGD/X3u2AHGWge51TtXjDH+0ZzOIRlXXc3JCUC/OIHgKjxx9Prt9NMtilm+ago1xw+BucAMEeAmg==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr22121784plj.116.1545262078295;
        Wed, 19 Dec 2018 15:27:58 -0800 (PST)
Received: from [172.20.10.3] (mobile-166-170-49-237.mycingular.net. [166.170.49.237])
        by smtp.gmail.com with ESMTPSA id b26sm41625306pfe.91.2018.12.19.15.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:27:57 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
Date:   Wed, 19 Dec 2018 16:27:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545261885.185366.488.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/18 4:24 PM, Bart Van Assche wrote:
> Hello,
> 
> If I run the srp blktests in a loop then I see the below call stack appearing
> sporadically. I have not yet had the time to analyze this but I'm reporting
> this here in case someone else would already have had a look at this.
> 
> Bart.
> 
> ==================================================================
> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
> Read of size 8 at addr ffff88803b335240 by task fio/21412
> 
> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>  dump_stack+0x86/0xca
>  print_address_description+0x71/0x239
>  kasan_report.cold.5+0x242/0x301
>  __asan_load8+0x54/0x90
>  bt_iter+0x86/0xf0
>  blk_mq_queue_tag_busy_iter+0x373/0x5e0
>  blk_mq_in_flight+0x96/0xb0
>  part_in_flight+0x40/0x140
>  part_round_stats+0x18e/0x370
>  blk_account_io_start+0x3d7/0x670
>  blk_mq_bio_to_request+0x19c/0x3a0
>  blk_mq_make_request+0x7a9/0xcb0
>  generic_make_request+0x41d/0x960
>  submit_bio+0x9b/0x250
>  do_blockdev_direct_IO+0x435c/0x4c70
>  __blockdev_direct_IO+0x79/0x88
>  ext4_direct_IO+0x46c/0xc00
>  generic_file_direct_write+0x119/0x210
>  __generic_file_write_iter+0x11c/0x280
>  ext4_file_write_iter+0x1b8/0x6f0
>  aio_write+0x204/0x310
>  io_submit_one+0x9d3/0xe80
>  __x64_sys_io_submit+0x115/0x340
>  do_syscall_64+0x71/0x210
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f02cf043219

I've seen this one before as well, it's not a new thing. As far as I can
tell, it's a false positive. There should be no possibility for a
use-after-free iterating the static tags/requests.

-- 
Jens Axboe

