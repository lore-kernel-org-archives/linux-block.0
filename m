Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33871 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753746AbdFPOal (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2017 10:30:41 -0400
Subject: Re: [PATCH 0/2] Two fixes for loop devices
To: NeilBrown <neilb@suse.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <149758925866.10006.12779875832895865043.stgit@noble>
From: Jens Axboe <axboe@fb.com>
Message-ID: <c70dfc69-516c-f1e8-4e39-74eff1bca176@fb.com>
Date: Fri, 16 Jun 2017 08:29:28 -0600
MIME-Version: 1.0
In-Reply-To: <149758925866.10006.12779875832895865043.stgit@noble>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/15/2017 11:02 PM, NeilBrown wrote:
> Hi Jens,
>  one of these is a resend of a patch I sent a while back.
>  The other is new - loop closes files differently from close()
>  and in a way that can confuse NFS.

Are you wanting to get these into 4.12, or defer to 4.13?

-- 
Jens Axboe
