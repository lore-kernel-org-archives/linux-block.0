Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:32973 "EHLO
	mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbcFOSUE (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 14:20:04 -0400
Received: by mail-qk0-f193.google.com with SMTP id a186so4323834qkf.0
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2016 11:20:03 -0700 (PDT)
Date: Wed, 15 Jun 2016 14:19:52 -0400
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] block/blk-cgroup.c: Declare local symbols static
Message-ID: <20160615181515.GI24102@mtj.duckdns.org>
References: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
 <298984df-eb0b-4643-5f2b-b19f8bd9c3d9@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <298984df-eb0b-4643-5f2b-b19f8bd9c3d9@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 14, 2016 at 05:04:32PM +0200, Bart Van Assche wrote:
> Detected by sparse.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
