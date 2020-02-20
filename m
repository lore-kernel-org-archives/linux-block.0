Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DB1C11D04
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 13:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C5E206E2
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 13:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgBTNV6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:21:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:42016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbgBTNV6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 08:21:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 44950ACA1;
        Thu, 20 Feb 2020 13:21:57 +0000 (UTC)
Subject: Re: [PATCH 2/3] bcache: make bch_btree_check() to be multiple threads
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200215082858.128025-1-colyli@suse.de>
 <20200215082858.128025-3-colyli@suse.de>
 <20200219163015.GE10644@infradead.org>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <6f0d6571-bd01-528b-649c-1365ad2a4910@suse.de>
Date:   Thu, 20 Feb 2020 21:21:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219163015.GE10644@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/2/20 12:30 上午, Christoph Hellwig wrote:
> maybe s/be multiple threads/multithreaded/ in the subject?
> 

Sure, I will do it in next version.

Thanks.

-- 

Coly Li
