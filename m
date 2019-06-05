Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2693BC282DE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 05:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F6B2083E
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 05:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfFEFp0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 01:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:55270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfFEFp0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 01:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFDEBAE16;
        Wed,  5 Jun 2019 05:45:24 +0000 (UTC)
Subject: Re: [PATCH 17/18] bcache: make bset_search_tree() be more
 understandable
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20190604151624.105150-1-colyli@suse.de>
 <20190604155330.107927-1-colyli@suse.de>
 <20190604155330.107927-2-colyli@suse.de>
 <20190605054335.GA7849@infradead.org>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <9567486c-cef4-5b28-b12e-4b23760bd933@suse.de>
Date:   Wed, 5 Jun 2019 13:45:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605054335.GA7849@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/6/5 1:43 下午, Christoph Hellwig wrote:
>> -			n = j * 2 + (((unsigned int)
>> -				      (f->mantissa -
>> -				       bfloat_mantissa(search, f))) >> 31);
>> +			n = (f->mantissa >= bfloat_mantissa(search, f))
>> +				? j * 2
>> +				: j * 2 + 1;
> 
> If you really want to make it more readable a good old if else would
> help a lot.
> 
>>  		else
>>  			n = (bkey_cmp(tree_to_bkey(t, j), search) > 0)
>>  				? j * 2
> 
> Same here.
> 

Hi Christoph,

Thanks for the hint, will handle it soon.

-- 

Coly Li
