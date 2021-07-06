Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F98BC07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B20C61289
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 14:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhGFOjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 10:39:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:4174 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhGFOjJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 10:39:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209080847"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="209080847"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 07:36:00 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="486287843"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.212.176.37]) ([10.212.176.37])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 07:36:00 -0700
Subject: Re: [PATCH] loop: reintroduce global lock for safe
 loop_validate_file() traversal
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <258f1892-bbbe-67e2-ead9-3287a3d7578b@i-love.sakura.ne.jp>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <fdd3e7bb-4ab6-2a37-a03a-56e088b32db3@linux.intel.com>
Date:   Tue, 6 Jul 2021 07:35:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <258f1892-bbbe-67e2-ead9-3287a3d7578b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/3/2021 10:42 PM, Tetsuo Handa wrote:
> 
> It is not clear why the size of old and new image files need to be the same.

filesystems have a heck of a time dealing with suddenly a smaller disk ;)

note that the commit in question predates the ability for filesystems to grow into larger spaces
or most of hotplug.

so it's quite possible that today we can allow switching to a larger file just fine
