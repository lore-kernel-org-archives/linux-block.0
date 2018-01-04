Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f50.google.com ([209.85.160.50]:44278 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeADRqE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jan 2018 12:46:04 -0500
Received: by mail-pl0-f50.google.com with SMTP id n13so1421519plp.11
        for <linux-block@vger.kernel.org>; Thu, 04 Jan 2018 09:46:04 -0800 (PST)
Subject: Re: [PATCH v1 00/10] cache device failure handling improvement
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, tang.junhui@zte.com.cn
References: <20180103140325.63175-1-colyli@suse.de>
 <e53e363e-740d-5974-d989-6bf2c3a37dac@lyle.org>
 <d0c930bf-ea36-9fe5-3cce-b8f56e1b163e@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <59499361-3823-1cfb-1306-c0ef16125e8d@lyle.org>
Date: Thu, 4 Jan 2018 09:46:00 -0800
MIME-Version: 1.0
In-Reply-To: <d0c930bf-ea36-9fe5-3cce-b8f56e1b163e@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Coly--

On 01/03/2018 06:20 PM, Coly Li wrote:
> Thanks for doing this. When you test the patch set, please apply them
> together, because the bugs that the first 8 patches try to fix won't be
> triggered without applying the last 2 patches, especially the io_disable
> patch.

Eventually I will test & review the whole set, but I need to concentrate
on testing something for a first submission to 4.16.  So I've taken
1,2,3 and 8 because they're easiest and have some benefit on their own
without 9 & 10.

This means that next pass through the review we'll at least have a few
fewer patches to look at, too.

Thanks,

Mike
