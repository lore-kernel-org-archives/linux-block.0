Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40192 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752772AbcIWRba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2016 13:31:30 -0400
Subject: Re: [PATCH] blkcg: Annotate blkg_hint correctly
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <a22244c9-c8fa-2538-688e-58b7284dc387@sandisk.com>
CC: Tejun Heo <tj@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <075e7b63-6e81-84aa-5ce2-c6037f39297e@fb.com>
Date: Fri, 23 Sep 2016 11:31:03 -0600
MIME-Version: 1.0
In-Reply-To: <a22244c9-c8fa-2538-688e-58b7284dc387@sandisk.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/23/2016 10:07 AM, Bart Van Assche wrote:
> Avoid that sparse complains about blkg_hint manipulations.
>
> Fixes: a637120e4902 ("blkcg: use radix tree to index blkgs from blkcg")
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>

Applied for 4.9, thanks.

-- 
Jens Axboe

