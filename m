Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103FFC10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 06:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D378C2077C
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 06:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfDYGBX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:01:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfDYGBX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 02:01:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F01C6AF95;
        Thu, 25 Apr 2019 06:01:21 +0000 (UTC)
Subject: Re: [PATCH 09/18] bcache: add failure check to run_cache_set() for
 journal replay
To:     Coly Li <colyli@suse.de>, axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20190424164843.29535-1-colyli@suse.de>
 <20190424164843.29535-10-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e9d5c5db-d8fd-a55a-5ac5-06131acda02c@suse.de>
Date:   Thu, 25 Apr 2019 08:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424164843.29535-10-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/19 6:48 PM, Coly Li wrote:
> Currently run_cache_set() has no return value, if there is failure in
> bch_journal_replay(), the caller of run_cache_set() has no idea about
> such failure and just continue to execute following code after
> run_cache_set().  The internal failure is triggered inside
> bch_journal_replay() and being handled in async way. This behavior is
> inefficient, while failure handling inside bch_journal_replay(), cache
> register code is still running to start the cache set. Registering and
> unregistering code running as same time may introduce some rare race
> condition, and make the code to be more hard to be understood.
> 
> This patch adds return value to run_cache_set(), and returns -EIO if
> bch_journal_rreplay() fails. Then caller of run_cache_set() may detect
> such failure and stop registering code flow immedidately inside
> register_cache_set().
> 
> If journal replay fails, run_cache_set() can report error immediately
> to register_cache_set(). This patch makes the failure handling for
> bch_journal_replay() be in synchronized way, easier to understand and
> debug, and avoid poetential race condition for register-and-unregister
> in same time.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/super.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
