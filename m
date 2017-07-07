Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44709 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750848AbdGGTZD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Jul 2017 15:25:03 -0400
Subject: Re: [PATCH 0/2] LightNVM: Fixes for 4.13
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>, <mb@lightnvm.io>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1499454533-14907-1-git-send-email-javier@cnexlabs.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <67c8b9e0-3bb3-08d9-4526-a5fb21b5960c@fb.com>
Date: Fri, 7 Jul 2017 13:24:45 -0600
MIME-Version: 1.0
In-Reply-To: <1499454533-14907-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/07/2017 01:08 PM, Javier González wrote:
> Hi Jens,
> 
> I have 2 extra fixes for this window. One is for controlling write I/Os
> when removing a pblk partition, otherwise, some controllers can be
> overflowed. We do the same on the fast write path.
> 
> This should be the last fixes coming from our side.

Added for 4.13, thanks.

-- 
Jens Axboe
