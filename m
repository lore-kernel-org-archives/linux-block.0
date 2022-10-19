Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69DEC433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 14:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJSOnh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 10:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJSOnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 10:43:17 -0400
X-Greylist: delayed 536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 07:29:15 PDT
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5328316EA11
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 07:29:14 -0700 (PDT)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 885CE14A02;
        Wed, 19 Oct 2022 09:17:47 -0500 (CDT)
Message-ID: <306b38d1-3098-91e0-9ddc-f4a8660fa386@sandeen.net>
Date:   Wed, 19 Oct 2022 09:19:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20221019051244.810755-1-yi.zhang@redhat.com>
 <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH blktests] common/xfs: ignore the 32M log size during
 mkfs.xfs
In-Reply-To: <122cec5e-5374-e98f-a8e7-b063d9c413fc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/22 1:16 AM, Chaitanya Kulkarni wrote:
> On 10/18/22 22:12, Yi Zhang wrote:
>> The new minimum size for the xfs log is 64MB which introudced from
>> xfsprogs v5.19.0, let's ignore it, or nvme/013 will be failed at:
>>
> 
> instead of removing it set to 64MB ?

What is the advantage of hard-coding any log size? By doing so you are
overriding mkfs's own best-practice heuristics, and you might run into
other failures in the future.

Is there a reason to not just use the defaults?

Thanks,
-Eric
