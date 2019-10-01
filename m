Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7FDC32792
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 00:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66742086A
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 00:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbfJAAC7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:02:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732622AbfJAAC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 20:02:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id DD23F28A824
Subject: Re: [PATCH 1/1] blk-mq: fill header with kernel-doc
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com
References: <20190930194846.23141-1-andrealmeid@collabora.com>
 <845be3ae-f7f4-4e80-ee26-30a03a8af8b4@acm.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <349b7e6a-fcf3-e1f3-2674-50f316bda9bf@collabora.com>
Date:   Mon, 30 Sep 2019 21:01:42 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <845be3ae-f7f4-4e80-ee26-30a03a8af8b4@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/19 7:01 PM, Bart Van Assche wrote:
> On 9/30/19 12:48 PM, André Almeida wrote:
>> Insert documentation for structs, enums and functions at header file.
>> Format existing and new comments at struct blk_mq_ops as
>> kernel-doc comments.
> 
> Hi André,
> 
> Seeing the documentation being improved is great. However, this patch
> conflicts with a patch series in my tree and that I plan to post soon.
> So I would appreciate it if this patch would be withheld until after my
> patch series has been accepted.
>

Sure, no problem. If it helps the workflow, I could rebase my patch at
the top of your tree.


> Thanks,
> 
> Bart.
> 

