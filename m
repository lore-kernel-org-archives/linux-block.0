Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ABFC432BE
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEA660F42
	for <linux-block@archiver.kernel.org>; Tue, 31 Aug 2021 10:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbhHaKby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:31:54 -0400
Received: from corp-mailer.zoner.com ([217.198.120.77]:51266 "EHLO
        corp-mailer.zoner.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbhHaKbx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 06:31:53 -0400
Received: from [10.1.0.142] (gw-sady.zoner.com [217.198.112.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by corp-mailer.zoner.com (Postfix) with ESMTPSA id B9DE51F250;
        Tue, 31 Aug 2021 12:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoner.cz;
        s=zcdkim1-3eaw99fduzu913p; t=1630405857;
        bh=tdN/zdCUbe1h5/EDse4Ig7JM6uMEQWL0w1tNZdDVeE0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cbQHAhfBxok1NPjFGyCBEURkE5pFwi3gXgRzJJDW5yIOYoohPE/lYAfm0pW1IQccx
         Wp8HW+/x20GnS/eDXVYPKMWeWay2n8S/UvvM1d5ftuyHCdQ75F37Q11Ec82oYwr9ua
         EXLINzBHGRtCm/ue7uKMC9CrZ3Efl55h5XA2DSb2afHrHnhpBXCs626oPMx3a6v7sH
         DOupQWkEqBzuQCg6g//sZYv4PMA4SAGLzZIEknds9IQ89QCyMvubs7d95BgwxDYi9Z
         bfd9IODiv6WE/0UNMngURspFthO7smwUp1IK5ca6qBBPpyMYrdXQQ9ce0lvYxz69Mq
         DxH/eWVW3jlIA==
Subject: Re: NULL pointer dereference in blk_mq_put_rq_ref (LTS kernel
 5.10.56)
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <1706c570-6c07-4eb7-219f-de3366e54077@zoner.cz>
 <YS33g6bLXCeB7Pue@T590>
From:   Martin Svec <martin.svec@zoner.cz>
Message-ID: <996b8008-f7ec-4752-e207-669fe88021df@zoner.cz>
Date:   Tue, 31 Aug 2021 12:30:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS33g6bLXCeB7Pue@T590>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Content-Language: cs
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming,

thanks a lot. I don't see the patches in 5.10 stable queue yet, is it safe to apply them on top of
5.10.60 LTS kernel?

Dne 31.08.2021 v 11:33 Ming Lei napsal(a):
> On Mon, Aug 30, 2021 at 04:52:54PM +0200, Martin Svec wrote:
>> Hi all,
>>
>> after upgrade from 5.4.x to 5.10.56 one of our LIO iSCSI Target servers hung
>> with kernel NULL pointer dereference bug, see below. According to the call trace
>> I guess that the bug is related to the generic blk-mq subsystem. I don't see any
>> fixes related to blk-mq between 5.10.56 and 5.10.60, so this bug probably occurs
>> in latest 5.10 stable releases too. I this a known issue or do you have any ideas
>> what's wrong?
> The issue should have been fixed by the following two patches:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9ed27a764156929efe714033edb3e9023c5f321
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c2da19ed50554ce52ecbad3655c98371fe58599f
>
>
> Thanks,
> Ming
>
Martin

