Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f50.google.com ([209.85.160.50]:36839 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeACROW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jan 2018 12:14:22 -0500
Received: by mail-pl0-f50.google.com with SMTP id b12so1614506plm.3
        for <linux-block@vger.kernel.org>; Wed, 03 Jan 2018 09:14:22 -0800 (PST)
Subject: Re: [PATCH v1 08/10] bcache: fix misleading error message in
 bch_count_io_errors()
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, tang.junhui@zte.com.cn
References: <20180103140325.63175-1-colyli@suse.de>
 <20180103140325.63175-9-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <5facb1d8-1b98-8c5d-99ff-1c5d78c665c8@lyle.org>
Date: Wed, 3 Jan 2018 09:14:20 -0800
MIME-Version: 1.0
In-Reply-To: <20180103140325.63175-9-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/03/2018 06:03 AM, Coly Li wrote:
> Bcache only does recoverable I/O for read operations by calling
> cached_dev_read_error(). For write opertions there is no I/O recovery for
> failed requests.
> 
> But in bch_count_io_errors() no matter read or write I/Os, before errors
> counter reaches io error limit, pr_err() always prints "IO error on %,
> recoverying". For write requests this information is misleading, because
> there is no I/O recovery at all.
> 
> This patch adds a parameter 'is_read' to bch_count_io_errors(), and only
> prints "recovering" by pr_err() when the bio direction is READ.
> 
> Signed-off-by: Coly Li <colyli@suse.de>

Reviewed-by: Michael Lyle <mlyle@lyle.org>
