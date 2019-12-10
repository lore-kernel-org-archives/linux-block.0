Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B8C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 05:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C612077B
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 05:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfLJFgZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:36:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:49026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfLJFgZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 00:36:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24A7DAC5F;
        Tue, 10 Dec 2019 05:36:23 +0000 (UTC)
Subject: Re: [PATCH] xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20191209201444.33243-1-natechancellor@gmail.com>
 <CAKwvOdmrGGn6f+XBOO3GCm-jVftLsFTUXdbhS9_iJVY03XqCjA@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <fa48a214-7c12-9123-88d0-00e99359f335@suse.com>
Date:   Tue, 10 Dec 2019 06:36:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmrGGn6f+XBOO3GCm-jVftLsFTUXdbhS9_iJVY03XqCjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.12.19 22:07, Nick Desaulniers wrote:
> On Mon, Dec 9, 2019 at 12:14 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>>
>> Clang warns:
>>
>> ../drivers/block/xen-blkfront.c:1117:4: warning: misleading indentation;
>> statement is not part of the previous 'if' [-Wmisleading-indentation]
>>                  nr_parts = PARTS_PER_DISK;
>>                  ^
>> ../drivers/block/xen-blkfront.c:1115:3: note: previous statement is here
>>                  if (err)
>>                  ^
>>
>> This is because there is a space at the beginning of this line; remove
>> it so that the indentation is consistent according to the Linux kernel
>> coding style and clang no longer warns.
>>
>> While we are here, the previous line has some trailing whitespace; clean
>> that up as well.
>>
>> Fixes: c80a420995e7 ("xen-blkfront: handle Xen major numbers other than XENVBD")
>> Link: https://github.com/ClangBuiltLinux/linux/issues/791
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> ---
>>   drivers/block/xen-blkfront.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index a74d03913822..c02be06c5299 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -1113,8 +1113,8 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
> 
> While you're here, would you please also removing the single space
> before the labels in this function?

AFAIK those are intended to be there.

Having labels indented by a space makes diff not believe those are
function declarations. So a patching a function with a label won't show
the label, but the function in the diff block header.


Juergen
