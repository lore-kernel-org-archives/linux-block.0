Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3239C4CEC7
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 22:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA1E206A5
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 22:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfILWI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:08:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48536 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILWI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 18:08:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id EF5B228A2EC
Subject: Re: [PATCH 3/3] null_blk: validated the number of devices
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, axboe@kernel.dk, m@bjorling.me,
        kernel@collabora.com, krisman@collabora.com
References: <20190911144636.226945-1-andrealmeid@collabora.com>
 <20190911144636.226945-3-andrealmeid@collabora.com>
 <20190912161937.GK29434@bombadil.infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <dbdb0415-8762-f9c1-a65a-3531d9cca109@collabora.com>
Date:   Thu, 12 Sep 2019 19:07:47 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190912161937.GK29434@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Matthew,

On 9/12/19 1:19 PM, Matthew Wilcox wrote:
> On Wed, Sep 11, 2019 at 11:46:36AM -0300, André Almeida wrote:
>>  
>> -static int nr_devices = 1;
>> +static unsigned int nr_devices = 1;
>>  module_param(nr_devices, int, 0444);
> 
> ^^^ you forgot to change the module_param to match
> 
>> +	if (!nr_devices) {
>> +		pr_err("null_blk: invalid number of devices\n");
>> +		return -EINVAL;
>> +	}
> 
> I don't think this is necessary.
> 

Could you explain why you don't think is necessary? As I see, the module
can't be used without any /dev/nullb* device, so why we should load it?

Thanks,
	André
