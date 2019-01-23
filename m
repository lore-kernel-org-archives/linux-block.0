Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D49C282C3
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 01:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9873D21726
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 01:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAWBj1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:39:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:40532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfAWBj0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 20:39:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D9E2ABCB;
        Wed, 23 Jan 2019 01:39:25 +0000 (UTC)
Subject: Re: [PATCH] bcache: never writeback a discard operation
To:     Daniel Axtens <dja@axtens.net>, Sasha Levin <sashal@kernel.org>
Cc:     "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <koverstreet@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-bcache@vger.kernel.org
References: <20190118051825.18196-1-dja@axtens.net>
 <20190122155556.478CB217D6@mail.kernel.org>
 <87womwp71z.fsf@linkitivity.dja.id.au>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <b6f67dae-1de4-256b-1498-d377961fe27e@suse.de>
Date:   Wed, 23 Jan 2019 09:39:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87womwp71z.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2019/1/23 上午8:10, Daniel Axtens 写道:
> Hi Sasha,
> 
>> This commit has been processed because it contains a "Fixes:" tag,
>> fixing commit: 72c270612bd3 bcache: Write out full stripes.
> 
> I added that fixes tag because that was the commit that added the
> code. However, I noticed that one of the bug reports mentions that the
> problem only arising after v4.8. [1] I don't quite know what to make of
> this: perhaps it is a consequence of another change enabling the broken
> path. Maybe someone on one of the lists will have an idea.
> 

From code logic, bcache should not have a discard bio in cache device,
otherwise it is a bug. Therefore no matter whether the issue happens
before v4.8 kernel, I'd like to have the fix in.

>> v4.4.171: Build failed! Errors:
>>     drivers/md/bcache/writeback.h:71:6: error: implicit declaration of function ‘bio_op’; did you mean ‘bio_rw’? [-Werror=implicit-function-declaration]
>>     drivers/md/bcache/writeback.h:71:21: error: ‘REQ_OP_DISCARD’ undeclared (first use in this function); did you mean ‘REQ_DISCARD’?
>>
>> v3.18.132: Build failed! Errors:
>>     drivers/md/bcache/writeback.h:71:6: error: implicit declaration of function ‘bio_op’; did you mean ‘bio_rw’? [-Werror=implicit-function-declaration]
>>     drivers/md/bcache/writeback.h:71:21: error: ‘REQ_OP_DISCARD’ undeclared (first use in this function); did you mean ‘REQ_DISCARD’?
>>
>>
>> How should we proceed with this patch?
> 
> The patch seems reasonably easy to backport. Compile-tested only, and
> only against v4.4.171.

I don't have idea whether stable kernels accept rebased patches, for
SUSE kernel I will do back port for all necessary kernel versions.

-- 

Coly Li
