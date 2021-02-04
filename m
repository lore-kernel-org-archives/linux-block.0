Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D55FC433E9
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C9864D9F
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhBDPCo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbhBDPAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 10:00:32 -0500
Received: from cc-smtpout3.netcologne.de (cc-smtpout3.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEAAC06178A;
        Thu,  4 Feb 2021 06:59:51 -0800 (PST)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout3.netcologne.de (Postfix) with ESMTP id 113E31297E;
        Thu,  4 Feb 2021 15:59:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by cc-smtpin2.netcologne.de (Postfix) with ESMTP id 0C72811D8D;
        Thu,  4 Feb 2021 15:59:49 +0100 (CET)
Received: from [87.79.223.205] (helo=cc-smtpin2.netcologne.de)
        by localhost with ESMTP (eXpurgate 4.19.0)
        (envelope-from <kurt@garloff.de>)
        id 601c0be4-0254-7f0000012729-7f0000018ffc-1
        for <multiple-recipients>; Thu, 04 Feb 2021 15:59:48 +0100
Received: from nas2.garloff.de (xdsl-87-79-223-205.nc.de [87.79.223.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA;
        Thu,  4 Feb 2021 15:59:44 +0100 (CET)
Received: from [192.168.155.24] (ap4.garloff.de [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id 81696B3B13A5;
        Thu,  4 Feb 2021 15:59:43 +0100 (CET)
Subject: Re: [GIT PULL] Floppy patch for 5.12
To:     Jens Axboe <axboe@kernel.dk>, efremov@linux.com
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>
References: <45f555f4-b694-ca8e-c088-f34dea9fc7c7@linux.com>
 <ba300e13-dc16-af15-a386-0c5348e0f919@kernel.dk>
From:   Kurt Garloff <kurt@garloff.de>
Message-ID: <925c6067-f317-70d1-231d-9d97c517212b@garloff.de>
Date:   Thu, 4 Feb 2021 15:59:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ba300e13-dc16-af15-a386-0c5348e0f919@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Am 04.02.21 um 15:37 schrieb Jens Axboe:
> On 2/4/21 3:12 AM, Denis Efremov wrote:
>> The following changes since commit 0d7389718c32ad6bb8bee7895c91e2418b6b26aa:
>>
>>   Merge tag 'nvme-5.21-2020-02-02' of git://git.infradead.org/nvme into for-5.12/drivers (2021-02-02 07:11:47 -0700)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.12
> Pulled, thanks.

Great, thanks!

Next is -stable then ... so all those cloud images using floppy to inject metadata
work again, despite current libblkid.
(Fortunately, most use cdrom these days.)

Best,

-- 
Kurt Garloff <kurt@garloff.de>, Cologne, Germany

