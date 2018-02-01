Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33472 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeBAVwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Feb 2018 16:52:12 -0500
Received: by mail-pg0-f51.google.com with SMTP id u1so13063455pgr.0
        for <linux-block@vger.kernel.org>; Thu, 01 Feb 2018 13:52:11 -0800 (PST)
Subject: Re: [PATCH v4 00/13] bcache: device failure handling improvement
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180128015625.128497-1-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <2fde00b8-f605-d0d0-a51c-c126a2939326@lyle.org>
Date: Thu, 1 Feb 2018 13:52:09 -0800
MIME-Version: 1.0
In-Reply-To: <20180128015625.128497-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/27/2018 05:56 PM, Coly Li wrote:
> Hi maintainers and folks,

Hi Coly---

> This patch set tries to improve bcache device failure handling, includes
> cache device and backing device failures.

I've skimmed this whole patchset and overall it looks good.  I have
taken some pieces (2,6) for possible-4.16.  I understand you'll be
sending out a v5 soon-- I'll perform a more detailed review then.

Thanks,

Mike
