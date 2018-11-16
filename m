Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF524C04EBC
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 16:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F37208A3
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 16:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5d+qTSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F37208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbeKQCUE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbeKQCUE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 21:20:04 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A329B2089D;
        Fri, 16 Nov 2018 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542384426;
        bh=t5Sx3xpwjY54nx3NJEvRFhDrb3U71wJALKfehMUdVvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5d+qTSyS6VLHu0NbnMXWYAG+g8v+w0Xc9NsxCU/qXGLV53l75dk25fn8PsXS9OSB
         a5EREF83Ql1QD1zqLnnfV3i2JTeOokAGiDjJo52XGhy0FQLprj0EtEybOtb1me64P/
         VCCiAAT5JAYHDAwPKlzlkGiUR8PHQUivSGQfCr00=
Date:   Fri, 16 Nov 2018 11:07:05 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: not embed .mq_kobj and ctx->kobj into queue
 instance
Message-ID: <20181116160705.GE1706@sasha-vm>
References: <20181116032826.11901-1-ming.lei@redhat.com>
 <20181116032826.11901-2-ming.lei@redhat.com>
 <20181116065205.GD1706@sasha-vm>
 <20181116074905.GB5520@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181116074905.GB5520@ming.t460p>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 03:49:06PM +0800, Ming Lei wrote:
>On Fri, Nov 16, 2018 at 01:52:05AM -0500, Sasha Levin wrote:
>> On Fri, Nov 16, 2018 at 11:28:25AM +0800, Ming Lei wrote:
>> > Even though .mq_kobj, ctx->kobj and q->kobj share same lifetime
>> > from block layer's view, actually they don't because userspace may
>> > grab one kobject anytime via sysfs, so each kobject's lifetime has
>> > to be independent, then the objects(mq_kobj, ctx) which hosts its
>> > own kobject have to be allocated dynamically.
>> >
>> > This patch fixes kernel panic issue during booting when DEBUG_KOBJECT_RELEASE
>> > is enabled.
>> >
>> > Reported-by: Guenter Roeck <linux@roeck-us.net>
>> > Cc: Guenter Roeck <linux@roeck-us.net>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>
>> What does this patch depend on? It doesn't apply to Linus's tree nor to
>> the block tree.
>>
>> Also, could you please cc lkml with patches?
>
>It depends on for-4.21/block.

And in particular on commit 392546aed22 ("blk-mq: separate number of
hardware queues from nr_cpu_ids") which isn't tagged for stable nor
looks like stable material, so this proposed patch doesn't backport
cleanly to any of the stable trees.

--
Thanks,
Sasha
