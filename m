Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5D6C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8192206D7
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 15:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="a+3ZY8hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEDPCo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 11:02:44 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36138 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728165AbgEDPCn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 11:02:43 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 7D6A02E09E9;
        Mon,  4 May 2020 18:02:35 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id x8Wr5xxAsD-2YXG9Sbt;
        Mon, 04 May 2020 18:02:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588604555; bh=TecYTwqL2Tni8kiHB0VFRMYHoz+jlo49hV2B3B1oH28=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=a+3ZY8hjuuH0jy7QCODn2HSUgXhHYwHG4hqr17w5kaBI8EqlqohmPA4GJdO4d29zZ
         YoetrcGhkOqoWi4wF6aPU3Ji7SVhsDkU3qH8SFLhicKXFB3q46WYlUlOPSAXWCa7qR
         lWRDAO4ZzWhQAqrAmWTJEht2lsU0/6X8RLxcqjzY=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id HG3qcYwhkL-2XXaA9TR;
        Mon, 04 May 2020 18:02:33 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 2/4] block/part_stat: use __this_cpu_add() instead of
 access by smp_processor_id()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
 <158859897252.19836.5614675872684760741.stgit@buzz>
 <20200504140317.GB29020@infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <2dfaeec5-135e-c7ac-714b-ecdf14478568@yandex-team.ru>
Date:   Mon, 4 May 2020 18:02:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504140317.GB29020@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/05/2020 17.03, Christoph Hellwig wrote:
>> +#define __part_stat_add(part, field, addnd)				\
>> +	(part_stat_get(part, field) += (addnd))
> 
> Just open coding part_stat_get for the UP side would seems a little
> easier to read.

If rewrite filed definition as

#ifdef	CONFIG_SMP
	struct disk_stats __percpu *dkstats;
#else
	struct disk_stats __percpu dkstats[1];
#endif

Then all per-cpu macro should work as is for UP case too.
Surprisingly arrow operator (struct->filed) works for arrays too =)


Inlining per-cpu structures should be good for tiny UP systems.
Especially if this could be done by few macro only in three places:
definition, allocating and freeing.


But sparse still complains.

./include/linux/part_stat.h:45:24: warning: incorrect type in initializer (different address spaces)
./include/linux/part_stat.h:45:24:    expected void const [noderef] <asn:3> *__vpp_verify
./include/linux/part_stat.h:45:24:    got struct disk_stats [noderef] *

Looks like it cannot assign different address-space to the filed.


> 
> Otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
